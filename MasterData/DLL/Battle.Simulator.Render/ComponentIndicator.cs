using System;
using System.Collections.Generic;
using Config;
using UnityEngine;
using UnityEngine.UI;

public class ComponentIndicator : CMonoBehaviour
{
	public const string SCENE_INDICATOR_PATH = "Effect/Battle/SceneIndicator";

	public const string ENEMY_INDICATOR_PATH = "Effect/Battle/EnemyIndicatorUI";

	public const string FRIEND_INDICATOR_PATH = "Effect/Battle/FriendIndicatorUI";

	public const string LOCK1_PATH = "Effect/General/fx_general_lock_blue";

	public const string LOCK2_PATH = "Effect/General/fx_general_lock_red";

	public const string HERO_INDICATOR_BASE = "Effect/Battle/HeroIndicatorBase";

	public const float mEllipseHeight = 266f;

	public const int mMaxEnemyIndicator = 4;

	private const float AngularVelocity = 10f;

	private Transform _spine;

	private GameObject _locker1;

	private GameObject _locker2;

	private EffectController _locker1ec;

	private EffectController _locker2ec;

	private BBHumanoid bb;

	private BattleScene _battleScene;

	private Transform _areaIndicator;

	private Transform _heroIndicator;

	private Dictionary<int, Transform> _enemy = new Dictionary<int, Transform>(100, new IntComparer());

	private Dictionary<int, Transform> _friend = new Dictionary<int, Transform>(10, new IntComparer());

	private Dictionary<int, Transform> _special = new Dictionary<int, Transform>(5, new IntComparer());

	private Dictionary<int, Transform> _triiger = new Dictionary<int, Transform>(5, new IntComparer());

	private Dictionary<int, Text> _triigerDis = new Dictionary<int, Text>(5, new IntComparer());

	private Dictionary<int, Vector3> _triigerPos = new Dictionary<int, Vector3>(5, new IntComparer());

	private LockTargetCinemachine _targetCinemachine;

	private Camera _mainCamera;

	private Renderer[] _heroIndicatorRenderers;

	private GameObject dynamicalCanvas;

	public float lockEffectScale = 1f;

	public bool overlookMode;

	private bool specialMode;

	[NonSerialized]
	public bool disableEnemyIndicator;

	public bool isShowHeroIndicator = true;

	private float mMagicFloat = 1.5f;

	public override void Initialize()
	{
		base.Initialize();
		AttachPointSetup attachPointSetup = U3DUtil.Get<AttachPointSetup>(base.gameObject);
		_spine = attachPointSetup.GetAttachPoint("root");
		if (null == _spine)
		{
			_spine = attachPointSetup.GetAttachPoint("Bip001");
		}
		BBCommom blackboard = mAgent.Blackboard;
		blackboard.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Combine(blackboard.ActionHandler, new BBCommom.AgentActionHandler(HandleAction));
		_battleScene = (BattleScene)NScene.GetCurrentScene();
		if (_targetCinemachine == null)
		{
			_targetCinemachine = _battleScene.virtualCameraParam.gameObject.GetComponent<LockTargetCinemachine>();
		}
		_areaIndicator = Asset.Instantiate("Effect/Battle/SceneIndicator").transform;
		bb = mAgent.Blackboard as BBHumanoid;
		_mainCamera = Camera.main;
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<SimGameOverEvent>(OnGameStopHandler);
		dynamicalCanvas = GameObject.Find("UICamera");
		if (dynamicalCanvas != null)
		{
			dynamicalCanvas = dynamicalCanvas.transform.Find("DynamicalCanvas").gameObject;
			dynamicalCanvas.SetActive(value: true);
		}
	}

	private void OnGameStopHandler(SimGameOverEvent eventReceived)
	{
		ResetBehavior();
	}

	private bool InView(Vector3 position)
	{
		if (_mainCamera == null)
		{
			_mainCamera = Camera.main;
		}
		Vector3 vector = _mainCamera.WorldToScreenPoint(position);
		if (vector.z > 0f && vector.x > 0f)
		{
			return vector.x < (float)Screen.width;
		}
		return false;
	}

	private bool InViewOverlook(Vector3 position)
	{
		if (_mainCamera == null)
		{
			_mainCamera = Camera.main;
		}
		Vector3 vector = _mainCamera.WorldToScreenPoint(position);
		if (vector.z > 0f && vector.x > 0f && vector.x < (float)Screen.width && vector.y > 0f)
		{
			return vector.y < (float)Screen.height;
		}
		return false;
	}

	private void MoveIndicator(NAgent agent, Transform indicator)
	{
		Vector3 vector = agent.Position - base.transform.position;
		Vector2 vector2 = _mainCamera.WorldToScreenPoint(base.transform.position);
		Vector3 localPosition = _mainCamera.WorldToScreenPoint(agent.Position);
		localPosition.x -= vector2.x;
		localPosition.y -= vector2.y;
		float num = 266f * (float)Screen.width / (float)Screen.height;
		float num2 = 266f;
		if (localPosition.x * localPosition.x / (num * num) + localPosition.y * localPosition.y / (num2 * num2) < 1f && localPosition.z > 0f)
		{
			indicator.localPosition = localPosition;
		}
		else
		{
			localPosition = _mainCamera.WorldToScreenPoint(base.transform.position + vector.normalized);
			Vector2 vector3 = (Vector2)localPosition - vector2;
			float num3 = vector3.y / vector3.x;
			float num4 = Mathf.Sign(vector3.x) * Mathf.Sqrt(1f / (1f / (num * num) + num3 * num3 / (num2 * num2)));
			float num5 = Mathf.Sign(vector3.y) * num2 * Mathf.Sqrt(1f - num4 * num4 / (num * num));
			if (!float.IsNaN(num4) && !float.IsNaN(num5))
			{
				indicator.localPosition = new Vector2(num4, num5);
			}
		}
		indicator.localRotation = Quaternion.FromToRotation(Vector3.up, indicator.localPosition);
	}

	private void MoveLocalIndicator(Vector3 pos, Transform indicator, Text text)
	{
		pos += new Vector3(0f, 2f, 0f);
		Vector3 vector = _mainCamera.transform.position + _mainCamera.transform.forward;
		Vector3 vector2 = pos - vector;
		Vector2 vector3 = _mainCamera.WorldToScreenPoint(vector);
		Vector3 localPosition = _mainCamera.WorldToScreenPoint(pos);
		localPosition.x -= vector3.x;
		localPosition.y -= vector3.y;
		float num = 266f * (float)Screen.width / (float)Screen.height;
		float num2 = 266f;
		Vector2 sizeDelta = (dynamicalCanvas.transform as RectTransform).sizeDelta;
		localPosition.x *= sizeDelta.x / (float)Screen.width;
		localPosition.y *= sizeDelta.y / (float)Screen.height;
		if (localPosition.x * localPosition.x / (num * num) + localPosition.y * localPosition.y / (num2 * num2) < 1f && localPosition.z >= 0f)
		{
			indicator.localPosition = localPosition;
			DrawText(enable: true, text, vector2.magnitude);
			return;
		}
		DrawText(enable: false, text, vector2.magnitude);
		pos = vector + vector2.normalized;
		localPosition = _mainCamera.WorldToScreenPoint(pos);
		Vector2 vector4 = (Vector2)localPosition - vector3;
		float num3 = vector4.y / vector4.x;
		float num4 = Mathf.Sign(vector4.x) * Mathf.Sqrt(1f / (1f / (num * num) + num3 * num3 / (num2 * num2)));
		float y = Mathf.Sign(vector4.y) * num2 * Mathf.Sqrt(1f - num4 * num4 / (num * num));
		indicator.localPosition = new Vector2(num4, y);
	}

	private void DrawText(bool enable, Text mDistanceText, float sDistance)
	{
		if (!(mDistanceText == null))
		{
			if (!enable)
			{
				mDistanceText.text = "";
				return;
			}
			int num = (int)(sDistance / mMagicFloat);
			string empty = string.Empty;
			empty = ((num < CommonString.Numbers.Length && num >= 0) ? CommonString.Numbers[num] : num.ToString());
			mDistanceText.text = empty;
		}
	}

	private Transform GetEnemeyIndicator(NAgent agent, bool isEnemy = true)
	{
		Transform value = null;
		if (_special.ContainsKey(agent.AgentID))
		{
			return value;
		}
		if (isEnemy)
		{
			if (!_enemy.TryGetValue(agent.AgentID, out value))
			{
				value = Asset.Instantiate("Effect/Battle/EnemyIndicatorUI").transform;
				_enemy[agent.AgentID] = value;
				if (dynamicalCanvas != null)
				{
					value.SetParent(dynamicalCanvas.transform);
				}
				value.localScale = new Vector3(1f, 1f, 1f);
			}
		}
		else if (!_friend.TryGetValue(agent.AgentID, out value))
		{
			value = Asset.Instantiate("Effect/Battle/FriendIndicatorUI").transform;
			_friend[agent.AgentID] = value;
			if (dynamicalCanvas != null)
			{
				value.SetParent(dynamicalCanvas.transform);
			}
			value.localScale = new Vector3(1f, 1f, 1f);
		}
		MoveIndicator(agent, value);
		return value;
	}

	private void ReturnEnemyIndicator(int id)
	{
		Transform value = null;
		if (_enemy.TryGetValue(id, out value))
		{
			_enemy.Remove(id);
			PooledAsset.DestroyOrReturn(value.gameObject);
		}
		else if (_friend.TryGetValue(id, out value))
		{
			_friend.Remove(id);
			PooledAsset.DestroyOrReturn(value.gameObject);
		}
	}

	private void HandleAction(AgentAction action)
	{
		if (action is AgentActionAbilityLeave && isShowHeroIndicator && _heroIndicator == null)
		{
			_heroIndicator = Asset.Instantiate("Effect/Battle/HeroIndicatorBase").transform;
			if (_heroIndicator != null)
			{
				_heroIndicatorRenderers = _heroIndicator.GetComponentsInChildren<Renderer>();
			}
		}
	}

	public override void UpdateBehavior()
	{
		if (_battleScene == null)
		{
			return;
		}
		if (!disableEnemyIndicator)
		{
			List<int> list = FrameListPool<int>.Claim();
			Dictionary<int, Transform>.Enumerator enumerator = _enemy.GetEnumerator();
			while (enumerator.MoveNext())
			{
				list.Add(enumerator.Current.Key);
			}
			enumerator = _friend.GetEnumerator();
			while (enumerator.MoveNext())
			{
				list.Add(enumerator.Current.Key);
			}
			List<NAgent> entities = _battleScene.GetAgentManager().Entities;
			entities.Sort(delegate(NAgent x, NAgent y)
			{
				int num6 = 0;
				double num7 = (x.Position - base.transform.position).sqrMagnitude;
				double num8 = (y.Position - base.transform.position).sqrMagnitude;
				if (num7 > num8)
				{
					return 1;
				}
				return (num7 < num8) ? (-1) : 0;
			});
			int num = 0;
			if (!overlookMode)
			{
				for (int num2 = 0; num2 < entities.Count; num2++)
				{
					NAgent nAgent = entities[num2];
					if (!nAgent.IsAlpha && RoleCampProcessor.IsEnemy(nAgent.Camp) && !InView(nAgent.transform.position) && !(GetEnemeyIndicator(nAgent) == null))
					{
						list.Remove(nAgent.AgentID);
						num++;
						if (num >= 4)
						{
							break;
						}
					}
				}
			}
			else
			{
				for (int num3 = 0; num3 < entities.Count; num3++)
				{
					NAgent nAgent2 = entities[num3];
					bool flag = !RoleCampProcessor.CompareCamp(nAgent2.Camp, mAgent.Camp);
					if ((!flag || num < 4) && !nAgent2.IsAlpha && nAgent2.AgentID != mAgent.AgentID && !InViewOverlook(nAgent2.transform.position) && !(GetEnemeyIndicator(nAgent2, flag) == null))
					{
						list.Remove(nAgent2.AgentID);
						num++;
					}
				}
			}
			for (int num4 = 0; num4 < list.Count; num4++)
			{
				ReturnEnemyIndicator(list[num4]);
			}
			FrameListPool<int>.Release(list);
		}
		else
		{
			List<int> list2 = FrameListPool<int>.Claim();
			Dictionary<int, Transform>.Enumerator enumerator2 = _enemy.GetEnumerator();
			while (enumerator2.MoveNext())
			{
				list2.Add(enumerator2.Current.Key);
			}
			enumerator2 = _friend.GetEnumerator();
			while (enumerator2.MoveNext())
			{
				list2.Add(enumerator2.Current.Key);
			}
			for (int num5 = 0; num5 < list2.Count; num5++)
			{
				ReturnEnemyIndicator(list2[num5]);
			}
			FrameListPool<int>.Release(list2);
		}
		if (specialMode)
		{
			UpdateSpecialIndicator();
		}
		UpdateLocalIndicator();
		bool nextAreaDirection = _battleScene.GetNextAreaDirection(out var direction);
		_areaIndicator.gameObject.SetActive(nextAreaDirection);
		_areaIndicator.transform.position = GetIndicatorPosition();
		if (nextAreaDirection)
		{
			Vector3 vector = direction - base.transform.position;
			_areaIndicator.forward = vector.NewY(0f);
		}
	}

	public void AddSpecialIndicator(int agentID, string path)
	{
		NAgent agent = AgentManager.GetAgentManager().GetAgent(agentID);
		if (!(agent == null))
		{
			Transform value = null;
			if (_special.TryGetValue(agent.AgentID, out value))
			{
				PooledAsset.DestroyOrReturn(value.gameObject);
			}
			value = Asset.Instantiate(path).transform;
			_special[agent.AgentID] = value;
			if (dynamicalCanvas != null)
			{
				value.SetParent(dynamicalCanvas.transform);
			}
			value.localScale = new Vector3(1f, 1f, 1f);
			specialMode = true;
		}
	}

	private void UpdateSpecialIndicator()
	{
		Dictionary<int, Transform>.Enumerator enumerator = _special.GetEnumerator();
		List<int> list = FrameListPool<int>.Claim();
		while (enumerator.MoveNext())
		{
			NAgent agent = AgentManager.GetAgentManager().GetAgent(enumerator.Current.Key);
			if (agent == null)
			{
				list.Add(enumerator.Current.Key);
				continue;
			}
			Transform value = enumerator.Current.Value;
			if (!agent.IsAlpha && !InViewOverlook(agent.transform.position))
			{
				if (!value.gameObject.activeSelf)
				{
					value.gameObject.SetActive(value: true);
				}
				MoveIndicator(agent, value);
			}
			else if (value.gameObject.activeSelf)
			{
				value.gameObject.SetActive(value: false);
			}
		}
		for (int i = 0; i < list.Count; i++)
		{
			RemoveSpecialIndicator(list[i]);
		}
		FrameListPool<int>.Release(list);
	}

	public void RemoveSpecialIndicator(int agentID)
	{
		Transform value = null;
		if (_special.TryGetValue(agentID, out value))
		{
			PooledAsset.DestroyOrReturn(value.gameObject);
			_special.Remove(agentID);
		}
		if (_special.Count <= 0)
		{
			specialMode = false;
		}
	}

	public void ResetSpecialIndicator()
	{
		foreach (KeyValuePair<int, Transform> item in _special)
		{
			PooledAsset.DestroyOrReturn(item.Value.gameObject);
		}
		_special.Clear();
		specialMode = false;
	}

	public void AddLocalIndicator(Vector3 pos, string path, int triggerID)
	{
		Transform value = null;
		if (_triiger.TryGetValue(triggerID, out value))
		{
			PooledAsset.DestroyOrReturn(value.gameObject);
		}
		value = Asset.Instantiate(path).transform;
		_triiger[triggerID] = value;
		_triigerDis[triggerID] = U3DUtil.GetComponentInChildren<Text>(value.gameObject);
		_triigerPos[triggerID] = pos;
		if (dynamicalCanvas != null)
		{
			value.SetParent(dynamicalCanvas.transform);
		}
		value.localScale = new Vector3(1f, 1f, 1f);
		specialMode = true;
	}

	private void UpdateLocalIndicator()
	{
		Dictionary<int, Transform>.Enumerator enumerator = _triiger.GetEnumerator();
		while (enumerator.MoveNext())
		{
			Transform value = enumerator.Current.Value;
			MoveLocalIndicator(_triigerPos[enumerator.Current.Key], value, _triigerDis[enumerator.Current.Key]);
		}
	}

	public void RemoveLocalIndicator(int agentID)
	{
		Transform value = null;
		if (_triiger.TryGetValue(agentID, out value))
		{
			PooledAsset.DestroyOrReturn(value.gameObject);
			_triiger.Remove(agentID);
			_triigerDis.Remove(agentID);
			_triigerPos.Remove(agentID);
		}
	}

	private Vector3 GetLockerPos(Vector3 cameraPos, Vector3 targetPos)
	{
		if ((cameraPos - targetPos).sqrMagnitude > 100f)
		{
			Vector3 vector = targetPos - cameraPos;
			vector.Normalize();
			return vector * 10f + cameraPos;
		}
		return targetPos;
	}

	public static Transform GetLockAttachPoint(NAgent target, int part)
	{
		if (ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(target.AgentConfigID, out var config) && config.ShapePartTypes != null && config.ShapePartAttachPoint != null)
		{
			int num = -1;
			for (int i = 0; i < config.ShapePartTypes.Count; i++)
			{
				if (config.ShapePartTypes.get_Item(i) == (ShapePartType)part)
				{
					num = i;
					break;
				}
			}
			if (num != -1 && config.ShapePartAttachPoint.Count > num)
			{
				string text = config.ShapePartAttachPoint.get_Item(num);
				return U3DUtil.Get<AttachPointSetup>(target.gameObject).GetAttachPoint(text);
			}
		}
		return U3DUtil.Get<AttachPointSetup>(target.gameObject).GetAttachPoint(En_BaseAttachPointType.HitPoint);
	}

	private void LateUpdate()
	{
		if (_battleScene == null)
		{
			return;
		}
		WorldStateManager worldSatetManager = _battleScene.GetWorldSatetManager();
		if (worldSatetManager == null)
		{
			return;
		}
		int lockedAgentID = worldSatetManager.lockedAgentID;
		NAgent agent = _battleScene.GetAgentManager().GetAgent(lockedAgentID);
		if (null != agent && (agent.Blackboard as BBHumanoid).m_NextSimFrameData.HP > 0)
		{
			Transform lockAttachPoint = GetLockAttachPoint(agent, worldSatetManager.lockedAgentPart);
			if (null != lockAttachPoint)
			{
				if (_mainCamera == null)
				{
					_mainCamera = Camera.main;
				}
				if (worldSatetManager.hasManualLock)
				{
					if (_locker2 == null)
					{
						_locker2 = Asset.Instantiate("Effect/General/fx_general_lock_red");
						EffectController effectController = EffectController.GetEffectController(_locker2);
						effectController.Initialize(isLoop: true, 10f, 1f, EEffectQuality.Fantastic, null);
						effectController.Simulator(0f);
						_locker2ec = effectController;
					}
					if (_locker1 != null)
					{
						PooledAsset.DestroyOrReturn(_locker1);
						_locker1 = null;
						_locker1ec = null;
					}
					_locker2.transform.position = GetLockerPos(_mainCamera.transform.position, lockAttachPoint.position);
					_locker2.transform.localScale = new Vector3(lockEffectScale, lockEffectScale, lockEffectScale);
					_locker2.transform.localRotation = Quaternion.identity;
				}
				else if (!worldSatetManager.hasManualLock)
				{
					if (_locker1 == null)
					{
						_locker1 = Asset.Instantiate("Effect/General/fx_general_lock_blue");
						EffectController effectController2 = EffectController.GetEffectController(_locker1);
						effectController2.Initialize(isLoop: true, 10f, 1f, EEffectQuality.Fantastic, null);
						effectController2.Simulator(0f);
						_locker1ec = effectController2;
					}
					if (_locker2 != null)
					{
						PooledAsset.DestroyOrReturn(_locker2);
						_locker2 = null;
						_locker2ec = null;
					}
					_locker1.transform.position = GetLockerPos(_mainCamera.transform.position, lockAttachPoint.position);
					_locker1.transform.localScale = new Vector3(lockEffectScale, lockEffectScale, lockEffectScale);
					_locker1.transform.localRotation = Quaternion.identity;
				}
			}
		}
		else
		{
			if (_locker1 != null)
			{
				PooledAsset.DestroyOrReturn(_locker1);
				_locker1 = null;
				_locker1ec = null;
			}
			if (_locker2 != null)
			{
				PooledAsset.DestroyOrReturn(_locker2);
				_locker2 = null;
				_locker2ec = null;
			}
		}
		if (_heroIndicator != null)
		{
			_heroIndicator.position = _spine.position.NewY(base.transform.position.y + 0.02f);
		}
	}

	public override void LateUpdateBehavior()
	{
	}

	public override void ResetBehavior()
	{
		base.ResetBehavior();
		Dictionary<int, Transform>.Enumerator enumerator = _enemy.GetEnumerator();
		while (enumerator.MoveNext())
		{
			PooledAsset.DestroyOrReturn(enumerator.Current.Value.gameObject);
		}
		_enemy.Clear();
		enumerator = _friend.GetEnumerator();
		while (enumerator.MoveNext())
		{
			PooledAsset.DestroyOrReturn(enumerator.Current.Value.gameObject);
		}
		_friend.Clear();
		if (_areaIndicator != null)
		{
			PooledAsset.DestroyOrReturn(_areaIndicator.gameObject);
			_areaIndicator = null;
		}
		if (_heroIndicatorRenderers != null)
		{
			_heroIndicatorRenderers = null;
		}
		if (_heroIndicator != null)
		{
			PooledAsset.DestroyOrReturn(_heroIndicator.gameObject);
			_heroIndicator = null;
		}
		if (mAgent != null && mAgent.Blackboard != null)
		{
			BBCommom blackboard = mAgent.Blackboard;
			blackboard.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Remove(blackboard.ActionHandler, new BBCommom.AgentActionHandler(HandleAction));
		}
		if (_locker1 != null)
		{
			PooledAsset.DestroyOrReturn(_locker1);
			_locker1 = null;
			_locker1ec = null;
		}
		if (_locker2 != null)
		{
			PooledAsset.DestroyOrReturn(_locker2);
			_locker2 = null;
			_locker2ec = null;
		}
		ResetSpecialIndicator();
		_battleScene = null;
	}

	public void ShowHeroIndicator()
	{
		isShowHeroIndicator = true;
		if (_heroIndicator == null)
		{
			_heroIndicator = Asset.Instantiate("Effect/Battle/HeroIndicatorBase").transform;
			if (_heroIndicator != null)
			{
				_heroIndicatorRenderers = _heroIndicator.GetComponentsInChildren<Renderer>();
			}
		}
	}

	public void HideHeroIndicator()
	{
		isShowHeroIndicator = false;
		if (_heroIndicator != null)
		{
			PooledAsset.DestroyOrReturn(_heroIndicator.gameObject);
			_heroIndicator = null;
		}
	}

	private Vector3 GetIndicatorPosition()
	{
		if (bb != null)
		{
			return _spine.position.NewY(bb.CurrentFramePosition.y + 0.02f);
		}
		return _spine.position.NewY(base.transform.position.y + 0.02f);
	}

	public void DisableRenders()
	{
		if (_heroIndicatorRenderers != null)
		{
			for (int i = 0; i < _heroIndicatorRenderers.Length; i++)
			{
				_heroIndicatorRenderers[i].enabled = false;
			}
		}
		if (_locker1 != null && _locker1ec != null)
		{
			_locker1ec.Hide(v: true);
		}
		if (_locker2 != null && _locker2ec != null)
		{
			_locker2ec.Hide(v: true);
		}
	}

	public void EnableRenders()
	{
		if (_heroIndicatorRenderers != null)
		{
			for (int i = 0; i < _heroIndicatorRenderers.Length; i++)
			{
				_heroIndicatorRenderers[i].enabled = true;
			}
		}
		if (_locker1 != null && _locker1ec != null)
		{
			_locker1ec.Hide(v: false);
		}
		if (_locker2 != null && _locker2ec != null)
		{
			_locker2ec.Hide(v: false);
		}
	}
}
