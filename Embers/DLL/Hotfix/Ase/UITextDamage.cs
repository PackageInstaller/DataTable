using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Text;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class UITextDamage : EntityInfoBase
{
	[SerializeField]
	private TextMeshProUGUI _label;

	[SerializeField]
	private string otherSign;

	[SerializeField]
	private string numPrefixIndex;

	[SerializeField]
	private RectTransform hbRect;

	[SerializeField]
	private RectTransform bRect;

	[SerializeField]
	private RectTransform downIconRect;

	[Header("多颜色显示")]
	[SerializeField]
	private string[] textColorNumPrefixIndex;

	[Header("多颜色显示")]
	[SerializeField]
	private string[] textOutLinghtColorNumPrefixIndex;

	[SerializeField]
	private Transform textRoot;

	[SerializeField]
	private GameObject glowObj;

	[SerializeField]
	private Transform glowParent;

	[SerializeField]
	private Color[] glowColors;

	[SerializeField]
	private string singleTextKey;

	[SerializeField]
	private float halfTextWidth;

	[SerializeField]
	private Animation aniComp;

	[Header("策划配置")]
	[SerializeField]
	private float lifeTime;

	[SerializeField]
	private float singleTextConfigTime;

	[SerializeField]
	private float mergeSingleTextConfigTime;

	[SerializeField]
	private int mergePlaAniCount;

	[SerializeField]
	private int OffsetXMin = -100;

	[SerializeField]
	private int OffsetXMax = 100;

	[SerializeField]
	private int OffsetYMin = 60;

	[SerializeField]
	private int OffsetYMax = 180;

	private Vector2 _randomOffset;

	private bool _firstTime;

	private Vector3 _initialPosition;

	private Vector3 _currentUiPosition;

	private Vector3 _offset;

	private float _time;

	private string content;

	private List<GameObject> singleTextObjs = new List<GameObject>(4);

	private List<GameObject> glowObjs = new List<GameObject>(8);

	private float glowTimer;

	private int glowNeedShowCount;

	public string SingleTextKey => singleTextKey;

	public bool IsInLifeTime
	{
		get
		{
			if (base.gameObject.activeInHierarchy && _time >= 0f)
			{
				return _time < lifeTime;
			}
			return false;
		}
	}

	public override void Init(Camera barCamera, Canvas infoCanvas)
	{
		base.Init(barCamera, infoCanvas);
		_firstTime = true;
	}

	public void AddSingleText(GameObject singleTextObj)
	{
		singleTextObjs.Add(singleTextObj);
		singleTextObj.SetActive(value: false);
		singleTextObj.transform.SetParent(textRoot);
	}

	public Vector2 GetUiPositionWithoutRandomOffset()
	{
		if (rectTransform == null)
		{
			return Vector2.zero;
		}
		return rectTransform.anchoredPosition3D - (Vector3)_randomOffset;
	}

	public Vector2 GetRandomPos()
	{
		return _randomOffset;
	}

	public void UpdateData(TextDamageParam textDamageParam, bool merge, Vector2 lastRandomPos)
	{
		_time = 0f;
		_firstTime = true;
		UpdateDamageData(textDamageParam.showContent, textDamageParam.WeaknessLevel, merge);
		if (!merge)
		{
			_randomOffset.x = Random.Range(OffsetXMin, OffsetXMax);
			_randomOffset.y = Random.Range(OffsetYMin, OffsetYMax);
		}
		else
		{
			_randomOffset = lastRandomPos;
		}
		ShowHBText(textDamageParam.maxSiteLevel);
		ShowHitDownEnergyIcon(textDamageParam.HitDownOrBreak, textDamageParam.maxSiteLevel >= 2);
		_offset = textDamageParam.OffsetPos;
		base.gameObject.SetActive(value: true);
		if (!aniComp.playAutomatically)
		{
			if (merge)
			{
				aniComp.Play("Merge");
			}
			else
			{
				aniComp.Play("Normal");
			}
		}
		RefreshPosition();
	}

	public void ForceClearData()
	{
		_time = lifeTime;
		ClearData();
	}

	private void ShowHBText(int maxSiteLevel)
	{
		if (!(hbRect == null) && !(bRect == null))
		{
			hbRect.gameObject.SetActive(maxSiteLevel == 3);
			bRect.gameObject.SetActive(maxSiteLevel == 2);
		}
	}

	private void ShowHitDownEnergyIcon(bool showDownIcon, bool showHB)
	{
		if (!(downIconRect == null))
		{
			downIconRect.localScale = (showDownIcon ? Vector3.one : Vector3.zero);
		}
	}

	private void UpdateDamageData(string text, int weaknessLevel, bool merge)
	{
		if ((Object)(object)_label != null)
		{
			if (numPrefixIndex != string.Empty)
			{
				content = otherSign;
				foreach (char arg in text)
				{
					content = ZString.Concat(content, ZString.Format("<sprite={0}{1}>", numPrefixIndex, arg));
				}
			}
			((TMP_Text)_label).SetText(content, true);
			return;
		}
		int length = text.Length;
		GlowObjSet(length, weaknessLevel);
		Vector2 vector = Vector2.right * ((float)(length - 3) * (0f - halfTextWidth));
		Vector3 localPosition = glowParent.localPosition;
		localPosition.x = vector.x;
		glowParent.localPosition = localPosition;
		hbRect.anchoredPosition = vector;
		bRect.anchoredPosition = vector;
		int num = length - mergePlaAniCount;
		for (int j = 0; j < singleTextObjs.Count; j++)
		{
			singleTextObjs[j].TryGetComponent<NormalSingleTextDamage>(out var component);
			if (!(component != null))
			{
				continue;
			}
			for (int k = j * 3; k <= j * 3 + 2; k++)
			{
				char c = ((k < length) ? text[k] : '\0');
				float time = (float)k * singleTextConfigTime;
				if (merge)
				{
					time = ((mergePlaAniCount <= 0) ? ((float)k * mergeSingleTextConfigTime) : ((length <= mergePlaAniCount) ? ((float)k * mergeSingleTextConfigTime) : ((k < num) ? (-1f) : ((float)(k - num) * mergeSingleTextConfigTime))));
				}
				GameObject gameObject = null;
				if (glowObjs.Count > k && weaknessLevel >= 2)
				{
					gameObject = glowObjs[k];
				}
				component.SetTextContent(c, time, k % 3, gameObject, merge);
			}
			singleTextObjs[j].gameObject.SetActive(value: true);
			if (textColorNumPrefixIndex != null && textColorNumPrefixIndex.Length > weaknessLevel - 1)
			{
				component.ShowContent(textColorNumPrefixIndex[weaknessLevel - 1]);
			}
			if (textOutLinghtColorNumPrefixIndex != null && textOutLinghtColorNumPrefixIndex.Length > weaknessLevel - 1)
			{
				component.ShowOutLightContent(textOutLinghtColorNumPrefixIndex[weaknessLevel - 1]);
			}
			if (j == 0)
			{
				component.RectTransform.anchoredPosition = vector;
			}
			else
			{
				component.RectTransform.anchoredPosition = vector + Vector2.right * halfTextWidth * 2f * 3f * j;
			}
		}
	}

	private void GlowObjSet(int count, int weaknessLevel)
	{
		if (weaknessLevel <= 1)
		{
			return;
		}
		glowNeedShowCount = count;
		int count2 = glowObjs.Count;
		if (count2 < count)
		{
			for (int i = 0; i < count - count2; i++)
			{
				GameObject item = Object.Instantiate(glowObj, glowParent);
				glowObjs.Add(item);
			}
		}
		for (int j = 0; j < glowNeedShowCount; j++)
		{
			glowObjs[j].transform.localPosition = new Vector3((float)(j - 1) * halfTextWidth * 2f, 0f, 0f);
			if (glowColors.Length > weaknessLevel - 1)
			{
				Image componentInChildren = glowObjs[j].GetComponentInChildren<Image>();
				if (componentInChildren != null)
				{
					componentInChildren.color = glowColors[weaknessLevel - 1];
				}
			}
		}
	}

	protected override void LateUpdate()
	{
		base.LateUpdate();
		_time += Time.deltaTime;
		if (_time >= lifeTime)
		{
			_time = lifeTime;
			ClearData();
		}
	}

	protected override void RefreshPosition()
	{
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Invalid comparison between Unknown and I4
		//IL_00ff: Unknown result type (might be due to invalid IL or missing references)
		if (followRoot == null)
		{
			return;
		}
		Vector3 initialPosition = followRoot.position + _offset;
		if (_firstTime)
		{
			_initialPosition = initialPosition;
		}
		if ((int)canvas.renderMode == 2)
		{
			initialPosition = _initialPosition;
			base.transform.position = initialPosition + Vector3.up * 0f;
			base.transform.localRotation *= Quaternion.Euler(0f, 180f, 0f);
			_currentUiPosition = base.transform.position;
		}
		else
		{
			initialPosition = _initialPosition;
			if (camera != null)
			{
				Vector2 vector = camera.WorldToScreenPoint(initialPosition);
				Vector2 vector2 = default(Vector2);
				RectTransformUtility.ScreenPointToLocalPointInRectangle(base.transform.parent as RectTransform, vector + Vector2.up * 0f, ((int)canvas.renderMode == 0) ? null : canvas.worldCamera, ref vector2);
				vector2 += _randomOffset;
				rectTransform.anchoredPosition3D = vector2;
				_currentUiPosition = vector2;
			}
			else
			{
				Vector3 vector3 = (((Component)(object)canvas).transform as RectTransform).InverseTransformPoint(initialPosition) + Vector3.up * 0f;
				rectTransform.anchoredPosition3D = vector3;
				_currentUiPosition = vector3;
			}
		}
		base.transform.SetAsLastSibling();
		_firstTime = false;
	}

	private void ClearData()
	{
		base.gameObject.SetActive(value: false);
		if (TryGetComponent<IPooledObject>(out var component))
		{
			component.Free();
		}
		for (int i = 0; i < singleTextObjs.Count; i++)
		{
			if (singleTextObjs[i].TryGetComponent<NormalSingleTextDamage>(out var component2))
			{
				singleTextObjs[i].SetActive(value: false);
				singleTextObjs[i].transform.SetParent(((Component)(object)canvas)?.transform);
				component2.ClearData();
			}
			if (singleTextObjs[i].TryGetComponent<IPooledObject>(out var component3))
			{
				component3.Free();
			}
		}
		for (int j = 0; j < glowObjs.Count; j++)
		{
			glowObjs[j].SetActive(value: false);
		}
		singleTextObjs.Clear();
		_randomOffset = Vector2.zero;
	}

	public override void Recovery()
	{
		base.Recovery();
		for (int i = 0; i < glowObjs.Count; i++)
		{
			Object.Destroy(glowObjs[i]);
		}
		glowObjs = null;
	}
}
