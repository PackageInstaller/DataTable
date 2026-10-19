using ACT.Drama;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class SystemTeleportMove : EntitySystem
{
	private const string TeleportExitLoop = "TeleportExitLoop";

	private const float InteractExitSitLoopTime = 2.5f;

	private const float RespawnAndTpMoveExitSitLoopTime = 1f;

	private bool _enter;

	private bool _entering;

	private float _exitSitLoopCountdown;

	private bool _exitSitLoopTriggered;

	public override Filter MajorFilter { get; }

	protected override void OnCreate()
	{
	}

	public override void FixedUpdate()
	{
		if (_enter)
		{
			UpdateEnteredTeleportMove();
		}
		else
		{
			TryEnterTeleportMove();
		}
	}

	public void TryEnterTeleportMove()
	{
		if (!_enter && !_entering && !(MonoECS.instance == null) && !InOtherLogic())
		{
			if (MonoECS.instance.InPlayerTag(MonoECS.PlayerTag.TeleportMove))
			{
				EnterTeleportMove(respawnAndTpMove: false);
			}
			else if (MonoECS.instance.InPlayerTag(MonoECS.PlayerTag.TeleportRespawnAndTpMove))
			{
				EnterTeleportMove(respawnAndTpMove: true);
			}
		}
	}

	private void UpdateEnteredTeleportMove()
	{
		if (MonoECS.instance == null)
		{
			return;
		}
		if (!MonoECS.instance.HasAnyPlayerTag(MonoECS.PlayerTag.TeleportMove | MonoECS.PlayerTag.TeleportRespawnAndTpMove))
		{
			_enter = false;
			ResetTimelineParams();
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEMAIN);
			Singleton<InteractiveDialogueManager>.instance.DispatchTriggerInteractiveDialogue(1004);
		}
		else
		{
			if (_exitSitLoopTriggered)
			{
				return;
			}
			Entity mainEntity = MonoECS.instance.mainEntity;
			if (mainEntity.IsValid && mainEntity.TryGetCompTime(out CompTime component) && component != null && mainEntity.TryGetCompMotion(out CompMotion component2) && component2 != null)
			{
				_exitSitLoopCountdown -= component.fixedDeltaTime;
				if (_exitSitLoopCountdown <= 0f)
				{
					ExitTeleportSitLoop(component2);
					_exitSitLoopTriggered = true;
				}
			}
		}
	}

	private void EnterTeleportMove(bool respawnAndTpMove)
	{
		_entering = true;
		try
		{
			if (!TrySetTimelineParams())
			{
				return;
			}
			_exitSitLoopCountdown = (respawnAndTpMove ? 1f : 2.5f);
			_exitSitLoopTriggered = false;
			if (respawnAndTpMove)
			{
				Singleton<TeleportMoveManager>.instance.PlayRespawnAndTpMoveTimeline();
			}
			else
			{
				Singleton<TeleportMoveManager>.instance.PlayInteractTimeline();
			}
			MonoECS instance = MonoECS.instance;
			if (((instance != null) ? instance.mainEntity : default(Entity)).TryGetCompPhysics(out CompPhysics component) && component != null)
			{
				if (respawnAndTpMove)
				{
					component.RespawnEnterTeleportSitLoop();
				}
				else
				{
					component.EnterTeleportSitDown();
				}
			}
			_enter = true;
		}
		catch
		{
			ResetTimelineParams();
			throw;
		}
		finally
		{
			_entering = false;
		}
	}

	private bool InOtherLogic()
	{
		if ((Model<GuideModel>.HasInstance() && Model<GuideModel>.Interface.IsInStrongGuide()) || Singleton<ConversationManager>.instance.IsPlaying)
		{
			return true;
		}
		return !Singleton<GameState>.instance.CanEnterPlayerOperation(MonoECS.PlayerTag.TeleportMove | MonoECS.PlayerTag.TeleportRespawnAndTpMove, MonoECS.PlayerTag.TeleportMove | MonoECS.PlayerTag.TeleportRespawnAndTpMove);
	}

	private void ExitTeleportSitLoop(CompMotion compMotion)
	{
		compMotion.SetTrigger("TeleportExitLoop");
	}

	private bool TrySetTimelineParams()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (!mainEntity.IsValid || !mainEntity.TryGetCompBehave(out CompBehave component) || component?.EntityTags == null || !mainEntity.TryGetCompMotion(out CompMotion component2) || component2 == null || !mainEntity.TryGetCompTime(out CompTime component3) || component3 == null || !mainEntity.TryGetCompPhysics(out CompPhysics component4) || component4 == null)
		{
			return false;
		}
		EntityTags entityTags = component.EntityTags;
		entityTags.AddTag(EntityTag.IgnoreAttack);
		entityTags.AddTag(EntityTag.IgnoreTrap);
		entityTags.AddTag(EntityTag.UnHatable);
		entityTags.AddTag(EntityTag.SystemControl);
		Singleton<GameManager>.instance.ecsManager.systemMonster.ClearAllMonsterHatredAndHide();
		Singleton<NewUIManager>.instance.CloseAllUI();
		MonoECS.instance.ClearMainEntityInput();
		component2.ResetTrigger(component2.lastConflictTrigger);
		MonoECS.instance.SetPlayerTag(MonoECS.PlayerTag.Timeline);
		component2.SetBool("InTimeline", b: true);
		GameUtility.SetCameraLayerDialog(isTimeline: true);
		GameUtility.TriggerTeleportPoint();
		return true;
	}

	private void ResetTimelineParams()
	{
		MonoECS instance = MonoECS.instance;
		Entity entity = ((instance != null) ? instance.mainEntity : default(Entity));
		if (entity.TryGetCompBehave(out CompBehave component) && component?.EntityTags != null)
		{
			EntityTags entityTags = component.EntityTags;
			entityTags.RemoveTag(EntityTag.IgnoreAttack);
			entityTags.RemoveTag(EntityTag.IgnoreTrap);
			entityTags.RemoveTag(EntityTag.UnHatable);
			entityTags.RemoveTag(EntityTag.SystemControl);
		}
		Singleton<GameManager>.instance.ecsManager.systemMonster.ShowAllMonsterRenderer();
		instance?.RemovePlayerTag(MonoECS.PlayerTag.Timeline);
		if (entity.TryGetCompMotion(out CompMotion component2))
		{
			component2?.SetBool("InTimeline", b: false);
		}
		GameUtility.SetCameraLayerDialog(isTimeline: false);
	}
}
