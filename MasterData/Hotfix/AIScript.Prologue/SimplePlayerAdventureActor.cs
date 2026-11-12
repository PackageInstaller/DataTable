using System;
using System.Collections;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.Playables;

namespace AIScript.Prologue;

public class SimplePlayerAdventureActor : PlayerAdventureActor
{
	public static int actorSpeedHash = Animator.StringToHash("speed");

	public static int stage1Hash = Animator.StringToHash("stage1");

	public static int stage2Hash = Animator.StringToHash("stage2");

	public static int stage3Hash = Animator.StringToHash("stage3");

	public static int stage4Hash = Animator.StringToHash("stage4");

	private string walkSound = "desert_walk";

	private string walkSound1 = "desert_walk1";

	private string runSound = "desert_run";

	public FP moveSpd = 1;

	public FP moveAcceleration = 90;

	public bool IsFixedMoveDir;

	public TSVector2 FixedMoveDir;

	public bool forceStandBy;

	public bool IsManualMove = true;

	private GameObject weaponL;

	private GameObject weaponR;

	private GameObject weaponL_Lod;

	private GameObject weaponR_Lod;

	private GameObject phone;

	private FP orginalDeceleration;

	private FP orginalWalkSpeed;

	private FP orginalRunSpeed;

	public FP animMaxSpd;

	private int stageIndex = 1;

	public bool isOverride;

	protected override void OnInit()
	{
		base.OnInit();
		weaponL = transform.Find("weapon_L").gameObject;
		weaponR = transform.Find("weapon_R").gameObject;
		weaponL_Lod = transform.Find("weapon_L_lod").gameObject;
		weaponR_Lod = transform.Find("weapon_R_lod").gameObject;
		phone = transform.Find("phone").gameObject;
		AddTag(CommonHelper.StringToHash("SimplePlayer"));
	}

	protected override void OnActive()
	{
		base.OnActive();
		_smooth.OnActive();
		Nova.Hotfix.Character character = Singleton<HotfixDataController>.Instance.GetCharacter(PrologueConfig.actorId);
		CharacterSkin characterSkin = Singleton<HotfixDataController>.Instance.GetCharacterSkin(character.DefaultSkinId);
		LoadData(character, characterSkin);
		SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor = this;
		actorHealthInfo.isAlive = true;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_INPUT_ACTION_BUTTON_OPERATE", OnPlayerInput);
		LoadExtendAnimation();
	}

	public override void LoadData(Nova.Hotfix.Character data, CharacterSkin skinInfo)
	{
		base.LoadData(data, skinInfo);
		SetActorOperateType(assist: false);
		orginalDeceleration = actorInfo.moveAcceleration;
		orginalWalkSpeed = actorInfo.walkSpeed;
		orginalRunSpeed = actorInfo.runSpeed;
		actorInfo.moveAcceleration = moveAcceleration;
		actorInfo.walkSpeed = moveSpd;
		actorInfo.runSpeed = moveSpd;
		ammoInfo.isNoCostAmmo = true;
		enableReload = false;
	}

	protected override void InitializeMovementBehaviour()
	{
		_movementFSM = new SimpleActorMovementFSM(gameObject);
		_movementFSM.RegistState(new ActorStandbyState());
		_movementFSM.RegistState(new ActorMoveState());
		_movementFSM.RegistState(new ActorJumpState());
		_movementFSM.RegistState(new ActorDashState());
		_movementFSM.RegistState(new ActorDodgeState());
	}

	protected override void RegisterActionState(string fcAction)
	{
		switch (actorInfo.searchType)
		{
		case HotfixEnum.characterSearchTargetType.MELEE:
			searchType = PlayerActorSearchType.Melee;
			moveControlType = PlayerActorMoveType.Melee;
			enableReload = false;
			break;
		case HotfixEnum.characterSearchTargetType.RANGED:
			searchType = PlayerActorSearchType.Range;
			moveControlType = PlayerActorMoveType.Range;
			enableReload = true;
			break;
		default:
			throw new ArgumentOutOfRangeException();
		}
		_actionState = new SimplePlayerActionState();
		_primeFSM.RegistState(_actionState, fcAction);
	}

	public void SwithFSM(bool isOverride)
	{
		(_movementFSM as SimpleActorMovementFSM).isOverride = isOverride;
		(_actionState as SimplePlayerActionState).isOverride = isOverride;
		if (isOverride)
		{
			actorInfo.moveAcceleration = moveAcceleration;
			actorInfo.walkSpeed = moveSpd;
			actorInfo.runSpeed = moveSpd;
		}
		else
		{
			actorInfo.moveAcceleration = orginalDeceleration;
			actorInfo.walkSpeed = orginalWalkSpeed;
			actorInfo.runSpeed = orginalRunSpeed;
		}
	}

	public override void LevelStart()
	{
		base.LevelStart();
		Action();
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
		if (TSMath.Abs(actorInfo.walkSpeed - speed) > FP.Epsilon)
		{
			actorInfo.walkSpeed = speed;
			actorInfo.runSpeed = speed;
			RefreshMoveSpeed();
		}
	}

	public void HidePhone()
	{
		phone.SetActive(value: false);
	}

	public void SetAnimMaxSpd(FP speed)
	{
		animMaxSpd = speed;
	}

	public void TriggerStage(int stage)
	{
		animatorController.SetBool(stage1Hash, stage == 1, isSecCtr: true);
		animatorController.SetBool(stage2Hash, stage == 2, isSecCtr: true);
		animatorController.SetBool(stage3Hash, stage == 3, isSecCtr: true);
		animatorController.SetBool(stage4Hash, stage == 4, isSecCtr: true);
		stageIndex = stage;
		Debug.Log($"==>进入阶段:{stage}");
	}

	public void SwithAnimationGroup()
	{
		ReplaceAnimationGroup(1);
	}

	public void SwithToUnBattle(float fadeTime)
	{
		isOverride = true;
		weaponL.SetActive(value: false);
		weaponL_Lod.SetActive(value: false);
		weaponR.SetActive(value: false);
		weaponR_Lod.SetActive(value: false);
		StartCoroutine(Fade(fade: true, fadeTime));
		SwithFSM(isOverride: true);
	}

	public void SwithToBattle(float fadeTime)
	{
		isOverride = false;
		weaponL.SetActive(value: true);
		weaponL_Lod.SetActive(value: true);
		weaponR.SetActive(value: true);
		weaponR_Lod.SetActive(value: true);
		StartCoroutine(Fade(fade: false, fadeTime));
		SwithFSM(isOverride: false);
	}

	private IEnumerator Fade(bool fade, float fadeTime)
	{
		float time = fadeTime;
		while (time > 0f)
		{
			time -= Time.deltaTime;
			if (time < 0f)
			{
				time = 0f;
			}
			if (fade)
			{
				animatorController.MixerCtr.SetInputWeight(0, time / fadeTime);
				animatorController.MixerCtr.SetInputWeight(1, 1f - time / fadeTime);
			}
			else
			{
				animatorController.MixerCtr.SetInputWeight(0, 1f - time / fadeTime);
				animatorController.MixerCtr.SetInputWeight(1, time / fadeTime);
			}
			yield return null;
		}
	}

	public override void PlaySound(string eventName)
	{
		if (!isOverride)
		{
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound(eventName, gameObject);
		}
		else if (stageIndex == 1)
		{
			if ((double)animatorController.GetFloat(actorSpeedHash, isSecCtr: true) < 0.7)
			{
				if (!eventName.Equals(walkSound1))
				{
					MonoSingleton<WwiseAudioManager>.Instance.PlaySound(eventName, gameObject);
				}
			}
			else if (!eventName.Equals(walkSound))
			{
				MonoSingleton<WwiseAudioManager>.Instance.PlaySound(eventName, gameObject);
			}
		}
		else if (stageIndex == 2)
		{
			if ((double)animatorController.GetFloat(actorSpeedHash, isSecCtr: true) < 0.25)
			{
				if (!eventName.Equals(runSound))
				{
					MonoSingleton<WwiseAudioManager>.Instance.PlaySound(eventName, gameObject);
				}
			}
			else if (!eventName.Equals(walkSound))
			{
				MonoSingleton<WwiseAudioManager>.Instance.PlaySound(eventName, gameObject);
			}
		}
		else
		{
			MonoSingleton<WwiseAudioManager>.Instance.PlaySound(eventName, gameObject);
		}
	}

	public override void Recycle()
	{
	}
}
