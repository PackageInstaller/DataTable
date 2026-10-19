using System;
using ACT.Battle;
using ACT.Event;
using ACT.Sound;
using ACT.UI;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Bamboo.Precache;
using Cinemachine;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.World.StateObject;

public class InteractController : StateObjectBase
{
	public enum BTreeValeType
	{
		vTransform
	}

	private enum RobotAnimState
	{
		Idle,
		Flip,
		WaitingForFlipEnd
	}

	public Collider collider;

	[SerializeField]
	private GameObject _robot;

	[SerializeField]
	private Transform _wifiRoot;

	private Vector3 _leftDir = new Vector3(0f, 180f, 0f);

	private Vector3 _rightDir = Vector3.zero;

	private Animator _robotAnimator;

	public BTreeValeType bTreeValeType;

	public string robotBTValueName = "矿车的Transform";

	public string robotEnterEvent = "kuangche_enter";

	public string robotExitEvent = "kuangche_exit";

	public CinemachineVirtualCamera vcam;

	public Rigidbody rig;

	public Transform pathParentTransform;

	public Transform forwardCheckBoxPos;

	public Transform backCheckBoxPos;

	public GameObject moveLeftEffect;

	public GameObject moveRightEffect;

	public GameObject robotConnectEffect;

	public GameObject fixEffect;

	private Transform m_CheckPos;

	private InteractControllerData m_Data;

	private bool m_Init;

	private InteractEntry _mEntry;

	private Vector3 m_NextPos;

	private bool m_interact;

	private Entity m_Controller;

	private uint m_MineCarLoopEvent;

	private Vector3 m_CurrentTargetPos;

	private Vector3 m_Dir;

	private float m_Dis;

	private Vector3 m_StartPoint;

	private Vector3 m_EndPoint;

	private int m_PathIndex;

	private Vector3 m_Velocity;

	private InstanceHandle m_WifiGo;

	private RobotAnimState m_RobotAnimState;

	private float m_IdleTimer;

	private const float FLIP_WAIT_TIME = 3f;

	private static readonly int ANIM_IDLE = Animator.StringToHash("idle");

	private static readonly int ANIM_FLIP = Animator.StringToHash("flip");

	public override bool serviceSave => true;

	private int PathIndex
	{
		get
		{
			return m_PathIndex;
		}
		set
		{
			if (value != m_PathIndex)
			{
				m_PathIndex = value;
				NetEnterState(m_PathIndex).Forget();
				_mEntry.BindInteractState(m_PathIndex, 0);
			}
		}
	}

	private Vector3 Velocity
	{
		get
		{
			return m_Velocity;
		}
		set
		{
			if (value != m_Velocity)
			{
				if (m_Velocity != Vector3.zero && value == Vector3.zero)
				{
					Singleton<GameManager>.instance.audioManager.Stop(m_MineCarLoopEvent);
					moveRightEffect.SetActive(value: false);
					moveLeftEffect.SetActive(value: false);
				}
				if (m_Velocity == Vector3.zero && value != Vector3.zero)
				{
					m_MineCarLoopEvent = Singleton<GameManager>.instance.audioManager.PlaySound(m_Data.audioMineCarLoopEvent, new AudioPlayOptions
					{
						IsLoop = true,
						attachTarget = transform
					});
					SetMoveEffect(value);
				}
				if (m_Velocity != Vector3.zero && value != Vector3.zero)
				{
					SetMoveEffect(value);
				}
				m_Velocity = value;
			}
		}
	}

	private void SetMoveEffect(Vector3 value)
	{
		if (m_Data.pathDir == PathDir.Right)
		{
			if (value.x > 0f)
			{
				moveRightEffect.SetActive(value: true);
				moveLeftEffect.SetActive(value: false);
			}
			if (value.x < 0f)
			{
				moveRightEffect.SetActive(value: false);
				moveLeftEffect.SetActive(value: true);
			}
		}
		else
		{
			if (value.x > 0f)
			{
				moveRightEffect.SetActive(value: false);
				moveLeftEffect.SetActive(value: true);
			}
			if (value.x < 0f)
			{
				moveRightEffect.SetActive(value: true);
				moveLeftEffect.SetActive(value: false);
			}
		}
	}

	public override void InitStateObject(int stateId)
	{
		CompStateObject compStateObject = entity.GetCompStateObject();
		if (compStateObject?.StateWorldAssetData is InteractControllerData data)
		{
			m_Data = data;
			entity.AddComponent<CompTrigger>().Init();
			CompInput compInput = entity.AddComponent<CompInput>();
			compInput.onLeftPressed.Add(OnLeftMove);
			compInput.onRightPressed.Add(OnRightMove);
			_mEntry = InteractEntry.CreateButtonEntry(m_Data.name, m_Data.weight, m_Data.iconId, -1);
			_mEntry.onInteract = (Entity _) =>
			{
			};
			_mEntry.BindInteractObjectBase(this);
			_mEntry.BindData(compStateObject.StateWorldAssetData);
			_mEntry.BindInteractState(stateId, 0);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.Input_ExitStateObjectControl, ExitInteract);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.Controller_ChangeState, ChangeControllerEvt);
			Vector3 value = m_Data.orbits[stateId].start.value;
			Vector3 value2 = m_Data.orbits[stateId].end.value;
			Transform transform = rig.transform;
			Vector3 position = (rig.position = value);
			transform.position = position;
			Transform transform2 = rig.transform;
			Quaternion rotation = (rig.rotation = Quaternion.LookRotation(value2 - value));
			transform2.rotation = rotation;
			OnRightMove(entity);
			vcam.gameObject.SetActive(value: false);
			CreatPathCollider();
			m_PathIndex = stateId;
			base.InitStateObject(stateId);
			CreatEntityCollider();
			if (_robot != null)
			{
				_robotAnimator = _robot.GetComponent<Animator>();
				_robot.SetActive(value: false);
			}
			m_Init = true;
		}
	}

	private void CreatPathCollider()
	{
		for (int i = 0; i < m_Data.orbits.Length; i++)
		{
			Orbit orbit = m_Data.orbits[i];
			m_StartPoint = orbit.start.value;
			m_EndPoint = orbit.end.value;
			m_Dis = (m_EndPoint - m_StartPoint).magnitude;
			m_Dir = m_EndPoint - m_StartPoint;
			GameObject gameObject = new GameObject($"Path:{i + 1}");
			gameObject.transform.parent = pathParentTransform;
			GameObject gameObject2 = new GameObject("collider");
			gameObject2.transform.parent = gameObject.transform;
			gameObject2.transform.rotation = Quaternion.LookRotation(m_Dir);
			gameObject2.transform.position = (m_StartPoint + m_EndPoint) / 2f;
			BoxCollider boxCollider = gameObject2.AddComponent<BoxCollider>();
			boxCollider.size = new Vector3(1f, 0.15f, m_Dis);
			if (m_Data.orbits[i].isJumpDown)
			{
				boxCollider.gameObject.AddComponent<JumpDownLayer>();
			}
		}
	}

	protected override void HandleInitState(int stateId)
	{
	}

	protected override void HandleChangeState(int fromStateId, int toStateId)
	{
	}

	private void OnLeftMove(Entity entity, float pressTime)
	{
		m_NextPos = ((m_Data.pathDir == PathDir.Right) ? m_Data.orbits[PathIndex].start.value : m_Data.orbits[PathIndex].end.value);
		if (_robot != null && _robot.activeSelf)
		{
			HandleRobotRotation((m_Data.pathDir == PathDir.Right) ? _leftDir : _rightDir);
		}
	}

	private void OnRightMove(Entity entity, float pressTime = 0f)
	{
		m_NextPos = ((m_Data.pathDir == PathDir.Right) ? m_Data.orbits[PathIndex].end.value : m_Data.orbits[PathIndex].start.value);
		if (_robot != null && _robot.activeSelf)
		{
			HandleRobotRotation((m_Data.pathDir == PathDir.Right) ? _rightDir : _leftDir);
		}
	}

	private void HandleRobotRotation(Vector3 targetDirection)
	{
		RobotAnimState robotAnimState = m_RobotAnimState;
		if (robotAnimState == RobotAnimState.Flip || robotAnimState == RobotAnimState.WaitingForFlipEnd)
		{
			m_RobotAnimState = RobotAnimState.WaitingForFlipEnd;
			return;
		}
		_robot.transform.localRotation = Quaternion.Lerp(_robot.transform.localRotation, Quaternion.Euler(targetDirection), 1f);
		PlayRobotIdle();
	}

	private void PlayRobotIdle()
	{
		if (_robotAnimator != null)
		{
			_robotAnimator.Play(ANIM_IDLE);
			m_RobotAnimState = RobotAnimState.Idle;
			m_IdleTimer = 0f;
		}
	}

	private void PlayRobotFlip()
	{
		if (_robotAnimator != null)
		{
			_robotAnimator.Play(ANIM_FLIP);
			m_RobotAnimState = RobotAnimState.Flip;
		}
	}

	private void UpdateRobotAnimationWhenIdle()
	{
		if (!(_robot == null) && _robot.activeSelf && !(_robotAnimator == null) && m_RobotAnimState == RobotAnimState.Idle)
		{
			m_IdleTimer += entity.GetCompTime().fixedDeltaTime * GameManager.timeSystem.globalSpeed;
			if (m_IdleTimer >= 3f)
			{
				PlayRobotFlip();
			}
		}
	}

	private void UpdateRobotAnimation()
	{
		if (_robot == null || !_robot.activeSelf || _robotAnimator == null)
		{
			return;
		}
		RobotAnimState robotAnimState = m_RobotAnimState;
		if (robotAnimState != RobotAnimState.WaitingForFlipEnd && robotAnimState != RobotAnimState.Flip)
		{
			return;
		}
		AnimatorStateInfo currentAnimatorStateInfo = _robotAnimator.GetCurrentAnimatorStateInfo(0);
		if (currentAnimatorStateInfo.shortNameHash == ANIM_FLIP && currentAnimatorStateInfo.normalizedTime >= 0.9f)
		{
			CompInput compInput = entity.GetCompInput();
			EInputDir inputDir = compInput.inputDir;
			if (inputDir == EInputDir.Right || inputDir == EInputDir.Left)
			{
				_robot.transform.localRotation = Quaternion.Lerp(_robot.transform.localRotation, Quaternion.Euler((compInput.inputDir == EInputDir.Right) ? _rightDir : _leftDir), 1f);
			}
			PlayRobotIdle();
		}
	}

	private void ResetRobotAnimState()
	{
		m_RobotAnimState = RobotAnimState.Idle;
		m_IdleTimer = 0f;
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		return true;
	}

	protected override void HandleEnterInteract()
	{
		if (!m_interact)
		{
			_mEntry.HandleEnter();
		}
	}

	protected override void HandleExitInteract()
	{
		_mEntry.HandleExit();
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
		if (!eb.IsAlive())
		{
			return;
		}
		entity.GetCompTrigger().SetCanTriggerHiddenRoom(canTriggerHiddenRoom: true);
		ObjectEnableHiddenRoomTriggerEvent evt = Singleton<EventManager>.instance.GetEvt<ObjectEnableHiddenRoomTriggerEvent>();
		evt.collider = collider;
		evt.enable = true;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ObjectEnableHiddenRoomTrigger, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		m_interact = true;
		if (_robot != null)
		{
			_robot.SetActive(value: true);
			HandleRobotRotation((m_Data.pathDir == PathDir.Right) ? _leftDir : _rightDir);
			PlayRobotIdle();
			if (_wifiRoot != null)
			{
				m_WifiGo = PrecacheManager.Instance.GetInstanceHandle(GameLoader.meta.signalReferenceAssetID.GUID);
				m_WifiGo.Completed += WifiGoComplete;
			}
		}
		fixEffect.SetActive(value: true);
		vcam.gameObject.SetActive(value: true);
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_MINETRAINOPERATE, new MineTrainOperateBaseViewData
		{
			entity = entity
		});
		MonoECS.instance.PlayerControlType = MonoECS.ControlType.OreCar;
		eb.GetCompAbility().AddAbilities(m_Data.abilities, AbilitySource.Ability);
		eb.GetCompAbility().onDie += new Action<Entity>(ControllerDie);
		m_Controller = eb;
	}

	private void ControllerDie(Entity eb)
	{
		entity.GetCompInput().dir = Vector2.zero;
		m_interact = false;
		if (_robot != null)
		{
			_robot.SetActive(value: false);
			ResetRobotAnimState();
		}
		vcam.gameObject.SetActive(value: false);
		MonoECS.instance.PlayerControlType = MonoECS.ControlType.Character;
		CompAbility compAbility = MonoECS.instance.mainEntity.GetCompAbility();
		string[] abilities = m_Data.abilities;
		foreach (string text in abilities)
		{
			compAbility.RemoveAbility(text);
		}
		if (m_WifiGo != null)
		{
			robotConnectEffect.SetActive(value: false);
			m_WifiGo.Completed -= WifiGoComplete;
			PrecacheManager.Instance.ReleaseInstanceHandle(m_WifiGo);
			m_WifiGo = null;
		}
		moveRightEffect.SetActive(value: false);
		moveLeftEffect.SetActive(value: false);
		fixEffect.SetActive(value: false);
		eb.GetCompAbility().onDie -= new Action<Entity>(ControllerDie);
		m_Controller = default;
		entity.GetCompTrigger().SetCanTriggerHiddenRoom(canTriggerHiddenRoom: false);
		ObjectEnableHiddenRoomTriggerEvent evt = Singleton<EventManager>.instance.GetEvt<ObjectEnableHiddenRoomTriggerEvent>();
		evt.collider = collider;
		evt.enable = false;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ObjectEnableHiddenRoomTrigger, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		MineTrainOperateBaseView mineTrainOperateBaseView = (MineTrainOperateBaseView)Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_MINETRAINOPERATE);
		if ((bool)mineTrainOperateBaseView && mineTrainOperateBaseView.UIController.State == UIState.Opened)
		{
			Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_MINETRAINOPERATE);
		}
	}

	private void WifiGoComplete(InstanceHandle l)
	{
		GameObject result = l.Result;
		result.transform.SetParent(_wifiRoot, worldPositionStays: false);
		result.transform.localScale = Vector3.one * 0.01f;
		result.transform.rotation = Quaternion.identity;
		robotConnectEffect.SetActive(value: true);
	}

	private void FixedUpdate()
	{
		if (!m_Init || !entity.IsLogicAvailable())
		{
			return;
		}
		CompInput compInput = entity.GetCompInput();
		if (compInput.inputDir == EInputDir.Right || compInput.inputDir == EInputDir.Left)
		{
			m_CurrentTargetPos = InterpolationUtility.FixedLerp(rig.position, m_NextPos, m_Data.speed * entity.GetCompTime().fixedDeltaTime * GameManager.timeSystem.globalSpeed, out var _);
			if (m_CurrentTargetPos == m_NextPos)
			{
				CalculateNextPos();
			}
			Vector3 direction = m_CurrentTargetPos - rig.position;
			if (direction.x != 0f)
			{
				if ((direction.x > 0f && compInput.inputDir == EInputDir.Left) || (direction.x < 0f && compInput.inputDir == EInputDir.Right))
				{
					return;
				}
				if (m_Data.pathDir == PathDir.Right)
				{
					m_CheckPos = ((direction.x > 0f) ? forwardCheckBoxPos : backCheckBoxPos);
				}
				else
				{
					m_CheckPos = ((direction.x < 0f) ? forwardCheckBoxPos : backCheckBoxPos);
				}
				if (Check(direction))
				{
					Velocity = Vector3.zero;
					GameUtility.OpenToolTip(LocalizationCommonData.CommonString.ControllerMoveCheck);
					return;
				}
			}
			rig.MovePosition(m_CurrentTargetPos);
		}
		else
		{
			UpdateRobotAnimationWhenIdle();
		}
		Velocity = rig.velocity;
		if (Velocity != Vector3.zero)
		{
			BaseTip tipDataByTipType = Singleton<TipManager>.instance.GetTipDataByTipType(TIP_TYPE.TIP_COMMONTIP);
			int num = 41000112;
			int num2 = 41000113;
			if (tipDataByTipType != null && tipDataByTipType.GetTipData() is CommonTipData commonTipData && (commonTipData.localizeId == num || commonTipData.localizeId == num2))
			{
				Singleton<TipManager>.instance.EarlyCloseAllTip();
			}
		}
		Vector3 value = m_Data.orbits[PathIndex].start.value;
		Vector3 value2 = m_Data.orbits[PathIndex].end.value;
		rig.transform.rotation = Quaternion.LookRotation(value2 - value);
		UpdateRobotAnimation();
	}

	private bool Check(Vector3 direction)
	{
		Collider[] cacheColliders = PhysicsUtility.cacheColliders;
		int num = Physics.OverlapBoxNonAlloc(m_CheckPos.position + m_Data.CheckDis / 2f * direction.normalized, m_Data.boxSize / 2f, cacheColliders, Quaternion.identity, m_Data.colliderLayer.value);
		bool flag = false;
		for (int i = 0; i < num; i++)
		{
			Collider collider = cacheColliders[i];
			StateObjectBase componentInParent = collider.GetComponentInParent<StateObjectBase>();
			if (componentInParent != null && componentInParent.entity.IsLogicAvailable())
			{
				if (componentInParent == this)
				{
					continue;
				}
				bool flag2 = false;
				StateWorldUid[] ignoreStateWorldUids = m_Data.IgnoreStateWorldUids;
				foreach (StateWorldUid stateWorldUid in ignoreStateWorldUids)
				{
					if (componentInParent.swid == stateWorldUid.value)
					{
						flag2 = true;
						break;
					}
				}
				if (!flag2)
				{
					flag = true;
					break;
				}
			}
			else
			{
				flag = this.collider != collider;
				if (flag)
				{
					break;
				}
			}
		}
		PhysicsUtility.Release(cacheColliders);
		return flag;
	}

	private void CalculateNextPos()
	{
		if (m_NextPos == m_Data.orbits[PathIndex].start)
		{
			if (PathIndex == 0)
			{
				m_NextPos = m_Data.orbits[PathIndex].start.value;
				GameUtility.OpenToolTip(LocalizationCommonData.CommonString.ControllerMoveEnd);
			}
			else
			{
				PathIndex--;
				m_NextPos = m_Data.orbits[PathIndex].start.value;
			}
		}
		if (m_NextPos == m_Data.orbits[PathIndex].end.value)
		{
			if (PathIndex == m_Data.orbits.Length - 1)
			{
				m_NextPos = m_Data.orbits[PathIndex].end.value;
				GameUtility.OpenToolTip(LocalizationCommonData.CommonString.ControllerMoveEnd);
			}
			else
			{
				PathIndex++;
				m_NextPos = m_Data.orbits[PathIndex].end.value;
			}
		}
	}

	public override void ReleaseStateObject()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Input_ExitStateObjectControl, ExitInteract);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Controller_ChangeState, ChangeControllerEvt);
		m_Controller = default;
		base.ReleaseStateObject();
		_mEntry.HandleExit();
	}

	private void ExitInteract(BaseEventContent obj)
	{
		if (!m_Controller.IsValid)
		{
			return;
		}
		MineTrainOperateBaseView mineTrainOperateBaseView = (MineTrainOperateBaseView)Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_MINETRAINOPERATE);
		if ((bool)mineTrainOperateBaseView && mineTrainOperateBaseView.UIController.State == UIState.Opened)
		{
			entity.GetCompInput().dir = Vector2.zero;
			m_interact = false;
			Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_MINETRAINOPERATE);
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEMAIN);
			if (_robot != null)
			{
				_robot.SetActive(value: false);
				ResetRobotAnimState();
			}
			vcam.gameObject.SetActive(value: false);
			MonoECS.instance.PlayerControlType = MonoECS.ControlType.Character;
			CompAbility compAbility = MonoECS.instance.mainEntity.GetCompAbility();
			string[] abilities = m_Data.abilities;
			foreach (string text in abilities)
			{
				compAbility.RemoveAbility(text);
			}
			if (m_WifiGo != null)
			{
				robotConnectEffect.SetActive(value: false);
				m_WifiGo.Completed -= WifiGoComplete;
				PrecacheManager.Instance.ReleaseInstanceHandle(m_WifiGo);
				m_WifiGo = null;
			}
			moveRightEffect.SetActive(value: false);
			moveLeftEffect.SetActive(value: false);
			fixEffect.SetActive(value: false);
			entity.GetCompTrigger().SetCanTriggerHiddenRoom(canTriggerHiddenRoom: false);
			ObjectEnableHiddenRoomTriggerEvent evt = Singleton<EventManager>.instance.GetEvt<ObjectEnableHiddenRoomTriggerEvent>();
			evt.collider = collider;
			evt.enable = false;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ObjectEnableHiddenRoomTrigger, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			if (target != null && target.entity.IsAlive())
			{
				_mEntry.HandleEnter();
			}
			m_Controller.GetCompAbility().onDie -= new Action<Entity>(ControllerDie);
			m_Controller = default;
		}
	}

	private void ChangeControllerEvt(BaseEventContent obj)
	{
		ChangeControllerStateEvt changeControllerStateEvt = (ChangeControllerStateEvt)obj;
		if (swid == changeControllerStateEvt.swid && changeControllerStateEvt.state >= 0 && changeControllerStateEvt.state < m_Data.orbits.Length)
		{
			PathIndex = changeControllerStateEvt.state;
			Vector3 value = m_Data.orbits[PathIndex].start.value;
			Vector3 value2 = m_Data.orbits[PathIndex].end.value;
			Transform transform = rig.transform;
			Vector3 position = (rig.position = value);
			transform.position = position;
			Transform transform2 = rig.transform;
			Quaternion rotation = (rig.rotation = Quaternion.LookRotation(value2 - value));
			transform2.rotation = rotation;
		}
	}

	protected override InteractEntry GetInteractEntry()
	{
		return _mEntry;
	}

	private void CreatEntityCollider()
	{
		collider.GetComponent<MonoEntity>().SetEB(entity);
	}
}
