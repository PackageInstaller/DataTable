using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

internal class PlayerEntityStateUpload
{
	public static readonly ActionList<Vector2, float> onLeftPressed = new ActionList<Vector2, float>();

	public static readonly ActionList<Vector2, float> onRightPressed = new ActionList<Vector2, float>();

	public static readonly ActionList<Vector2, float> onUpPressed = new ActionList<Vector2, float>();

	public static readonly ActionList<Vector2, float> onDownPressed = new ActionList<Vector2, float>();

	protected float upPressTime;

	protected float downPressTime;

	protected float leftPressTime;

	protected float rightPressTime;

	public void UploadState(float[] inputs, int[] states, bool[] marks, Entity playerEntity, float fixedDeltaTime)
	{
		UploadMove(new Vector2(inputs[0], inputs[1]), marks[0], playerEntity, fixedDeltaTime);
		if (playerEntity.IsCharacter())
		{
			UploadDodge(states[2], playerEntity);
			UploadRegularAttack(states[3], playerEntity);
			UploadSkillAttack(states[4], playerEntity);
			UploadJump(states[5], playerEntity);
			UploadVibrate(states[6], playerEntity);
			UploadClaw(states[7], playerEntity);
			UploadItemShortcut(states[8], playerEntity);
			UploadInteract(states[12], playerEntity);
			UploadInteractSwitch(states[13], playerEntity);
			UploadChangeCharacter_1(states[9], playerEntity);
			UploadChangeCharacter_2(states[10], playerEntity);
			UploadChangeCharacter_3(states[11], playerEntity);
		}
	}

	public void UploadMove(Vector2 dir, bool isPressed, Entity playerEntity, float fixedDeltaTime)
	{
		CompInput compInput = playerEntity.GetCompInput();
		if (isPressed)
		{
			EInputDir dirX = compInput.dirX;
			EInputDir dirY = compInput.dirY;
			compInput.dir = dir;
			switch (dirX)
			{
			case EInputDir.Left:
				rightPressTime = 0f;
				leftPressTime += fixedDeltaTime;
				compInput.onLeftPressed.Invoke(playerEntity, leftPressTime);
				onLeftPressed.Invoke(dir, leftPressTime);
				break;
			case EInputDir.Right:
				leftPressTime = 0f;
				rightPressTime += fixedDeltaTime;
				compInput.onRightPressed.Invoke(playerEntity, rightPressTime);
				onRightPressed.Invoke(dir, rightPressTime);
				break;
			}
			switch (dirY)
			{
			case EInputDir.Up:
				downPressTime = 0f;
				upPressTime += fixedDeltaTime;
				compInput.onUpPressed.Invoke(playerEntity, upPressTime);
				onUpPressed.Invoke(dir, upPressTime);
				break;
			case EInputDir.Down:
				upPressTime = 0f;
				downPressTime += fixedDeltaTime;
				compInput.onDownPressed.Invoke(playerEntity, downPressTime);
				onDownPressed.Invoke(dir, downPressTime);
				break;
			}
		}
		else
		{
			upPressTime = (downPressTime = (rightPressTime = (leftPressTime = 0f)));
			dir = Vector2.zero;
			compInput.dir = Vector2.zero;
		}
	}

	public void UploadDodge(int pressState, Entity playerEntity)
	{
		switch (pressState)
		{
		case 3:
		{
			playerEntity.SetTrigger("Dodge");
			playerEntity.SetBool("DodgeHold", value: true);
			InputEvt evt = Singleton<EventManager>.instance.GetEvt<InputEvt>();
			evt.inputKey = InputKey.dodge;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_Down, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			break;
		}
		case 6:
			playerEntity.SetBool("DodgePress", value: true);
			break;
		case 1:
			playerEntity.SetBool("DodgePress", value: false);
			playerEntity.SetBool("DodgeHold", value: false);
			playerEntity.SetTrigger("DodgeRelease");
			break;
		case 2:
			playerEntity.SetTrigger("DodgeClick");
			playerEntity.SetBool("DodgeHold", value: false);
			break;
		case 4:
		case 5:
			break;
		}
	}

	public void UploadRegularAttack(int state, Entity playerEntity)
	{
		switch (state)
		{
		case 3:
		{
			playerEntity.SetBool("ButtonAHold", value: true);
			playerEntity.SetTrigger("ButtonA");
			playerEntity.SetBool("ButtonAPressRec", value: true);
			InputEvt evt = Singleton<EventManager>.instance.GetEvt<InputEvt>();
			evt.inputKey = InputKey.regularAttack;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_Down, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Player_Attack);
			break;
		}
		case 6:
			playerEntity.SetBool("ButtonAPress", value: true);
			break;
		case 1:
			playerEntity.SetBool("ButtonAHold", value: false);
			playerEntity.SetBool("ButtonAPress", value: false);
			playerEntity.SetTrigger("ButtonARelease");
			break;
		case 2:
			playerEntity.SetBool("ButtonAPress", value: false);
			playerEntity.SetBool("ButtonAHold", value: false);
			playerEntity.SetTrigger("ButtonAClick");
			break;
		case 5:
			playerEntity.SetBool("ButtonAPress", value: true);
			playerEntity.SetTrigger("ButtonAPressTrigger");
			break;
		case 4:
			break;
		}
	}

	public void UploadSkillAttack(int pressState, Entity playerEntity)
	{
		switch (pressState)
		{
		case 3:
		{
			playerEntity.SetBool("ButtonBHold", value: true);
			playerEntity.SetTrigger("ButtonB");
			playerEntity.SetBool("ButtonBPressRec", value: true);
			InputEvt evt = Singleton<EventManager>.instance.GetEvt<InputEvt>();
			evt.inputKey = InputKey.heavyAttack;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_Down, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.Player_SkillAttack);
			break;
		}
		case 6:
			playerEntity.SetBool("ButtonBPress", value: true);
			break;
		case 1:
			playerEntity.SetBool("ButtonBPress", value: false);
			playerEntity.SetBool("ButtonBHold", value: false);
			playerEntity.SetTrigger("ButtonBRelease");
			break;
		case 2:
			playerEntity.SetBool("ButtonBHold", value: false);
			playerEntity.SetBool("ButtonBPress", value: false);
			playerEntity.SetTrigger("ButtonBClick");
			break;
		case 5:
			playerEntity.SetBool("ButtonBPress", value: true);
			playerEntity.SetTrigger("ButtonBPressTrigger");
			break;
		case 4:
			break;
		}
	}

	public void UploadJump(int pressState, Entity playerEntity)
	{
		CompPhysics compPhysics = playerEntity.GetCompPhysics();
		CompMotion compMotion = playerEntity.GetCompMotion();
		switch (pressState)
		{
		case 3:
		{
			bool flag = compPhysics.UseGlide() && compMotion.JumpInAirCount <= 0 && !playerEntity.GetMotionBool("OnGround") && !playerEntity.GetMotionBool("ForbidGlide");
			if (compPhysics.state == ACTMovementMode.WallClimbing)
			{
				compMotion.SetTrigger("AdsorbJump");
				compMotion.SetTrigger("Jump");
			}
			else if (flag)
			{
				compMotion.SetTrigger("Glide");
			}
			else if (compPhysics.state == ACTMovementMode.Adsorbing)
			{
				if (compPhysics.adsorbingState == AdsorbingState.OnWall)
				{
					compMotion.SetTrigger("AdsorbJump");
				}
				compMotion.JumpInAirCount = playerEntity.GetConfig().jumpOffWallInAirCount;
				compMotion.SetTrigger("Jump");
			}
			else
			{
				compMotion.SetTrigger("Jump");
			}
			compMotion.SetBool("JumpHold", b: true);
			InputEvt evt = Singleton<EventManager>.instance.GetEvt<InputEvt>();
			evt.inputKey = InputKey.jump;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_Down, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			break;
		}
		case 6:
			compMotion.SetBool("JumpPress", b: true);
			break;
		case 1:
			compMotion.SetBool("JumpPress", b: false);
			compMotion.SetBool("JumpHold", b: false);
			compMotion.SetTrigger("JumpRelease");
			compPhysics.ReleaseJumpPress();
			break;
		case 2:
			playerEntity.SetBool("JumpHold", value: false);
			compPhysics.ReleaseJumpPress();
			break;
		case 4:
		case 5:
			break;
		}
	}

	public void UploadVibrate(int pressState, Entity playerEntity)
	{
		if (!playerEntity.IsCharacter())
		{
			return;
		}
		switch (pressState)
		{
		case 6:
			playerEntity.SetBool("ButtonUPress", value: true);
			break;
		case 1:
			playerEntity.SetBool("ButtonUPress", value: false);
			playerEntity.SetBool("ButtonUHold", value: false);
			playerEntity.SetTrigger("ButtonURelease");
			break;
		case 2:
			playerEntity.SetBool("ButtonUPress", value: false);
			playerEntity.SetBool("ButtonUHold", value: false);
			playerEntity.SetTrigger("ButtonUClick");
			break;
		case 3:
		{
			playerEntity.SetTrigger("ButtonU");
			playerEntity.SetBool("ButtonUHold", value: true);
			EntityCharacterData entityCharacterData = RuntimeConfigs.data.entityCharacterDatas[playerEntity.GetCompCharacter().characterSource.Id()];
			if (!(playerEntity.GetCompAbility().CurrentUltimateSkillValue < entityCharacterData.skillEnergy))
			{
				playerEntity.SetTrigger("Skill");
				InputEvt evt = Singleton<EventManager>.instance.GetEvt<InputEvt>();
				evt.inputKey = InputKey.vibrate;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_Down, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
			break;
		}
		case 4:
		case 5:
			break;
		}
	}

	public void UploadItemShortcut(int pressState, Entity playerEntity)
	{
		if (pressState == 3)
		{
			InputEvt evt = Singleton<EventManager>.instance.GetEvt<InputEvt>();
			evt.inputKey = InputKey.itemShortCut;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_Down, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public void UploadClaw(int pressState, Entity playerEntity)
	{
		if (pressState == 3)
		{
			MonoECS.instance.onClawAction?.Invoke(playerEntity);
		}
	}

	public void UploadInteract(int pressState, Entity playerEntity)
	{
		switch (pressState)
		{
		case 3:
		{
			InputInteractEvt evt3 = Singleton<EventManager>.instance.GetEvt<InputInteractEvt>();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_Interact, evt3);
			Singleton<EventManager>.instance.ReleaseEvt(evt3);
			break;
		}
		case 2:
		{
			InputInteractTab evt2 = Singleton<EventManager>.instance.GetEvt<InputInteractTab>();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_InteractTab, evt2);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
			break;
		}
		case 1:
		{
			InputInteractLongPressTab evt = Singleton<EventManager>.instance.GetEvt<InputInteractLongPressTab>();
			evt.pressTime = 0f;
			evt.isOver = true;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_InteractLongpressTab, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			break;
		}
		}
	}

	public void UploadInteractSwitch(int pressState, Entity playerEntity)
	{
		switch (pressState)
		{
		case 1:
		{
			InputInteractLongPressTab evt2 = Singleton<EventManager>.instance.GetEvt<InputInteractLongPressTab>();
			evt2.pressTime = 0f;
			evt2.isOver = true;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_InteractLongpressTab, evt2);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
			break;
		}
		case 2:
		{
			InputInteractTab evt = Singleton<EventManager>.instance.GetEvt<InputInteractTab>();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_InteractTab, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			break;
		}
		}
	}

	public void UploadChangeCharacter_1(int pressState, Entity playerEntity)
	{
		if (pressState == 3)
		{
			ChangeCharacter(playerEntity, "changeCharacter0", InputKey.switch1Character, 0);
		}
	}

	public void UploadChangeCharacter_2(int pressState, Entity playerEntity)
	{
		if (pressState == 3)
		{
			ChangeCharacter(playerEntity, "changeCharacter1", InputKey.switch2Character, 1);
		}
	}

	public void UploadChangeCharacter_3(int pressState, Entity playerEntity)
	{
		if (pressState == 3)
		{
			ChangeCharacter(playerEntity, "changeCharacter2", InputKey.switch3Character, 2);
		}
	}

	private void ChangeCharacter(Entity playerEntity, string triggerBehave, InputKey eventKey, int index)
	{
		playerEntity.SetTrigger(triggerBehave);
		InputEvt evt = Singleton<EventManager>.instance.GetEvt<InputEvt>();
		evt.inputKey = eventKey;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_Down, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		MonoECS.instance.SwitchButton(index);
	}
}
