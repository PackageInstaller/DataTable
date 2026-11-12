using Nova.Hotfix;
using TrueSync;
using UnityEngine;

namespace AIScript.Prologue;

public class SimpleMonsterAdventrueActor : MonsterAdventureActor
{
	public static int actorSpeedHash = Animator.StringToHash("speed");

	public static int stage2Hash = Animator.StringToHash("stage2");

	public FP moveSpd = 1;

	public FP moveAcceleration = 90;

	public AdventureFXPlayer fxPlayer;

	protected override void OnInit()
	{
		base.OnInit();
	}

	protected override void OnActive()
	{
		base.OnActive();
		_smooth.OnActive();
		Nova.Hotfix.Monster monster = Singleton<HotfixDataController>.Instance.GetMonster(PrologueConfig.monsterId);
		MonsterSkin monsterSkin = Singleton<HotfixDataController>.Instance.GetMonsterSkin(monster.FAId);
		spawnerInfo.level = 1;
		LoadData(monster, monsterSkin, new ActorSpawnInfo
		{
			isRoguelikeMonster = true
		});
		fxPlayer = transform.Find("Root/Bone008/_FX/fx_loop_90015")?.GetComponent<AdventureFXPlayer>();
	}

	public override void LoadData(Nova.Hotfix.Monster data, MonsterSkin skin, ActorSpawnInfo actorSpawnInfo, bool isSummonMonster = false, SummonCfg cfg = null)
	{
		base.LoadData(data, skin, actorSpawnInfo, isSummonMonster, cfg);
		actorInfo.moveAcceleration = moveAcceleration;
		SetSpeed(moveSpd);
	}

	protected override void InitializeMovementBehaviour()
	{
		_movementFSM = new SimpleActorMovementFSM(gameObject);
		_movementFSM.RegistState(new ActorStandbyState());
		_movementFSM.RegistState(new ActorMoveState());
		_movementFSM.RegistState(new ActorJumpState());
		_movementFSM.RegistState(new ActorDashState());
		_movementFSM.RegistState(new ActorDodgeState());
		(_movementFSM as SimpleActorMovementFSM).isOverride = true;
	}

	public override void OnPlayIdleAnim()
	{
	}

	protected override void OnLogicStart()
	{
		base.OnLogicStart();
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
	}

	public void SetSpeed(FP speed)
	{
		actorInfo.walkSpeed = speed;
		actorInfo.runSpeed = speed;
		RefreshMoveSpeed();
	}

	public override void Recycle()
	{
	}

	public void ShowSelf(bool flage)
	{
		if (flage)
		{
			Visible();
			fxPlayer?.Play();
		}
		else
		{
			Hide();
			fxPlayer?.Stop();
		}
	}

	protected override void SetupVisualComponents(float visibleRadius, float visibleHeight)
	{
		base.SetupVisualComponents(visibleRadius, visibleHeight);
		if (visualControl != null && visualControl.interactiveEnvPawn != null)
		{
			visualControl.interactiveEnvPawn.enabled = false;
		}
	}
}
