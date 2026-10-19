using ACT.Battle.Configs;
using ACT.Event;
using ACT.EventTrack;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityReCall : BaseAbilityMixin
{
	private ConfigMixinReCall m_Config;

	private Vector3 m_TargetPos;

	private bool m_IsStartTp;

	private float _waitTime;

	public AbilityReCall(ConfigMixinReCall config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
		_waitTime = config.waitTime;
	}

	private void TP(BaseEventContent obj)
	{
		owner.GetCompAbility()?.RemoveAbility(m_Config.name);
	}

	internal override void OnAdd()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_TP, TP);
		CompStateObject compStateObject = caster.GetCompStateObject();
		if (!(compStateObject?.StateWorldAssetData is LaserData { isReCall: false }) && owner.GetEntityType() == EntityType.Character)
		{
			CompPhysics? compPhysics = owner.GetCompPhysics();
			if (!owner.TryGetCompAbility(out CompAbility component) || !component.HasAbility("Rogueability_list_assistSkill_wudi"))
			{
				MonoECS.instance.PushPauseAllInput();
				Singleton<NewUIManager>.instance.SetBlackFadeState(activeState: true, 0.5f).Forget();
			}
			if (m_Config.onAddList != null)
			{
				DoActions(owner, null, m_Config.onAddList);
			}
			ExitStateObjectControlEvt evt = Singleton<EventManager>.instance.GetEvt<ExitStateObjectControlEvt>();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_ExitStateObjectControl, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			compPhysics.characterMovement.velocity = Vector3.zero;
			compPhysics.rawVelocity = Vector3.zero;
			compPhysics.characterMovement.detectCollisions = false;
			m_TargetPos = TeleportUtility.GetRecallPosition();
			m_IsStartTp = true;
			_waitTime = m_Config.waitTime;
		}
		MovementEvent evt2 = EventTrackSolver.Instance.GetEvt<MovementEvent>();
		evt2.eventType = 4;
		evt2.swid = compStateObject?.StateWorldAssetData?.stateWorldAssetUid ?? (-1);
		evt2.pos = caster.GetCompTransform().physicsPosition;
		EventTrackSolver.Instance.Dispatch(evt2);
		RecallEvt evt3 = Singleton<EventManager>.instance.GetEvt<RecallEvt>();
		evt3.checkPointUID = MonoECS.instance.checkPointManager.GetCurrentSceneInfo().CheckPosUid;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Recall, evt3);
		Singleton<EventManager>.instance.ReleaseEvt(evt3);
		Model<RaidModel>.Interface.ParkourTrapTimes++;
	}

	internal override void Update()
	{
		if (!owner.GetMono().enabled)
		{
			owner.GetCompPhysics().characterMovement.detectCollisions = true;
		}
	}

	internal override void FixedUpdate()
	{
		CompTransform compTransform = owner.GetCompTransform();
		CompAbility compAbility = owner.GetCompAbility();
		CompPhysics compPhysics = owner.GetCompPhysics();
		CompTime compTime = owner.GetCompTime();
		_waitTime -= compTime.fixedDeltaTime;
		if (_waitTime <= 0f)
		{
			if (!owner.IsValid)
			{
				return;
			}
			if (m_IsStartTp)
			{
				compTransform.UpdatePosition(m_TargetPos);
				compPhysics.SetConstZ(m_TargetPos.z);
				compAbility.RemoveAbility(m_Config.name);
			}
		}
		if (m_IsStartTp && Mathf.Approximately(compTime.fixedDeltaTime, 0f))
		{
			compTransform.SetPositionImmediately(m_TargetPos);
			compPhysics.SetConstZ(m_TargetPos.z);
			compAbility.RemoveAbility(m_Config.name);
		}
	}

	internal override void OnRemove()
	{
		RemoveAction();
	}

	internal override void OnSilentRemove()
	{
		RemoveAction();
	}

	private void RemoveAction()
	{
		m_IsStartTp = false;
		if (owner.IsLogicAvailable())
		{
			if (m_Config.onRemoveList != null)
			{
				DoActions(owner, null, m_Config.onRemoveList);
			}
			MonoECS.instance.SyncGameInfos();
			owner.SetBool("reCalling", value: false);
			owner.GetCompPhysics().characterMovement.detectCollisions = true;
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_TP, TP);
			GameManager.cameraSystem.CameraTp(m_TargetPos);
			MonoECS.instance.PopPauseAllInput();
			Singleton<NewUIManager>.instance.SetBlackFadeState(activeState: false, 0.5f).Forget();
		}
	}
}
