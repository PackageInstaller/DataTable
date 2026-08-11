using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class UIDamageTextSystem : BaseSystem
{
	private class ActiveDamageTextInfo
	{
		public UITextDamage TextDamage;

		public string Key;

		public int SkillId;

		public int Damage;

		public Vector2 UiPosition;
	}

	public class DamageStack : IReference
	{
		private int upStackCount;

		private int surplusUpStackCount;

		private int downStackCount;

		private int surplusDownStackCount;

		public void AddDamage(bool isUp)
		{
			if (isUp)
			{
				upStackCount++;
				surplusUpStackCount++;
			}
			else
			{
				downStackCount++;
				surplusDownStackCount++;
			}
		}

		public void EndDamage(bool isUp)
		{
			if (isUp)
			{
				surplusUpStackCount--;
			}
			else
			{
				surplusUpStackCount--;
			}
			if (surplusUpStackCount <= 0)
			{
				upStackCount = 0;
			}
			if (surplusUpStackCount <= 0)
			{
				downStackCount = 0;
			}
		}

		public int GetStackCount(bool isUp)
		{
			if (!isUp)
			{
				return downStackCount;
			}
			return upStackCount;
		}

		public void Clear()
		{
			upStackCount = 0;
			downStackCount = 0;
			surplusUpStackCount = 0;
			surplusDownStackCount = 0;
		}
	}

	private float mergeDamageTextDistance = 100f;

	private CanvasComponent.CanvasGroup _canvasGroup;

	private Camera _barCamera;

	private Dictionary<string, IObjectPool<GameObject>> _damageTextPool = new Dictionary<string, IObjectPool<GameObject>>();

	private readonly List<ActiveDamageTextInfo> activeDamageTextInfos = new List<ActiveDamageTextInfo>();

	protected override bool IsLogicSystem => false;

	public override void OnInit(object data = null)
	{
		_canvasGroup = GameEntry.Canvas.GetCanvasGroup("DamageText");
	}

	public override void OnAwake(object data = null)
	{
		_barCamera = GetSystem<CameraSystem>().BattleCamera;
		DRConstantConfig dataRow = GameEntry.DataTable.GetDataRow<DRConstantConfig>(1041);
		if (dataRow != null)
		{
			mergeDamageTextDistance = dataRow.Value;
		}
	}

	public override async UniTask<bool> OnEnter(object data = null)
	{
		if (_canvasGroup == null)
		{
			return false;
		}
		DRDamageText[] drDamageTextArray = GameEntry.DataTable.GetAllDataRow<DRDamageText>();
		foreach (DRDamageText drDamageText in drDamageTextArray)
		{
			if (drDamageText != null)
			{
				string damageTextPath = AssetUtility.GetEntityAsset(drDamageText.Path);
				GameObject gameObject = await GetSystem<GameResourceSystem>().LoadAssetAsync<GameObject>(damageTextPath);
				if (!(gameObject == null) && !_damageTextPool.ContainsKey(drDamageText.DamageKey))
				{
					_damageTextPool.Add(drDamageText.DamageKey, new ObjectPool<GameObject>(new EntityInfoItemViewFactory(damageTextPath, gameObject, _canvasGroup.Root), drDamageText.InitCap, Mathf.Max(drDamageText.InitCap * 2, 16)));
				}
			}
		}
		return true;
	}

	private UITextDamage AllocateDamageText(string keyType, Transform root, int textCount)
	{
		_damageTextPool.TryGetValue(keyType, out var value);
		if (value == null)
		{
			return null;
		}
		GameObject gameObject = value.Allocate();
		UITextDamage component = gameObject.GetComponent<UITextDamage>();
		component.Init(_barCamera, _canvasGroup.Canvas);
		if (!string.IsNullOrEmpty(component.SingleTextKey))
		{
			_damageTextPool.TryGetValue(component.SingleTextKey, out var value2);
			if (value2 == null)
			{
				if (gameObject.TryGetComponent<IPooledObject>(out var component2))
				{
					component2.Free();
				}
				return null;
			}
			int num = Mathf.CeilToInt((float)textCount / 3f);
			for (int i = 0; i < num; i++)
			{
				GameObject singleTextObj = value2.Allocate();
				component.AddSingleText(singleTextObj);
			}
		}
		component.BindFollowRoot(root);
		return component;
	}

	public void ShowStackDamageText(TextDamageParam textDamageParam, BaseEntity owner, string key = "default", int skillId = 0)
	{
		if (textDamageParam == null || string.IsNullOrEmpty(textDamageParam.showContent) || string.IsNullOrEmpty(key))
		{
			ReferencePool.Release(textDamageParam);
			return;
		}
		if (!key.Equals("injured") && !key.Equals("health") && GetCanShowDamageText() == 0f)
		{
			ReferencePool.Release(textDamageParam);
			return;
		}
		Transform transform = owner.GetComponent<EntityViewComponent>().Transform;
		bool flag = TryMergeDamageText(textDamageParam, transform, key, skillId, out var mergedDamage, out var lastRandomPos);
		if (flag)
		{
			textDamageParam.showContent = mergedDamage.ToString();
		}
		UITextDamage uITextDamage = AllocateDamageText(key, transform, textDamageParam.showContent.Length);
		if (uITextDamage == null)
		{
			Toast.ShowError("找不到跳字类型 " + key);
			ReferencePool.Release(textDamageParam);
		}
		else
		{
			uITextDamage.UpdateData(textDamageParam, flag, lastRandomPos);
			RegisterActiveDamageText(uITextDamage, key, skillId, textDamageParam.showContent);
			ReferencePool.Release(textDamageParam);
		}
	}

	private bool TryMergeDamageText(TextDamageParam textDamageParam, Transform followRoot, string key, int skillId, out int mergedDamage, out Vector2 lastRandomPos)
	{
		mergedDamage = 0;
		lastRandomPos = Vector2.zero;
		if (!CanMergeDamageText() || !IsMergeDamageTextKey(key) || skillId <= 0)
		{
			return false;
		}
		if (!int.TryParse(textDamageParam.showContent, out var result))
		{
			return false;
		}
		ClearInvalidActiveDamageText();
		Vector2 vector = CalculateDamageTextPosition(followRoot, textDamageParam.OffsetPos);
		ActiveDamageTextInfo activeDamageTextInfo = null;
		float num = mergeDamageTextDistance * mergeDamageTextDistance;
		bool flag = false;
		float num2 = float.MaxValue;
		_ = string.Empty;
		for (int i = 0; i < activeDamageTextInfos.Count; i++)
		{
			ActiveDamageTextInfo activeDamageTextInfo2 = activeDamageTextInfos[i];
			if (activeDamageTextInfo2.SkillId == skillId)
			{
				flag = true;
				float sqrMagnitude = (activeDamageTextInfo2.UiPosition - vector).sqrMagnitude;
				if (sqrMagnitude < num2)
				{
					num2 = sqrMagnitude;
					_ = activeDamageTextInfo2.Key;
				}
				if (IsMergeDamageTextKey(activeDamageTextInfo2.Key) && !(sqrMagnitude >= num))
				{
					num = sqrMagnitude;
					activeDamageTextInfo = activeDamageTextInfo2;
				}
			}
		}
		if (activeDamageTextInfo == null)
		{
			return false;
		}
		mergedDamage = activeDamageTextInfo.Damage + result;
		lastRandomPos = activeDamageTextInfo.TextDamage.GetRandomPos();
		activeDamageTextInfo.TextDamage.ForceClearData();
		activeDamageTextInfos.Remove(activeDamageTextInfo);
		return true;
	}

	private void RegisterActiveDamageText(UITextDamage textDamage, string key, int skillId, string damageText)
	{
		if (IsMergeDamageTextKey(key) && skillId > 0 && int.TryParse(damageText, out var result))
		{
			ActiveDamageTextInfo activeDamageTextInfo = new ActiveDamageTextInfo();
			activeDamageTextInfo.TextDamage = textDamage;
			activeDamageTextInfo.Key = key;
			activeDamageTextInfo.SkillId = skillId;
			activeDamageTextInfo.Damage = result;
			activeDamageTextInfo.UiPosition = textDamage.GetUiPositionWithoutRandomOffset();
			activeDamageTextInfos.Add(activeDamageTextInfo);
		}
	}

	private void ClearInvalidActiveDamageText()
	{
		for (int num = activeDamageTextInfos.Count - 1; num >= 0; num--)
		{
			UITextDamage textDamage = activeDamageTextInfos[num].TextDamage;
			if (textDamage == null || !textDamage.IsInLifeTime)
			{
				activeDamageTextInfos.RemoveAt(num);
			}
		}
	}

	private Vector2 CalculateDamageTextPosition(Transform followRoot, Vector3 offset)
	{
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Invalid comparison between Unknown and I4
		//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
		if (followRoot == null || _canvasGroup == null || (Object)(object)_canvasGroup.Canvas == null)
		{
			return Vector2.zero;
		}
		Canvas canvas = _canvasGroup.Canvas;
		Vector3 position = followRoot.position + offset;
		if ((int)canvas.renderMode == 2)
		{
			return new Vector2(position.x, position.y);
		}
		if (_barCamera != null)
		{
			Vector2 vector = _barCamera.WorldToScreenPoint(position);
			RectTransform rectTransform = _canvasGroup.Root as RectTransform;
			if (rectTransform == null)
			{
				rectTransform = ((Component)(object)canvas).transform as RectTransform;
			}
			Vector2 result = default(Vector2);
			RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, vector, ((int)canvas.renderMode == 0) ? null : canvas.worldCamera, ref result);
			return result;
		}
		return ((RectTransform)((Component)(object)canvas).transform).InverseTransformPoint(position);
	}

	private bool CanMergeDamageText()
	{
		return GameSettingExtension.GetFloatRawValue("伤害数字显示") == 2f;
	}

	private bool IsMergeDamageTextKey(string key)
	{
		if (!(key == "default") && !(key == "critical"))
		{
			return key == "injured";
		}
		return true;
	}

	public float GetCanShowDamageText()
	{
		return GameSettingExtension.GetFloatRawValue("伤害数字显示");
	}

	public override void OnDispose()
	{
		foreach (KeyValuePair<string, IObjectPool<GameObject>> item in _damageTextPool)
		{
			item.Value.Dispose();
		}
		_damageTextPool.Clear();
		_damageTextPool = null;
		activeDamageTextInfos.Clear();
	}
}
