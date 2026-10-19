using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.Timeline;
using ACT.Utility;
using AOT.Animation;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;

namespace ACT.Battle;

public class SystemBehave : EntitySystem
{
	public const string WAIST = "waist";

	public const string GROUND_DISTANCE = "GroundDistance";

	public const string FALLING_Time = "FallingTime";

	public const string FALL = "Fall";

	public const string ONGROUND = "OnGround";

	public const string DIR_NONE = "DirNone";

	public const string DIR_LEFT = "DirLeft";

	public const string DIR_RIGHT = "DirRight";

	public const string DIR_OP = "DirOp";

	public const string DIR_UP = "DirUp";

	public const string DIR_DOWN = "DirDown";

	public const string JUMP = "Jump";

	public const string JUMPP = "JumpPress";

	public const string JUMPR = "JumpRelease";

	public const string DODGE = "Dodge";

	public const string DODGEC = "DodgeClick";

	public const string DODGEP = "DodgePress";

	public const string DODGER = "DodgeRelease";

	public const string WEAPON1 = "ButtonA";

	public const string WEAPON1C = "ButtonAClick";

	public const string WEAPON1P = "ButtonAPress";

	public const string WEAPON1PTRIGGER = "ButtonAPressTrigger";

	public const string WEAPON1R = "ButtonARelease";

	public const string WEAPON2 = "ButtonB";

	public const string WEAPON2C = "ButtonBClick";

	public const string WEAPON2P = "ButtonBPress";

	public const string WEAPON2PTRIGGER = "ButtonBPressTrigger";

	public const string WEAPON2R = "ButtonBRelease";

	public const string WEAPON1PRESS_REC = "ButtonAPressRec";

	public const string WEAPON2PRESS_REC = "ButtonBPressRec";

	public const string JumpHold = "JumpHold";

	public const string DodgeHold = "DodgeHold";

	public const string ButtonAHold = "ButtonAHold";

	public const string ButtonBHold = "ButtonBHold";

	public const string ButtonU = "ButtonU";

	public const string ButtonUClick = "ButtonUClick";

	public const string ButtonUHold = "ButtonUHold";

	public const string ButtonUPress = "ButtonUPress";

	public const string ButtonURelease = "ButtonURelease";

	public const string ULTRA = "Skill";

	public const string ULTRASTATE = "UltraState";

	public const string MOVE = "Move";

	public const string FlyMove = "FlyMove";

	public const string JUMPUPTRAMPOLINE = "JumpUpTrampoline";

	public const string IN_AIR = "InAir";

	public const string FACE_LEFT = "FaceLeft";

	public const string VX = "Vx";

	public const string VY = "Vy";

	public const string ABSVX = "AbsVx";

	public const string ABSVY = "AbsVy";

	public const string BeCarryed = "BeCarryed";

	public const string IS_HITTING = "is_hitting";

	public const string HIT = "Hit";

	public const string HITTING = "Hitting";

	public const string HIT_LEVEL = "HitLevel";

	public const string EXPRESSIVE_ANGLE = "ExpressiveAngle";

	public const string HIT_LIGHT = "HitLight";

	public const string HIT_BACK = "HitBack";

	public const string HIT_ANGLE = "HitAngle";

	public const string HIT_SPEED = "HitSpeed";

	public const string HIT_SPEEDX = "HitSpeedX";

	public const string HIT_SPEEDY = "HitSpeedY";

	public const string HIT_GROUNDPROTECTION = "HitGroundProtection";

	public const string HIT_PART1 = "HitPart1";

	public const string HIT_PART2 = "HitPart2";

	public const string HIT_PART3 = "HitPart3";

	public const string HIT_PART4 = "HitPart4";

	public const string HIT_PART5 = "HitPart5";

	public const string IS_WEAK_STATE = "is_weak_state";

	public const string CHANGE_DIR = "ChangeDir";

	public const string IS_POSTURE_BREAK = "IsPostureBreak";

	public const string IS_BREAK = "IsBreak";

	public const string IS_WEAK = "IsWeak";

	public const string POSTURE_BREAK = "PostureBreak";

	public const string DIE = "Die";

	public const string TRAP_DIE = "trap_die";

	public const string IS_DEAD = "IsDead";

	public const string FEIGNEDDIE = "FeignedDie";

	public const string IS_FEIGNEDDIE = "IsFeignedDie";

	public const string CLIMB = "Climb";

	public const string ISCLIMBSTATE = "IsClimbState";

	public const string BACKTRACE_BEGIN = "backtraceBegin";

	public const string RECALLING = "reCalling";

	public const string CLIMB_OVER = "ClimbOver";

	public const string CLIMB_EXIT = "ClimbExit";

	public const string OPEN_BOX = "OpenBox";

	public const string CARRY_OVER = "CarryOver";

	public const string STEP_ON = "StepOn";

	public const string HANG_ON = "HangOn";

	public const string CLIMB_COMPENSATE = "ClimbCompensate";

	public const string RUN_DURATION = "RunDuration";

	public const string BORN_LEFT = "born_left";

	public const string SKILL_INDEX = "SkillIndex";

	public const string USE_SKILL = "UseSkill";

	public const string MOVE_FRONT = "move_front";

	public const string MOVE_BACK = "move_back";

	public const string OutMove = "move_out";

	public const string Enemy_Turn = "turn";

	public const string Enemy_Turn_2_LEFT = "turn_to_left";

	public const string Enemy_Turn_2_RIGHT = "turn_to_right";

	public const string Use_Walk = "useWalk";

	public const string CHANGECHARACTER0 = "changeCharacter0";

	public const string CHANGECHARACTER1 = "changeCharacter1";

	public const string CHANGECHARACTER2 = "changeCharacter2";

	public const string SWITCHIN = "switchIn";

	public const string IS_CONTROLLED = "isControlled";

	public const string IS_ACTIVE = "isActive";

	public const string ADSORB_JUMP = "AdsorbJump";

	public const string ADSORB_ENTER = "AdsorbEnter";

	public const string FORBIDUP = "ForbidUp";

	public const string ADSORB_OVER = "AdsorbOver";

	public const string WALL_CHECK = "WallCheck";

	public const string WALL_CLIMB = "WallClimb";

	public const string WALL_MUST_LEAVE = "WallMustLeave";

	public const string NEED_LEAVA_WALL_CLIMB_BY_INPUT = "NeedLeaveWallClimbByInput";

	private const int MAX_STATE_TRANSITION_DEPTH = 128;

	public const string GLIDE = "Glide";

	public const string UPDRAFT = "Updraft";

	public const string SWITCHSKILLCD = "switchSkillCD";

	public const string BATTLESTATE = "battleState";

	public const string WEAPONANIMEXIT = "weaponAnimExit";

	public const string IS_AIR_ATTACKED = "IsAirAttacked";

	public const string AIR_ATTACK_A = "airAttackA";

	public const string DODGEINAIRCOUNT = "dodgeInAirCount";

	public const string JUMPINAIRCOUNT = "jumpInAirCount";

	public const string HEAVY_PUNCH = "heavyPunch";

	public const string MUST_HIT_ON_WALL = "mustHitOnWall";

	public const string CAN_HIT_ON_WALL = "canHitOnWall";

	public const string HIT_ON_WALL = "hitOnWall";

	public const string HOOK = "hook";

	public const string HOOK_HORIZONTAL = "Hook_Horizontal";

	public const string HOOK_DOWN = "Hook_Down";

	public const string HOOKING = "hooking";

	public const string HOOK_OVER = "hookOver";

	public const string HOOK_TRANSFER = "hookTransfer";

	public const string SPRING_ENTER = "springEnter";

	public const string SPRING_OVER = "springOver";

	public const string MOTIONFORBIDULTRA = "MotionForbidUltra";

	public const string MOTIONFORBIDDODGEANDGRAB = "MotionForbidDodgeAndGrab";

	public const string MOTIONFORBIDJUMP = "MotionForbidJump";

	public const string MOTIONFORBIDWEAPON1 = "MotionForbidWeapon1";

	public const string MOTIONFORBIDWEAPON2 = "MotionForbidWeapon2";

	public const string ASSIST_REMAIN = "assistRemain";

	public const string AIRAINDEX = "AirAnum";

	public const string NORMALENERGYVALUE = "normalEnergy";

	public const string SPECIALENERGYVALUE = "specialEnergy";

	public const string JUMPDOWN = "jumpDown";

	public const string FREEZE = "Freeze";

	public const string InTimeline = "InTimeline";

	public const string NPC_PANIC = "StartPanic";

	public const string ULTRAENERGYVALUE = "ultraEnergy";

	public const string TeleportSitDown = "TeleportSitDown";

	public const string TeleportExitMove = "TeleportExitMove";

	public const string TeleportExitLoop = "TeleportExitLoop";

	public const string SystemControl = "SystemControl";

	public const string ForbidGlide = "ForbidGlide";

	public const string StopPathMove = "StopPathMove";

	public const string Change = "Change";

	public const string Born = "born";

	public const string BornC = "born_c";

	public static string[] ConflictTriggers = new string[11]
	{
		"Jump", "Dodge", "Glide", "ButtonA", "ButtonB", "changeCharacter0", "changeCharacter1", "changeCharacter2", "ButtonU", "ButtonAPressTrigger",
		"ButtonBPressTrigger"
	};

	public static string[] InstantResetTriggers = new string[47]
	{
		"Hit", "HitLevel", "ButtonARelease", "ButtonAClick", "ButtonBRelease", "ButtonBClick", "StepOn", "HangOn", "JumpUpTrampoline", "DodgeRelease",
		"DodgeClick", "Fall", "ClimbExit", "ClimbOver", "ClimbCompensate", "PostureBreak", "HitLight", "switchIn", "Climb", "AdsorbJump",
		"AdsorbEnter", "AdsorbOver", "OpenBox", "Skill", "heavyPunch", "JumpRelease", "hookOver", "hook", "HitGroundProtection", "ChangeDir",
		"springEnter", "springOver", "jumpDown", "backtraceBegin", "ButtonURelease", "ButtonUClick", "TeleportSitDown", "TeleportExitMove", "TeleportExitLoop", "NeedLeaveWallClimbByInput",
		"WallMustLeave", "HitPart1", "HitPart2", "HitPart3", "HitPart4", "HitPart5", "StopPathMove"
	};

	public static string[] InstantRestBool = new string[6] { "ButtonAPress", "ButtonBPress", "ButtonAHold", "ButtonBHold", "ButtonUPress", "ButtonUHold" };

	private Dictionary<ConfigMotionStateMachine, StateController> m_StateControllers;

	public ObjectPool<FSMRuntimeState> motionStatePool;

	private HashSet<string> m_UsedTriggers;

	public Action AnimatorEnqueue;

	private Filter _filter;

	private Filter _onRemoveFilter;

	private EntityAction<CompBehave> _checkToReleaseAction;

	private EntityAction<CompBehave, CompMotion, CompTime, CompAbility> _fixedUpdateBehaveAction;

	private EntityAction<CompMotion, CompTime> _updateBehaveAction;

	private float m_lerpP;

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompTransform, CompTime, CompInput, CompMotion, CompPhysics, CompEffect>().Build();
		_onRemoveFilter = World.NewFilter().All<CompBehave>().Build();
		_checkToReleaseAction = CheckToRelease;
		_fixedUpdateBehaveAction = FixedUpdateBehave;
		_updateBehaveAction = UpdateBehave;
		m_StateControllers = new Dictionary<ConfigMotionStateMachine, StateController>();
		motionStatePool = new ObjectPool<FSMRuntimeState>((FSMRuntimeState s) =>
		{
			s.Reset();
		}, null);
		m_UsedTriggers = new HashSet<string>();
	}

	public override void LateFixedUpdate()
	{
		_onRemoveFilter.ForEach(_checkToReleaseAction);
	}

	private void CheckToRelease(Entity entity, CompBehave compBehave)
	{
		if (compBehave.IsOnRemove())
		{
			GameManager.entities.factory.DestroyEntity(entity);
		}
	}

	public void OnSpawn(Entity behave)
	{
		ConfigCharacter config = behave.GetConfig();
		CompMotion compMotion = behave.GetCompMotion();
		try
		{
			if (!m_StateControllers.ContainsKey(config.moveFSM))
			{
				m_StateControllers.Add(config.moveFSM, new StateController(config.moveFSM));
			}
			compMotion.moveController = m_StateControllers[config.moveFSM];
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"生成{behave}->moveFSM出错");
			}
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
		try
		{
			StateAttackController stateAttackController;
			if (!m_StateControllers.ContainsKey(config.attackFSM))
			{
				stateAttackController = new StateAttackController(compMotion.moveController, config.attackFSM);
				m_StateControllers.Add(config.attackFSM, stateAttackController);
			}
			else
			{
				stateAttackController = m_StateControllers[config.attackFSM] as StateAttackController;
				stateAttackController?.Reset(compMotion.moveController, config.attackFSM);
			}
			compMotion.attackController = stateAttackController;
			compMotion.currentAttackFSM = ((stateAttackController != null) ? config.attackFSM : null);
			compMotion.currentAttackFSMOverlay = null;
			compMotion.pendingAttackFSM = null;
			compMotion.pendingAttackFSMOverlay = null;
		}
		catch (Exception exception2)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"生成{behave}->attackFSM出错");
			}
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception2);
			}
		}
		CompPhysics compPhysics = behave.GetCompPhysics();
		State state = null;
		if (CompPhysics.IsGroundLikeMotion(config.motionType) && compPhysics.state != ACTMovementMode.Walking)
		{
			state = compMotion.moveController.childrenStateLayers[0].states.Find((State e) => e.value.stateType == MotionState.FreeFall);
		}
		if (state == null)
		{
			state = compMotion.moveController.childrenStateLayers[0].states.Find((State e) => e.value.stateType == MotionState.Born);
			if (state == null)
			{
				state = compMotion.moveController.childrenStateLayers[0].states.Find((State e) => e.value.name == "idle");
			}
		}
		SwitchInState(behave, state);
		if (config.moveFSM.layers.Length > 1)
		{
			State state2 = compMotion.moveController.childrenStateLayers[1].states.Find((State e) => e.value.name == "idle_knock_layer");
			SetLayerState(behave, state2, 1);
		}
		if (config.attackFSM.layers.Length > 1)
		{
			State state3 = compMotion.attackController.childrenStateLayers[1].states.Find((State e) => e.value.name == "idle_effect");
			SetLayerState(behave, state3, 2);
		}
		compMotion.playable.Evaluate(0f);
	}

	public void ReleaseStateController()
	{
		m_StateControllers = new Dictionary<ConfigMotionStateMachine, StateController>();
	}

	public bool RequestAttackFSMSwitch(Entity entity, string variantId)
	{
		if (!entity.IsValid || !entity.TryGetCompMotion(out CompMotion component) || !entity.TryGetCompBehave(out CompBehave component2) || component2.Config == null || !component2.Config.TryGetAttackFSMSwitchTarget(variantId, out var fsm, out var overlay))
		{
			return false;
		}
		if (component.attackController == null || component.currentAttackFSM == null)
		{
			return false;
		}
		if (component.currentAttackFSM == fsm && component.currentAttackFSMOverlay == overlay)
		{
			component.pendingAttackFSM = null;
			component.pendingAttackFSMOverlay = null;
			return true;
		}
		component.pendingAttackFSM = fsm;
		component.pendingAttackFSMOverlay = overlay;
		return true;
	}

	private void SetLayerState(Entity behave, State state, int index)
	{
		FSMRuntimeState fSMRuntimeState = motionStatePool.Get();
		fSMRuntimeState.state = state;
		behave.GetConfigMotion(fSMRuntimeState);
		CompMotion compMotion = behave.GetCompMotion();
		EnqueueRuntimeState(fSMRuntimeState, behave, compMotion.mixers[index], compMotion.layerMotionQueue[index]);
		if (index == 1 && state != null)
		{
			compMotion.ApplyKnockLayerWeightByStateTag(state.value.tag);
		}
	}

	public void SwitchInState(Entity behave, State state, bool isRecoverCount = true, float normalizedTime = 0f)
	{
		CompMotion compMotion = behave.GetCompMotion();
		if (compMotion.layer0Peak != null)
		{
			Layer0SwitchOut(behave, compMotion.layer0Peak);
		}
		FSMRuntimeState fSMRuntimeState = motionStatePool.Get();
		fSMRuntimeState.state = state;
		fSMRuntimeState.fromLogicWeight = 1f;
		fSMRuntimeState.toLogicWeight = 1f;
		behave.GetConfigMotion(fSMRuntimeState);
		SetRuntimeStateNormalizedTime(fSMRuntimeState, normalizedTime);
		EnqueueRuntimeState(fSMRuntimeState, behave, compMotion.mixers[0], compMotion.layerMotionQueue[0]);
		Layer0SwitchIn(behave, fSMRuntimeState);
		if (isRecoverCount)
		{
			compMotion.RecoverMotionCount();
		}
	}

	private static void SetRuntimeStateNormalizedTime(FSMRuntimeState runtimeState, float normalizedTime)
	{
		if (!(runtimeState.runtimeClip == null))
		{
			float length = runtimeState.runtimeClip.length;
			if (!(length <= Mathf.Epsilon))
			{
				float num = Mathf.Clamp01(normalizedTime) * length;
				runtimeState.fromLogicTime = (runtimeState.toLogicTime = num);
				runtimeState.fromLogicPercent = (runtimeState.toLogicPercent = num / length);
				runtimeState.perfTime = num;
				runtimeState.perfWeight = runtimeState.toLogicWeight;
			}
		}
	}

	public FSMRuntimeState CreateRuntimeState(Entity behave, State state, float logicOffset = 0f)
	{
		FSMRuntimeState fSMRuntimeState = motionStatePool.Get();
		fSMRuntimeState.state = state;
		fSMRuntimeState.fromLogicTime = (fSMRuntimeState.toLogicTime = logicOffset);
		fSMRuntimeState.fromLogicWeight = 0f;
		fSMRuntimeState.toLogicWeight = 0f;
		fSMRuntimeState.externalWeightDriven = false;
		fSMRuntimeState.externalStateHash = 0;
		behave.GetConfigMotion(fSMRuntimeState);
		return fSMRuntimeState;
	}

	public void UpdateTimelineLayer0States(Entity behave, List<(EntityStatePlayBehaviour.StateSource stateSource, string stateName, int clipHash, float weight, float logicOffset)> requests)
	{
		CompMotion compMotion = behave.GetCompMotion();
		if (compMotion == null)
		{
			return;
		}
		FSMRuntimeState fSMRuntimeState = null;
		float num = float.MinValue;
		List<FSMRuntimeState> list = compMotion.layerMotionQueue[0];
		for (int i = 0; i < requests.Count; i++)
		{
			(EntityStatePlayBehaviour.StateSource, string, int, float, float) tuple = requests[i];
			State state = tuple.Item1 switch
			{
				EntityStatePlayBehaviour.StateSource.Move => FindMotionState(behave, tuple.Item2), 
				EntityStatePlayBehaviour.StateSource.Attack => FindAttackMotionState(behave, tuple.Item2), 
				_ => null, 
			};
			if (state == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"Timeline 直接调用状态失败, 未找到状态: {tuple.Item1}/{tuple.Item2}, entity: {behave}");
				}
				continue;
			}
			FSMRuntimeState fSMRuntimeState2 = FindLayer0TimelineState(behave, tuple.Item3);
			if (fSMRuntimeState2 == null)
			{
				fSMRuntimeState2 = CreateRuntimeState(behave, state, tuple.Item5);
				fSMRuntimeState2.externalWeightDriven = true;
				fSMRuntimeState2.externalStateHash = tuple.Item3;
			}
			fSMRuntimeState2.fromLogicWeight = fSMRuntimeState2.toLogicWeight;
			fSMRuntimeState2.toLogicWeight = tuple.Item4;
			fSMRuntimeState2.perfWeight = tuple.Item4;
			compMotion.timelineStateFinished[tuple.Item3] = !fSMRuntimeState2.loop && (Mathf.Approximately(fSMRuntimeState2.toLogicPercent, 1f) || fSMRuntimeState2.toLogicPercent >= 1f);
			if (!(tuple.Item4 < num))
			{
				num = tuple.Item4;
				fSMRuntimeState = fSMRuntimeState2;
				SyncTimelineLayer0States(compMotion, fSMRuntimeState, list);
			}
		}
		float num2 = 0f;
		for (int j = 0; j < requests.Count; j++)
		{
			num2 += requests[j].weight;
		}
		float num3 = Mathf.Clamp01(1f - num2);
		float num4 = 0f;
		for (int k = 0; k < list.Count; k++)
		{
			FSMRuntimeState fSMRuntimeState3 = list[k];
			if (fSMRuntimeState3.externalWeightDriven)
			{
				bool flag = false;
				for (int l = 0; l < requests.Count; l++)
				{
					if (fSMRuntimeState3.externalStateHash == requests[l].clipHash)
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					fSMRuntimeState3.externalWeightDriven = false;
					if (fSMRuntimeState3.externalStateHash != 0)
					{
						compMotion.timelineStateFinished.Remove(fSMRuntimeState3.externalStateHash);
					}
					fSMRuntimeState3.externalStateHash = 0;
				}
			}
			else
			{
				num4 += fSMRuntimeState3.toLogicWeight;
			}
		}
		if (num4 > 0f)
		{
			float num5 = num3 / num4;
			for (int m = 0; m < list.Count; m++)
			{
				FSMRuntimeState fSMRuntimeState4 = list[m];
				if (!fSMRuntimeState4.externalWeightDriven)
				{
					fSMRuntimeState4.fromLogicWeight = fSMRuntimeState4.toLogicWeight;
					fSMRuntimeState4.toLogicWeight *= num5;
				}
			}
		}
		else
		{
			if (!(num3 <= 0f))
			{
				return;
			}
			for (int n = 0; n < list.Count; n++)
			{
				FSMRuntimeState fSMRuntimeState5 = list[n];
				if (!fSMRuntimeState5.externalWeightDriven)
				{
					fSMRuntimeState5.fromLogicWeight = fSMRuntimeState5.toLogicWeight;
					fSMRuntimeState5.toLogicWeight = 0f;
				}
			}
		}
	}

	private void SyncTimelineLayer0States(CompMotion compMotion, FSMRuntimeState nextPeak, List<FSMRuntimeState> queue)
	{
		if (nextPeak == null)
		{
			return;
		}
		if (compMotion.layer0Peak == null)
		{
			EnqueueRuntimeState(nextPeak, compMotion.owner, compMotion.mixers[0], compMotion.layerMotionQueue[0]);
			Layer0SwitchIn(compMotion.owner, nextPeak);
			return;
		}
		foreach (FSMRuntimeState item in queue)
		{
			if (item.actualMotion == nextPeak.actualMotion)
			{
				return;
			}
		}
		Layer0SwitchOut(compMotion.owner, nextPeak);
		EnqueueRuntimeState(nextPeak, compMotion.owner, compMotion.mixers[0], compMotion.layerMotionQueue[0]);
		Layer0SwitchIn(compMotion.owner, nextPeak);
	}

	public void ClearTimelineLayer0States(Entity behave)
	{
		CompMotion compMotion = behave.GetCompMotion();
		if (compMotion == null)
		{
			return;
		}
		List<FSMRuntimeState> list = compMotion.layerMotionQueue[0];
		for (int i = 0; i < list.Count; i++)
		{
			FSMRuntimeState fSMRuntimeState = list[i];
			if (fSMRuntimeState.externalWeightDriven)
			{
				fSMRuntimeState.externalWeightDriven = false;
				if (fSMRuntimeState.externalStateHash != 0)
				{
					compMotion.timelineStateFinished.Remove(fSMRuntimeState.externalStateHash);
				}
				fSMRuntimeState.externalStateHash = 0;
			}
		}
		compMotion.timelineStateFinished.Clear();
	}

	private FSMRuntimeState FindLayer0TimelineState(Entity behave, int clipHash)
	{
		CompMotion compMotion = behave.GetCompMotion();
		if (compMotion == null)
		{
			return null;
		}
		List<FSMRuntimeState> list = compMotion.layerMotionQueue[0];
		for (int i = 0; i < list.Count; i++)
		{
			FSMRuntimeState fSMRuntimeState = list[i];
			if (fSMRuntimeState.externalWeightDriven && fSMRuntimeState.externalStateHash == clipHash)
			{
				return fSMRuntimeState;
			}
		}
		return null;
	}

	public bool IsTimelineLayer0StateFinished(Entity behave, int clipHash)
	{
		CompMotion compMotion = behave.GetCompMotion();
		if (compMotion == null || clipHash == 0 || !compMotion.timelineStateFinished.TryGetValue(clipHash, out var value))
		{
			return false;
		}
		return value;
	}

	private void ClearMotionQueue(Entity behave)
	{
		CompMotion compMotion = behave.GetCompMotion();
		Layer0SwitchOut(behave, compMotion.layer0Peak);
		for (int i = 0; i < compMotion.mixers[0].GetInputCount(); i++)
		{
			compMotion.mixers[0].DisconnectInput(i);
		}
		compMotion.mixers[0].SetInputCount(0);
		compMotion.layerMotionQueue[0].ForEach((FSMRuntimeState f) =>
		{
			motionStatePool.Release(f);
		});
		compMotion.layerMotionQueue[0].Clear();
		compMotion.layer0Peak = null;
		compMotion.layer0PeakConfig = null;
	}

	public override void FixedUpdate()
	{
		if (MonoECS.instance.isStartWorld && !MonoECS.instance.IsLoadSubScene)
		{
			_filter.ForEach(_fixedUpdateBehaveAction);
		}
	}

	private void FixedUpdateBehave(Entity entity, CompBehave compBehave, CompMotion compMotion, CompTime compTime, CompAbility compAbility)
	{
		if (!entity.IsTickAvailable())
		{
			return;
		}
		List<FSMRuntimeState> toReleaseFsmRuntimeStates = compMotion.toReleaseFsmRuntimeStates;
		foreach (FSMRuntimeState item in toReleaseFsmRuntimeStates)
		{
			motionStatePool.Release(item);
		}
		toReleaseFsmRuntimeStates.Clear();
		compMotion.lastLayer0Peak = null;
		compMotion.lastLayer0PeakConfig = null;
		TryApplyPendingAttackFSMSwitch(entity, compMotion, compTime);
		FixedUpdateOwner(entity, compBehave, compMotion, compAbility, compTime);
	}

	private void TryApplyPendingAttackFSMSwitch(Entity entity, CompMotion compMotion, CompTime compTime)
	{
		ConfigAttackStateMachine pendingAttackFSM = compMotion.pendingAttackFSM;
		if (pendingAttackFSM == null)
		{
			return;
		}
		ConfigAttackFSMOverlay pendingAttackFSMOverlay = compMotion.pendingAttackFSMOverlay;
		StateAttackController attackController = compMotion.attackController;
		ConfigAttackStateMachine currentAttackFSM = compMotion.currentAttackFSM;
		if (attackController != null && !(currentAttackFSM == null) && compMotion.moveController != null)
		{
			if (currentAttackFSM == pendingAttackFSM && compMotion.currentAttackFSMOverlay == pendingAttackFSMOverlay)
			{
				compMotion.pendingAttackFSM = null;
				compMotion.pendingAttackFSMOverlay = null;
			}
			else if (CanApplyAttackFSMSwitch(compMotion, compTime, attackController))
			{
				StateAttackController stateAttackController = new StateAttackController(compMotion.moveController, pendingAttackFSM);
				AttackFSMOverlayRuntimeBuilder.Apply(stateAttackController, pendingAttackFSMOverlay);
				MigrateAttackFSMParameters(compMotion, entity.GetConfig().moveFSM, currentAttackFSM, compMotion.currentAttackFSMOverlay, pendingAttackFSM, pendingAttackFSMOverlay);
				compMotion.attackController = stateAttackController;
				compMotion.currentAttackFSM = pendingAttackFSM;
				compMotion.currentAttackFSMOverlay = pendingAttackFSMOverlay;
				ResetAttackEffectLayer(entity, stateAttackController);
				compMotion.pendingAttackFSM = null;
				compMotion.pendingAttackFSMOverlay = null;
			}
		}
	}

	private static bool CanApplyAttackFSMSwitch(CompMotion compMotion, CompTime compTime, StateAttackController oldController)
	{
		if (compMotion.IsMontageExclusiveLocked || compTime.isMotionTimeScale || compMotion.layer0Peak?.state?.stateLayer?.stateController == oldController)
		{
			return false;
		}
		List<FSMRuntimeState> list = compMotion.layerMotionQueue[0];
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i].state?.stateLayer?.stateController == oldController)
			{
				return false;
			}
		}
		if (oldController.childrenStateLayers.Count <= 1)
		{
			return compMotion.layerMotionQueue[2].Count == 0;
		}
		List<FSMRuntimeState> list2 = compMotion.layerMotionQueue[2];
		if (list2.Count != 1)
		{
			return false;
		}
		FSMRuntimeState fSMRuntimeState = list2[0];
		if (fSMRuntimeState.state?.stateLayer?.stateController == oldController && fSMRuntimeState.state.value.name == "idle_effect" && !fSMRuntimeState.externalWeightDriven)
		{
			return fSMRuntimeState.transitionDuration <= 0f;
		}
		return false;
	}

	private static void MigrateAttackFSMParameters(CompMotion compMotion, ConfigMotionStateMachine moveFSM, ConfigAttackStateMachine oldFSM, ConfigAttackFSMOverlay oldOverlay, ConfigAttackStateMachine targetFSM, ConfigAttackFSMOverlay targetOverlay)
	{
		HashSet<string> moveParameterNames = new HashSet<string>();
		for (int i = 0; i < moveFSM.parameters.Length; i++)
		{
			moveParameterNames.Add(moveFSM.parameters[i].name);
		}
		ResetAttackOnlyTriggers(oldFSM.parameters);
		ResetAttackOnlyTriggers(oldOverlay?.additionalParameters);
		ResetAttackOnlyTriggers(targetFSM.parameters);
		ResetAttackOnlyTriggers(targetOverlay?.additionalParameters);
		AddMissingParameters(targetFSM.parameters);
		AddMissingParameters(targetOverlay?.additionalParameters);
		void AddMissingParameters(ConfigAnimParameter[] parameters)
		{
			if (parameters != null)
			{
				foreach (ConfigAnimParameter configAnimParameter in parameters)
				{
					if (!compMotion.parameters.ContainsKey(configAnimParameter.name))
					{
						ConfigAnimParameter configAnimParameter2 = configAnimParameter.Clone();
						if (configAnimParameter2.type == ConfigAnimParameterType.Trigger)
						{
							configAnimParameter2.defaultBool = false;
						}
						compMotion.parameters.Add(configAnimParameter2.name, configAnimParameter2);
					}
				}
			}
		}
		void ResetAttackOnlyTriggers(ConfigAnimParameter[] parameters)
		{
			if (parameters != null)
			{
				foreach (ConfigAnimParameter configAnimParameter in parameters)
				{
					if (configAnimParameter.type == ConfigAnimParameterType.Trigger && !moveParameterNames.Contains(configAnimParameter.name))
					{
						compMotion.ResetTrigger(configAnimParameter.name);
					}
				}
			}
		}
	}

	private void ResetAttackEffectLayer(Entity entity, StateAttackController targetController)
	{
		CompMotion compMotion = entity.GetCompMotion();
		AnimationMixerPlayable playable = compMotion.mixers[2];
		for (int i = 0; i < playable.GetInputCount(); i++)
		{
			playable.DisconnectInput(i);
		}
		playable.SetInputCount(0);
		List<FSMRuntimeState> list = compMotion.layerMotionQueue[2];
		for (int j = 0; j < list.Count; j++)
		{
			motionStatePool.Release(list[j]);
		}
		list.Clear();
		if (targetController.childrenStateLayers.Count > 1)
		{
			State state = targetController.childrenStateLayers[1].states.Find((State state2) => state2.value.name == "idle_effect");
			SetLayerState(entity, state, 2);
		}
	}

	private void FixedUpdateOwner(Entity entity, CompBehave compBehave, CompMotion compMotion, CompAbility compAbility, CompTime compTime)
	{
		FixedUpdateOwnerSkillCD(entity, compMotion, compAbility, compTime);
		if (entity.IsCharacter() && MonoECS.instance.localPlayer.IndexOfTeamCharacter(entity) != -1)
		{
			FixedUpdateChangeCharCD(entity, compBehave, compAbility);
		}
		if (Singleton<GameState>.instance.PlayerAlive == PlayerLiveState.Normal)
		{
			entity.SetBool("battleState", MonoECS.instance.playState != ACT.Utility.PlayState.UnBattle);
		}
		if (entity.IsActive())
		{
			FixedUpdateOwnerBehave(entity, compMotion, compTime, compAbility);
		}
	}

	public override void Update()
	{
		float num = Time.time - Time.fixedTime;
		m_lerpP = num / Time.fixedDeltaTime;
		m_lerpP = Mathf.Clamp01(m_lerpP);
		_filter.ForEach(_updateBehaveAction);
	}

	private void FixedUpdateOwnerBehave(Entity entity, CompMotion compMotion, CompTime compTime, CompAbility compAbility)
	{
		bool isMontageExclusiveLocked = entity.GetCompMotion().IsMontageExclusiveLocked;
		for (int i = 0; i < compMotion.layerMotionQueue.Length; i++)
		{
			List<FSMRuntimeState> list = compMotion.layerMotionQueue[i];
			AnimationMixerPlayable mixer = compMotion.mixers[i];
			if (list.Count == 0)
			{
				continue;
			}
			if (!isMontageExclusiveLocked || i != 0)
			{
				FSMRuntimeState fSMRuntimeState = list[list.Count - 1];
				FSMRuntimeState fSMRuntimeState2 = motionStatePool.Get();
				m_UsedTriggers.Clear();
				fSMRuntimeState2.state = fSMRuntimeState.state;
				bool flag = false;
				if (i == 0)
				{
					flag = GetStateByMotionLayerAnyState(entity, compMotion, compAbility, fSMRuntimeState, compMotion.moveController, i, m_UsedTriggers, fSMRuntimeState2);
					if (!flag)
					{
						flag = GetStateByMotionLayerAnyState(entity, compMotion, compAbility, fSMRuntimeState, compMotion.attackController, i, m_UsedTriggers, fSMRuntimeState2);
						if (!flag && fSMRuntimeState.state.stateLayer.stateController != compMotion.attackController)
						{
							List<StateFromTransition> fromTransitions = compMotion.attackController.fromTransitions;
							for (int j = 0; j < fromTransitions.Count; j++)
							{
								StateFromTransition stateFromTransition = fromTransitions[j];
								if (MatchesAttackFromOrigin(fSMRuntimeState.state, stateFromTransition.origin))
								{
									flag = GetStateByTransitions(entity, compMotion, compAbility, fSMRuntimeState, stateFromTransition.transitions, m_UsedTriggers, useTransData: true, null, fSMRuntimeState2);
								}
								if (flag)
								{
									break;
								}
							}
						}
					}
				}
				if (i == 1)
				{
					flag = GetStateByMotionLayerAnyState(entity, compMotion, compAbility, fSMRuntimeState, compMotion.moveController, 1, m_UsedTriggers, fSMRuntimeState2);
				}
				if (i == 2)
				{
					flag = GetStateByMotionLayerAnyState(entity, compMotion, compAbility, fSMRuntimeState, compMotion.attackController, 1, m_UsedTriggers, fSMRuntimeState2);
				}
				if (!flag)
				{
					switch (fSMRuntimeState.state.parentStateMachine.value.type)
					{
					case StateMachineType.Legacy:
						flag = GetStateByTransitions(entity, compMotion, compAbility, fSMRuntimeState, fSMRuntimeState.state.transitions, m_UsedTriggers, useTransData: true, null, fSMRuntimeState2);
						break;
					case StateMachineType.RandomSon:
						flag = GetStateByTransitions(entity, compMotion, compAbility, fSMRuntimeState, fSMRuntimeState.state.parentStateMachine.transitions, m_UsedTriggers, useTransData: true, null, fSMRuntimeState2);
						break;
					case StateMachineType.SameExit:
						flag = GetStateByTransitions(entity, compMotion, compAbility, fSMRuntimeState, fSMRuntimeState.state.transitions, m_UsedTriggers, useTransData: true, null, fSMRuntimeState2);
						if (!flag)
						{
							flag = GetStateByTransitions(entity, compMotion, compAbility, fSMRuntimeState, fSMRuntimeState.state.parentStateMachine.transitions, m_UsedTriggers, useTransData: true, null, fSMRuntimeState2);
						}
						break;
					}
				}
				if (flag && (fSMRuntimeState2.actualMotion == null || fSMRuntimeState2.runtimeClip == null))
				{
					flag = false;
				}
				if (flag)
				{
					if (i == 0)
					{
						Layer0SwitchOut(entity, fSMRuntimeState2);
					}
					EnqueueRuntimeState(fSMRuntimeState2, entity, mixer, list);
					if (i == 1)
					{
						compMotion.ApplyKnockLayerWeightByStateTag(fSMRuntimeState2.state.value.tag);
					}
					foreach (string usedTrigger in m_UsedTriggers)
					{
						entity.ResetTrigger(usedTrigger);
					}
					if (i == 0)
					{
						Layer0SwitchIn(entity, fSMRuntimeState2);
					}
					if (i == 0)
					{
						entity.GetConfig()?.stateChangeActions?.TriggerCustomStateChangeAction(fSMRuntimeState.state.value.stateType, fSMRuntimeState2.state.value.stateType, entity, StateChangeActionType.CurrentBehave);
					}
				}
				else
				{
					compMotion.toReleaseFsmRuntimeStates.Add(fSMRuntimeState2);
				}
			}
			Forward1Frame(entity, compMotion, list, ref mixer);
		}
		compMotion.ResetTriggerInput();
		compMotion.UpdateMotionTags();
		compMotion.UpdateEndureLevel();
		compMotion.UpdateEntityTag();
		if (compMotion.InTag(MotionTag_backUp.ChangeDir))
		{
			switch (entity.GetCompInput().dirX)
			{
			case EInputDir.Left:
				entity.SetFaceLeft(left: true);
				compMotion.layer0Peak.startFaceDir = FaceDir.Left;
				break;
			case EInputDir.Right:
				entity.SetFaceLeft(left: false);
				compMotion.layer0Peak.startFaceDir = FaceDir.Right;
				break;
			}
		}
		compMotion.UpdateTagParameters();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_ChangePlayerLimit, null);
		UpdateFrameInfo(entity, compMotion, compTime);
	}

	private void Forward1Frame(Entity entity, CompMotion compMotion, List<FSMRuntimeState> queue, ref AnimationMixerPlayable mixer)
	{
		for (int num = queue.Count - 2; num >= 0; num--)
		{
			FSMRuntimeState fSMRuntimeState = queue[num];
			if (fSMRuntimeState.toLogicWeight == 0f)
			{
				queue.RemoveAt(num);
				compMotion.toReleaseFsmRuntimeStates.Add(fSMRuntimeState);
			}
		}
		float num2 = 1f;
		bool flag = false;
		CompTime compTime = entity.GetCompTime();
		for (int num3 = queue.Count - 1; num3 >= 0; num3--)
		{
			FSMRuntimeState fSMRuntimeState2 = queue[num3];
			fSMRuntimeState2.fromLogicTime = fSMRuntimeState2.toLogicTime;
			fSMRuntimeState2.fromLogicPercent = fSMRuntimeState2.toLogicPercent;
			float num4 = compTime.motionFixedDeltaTime * fSMRuntimeState2.speed;
			fSMRuntimeState2.toLogicTime += num4;
			float num5 = num4 / fSMRuntimeState2.length;
			float toLogicPercent = fSMRuntimeState2.toLogicPercent;
			fSMRuntimeState2.toLogicPercent += num5;
			PeriodMode periodMode = fSMRuntimeState2.periodMode;
			if (periodMode == PeriodMode.AfterDoPauseFrame || periodMode == PeriodMode.DoPauseFrame)
			{
				fSMRuntimeState2.periodMode = PeriodMode.Normal;
			}
			bool flag2 = Mathf.Approximately(num4, 0f);
			fSMRuntimeState2.continueTimeElapsedZero = fSMRuntimeState2.timeElapsedZero & flag2;
			if (flag2)
			{
				fSMRuntimeState2.periodMode = PeriodMode.DoPauseFrame;
			}
			else if (fSMRuntimeState2.timeElapsedZero)
			{
				fSMRuntimeState2.periodMode = PeriodMode.AfterDoPauseFrame;
			}
			fSMRuntimeState2.timeElapsedZero = flag2;
			fSMRuntimeState2.logicLoopTimes = 0;
			if (fSMRuntimeState2.loop)
			{
				fSMRuntimeState2.logicLoopTimes = (int)(toLogicPercent + num5) - (int)toLogicPercent;
				fSMRuntimeState2.toLogicPercent %= 1f;
			}
			else
			{
				fSMRuntimeState2.toLogicPercent = Mathf.Clamp(fSMRuntimeState2.toLogicPercent, 0f, 1f);
			}
			bool flag3 = Mathf.Approximately(fSMRuntimeState2.toLogicPercent, fSMRuntimeState2.fromLogicPercent);
			if (!fSMRuntimeState2.loop && Mathf.Approximately(fSMRuntimeState2.toLogicPercent, 1f) && fSMRuntimeState2.fromLogicPercent < 1f && !flag3)
			{
				OnStateEnd(compMotion, fSMRuntimeState2.state.value.stateType);
			}
			fSMRuntimeState2.fromLogicWeight = fSMRuntimeState2.toLogicWeight;
			bool flag4 = fSMRuntimeState2.transitionDuration > 0f;
			if (flag4 && fSMRuntimeState2.logicTransitionTime < fSMRuntimeState2.transitionDuration)
			{
				fSMRuntimeState2.logicTransitionTime += num4;
				if (fSMRuntimeState2.logicTransitionTime >= fSMRuntimeState2.transitionDuration)
				{
					flag4 = false;
					fSMRuntimeState2.transitionDuration = 0f;
				}
			}
			if (!flag4)
			{
				fSMRuntimeState2.toLogicWeight = num2;
				num2 = 0f;
			}
			else
			{
				fSMRuntimeState2.toLogicWeight = num2 * fSMRuntimeState2.logicTransitionTime / fSMRuntimeState2.transitionDuration;
				num2 -= fSMRuntimeState2.toLogicWeight;
			}
			if (num3 == queue.Count - 1)
			{
				flag = !flag4;
			}
			if (flag)
			{
				fSMRuntimeState2.fromLogicWeight = fSMRuntimeState2.toLogicWeight;
			}
		}
	}

	private void UpdateFrameInfo(Entity entity, CompMotion compMotion, CompTime compTime)
	{
		if (compMotion.curMotionState == MotionState.Move)
		{
			compMotion.RunDuration += compTime.motionFixedDeltaTime;
		}
		else
		{
			compMotion.RunDuration = 0f;
		}
	}

	private void FixedUpdateOwnerSkillCD(Entity entity, CompMotion compMotion, CompAbility compAbility, CompTime compTime)
	{
		foreach (Skill skill in compMotion.skills)
		{
			if (skill.NowCd <= 0f)
			{
				if (skill.NowCount != skill.MaxCount)
				{
					int num = ((skill.Cd != 0f) ? (Mathf.FloorToInt((0f - skill.NowCd) / skill.Cd) + 1) : skill.MaxCount);
					skill.SetSkillCount(Mathf.Min((int)((float)skill.NowCount + (float)num * skill.AddCount), skill.MaxCount));
				}
				else
				{
					skill.SetSkillCd(0f, exceeds: false);
				}
			}
			else
			{
				UpdateSkillCd(entity, skill, compAbility, compTime);
			}
		}
	}

	private void FixedUpdateChangeCharCD(Entity entity, CompBehave compBehave, CompAbility compAbility)
	{
		if (compAbility.alive && compBehave.ChangeCD > 0f)
		{
			float fixedDeltaTime = entity.GetCompTime().fixedDeltaTime;
			compBehave.ChangeCD -= fixedDeltaTime;
		}
	}

	private void UpdateSkillCd(Entity behave, Skill skill, CompAbility compAbility, CompTime compTime)
	{
		float num = 1f;
		if (skill.config.cdProperty != 0)
		{
			num = 1f + compAbility.GetProperty(skill.config.cdProperty).value;
		}
		int num2 = ((!behave.GetCompEffect().bInUltraTimeline) ? 1 : 0);
		skill.SetSkillCd(skill.NowCd - compTime.fixedDeltaTime * num * (float)num2, exceeds: false);
	}

	private void EnqueueRuntimeState(FSMRuntimeState nextRuntimeState, Entity behave, AnimationMixerPlayable mixer, List<FSMRuntimeState> queue)
	{
		ConfigMotion actualMotion = nextRuntimeState.actualMotion;
		AnimationClip runtimeClip = nextRuntimeState.runtimeClip;
		nextRuntimeState.speed = actualMotion.speed;
		CompMotion compMotion = behave.GetCompMotion();
		AnimationClipPlayable animationClipPlayable = AnimationClipPlayable.Create(compMotion.playable, runtimeClip);
		if (actualMotion._useDynamicYScale)
		{
			Transform bip = behave.GetBip001();
			float maxCurveValue = GameUtility.GetMaxCurveValue(actualMotion.upCurve);
			YCurveScaleJob jobData = new YCurveScaleJob
			{
				target = compMotion.animator.BindStreamTransform(bip),
				originalYDis = maxCurveValue,
				hasInit = 0,
				yScale = 1f
			};
			AnimationScriptPlayable animationScriptPlayable = AnimationScriptPlayable.Create(compMotion.playable, jobData, 1);
			animationScriptPlayable.AddInput(animationClipPlayable, 0, 1f);
			animationScriptPlayable.SetPropagateSetTime(value: true);
			nextRuntimeState.playable = animationScriptPlayable;
			nextRuntimeState.scriptPlayable = animationScriptPlayable;
			compMotion.globalYScalePlayable = animationScriptPlayable;
			compMotion.UpdateYScale();
		}
		else
		{
			nextRuntimeState.playable = animationClipPlayable;
			compMotion.globalYScalePlayable = AnimationScriptPlayable.Null;
		}
		nextRuntimeState.length = runtimeClip.length;
		nextRuntimeState.loop = runtimeClip.isLooping;
		nextRuntimeState.fromLogicPercent = (nextRuntimeState.toLogicPercent = nextRuntimeState.toLogicTime / nextRuntimeState.length);
		queue.Add(nextRuntimeState);
	}

	private void Layer0SwitchOut(Entity entity, FSMRuntimeState nextRuntimeState)
	{
		CompMotion compMotion = entity.GetCompMotion();
		if (compMotion.layer0Peak != null)
		{
			compMotion.layer0Peak.hasRecoveredEnergyThisMotion = false;
			compMotion.layer0Peak.dodgeCounterUseCounted = false;
		}
		compMotion.OnSwitchOut?.Invoke(nextRuntimeState, compMotion.layer0PeakConfig);
	}

	private void Layer0SwitchIn(Entity entity, FSMRuntimeState nextRuntimeState)
	{
		ConfigMotion actualMotion = nextRuntimeState.actualMotion;
		nextRuntimeState.hasRecoveredEnergyThisMotion = false;
		nextRuntimeState.dodgeCounterUseCounted = false;
		CompMotion compMotion = entity.GetCompMotion();
		compMotion.suppressSwitchOutAreaAttack = false;
		compMotion.OnSwitchIn?.Invoke(nextRuntimeState, actualMotion);
		bool num = Model<CharacterTutorialModel>.HasInstance() && Model<CharacterTutorialModel>.Interface.InCharacterTutorial;
		bool flag = Model<ChallengeTargetTrackerModel>.HasInstance() && Model<ChallengeTargetTrackerModel>.Interface.NeedCharacterStateEvent;
		if (num | flag)
		{
			CompCharacter compCharacter = entity.GetCompCharacter();
			if (compCharacter != null)
			{
				ICharacterSource characterSource = compCharacter.characterSource;
				if (characterSource != null)
				{
					CharacterStateChangeEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterStateChangeEvt>();
					evt.characterId = characterSource.Id();
					evt.characterState = actualMotion.name;
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.CharacterStateChange, evt);
					Singleton<EventManager>.instance.ReleaseEvt(evt);
				}
			}
		}
		MotionState curMotionState = compMotion.curMotionState;
		MotionState stateType = nextRuntimeState.state.value.stateType;
		compMotion.curMotionState = nextRuntimeState.state.value.stateType;
		compMotion.lastLayer0Peak = compMotion.layer0Peak;
		compMotion.lastLayer0PeakConfig = compMotion.layer0PeakConfig;
		compMotion.layer0Peak = nextRuntimeState;
		compMotion.layer0PeakConfig = actualMotion;
		nextRuntimeState.startFaceDir = entity.GetConfig().animationSchema switch
		{
			AnimationSchema.LockRotation => actualMotion.changFaceDir, 
			AnimationSchema.UnlockRotation => entity.GetFaceDir(), 
			_ => throw new ArgumentOutOfRangeException(), 
		};
		if (nextRuntimeState.actualMotion.isFirstMotion)
		{
			TrackSkillEvt evt2 = EventTrackSolver.Instance.GetEvt<TrackSkillEvt>();
			evt2.skillId = nextRuntimeState.actualMotion.skillDetailId;
			evt2.caster = entity;
			evt2.stateName = nextRuntimeState.actualMotion.name;
			EventTrackSolver.Instance.Dispatch(evt2);
		}
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtMotionChange evt3 = abilitySystem.GetEvt<EvtMotionChange>(entity, null);
		evt3.mainEntity = entity;
		if (compMotion.lastLayer0Peak != null)
		{
			evt3.from = compMotion.lastLayer0Peak.state.value.name;
			evt3.fromState = compMotion.lastLayer0Peak.state.value;
			evt3.fromMotion = compMotion.lastLayer0Peak.actualMotion;
		}
		else
		{
			evt3.fromMotion = null;
		}
		evt3.to = nextRuntimeState.state.value.name;
		evt3.toState = nextRuntimeState.state.value;
		evt3.toMotion = nextRuntimeState.actualMotion;
		evt3.isFirstMotion = nextRuntimeState.actualMotion.isFirstMotion;
		evt3.skillId = nextRuntimeState.actualMotion.skillDetailId;
		abilitySystem.FireEvt(evt3);
		Singleton<AchievementSyncBattleTypeManager>.instance?.OnEvtMotionChange(evt3);
		abilitySystem.ReleaseEvt(evt3);
		MotionStateChangeEvt evt4 = Singleton<EventManager>.instance.GetEvt<MotionStateChangeEvt>();
		evt4.entity = entity;
		evt4.beforeState = curMotionState;
		evt4.curState = stateType;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Motion_MotionStateChange, evt4);
		Singleton<EventManager>.instance.ReleaseEvt(evt4);
		CompPhysics compPhysics = entity.GetCompPhysics();
		if (curMotionState != stateType)
		{
			switch (curMotionState)
			{
			case MotionState.Attack:
				if (entity.IsMonster())
				{
					entity.GetCompAI().behaviorDepth = 0;
				}
				break;
			case MotionState.Climb:
				ExitClimb(entity);
				break;
			case MotionState.ClimbDown:
				if (stateType != MotionState.Climb)
				{
					ExitClimb(entity);
				}
				else
				{
					ExitClimbDown(entity);
				}
				break;
			case MotionState.WallClimb:
				ExitWallClimb(entity);
				break;
			case MotionState.Die:
				if (stateType != MotionState.Hit)
				{
					ExitHit(entity);
				}
				break;
			case MotionState.Hit:
				if (stateType != MotionState.Die)
				{
					ExitHit(entity);
				}
				break;
			case MotionState.BeCarryed:
				if (stateType != MotionState.Die)
				{
					ExitBeCarryed(entity);
				}
				break;
			case MotionState.Adsorb:
				ExitAdsorb(entity);
				break;
			case MotionState.ClimbCompensate:
				compPhysics.ExitCC();
				break;
			case MotionState.BackTrace:
				ExitBackTrace(entity);
				break;
			case MotionState.GrabHook:
				compPhysics.ExitGrabHook();
				break;
			case MotionState.SpringBegin:
				compPhysics.MotionExitSpringBegin();
				break;
			case MotionState.Spring:
				compPhysics.MotionExitSpring();
				break;
			case MotionState.JumpDown:
				compPhysics.MotionExitJumpDown();
				break;
			case MotionState.Glide:
				ExitGlide(entity);
				break;
			case MotionState.TeleportMoveToPath:
				compPhysics.MotionExitTeleportMoveToPath();
				break;
			}
			switch (stateType)
			{
			case MotionState.Adsorb:
				EnterAdsorb(entity);
				break;
			case MotionState.ClimbDown:
				EnterClimbDown(entity);
				break;
			case MotionState.Climb:
				EnterClimb(entity);
				break;
			case MotionState.WallClimb:
				EnterWallClimb(entity);
				break;
			case MotionState.Die:
				EnterDie(entity);
				break;
			case MotionState.ClimbCompensate:
				compPhysics.EnterCC();
				break;
			case MotionState.BackTrace:
				EnterBackTrace(entity);
				break;
			case MotionState.GrabHook:
				EnterGrabHook(entity);
				break;
			case MotionState.GrabHookBegin:
				EnterGrabHookBegin(entity);
				break;
			case MotionState.Dodge:
			{
				bool flag2 = entity.IsFaceLeft();
				if (curMotionState == MotionState.WallClimb)
				{
					nextRuntimeState.startFaceDir = (flag2 ? FaceDir.Right : FaceDir.Left);
					entity.SetFaceDir(flag2 ? FaceDir.Right : FaceDir.Left);
					compPhysics.SetDirImmediately();
				}
				if (compPhysics.isGrounded)
				{
					EvtDodge evt5 = abilitySystem.GetEvt<EvtDodge>(entity, null);
					evt5.mainEntity = entity;
					abilitySystem.FireEvt(evt5);
					abilitySystem.ReleaseEvt(evt5);
				}
				else
				{
					EvtAirDodge evt6 = abilitySystem.GetEvt<EvtAirDodge>(entity, null);
					evt6.mainEntity = entity;
					abilitySystem.FireEvt(evt6);
					abilitySystem.ReleaseEvt(evt6);
				}
				compPhysics.ResetFreeFallingTime();
				break;
			}
			case MotionState.SpringBegin:
				compPhysics.MotionEnterSpringBegin();
				break;
			case MotionState.Spring:
				compPhysics.MotionEnterSpring();
				break;
			case MotionState.JumpDown:
				compPhysics.MotionEnterJumpDown();
				break;
			case MotionState.Glide:
				EnterGlide(entity);
				break;
			case MotionState.TeleportMoveToPath:
				nextRuntimeState.startFaceDir = FaceDir.Right;
				compPhysics.MotionEnterTeleportMoveToPath();
				break;
			}
			if (compPhysics != null && compPhysics.CantHook && stateType != MotionState.GrabHookBegin && stateType != MotionState.GrabHook)
			{
				compPhysics.BreakHook();
			}
			CompSound compSound = entity.GetCompSound();
			if (compSound != null && curMotionState != MotionState.Idle && stateType != MotionState.Idle)
			{
				compSound.StopCurSound();
			}
			compMotion.onMotionChange?.Invoke(curMotionState, stateType);
		}
		switch (stateType)
		{
		case MotionState.Die:
			EnterHit(entity);
			break;
		case MotionState.Hit:
		{
			FaceDir faceDir = entity.GetCompTransform().FaceDir;
			EnterHit(entity);
			compMotion.suppressSwitchOutAreaAttack = faceDir != entity.GetCompTransform().FaceDir;
			break;
		}
		case MotionState.BeCarryed:
			compPhysics.EnterBeCarryed();
			break;
		case MotionState.Attack:
			if (entity.IsMonster())
			{
				entity.GetCompAI().behaviorDepth++;
			}
			break;
		case MotionState.Dodge:
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Plyaer_Dodge);
			break;
		}
		StateTag curStateTag = compMotion.curStateTag;
		StateTag tag = nextRuntimeState.state.value.tag;
		compMotion.curStateTag = nextRuntimeState.state.value.tag;
		if (curStateTag != tag)
		{
			switch (curStateTag)
			{
			case StateTag.weakState:
				ExitWeakState(entity);
				break;
			case StateTag.groundProtection:
				ExitGroundProtection(entity);
				break;
			}
			switch (tag)
			{
			case StateTag.weakState:
				EnterWeakState(entity);
				break;
			case StateTag.groundProtection:
				EnterGroundProtection(entity);
				break;
			}
		}
		if (compPhysics != null)
		{
			compPhysics.characterMovement.cannotOffCliff = actualMotion.cantOffCliff;
		}
		if (compPhysics != null && compPhysics.state == ACTMovementMode.Falling)
		{
			if (stateType == MotionState.Jump && curMotionState != stateType && compPhysics._fallingTime >= GameLoader.meta.coyoteTime)
			{
				compMotion.JumpInAirCount--;
				GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Player_DoubleJump);
			}
			else if (stateType == MotionState.Jump && curMotionState == stateType)
			{
				compMotion.JumpInAirCount--;
			}
			if (stateType == MotionState.Dodge)
			{
				compMotion.dodgeInAirCount--;
			}
			if (stateType == MotionState.AirAttackA)
			{
				compMotion.airAttackCount--;
			}
		}
		else if (stateType == MotionState.Jump)
		{
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Player_Jump);
		}
		if (compMotion.skillLookup.TryGetValue(nextRuntimeState.state.value.name, out var value))
		{
			compMotion.ConsumeSkillCount(value, useall: false);
		}
	}

	private void EnterWeakState(Entity entity)
	{
		entity.SetBool("is_weak_state", value: true);
	}

	private void ExitWeakState(Entity entity)
	{
		entity.SetBool("is_weak_state", value: false);
	}

	private void EnterGroundProtection(Entity entity)
	{
	}

	private void ExitGroundProtection(Entity entity)
	{
	}

	private void EnterHit(Entity entity)
	{
		entity.GetCompPhysics().EnterHit();
		entity.SetBool("is_hitting", value: true);
	}

	private void ExitHit(Entity entity)
	{
		CompPhysics? compPhysics = entity.GetCompPhysics();
		compPhysics.ClearLastFrameVelocity();
		compPhysics.ExitHit();
		entity.SetBool("is_hitting", value: false);
	}

	private void EnterClimb(Entity behave)
	{
		CompMotion? compMotion = behave.GetCompMotion();
		compMotion.RecoverMotionCount();
		compMotion.SetBool("IsClimbState", b: true);
		behave.GetCompPhysics().MotionEnterClimb();
	}

	private void EnterClimbDown(Entity behave)
	{
		CompMotion? compMotion = behave.GetCompMotion();
		compMotion.RecoverMotionCount();
		compMotion.SetBool("IsClimbState", b: true);
		behave.GetCompPhysics().MotionEnterClimbDown();
	}

	private void EnterGrabHook(Entity behave)
	{
		behave.GetCompPhysics().EnterGrabHook();
		behave.GetCompMotion().RecoverMotionCount();
	}

	private void EnterGrabHookBegin(Entity behave)
	{
		behave.GetCompPhysics().EnterGrabHookBegin();
	}

	private void EnterAdsorb(Entity behave)
	{
		behave.GetCompPhysics().MotionEnterAdsorb();
	}

	private void EnterBackTrace(Entity behave)
	{
		behave.GetCompPhysics().MotionEnterRecall();
		CompMotion? compMotion = behave.GetCompMotion();
		compMotion.ResetTrigger(compMotion.lastConflictTrigger);
	}

	private void ExitBackTrace(Entity behave)
	{
		CompMotion? compMotion = behave.GetCompMotion();
		compMotion.ResetTrigger(compMotion.lastConflictTrigger);
		compMotion.SetBool("ButtonAPress", b: false);
		compMotion.SetBool("ButtonBPress", b: false);
		compMotion.SetBool("DodgePress", b: false);
		compMotion.SetBool("JumpPress", b: false);
		behave.GetCompPhysics().MotionExitReCall();
	}

	private void ExitClimb(Entity behave)
	{
		behave.GetCompMotion().SetBool("IsClimbState", b: false);
		behave.GetCompPhysics().MotionExitClimb();
	}

	private void ExitClimbDown(Entity behave)
	{
		behave.GetCompPhysics().MotionExitClimbDown();
	}

	private void ExitAdsorb(Entity behave)
	{
		behave.GetCompPhysics().MotionExitAdsorb();
	}

	private void EnterJumpOffWall(Entity behave)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("EnterJumpOffWall");
		}
		CompInput compInput = behave.GetCompInput();
		compInput.dir = Vector2.zero;
		behave.SetFaceLeft(compInput.isSetLeft);
	}

	private void ExitJumpOffWall(Entity behave)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("ExitJumpOffWall");
		}
	}

	private void ExitBeCarryed(Entity entity)
	{
		CompPhysics? compPhysics = entity.GetCompPhysics();
		compPhysics.ClearLastFrameVelocity();
		compPhysics.ExitBeCarryed();
	}

	public void EnterDie(Entity entity)
	{
		CompPhysics? compPhysics = entity.GetCompPhysics();
		compPhysics.ClearLastFrameVelocity();
		compPhysics.ExitBeCarryed();
		compPhysics.characterMovement.detectCollisions = true;
		if (entity.IsMonster())
		{
			entity.GetCompAI().SetAttackToken(res: false);
		}
	}

	private void EnterWallClimb(Entity behave)
	{
		behave.GetCompPhysics().MotionEnterWallClimb();
		behave.GetCompMotion().RecoverMotionCount();
	}

	private void ExitWallClimb(Entity behave)
	{
		behave.GetCompPhysics().MotionExitWallClimb();
	}

	private void EnterGlide(Entity behave)
	{
		behave.GetCompPhysics().MotionEnterGlide();
	}

	private void ExitGlide(Entity behave)
	{
		behave.GetCompPhysics().MotionExitGlide();
	}

	private void OnStateEnd(CompMotion compMotion, MotionState stateType)
	{
		if (stateType == MotionState.Die)
		{
			compMotion.DieAnimationEnd = true;
		}
	}

	public void ResetInput(Entity entity)
	{
		if (entity.IsLogicAvailable())
		{
			entity.SetBool("DirNone", value: true);
			entity.SetBool("DirLeft", value: false);
			entity.SetBool("DirRight", value: false);
			entity.SetBool("Move", value: false);
			entity.SetBool("DirUp", value: false);
			entity.SetBool("DirDown", value: false);
			entity.SetBool("DirOp", value: false);
			entity.SetBool("DodgePress", value: false);
			entity.SetBool("DodgeHold", value: false);
			entity.SetBool("JumpPress", value: false);
			entity.SetBool("JumpHold", value: true);
			entity.ResetTrigger("Glide");
			entity.SetBool("ButtonAPress", value: false);
			entity.SetBool("ButtonAHold", value: false);
			entity.GetCompMotion()?.ResetTriggerInput();
		}
	}

	private static bool MatchesAttackFromOrigin(State current, StateObject origin)
	{
		if (current == null || origin == null)
		{
			return false;
		}
		if (origin is State)
		{
			return current == origin;
		}
		if (!(origin is StateMachine stateMachine))
		{
			return false;
		}
		if (current.parentStateMachine == stateMachine)
		{
			return true;
		}
		string name = current.value.name;
		if (string.IsNullOrEmpty(name))
		{
			return false;
		}
		List<State> states = stateMachine.states;
		for (int i = 0; i < states.Count; i++)
		{
			if (states[i].value.name == name)
			{
				return true;
			}
		}
		return false;
	}

	protected bool GetStateByMotionLayerAnyState(Entity behave, CompMotion compMotion, CompAbility compAbility, FSMRuntimeState curState, StateController stateController, int layer, HashSet<string> usedTriggers, FSMRuntimeState found)
	{
		bool flag = false;
		if (layer < stateController.childrenStateLayers.Count)
		{
			for (int i = 0; i < stateController.childrenStateLayers[layer].stateMachines.Count; i++)
			{
				flag = GetStateByTransitions(behave, compMotion, compAbility, curState, stateController.childrenStateLayers[layer].stateMachines[i].anyStateTransitions, usedTriggers, useTransData: true, null, found);
				if (flag)
				{
					break;
				}
			}
		}
		return flag;
	}

	private static bool IsMotionForbidTriggerBlocked(CompMotion compMotion, ConfigAnimCondition condition, ConfigAnimParameter parameter)
	{
		if (parameter.type != ConfigAnimParameterType.Trigger || condition.mode != ConfigAnimConditionMode.If)
		{
			return false;
		}
		string parameter2 = condition.parameter;
		if (!(parameter2 == "ButtonA"))
		{
			if (parameter2 == "ButtonB")
			{
				return compMotion.InTag(MotionTag_backUp.ForbidWeapon2);
			}
			return false;
		}
		return compMotion.InTag(MotionTag_backUp.ForbidWeapon1);
	}

	protected bool GetStateByTransition(Entity entity, CompMotion compMotion, CompAbility compAbility, FSMRuntimeState curState, StateTransition t, HashSet<string> usedTriggers, bool useTransData, StateMachine sm, FSMRuntimeState found, int recursionDepth = 0)
	{
		if (recursionDepth >= 128)
		{
			_ = LuminApplication.LogEnabled;
			return false;
		}
		if (t.destination == curState.state && !t.value.canTransitionToSelf)
		{
			return false;
		}
		if (t.value.hasExitTime && curState.toLogicPercent < t.value.transitionExitPercent)
		{
			return false;
		}
		bool flag = true;
		for (int i = 0; i < t.value.conditions.Length; i++)
		{
			ConfigAnimCondition condition = t.value.conditions[i];
			DynamicValue value2;
			if (compMotion.parameters.TryGetValue(condition.parameter, out var value))
			{
				if (IsMotionForbidTriggerBlocked(compMotion, condition, value))
				{
					flag = false;
					break;
				}
				switch (condition.mode)
				{
				case ConfigAnimConditionMode.If:
					flag = value.defaultBool;
					break;
				case ConfigAnimConditionMode.IfNot:
					flag = !value.defaultBool;
					break;
				case ConfigAnimConditionMode.Greater:
					if (value.type == ConfigAnimParameterType.Float)
					{
						flag = value.defaultFloat > condition.threshold;
					}
					else if (value.type == ConfigAnimParameterType.Int)
					{
						flag = (float)value.defaultInt > condition.threshold;
					}
					break;
				case ConfigAnimConditionMode.Less:
					if (value.type == ConfigAnimParameterType.Float)
					{
						flag = value.defaultFloat < condition.threshold;
					}
					else if (value.type == ConfigAnimParameterType.Int)
					{
						flag = (float)value.defaultInt < condition.threshold;
					}
					break;
				case ConfigAnimConditionMode.Equals:
					if (value.type == ConfigAnimParameterType.Float)
					{
						flag = Mathf.Approximately(value.defaultFloat, condition.threshold);
					}
					else if (value.type == ConfigAnimParameterType.Int)
					{
						flag = Mathf.Approximately(value.defaultInt, condition.threshold);
					}
					break;
				case ConfigAnimConditionMode.NotEqual:
					switch (value.type)
					{
					case ConfigAnimParameterType.Float:
						flag = !Mathf.Approximately(value.defaultFloat, condition.threshold);
						break;
					case ConfigAnimParameterType.Int:
						flag = !Mathf.Approximately(value.defaultInt, condition.threshold);
						break;
					}
					break;
				case ConfigAnimConditionMode.GreaterAndEqual:
					if (value.type == ConfigAnimParameterType.Float)
					{
						flag = value.defaultFloat >= condition.threshold;
					}
					else if (value.type == ConfigAnimParameterType.Int)
					{
						flag = (float)value.defaultInt >= condition.threshold;
					}
					break;
				case ConfigAnimConditionMode.LessAndEqual:
					if (value.type == ConfigAnimParameterType.Float)
					{
						flag = value.defaultFloat <= condition.threshold;
					}
					else if (value.type == ConfigAnimParameterType.Int)
					{
						flag = (float)value.defaultInt <= condition.threshold;
					}
					break;
				}
			}
			else if (compAbility.vars.TryGetValue(condition.parameter, out value2))
			{
				float value3 = value2.value;
				switch (condition.mode)
				{
				case ConfigAnimConditionMode.Greater:
					flag = value3 > condition.threshold;
					break;
				case ConfigAnimConditionMode.Less:
					flag = value3 < condition.threshold;
					break;
				case ConfigAnimConditionMode.Equals:
					flag = Mathf.Approximately(value3, condition.threshold);
					break;
				case ConfigAnimConditionMode.NotEqual:
					flag = !Mathf.Approximately(value3, condition.threshold);
					break;
				case ConfigAnimConditionMode.GreaterAndEqual:
					flag = value3 >= condition.threshold;
					break;
				case ConfigAnimConditionMode.LessAndEqual:
					flag = value3 <= condition.threshold;
					break;
				}
			}
			else
			{
				if (condition.parameter == "" || condition.parameter == " ")
				{
					if (!LuminApplication.LogEnabled)
					{
					}
				}
				else if (condition.parameter.Contains(" "))
				{
					if (!LuminApplication.LogEnabled)
					{
					}
				}
				else
				{
					_ = LuminApplication.LogEnabled;
				}
				flag = false;
			}
			if (!flag)
			{
				break;
			}
		}
		if (flag)
		{
			if (t.destination == null)
			{
				StateMachine stateMachine = ((sm == null) ? found.state.parentStateMachine : sm.parentStateMachine);
				if (stateMachine != null)
				{
					List<StateTransition> transitions = stateMachine.transitions;
					flag = GetStateByTransitions(entity, compMotion, compAbility, curState, transitions, usedTriggers, useTransData: false, stateMachine, found, recursionDepth + 1);
					if (!flag)
					{
						transitions = stateMachine.entryTransitions;
						flag = GetStateByTransitions(entity, compMotion, compAbility, curState, transitions, usedTriggers, useTransData: true, stateMachine, found, recursionDepth + 1);
					}
				}
				else
				{
					List<StateTransition> entryTransitions = compMotion.moveController.childrenStateLayers[0].stateMachine.entryTransitions;
					flag = GetStateByTransitions(entity, compMotion, compAbility, curState, entryTransitions, usedTriggers, useTransData: true, null, found, recursionDepth + 1);
				}
			}
			else if (t.value.toStateMachine)
			{
				StateMachine stateMachine2 = t.destination as StateMachine;
				switch (stateMachine2.value.type)
				{
				case StateMachineType.Legacy:
				case StateMachineType.SameExit:
					flag = GetStateByTransitions(entity, compMotion, compAbility, curState, stateMachine2.entryTransitions, usedTriggers, useTransData: false, stateMachine2, found, recursionDepth + 1);
					break;
				case StateMachineType.RandomSon:
					flag = GetStateByRandonSon(entity, stateMachine2, found);
					break;
				}
			}
			else
			{
				State state = t.destination as State;
				State state2 = found.state;
				if (compMotion.banedMotions.Contains(state.value.name))
				{
					flag = false;
				}
				else
				{
					found.state = t.destination as State;
				}
				if (entity.GetConfigMotion(found) == null)
				{
					flag = false;
					found.state = state2;
				}
			}
		}
		if (flag)
		{
			for (int j = 0; j < t.value.conditions.Length; j++)
			{
				if (compMotion.parameters.TryGetValue(t.value.conditions[j].parameter, out var value4) && value4.type == ConfigAnimParameterType.Trigger && value4.defaultBool)
				{
					m_UsedTriggers.Add(value4.name);
				}
			}
			if (useTransData)
			{
				found.transitionDuration = t.value.transitionDuration;
				found.fromLogicTime = (found.toLogicTime = t.value.transitionOffset);
			}
		}
		return flag;
	}

	private bool GetStateByRandonSon(Entity entity, StateMachine sm, FSMRuntimeState found)
	{
		if (entity.GetCompTime().isMotionTimeScale)
		{
			return false;
		}
		State state = found.state;
		List<State> states = sm.states;
		for (int num = UnityEngine.Random.Range(0, states.Count); num >= 0; num--)
		{
			found.state = states[num];
			if (entity.GetConfigMotion(found) != null)
			{
				return true;
			}
		}
		found.state = state;
		return false;
	}

	protected bool GetStateByTransitions(Entity behave, CompMotion compMotion, CompAbility compAbility, FSMRuntimeState mState, List<StateTransition> transitions, HashSet<string> usedTriggers, bool useTransData, StateMachine sm, FSMRuntimeState found, int recursionDepth = 0)
	{
		if (recursionDepth >= 128)
		{
			_ = LuminApplication.LogEnabled;
			return false;
		}
		bool flag = false;
		for (int i = 0; i < transitions.Count; i++)
		{
			flag = GetStateByTransition(behave, compMotion, compAbility, mState, transitions[i], usedTriggers, useTransData, sm, found, recursionDepth + 1);
			if (flag)
			{
				break;
			}
		}
		return flag;
	}

	private void UpdateBehave(Entity entity, CompMotion compMotion, CompTime compTime)
	{
		if (!entity.IsTickAvailable() || !entity.IsActive() || !entity.IsLogicAvailable())
		{
			return;
		}
		for (int i = 0; i < compMotion.layerMotionQueue.Length; i++)
		{
			List<FSMRuntimeState> list = compMotion.layerMotionQueue[i];
			if (list.Count == 0)
			{
				continue;
			}
			for (int num = list.Count - 1; num >= 0; num--)
			{
				FSMRuntimeState fSMRuntimeState = list[num];
				fSMRuntimeState.perfTime = Mathf.Lerp(fSMRuntimeState.fromLogicTime, fSMRuntimeState.toLogicTime, m_lerpP = (compTime.isFrameHalt() ? 1f : m_lerpP));
				fSMRuntimeState.perfWeight = Mathf.Lerp(fSMRuntimeState.fromLogicWeight, fSMRuntimeState.toLogicWeight, m_lerpP = (compTime.isFrameHalt() ? 1f : m_lerpP));
				if (fSMRuntimeState.loop)
				{
					while (fSMRuntimeState.perfTime > fSMRuntimeState.length)
					{
						fSMRuntimeState.perfTime -= fSMRuntimeState.length;
					}
				}
				else if (fSMRuntimeState.perfTime > fSMRuntimeState.length)
				{
					fSMRuntimeState.perfTime = fSMRuntimeState.length;
				}
			}
		}
	}

	public void SetMotionMustDo(Entity entity)
	{
		CompMotion compMotion = entity.GetCompMotion();
		CompTime compTime = entity.GetCompTime();
		if (compMotion.layer0Peak == null)
		{
			return;
		}
		FSMRuntimeState layer0Peak = compMotion.layer0Peak;
		ConfigMotion layer0PeakConfig = compMotion.layer0PeakConfig;
		if (layer0PeakConfig.performances != null)
		{
			for (int i = 0; i < layer0PeakConfig.performances.Length; i++)
			{
				try
				{
					PerformanceItem performanceItem = layer0PeakConfig.performances[i];
					if (performanceItem.mustDo && performanceItem.time > layer0Peak.fromLogicPercent)
					{
						performanceItem.Fire(FindTargetResult.EntityOnly(entity), layer0Peak);
					}
				}
				catch (Exception ex)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogException(ex);
					}
					throw ex;
				}
			}
		}
		if (layer0PeakConfig.triggerAbilities != null)
		{
			for (int j = 0; j < layer0PeakConfig.triggerAbilities.Length; j++)
			{
				try
				{
					ConfigTriggerAbility configTriggerAbility = layer0PeakConfig.triggerAbilities[j];
					if (configTriggerAbility.mustDo && configTriggerAbility.time > layer0Peak.fromLogicPercent)
					{
						configTriggerAbility.triggerAbility.CheckDo(new ActionMemory(entity, entity, FindTargetResult.EntityOnly(entity)));
					}
				}
				catch (Exception ex2)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogException(ex2);
					}
					throw ex2;
				}
			}
		}
		SystemAbility abilitySystem = GameManager.abilitySystem;
		if (layer0PeakConfig.volumeClips == null)
		{
			return;
		}
		for (int k = 0; k < layer0PeakConfig.volumeClips.Length; k++)
		{
			try
			{
				VolumeLayerItem volumeLayerItem = layer0PeakConfig.volumeClips[k];
				if (layer0Peak.DoByPercentPeriod(volumeLayerItem.time, volumeLayerItem.time, mustDo: false, volumeLayerItem.CanDoPeriod()))
				{
					if (entity.IsFaceLeft() && volumeLayerItem.needCasterFaceDirToCheckVolume)
					{
						volumeLayerItem.StartVolumeClip(entity, abilitySystem.GetVolume(volumeLayerItem.volumeReference1AssetID));
					}
					else
					{
						volumeLayerItem.StartVolumeClip(entity, abilitySystem.GetVolume(volumeLayerItem.volumeReferenceAssetID));
					}
					goto IL_01cb;
				}
				if (!layer0Peak.DoByPercentPeriod(volumeLayerItem.time, volumeLayerItem.end, mustDo: false, volumeLayerItem.CanDoPeriod()))
				{
					goto IL_01cb;
				}
				if (compMotion.volumeAnimator == null)
				{
					continue;
				}
				compMotion.volumeAnimator.speed = compTime.motionFixedSpeed * compMotion.volumeSpeed;
				goto IL_01cb;
				IL_01cb:
				if (layer0Peak.DoByPercentPeriod(volumeLayerItem.end, volumeLayerItem.end, mustDo: true, volumeLayerItem.CanDoPeriod()))
				{
					if (entity.IsFaceLeft() && volumeLayerItem.needCasterFaceDirToCheckVolume)
					{
						volumeLayerItem.EndVolumeClip(entity, abilitySystem.GetVolume(volumeLayerItem.volumeReference1AssetID));
					}
					else
					{
						volumeLayerItem.EndVolumeClip(entity, abilitySystem.GetVolume(volumeLayerItem.volumeReferenceAssetID));
					}
				}
			}
			catch (Exception ex3)
			{
				throw ex3;
			}
		}
	}

	public void ForcedChangeToMotionState(Entity entity, State state)
	{
		ForcedChangeToMotionState(entity, state, 0f);
	}

	public void ForcedChangeToMotionState(Entity entity, State state, float normalizedTime)
	{
		SetMotionMustDo(entity);
		entity.GetCompMotion().layerMotionQueue[0].ForEach((FSMRuntimeState f) =>
		{
			f.toLogicWeight = (f.fromLogicWeight = 0f);
		});
		SwitchInState(entity, state, isRecoverCount: false, normalizedTime);
		entity.GetCompAbility().ClearHited();
	}

	public void RebornForcedChangeToIdle(Entity entity)
	{
		ClearMotionQueue(entity);
		State state = FindMotionState(entity, "born");
		ForcedChangeToMotionState(entity, state);
		SwitchInState(entity, state, isRecoverCount: false);
	}

	public void ForcedChangeToMotionState(Entity entity, string stateName)
	{
		State state = FindMotionState(entity, stateName);
		if (state != null)
		{
			ForcedChangeToMotionState(entity, state);
		}
	}

	public State FindMotionState(Entity entity, string name)
	{
		return entity.GetCompMotion().moveController.childrenStateLayers[0].states.Find((State e) => e.value.name == name);
	}

	public State FindAttackMotionState(Entity entity, string name)
	{
		return entity.GetCompMotion().attackController.childrenStateLayers[0].states.Find((State e) => e.value.name == name);
	}

	public void TimelineStop(Entity entity, bool force)
	{
		if (!entity.IsValid)
		{
			return;
		}
		CompPhysics compPhysics = entity.GetCompPhysics();
		CompBehave compBehave = entity.GetCompBehave();
		if (compPhysics != null && compBehave != null)
		{
			compPhysics.ClearVelocity();
			if (force)
			{
				ForcedChangeToMotionState(entity, "idle");
				GameManager.physicsSystem.ForceToGround(entity);
			}
			else if (compPhysics.isGrounded)
			{
				ForcedChangeToMotionState(entity, "idle");
			}
			else if (compPhysics.motion == MotionType.Air)
			{
				ForcedChangeToMotionState(entity, "idle_nobattle");
			}
			else
			{
				ForcedChangeToMotionState(entity, "falling");
			}
			AniPartControl aniControl = compBehave.MonoEntity.aniControl;
			if (aniControl != null)
			{
				aniControl.ResetVisibilityToVisible(AniPartControl.PartType.Dissolve);
				aniControl.ResetVisibilityToVisible(AniPartControl.PartType.SystemDither);
			}
		}
	}
}
