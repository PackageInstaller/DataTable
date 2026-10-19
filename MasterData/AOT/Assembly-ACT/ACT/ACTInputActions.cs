using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.Utilities;

namespace ACT;

public class ACTInputActions : IInputActionCollection2, IInputActionCollection, IEnumerable<InputAction>, IEnumerable, IDisposable
{
	public struct PlayerActions(ACTInputActions wrapper)
	{
		private ACTInputActions m_Wrapper = wrapper;

		public InputAction Move => m_Wrapper.m_Player_Move;

		public InputAction RegularAttack => m_Wrapper.m_Player_RegularAttack;

		public InputAction SkillAttack => m_Wrapper.m_Player_SkillAttack;

		public InputAction Dodge => m_Wrapper.m_Player_Dodge;

		public InputAction Jump => m_Wrapper.m_Player_Jump;

		public InputAction Vibrate => m_Wrapper.m_Player_Vibrate;

		public InputAction ShortCut => m_Wrapper.m_Player_ShortCut;

		public InputAction Claw => m_Wrapper.m_Player_Claw;

		public InputAction Switch1Character => m_Wrapper.m_Player_Switch1Character;

		public InputAction Switch2Character => m_Wrapper.m_Player_Switch2Character;

		public InputAction Switch3Character => m_Wrapper.m_Player_Switch3Character;

		public bool enabled => Get().enabled;

		public InputActionMap Get()
		{
			return m_Wrapper.m_Player;
		}

		public void Enable()
		{
			Get().Enable();
		}

		public void Disable()
		{
			Get().Disable();
		}

		public static implicit operator InputActionMap(PlayerActions set)
		{
			return set.Get();
		}

		public void AddCallbacks(IPlayerActions instance)
		{
			if (instance != null && !m_Wrapper.m_PlayerActionsCallbackInterfaces.Contains(instance))
			{
				m_Wrapper.m_PlayerActionsCallbackInterfaces.Add(instance);
				Move.started += instance.OnMove;
				Move.performed += instance.OnMove;
				Move.canceled += instance.OnMove;
				RegularAttack.started += instance.OnRegularAttack;
				RegularAttack.performed += instance.OnRegularAttack;
				RegularAttack.canceled += instance.OnRegularAttack;
				SkillAttack.started += instance.OnSkillAttack;
				SkillAttack.performed += instance.OnSkillAttack;
				SkillAttack.canceled += instance.OnSkillAttack;
				Dodge.started += instance.OnDodge;
				Dodge.performed += instance.OnDodge;
				Dodge.canceled += instance.OnDodge;
				Jump.started += instance.OnJump;
				Jump.performed += instance.OnJump;
				Jump.canceled += instance.OnJump;
				Vibrate.started += instance.OnVibrate;
				Vibrate.performed += instance.OnVibrate;
				Vibrate.canceled += instance.OnVibrate;
				ShortCut.started += instance.OnShortCut;
				ShortCut.performed += instance.OnShortCut;
				ShortCut.canceled += instance.OnShortCut;
				Claw.started += instance.OnClaw;
				Claw.performed += instance.OnClaw;
				Claw.canceled += instance.OnClaw;
				Switch1Character.started += instance.OnSwitch1Character;
				Switch1Character.performed += instance.OnSwitch1Character;
				Switch1Character.canceled += instance.OnSwitch1Character;
				Switch2Character.started += instance.OnSwitch2Character;
				Switch2Character.performed += instance.OnSwitch2Character;
				Switch2Character.canceled += instance.OnSwitch2Character;
				Switch3Character.started += instance.OnSwitch3Character;
				Switch3Character.performed += instance.OnSwitch3Character;
				Switch3Character.canceled += instance.OnSwitch3Character;
			}
		}

		private void UnregisterCallbacks(IPlayerActions instance)
		{
			Move.started -= instance.OnMove;
			Move.performed -= instance.OnMove;
			Move.canceled -= instance.OnMove;
			RegularAttack.started -= instance.OnRegularAttack;
			RegularAttack.performed -= instance.OnRegularAttack;
			RegularAttack.canceled -= instance.OnRegularAttack;
			SkillAttack.started -= instance.OnSkillAttack;
			SkillAttack.performed -= instance.OnSkillAttack;
			SkillAttack.canceled -= instance.OnSkillAttack;
			Dodge.started -= instance.OnDodge;
			Dodge.performed -= instance.OnDodge;
			Dodge.canceled -= instance.OnDodge;
			Jump.started -= instance.OnJump;
			Jump.performed -= instance.OnJump;
			Jump.canceled -= instance.OnJump;
			Vibrate.started -= instance.OnVibrate;
			Vibrate.performed -= instance.OnVibrate;
			Vibrate.canceled -= instance.OnVibrate;
			ShortCut.started -= instance.OnShortCut;
			ShortCut.performed -= instance.OnShortCut;
			ShortCut.canceled -= instance.OnShortCut;
			Claw.started -= instance.OnClaw;
			Claw.performed -= instance.OnClaw;
			Claw.canceled -= instance.OnClaw;
			Switch1Character.started -= instance.OnSwitch1Character;
			Switch1Character.performed -= instance.OnSwitch1Character;
			Switch1Character.canceled -= instance.OnSwitch1Character;
			Switch2Character.started -= instance.OnSwitch2Character;
			Switch2Character.performed -= instance.OnSwitch2Character;
			Switch2Character.canceled -= instance.OnSwitch2Character;
			Switch3Character.started -= instance.OnSwitch3Character;
			Switch3Character.performed -= instance.OnSwitch3Character;
			Switch3Character.canceled -= instance.OnSwitch3Character;
		}

		public void RemoveCallbacks(IPlayerActions instance)
		{
			if (m_Wrapper.m_PlayerActionsCallbackInterfaces.Remove(instance))
			{
				UnregisterCallbacks(instance);
			}
		}

		public void SetCallbacks(IPlayerActions instance)
		{
			foreach (IPlayerActions playerActionsCallbackInterface in m_Wrapper.m_PlayerActionsCallbackInterfaces)
			{
				UnregisterCallbacks(playerActionsCallbackInterface);
			}
			m_Wrapper.m_PlayerActionsCallbackInterfaces.Clear();
			AddCallbacks(instance);
		}
	}

	public struct UIActions(ACTInputActions wrapper)
	{
		private ACTInputActions m_Wrapper = wrapper;

		public InputAction RightClick => m_Wrapper.m_UI_RightClick;

		public InputAction OpenAreaExplore => m_Wrapper.m_UI_OpenAreaExplore;

		public InputAction OpenSubAreaExplore => m_Wrapper.m_UI_OpenSubAreaExplore;

		public InputAction MoveMap => m_Wrapper.m_UI_MoveMap;

		public InputAction OpenTIps => m_Wrapper.m_UI_OpenTIps;

		public InputAction ImportCollect => m_Wrapper.m_UI_ImportCollect;

		public InputAction LSUpDownSelect => m_Wrapper.m_UI_LSUpDownSelect;

		public InputAction LSLeftRightSelect => m_Wrapper.m_UI_LSLeftRightSelect;

		public InputAction RSLeftRightSelect => m_Wrapper.m_UI_RSLeftRightSelect;

		public InputAction RSUpDownSelect => m_Wrapper.m_UI_RSUpDownSelect;

		public InputAction ScrollViewRightStickControl => m_Wrapper.m_UI_ScrollViewRightStickControl;

		public InputAction MiddleClick => m_Wrapper.m_UI_MiddleClick;

		public InputAction ScrollWheel => m_Wrapper.m_UI_ScrollWheel;

		public InputAction ScrollWheelY => m_Wrapper.m_UI_ScrollWheelY;

		public InputAction Click => m_Wrapper.m_UI_Click;

		public InputAction Point => m_Wrapper.m_UI_Point;

		public InputAction Navigate => m_Wrapper.m_UI_Navigate;

		public InputAction GamePadNavigate => m_Wrapper.m_UI_GamePadNavigate;

		public InputAction SwitchInteract => m_Wrapper.m_UI_SwitchInteract;

		public InputAction SwitchInteractGamePadX => m_Wrapper.m_UI_SwitchInteractGamePadX;

		public InputAction SwitchInteractGamePadY => m_Wrapper.m_UI_SwitchInteractGamePadY;

		public InputAction ZoomFovGamePadY => m_Wrapper.m_UI_ZoomFovGamePadY;

		public InputAction ZoomFovPageUp => m_Wrapper.m_UI_ZoomFovPageUp;

		public InputAction ZoomFovPageDown => m_Wrapper.m_UI_ZoomFovPageDown;

		public InputAction MenuDisc => m_Wrapper.m_UI_MenuDisc;

		public InputAction Bag => m_Wrapper.m_UI_Bag;

		public InputAction Character => m_Wrapper.m_UI_Character;

		public InputAction Summary => m_Wrapper.m_UI_Summary;

		public InputAction CardPool => m_Wrapper.m_UI_CardPool;

		public InputAction Activity => m_Wrapper.m_UI_Activity;

		public InputAction Task => m_Wrapper.m_UI_Task;

		public InputAction Team => m_Wrapper.m_UI_Team;

		public InputAction BattlePass => m_Wrapper.m_UI_BattlePass;

		public InputAction MissionTarget => m_Wrapper.m_UI_MissionTarget;

		public InputAction Map => m_Wrapper.m_UI_Map;

		public InputAction Back => m_Wrapper.m_UI_Back;

		public InputAction Esc => m_Wrapper.m_UI_Esc;

		public InputAction Interact => m_Wrapper.m_UI_Interact;

		public InputAction GM => m_Wrapper.m_UI_GM;

		public InputAction GMConsole => m_Wrapper.m_UI_GMConsole;

		public InputAction ShowCursor => m_Wrapper.m_UI_ShowCursor;

		public InputAction CommonSelect => m_Wrapper.m_UI_CommonSelect;

		public InputAction LeftSwitchRole => m_Wrapper.m_UI_LeftSwitchRole;

		public InputAction RightSwitchRole => m_Wrapper.m_UI_RightSwitchRole;

		public InputAction SelectNameInput => m_Wrapper.m_UI_SelectNameInput;

		public InputAction Confirm => m_Wrapper.m_UI_Confirm;

		public InputAction RightStickPress => m_Wrapper.m_UI_RightStickPress;

		public InputAction SNSOpenMission => m_Wrapper.m_UI_SNSOpenMission;

		public InputAction GuideToturial => m_Wrapper.m_UI_GuideToturial;

		public InputAction SpecialProppickTrigger => m_Wrapper.m_UI_SpecialProppickTrigger;

		public InputAction TextLibrary => m_Wrapper.m_UI_TextLibrary;

		public InputAction RightStickNavigate => m_Wrapper.m_UI_RightStickNavigate;

		public InputAction LeftStackPress => m_Wrapper.m_UI_LeftStackPress;

		public InputAction LeftTrigger => m_Wrapper.m_UI_LeftTrigger;

		public InputAction View => m_Wrapper.m_UI_View;

		public InputAction Start => m_Wrapper.m_UI_Start;

		public InputAction TriggerSearchInPutField => m_Wrapper.m_UI_TriggerSearchInPutField;

		public InputAction SearchSubmit => m_Wrapper.m_UI_SearchSubmit;

		public InputAction SwitchPageLeft => m_Wrapper.m_UI_SwitchPageLeft;

		public InputAction SwitchPageRight => m_Wrapper.m_UI_SwitchPageRight;

		public InputAction SwitchPageUp => m_Wrapper.m_UI_SwitchPageUp;

		public InputAction SwitchPageDown => m_Wrapper.m_UI_SwitchPageDown;

		public InputAction UISpecial1 => m_Wrapper.m_UI_UISpecial1;

		public InputAction UISpecial2 => m_Wrapper.m_UI_UISpecial2;

		public InputAction UISpecial3 => m_Wrapper.m_UI_UISpecial3;

		public InputAction UISpecial4 => m_Wrapper.m_UI_UISpecial4;

		public InputAction UISpecial5 => m_Wrapper.m_UI_UISpecial5;

		public InputAction UISpecial6 => m_Wrapper.m_UI_UISpecial6;

		public InputAction UISpecial7 => m_Wrapper.m_UI_UISpecial7;

		public InputAction UISpecial8 => m_Wrapper.m_UI_UISpecial8;

		public InputAction UISpecial9 => m_Wrapper.m_UI_UISpecial9;

		public InputAction UISpecial10 => m_Wrapper.m_UI_UISpecial10;

		public InputAction LongPressX => m_Wrapper.m_UI_LongPressX;

		public InputAction RightTrigger => m_Wrapper.m_UI_RightTrigger;

		public InputAction Next => m_Wrapper.m_UI_Next;

		public InputAction Prev => m_Wrapper.m_UI_Prev;

		public InputAction SelectItemCell => m_Wrapper.m_UI_SelectItemCell;

		public InputAction Lock => m_Wrapper.m_UI_Lock;

		public InputAction ShowCoinDetail => m_Wrapper.m_UI_ShowCoinDetail;

		public InputAction PressAnyKey => m_Wrapper.m_UI_PressAnyKey;

		public InputAction ButtonUp => m_Wrapper.m_UI_ButtonUp;

		public InputAction ButtonDown => m_Wrapper.m_UI_ButtonDown;

		public InputAction ButtonLeft => m_Wrapper.m_UI_ButtonLeft;

		public InputAction ButtonRight => m_Wrapper.m_UI_ButtonRight;

		public InputAction LSUp => m_Wrapper.m_UI_LSUp;

		public InputAction LSDown => m_Wrapper.m_UI_LSDown;

		public InputAction LSLeft => m_Wrapper.m_UI_LSLeft;

		public InputAction LSRight => m_Wrapper.m_UI_LSRight;

		public InputAction StopChallenge => m_Wrapper.m_UI_StopChallenge;

		public InputAction WorldLevelBreakTips => m_Wrapper.m_UI_WorldLevelBreakTips;

		public bool enabled => Get().enabled;

		public InputActionMap Get()
		{
			return m_Wrapper.m_UI;
		}

		public void Enable()
		{
			Get().Enable();
		}

		public void Disable()
		{
			Get().Disable();
		}

		public static implicit operator InputActionMap(UIActions set)
		{
			return set.Get();
		}

		public void AddCallbacks(IUIActions instance)
		{
			if (instance != null && !m_Wrapper.m_UIActionsCallbackInterfaces.Contains(instance))
			{
				m_Wrapper.m_UIActionsCallbackInterfaces.Add(instance);
				RightClick.started += instance.OnRightClick;
				RightClick.performed += instance.OnRightClick;
				RightClick.canceled += instance.OnRightClick;
				OpenAreaExplore.started += instance.OnOpenAreaExplore;
				OpenAreaExplore.performed += instance.OnOpenAreaExplore;
				OpenAreaExplore.canceled += instance.OnOpenAreaExplore;
				OpenSubAreaExplore.started += instance.OnOpenSubAreaExplore;
				OpenSubAreaExplore.performed += instance.OnOpenSubAreaExplore;
				OpenSubAreaExplore.canceled += instance.OnOpenSubAreaExplore;
				MoveMap.started += instance.OnMoveMap;
				MoveMap.performed += instance.OnMoveMap;
				MoveMap.canceled += instance.OnMoveMap;
				OpenTIps.started += instance.OnOpenTIps;
				OpenTIps.performed += instance.OnOpenTIps;
				OpenTIps.canceled += instance.OnOpenTIps;
				ImportCollect.started += instance.OnImportCollect;
				ImportCollect.performed += instance.OnImportCollect;
				ImportCollect.canceled += instance.OnImportCollect;
				LSUpDownSelect.started += instance.OnLSUpDownSelect;
				LSUpDownSelect.performed += instance.OnLSUpDownSelect;
				LSUpDownSelect.canceled += instance.OnLSUpDownSelect;
				LSLeftRightSelect.started += instance.OnLSLeftRightSelect;
				LSLeftRightSelect.performed += instance.OnLSLeftRightSelect;
				LSLeftRightSelect.canceled += instance.OnLSLeftRightSelect;
				RSLeftRightSelect.started += instance.OnRSLeftRightSelect;
				RSLeftRightSelect.performed += instance.OnRSLeftRightSelect;
				RSLeftRightSelect.canceled += instance.OnRSLeftRightSelect;
				RSUpDownSelect.started += instance.OnRSUpDownSelect;
				RSUpDownSelect.performed += instance.OnRSUpDownSelect;
				RSUpDownSelect.canceled += instance.OnRSUpDownSelect;
				ScrollViewRightStickControl.started += instance.OnScrollViewRightStickControl;
				ScrollViewRightStickControl.performed += instance.OnScrollViewRightStickControl;
				ScrollViewRightStickControl.canceled += instance.OnScrollViewRightStickControl;
				MiddleClick.started += instance.OnMiddleClick;
				MiddleClick.performed += instance.OnMiddleClick;
				MiddleClick.canceled += instance.OnMiddleClick;
				ScrollWheel.started += instance.OnScrollWheel;
				ScrollWheel.performed += instance.OnScrollWheel;
				ScrollWheel.canceled += instance.OnScrollWheel;
				ScrollWheelY.started += instance.OnScrollWheelY;
				ScrollWheelY.performed += instance.OnScrollWheelY;
				ScrollWheelY.canceled += instance.OnScrollWheelY;
				Click.started += instance.OnClick;
				Click.performed += instance.OnClick;
				Click.canceled += instance.OnClick;
				Point.started += instance.OnPoint;
				Point.performed += instance.OnPoint;
				Point.canceled += instance.OnPoint;
				Navigate.started += instance.OnNavigate;
				Navigate.performed += instance.OnNavigate;
				Navigate.canceled += instance.OnNavigate;
				GamePadNavigate.started += instance.OnGamePadNavigate;
				GamePadNavigate.performed += instance.OnGamePadNavigate;
				GamePadNavigate.canceled += instance.OnGamePadNavigate;
				SwitchInteract.started += instance.OnSwitchInteract;
				SwitchInteract.performed += instance.OnSwitchInteract;
				SwitchInteract.canceled += instance.OnSwitchInteract;
				SwitchInteractGamePadX.started += instance.OnSwitchInteractGamePadX;
				SwitchInteractGamePadX.performed += instance.OnSwitchInteractGamePadX;
				SwitchInteractGamePadX.canceled += instance.OnSwitchInteractGamePadX;
				SwitchInteractGamePadY.started += instance.OnSwitchInteractGamePadY;
				SwitchInteractGamePadY.performed += instance.OnSwitchInteractGamePadY;
				SwitchInteractGamePadY.canceled += instance.OnSwitchInteractGamePadY;
				ZoomFovGamePadY.started += instance.OnZoomFovGamePadY;
				ZoomFovGamePadY.performed += instance.OnZoomFovGamePadY;
				ZoomFovGamePadY.canceled += instance.OnZoomFovGamePadY;
				ZoomFovPageUp.started += instance.OnZoomFovPageUp;
				ZoomFovPageUp.performed += instance.OnZoomFovPageUp;
				ZoomFovPageUp.canceled += instance.OnZoomFovPageUp;
				ZoomFovPageDown.started += instance.OnZoomFovPageDown;
				ZoomFovPageDown.performed += instance.OnZoomFovPageDown;
				ZoomFovPageDown.canceled += instance.OnZoomFovPageDown;
				MenuDisc.started += instance.OnMenuDisc;
				MenuDisc.performed += instance.OnMenuDisc;
				MenuDisc.canceled += instance.OnMenuDisc;
				Bag.started += instance.OnBag;
				Bag.performed += instance.OnBag;
				Bag.canceled += instance.OnBag;
				Character.started += instance.OnCharacter;
				Character.performed += instance.OnCharacter;
				Character.canceled += instance.OnCharacter;
				Summary.started += instance.OnSummary;
				Summary.performed += instance.OnSummary;
				Summary.canceled += instance.OnSummary;
				CardPool.started += instance.OnCardPool;
				CardPool.performed += instance.OnCardPool;
				CardPool.canceled += instance.OnCardPool;
				Activity.started += instance.OnActivity;
				Activity.performed += instance.OnActivity;
				Activity.canceled += instance.OnActivity;
				Task.started += instance.OnTask;
				Task.performed += instance.OnTask;
				Task.canceled += instance.OnTask;
				Team.started += instance.OnTeam;
				Team.performed += instance.OnTeam;
				Team.canceled += instance.OnTeam;
				BattlePass.started += instance.OnBattlePass;
				BattlePass.performed += instance.OnBattlePass;
				BattlePass.canceled += instance.OnBattlePass;
				MissionTarget.started += instance.OnMissionTarget;
				MissionTarget.performed += instance.OnMissionTarget;
				MissionTarget.canceled += instance.OnMissionTarget;
				Map.started += instance.OnMap;
				Map.performed += instance.OnMap;
				Map.canceled += instance.OnMap;
				Back.started += instance.OnBack;
				Back.performed += instance.OnBack;
				Back.canceled += instance.OnBack;
				Esc.started += instance.OnEsc;
				Esc.performed += instance.OnEsc;
				Esc.canceled += instance.OnEsc;
				Interact.started += instance.OnInteract;
				Interact.performed += instance.OnInteract;
				Interact.canceled += instance.OnInteract;
				GM.started += instance.OnGM;
				GM.performed += instance.OnGM;
				GM.canceled += instance.OnGM;
				GMConsole.started += instance.OnGMConsole;
				GMConsole.performed += instance.OnGMConsole;
				GMConsole.canceled += instance.OnGMConsole;
				ShowCursor.started += instance.OnShowCursor;
				ShowCursor.performed += instance.OnShowCursor;
				ShowCursor.canceled += instance.OnShowCursor;
				CommonSelect.started += instance.OnCommonSelect;
				CommonSelect.performed += instance.OnCommonSelect;
				CommonSelect.canceled += instance.OnCommonSelect;
				LeftSwitchRole.started += instance.OnLeftSwitchRole;
				LeftSwitchRole.performed += instance.OnLeftSwitchRole;
				LeftSwitchRole.canceled += instance.OnLeftSwitchRole;
				RightSwitchRole.started += instance.OnRightSwitchRole;
				RightSwitchRole.performed += instance.OnRightSwitchRole;
				RightSwitchRole.canceled += instance.OnRightSwitchRole;
				SelectNameInput.started += instance.OnSelectNameInput;
				SelectNameInput.performed += instance.OnSelectNameInput;
				SelectNameInput.canceled += instance.OnSelectNameInput;
				Confirm.started += instance.OnConfirm;
				Confirm.performed += instance.OnConfirm;
				Confirm.canceled += instance.OnConfirm;
				RightStickPress.started += instance.OnRightStickPress;
				RightStickPress.performed += instance.OnRightStickPress;
				RightStickPress.canceled += instance.OnRightStickPress;
				SNSOpenMission.started += instance.OnSNSOpenMission;
				SNSOpenMission.performed += instance.OnSNSOpenMission;
				SNSOpenMission.canceled += instance.OnSNSOpenMission;
				GuideToturial.started += instance.OnGuideToturial;
				GuideToturial.performed += instance.OnGuideToturial;
				GuideToturial.canceled += instance.OnGuideToturial;
				SpecialProppickTrigger.started += instance.OnSpecialProppickTrigger;
				SpecialProppickTrigger.performed += instance.OnSpecialProppickTrigger;
				SpecialProppickTrigger.canceled += instance.OnSpecialProppickTrigger;
				TextLibrary.started += instance.OnTextLibrary;
				TextLibrary.performed += instance.OnTextLibrary;
				TextLibrary.canceled += instance.OnTextLibrary;
				RightStickNavigate.started += instance.OnRightStickNavigate;
				RightStickNavigate.performed += instance.OnRightStickNavigate;
				RightStickNavigate.canceled += instance.OnRightStickNavigate;
				LeftStackPress.started += instance.OnLeftStackPress;
				LeftStackPress.performed += instance.OnLeftStackPress;
				LeftStackPress.canceled += instance.OnLeftStackPress;
				LeftTrigger.started += instance.OnLeftTrigger;
				LeftTrigger.performed += instance.OnLeftTrigger;
				LeftTrigger.canceled += instance.OnLeftTrigger;
				View.started += instance.OnView;
				View.performed += instance.OnView;
				View.canceled += instance.OnView;
				Start.started += instance.OnStart;
				Start.performed += instance.OnStart;
				Start.canceled += instance.OnStart;
				TriggerSearchInPutField.started += instance.OnTriggerSearchInPutField;
				TriggerSearchInPutField.performed += instance.OnTriggerSearchInPutField;
				TriggerSearchInPutField.canceled += instance.OnTriggerSearchInPutField;
				SearchSubmit.started += instance.OnSearchSubmit;
				SearchSubmit.performed += instance.OnSearchSubmit;
				SearchSubmit.canceled += instance.OnSearchSubmit;
				SwitchPageLeft.started += instance.OnSwitchPageLeft;
				SwitchPageLeft.performed += instance.OnSwitchPageLeft;
				SwitchPageLeft.canceled += instance.OnSwitchPageLeft;
				SwitchPageRight.started += instance.OnSwitchPageRight;
				SwitchPageRight.performed += instance.OnSwitchPageRight;
				SwitchPageRight.canceled += instance.OnSwitchPageRight;
				SwitchPageUp.started += instance.OnSwitchPageUp;
				SwitchPageUp.performed += instance.OnSwitchPageUp;
				SwitchPageUp.canceled += instance.OnSwitchPageUp;
				SwitchPageDown.started += instance.OnSwitchPageDown;
				SwitchPageDown.performed += instance.OnSwitchPageDown;
				SwitchPageDown.canceled += instance.OnSwitchPageDown;
				UISpecial1.started += instance.OnUISpecial1;
				UISpecial1.performed += instance.OnUISpecial1;
				UISpecial1.canceled += instance.OnUISpecial1;
				UISpecial2.started += instance.OnUISpecial2;
				UISpecial2.performed += instance.OnUISpecial2;
				UISpecial2.canceled += instance.OnUISpecial2;
				UISpecial3.started += instance.OnUISpecial3;
				UISpecial3.performed += instance.OnUISpecial3;
				UISpecial3.canceled += instance.OnUISpecial3;
				UISpecial4.started += instance.OnUISpecial4;
				UISpecial4.performed += instance.OnUISpecial4;
				UISpecial4.canceled += instance.OnUISpecial4;
				UISpecial5.started += instance.OnUISpecial5;
				UISpecial5.performed += instance.OnUISpecial5;
				UISpecial5.canceled += instance.OnUISpecial5;
				UISpecial6.started += instance.OnUISpecial6;
				UISpecial6.performed += instance.OnUISpecial6;
				UISpecial6.canceled += instance.OnUISpecial6;
				UISpecial7.started += instance.OnUISpecial7;
				UISpecial7.performed += instance.OnUISpecial7;
				UISpecial7.canceled += instance.OnUISpecial7;
				UISpecial8.started += instance.OnUISpecial8;
				UISpecial8.performed += instance.OnUISpecial8;
				UISpecial8.canceled += instance.OnUISpecial8;
				UISpecial9.started += instance.OnUISpecial9;
				UISpecial9.performed += instance.OnUISpecial9;
				UISpecial9.canceled += instance.OnUISpecial9;
				UISpecial10.started += instance.OnUISpecial10;
				UISpecial10.performed += instance.OnUISpecial10;
				UISpecial10.canceled += instance.OnUISpecial10;
				LongPressX.started += instance.OnLongPressX;
				LongPressX.performed += instance.OnLongPressX;
				LongPressX.canceled += instance.OnLongPressX;
				RightTrigger.started += instance.OnRightTrigger;
				RightTrigger.performed += instance.OnRightTrigger;
				RightTrigger.canceled += instance.OnRightTrigger;
				Next.started += instance.OnNext;
				Next.performed += instance.OnNext;
				Next.canceled += instance.OnNext;
				Prev.started += instance.OnPrev;
				Prev.performed += instance.OnPrev;
				Prev.canceled += instance.OnPrev;
				SelectItemCell.started += instance.OnSelectItemCell;
				SelectItemCell.performed += instance.OnSelectItemCell;
				SelectItemCell.canceled += instance.OnSelectItemCell;
				Lock.started += instance.OnLock;
				Lock.performed += instance.OnLock;
				Lock.canceled += instance.OnLock;
				ShowCoinDetail.started += instance.OnShowCoinDetail;
				ShowCoinDetail.performed += instance.OnShowCoinDetail;
				ShowCoinDetail.canceled += instance.OnShowCoinDetail;
				PressAnyKey.started += instance.OnPressAnyKey;
				PressAnyKey.performed += instance.OnPressAnyKey;
				PressAnyKey.canceled += instance.OnPressAnyKey;
				ButtonUp.started += instance.OnButtonUp;
				ButtonUp.performed += instance.OnButtonUp;
				ButtonUp.canceled += instance.OnButtonUp;
				ButtonDown.started += instance.OnButtonDown;
				ButtonDown.performed += instance.OnButtonDown;
				ButtonDown.canceled += instance.OnButtonDown;
				ButtonLeft.started += instance.OnButtonLeft;
				ButtonLeft.performed += instance.OnButtonLeft;
				ButtonLeft.canceled += instance.OnButtonLeft;
				ButtonRight.started += instance.OnButtonRight;
				ButtonRight.performed += instance.OnButtonRight;
				ButtonRight.canceled += instance.OnButtonRight;
				LSUp.started += instance.OnLSUp;
				LSUp.performed += instance.OnLSUp;
				LSUp.canceled += instance.OnLSUp;
				LSDown.started += instance.OnLSDown;
				LSDown.performed += instance.OnLSDown;
				LSDown.canceled += instance.OnLSDown;
				LSLeft.started += instance.OnLSLeft;
				LSLeft.performed += instance.OnLSLeft;
				LSLeft.canceled += instance.OnLSLeft;
				LSRight.started += instance.OnLSRight;
				LSRight.performed += instance.OnLSRight;
				LSRight.canceled += instance.OnLSRight;
				StopChallenge.started += instance.OnStopChallenge;
				StopChallenge.performed += instance.OnStopChallenge;
				StopChallenge.canceled += instance.OnStopChallenge;
				WorldLevelBreakTips.started += instance.OnWorldLevelBreakTips;
				WorldLevelBreakTips.performed += instance.OnWorldLevelBreakTips;
				WorldLevelBreakTips.canceled += instance.OnWorldLevelBreakTips;
			}
		}

		private void UnregisterCallbacks(IUIActions instance)
		{
			RightClick.started -= instance.OnRightClick;
			RightClick.performed -= instance.OnRightClick;
			RightClick.canceled -= instance.OnRightClick;
			OpenAreaExplore.started -= instance.OnOpenAreaExplore;
			OpenAreaExplore.performed -= instance.OnOpenAreaExplore;
			OpenAreaExplore.canceled -= instance.OnOpenAreaExplore;
			OpenSubAreaExplore.started -= instance.OnOpenSubAreaExplore;
			OpenSubAreaExplore.performed -= instance.OnOpenSubAreaExplore;
			OpenSubAreaExplore.canceled -= instance.OnOpenSubAreaExplore;
			MoveMap.started -= instance.OnMoveMap;
			MoveMap.performed -= instance.OnMoveMap;
			MoveMap.canceled -= instance.OnMoveMap;
			OpenTIps.started -= instance.OnOpenTIps;
			OpenTIps.performed -= instance.OnOpenTIps;
			OpenTIps.canceled -= instance.OnOpenTIps;
			ImportCollect.started -= instance.OnImportCollect;
			ImportCollect.performed -= instance.OnImportCollect;
			ImportCollect.canceled -= instance.OnImportCollect;
			LSUpDownSelect.started -= instance.OnLSUpDownSelect;
			LSUpDownSelect.performed -= instance.OnLSUpDownSelect;
			LSUpDownSelect.canceled -= instance.OnLSUpDownSelect;
			LSLeftRightSelect.started -= instance.OnLSLeftRightSelect;
			LSLeftRightSelect.performed -= instance.OnLSLeftRightSelect;
			LSLeftRightSelect.canceled -= instance.OnLSLeftRightSelect;
			RSLeftRightSelect.started -= instance.OnRSLeftRightSelect;
			RSLeftRightSelect.performed -= instance.OnRSLeftRightSelect;
			RSLeftRightSelect.canceled -= instance.OnRSLeftRightSelect;
			RSUpDownSelect.started -= instance.OnRSUpDownSelect;
			RSUpDownSelect.performed -= instance.OnRSUpDownSelect;
			RSUpDownSelect.canceled -= instance.OnRSUpDownSelect;
			ScrollViewRightStickControl.started -= instance.OnScrollViewRightStickControl;
			ScrollViewRightStickControl.performed -= instance.OnScrollViewRightStickControl;
			ScrollViewRightStickControl.canceled -= instance.OnScrollViewRightStickControl;
			MiddleClick.started -= instance.OnMiddleClick;
			MiddleClick.performed -= instance.OnMiddleClick;
			MiddleClick.canceled -= instance.OnMiddleClick;
			ScrollWheel.started -= instance.OnScrollWheel;
			ScrollWheel.performed -= instance.OnScrollWheel;
			ScrollWheel.canceled -= instance.OnScrollWheel;
			ScrollWheelY.started -= instance.OnScrollWheelY;
			ScrollWheelY.performed -= instance.OnScrollWheelY;
			ScrollWheelY.canceled -= instance.OnScrollWheelY;
			Click.started -= instance.OnClick;
			Click.performed -= instance.OnClick;
			Click.canceled -= instance.OnClick;
			Point.started -= instance.OnPoint;
			Point.performed -= instance.OnPoint;
			Point.canceled -= instance.OnPoint;
			Navigate.started -= instance.OnNavigate;
			Navigate.performed -= instance.OnNavigate;
			Navigate.canceled -= instance.OnNavigate;
			GamePadNavigate.started -= instance.OnGamePadNavigate;
			GamePadNavigate.performed -= instance.OnGamePadNavigate;
			GamePadNavigate.canceled -= instance.OnGamePadNavigate;
			SwitchInteract.started -= instance.OnSwitchInteract;
			SwitchInteract.performed -= instance.OnSwitchInteract;
			SwitchInteract.canceled -= instance.OnSwitchInteract;
			SwitchInteractGamePadX.started -= instance.OnSwitchInteractGamePadX;
			SwitchInteractGamePadX.performed -= instance.OnSwitchInteractGamePadX;
			SwitchInteractGamePadX.canceled -= instance.OnSwitchInteractGamePadX;
			SwitchInteractGamePadY.started -= instance.OnSwitchInteractGamePadY;
			SwitchInteractGamePadY.performed -= instance.OnSwitchInteractGamePadY;
			SwitchInteractGamePadY.canceled -= instance.OnSwitchInteractGamePadY;
			ZoomFovGamePadY.started -= instance.OnZoomFovGamePadY;
			ZoomFovGamePadY.performed -= instance.OnZoomFovGamePadY;
			ZoomFovGamePadY.canceled -= instance.OnZoomFovGamePadY;
			ZoomFovPageUp.started -= instance.OnZoomFovPageUp;
			ZoomFovPageUp.performed -= instance.OnZoomFovPageUp;
			ZoomFovPageUp.canceled -= instance.OnZoomFovPageUp;
			ZoomFovPageDown.started -= instance.OnZoomFovPageDown;
			ZoomFovPageDown.performed -= instance.OnZoomFovPageDown;
			ZoomFovPageDown.canceled -= instance.OnZoomFovPageDown;
			MenuDisc.started -= instance.OnMenuDisc;
			MenuDisc.performed -= instance.OnMenuDisc;
			MenuDisc.canceled -= instance.OnMenuDisc;
			Bag.started -= instance.OnBag;
			Bag.performed -= instance.OnBag;
			Bag.canceled -= instance.OnBag;
			Character.started -= instance.OnCharacter;
			Character.performed -= instance.OnCharacter;
			Character.canceled -= instance.OnCharacter;
			Summary.started -= instance.OnSummary;
			Summary.performed -= instance.OnSummary;
			Summary.canceled -= instance.OnSummary;
			CardPool.started -= instance.OnCardPool;
			CardPool.performed -= instance.OnCardPool;
			CardPool.canceled -= instance.OnCardPool;
			Activity.started -= instance.OnActivity;
			Activity.performed -= instance.OnActivity;
			Activity.canceled -= instance.OnActivity;
			Task.started -= instance.OnTask;
			Task.performed -= instance.OnTask;
			Task.canceled -= instance.OnTask;
			Team.started -= instance.OnTeam;
			Team.performed -= instance.OnTeam;
			Team.canceled -= instance.OnTeam;
			BattlePass.started -= instance.OnBattlePass;
			BattlePass.performed -= instance.OnBattlePass;
			BattlePass.canceled -= instance.OnBattlePass;
			MissionTarget.started -= instance.OnMissionTarget;
			MissionTarget.performed -= instance.OnMissionTarget;
			MissionTarget.canceled -= instance.OnMissionTarget;
			Map.started -= instance.OnMap;
			Map.performed -= instance.OnMap;
			Map.canceled -= instance.OnMap;
			Back.started -= instance.OnBack;
			Back.performed -= instance.OnBack;
			Back.canceled -= instance.OnBack;
			Esc.started -= instance.OnEsc;
			Esc.performed -= instance.OnEsc;
			Esc.canceled -= instance.OnEsc;
			Interact.started -= instance.OnInteract;
			Interact.performed -= instance.OnInteract;
			Interact.canceled -= instance.OnInteract;
			GM.started -= instance.OnGM;
			GM.performed -= instance.OnGM;
			GM.canceled -= instance.OnGM;
			GMConsole.started -= instance.OnGMConsole;
			GMConsole.performed -= instance.OnGMConsole;
			GMConsole.canceled -= instance.OnGMConsole;
			ShowCursor.started -= instance.OnShowCursor;
			ShowCursor.performed -= instance.OnShowCursor;
			ShowCursor.canceled -= instance.OnShowCursor;
			CommonSelect.started -= instance.OnCommonSelect;
			CommonSelect.performed -= instance.OnCommonSelect;
			CommonSelect.canceled -= instance.OnCommonSelect;
			LeftSwitchRole.started -= instance.OnLeftSwitchRole;
			LeftSwitchRole.performed -= instance.OnLeftSwitchRole;
			LeftSwitchRole.canceled -= instance.OnLeftSwitchRole;
			RightSwitchRole.started -= instance.OnRightSwitchRole;
			RightSwitchRole.performed -= instance.OnRightSwitchRole;
			RightSwitchRole.canceled -= instance.OnRightSwitchRole;
			SelectNameInput.started -= instance.OnSelectNameInput;
			SelectNameInput.performed -= instance.OnSelectNameInput;
			SelectNameInput.canceled -= instance.OnSelectNameInput;
			Confirm.started -= instance.OnConfirm;
			Confirm.performed -= instance.OnConfirm;
			Confirm.canceled -= instance.OnConfirm;
			RightStickPress.started -= instance.OnRightStickPress;
			RightStickPress.performed -= instance.OnRightStickPress;
			RightStickPress.canceled -= instance.OnRightStickPress;
			SNSOpenMission.started -= instance.OnSNSOpenMission;
			SNSOpenMission.performed -= instance.OnSNSOpenMission;
			SNSOpenMission.canceled -= instance.OnSNSOpenMission;
			GuideToturial.started -= instance.OnGuideToturial;
			GuideToturial.performed -= instance.OnGuideToturial;
			GuideToturial.canceled -= instance.OnGuideToturial;
			SpecialProppickTrigger.started -= instance.OnSpecialProppickTrigger;
			SpecialProppickTrigger.performed -= instance.OnSpecialProppickTrigger;
			SpecialProppickTrigger.canceled -= instance.OnSpecialProppickTrigger;
			TextLibrary.started -= instance.OnTextLibrary;
			TextLibrary.performed -= instance.OnTextLibrary;
			TextLibrary.canceled -= instance.OnTextLibrary;
			RightStickNavigate.started -= instance.OnRightStickNavigate;
			RightStickNavigate.performed -= instance.OnRightStickNavigate;
			RightStickNavigate.canceled -= instance.OnRightStickNavigate;
			LeftStackPress.started -= instance.OnLeftStackPress;
			LeftStackPress.performed -= instance.OnLeftStackPress;
			LeftStackPress.canceled -= instance.OnLeftStackPress;
			LeftTrigger.started -= instance.OnLeftTrigger;
			LeftTrigger.performed -= instance.OnLeftTrigger;
			LeftTrigger.canceled -= instance.OnLeftTrigger;
			View.started -= instance.OnView;
			View.performed -= instance.OnView;
			View.canceled -= instance.OnView;
			Start.started -= instance.OnStart;
			Start.performed -= instance.OnStart;
			Start.canceled -= instance.OnStart;
			TriggerSearchInPutField.started -= instance.OnTriggerSearchInPutField;
			TriggerSearchInPutField.performed -= instance.OnTriggerSearchInPutField;
			TriggerSearchInPutField.canceled -= instance.OnTriggerSearchInPutField;
			SearchSubmit.started -= instance.OnSearchSubmit;
			SearchSubmit.performed -= instance.OnSearchSubmit;
			SearchSubmit.canceled -= instance.OnSearchSubmit;
			SwitchPageLeft.started -= instance.OnSwitchPageLeft;
			SwitchPageLeft.performed -= instance.OnSwitchPageLeft;
			SwitchPageLeft.canceled -= instance.OnSwitchPageLeft;
			SwitchPageRight.started -= instance.OnSwitchPageRight;
			SwitchPageRight.performed -= instance.OnSwitchPageRight;
			SwitchPageRight.canceled -= instance.OnSwitchPageRight;
			SwitchPageUp.started -= instance.OnSwitchPageUp;
			SwitchPageUp.performed -= instance.OnSwitchPageUp;
			SwitchPageUp.canceled -= instance.OnSwitchPageUp;
			SwitchPageDown.started -= instance.OnSwitchPageDown;
			SwitchPageDown.performed -= instance.OnSwitchPageDown;
			SwitchPageDown.canceled -= instance.OnSwitchPageDown;
			UISpecial1.started -= instance.OnUISpecial1;
			UISpecial1.performed -= instance.OnUISpecial1;
			UISpecial1.canceled -= instance.OnUISpecial1;
			UISpecial2.started -= instance.OnUISpecial2;
			UISpecial2.performed -= instance.OnUISpecial2;
			UISpecial2.canceled -= instance.OnUISpecial2;
			UISpecial3.started -= instance.OnUISpecial3;
			UISpecial3.performed -= instance.OnUISpecial3;
			UISpecial3.canceled -= instance.OnUISpecial3;
			UISpecial4.started -= instance.OnUISpecial4;
			UISpecial4.performed -= instance.OnUISpecial4;
			UISpecial4.canceled -= instance.OnUISpecial4;
			UISpecial5.started -= instance.OnUISpecial5;
			UISpecial5.performed -= instance.OnUISpecial5;
			UISpecial5.canceled -= instance.OnUISpecial5;
			UISpecial6.started -= instance.OnUISpecial6;
			UISpecial6.performed -= instance.OnUISpecial6;
			UISpecial6.canceled -= instance.OnUISpecial6;
			UISpecial7.started -= instance.OnUISpecial7;
			UISpecial7.performed -= instance.OnUISpecial7;
			UISpecial7.canceled -= instance.OnUISpecial7;
			UISpecial8.started -= instance.OnUISpecial8;
			UISpecial8.performed -= instance.OnUISpecial8;
			UISpecial8.canceled -= instance.OnUISpecial8;
			UISpecial9.started -= instance.OnUISpecial9;
			UISpecial9.performed -= instance.OnUISpecial9;
			UISpecial9.canceled -= instance.OnUISpecial9;
			UISpecial10.started -= instance.OnUISpecial10;
			UISpecial10.performed -= instance.OnUISpecial10;
			UISpecial10.canceled -= instance.OnUISpecial10;
			LongPressX.started -= instance.OnLongPressX;
			LongPressX.performed -= instance.OnLongPressX;
			LongPressX.canceled -= instance.OnLongPressX;
			RightTrigger.started -= instance.OnRightTrigger;
			RightTrigger.performed -= instance.OnRightTrigger;
			RightTrigger.canceled -= instance.OnRightTrigger;
			Next.started -= instance.OnNext;
			Next.performed -= instance.OnNext;
			Next.canceled -= instance.OnNext;
			Prev.started -= instance.OnPrev;
			Prev.performed -= instance.OnPrev;
			Prev.canceled -= instance.OnPrev;
			SelectItemCell.started -= instance.OnSelectItemCell;
			SelectItemCell.performed -= instance.OnSelectItemCell;
			SelectItemCell.canceled -= instance.OnSelectItemCell;
			Lock.started -= instance.OnLock;
			Lock.performed -= instance.OnLock;
			Lock.canceled -= instance.OnLock;
			ShowCoinDetail.started -= instance.OnShowCoinDetail;
			ShowCoinDetail.performed -= instance.OnShowCoinDetail;
			ShowCoinDetail.canceled -= instance.OnShowCoinDetail;
			PressAnyKey.started -= instance.OnPressAnyKey;
			PressAnyKey.performed -= instance.OnPressAnyKey;
			PressAnyKey.canceled -= instance.OnPressAnyKey;
			ButtonUp.started -= instance.OnButtonUp;
			ButtonUp.performed -= instance.OnButtonUp;
			ButtonUp.canceled -= instance.OnButtonUp;
			ButtonDown.started -= instance.OnButtonDown;
			ButtonDown.performed -= instance.OnButtonDown;
			ButtonDown.canceled -= instance.OnButtonDown;
			ButtonLeft.started -= instance.OnButtonLeft;
			ButtonLeft.performed -= instance.OnButtonLeft;
			ButtonLeft.canceled -= instance.OnButtonLeft;
			ButtonRight.started -= instance.OnButtonRight;
			ButtonRight.performed -= instance.OnButtonRight;
			ButtonRight.canceled -= instance.OnButtonRight;
			LSUp.started -= instance.OnLSUp;
			LSUp.performed -= instance.OnLSUp;
			LSUp.canceled -= instance.OnLSUp;
			LSDown.started -= instance.OnLSDown;
			LSDown.performed -= instance.OnLSDown;
			LSDown.canceled -= instance.OnLSDown;
			LSLeft.started -= instance.OnLSLeft;
			LSLeft.performed -= instance.OnLSLeft;
			LSLeft.canceled -= instance.OnLSLeft;
			LSRight.started -= instance.OnLSRight;
			LSRight.performed -= instance.OnLSRight;
			LSRight.canceled -= instance.OnLSRight;
			StopChallenge.started -= instance.OnStopChallenge;
			StopChallenge.performed -= instance.OnStopChallenge;
			StopChallenge.canceled -= instance.OnStopChallenge;
			WorldLevelBreakTips.started -= instance.OnWorldLevelBreakTips;
			WorldLevelBreakTips.performed -= instance.OnWorldLevelBreakTips;
			WorldLevelBreakTips.canceled -= instance.OnWorldLevelBreakTips;
		}

		public void RemoveCallbacks(IUIActions instance)
		{
			if (m_Wrapper.m_UIActionsCallbackInterfaces.Remove(instance))
			{
				UnregisterCallbacks(instance);
			}
		}

		public void SetCallbacks(IUIActions instance)
		{
			foreach (IUIActions uIActionsCallbackInterface in m_Wrapper.m_UIActionsCallbackInterfaces)
			{
				UnregisterCallbacks(uIActionsCallbackInterface);
			}
			m_Wrapper.m_UIActionsCallbackInterfaces.Clear();
			AddCallbacks(instance);
		}
	}

	public struct LargeMapViewActions(ACTInputActions wrapper)
	{
		private ACTInputActions m_Wrapper = wrapper;

		public InputAction mapScaleReduce => m_Wrapper.m_LargeMapView_mapScaleReduce;

		public InputAction mapScaleReduceFloat => m_Wrapper.m_LargeMapView_mapScaleReduceFloat;

		public InputAction mapScaleAdd => m_Wrapper.m_LargeMapView_mapScaleAdd;

		public InputAction mapScaleAddFloat => m_Wrapper.m_LargeMapView_mapScaleAddFloat;

		public InputAction Select => m_Wrapper.m_LargeMapView_Select;

		public InputAction MapItem => m_Wrapper.m_LargeMapView_MapItem;

		public InputAction Return => m_Wrapper.m_LargeMapView_Return;

		public InputAction MapCollection => m_Wrapper.m_LargeMapView_MapCollection;

		public InputAction WorldMap => m_Wrapper.m_LargeMapView_WorldMap;

		public InputAction MapTemple => m_Wrapper.m_LargeMapView_MapTemple;

		public InputAction Delete => m_Wrapper.m_LargeMapView_Delete;

		public InputAction MoveMap => m_Wrapper.m_LargeMapView_MoveMap;

		public InputAction MoveCursor => m_Wrapper.m_LargeMapView_MoveCursor;

		public InputAction BackToPlayer => m_Wrapper.m_LargeMapView_BackToPlayer;

		public InputAction WorldMapChooseLast => m_Wrapper.m_LargeMapView_WorldMapChooseLast;

		public InputAction WorldMapChooseNext => m_Wrapper.m_LargeMapView_WorldMapChooseNext;

		public InputAction MapSideInfoLast => m_Wrapper.m_LargeMapView_MapSideInfoLast;

		public InputAction MapSideInfoNext => m_Wrapper.m_LargeMapView_MapSideInfoNext;

		public InputAction ChangeToSelectItem => m_Wrapper.m_LargeMapView_ChangeToSelectItem;

		public InputAction BackToTarget => m_Wrapper.m_LargeMapView_BackToTarget;

		public InputAction Up => m_Wrapper.m_LargeMapView_Up;

		public InputAction Down => m_Wrapper.m_LargeMapView_Down;

		public InputAction Left => m_Wrapper.m_LargeMapView_Left;

		public InputAction Right => m_Wrapper.m_LargeMapView_Right;

		public bool enabled => Get().enabled;

		public InputActionMap Get()
		{
			return m_Wrapper.m_LargeMapView;
		}

		public void Enable()
		{
			Get().Enable();
		}

		public void Disable()
		{
			Get().Disable();
		}

		public static implicit operator InputActionMap(LargeMapViewActions set)
		{
			return set.Get();
		}

		public void AddCallbacks(ILargeMapViewActions instance)
		{
			if (instance != null && !m_Wrapper.m_LargeMapViewActionsCallbackInterfaces.Contains(instance))
			{
				m_Wrapper.m_LargeMapViewActionsCallbackInterfaces.Add(instance);
				mapScaleReduce.started += instance.OnMapScaleReduce;
				mapScaleReduce.performed += instance.OnMapScaleReduce;
				mapScaleReduce.canceled += instance.OnMapScaleReduce;
				mapScaleReduceFloat.started += instance.OnMapScaleReduceFloat;
				mapScaleReduceFloat.performed += instance.OnMapScaleReduceFloat;
				mapScaleReduceFloat.canceled += instance.OnMapScaleReduceFloat;
				mapScaleAdd.started += instance.OnMapScaleAdd;
				mapScaleAdd.performed += instance.OnMapScaleAdd;
				mapScaleAdd.canceled += instance.OnMapScaleAdd;
				mapScaleAddFloat.started += instance.OnMapScaleAddFloat;
				mapScaleAddFloat.performed += instance.OnMapScaleAddFloat;
				mapScaleAddFloat.canceled += instance.OnMapScaleAddFloat;
				Select.started += instance.OnSelect;
				Select.performed += instance.OnSelect;
				Select.canceled += instance.OnSelect;
				MapItem.started += instance.OnMapItem;
				MapItem.performed += instance.OnMapItem;
				MapItem.canceled += instance.OnMapItem;
				Return.started += instance.OnReturn;
				Return.performed += instance.OnReturn;
				Return.canceled += instance.OnReturn;
				MapCollection.started += instance.OnMapCollection;
				MapCollection.performed += instance.OnMapCollection;
				MapCollection.canceled += instance.OnMapCollection;
				WorldMap.started += instance.OnWorldMap;
				WorldMap.performed += instance.OnWorldMap;
				WorldMap.canceled += instance.OnWorldMap;
				MapTemple.started += instance.OnMapTemple;
				MapTemple.performed += instance.OnMapTemple;
				MapTemple.canceled += instance.OnMapTemple;
				Delete.started += instance.OnDelete;
				Delete.performed += instance.OnDelete;
				Delete.canceled += instance.OnDelete;
				MoveMap.started += instance.OnMoveMap;
				MoveMap.performed += instance.OnMoveMap;
				MoveMap.canceled += instance.OnMoveMap;
				MoveCursor.started += instance.OnMoveCursor;
				MoveCursor.performed += instance.OnMoveCursor;
				MoveCursor.canceled += instance.OnMoveCursor;
				BackToPlayer.started += instance.OnBackToPlayer;
				BackToPlayer.performed += instance.OnBackToPlayer;
				BackToPlayer.canceled += instance.OnBackToPlayer;
				WorldMapChooseLast.started += instance.OnWorldMapChooseLast;
				WorldMapChooseLast.performed += instance.OnWorldMapChooseLast;
				WorldMapChooseLast.canceled += instance.OnWorldMapChooseLast;
				WorldMapChooseNext.started += instance.OnWorldMapChooseNext;
				WorldMapChooseNext.performed += instance.OnWorldMapChooseNext;
				WorldMapChooseNext.canceled += instance.OnWorldMapChooseNext;
				MapSideInfoLast.started += instance.OnMapSideInfoLast;
				MapSideInfoLast.performed += instance.OnMapSideInfoLast;
				MapSideInfoLast.canceled += instance.OnMapSideInfoLast;
				MapSideInfoNext.started += instance.OnMapSideInfoNext;
				MapSideInfoNext.performed += instance.OnMapSideInfoNext;
				MapSideInfoNext.canceled += instance.OnMapSideInfoNext;
				ChangeToSelectItem.started += instance.OnChangeToSelectItem;
				ChangeToSelectItem.performed += instance.OnChangeToSelectItem;
				ChangeToSelectItem.canceled += instance.OnChangeToSelectItem;
				BackToTarget.started += instance.OnBackToTarget;
				BackToTarget.performed += instance.OnBackToTarget;
				BackToTarget.canceled += instance.OnBackToTarget;
				Up.started += instance.OnUp;
				Up.performed += instance.OnUp;
				Up.canceled += instance.OnUp;
				Down.started += instance.OnDown;
				Down.performed += instance.OnDown;
				Down.canceled += instance.OnDown;
				Left.started += instance.OnLeft;
				Left.performed += instance.OnLeft;
				Left.canceled += instance.OnLeft;
				Right.started += instance.OnRight;
				Right.performed += instance.OnRight;
				Right.canceled += instance.OnRight;
			}
		}

		private void UnregisterCallbacks(ILargeMapViewActions instance)
		{
			mapScaleReduce.started -= instance.OnMapScaleReduce;
			mapScaleReduce.performed -= instance.OnMapScaleReduce;
			mapScaleReduce.canceled -= instance.OnMapScaleReduce;
			mapScaleReduceFloat.started -= instance.OnMapScaleReduceFloat;
			mapScaleReduceFloat.performed -= instance.OnMapScaleReduceFloat;
			mapScaleReduceFloat.canceled -= instance.OnMapScaleReduceFloat;
			mapScaleAdd.started -= instance.OnMapScaleAdd;
			mapScaleAdd.performed -= instance.OnMapScaleAdd;
			mapScaleAdd.canceled -= instance.OnMapScaleAdd;
			mapScaleAddFloat.started -= instance.OnMapScaleAddFloat;
			mapScaleAddFloat.performed -= instance.OnMapScaleAddFloat;
			mapScaleAddFloat.canceled -= instance.OnMapScaleAddFloat;
			Select.started -= instance.OnSelect;
			Select.performed -= instance.OnSelect;
			Select.canceled -= instance.OnSelect;
			MapItem.started -= instance.OnMapItem;
			MapItem.performed -= instance.OnMapItem;
			MapItem.canceled -= instance.OnMapItem;
			Return.started -= instance.OnReturn;
			Return.performed -= instance.OnReturn;
			Return.canceled -= instance.OnReturn;
			MapCollection.started -= instance.OnMapCollection;
			MapCollection.performed -= instance.OnMapCollection;
			MapCollection.canceled -= instance.OnMapCollection;
			WorldMap.started -= instance.OnWorldMap;
			WorldMap.performed -= instance.OnWorldMap;
			WorldMap.canceled -= instance.OnWorldMap;
			MapTemple.started -= instance.OnMapTemple;
			MapTemple.performed -= instance.OnMapTemple;
			MapTemple.canceled -= instance.OnMapTemple;
			Delete.started -= instance.OnDelete;
			Delete.performed -= instance.OnDelete;
			Delete.canceled -= instance.OnDelete;
			MoveMap.started -= instance.OnMoveMap;
			MoveMap.performed -= instance.OnMoveMap;
			MoveMap.canceled -= instance.OnMoveMap;
			MoveCursor.started -= instance.OnMoveCursor;
			MoveCursor.performed -= instance.OnMoveCursor;
			MoveCursor.canceled -= instance.OnMoveCursor;
			BackToPlayer.started -= instance.OnBackToPlayer;
			BackToPlayer.performed -= instance.OnBackToPlayer;
			BackToPlayer.canceled -= instance.OnBackToPlayer;
			WorldMapChooseLast.started -= instance.OnWorldMapChooseLast;
			WorldMapChooseLast.performed -= instance.OnWorldMapChooseLast;
			WorldMapChooseLast.canceled -= instance.OnWorldMapChooseLast;
			WorldMapChooseNext.started -= instance.OnWorldMapChooseNext;
			WorldMapChooseNext.performed -= instance.OnWorldMapChooseNext;
			WorldMapChooseNext.canceled -= instance.OnWorldMapChooseNext;
			MapSideInfoLast.started -= instance.OnMapSideInfoLast;
			MapSideInfoLast.performed -= instance.OnMapSideInfoLast;
			MapSideInfoLast.canceled -= instance.OnMapSideInfoLast;
			MapSideInfoNext.started -= instance.OnMapSideInfoNext;
			MapSideInfoNext.performed -= instance.OnMapSideInfoNext;
			MapSideInfoNext.canceled -= instance.OnMapSideInfoNext;
			ChangeToSelectItem.started -= instance.OnChangeToSelectItem;
			ChangeToSelectItem.performed -= instance.OnChangeToSelectItem;
			ChangeToSelectItem.canceled -= instance.OnChangeToSelectItem;
			BackToTarget.started -= instance.OnBackToTarget;
			BackToTarget.performed -= instance.OnBackToTarget;
			BackToTarget.canceled -= instance.OnBackToTarget;
			Up.started -= instance.OnUp;
			Up.performed -= instance.OnUp;
			Up.canceled -= instance.OnUp;
			Down.started -= instance.OnDown;
			Down.performed -= instance.OnDown;
			Down.canceled -= instance.OnDown;
			Left.started -= instance.OnLeft;
			Left.performed -= instance.OnLeft;
			Left.canceled -= instance.OnLeft;
			Right.started -= instance.OnRight;
			Right.performed -= instance.OnRight;
			Right.canceled -= instance.OnRight;
		}

		public void RemoveCallbacks(ILargeMapViewActions instance)
		{
			if (m_Wrapper.m_LargeMapViewActionsCallbackInterfaces.Remove(instance))
			{
				UnregisterCallbacks(instance);
			}
		}

		public void SetCallbacks(ILargeMapViewActions instance)
		{
			foreach (ILargeMapViewActions largeMapViewActionsCallbackInterface in m_Wrapper.m_LargeMapViewActionsCallbackInterfaces)
			{
				UnregisterCallbacks(largeMapViewActionsCallbackInterface);
			}
			m_Wrapper.m_LargeMapViewActionsCallbackInterfaces.Clear();
			AddCallbacks(instance);
		}
	}

	public struct ConversationActions(ACTInputActions wrapper)
	{
		private ACTInputActions m_Wrapper = wrapper;

		public InputAction ConversationNext => m_Wrapper.m_Conversation_ConversationNext;

		public InputAction ConversationAutoPlay => m_Wrapper.m_Conversation_ConversationAutoPlay;

		public InputAction ConversationReview => m_Wrapper.m_Conversation_ConversationReview;

		public InputAction ConversationHide => m_Wrapper.m_Conversation_ConversationHide;

		public InputAction ConversationReviewClose => m_Wrapper.m_Conversation_ConversationReviewClose;

		public InputAction ConversationReviewScroll => m_Wrapper.m_Conversation_ConversationReviewScroll;

		public InputAction ConversationLastChoice => m_Wrapper.m_Conversation_ConversationLastChoice;

		public InputAction ConversationLastChoice1 => m_Wrapper.m_Conversation_ConversationLastChoice1;

		public InputAction ConversationNextChoice => m_Wrapper.m_Conversation_ConversationNextChoice;

		public InputAction ConversationNextChoice1 => m_Wrapper.m_Conversation_ConversationNextChoice1;

		public InputAction ConversationSkip => m_Wrapper.m_Conversation_ConversationSkip;

		public InputAction ConversationChoose => m_Wrapper.m_Conversation_ConversationChoose;

		public bool enabled => Get().enabled;

		public InputActionMap Get()
		{
			return m_Wrapper.m_Conversation;
		}

		public void Enable()
		{
			Get().Enable();
		}

		public void Disable()
		{
			Get().Disable();
		}

		public static implicit operator InputActionMap(ConversationActions set)
		{
			return set.Get();
		}

		public void AddCallbacks(IConversationActions instance)
		{
			if (instance != null && !m_Wrapper.m_ConversationActionsCallbackInterfaces.Contains(instance))
			{
				m_Wrapper.m_ConversationActionsCallbackInterfaces.Add(instance);
				ConversationNext.started += instance.OnConversationNext;
				ConversationNext.performed += instance.OnConversationNext;
				ConversationNext.canceled += instance.OnConversationNext;
				ConversationAutoPlay.started += instance.OnConversationAutoPlay;
				ConversationAutoPlay.performed += instance.OnConversationAutoPlay;
				ConversationAutoPlay.canceled += instance.OnConversationAutoPlay;
				ConversationReview.started += instance.OnConversationReview;
				ConversationReview.performed += instance.OnConversationReview;
				ConversationReview.canceled += instance.OnConversationReview;
				ConversationHide.started += instance.OnConversationHide;
				ConversationHide.performed += instance.OnConversationHide;
				ConversationHide.canceled += instance.OnConversationHide;
				ConversationReviewClose.started += instance.OnConversationReviewClose;
				ConversationReviewClose.performed += instance.OnConversationReviewClose;
				ConversationReviewClose.canceled += instance.OnConversationReviewClose;
				ConversationReviewScroll.started += instance.OnConversationReviewScroll;
				ConversationReviewScroll.performed += instance.OnConversationReviewScroll;
				ConversationReviewScroll.canceled += instance.OnConversationReviewScroll;
				ConversationLastChoice.started += instance.OnConversationLastChoice;
				ConversationLastChoice.performed += instance.OnConversationLastChoice;
				ConversationLastChoice.canceled += instance.OnConversationLastChoice;
				ConversationLastChoice1.started += instance.OnConversationLastChoice1;
				ConversationLastChoice1.performed += instance.OnConversationLastChoice1;
				ConversationLastChoice1.canceled += instance.OnConversationLastChoice1;
				ConversationNextChoice.started += instance.OnConversationNextChoice;
				ConversationNextChoice.performed += instance.OnConversationNextChoice;
				ConversationNextChoice.canceled += instance.OnConversationNextChoice;
				ConversationNextChoice1.started += instance.OnConversationNextChoice1;
				ConversationNextChoice1.performed += instance.OnConversationNextChoice1;
				ConversationNextChoice1.canceled += instance.OnConversationNextChoice1;
				ConversationSkip.started += instance.OnConversationSkip;
				ConversationSkip.performed += instance.OnConversationSkip;
				ConversationSkip.canceled += instance.OnConversationSkip;
				ConversationChoose.started += instance.OnConversationChoose;
				ConversationChoose.performed += instance.OnConversationChoose;
				ConversationChoose.canceled += instance.OnConversationChoose;
			}
		}

		private void UnregisterCallbacks(IConversationActions instance)
		{
			ConversationNext.started -= instance.OnConversationNext;
			ConversationNext.performed -= instance.OnConversationNext;
			ConversationNext.canceled -= instance.OnConversationNext;
			ConversationAutoPlay.started -= instance.OnConversationAutoPlay;
			ConversationAutoPlay.performed -= instance.OnConversationAutoPlay;
			ConversationAutoPlay.canceled -= instance.OnConversationAutoPlay;
			ConversationReview.started -= instance.OnConversationReview;
			ConversationReview.performed -= instance.OnConversationReview;
			ConversationReview.canceled -= instance.OnConversationReview;
			ConversationHide.started -= instance.OnConversationHide;
			ConversationHide.performed -= instance.OnConversationHide;
			ConversationHide.canceled -= instance.OnConversationHide;
			ConversationReviewClose.started -= instance.OnConversationReviewClose;
			ConversationReviewClose.performed -= instance.OnConversationReviewClose;
			ConversationReviewClose.canceled -= instance.OnConversationReviewClose;
			ConversationReviewScroll.started -= instance.OnConversationReviewScroll;
			ConversationReviewScroll.performed -= instance.OnConversationReviewScroll;
			ConversationReviewScroll.canceled -= instance.OnConversationReviewScroll;
			ConversationLastChoice.started -= instance.OnConversationLastChoice;
			ConversationLastChoice.performed -= instance.OnConversationLastChoice;
			ConversationLastChoice.canceled -= instance.OnConversationLastChoice;
			ConversationLastChoice1.started -= instance.OnConversationLastChoice1;
			ConversationLastChoice1.performed -= instance.OnConversationLastChoice1;
			ConversationLastChoice1.canceled -= instance.OnConversationLastChoice1;
			ConversationNextChoice.started -= instance.OnConversationNextChoice;
			ConversationNextChoice.performed -= instance.OnConversationNextChoice;
			ConversationNextChoice.canceled -= instance.OnConversationNextChoice;
			ConversationNextChoice1.started -= instance.OnConversationNextChoice1;
			ConversationNextChoice1.performed -= instance.OnConversationNextChoice1;
			ConversationNextChoice1.canceled -= instance.OnConversationNextChoice1;
			ConversationSkip.started -= instance.OnConversationSkip;
			ConversationSkip.performed -= instance.OnConversationSkip;
			ConversationSkip.canceled -= instance.OnConversationSkip;
			ConversationChoose.started -= instance.OnConversationChoose;
			ConversationChoose.performed -= instance.OnConversationChoose;
			ConversationChoose.canceled -= instance.OnConversationChoose;
		}

		public void RemoveCallbacks(IConversationActions instance)
		{
			if (m_Wrapper.m_ConversationActionsCallbackInterfaces.Remove(instance))
			{
				UnregisterCallbacks(instance);
			}
		}

		public void SetCallbacks(IConversationActions instance)
		{
			foreach (IConversationActions conversationActionsCallbackInterface in m_Wrapper.m_ConversationActionsCallbackInterfaces)
			{
				UnregisterCallbacks(conversationActionsCallbackInterface);
			}
			m_Wrapper.m_ConversationActionsCallbackInterfaces.Clear();
			AddCallbacks(instance);
		}
	}

	public struct StateObjectActions(ACTInputActions wrapper)
	{
		private ACTInputActions m_Wrapper = wrapper;

		public InputAction StateObjectMove => m_Wrapper.m_StateObject_StateObjectMove;

		public bool enabled => Get().enabled;

		public InputActionMap Get()
		{
			return m_Wrapper.m_StateObject;
		}

		public void Enable()
		{
			Get().Enable();
		}

		public void Disable()
		{
			Get().Disable();
		}

		public static implicit operator InputActionMap(StateObjectActions set)
		{
			return set.Get();
		}

		public void AddCallbacks(IStateObjectActions instance)
		{
			if (instance != null && !m_Wrapper.m_StateObjectActionsCallbackInterfaces.Contains(instance))
			{
				m_Wrapper.m_StateObjectActionsCallbackInterfaces.Add(instance);
				StateObjectMove.started += instance.OnStateObjectMove;
				StateObjectMove.performed += instance.OnStateObjectMove;
				StateObjectMove.canceled += instance.OnStateObjectMove;
			}
		}

		private void UnregisterCallbacks(IStateObjectActions instance)
		{
			StateObjectMove.started -= instance.OnStateObjectMove;
			StateObjectMove.performed -= instance.OnStateObjectMove;
			StateObjectMove.canceled -= instance.OnStateObjectMove;
		}

		public void RemoveCallbacks(IStateObjectActions instance)
		{
			if (m_Wrapper.m_StateObjectActionsCallbackInterfaces.Remove(instance))
			{
				UnregisterCallbacks(instance);
			}
		}

		public void SetCallbacks(IStateObjectActions instance)
		{
			foreach (IStateObjectActions stateObjectActionsCallbackInterface in m_Wrapper.m_StateObjectActionsCallbackInterfaces)
			{
				UnregisterCallbacks(stateObjectActionsCallbackInterface);
			}
			m_Wrapper.m_StateObjectActionsCallbackInterfaces.Clear();
			AddCallbacks(instance);
		}
	}

	public struct SettingsActions(ACTInputActions wrapper)
	{
		private ACTInputActions m_Wrapper = wrapper;

		public InputAction SettingsConfirm => m_Wrapper.m_Settings_SettingsConfirm;

		public InputAction SettingsPreTab => m_Wrapper.m_Settings_SettingsPreTab;

		public InputAction SettingsNextTab => m_Wrapper.m_Settings_SettingsNextTab;

		public InputAction SettingsSwitchDetail => m_Wrapper.m_Settings_SettingsSwitchDetail;

		public InputAction SettingsSliderLeft => m_Wrapper.m_Settings_SettingsSliderLeft;

		public InputAction SettingsSliderRight => m_Wrapper.m_Settings_SettingsSliderRight;

		public InputAction SettingsSliderShift => m_Wrapper.m_Settings_SettingsSliderShift;

		public InputAction SettingsSliderLeftShift => m_Wrapper.m_Settings_SettingsSliderLeftShift;

		public InputAction SettingsSliderRightShift => m_Wrapper.m_Settings_SettingsSliderRightShift;

		public InputAction SettingsSelectionUp => m_Wrapper.m_Settings_SettingsSelectionUp;

		public InputAction SettingsSelectionUp1 => m_Wrapper.m_Settings_SettingsSelectionUp1;

		public InputAction SettingsSelectionDown => m_Wrapper.m_Settings_SettingsSelectionDown;

		public InputAction SettingsSelectionDown1 => m_Wrapper.m_Settings_SettingsSelectionDown1;

		public InputAction SettingsSelectionLeft => m_Wrapper.m_Settings_SettingsSelectionLeft;

		public InputAction SettingsSelectionLeft1 => m_Wrapper.m_Settings_SettingsSelectionLeft1;

		public InputAction SettingsSelectionRight => m_Wrapper.m_Settings_SettingsSelectionRight;

		public InputAction SettingsSelectionRight1 => m_Wrapper.m_Settings_SettingsSelectionRight1;

		public InputAction SettingsBackHUD => m_Wrapper.m_Settings_SettingsBackHUD;

		public InputAction PreTab1 => m_Wrapper.m_Settings_PreTab1;

		public InputAction NextTab1 => m_Wrapper.m_Settings_NextTab1;

		public InputAction SettingsResetToDefault => m_Wrapper.m_Settings_SettingsResetToDefault;

		public bool enabled => Get().enabled;

		public InputActionMap Get()
		{
			return m_Wrapper.m_Settings;
		}

		public void Enable()
		{
			Get().Enable();
		}

		public void Disable()
		{
			Get().Disable();
		}

		public static implicit operator InputActionMap(SettingsActions set)
		{
			return set.Get();
		}

		public void AddCallbacks(ISettingsActions instance)
		{
			if (instance != null && !m_Wrapper.m_SettingsActionsCallbackInterfaces.Contains(instance))
			{
				m_Wrapper.m_SettingsActionsCallbackInterfaces.Add(instance);
				SettingsConfirm.started += instance.OnSettingsConfirm;
				SettingsConfirm.performed += instance.OnSettingsConfirm;
				SettingsConfirm.canceled += instance.OnSettingsConfirm;
				SettingsPreTab.started += instance.OnSettingsPreTab;
				SettingsPreTab.performed += instance.OnSettingsPreTab;
				SettingsPreTab.canceled += instance.OnSettingsPreTab;
				SettingsNextTab.started += instance.OnSettingsNextTab;
				SettingsNextTab.performed += instance.OnSettingsNextTab;
				SettingsNextTab.canceled += instance.OnSettingsNextTab;
				SettingsSwitchDetail.started += instance.OnSettingsSwitchDetail;
				SettingsSwitchDetail.performed += instance.OnSettingsSwitchDetail;
				SettingsSwitchDetail.canceled += instance.OnSettingsSwitchDetail;
				SettingsSliderLeft.started += instance.OnSettingsSliderLeft;
				SettingsSliderLeft.performed += instance.OnSettingsSliderLeft;
				SettingsSliderLeft.canceled += instance.OnSettingsSliderLeft;
				SettingsSliderRight.started += instance.OnSettingsSliderRight;
				SettingsSliderRight.performed += instance.OnSettingsSliderRight;
				SettingsSliderRight.canceled += instance.OnSettingsSliderRight;
				SettingsSliderShift.started += instance.OnSettingsSliderShift;
				SettingsSliderShift.performed += instance.OnSettingsSliderShift;
				SettingsSliderShift.canceled += instance.OnSettingsSliderShift;
				SettingsSliderLeftShift.started += instance.OnSettingsSliderLeftShift;
				SettingsSliderLeftShift.performed += instance.OnSettingsSliderLeftShift;
				SettingsSliderLeftShift.canceled += instance.OnSettingsSliderLeftShift;
				SettingsSliderRightShift.started += instance.OnSettingsSliderRightShift;
				SettingsSliderRightShift.performed += instance.OnSettingsSliderRightShift;
				SettingsSliderRightShift.canceled += instance.OnSettingsSliderRightShift;
				SettingsSelectionUp.started += instance.OnSettingsSelectionUp;
				SettingsSelectionUp.performed += instance.OnSettingsSelectionUp;
				SettingsSelectionUp.canceled += instance.OnSettingsSelectionUp;
				SettingsSelectionUp1.started += instance.OnSettingsSelectionUp1;
				SettingsSelectionUp1.performed += instance.OnSettingsSelectionUp1;
				SettingsSelectionUp1.canceled += instance.OnSettingsSelectionUp1;
				SettingsSelectionDown.started += instance.OnSettingsSelectionDown;
				SettingsSelectionDown.performed += instance.OnSettingsSelectionDown;
				SettingsSelectionDown.canceled += instance.OnSettingsSelectionDown;
				SettingsSelectionDown1.started += instance.OnSettingsSelectionDown1;
				SettingsSelectionDown1.performed += instance.OnSettingsSelectionDown1;
				SettingsSelectionDown1.canceled += instance.OnSettingsSelectionDown1;
				SettingsSelectionLeft.started += instance.OnSettingsSelectionLeft;
				SettingsSelectionLeft.performed += instance.OnSettingsSelectionLeft;
				SettingsSelectionLeft.canceled += instance.OnSettingsSelectionLeft;
				SettingsSelectionLeft1.started += instance.OnSettingsSelectionLeft1;
				SettingsSelectionLeft1.performed += instance.OnSettingsSelectionLeft1;
				SettingsSelectionLeft1.canceled += instance.OnSettingsSelectionLeft1;
				SettingsSelectionRight.started += instance.OnSettingsSelectionRight;
				SettingsSelectionRight.performed += instance.OnSettingsSelectionRight;
				SettingsSelectionRight.canceled += instance.OnSettingsSelectionRight;
				SettingsSelectionRight1.started += instance.OnSettingsSelectionRight1;
				SettingsSelectionRight1.performed += instance.OnSettingsSelectionRight1;
				SettingsSelectionRight1.canceled += instance.OnSettingsSelectionRight1;
				SettingsBackHUD.started += instance.OnSettingsBackHUD;
				SettingsBackHUD.performed += instance.OnSettingsBackHUD;
				SettingsBackHUD.canceled += instance.OnSettingsBackHUD;
				PreTab1.started += instance.OnPreTab1;
				PreTab1.performed += instance.OnPreTab1;
				PreTab1.canceled += instance.OnPreTab1;
				NextTab1.started += instance.OnNextTab1;
				NextTab1.performed += instance.OnNextTab1;
				NextTab1.canceled += instance.OnNextTab1;
				SettingsResetToDefault.started += instance.OnSettingsResetToDefault;
				SettingsResetToDefault.performed += instance.OnSettingsResetToDefault;
				SettingsResetToDefault.canceled += instance.OnSettingsResetToDefault;
			}
		}

		private void UnregisterCallbacks(ISettingsActions instance)
		{
			SettingsConfirm.started -= instance.OnSettingsConfirm;
			SettingsConfirm.performed -= instance.OnSettingsConfirm;
			SettingsConfirm.canceled -= instance.OnSettingsConfirm;
			SettingsPreTab.started -= instance.OnSettingsPreTab;
			SettingsPreTab.performed -= instance.OnSettingsPreTab;
			SettingsPreTab.canceled -= instance.OnSettingsPreTab;
			SettingsNextTab.started -= instance.OnSettingsNextTab;
			SettingsNextTab.performed -= instance.OnSettingsNextTab;
			SettingsNextTab.canceled -= instance.OnSettingsNextTab;
			SettingsSwitchDetail.started -= instance.OnSettingsSwitchDetail;
			SettingsSwitchDetail.performed -= instance.OnSettingsSwitchDetail;
			SettingsSwitchDetail.canceled -= instance.OnSettingsSwitchDetail;
			SettingsSliderLeft.started -= instance.OnSettingsSliderLeft;
			SettingsSliderLeft.performed -= instance.OnSettingsSliderLeft;
			SettingsSliderLeft.canceled -= instance.OnSettingsSliderLeft;
			SettingsSliderRight.started -= instance.OnSettingsSliderRight;
			SettingsSliderRight.performed -= instance.OnSettingsSliderRight;
			SettingsSliderRight.canceled -= instance.OnSettingsSliderRight;
			SettingsSliderShift.started -= instance.OnSettingsSliderShift;
			SettingsSliderShift.performed -= instance.OnSettingsSliderShift;
			SettingsSliderShift.canceled -= instance.OnSettingsSliderShift;
			SettingsSliderLeftShift.started -= instance.OnSettingsSliderLeftShift;
			SettingsSliderLeftShift.performed -= instance.OnSettingsSliderLeftShift;
			SettingsSliderLeftShift.canceled -= instance.OnSettingsSliderLeftShift;
			SettingsSliderRightShift.started -= instance.OnSettingsSliderRightShift;
			SettingsSliderRightShift.performed -= instance.OnSettingsSliderRightShift;
			SettingsSliderRightShift.canceled -= instance.OnSettingsSliderRightShift;
			SettingsSelectionUp.started -= instance.OnSettingsSelectionUp;
			SettingsSelectionUp.performed -= instance.OnSettingsSelectionUp;
			SettingsSelectionUp.canceled -= instance.OnSettingsSelectionUp;
			SettingsSelectionUp1.started -= instance.OnSettingsSelectionUp1;
			SettingsSelectionUp1.performed -= instance.OnSettingsSelectionUp1;
			SettingsSelectionUp1.canceled -= instance.OnSettingsSelectionUp1;
			SettingsSelectionDown.started -= instance.OnSettingsSelectionDown;
			SettingsSelectionDown.performed -= instance.OnSettingsSelectionDown;
			SettingsSelectionDown.canceled -= instance.OnSettingsSelectionDown;
			SettingsSelectionDown1.started -= instance.OnSettingsSelectionDown1;
			SettingsSelectionDown1.performed -= instance.OnSettingsSelectionDown1;
			SettingsSelectionDown1.canceled -= instance.OnSettingsSelectionDown1;
			SettingsSelectionLeft.started -= instance.OnSettingsSelectionLeft;
			SettingsSelectionLeft.performed -= instance.OnSettingsSelectionLeft;
			SettingsSelectionLeft.canceled -= instance.OnSettingsSelectionLeft;
			SettingsSelectionLeft1.started -= instance.OnSettingsSelectionLeft1;
			SettingsSelectionLeft1.performed -= instance.OnSettingsSelectionLeft1;
			SettingsSelectionLeft1.canceled -= instance.OnSettingsSelectionLeft1;
			SettingsSelectionRight.started -= instance.OnSettingsSelectionRight;
			SettingsSelectionRight.performed -= instance.OnSettingsSelectionRight;
			SettingsSelectionRight.canceled -= instance.OnSettingsSelectionRight;
			SettingsSelectionRight1.started -= instance.OnSettingsSelectionRight1;
			SettingsSelectionRight1.performed -= instance.OnSettingsSelectionRight1;
			SettingsSelectionRight1.canceled -= instance.OnSettingsSelectionRight1;
			SettingsBackHUD.started -= instance.OnSettingsBackHUD;
			SettingsBackHUD.performed -= instance.OnSettingsBackHUD;
			SettingsBackHUD.canceled -= instance.OnSettingsBackHUD;
			PreTab1.started -= instance.OnPreTab1;
			PreTab1.performed -= instance.OnPreTab1;
			PreTab1.canceled -= instance.OnPreTab1;
			NextTab1.started -= instance.OnNextTab1;
			NextTab1.performed -= instance.OnNextTab1;
			NextTab1.canceled -= instance.OnNextTab1;
			SettingsResetToDefault.started -= instance.OnSettingsResetToDefault;
			SettingsResetToDefault.performed -= instance.OnSettingsResetToDefault;
			SettingsResetToDefault.canceled -= instance.OnSettingsResetToDefault;
		}

		public void RemoveCallbacks(ISettingsActions instance)
		{
			if (m_Wrapper.m_SettingsActionsCallbackInterfaces.Remove(instance))
			{
				UnregisterCallbacks(instance);
			}
		}

		public void SetCallbacks(ISettingsActions instance)
		{
			foreach (ISettingsActions settingsActionsCallbackInterface in m_Wrapper.m_SettingsActionsCallbackInterfaces)
			{
				UnregisterCallbacks(settingsActionsCallbackInterface);
			}
			m_Wrapper.m_SettingsActionsCallbackInterfaces.Clear();
			AddCallbacks(instance);
		}
	}

	public struct GuideActions(ACTInputActions wrapper)
	{
		private ACTInputActions m_Wrapper = wrapper;

		public InputAction ClickFinshGuideStep => m_Wrapper.m_Guide_ClickFinshGuideStep;

		public InputAction ClickSkipGuide => m_Wrapper.m_Guide_ClickSkipGuide;

		public bool enabled => Get().enabled;

		public InputActionMap Get()
		{
			return m_Wrapper.m_Guide;
		}

		public void Enable()
		{
			Get().Enable();
		}

		public void Disable()
		{
			Get().Disable();
		}

		public static implicit operator InputActionMap(GuideActions set)
		{
			return set.Get();
		}

		public void AddCallbacks(IGuideActions instance)
		{
			if (instance != null && !m_Wrapper.m_GuideActionsCallbackInterfaces.Contains(instance))
			{
				m_Wrapper.m_GuideActionsCallbackInterfaces.Add(instance);
				ClickFinshGuideStep.started += instance.OnClickFinshGuideStep;
				ClickFinshGuideStep.performed += instance.OnClickFinshGuideStep;
				ClickFinshGuideStep.canceled += instance.OnClickFinshGuideStep;
				ClickSkipGuide.started += instance.OnClickSkipGuide;
				ClickSkipGuide.performed += instance.OnClickSkipGuide;
				ClickSkipGuide.canceled += instance.OnClickSkipGuide;
			}
		}

		private void UnregisterCallbacks(IGuideActions instance)
		{
			ClickFinshGuideStep.started -= instance.OnClickFinshGuideStep;
			ClickFinshGuideStep.performed -= instance.OnClickFinshGuideStep;
			ClickFinshGuideStep.canceled -= instance.OnClickFinshGuideStep;
			ClickSkipGuide.started -= instance.OnClickSkipGuide;
			ClickSkipGuide.performed -= instance.OnClickSkipGuide;
			ClickSkipGuide.canceled -= instance.OnClickSkipGuide;
		}

		public void RemoveCallbacks(IGuideActions instance)
		{
			if (m_Wrapper.m_GuideActionsCallbackInterfaces.Remove(instance))
			{
				UnregisterCallbacks(instance);
			}
		}

		public void SetCallbacks(IGuideActions instance)
		{
			foreach (IGuideActions guideActionsCallbackInterface in m_Wrapper.m_GuideActionsCallbackInterfaces)
			{
				UnregisterCallbacks(guideActionsCallbackInterface);
			}
			m_Wrapper.m_GuideActionsCallbackInterfaces.Clear();
			AddCallbacks(instance);
		}
	}

	public struct TextLibraryActions(ACTInputActions wrapper)
	{
		private ACTInputActions m_Wrapper = wrapper;

		public InputAction TextLibraryUITipGamePadModifier => m_Wrapper.m_TextLibrary_TextLibraryUITipGamePadModifier;

		public InputAction TextLibraryUITipGamePadBinding => m_Wrapper.m_TextLibrary_TextLibraryUITipGamePadBinding;

		public bool enabled => Get().enabled;

		public InputActionMap Get()
		{
			return m_Wrapper.m_TextLibrary;
		}

		public void Enable()
		{
			Get().Enable();
		}

		public void Disable()
		{
			Get().Disable();
		}

		public static implicit operator InputActionMap(TextLibraryActions set)
		{
			return set.Get();
		}

		public void AddCallbacks(ITextLibraryActions instance)
		{
			if (instance != null && !m_Wrapper.m_TextLibraryActionsCallbackInterfaces.Contains(instance))
			{
				m_Wrapper.m_TextLibraryActionsCallbackInterfaces.Add(instance);
				TextLibraryUITipGamePadModifier.started += instance.OnTextLibraryUITipGamePadModifier;
				TextLibraryUITipGamePadModifier.performed += instance.OnTextLibraryUITipGamePadModifier;
				TextLibraryUITipGamePadModifier.canceled += instance.OnTextLibraryUITipGamePadModifier;
				TextLibraryUITipGamePadBinding.started += instance.OnTextLibraryUITipGamePadBinding;
				TextLibraryUITipGamePadBinding.performed += instance.OnTextLibraryUITipGamePadBinding;
				TextLibraryUITipGamePadBinding.canceled += instance.OnTextLibraryUITipGamePadBinding;
			}
		}

		private void UnregisterCallbacks(ITextLibraryActions instance)
		{
			TextLibraryUITipGamePadModifier.started -= instance.OnTextLibraryUITipGamePadModifier;
			TextLibraryUITipGamePadModifier.performed -= instance.OnTextLibraryUITipGamePadModifier;
			TextLibraryUITipGamePadModifier.canceled -= instance.OnTextLibraryUITipGamePadModifier;
			TextLibraryUITipGamePadBinding.started -= instance.OnTextLibraryUITipGamePadBinding;
			TextLibraryUITipGamePadBinding.performed -= instance.OnTextLibraryUITipGamePadBinding;
			TextLibraryUITipGamePadBinding.canceled -= instance.OnTextLibraryUITipGamePadBinding;
		}

		public void RemoveCallbacks(ITextLibraryActions instance)
		{
			if (m_Wrapper.m_TextLibraryActionsCallbackInterfaces.Remove(instance))
			{
				UnregisterCallbacks(instance);
			}
		}

		public void SetCallbacks(ITextLibraryActions instance)
		{
			foreach (ITextLibraryActions textLibraryActionsCallbackInterface in m_Wrapper.m_TextLibraryActionsCallbackInterfaces)
			{
				UnregisterCallbacks(textLibraryActionsCallbackInterface);
			}
			m_Wrapper.m_TextLibraryActionsCallbackInterfaces.Clear();
			AddCallbacks(instance);
		}
	}

	public struct CharacterViewActions(ACTInputActions wrapper)
	{
		private ACTInputActions m_Wrapper = wrapper;

		public InputAction NextCharacter => m_Wrapper.m_CharacterView_NextCharacter;

		public InputAction PrevCharacter => m_Wrapper.m_CharacterView_PrevCharacter;

		public InputAction NextTab => m_Wrapper.m_CharacterView_NextTab;

		public InputAction PrevTab => m_Wrapper.m_CharacterView_PrevTab;

		public InputAction OpenCharacterList => m_Wrapper.m_CharacterView_OpenCharacterList;

		public InputAction OpenModelView => m_Wrapper.m_CharacterView_OpenModelView;

		public InputAction Upgrade => m_Wrapper.m_CharacterView_Upgrade;

		public InputAction Destiny => m_Wrapper.m_CharacterView_Destiny;

		public InputAction SelectMaxLevel => m_Wrapper.m_CharacterView_SelectMaxLevel;

		public InputAction ShowCostCoinDetail => m_Wrapper.m_CharacterView_ShowCostCoinDetail;

		public InputAction ToggleSkillDescriptionMode => m_Wrapper.m_CharacterView_ToggleSkillDescriptionMode;

		public InputAction ShowMaterialCost => m_Wrapper.m_CharacterView_ShowMaterialCost;

		public InputAction ShowUpdatePreview => m_Wrapper.m_CharacterView_ShowUpdatePreview;

		public bool enabled => Get().enabled;

		public InputActionMap Get()
		{
			return m_Wrapper.m_CharacterView;
		}

		public void Enable()
		{
			Get().Enable();
		}

		public void Disable()
		{
			Get().Disable();
		}

		public static implicit operator InputActionMap(CharacterViewActions set)
		{
			return set.Get();
		}

		public void AddCallbacks(ICharacterViewActions instance)
		{
			if (instance != null && !m_Wrapper.m_CharacterViewActionsCallbackInterfaces.Contains(instance))
			{
				m_Wrapper.m_CharacterViewActionsCallbackInterfaces.Add(instance);
				NextCharacter.started += instance.OnNextCharacter;
				NextCharacter.performed += instance.OnNextCharacter;
				NextCharacter.canceled += instance.OnNextCharacter;
				PrevCharacter.started += instance.OnPrevCharacter;
				PrevCharacter.performed += instance.OnPrevCharacter;
				PrevCharacter.canceled += instance.OnPrevCharacter;
				NextTab.started += instance.OnNextTab;
				NextTab.performed += instance.OnNextTab;
				NextTab.canceled += instance.OnNextTab;
				PrevTab.started += instance.OnPrevTab;
				PrevTab.performed += instance.OnPrevTab;
				PrevTab.canceled += instance.OnPrevTab;
				OpenCharacterList.started += instance.OnOpenCharacterList;
				OpenCharacterList.performed += instance.OnOpenCharacterList;
				OpenCharacterList.canceled += instance.OnOpenCharacterList;
				OpenModelView.started += instance.OnOpenModelView;
				OpenModelView.performed += instance.OnOpenModelView;
				OpenModelView.canceled += instance.OnOpenModelView;
				Upgrade.started += instance.OnUpgrade;
				Upgrade.performed += instance.OnUpgrade;
				Upgrade.canceled += instance.OnUpgrade;
				Destiny.started += instance.OnDestiny;
				Destiny.performed += instance.OnDestiny;
				Destiny.canceled += instance.OnDestiny;
				SelectMaxLevel.started += instance.OnSelectMaxLevel;
				SelectMaxLevel.performed += instance.OnSelectMaxLevel;
				SelectMaxLevel.canceled += instance.OnSelectMaxLevel;
				ShowCostCoinDetail.started += instance.OnShowCostCoinDetail;
				ShowCostCoinDetail.performed += instance.OnShowCostCoinDetail;
				ShowCostCoinDetail.canceled += instance.OnShowCostCoinDetail;
				ToggleSkillDescriptionMode.started += instance.OnToggleSkillDescriptionMode;
				ToggleSkillDescriptionMode.performed += instance.OnToggleSkillDescriptionMode;
				ToggleSkillDescriptionMode.canceled += instance.OnToggleSkillDescriptionMode;
				ShowMaterialCost.started += instance.OnShowMaterialCost;
				ShowMaterialCost.performed += instance.OnShowMaterialCost;
				ShowMaterialCost.canceled += instance.OnShowMaterialCost;
				ShowUpdatePreview.started += instance.OnShowUpdatePreview;
				ShowUpdatePreview.performed += instance.OnShowUpdatePreview;
				ShowUpdatePreview.canceled += instance.OnShowUpdatePreview;
			}
		}

		private void UnregisterCallbacks(ICharacterViewActions instance)
		{
			NextCharacter.started -= instance.OnNextCharacter;
			NextCharacter.performed -= instance.OnNextCharacter;
			NextCharacter.canceled -= instance.OnNextCharacter;
			PrevCharacter.started -= instance.OnPrevCharacter;
			PrevCharacter.performed -= instance.OnPrevCharacter;
			PrevCharacter.canceled -= instance.OnPrevCharacter;
			NextTab.started -= instance.OnNextTab;
			NextTab.performed -= instance.OnNextTab;
			NextTab.canceled -= instance.OnNextTab;
			PrevTab.started -= instance.OnPrevTab;
			PrevTab.performed -= instance.OnPrevTab;
			PrevTab.canceled -= instance.OnPrevTab;
			OpenCharacterList.started -= instance.OnOpenCharacterList;
			OpenCharacterList.performed -= instance.OnOpenCharacterList;
			OpenCharacterList.canceled -= instance.OnOpenCharacterList;
			OpenModelView.started -= instance.OnOpenModelView;
			OpenModelView.performed -= instance.OnOpenModelView;
			OpenModelView.canceled -= instance.OnOpenModelView;
			Upgrade.started -= instance.OnUpgrade;
			Upgrade.performed -= instance.OnUpgrade;
			Upgrade.canceled -= instance.OnUpgrade;
			Destiny.started -= instance.OnDestiny;
			Destiny.performed -= instance.OnDestiny;
			Destiny.canceled -= instance.OnDestiny;
			SelectMaxLevel.started -= instance.OnSelectMaxLevel;
			SelectMaxLevel.performed -= instance.OnSelectMaxLevel;
			SelectMaxLevel.canceled -= instance.OnSelectMaxLevel;
			ShowCostCoinDetail.started -= instance.OnShowCostCoinDetail;
			ShowCostCoinDetail.performed -= instance.OnShowCostCoinDetail;
			ShowCostCoinDetail.canceled -= instance.OnShowCostCoinDetail;
			ToggleSkillDescriptionMode.started -= instance.OnToggleSkillDescriptionMode;
			ToggleSkillDescriptionMode.performed -= instance.OnToggleSkillDescriptionMode;
			ToggleSkillDescriptionMode.canceled -= instance.OnToggleSkillDescriptionMode;
			ShowMaterialCost.started -= instance.OnShowMaterialCost;
			ShowMaterialCost.performed -= instance.OnShowMaterialCost;
			ShowMaterialCost.canceled -= instance.OnShowMaterialCost;
			ShowUpdatePreview.started -= instance.OnShowUpdatePreview;
			ShowUpdatePreview.performed -= instance.OnShowUpdatePreview;
			ShowUpdatePreview.canceled -= instance.OnShowUpdatePreview;
		}

		public void RemoveCallbacks(ICharacterViewActions instance)
		{
			if (m_Wrapper.m_CharacterViewActionsCallbackInterfaces.Remove(instance))
			{
				UnregisterCallbacks(instance);
			}
		}

		public void SetCallbacks(ICharacterViewActions instance)
		{
			foreach (ICharacterViewActions characterViewActionsCallbackInterface in m_Wrapper.m_CharacterViewActionsCallbackInterfaces)
			{
				UnregisterCallbacks(characterViewActionsCallbackInterface);
			}
			m_Wrapper.m_CharacterViewActionsCallbackInterfaces.Clear();
			AddCallbacks(instance);
		}
	}

	public struct LoginActions(ACTInputActions wrapper)
	{
		private ACTInputActions m_Wrapper = wrapper;

		public InputAction Enter => m_Wrapper.m_Login_Enter;

		public InputAction Account => m_Wrapper.m_Login_Account;

		public InputAction SoundMute => m_Wrapper.m_Login_SoundMute;

		public InputAction AgeNotice => m_Wrapper.m_Login_AgeNotice;

		public InputAction Billboard => m_Wrapper.m_Login_Billboard;

		public bool enabled => Get().enabled;

		public InputActionMap Get()
		{
			return m_Wrapper.m_Login;
		}

		public void Enable()
		{
			Get().Enable();
		}

		public void Disable()
		{
			Get().Disable();
		}

		public static implicit operator InputActionMap(LoginActions set)
		{
			return set.Get();
		}

		public void AddCallbacks(ILoginActions instance)
		{
			if (instance != null && !m_Wrapper.m_LoginActionsCallbackInterfaces.Contains(instance))
			{
				m_Wrapper.m_LoginActionsCallbackInterfaces.Add(instance);
				Enter.started += instance.OnEnter;
				Enter.performed += instance.OnEnter;
				Enter.canceled += instance.OnEnter;
				Account.started += instance.OnAccount;
				Account.performed += instance.OnAccount;
				Account.canceled += instance.OnAccount;
				SoundMute.started += instance.OnSoundMute;
				SoundMute.performed += instance.OnSoundMute;
				SoundMute.canceled += instance.OnSoundMute;
				AgeNotice.started += instance.OnAgeNotice;
				AgeNotice.performed += instance.OnAgeNotice;
				AgeNotice.canceled += instance.OnAgeNotice;
				Billboard.started += instance.OnBillboard;
				Billboard.performed += instance.OnBillboard;
				Billboard.canceled += instance.OnBillboard;
			}
		}

		private void UnregisterCallbacks(ILoginActions instance)
		{
			Enter.started -= instance.OnEnter;
			Enter.performed -= instance.OnEnter;
			Enter.canceled -= instance.OnEnter;
			Account.started -= instance.OnAccount;
			Account.performed -= instance.OnAccount;
			Account.canceled -= instance.OnAccount;
			SoundMute.started -= instance.OnSoundMute;
			SoundMute.performed -= instance.OnSoundMute;
			SoundMute.canceled -= instance.OnSoundMute;
			AgeNotice.started -= instance.OnAgeNotice;
			AgeNotice.performed -= instance.OnAgeNotice;
			AgeNotice.canceled -= instance.OnAgeNotice;
			Billboard.started -= instance.OnBillboard;
			Billboard.performed -= instance.OnBillboard;
			Billboard.canceled -= instance.OnBillboard;
		}

		public void RemoveCallbacks(ILoginActions instance)
		{
			if (m_Wrapper.m_LoginActionsCallbackInterfaces.Remove(instance))
			{
				UnregisterCallbacks(instance);
			}
		}

		public void SetCallbacks(ILoginActions instance)
		{
			foreach (ILoginActions loginActionsCallbackInterface in m_Wrapper.m_LoginActionsCallbackInterfaces)
			{
				UnregisterCallbacks(loginActionsCallbackInterface);
			}
			m_Wrapper.m_LoginActionsCallbackInterfaces.Clear();
			AddCallbacks(instance);
		}
	}

	public interface IPlayerActions
	{
		void OnMove(InputAction.CallbackContext context);

		void OnRegularAttack(InputAction.CallbackContext context);

		void OnSkillAttack(InputAction.CallbackContext context);

		void OnDodge(InputAction.CallbackContext context);

		void OnJump(InputAction.CallbackContext context);

		void OnVibrate(InputAction.CallbackContext context);

		void OnShortCut(InputAction.CallbackContext context);

		void OnClaw(InputAction.CallbackContext context);

		void OnSwitch1Character(InputAction.CallbackContext context);

		void OnSwitch2Character(InputAction.CallbackContext context);

		void OnSwitch3Character(InputAction.CallbackContext context);
	}

	public interface IUIActions
	{
		void OnRightClick(InputAction.CallbackContext context);

		void OnOpenAreaExplore(InputAction.CallbackContext context);

		void OnOpenSubAreaExplore(InputAction.CallbackContext context);

		void OnMoveMap(InputAction.CallbackContext context);

		void OnOpenTIps(InputAction.CallbackContext context);

		void OnImportCollect(InputAction.CallbackContext context);

		void OnLSUpDownSelect(InputAction.CallbackContext context);

		void OnLSLeftRightSelect(InputAction.CallbackContext context);

		void OnRSLeftRightSelect(InputAction.CallbackContext context);

		void OnRSUpDownSelect(InputAction.CallbackContext context);

		void OnScrollViewRightStickControl(InputAction.CallbackContext context);

		void OnMiddleClick(InputAction.CallbackContext context);

		void OnScrollWheel(InputAction.CallbackContext context);

		void OnScrollWheelY(InputAction.CallbackContext context);

		void OnClick(InputAction.CallbackContext context);

		void OnPoint(InputAction.CallbackContext context);

		void OnNavigate(InputAction.CallbackContext context);

		void OnGamePadNavigate(InputAction.CallbackContext context);

		void OnSwitchInteract(InputAction.CallbackContext context);

		void OnSwitchInteractGamePadX(InputAction.CallbackContext context);

		void OnSwitchInteractGamePadY(InputAction.CallbackContext context);

		void OnZoomFovGamePadY(InputAction.CallbackContext context);

		void OnZoomFovPageUp(InputAction.CallbackContext context);

		void OnZoomFovPageDown(InputAction.CallbackContext context);

		void OnMenuDisc(InputAction.CallbackContext context);

		void OnBag(InputAction.CallbackContext context);

		void OnCharacter(InputAction.CallbackContext context);

		void OnSummary(InputAction.CallbackContext context);

		void OnCardPool(InputAction.CallbackContext context);

		void OnActivity(InputAction.CallbackContext context);

		void OnTask(InputAction.CallbackContext context);

		void OnTeam(InputAction.CallbackContext context);

		void OnBattlePass(InputAction.CallbackContext context);

		void OnMissionTarget(InputAction.CallbackContext context);

		void OnMap(InputAction.CallbackContext context);

		void OnBack(InputAction.CallbackContext context);

		void OnEsc(InputAction.CallbackContext context);

		void OnInteract(InputAction.CallbackContext context);

		void OnGM(InputAction.CallbackContext context);

		void OnGMConsole(InputAction.CallbackContext context);

		void OnShowCursor(InputAction.CallbackContext context);

		void OnCommonSelect(InputAction.CallbackContext context);

		void OnLeftSwitchRole(InputAction.CallbackContext context);

		void OnRightSwitchRole(InputAction.CallbackContext context);

		void OnSelectNameInput(InputAction.CallbackContext context);

		void OnConfirm(InputAction.CallbackContext context);

		void OnRightStickPress(InputAction.CallbackContext context);

		void OnSNSOpenMission(InputAction.CallbackContext context);

		void OnGuideToturial(InputAction.CallbackContext context);

		void OnSpecialProppickTrigger(InputAction.CallbackContext context);

		void OnTextLibrary(InputAction.CallbackContext context);

		void OnRightStickNavigate(InputAction.CallbackContext context);

		void OnLeftStackPress(InputAction.CallbackContext context);

		void OnLeftTrigger(InputAction.CallbackContext context);

		void OnView(InputAction.CallbackContext context);

		void OnStart(InputAction.CallbackContext context);

		void OnTriggerSearchInPutField(InputAction.CallbackContext context);

		void OnSearchSubmit(InputAction.CallbackContext context);

		void OnSwitchPageLeft(InputAction.CallbackContext context);

		void OnSwitchPageRight(InputAction.CallbackContext context);

		void OnSwitchPageUp(InputAction.CallbackContext context);

		void OnSwitchPageDown(InputAction.CallbackContext context);

		void OnUISpecial1(InputAction.CallbackContext context);

		void OnUISpecial2(InputAction.CallbackContext context);

		void OnUISpecial3(InputAction.CallbackContext context);

		void OnUISpecial4(InputAction.CallbackContext context);

		void OnUISpecial5(InputAction.CallbackContext context);

		void OnUISpecial6(InputAction.CallbackContext context);

		void OnUISpecial7(InputAction.CallbackContext context);

		void OnUISpecial8(InputAction.CallbackContext context);

		void OnUISpecial9(InputAction.CallbackContext context);

		void OnUISpecial10(InputAction.CallbackContext context);

		void OnLongPressX(InputAction.CallbackContext context);

		void OnRightTrigger(InputAction.CallbackContext context);

		void OnNext(InputAction.CallbackContext context);

		void OnPrev(InputAction.CallbackContext context);

		void OnSelectItemCell(InputAction.CallbackContext context);

		void OnLock(InputAction.CallbackContext context);

		void OnShowCoinDetail(InputAction.CallbackContext context);

		void OnPressAnyKey(InputAction.CallbackContext context);

		void OnButtonUp(InputAction.CallbackContext context);

		void OnButtonDown(InputAction.CallbackContext context);

		void OnButtonLeft(InputAction.CallbackContext context);

		void OnButtonRight(InputAction.CallbackContext context);

		void OnLSUp(InputAction.CallbackContext context);

		void OnLSDown(InputAction.CallbackContext context);

		void OnLSLeft(InputAction.CallbackContext context);

		void OnLSRight(InputAction.CallbackContext context);

		void OnStopChallenge(InputAction.CallbackContext context);

		void OnWorldLevelBreakTips(InputAction.CallbackContext context);
	}

	public interface ILargeMapViewActions
	{
		void OnMapScaleReduce(InputAction.CallbackContext context);

		void OnMapScaleReduceFloat(InputAction.CallbackContext context);

		void OnMapScaleAdd(InputAction.CallbackContext context);

		void OnMapScaleAddFloat(InputAction.CallbackContext context);

		void OnSelect(InputAction.CallbackContext context);

		void OnMapItem(InputAction.CallbackContext context);

		void OnReturn(InputAction.CallbackContext context);

		void OnMapCollection(InputAction.CallbackContext context);

		void OnWorldMap(InputAction.CallbackContext context);

		void OnMapTemple(InputAction.CallbackContext context);

		void OnDelete(InputAction.CallbackContext context);

		void OnMoveMap(InputAction.CallbackContext context);

		void OnMoveCursor(InputAction.CallbackContext context);

		void OnBackToPlayer(InputAction.CallbackContext context);

		void OnWorldMapChooseLast(InputAction.CallbackContext context);

		void OnWorldMapChooseNext(InputAction.CallbackContext context);

		void OnMapSideInfoLast(InputAction.CallbackContext context);

		void OnMapSideInfoNext(InputAction.CallbackContext context);

		void OnChangeToSelectItem(InputAction.CallbackContext context);

		void OnBackToTarget(InputAction.CallbackContext context);

		void OnUp(InputAction.CallbackContext context);

		void OnDown(InputAction.CallbackContext context);

		void OnLeft(InputAction.CallbackContext context);

		void OnRight(InputAction.CallbackContext context);
	}

	public interface IConversationActions
	{
		void OnConversationNext(InputAction.CallbackContext context);

		void OnConversationAutoPlay(InputAction.CallbackContext context);

		void OnConversationReview(InputAction.CallbackContext context);

		void OnConversationHide(InputAction.CallbackContext context);

		void OnConversationReviewClose(InputAction.CallbackContext context);

		void OnConversationReviewScroll(InputAction.CallbackContext context);

		void OnConversationLastChoice(InputAction.CallbackContext context);

		void OnConversationLastChoice1(InputAction.CallbackContext context);

		void OnConversationNextChoice(InputAction.CallbackContext context);

		void OnConversationNextChoice1(InputAction.CallbackContext context);

		void OnConversationSkip(InputAction.CallbackContext context);

		void OnConversationChoose(InputAction.CallbackContext context);
	}

	public interface IStateObjectActions
	{
		void OnStateObjectMove(InputAction.CallbackContext context);
	}

	public interface ISettingsActions
	{
		void OnSettingsConfirm(InputAction.CallbackContext context);

		void OnSettingsPreTab(InputAction.CallbackContext context);

		void OnSettingsNextTab(InputAction.CallbackContext context);

		void OnSettingsSwitchDetail(InputAction.CallbackContext context);

		void OnSettingsSliderLeft(InputAction.CallbackContext context);

		void OnSettingsSliderRight(InputAction.CallbackContext context);

		void OnSettingsSliderShift(InputAction.CallbackContext context);

		void OnSettingsSliderLeftShift(InputAction.CallbackContext context);

		void OnSettingsSliderRightShift(InputAction.CallbackContext context);

		void OnSettingsSelectionUp(InputAction.CallbackContext context);

		void OnSettingsSelectionUp1(InputAction.CallbackContext context);

		void OnSettingsSelectionDown(InputAction.CallbackContext context);

		void OnSettingsSelectionDown1(InputAction.CallbackContext context);

		void OnSettingsSelectionLeft(InputAction.CallbackContext context);

		void OnSettingsSelectionLeft1(InputAction.CallbackContext context);

		void OnSettingsSelectionRight(InputAction.CallbackContext context);

		void OnSettingsSelectionRight1(InputAction.CallbackContext context);

		void OnSettingsBackHUD(InputAction.CallbackContext context);

		void OnPreTab1(InputAction.CallbackContext context);

		void OnNextTab1(InputAction.CallbackContext context);

		void OnSettingsResetToDefault(InputAction.CallbackContext context);
	}

	public interface IGuideActions
	{
		void OnClickFinshGuideStep(InputAction.CallbackContext context);

		void OnClickSkipGuide(InputAction.CallbackContext context);
	}

	public interface ITextLibraryActions
	{
		void OnTextLibraryUITipGamePadModifier(InputAction.CallbackContext context);

		void OnTextLibraryUITipGamePadBinding(InputAction.CallbackContext context);
	}

	public interface ICharacterViewActions
	{
		void OnNextCharacter(InputAction.CallbackContext context);

		void OnPrevCharacter(InputAction.CallbackContext context);

		void OnNextTab(InputAction.CallbackContext context);

		void OnPrevTab(InputAction.CallbackContext context);

		void OnOpenCharacterList(InputAction.CallbackContext context);

		void OnOpenModelView(InputAction.CallbackContext context);

		void OnUpgrade(InputAction.CallbackContext context);

		void OnDestiny(InputAction.CallbackContext context);

		void OnSelectMaxLevel(InputAction.CallbackContext context);

		void OnShowCostCoinDetail(InputAction.CallbackContext context);

		void OnToggleSkillDescriptionMode(InputAction.CallbackContext context);

		void OnShowMaterialCost(InputAction.CallbackContext context);

		void OnShowUpdatePreview(InputAction.CallbackContext context);
	}

	public interface ILoginActions
	{
		void OnEnter(InputAction.CallbackContext context);

		void OnAccount(InputAction.CallbackContext context);

		void OnSoundMute(InputAction.CallbackContext context);

		void OnAgeNotice(InputAction.CallbackContext context);

		void OnBillboard(InputAction.CallbackContext context);
	}

	private readonly InputActionMap m_Player;

	private List<IPlayerActions> m_PlayerActionsCallbackInterfaces = new List<IPlayerActions>();

	private readonly InputAction m_Player_Move;

	private readonly InputAction m_Player_RegularAttack;

	private readonly InputAction m_Player_SkillAttack;

	private readonly InputAction m_Player_Dodge;

	private readonly InputAction m_Player_Jump;

	private readonly InputAction m_Player_Vibrate;

	private readonly InputAction m_Player_ShortCut;

	private readonly InputAction m_Player_Claw;

	private readonly InputAction m_Player_Switch1Character;

	private readonly InputAction m_Player_Switch2Character;

	private readonly InputAction m_Player_Switch3Character;

	private readonly InputActionMap m_UI;

	private List<IUIActions> m_UIActionsCallbackInterfaces = new List<IUIActions>();

	private readonly InputAction m_UI_RightClick;

	private readonly InputAction m_UI_OpenAreaExplore;

	private readonly InputAction m_UI_OpenSubAreaExplore;

	private readonly InputAction m_UI_MoveMap;

	private readonly InputAction m_UI_OpenTIps;

	private readonly InputAction m_UI_ImportCollect;

	private readonly InputAction m_UI_LSUpDownSelect;

	private readonly InputAction m_UI_LSLeftRightSelect;

	private readonly InputAction m_UI_RSLeftRightSelect;

	private readonly InputAction m_UI_RSUpDownSelect;

	private readonly InputAction m_UI_ScrollViewRightStickControl;

	private readonly InputAction m_UI_MiddleClick;

	private readonly InputAction m_UI_ScrollWheel;

	private readonly InputAction m_UI_ScrollWheelY;

	private readonly InputAction m_UI_Click;

	private readonly InputAction m_UI_Point;

	private readonly InputAction m_UI_Navigate;

	private readonly InputAction m_UI_GamePadNavigate;

	private readonly InputAction m_UI_SwitchInteract;

	private readonly InputAction m_UI_SwitchInteractGamePadX;

	private readonly InputAction m_UI_SwitchInteractGamePadY;

	private readonly InputAction m_UI_ZoomFovGamePadY;

	private readonly InputAction m_UI_ZoomFovPageUp;

	private readonly InputAction m_UI_ZoomFovPageDown;

	private readonly InputAction m_UI_MenuDisc;

	private readonly InputAction m_UI_Bag;

	private readonly InputAction m_UI_Character;

	private readonly InputAction m_UI_Summary;

	private readonly InputAction m_UI_CardPool;

	private readonly InputAction m_UI_Activity;

	private readonly InputAction m_UI_Task;

	private readonly InputAction m_UI_Team;

	private readonly InputAction m_UI_BattlePass;

	private readonly InputAction m_UI_MissionTarget;

	private readonly InputAction m_UI_Map;

	private readonly InputAction m_UI_Back;

	private readonly InputAction m_UI_Esc;

	private readonly InputAction m_UI_Interact;

	private readonly InputAction m_UI_GM;

	private readonly InputAction m_UI_GMConsole;

	private readonly InputAction m_UI_ShowCursor;

	private readonly InputAction m_UI_CommonSelect;

	private readonly InputAction m_UI_LeftSwitchRole;

	private readonly InputAction m_UI_RightSwitchRole;

	private readonly InputAction m_UI_SelectNameInput;

	private readonly InputAction m_UI_Confirm;

	private readonly InputAction m_UI_RightStickPress;

	private readonly InputAction m_UI_SNSOpenMission;

	private readonly InputAction m_UI_GuideToturial;

	private readonly InputAction m_UI_SpecialProppickTrigger;

	private readonly InputAction m_UI_TextLibrary;

	private readonly InputAction m_UI_RightStickNavigate;

	private readonly InputAction m_UI_LeftStackPress;

	private readonly InputAction m_UI_LeftTrigger;

	private readonly InputAction m_UI_View;

	private readonly InputAction m_UI_Start;

	private readonly InputAction m_UI_TriggerSearchInPutField;

	private readonly InputAction m_UI_SearchSubmit;

	private readonly InputAction m_UI_SwitchPageLeft;

	private readonly InputAction m_UI_SwitchPageRight;

	private readonly InputAction m_UI_SwitchPageUp;

	private readonly InputAction m_UI_SwitchPageDown;

	private readonly InputAction m_UI_UISpecial1;

	private readonly InputAction m_UI_UISpecial2;

	private readonly InputAction m_UI_UISpecial3;

	private readonly InputAction m_UI_UISpecial4;

	private readonly InputAction m_UI_UISpecial5;

	private readonly InputAction m_UI_UISpecial6;

	private readonly InputAction m_UI_UISpecial7;

	private readonly InputAction m_UI_UISpecial8;

	private readonly InputAction m_UI_UISpecial9;

	private readonly InputAction m_UI_UISpecial10;

	private readonly InputAction m_UI_LongPressX;

	private readonly InputAction m_UI_RightTrigger;

	private readonly InputAction m_UI_Next;

	private readonly InputAction m_UI_Prev;

	private readonly InputAction m_UI_SelectItemCell;

	private readonly InputAction m_UI_Lock;

	private readonly InputAction m_UI_ShowCoinDetail;

	private readonly InputAction m_UI_PressAnyKey;

	private readonly InputAction m_UI_ButtonUp;

	private readonly InputAction m_UI_ButtonDown;

	private readonly InputAction m_UI_ButtonLeft;

	private readonly InputAction m_UI_ButtonRight;

	private readonly InputAction m_UI_LSUp;

	private readonly InputAction m_UI_LSDown;

	private readonly InputAction m_UI_LSLeft;

	private readonly InputAction m_UI_LSRight;

	private readonly InputAction m_UI_StopChallenge;

	private readonly InputAction m_UI_WorldLevelBreakTips;

	private readonly InputActionMap m_LargeMapView;

	private List<ILargeMapViewActions> m_LargeMapViewActionsCallbackInterfaces = new List<ILargeMapViewActions>();

	private readonly InputAction m_LargeMapView_mapScaleReduce;

	private readonly InputAction m_LargeMapView_mapScaleReduceFloat;

	private readonly InputAction m_LargeMapView_mapScaleAdd;

	private readonly InputAction m_LargeMapView_mapScaleAddFloat;

	private readonly InputAction m_LargeMapView_Select;

	private readonly InputAction m_LargeMapView_MapItem;

	private readonly InputAction m_LargeMapView_Return;

	private readonly InputAction m_LargeMapView_MapCollection;

	private readonly InputAction m_LargeMapView_WorldMap;

	private readonly InputAction m_LargeMapView_MapTemple;

	private readonly InputAction m_LargeMapView_Delete;

	private readonly InputAction m_LargeMapView_MoveMap;

	private readonly InputAction m_LargeMapView_MoveCursor;

	private readonly InputAction m_LargeMapView_BackToPlayer;

	private readonly InputAction m_LargeMapView_WorldMapChooseLast;

	private readonly InputAction m_LargeMapView_WorldMapChooseNext;

	private readonly InputAction m_LargeMapView_MapSideInfoLast;

	private readonly InputAction m_LargeMapView_MapSideInfoNext;

	private readonly InputAction m_LargeMapView_ChangeToSelectItem;

	private readonly InputAction m_LargeMapView_BackToTarget;

	private readonly InputAction m_LargeMapView_Up;

	private readonly InputAction m_LargeMapView_Down;

	private readonly InputAction m_LargeMapView_Left;

	private readonly InputAction m_LargeMapView_Right;

	private readonly InputActionMap m_Conversation;

	private List<IConversationActions> m_ConversationActionsCallbackInterfaces = new List<IConversationActions>();

	private readonly InputAction m_Conversation_ConversationNext;

	private readonly InputAction m_Conversation_ConversationAutoPlay;

	private readonly InputAction m_Conversation_ConversationReview;

	private readonly InputAction m_Conversation_ConversationHide;

	private readonly InputAction m_Conversation_ConversationReviewClose;

	private readonly InputAction m_Conversation_ConversationReviewScroll;

	private readonly InputAction m_Conversation_ConversationLastChoice;

	private readonly InputAction m_Conversation_ConversationLastChoice1;

	private readonly InputAction m_Conversation_ConversationNextChoice;

	private readonly InputAction m_Conversation_ConversationNextChoice1;

	private readonly InputAction m_Conversation_ConversationSkip;

	private readonly InputAction m_Conversation_ConversationChoose;

	private readonly InputActionMap m_StateObject;

	private List<IStateObjectActions> m_StateObjectActionsCallbackInterfaces = new List<IStateObjectActions>();

	private readonly InputAction m_StateObject_StateObjectMove;

	private readonly InputActionMap m_Settings;

	private List<ISettingsActions> m_SettingsActionsCallbackInterfaces = new List<ISettingsActions>();

	private readonly InputAction m_Settings_SettingsConfirm;

	private readonly InputAction m_Settings_SettingsPreTab;

	private readonly InputAction m_Settings_SettingsNextTab;

	private readonly InputAction m_Settings_SettingsSwitchDetail;

	private readonly InputAction m_Settings_SettingsSliderLeft;

	private readonly InputAction m_Settings_SettingsSliderRight;

	private readonly InputAction m_Settings_SettingsSliderShift;

	private readonly InputAction m_Settings_SettingsSliderLeftShift;

	private readonly InputAction m_Settings_SettingsSliderRightShift;

	private readonly InputAction m_Settings_SettingsSelectionUp;

	private readonly InputAction m_Settings_SettingsSelectionUp1;

	private readonly InputAction m_Settings_SettingsSelectionDown;

	private readonly InputAction m_Settings_SettingsSelectionDown1;

	private readonly InputAction m_Settings_SettingsSelectionLeft;

	private readonly InputAction m_Settings_SettingsSelectionLeft1;

	private readonly InputAction m_Settings_SettingsSelectionRight;

	private readonly InputAction m_Settings_SettingsSelectionRight1;

	private readonly InputAction m_Settings_SettingsBackHUD;

	private readonly InputAction m_Settings_PreTab1;

	private readonly InputAction m_Settings_NextTab1;

	private readonly InputAction m_Settings_SettingsResetToDefault;

	private readonly InputActionMap m_Guide;

	private List<IGuideActions> m_GuideActionsCallbackInterfaces = new List<IGuideActions>();

	private readonly InputAction m_Guide_ClickFinshGuideStep;

	private readonly InputAction m_Guide_ClickSkipGuide;

	private readonly InputActionMap m_TextLibrary;

	private List<ITextLibraryActions> m_TextLibraryActionsCallbackInterfaces = new List<ITextLibraryActions>();

	private readonly InputAction m_TextLibrary_TextLibraryUITipGamePadModifier;

	private readonly InputAction m_TextLibrary_TextLibraryUITipGamePadBinding;

	private readonly InputActionMap m_CharacterView;

	private List<ICharacterViewActions> m_CharacterViewActionsCallbackInterfaces = new List<ICharacterViewActions>();

	private readonly InputAction m_CharacterView_NextCharacter;

	private readonly InputAction m_CharacterView_PrevCharacter;

	private readonly InputAction m_CharacterView_NextTab;

	private readonly InputAction m_CharacterView_PrevTab;

	private readonly InputAction m_CharacterView_OpenCharacterList;

	private readonly InputAction m_CharacterView_OpenModelView;

	private readonly InputAction m_CharacterView_Upgrade;

	private readonly InputAction m_CharacterView_Destiny;

	private readonly InputAction m_CharacterView_SelectMaxLevel;

	private readonly InputAction m_CharacterView_ShowCostCoinDetail;

	private readonly InputAction m_CharacterView_ToggleSkillDescriptionMode;

	private readonly InputAction m_CharacterView_ShowMaterialCost;

	private readonly InputAction m_CharacterView_ShowUpdatePreview;

	private readonly InputActionMap m_Login;

	private List<ILoginActions> m_LoginActionsCallbackInterfaces = new List<ILoginActions>();

	private readonly InputAction m_Login_Enter;

	private readonly InputAction m_Login_Account;

	private readonly InputAction m_Login_SoundMute;

	private readonly InputAction m_Login_AgeNotice;

	private readonly InputAction m_Login_Billboard;

	public InputActionAsset asset { get; }

	public InputBinding? bindingMask
	{
		get
		{
			return asset.bindingMask;
		}
		set
		{
			asset.bindingMask = value;
		}
	}

	public ReadOnlyArray<InputDevice>? devices
	{
		get
		{
			return asset.devices;
		}
		set
		{
			asset.devices = value;
		}
	}

	public ReadOnlyArray<InputControlScheme> controlSchemes => asset.controlSchemes;

	public IEnumerable<InputBinding> bindings => asset.bindings;

	public PlayerActions Player => new PlayerActions(this);

	public UIActions UI => new UIActions(this);

	public LargeMapViewActions LargeMapView => new LargeMapViewActions(this);

	public ConversationActions Conversation => new ConversationActions(this);

	public StateObjectActions StateObject => new StateObjectActions(this);

	public SettingsActions Settings => new SettingsActions(this);

	public GuideActions Guide => new GuideActions(this);

	public TextLibraryActions TextLibrary => new TextLibraryActions(this);

	public CharacterViewActions CharacterView => new CharacterViewActions(this);

	public LoginActions Login => new LoginActions(this);

	public ACTInputActions()
	{
		asset = InputActionAsset.FromJson("{\r\n    \"version\": 1,\r\n    \"name\": \"ACTInputActions\",\r\n    \"maps\": [\r\n        {\r\n            \"name\": \"Player\",\r\n            \"id\": \"04e25266-d819-4694-962d-428a27016023\",\r\n            \"actions\": [\r\n                {\r\n                    \"name\": \"Move\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"0fa1e4d7-9884-46a1-b950-b60d34df1c0a\",\r\n                    \"expectedControlType\": \"Vector2\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                },\r\n                {\r\n                    \"name\": \"RegularAttack\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"501b9748-299c-498e-8390-fed2274bd86f\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                },\r\n                {\r\n                    \"name\": \"SkillAttack\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"06dc2bf6-a12c-44fd-b12b-3b74dcc76c3e\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                },\r\n                {\r\n                    \"name\": \"Dodge\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"f8e1da85-8418-4e86-85ef-bfaad376be8e\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                },\r\n                {\r\n                    \"name\": \"Jump\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"7cedf2ec-e1d5-41f2-93ff-b04f4114dbca\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                },\r\n                {\r\n                    \"name\": \"Vibrate\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"dc8951af-f0f6-42cf-a0eb-37e82749e3a2\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                },\r\n                {\r\n                    \"name\": \"ShortCut\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"0baabff4-1a80-4fe7-bd49-19d3dea4a2cc\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                },\r\n                {\r\n                    \"name\": \"Claw\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"ca3c217a-38c0-4200-bdbd-8d7daf93dc72\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                },\r\n                {\r\n                    \"name\": \"Switch1Character\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"a2e49eeb-28b3-470c-bfab-0e295ad5d582\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                },\r\n                {\r\n                    \"name\": \"Switch2Character\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"338a6cef-8320-4a39-9775-b9bc000787a3\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                },\r\n                {\r\n                    \"name\": \"Switch3Character\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"84168a5c-e065-41ab-aded-db2aa6182193\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                }\r\n            ],\r\n            \"bindings\": [\r\n                {\r\n                    \"name\": \"WSAD\",\r\n                    \"id\": \"8ad63b96-4edb-4352-a195-39a052b3157e\",\r\n                    \"path\": \"2DVector\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": true,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"up\",\r\n                    \"id\": \"1381268b-f667-4524-8567-b392db00dab6\",\r\n                    \"path\": \"<Keyboard>/w\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"down\",\r\n                    \"id\": \"289b0c7d-10ed-4e96-b340-6daf0fd7cda9\",\r\n                    \"path\": \"<Keyboard>/s\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"left\",\r\n                    \"id\": \"7e5965d8-5f1c-4565-be5d-2e822b67c063\",\r\n                    \"path\": \"<Keyboard>/a\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"right\",\r\n                    \"id\": \"9dee374c-98c3-4760-bb10-d4208772e986\",\r\n                    \"path\": \"<Keyboard>/d\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"UpDownLeftRight\",\r\n                    \"id\": \"ce51a3e0-ef5c-4cb2-9a50-f843cfaf8985\",\r\n                    \"path\": \"2DVector\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": true,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"up\",\r\n                    \"id\": \"9f4556a9-6357-490a-bff8-0551792d9de7\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"down\",\r\n                    \"id\": \"f05639b7-3347-4819-9db1-91bda16bc154\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"left\",\r\n                    \"id\": \"8ed33926-5357-453b-b144-f2c9a219a74c\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"right\",\r\n                    \"id\": \"2c61dd74-7fc2-419b-8f53-348ff5594435\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"978bfe49-cc26-4a3d-ab7b-7d7a29327403\",\r\n                    \"path\": \"<Gamepad>/leftStick\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"StickDeadzone(min=1.401298E-45,max=1.401298E-45)\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"8dd0a321-f63c-43bb-8c8d-42857ab971f9\",\r\n                    \"path\": \"<OnScreenControlDevice>/leftStick\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Move\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"66802d91-026a-419a-9882-ac05f2851bdf\",\r\n                    \"path\": \"<Keyboard>/1\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Switch1Character\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ca82ce41-a3eb-4ca1-b5fa-75d4c7be7c6a\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Switch1Character\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"24243bbd-0843-44d1-ae7d-d70680a8bcf8\",\r\n                    \"path\": \"<Gamepad>/dpad/up\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Switch1Character\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"aa8513e6-ec0d-4bce-b1dc-f3d56df6b00f\",\r\n                    \"path\": \"<OnScreenControlDevice>/dpad/up\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Switch1Character\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"95bbb7bb-a6cd-451a-b4ac-935a564f8f05\",\r\n                    \"path\": \"<Keyboard>/2\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Switch2Character\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f3b2a5c6-7036-493a-a59d-5612fd00cb7e\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Switch2Character\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"a4fb40b4-c6a8-4ff4-9621-f0b7922ecd12\",\r\n                    \"path\": \"<Gamepad>/dpad/right\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Switch2Character\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f805458b-e701-44de-9b46-be29deef26f1\",\r\n                    \"path\": \"<OnScreenControlDevice>/dpad/right\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Switch2Character\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7dc23176-1822-41a6-9a4f-f50c2f1ff9c8\",\r\n                    \"path\": \"<Keyboard>/3\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Switch3Character\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b75dad54-4c8b-4a61-9b7f-d5fc60fd2dc9\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Switch3Character\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d528b9a8-9c44-4e1a-9aad-5002bfc7c982\",\r\n                    \"path\": \"<Gamepad>/dpad/down\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Switch3Character\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"9bbc5a7e-21ba-4937-8cb2-77725f89cd5a\",\r\n                    \"path\": \"<OnScreenControlDevice>/dpad/down\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Switch3Character\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"318a858f-23e2-4430-ba4b-1dbef931958d\",\r\n                    \"path\": \"<Mouse>/leftButton\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"RegularAttack\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"58be04da-ed44-4737-8674-eb78af9fc71a\",\r\n                    \"path\": \"<Keyboard>/j\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"RegularAttack\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d45d296a-4b24-4fa8-a3ab-33cda0643362\",\r\n                    \"path\": \"<Gamepad>/buttonWest\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"RegularAttack\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"63205569-7acf-4cb5-88bc-e177f5a8280d\",\r\n                    \"path\": \"<OnScreenControlDevice>/buttonWest\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"RegularAttack\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"376f7c86-35f3-448f-a44e-1e42d0251c63\",\r\n                    \"path\": \"<Keyboard>/e\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SkillAttack\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"9db45c68-63cb-4816-9fbe-6625e0a8524a\",\r\n                    \"path\": \"<Keyboard>/k\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SkillAttack\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"23f0beab-922a-4842-9002-7a157f8f046a\",\r\n                    \"path\": \"<Gamepad>/buttonNorth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SkillAttack\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"9c17c7f5-5d3f-418c-937d-48986536d56c\",\r\n                    \"path\": \"<OnScreenControlDevice>/buttonNorth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SkillAttack\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ddcaa2dc-193d-4831-94ed-e32faf6b853b\",\r\n                    \"path\": \"<Keyboard>/q\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Vibrate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"53072730-5116-414f-b7ce-19b8b4ba0036\",\r\n                    \"path\": \"<Keyboard>/l\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Vibrate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"e0f29e26-fdb5-44ca-a83c-484e7a4d1498\",\r\n                    \"path\": \"<Gamepad>/rightTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Vibrate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"701c0cde-c65f-429d-b92a-af2c6e378fcb\",\r\n                    \"path\": \"<OnScreenControlDevice>/rightTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Vibrate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"a47d1b40-a0de-4db8-b721-4241c58ddc05\",\r\n                    \"path\": \"<Mouse>/rightButton\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Dodge\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"185a7f88-407a-4875-a198-cd620496757b\",\r\n                    \"path\": \"<Keyboard>/leftShift\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Dodge\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b4c250bc-dc71-422f-a0bd-5627c79eb692\",\r\n                    \"path\": \"<Gamepad>/buttonEast\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Dodge\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"9d8b3499-5951-4019-9850-7ca046b06f38\",\r\n                    \"path\": \"<OnScreenControlDevice>/buttonEast\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Dodge\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"abbe92fe-ff9d-49d2-bd30-8e391545d7fa\",\r\n                    \"path\": \"<Keyboard>/r\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Claw\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d5df8371-4c8e-4fe7-bc64-3342f68bb681\",\r\n                    \"path\": \"<Keyboard>/i\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Claw\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"40caff44-8401-4ad1-9331-8e318dd7823c\",\r\n                    \"path\": \"<Gamepad>/leftTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Claw\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"3bd8d9b9-2568-42f3-b553-c84b5e3b0a2b\",\r\n                    \"path\": \"<OnScreenControlDevice>/leftTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Claw\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"15d52b3a-a1bb-4f88-beaf-b714ff938199\",\r\n                    \"path\": \"<Keyboard>/space\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Jump\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"dd80a769-c6fc-4fc7-9327-10680a1b5d39\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Jump\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"a6b8db95-3e9e-4a57-8ba8-427ff86c649d\",\r\n                    \"path\": \"<Gamepad>/buttonSouth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Jump\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"dd904c30-2d88-481b-9e71-cd75b2bc5d68\",\r\n                    \"path\": \"<OnScreenControlDevice>/buttonSouth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Jump\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"feb48994-b57e-48e8-ac69-d049b7705aad\",\r\n                    \"path\": \"<Keyboard>/z\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShortCut\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"4ab21c69-c0d0-40cf-902d-3d5f8e176b5f\",\r\n                    \"path\": \"<Keyboard>/h\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShortCut\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"One Modifier\",\r\n                    \"id\": \"0bba36f8-836d-4710-86fe-0233a230c85f\",\r\n                    \"path\": \"OneModifier\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShortCut\",\r\n                    \"isComposite\": true,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"modifier\",\r\n                    \"id\": \"e2fbd390-562e-4b50-b070-b11fce9a3c44\",\r\n                    \"path\": \"<Gamepad>/leftShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShortCut\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"binding\",\r\n                    \"id\": \"137e8092-e0b6-44be-85c3-47d38c496201\",\r\n                    \"path\": \"<Gamepad>/buttonNorth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShortCut\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                }\r\n            ]\r\n        },\r\n        {\r\n            \"name\": \"UI\",\r\n            \"id\": \"fb8015e5-3842-4bc7-8c83-da0740b55c64\",\r\n            \"actions\": [\r\n                {\r\n                    \"name\": \"RightClick\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"929746c0-81fd-4da1-acff-baf55aeab625\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                },\r\n                {\r\n                    \"name\": \"OpenAreaExplore\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"3753f9f8-3e67-4834-bb0b-cadf46fa1b1e\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"OpenSubAreaExplore\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"9c70cfc3-4bb2-4b29-bcdd-e801480b5407\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"MoveMap\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"c1702744-5dce-43a8-9230-88ba4228b161\",\r\n                    \"expectedControlType\": \"Vector2\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"OpenTIps\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"bd272e1c-eeef-43f6-a46d-1d1f1d1fb72f\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ImportCollect\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"fe320230-9094-4d06-b78c-2261c65626df\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"LSUpDownSelect\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"30cfdc52-854a-4b14-bd19-32ef87ab1222\",\r\n                    \"expectedControlType\": \"Axis\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"LSLeftRightSelect\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"afab5f2f-369e-4c0a-83b3-d713112f56c4\",\r\n                    \"expectedControlType\": \"Axis\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"RSLeftRightSelect\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"ceda5e40-6172-45bf-bc73-652c43a1354e\",\r\n                    \"expectedControlType\": \"Axis\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"RSUpDownSelect\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"20084fac-b77f-4b73-869a-fba5952c6576\",\r\n                    \"expectedControlType\": \"Axis\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ScrollViewRightStickControl\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"bf25a8fa-56fe-4982-952c-63bb97ada25b\",\r\n                    \"expectedControlType\": \"Vector2\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"MiddleClick\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"3564de43-e0c3-4594-8cb2-fef28992840b\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ScrollWheel\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"f255a131-0354-48ed-8bef-957064509d41\",\r\n                    \"expectedControlType\": \"Vector2\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ScrollWheelY\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"e1a55d56-e085-4b22-80bb-6faba929093b\",\r\n                    \"expectedControlType\": \"Axis\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Click\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"3fa56bdd-193c-4a42-b6e2-55741ea2e21f\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Point\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"178667b8-bb3d-499a-9436-6ba796c35077\",\r\n                    \"expectedControlType\": \"Vector2\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Navigate\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"db3d6d68-efba-46b9-ab22-6f20f6ea2117\",\r\n                    \"expectedControlType\": \"Vector2\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"GamePadNavigate\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"02f9ec4b-3684-4fbb-acdd-f1bc39f2091a\",\r\n                    \"expectedControlType\": \"Vector2\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SwitchInteract\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"238a7369-3780-4834-b62c-9b98ee60647d\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SwitchInteractGamePadX\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"f154787f-49c5-4f15-b9de-13db3590b82f\",\r\n                    \"expectedControlType\": \"Axis\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SwitchInteractGamePadY\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"05cde66b-2d79-4335-912f-e1896f0fb745\",\r\n                    \"expectedControlType\": \"Axis\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ZoomFovGamePadY\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"f0484f74-4a63-4993-97b1-6cb2ee163bce\",\r\n                    \"expectedControlType\": \"Vector2\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ZoomFovPageUp\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"aa7aa338-9814-4926-aa62-898f231d003c\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ZoomFovPageDown\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"483de438-e01a-40a7-8bf1-b3917e48e491\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"MenuDisc\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"f6b2e305-c0b9-4071-8820-86a5ff1615e8\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Bag\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"6d371c11-bfc9-4b2f-a407-e50e847be57c\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Character\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"830d27ad-15f1-4254-841b-31ab9504fc82\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Summary\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"d72b2f00-b606-4b95-b1be-969e1b8feca8\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"CardPool\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"3077fce8-cf5b-4d09-b552-5f8b7f377b4f\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Activity\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"b72857bb-cdd7-4e4d-ba7a-dd29ad231b61\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Task\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"2468ccd7-9641-4a00-9741-01aa632a0199\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Team\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"b710e408-91ce-42e4-8914-2dee7a89f983\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"BattlePass\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"8b4fa71d-b8fc-43ac-9d2a-8e807bcbc012\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"MissionTarget\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"c1596e7f-dc58-4b82-93bf-b0b6629ab272\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Map\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"ad3d0eab-80d5-43d1-ad81-ac469a4cdf0c\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Back\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"3d820647-8c79-45a0-932d-8a0e99d27be8\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Esc\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"74eed6e3-b9dd-4824-b065-9f03fb20904e\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Interact\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"06ce800e-63fb-4c06-9a24-d1592782f477\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"GM\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"fa4515bb-d747-4809-ac78-b4134d283d8b\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"GMConsole\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"01fee7d5-f521-4a55-b231-94b1f636b63c\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ShowCursor\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"71812771-cfd6-4866-b6c2-f6253c2ec62f\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"CommonSelect\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"2d8aa382-5079-409f-b0aa-b4628d93d3e7\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"LeftSwitchRole\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"82bf39ab-87c1-4256-a210-e9e6041f331e\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"RightSwitchRole\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"62b287cd-cd06-4aa0-bb75-825eee611104\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SelectNameInput\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"d5a19072-b437-42d4-8893-1a4667c331da\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Confirm\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"cc6f929f-8406-45ae-a69e-8fe3a57e39a8\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"RightStickPress\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"90e84381-10ea-47c7-9934-d6c2dda1ca80\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SNSOpenMission\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"b63c9d60-0d0a-4373-a4c2-ef6be87f06ff\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"GuideToturial\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"37754b3e-e8fd-4c0f-8c9a-23ae4b6c6cf6\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SpecialProppickTrigger\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"e7024af2-560a-446a-87ab-7a3ffdf3a447\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"TextLibrary\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"86dfb443-2ef8-4d1b-b2d5-ac78ea5917a6\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"RightStickNavigate\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"72b7b55a-7531-4f2c-a8d9-8d236385669a\",\r\n                    \"expectedControlType\": \"Vector2\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"LeftStackPress\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"cf7c31bb-041b-456d-98bd-cc25385573b5\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"LeftTrigger\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"dd667d83-d2b9-45fc-93bd-da8b78363e27\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"View\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"eb3b585e-ce1d-42dd-99fc-3ce915c657ab\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Start\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"43c91abd-69d9-4611-a599-15df0ad6c125\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"TriggerSearchInPutField\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"cc8706c4-809c-4067-9341-8f9a72e61781\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SearchSubmit\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"582755ca-8950-4930-a645-7e493e0f8b6e\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SwitchPageLeft\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"2c9c4ad6-2462-410b-b8b7-63b9fa90ea60\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SwitchPageRight\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"e182f565-df81-4051-8e51-4ec2e1ff1f8d\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SwitchPageUp\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"c45ec4ba-412a-4e95-983d-bba54f67df30\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SwitchPageDown\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"bce7231b-7ff4-477e-9ef0-203140490a1c\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"UISpecial1\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"cf691991-7e8c-42fb-847f-8191113781a1\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"UISpecial2\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"3842cdc0-1edb-4fb1-ad8e-d1f6ae78780e\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"UISpecial3\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"97855fc7-8178-4a4f-8904-8b033418de9a\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"UISpecial4\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"c05730f4-feb4-4a7f-a3a6-ace643cbb340\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"UISpecial5\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"840f84c5-060e-4782-87fd-73af7b333147\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"UISpecial6\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"1a7436d2-0ab8-4260-aaf3-7d8b61b02e52\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"UISpecial7\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"1dc8aa24-4bc2-4f36-9379-8a39f2e81b28\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"UISpecial8\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"4275a64a-76f7-4e5d-8e42-5aefcc4a8289\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"UISpecial9\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"a46130f4-34b7-4617-843d-7a0cb682c7c8\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"UISpecial10\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"ff6a042d-93cf-48ae-b510-c7d26283d51b\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"LongPressX\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"ce681562-5b73-4082-a4ad-826cb689a6a8\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"RightTrigger\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"e61fdd26-529d-42a7-a964-7dd3aae81a27\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Next\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"2d026251-1a8a-42d0-8092-3f88ef2cbf2c\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"AxisDeadzone(min=0.5),Clamp(max=1)\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                },\r\n                {\r\n                    \"name\": \"Prev\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"98af2a43-b1bf-4089-a5d0-777651e63fc0\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"AxisDeadzone(min=0.5),Clamp(max=1)\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                },\r\n                {\r\n                    \"name\": \"SelectItemCell\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"b17b3445-c4fe-4d33-9869-eadfd97117b5\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Lock\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"b3c6ef57-d0c2-4737-80bf-210f840711b0\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ShowCoinDetail\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"2d3c06ad-b251-4001-8b29-b7a27d2d4399\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"PressAnyKey\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"ec39ca19-118c-40b6-969f-83a7d40f5d2a\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ButtonUp\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"5c1a664a-485e-469f-8bfb-9f967d16bb10\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ButtonDown\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"3f708e3a-81e2-4e07-96ca-7ad6c3cdadec\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ButtonLeft\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"89b16c1f-0827-49a4-af62-33172e7a1908\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ButtonRight\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"6f0610fa-c285-4f6c-829b-fedd6c7caa70\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"LSUp\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"5fa7bc03-517b-4da4-afc2-8bdff7810883\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"LSDown\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"b2835a83-ad33-46ac-bcd6-4710d81f2ae4\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"LSLeft\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"3d2f2f47-f511-4eab-b234-0a1e1b3356bc\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"LSRight\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"1aacee70-358a-4414-9730-0367fe24d706\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"StopChallenge\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"4ec9d1d6-cb42-401a-9c8a-e4136007d2f9\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"WorldLevelBreakTips\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"0cd1ebb1-e16e-42a0-9a8a-4f97accc8930\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                }\r\n            ],\r\n            \"bindings\": [\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b5d8c252-a32b-4d69-ba14-ef2ffa1a2596\",\r\n                    \"path\": \"<Gamepad>/dpad\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Navigate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"a1938602-62be-45d4-980f-d980592eab47\",\r\n                    \"path\": \"<Gamepad>/leftStick\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Navigate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"eeda1cb9-381f-4853-9389-f0ab4cf82544\",\r\n                    \"path\": \"<Keyboard>/escape\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Back\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f84bcd4b-385a-4501-b74b-d1e45db4ca96\",\r\n                    \"path\": \"<Gamepad>/buttonEast\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Back\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"Keyboard\",\r\n                    \"id\": \"bac5abe0-a6fb-450c-b704-09f488f34e41\",\r\n                    \"path\": \"2DVector\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Navigate\",\r\n                    \"isComposite\": true,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"up\",\r\n                    \"id\": \"ddd4aef1-f60d-4064-a1da-1637150c8e5d\",\r\n                    \"path\": \"<Keyboard>/upArrow\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Navigate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"down\",\r\n                    \"id\": \"7cbceece-7b34-4265-869f-4d495854eff9\",\r\n                    \"path\": \"<Keyboard>/downArrow\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Navigate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"left\",\r\n                    \"id\": \"20b14747-aec6-45fc-a0d5-bb98d4323ba2\",\r\n                    \"path\": \"<Keyboard>/leftArrow\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Navigate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"right\",\r\n                    \"id\": \"558f4ac9-1441-41ed-aa4e-9cacd7ca7400\",\r\n                    \"path\": \"<Keyboard>/rightArrow\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Navigate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"WASD\",\r\n                    \"id\": \"04e6ba84-559b-4bd9-b5b5-a44608f0f659\",\r\n                    \"path\": \"2DVector\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Navigate\",\r\n                    \"isComposite\": true,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"up\",\r\n                    \"id\": \"6acf2543-7b71-4ed8-8b08-c11e8d21db0c\",\r\n                    \"path\": \"<Keyboard>/w\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Navigate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"down\",\r\n                    \"id\": \"4f661855-4417-43ab-bbaa-5bd60bc09e42\",\r\n                    \"path\": \"<Keyboard>/s\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Navigate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"left\",\r\n                    \"id\": \"e5ce24d7-da19-41c6-af62-0d4b4969280f\",\r\n                    \"path\": \"<Keyboard>/a\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Navigate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"right\",\r\n                    \"id\": \"a3eafc8b-ee83-4928-bd5e-a15ed94c6ecc\",\r\n                    \"path\": \"<Keyboard>/d\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Navigate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7ab29c65-67a4-4726-b606-08886f603340\",\r\n                    \"path\": \"<Gamepad>/leftStick\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"GamePadNavigate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"74ac2ebd-4941-4d4e-81a1-b503e4e4e04f\",\r\n                    \"path\": \"<Mouse>/position\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Point\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"0baf4373-9586-4cb3-8f68-f27490b43cdd\",\r\n                    \"path\": \"<Pen>/position\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Point\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"42d7ffd3-98d8-46ed-9459-038b8b14606e\",\r\n                    \"path\": \"<Touchscreen>/touch*/position\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Point\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"07e9d198-5792-4006-b771-7844053a2c1b\",\r\n                    \"path\": \"<Mouse>/leftButton\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Click\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"52b63527-0340-4352-bf00-805958daba8e\",\r\n                    \"path\": \"<Pen>/tip\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Click\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"befd3ef7-2542-4c05-8ab0-6f34df09319c\",\r\n                    \"path\": \"<Touchscreen>/touch*/press\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Click\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"cee0cda3-e25b-421c-a604-4397f0c9b85a\",\r\n                    \"path\": \"<Mouse>/scroll\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ScrollWheel\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ca97881d-35f8-436f-9df1-f90bc88eb2a3\",\r\n                    \"path\": \"<Mouse>/scroll/y\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ScrollWheelY\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"e27373ba-21e9-4a67-aa23-bf0cf65d5325\",\r\n                    \"path\": \"<Mouse>/middleButton\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MiddleClick\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"212911f4-0bdb-4fca-af53-0ee87ba903a7\",\r\n                    \"path\": \"<Mouse>/rightButton\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"RightClick\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"372ba12f-e465-40fb-9960-b66fc57722e8\",\r\n                    \"path\": \"<Gamepad>/dpad/up\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"OpenAreaExplore\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"75e10a34-636f-4c0d-a756-712487d0a76e\",\r\n                    \"path\": \"<Gamepad>/dpad/down\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"OpenSubAreaExplore\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"4a307dbb-d136-448d-9e3f-dfe6749df778\",\r\n                    \"path\": \"<Gamepad>/leftStick\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MoveMap\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"2D Vector\",\r\n                    \"id\": \"9cb0b45d-2a50-4dff-ac83-ec6be098fa83\",\r\n                    \"path\": \"2DVector\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MoveMap\",\r\n                    \"isComposite\": true,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"up\",\r\n                    \"id\": \"18724cd8-362d-49d4-b120-30140a51edb8\",\r\n                    \"path\": \"<Keyboard>/w\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MoveMap\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"down\",\r\n                    \"id\": \"743af945-d6eb-4d33-8cc8-8131cc2d6466\",\r\n                    \"path\": \"<Keyboard>/s\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MoveMap\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"left\",\r\n                    \"id\": \"753463d6-c1f1-4705-84c3-677847679f98\",\r\n                    \"path\": \"<Keyboard>/a\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MoveMap\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"right\",\r\n                    \"id\": \"f2ea7b73-2977-40e1-bdcc-12b73e7f3634\",\r\n                    \"path\": \"<Keyboard>/d\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MoveMap\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"3b01696a-1312-4ce1-ade1-8698d6a2e068\",\r\n                    \"path\": \"<Keyboard>/d\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Next\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"474e4dab-51a4-496a-853b-7b81d965030a\",\r\n                    \"path\": \"<Gamepad>/dpad/right\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Next\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b90b205a-70ec-4cae-b1b3-af6e34660e90\",\r\n                    \"path\": \"<Gamepad>/leftStick/right\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Next\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"8e940f55-8beb-4c24-b2ce-a13e4210e739\",\r\n                    \"path\": \"<Keyboard>/a\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Prev\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"cc62d94e-a902-410e-aaa8-be1ae210a2b4\",\r\n                    \"path\": \"<Gamepad>/dpad/left\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Prev\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f23e92ac-c8fc-406d-b5d8-055eb1eece06\",\r\n                    \"path\": \"<Gamepad>/leftStick/left\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Prev\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"8d71eadb-0021-439f-b295-112ed918a8ea\",\r\n                    \"path\": \"<Gamepad>/rightStickPress\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"OpenTIps\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"e4a4ebb3-1196-450e-a533-94d323b6b01e\",\r\n                    \"path\": \"<Gamepad>/leftStickPress\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ImportCollect\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"3d609200-eda8-4175-b371-2784d16f2dfc\",\r\n                    \"path\": \"<Gamepad>/leftStick/y\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LSUpDownSelect\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"3030c671-0fa3-4ff8-8282-eadb8bc8e934\",\r\n                    \"path\": \"<Gamepad>/leftStick/x\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LSLeftRightSelect\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"423c8c0e-e9e1-47c5-83c4-6d44b5242b90\",\r\n                    \"path\": \"<Gamepad>/rightStick/x\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"RSLeftRightSelect\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"04cf5e8f-92fe-413b-83eb-5b7fd03c2abc\",\r\n                    \"path\": \"<Gamepad>/rightStick/y\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"RSUpDownSelect\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"cd9d768b-0fce-44cb-a0b0-2925dc3fa117\",\r\n                    \"path\": \"<Gamepad>/rightStick\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ScrollViewRightStickControl\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"391dbd04-6eaa-4600-9597-85e58e80dd6d\",\r\n                    \"path\": \"<Mouse>/middleButton\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SwitchInteract\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"692364fb-62ac-49f1-ae47-07892cb14e59\",\r\n                    \"path\": \"<Keyboard>/b\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Bag\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"139787d1-a531-4733-af03-1d231cd5bd73\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Bag\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b934d071-91bf-494a-88c3-d92ca0ffb4b2\",\r\n                    \"path\": \"<Keyboard>/c\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Character\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"649a7355-827c-436b-a5e7-72d3eb0d4c7a\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Character\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"daee5c04-5cc1-4490-b180-c3a58a39e0c4\",\r\n                    \"path\": \"<Keyboard>/f4\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Summary\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"edfae337-a749-451d-8789-219e5d565a3b\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Summary\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"c2252539-6c46-4fbc-a3fa-2d9d80af7604\",\r\n                    \"path\": \"<Keyboard>/f3\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"CardPool\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"8ee049f7-5a67-4c6a-9f77-318255c4bcb5\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"CardPool\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"90fcc9d8-09fb-4002-928f-b0619f82d55b\",\r\n                    \"path\": \"<Keyboard>/f1\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Activity\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"72ed5312-cb54-4cbc-a1b4-27203a1f574a\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Activity\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"28531676-0a48-45e3-87d8-43dc26985965\",\r\n                    \"path\": \"<Keyboard>/t\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Task\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"10e6ddbc-f9f4-4503-b5b2-28dc7e4e06af\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Task\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"437d1b62-d669-455c-a398-ffcfb402c163\",\r\n                    \"path\": \"<Keyboard>/p\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Team\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ce5273b0-0c2d-4d59-864b-90b98d4728c2\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Team\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"631ba122-9015-41b6-b199-c824a5e3292e\",\r\n                    \"path\": \"<Keyboard>/f2\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"BattlePass\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"39edb7f3-9d74-480d-9192-30c77c269674\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"BattlePass\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7297bc5e-fe54-4fda-98c9-f258cece7f74\",\r\n                    \"path\": \"<Keyboard>/v\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MissionTarget\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"032e3a99-5115-4f43-9f9e-2cbee04ec02d\",\r\n                    \"path\": \"<Gamepad>/rightStickPress\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MissionTarget\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"bf081dee-dcab-40fa-87f7-5a6529b1e901\",\r\n                    \"path\": \"<Keyboard>/m\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Map\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"89e73988-9744-4be2-b73f-ba66e1c5d88f\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Map\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"6aea5bf2-c243-4a7b-afe9-919b3af4f9dd\",\r\n                    \"path\": \"<Gamepad>/select\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Map\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b64d642b-64bf-44fe-8666-8464fbba2ac8\",\r\n                    \"path\": \"<Keyboard>/escape\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Esc\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"4c7a94ce-c900-4efa-b046-01cfc8da9129\",\r\n                    \"path\": \"<Gamepad>/start\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Esc\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f8499ff8-aaf0-446c-b119-d4bf6245cac1\",\r\n                    \"path\": \"<Keyboard>/backquote\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"GM\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"3642fc76-4dae-4235-9a18-ae40721449fe\",\r\n                    \"path\": \"<Touchscreen>/touch3/press\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"GM\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"274ca30d-86e6-4794-9538-ddfc2ce1bcda\",\r\n                    \"path\": \"<Keyboard>/home\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"GMConsole\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"339d60f6-793d-4b29-b84d-d43f2f704194\",\r\n                    \"path\": \"<Touchscreen>/touch2/press\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"GMConsole\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"30533125-1cfa-45a4-bfe0-6ee82a26bede\",\r\n                    \"path\": \"<Keyboard>/f\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Interact\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"09fc4ceb-0f70-4806-8933-3303af5ba21e\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Interact\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"a2aacd8a-4164-4277-b7fd-68ac8f239310\",\r\n                    \"path\": \"<Gamepad>/rightShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Interact\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d6ac35e6-36b4-4f86-a321-9ff89266eedc\",\r\n                    \"path\": \"<Keyboard>/leftAlt\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShowCursor\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d59ce303-1d90-45a6-be68-3dca31efd3a3\",\r\n                    \"path\": \"<Gamepad>/rightStick/x\",\r\n                    \"interactions\": \"Press\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SwitchInteractGamePadX\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"47207913-b232-4993-b773-7b7dcce66e5b\",\r\n                    \"path\": \"<Gamepad>/rightStick/y\",\r\n                    \"interactions\": \"Press\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SwitchInteractGamePadY\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"132d53a0-d2b7-40c5-989c-ee4a3d35f7c5\",\r\n                    \"path\": \"<Gamepad>/rightStick\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"StickDeadzone\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ZoomFovGamePadY\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ad585ae8-e356-4924-a0d8-cf616f701f89\",\r\n                    \"path\": \"<Keyboard>/pageUp\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ZoomFovPageUp\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"30d6966a-dac2-4587-9502-a783e0a2a118\",\r\n                    \"path\": \"<Keyboard>/pageDown\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ZoomFovPageDown\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d8b64430-3953-4d35-a2f7-2a22fd3f35eb\",\r\n                    \"path\": \"<Gamepad>/select\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"CommonSelect\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7e62047a-74f4-4399-bba1-934af3b775ad\",\r\n                    \"path\": \"<Gamepad>/leftShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LeftSwitchRole\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"2e574fa2-d78d-475c-b6e2-ec2d57749f6c\",\r\n                    \"path\": \"<Gamepad>/rightShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"RightSwitchRole\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"cc53efe5-e4f6-4f47-85b9-d3511ab88197\",\r\n                    \"path\": \"<Gamepad>/leftStickPress\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SelectNameInput\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"df6022bf-95c1-45e0-9d9f-7a6433d0c31e\",\r\n                    \"path\": \"<Gamepad>/buttonSouth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Confirm\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"60c910c2-3e1a-47e4-8801-a694f51b685a\",\r\n                    \"path\": \"<Keyboard>/enter\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Confirm\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"1d705deb-ae58-4cf0-ab05-e6adf8b312b2\",\r\n                    \"path\": \"<Gamepad>/rightStickPress\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"RightStickPress\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"17522433-da7f-40b3-9bf5-d25596755701\",\r\n                    \"path\": \"<Keyboard>/f5\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SNSOpenMission\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ca30ea75-34a9-4bba-b7fa-df9933fe21af\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SNSOpenMission\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"4091c617-4910-443e-a9b5-3223311db95e\",\r\n                    \"path\": \"<Keyboard>/equals\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"GuideToturial\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"855a54a4-e1a7-49fe-8564-31418ba58d7b\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"GuideToturial\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"One Modifier\",\r\n                    \"id\": \"62ed9c64-0c62-41cd-b2e1-e9c251ccecc0\",\r\n                    \"path\": \"OneModifier\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"GuideToturial\",\r\n                    \"isComposite\": true,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"modifier\",\r\n                    \"id\": \"26d4bcb3-e533-455b-bbba-3df7faafb779\",\r\n                    \"path\": \"<Gamepad>/leftShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"GuideToturial\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"binding\",\r\n                    \"id\": \"405c45de-ec43-49d6-b90f-e1a93eb05f99\",\r\n                    \"path\": \"<Gamepad>/rightShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"GuideToturial\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ac4554aa-1cdd-4300-b3f1-124272403b75\",\r\n                    \"path\": \"<Keyboard>/minus\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SpecialProppickTrigger\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"990be760-5508-41b6-95e1-b759d74b47dc\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SpecialProppickTrigger\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"One Modifier\",\r\n                    \"id\": \"c2e7ef87-32c7-4a56-98cf-2e3bdb149cfb\",\r\n                    \"path\": \"OneModifier\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SpecialProppickTrigger\",\r\n                    \"isComposite\": true,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"modifier\",\r\n                    \"id\": \"b26cc425-1b99-407f-b8a7-fd6a50c12d8c\",\r\n                    \"path\": \"<Gamepad>/leftShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SpecialProppickTrigger\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"binding\",\r\n                    \"id\": \"282deb76-d2c9-4b3e-87d4-fdecb3e8d701\",\r\n                    \"path\": \"<Gamepad>/leftTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SpecialProppickTrigger\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"927e1deb-3057-4770-a39b-a7a62507afd7\",\r\n                    \"path\": \"<Gamepad>/rightStick\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"RightStickNavigate\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"db8f98a4-95c2-4c6f-9555-1e6daa33747b\",\r\n                    \"path\": \"<Gamepad>/leftStickPress\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LeftStackPress\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"914222dc-d829-44a3-8b1a-8cf5cfdc3de1\",\r\n                    \"path\": \"<Gamepad>/leftTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LeftTrigger\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"65711e76-3836-4af1-8d61-1633841f6efb\",\r\n                    \"path\": \"<Gamepad>/select\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"View\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"a37c44fe-860b-4f3e-8ec4-e2384690fe5d\",\r\n                    \"path\": \"<Gamepad>/start\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Start\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ec480d07-554d-41f3-a357-91a798ab87ea\",\r\n                    \"path\": \"<Gamepad>/start\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"TriggerSearchInPutField\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"14847033-eb29-4df2-9bd5-7c5a11034924\",\r\n                    \"path\": \"<Gamepad>/buttonNorth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SearchSubmit\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"0f2f2c3a-4244-407e-8a79-5811173efde3\",\r\n                    \"path\": \"<Keyboard>/k\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SearchSubmit\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"27dc81fb-203d-4329-acaf-9992439f34f7\",\r\n                    \"path\": \"<Gamepad>/leftTrigger\",\r\n                    \"interactions\": \"Press(behavior=2)\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SwitchPageLeft\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"5074ab8c-a3ba-4220-9da4-99e821d36b8a\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SwitchPageLeft\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"def93430-bc02-46af-a30f-7d64131b0021\",\r\n                    \"path\": \"<Keyboard>/u\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SwitchPageLeft\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"24b8c95d-44cc-47cf-ab70-63bc6f2ae2e8\",\r\n                    \"path\": \"<Gamepad>/rightTrigger\",\r\n                    \"interactions\": \"Press(behavior=2)\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SwitchPageRight\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"9b470eef-b40c-49c7-adf4-3c5e98add577\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SwitchPageRight\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7f37b3e5-6d0c-4aab-b6f6-6bd12bab8d3e\",\r\n                    \"path\": \"<Keyboard>/o\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SwitchPageRight\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"a5ddf319-25ad-4c54-83ac-d1718c784c51\",\r\n                    \"path\": \"<Gamepad>/leftShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SwitchPageUp\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"c1411c70-5799-4dad-99a2-b59988606b1f\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SwitchPageUp\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"3d3e47a5-fb50-4dcc-b792-6f8450514924\",\r\n                    \"path\": \"<Keyboard>/q\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SwitchPageUp\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"e2c59519-4862-4f92-93b4-2fb1f3953a3f\",\r\n                    \"path\": \"<Gamepad>/rightShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SwitchPageDown\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7de5d13c-32f0-4f80-b5a5-a51a041199bf\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SwitchPageDown\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"2930c4d4-6f5f-4017-801a-63ba1587c042\",\r\n                    \"path\": \"<Keyboard>/e\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SwitchPageDown\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"bff6256d-2ec9-48b3-92d7-2e90a93eec10\",\r\n                    \"path\": \"<Gamepad>/buttonWest\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial2\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"81769181-f431-48bb-aba4-47dc64c94676\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial2\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"638ded51-e6f8-4b98-8b56-80cbd16defbd\",\r\n                    \"path\": \"<Keyboard>/j\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial2\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7aa456f1-472d-41e1-8a5e-a140dda8ca39\",\r\n                    \"path\": \"<Gamepad>/select\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial3\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b797da83-2326-430f-8788-1cab91763f95\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial3\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"468ba315-5519-4f38-bb7e-a0d7bae4f09d\",\r\n                    \"path\": \"<Keyboard>/f\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial3\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f6ae4db8-b386-4308-a4f3-c8460c802ae4\",\r\n                    \"path\": \"<Gamepad>/start\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial4\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"9ccaee27-d184-4bf2-8a53-f0adcab22237\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial4\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"1e4f40e9-23a7-4a18-91ac-ae7e1d83361a\",\r\n                    \"path\": \"<Keyboard>/h\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial4\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"71a8a1c9-3ce4-452f-bdf2-2d687b7559f1\",\r\n                    \"path\": \"<Gamepad>/buttonEast\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PressAnyKey\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f9b5a27c-d96d-4ada-86e8-525de05c04a0\",\r\n                    \"path\": \"<Gamepad>/buttonNorth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PressAnyKey\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"16174bb5-3ef2-463f-a133-4104644dcc63\",\r\n                    \"path\": \"<Gamepad>/buttonSouth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PressAnyKey\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"0da12df9-6af1-41b7-a844-ddad52c1aea6\",\r\n                    \"path\": \"<Gamepad>/buttonWest\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PressAnyKey\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b9878b4b-89c5-49d6-9eaa-569941d92a8e\",\r\n                    \"path\": \"<Gamepad>/dpad/down\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PressAnyKey\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"4b0beff5-0cdf-463c-aa0c-9936d4338b92\",\r\n                    \"path\": \"<Gamepad>/dpad/left\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PressAnyKey\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"4cf08adc-949b-4209-b5d0-4c3b2dd23006\",\r\n                    \"path\": \"<Gamepad>/dpad/right\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PressAnyKey\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"1c2b4d66-aca8-44a6-8a39-358c8fefc0aa\",\r\n                    \"path\": \"<Gamepad>/dpad/up\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PressAnyKey\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7bf0a9bb-8805-4ca0-a27f-028e03c22cb0\",\r\n                    \"path\": \"<Gamepad>/leftShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PressAnyKey\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"bd667ac7-adee-4163-ba75-389bbba23a1d\",\r\n                    \"path\": \"<Gamepad>/leftTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PressAnyKey\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"e0ac1843-b205-4fb8-a014-ba370be7ad73\",\r\n                    \"path\": \"<Gamepad>/rightShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PressAnyKey\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"073d2012-2ab7-4c80-aa35-f5870684fcc5\",\r\n                    \"path\": \"<Gamepad>/rightTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PressAnyKey\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"a00e7f74-937a-4ff2-b22d-a235c03513ce\",\r\n                    \"path\": \"<Gamepad>/select\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PressAnyKey\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"a3a77a94-5662-4f67-996e-8409e1af66c9\",\r\n                    \"path\": \"<Gamepad>/start\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PressAnyKey\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"3414d279-89c7-41ee-99cf-342cac967a82\",\r\n                    \"path\": \"<Keyboard>/anyKey\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PressAnyKey\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"433dbbde-1105-4f50-9b86-c3e7949d0661\",\r\n                    \"path\": \"<Keyboard>/w\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ButtonUp\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f7d7515f-23de-46ef-87ea-f0d5e7a18359\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ButtonUp\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"5302894e-0e53-4da3-bb95-e2ef3ab3b432\",\r\n                    \"path\": \"<Gamepad>/buttonNorth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ButtonUp\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"a819cf12-b1e3-4ca2-b479-431bf86bbeaf\",\r\n                    \"path\": \"<Keyboard>/s\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ButtonDown\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"5a0941c3-5326-473f-9c15-c5335217ab14\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ButtonDown\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b3c1f81b-3cb5-4463-8d67-c9bb4437effe\",\r\n                    \"path\": \"<Gamepad>/buttonSouth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ButtonDown\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"897277e6-99e5-4f7e-a239-5d5295c58757\",\r\n                    \"path\": \"<Keyboard>/a\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ButtonLeft\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"020436f1-086c-4099-b443-3fe590cdf3d3\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ButtonLeft\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"5a3d5039-0a54-4afb-bdd8-615e8ff67189\",\r\n                    \"path\": \"<Gamepad>/buttonWest\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ButtonLeft\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"5ca59544-555e-468f-8ab0-8c0465c116e7\",\r\n                    \"path\": \"<Keyboard>/d\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ButtonRight\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"2270eb63-302a-4415-ba58-5e7d32b7c904\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ButtonRight\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"dc74b53d-6222-420e-bc3d-4662ac8cdbf3\",\r\n                    \"path\": \"<Gamepad>/buttonEast\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ButtonRight\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ad868701-f30a-42e5-9a91-be98eadeef5f\",\r\n                    \"path\": \"<Keyboard>/w\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LSUp\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ea0dfe3c-e14e-42d9-a7b4-305f74bce5b5\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LSUp\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"9abcd8e1-4897-4312-a880-7fd0c0e9a692\",\r\n                    \"path\": \"<Gamepad>/leftStick/up\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LSUp\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"5f2fb70a-1a14-4676-a533-c81cadfc29a4\",\r\n                    \"path\": \"<Keyboard>/s\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LSDown\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ab934981-ac82-4e68-b11b-22b45edf66cc\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LSDown\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"4b147b49-b207-4a63-8c1c-5e0e450e048e\",\r\n                    \"path\": \"<Gamepad>/leftStick/down\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LSDown\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"0197cd63-12c4-46a5-b7fb-d9f93f1c07ae\",\r\n                    \"path\": \"<Keyboard>/a\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LSLeft\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"982a9eb7-78b1-4b3b-8a44-bb5336ff6826\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LSLeft\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b17ced39-f5cb-4bbc-aa1f-98900aecc88c\",\r\n                    \"path\": \"<Gamepad>/leftStick/left\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LSLeft\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"6a9702e6-6f1a-4f5a-9aa8-8372c251dd28\",\r\n                    \"path\": \"<Keyboard>/d\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LSRight\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"244e3368-c321-4cd2-a766-835ff7ce0c7f\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LSRight\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"4ac2962e-a010-4109-9adc-f4f69299938b\",\r\n                    \"path\": \"<Gamepad>/leftStick/right\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LSRight\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ef8b80d3-0eec-4f8b-9c15-3d84753492e5\",\r\n                    \"path\": \"<Keyboard>/backslash\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"TextLibrary\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"fba4a4f9-a954-45e4-a916-35a9ccc06c7a\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"TextLibrary\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"One Modifier\",\r\n                    \"id\": \"988d4eb9-a88c-4756-b186-b18fcffe3fa6\",\r\n                    \"path\": \"OneModifier\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"TextLibrary\",\r\n                    \"isComposite\": true,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"modifier\",\r\n                    \"id\": \"c67a69a5-66a6-4a6f-be63-271510d2d9c8\",\r\n                    \"path\": \"<Gamepad>/leftShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"TextLibrary\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"binding\",\r\n                    \"id\": \"d348a3ad-1d3d-4236-908c-ba2a2e879fbf\",\r\n                    \"path\": \"<Gamepad>/rightTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"TextLibrary\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"cbd69863-b8d4-4b25-aa4e-89d1d5770c88\",\r\n                    \"path\": \"<Gamepad>/leftStickPress\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial5\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"0f745355-e70d-4a73-981a-ed4a78267007\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial5\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"5ced48ff-e668-455e-9374-b10755708dac\",\r\n                    \"path\": \"<Keyboard>/z\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial5\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d91ffc8b-a0a4-4839-895a-27407a1e2a37\",\r\n                    \"path\": \"<Gamepad>/rightStickPress\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial6\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"e972307f-281e-492d-9afd-e391d7dde086\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial6\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"acd96d38-5faf-42fb-b64e-86428c54c633\",\r\n                    \"path\": \"<Keyboard>/x\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial6\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"8495f617-4091-4f30-988b-35c77679b4be\",\r\n                    \"path\": \"<Gamepad>/dpad/up\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial7\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"1c99baf8-c6d7-4f1e-ab58-1f9bd3bbd87c\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial7\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"aef3c7af-8d74-44d9-9797-ea680df2ac28\",\r\n                    \"path\": \"<Keyboard>/upArrow\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial7\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7857c05b-aea1-40d1-9155-306afcf34f48\",\r\n                    \"path\": \"<Gamepad>/dpad/down\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial8\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"03ab085d-76bf-4509-9edf-2c281609a5ea\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial8\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"c28fbd03-8761-4e3c-bbbb-39372593f935\",\r\n                    \"path\": \"<Keyboard>/downArrow\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial8\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"780bece8-adfb-43ab-b607-23fc1b6012ba\",\r\n                    \"path\": \"<Gamepad>/dpad/left\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial9\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"9dffd379-b90c-46ed-a2eb-e9257daf4cc9\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial9\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"bdc376be-da9c-4ef4-a3f5-87015c133a36\",\r\n                    \"path\": \"<Keyboard>/leftArrow\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial9\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"85662b2a-48f9-4ef1-bff8-61361ad6bce9\",\r\n                    \"path\": \"<Gamepad>/dpad/right\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial10\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"4de4cedf-da56-4ca2-8e37-d4b7d3a84517\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial10\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"e451f6fc-2c1f-4606-8502-17f8319c83e0\",\r\n                    \"path\": \"<Keyboard>/rightArrow\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial10\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b3838d91-df93-4e51-85fc-522b17711610\",\r\n                    \"path\": \"<Gamepad>/buttonNorth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial1\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"1a322147-c22b-4ddf-b772-d9b660678d72\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial1\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d1243b81-f576-4b8d-b6ce-e26efb2f5766\",\r\n                    \"path\": \"<Keyboard>/k\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"UISpecial1\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"53573e8d-f53a-4cd9-ac57-e75c39269ec6\",\r\n                    \"path\": \"<Gamepad>/buttonWest\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"LongPressX\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"108d89fc-7551-4f88-8a03-aed6e423a3a8\",\r\n                    \"path\": \"<Gamepad>/rightTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"RightTrigger\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f9440165-8b31-4505-b488-683f7485bfc5\",\r\n                    \"path\": \"<Keyboard>/z\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SelectItemCell\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d67ce356-3221-4437-944b-a9a67a1cdb42\",\r\n                    \"path\": \"<Gamepad>/leftStickPress\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SelectItemCell\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f13714af-3995-4b1e-849a-db4a84a989f6\",\r\n                    \"path\": \"<Gamepad>/leftTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Lock\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b66dec71-609d-4a70-aa4e-fdb32e063be9\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Lock\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"718acfa4-e0b4-44d8-ad6d-d55f7bdd21da\",\r\n                    \"path\": \"<Keyboard>/u\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Lock\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ae3bc7ac-adb9-4377-ac46-64dc7fd6b4f7\",\r\n                    \"path\": \"<Gamepad>/rightStickPress\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShowCoinDetail\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"bc57565b-f8a6-4858-8443-24dda0bdbba0\",\r\n                    \"path\": \"<Keyboard>/x\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShowCoinDetail\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"27cb2718-9de8-4ad7-ae01-38dcca2f3a6f\",\r\n                    \"path\": \"<Keyboard>/tab\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MenuDisc\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"faf426a5-6895-4101-9b73-6173793aa0ad\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MenuDisc\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"01447ef6-ee23-49be-b8ef-6375bda86a36\",\r\n                    \"path\": \"<Gamepad>/dpad/left\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MenuDisc\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"1d4bb0b1-6cee-464e-90eb-0b0001af3cba\",\r\n                    \"path\": \"<Keyboard>/y\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"StopChallenge\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"9eaf49bb-7940-43c3-8d1d-6486b9f5da9a\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"StopChallenge\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"71c5d5c3-bc4e-44cd-a2e3-c71950b86352\",\r\n                    \"path\": \"<Gamepad>/leftStickPress\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"StopChallenge\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"29f5de50-1600-422d-8c21-20fa98898722\",\r\n                    \"path\": \"<Keyboard>/#(])\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"WorldLevelBreakTips\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"One Modifier\",\r\n                    \"id\": \"b79aa0ec-6ec2-4549-ac82-ff47cc6fbe0e\",\r\n                    \"path\": \"OneModifier\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"WorldLevelBreakTips\",\r\n                    \"isComposite\": true,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"modifier\",\r\n                    \"id\": \"6fd8fdcb-8c38-436c-ae53-7c75d01b71bc\",\r\n                    \"path\": \"<Gamepad>/leftShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"WorldLevelBreakTips\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"binding\",\r\n                    \"id\": \"f5a3567e-71ae-4ad7-97d6-656a555dde11\",\r\n                    \"path\": \"<Gamepad>/dpad/up\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"WorldLevelBreakTips\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                }\r\n            ]\r\n        },\r\n        {\r\n            \"name\": \"LargeMapView\",\r\n            \"id\": \"56fb029a-84c7-4163-876d-269291f728b0\",\r\n            \"actions\": [\r\n                {\r\n                    \"name\": \"mapScaleReduce\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"9faac836-8f65-4433-a053-63a3091a4815\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"mapScaleReduceFloat\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"eb18f311-c8de-47ea-8790-7acaaa83c05e\",\r\n                    \"expectedControlType\": \"Axis\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"mapScaleAdd\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"da44bdaa-a30e-4344-9ad5-813367e4fc26\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"mapScaleAddFloat\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"fae17d6d-3ef2-4d8d-90ba-884e77320cf7\",\r\n                    \"expectedControlType\": \"Axis\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Select\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"e60eb0db-e3bc-4cbc-aa20-56120e9a1656\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"MapItem\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"a0ce8c7f-6708-4b4a-a293-1fe5337f7554\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Return\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"59492d64-1593-45e4-8543-f377507da6db\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"MapCollection\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"87432d81-d1ab-48aa-aab5-a949e8d270be\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"WorldMap\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"e07790b4-8ded-4cef-abab-780f723f5850\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"MapTemple\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"873d4eab-d2a8-47f0-9cca-b275937918c9\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Delete\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"3851e576-abac-4ab1-9f9b-18f2715a4ac9\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"MoveMap\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"9569edd5-8462-488c-bf0e-10cd9a5e8d7a\",\r\n                    \"expectedControlType\": \"Vector2\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"MoveCursor\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"ce5e3216-e928-485d-9899-f0fbc911cb68\",\r\n                    \"expectedControlType\": \"Vector2\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"BackToPlayer\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"57302cf6-ae90-4dc6-9906-24c69100bc49\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"WorldMapChooseLast\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"c236a3bd-4970-469b-b39e-7a8fe9b4904d\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"WorldMapChooseNext\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"a00bd66e-eed6-4a53-b7ad-518d3010b3ce\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"MapSideInfoLast\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"0dcaad4b-d8d6-447a-8d1f-cc8e93c53bbe\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"MapSideInfoNext\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"fe0652e5-03d4-4819-961d-7ddf16d5d9b8\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ChangeToSelectItem\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"e4cdfc28-9aa2-4eaa-8236-384ba67a05e0\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"BackToTarget\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"9ba2b0fa-5fc6-4d56-b5b9-62475d69e873\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Up\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"8dcc4a0b-ec9a-4e14-9954-fcb74d8f4357\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Down\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"cd8a482f-6774-42ef-aedc-77ace798bf97\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Left\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"03b5498c-0d6c-4be5-825b-d02a3f3c4433\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                },\r\n                {\r\n                    \"name\": \"Right\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"e3eceaf4-477e-4003-9335-67dfda869c1c\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                }\r\n            ],\r\n            \"bindings\": [\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f9e9bd4f-55c4-4cd3-8b17-e281ffc8edd7\",\r\n                    \"path\": \"<Gamepad>/leftTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"mapScaleReduce\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"2e163af1-533d-4c01-84c3-61793710b517\",\r\n                    \"path\": \"<Gamepad>/leftTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"mapScaleReduceFloat\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f8e8f3d6-6c97-4629-8e99-0ee34c9b362d\",\r\n                    \"path\": \"<Gamepad>/rightTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"mapScaleAdd\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"346ccfa8-a082-4279-b6b9-b0bdd3f327ed\",\r\n                    \"path\": \"<Gamepad>/rightTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"mapScaleAddFloat\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b0931e3e-d503-46de-9199-1052c98883d0\",\r\n                    \"path\": \"<Gamepad>/buttonSouth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Select\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f8b30240-4e53-446b-be30-2516c7c2095a\",\r\n                    \"path\": \"<Gamepad>/buttonNorth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MapItem\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"41e5de40-51cb-48e7-97cd-3f147861300e\",\r\n                    \"path\": \"<Gamepad>/buttonEast\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Return\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"10016e14-e792-495d-955d-ca1869d808f3\",\r\n                    \"path\": \"<Gamepad>/rightShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MapCollection\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"e828cbcd-1475-4ead-a5c6-043bb108b481\",\r\n                    \"path\": \"<Gamepad>/leftShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"WorldMap\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"83eb1437-2ccb-4a2f-aac8-e1ac1ea05bd3\",\r\n                    \"path\": \"<Gamepad>/buttonWest\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MapTemple\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"41bb54fd-b89d-4c7e-82bd-c02c1332c376\",\r\n                    \"path\": \"<Gamepad>/buttonWest\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Delete\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b10cdadb-ffd9-4aea-8d9b-e94cedb11e7f\",\r\n                    \"path\": \"<Gamepad>/leftStick\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MoveMap\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"2D Vector\",\r\n                    \"id\": \"3930c46b-d1e3-4e4f-b8da-5b0e8d7a2e42\",\r\n                    \"path\": \"2DVector\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MoveMap\",\r\n                    \"isComposite\": true,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"up\",\r\n                    \"id\": \"2e551019-defa-44cd-afc2-75e53e77fb6a\",\r\n                    \"path\": \"<Keyboard>/w\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MoveMap\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"down\",\r\n                    \"id\": \"1352977c-e316-43d1-9316-36392457f06b\",\r\n                    \"path\": \"<Keyboard>/s\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MoveMap\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"left\",\r\n                    \"id\": \"907ccf72-cf5e-4550-a788-4ae0b75aa9c6\",\r\n                    \"path\": \"<Keyboard>/a\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MoveMap\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"right\",\r\n                    \"id\": \"13c1a075-972d-400c-8788-01e634aa6094\",\r\n                    \"path\": \"<Keyboard>/d\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MoveMap\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"29a147b4-4df9-4436-8eeb-6825dced12c2\",\r\n                    \"path\": \"<Gamepad>/rightStick\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MoveCursor\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"261d9a49-f971-4475-a296-7d557118bd26\",\r\n                    \"path\": \"<Gamepad>/rightStickPress\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"BackToPlayer\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b59e45dc-4528-4c67-b509-604914eeb380\",\r\n                    \"path\": \"<Gamepad>/dpad/up\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"WorldMapChooseLast\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b9407bd3-7958-40c8-855d-6df152390f56\",\r\n                    \"path\": \"<Gamepad>/dpad/down\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"WorldMapChooseNext\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"2d30913a-5005-4dc7-9746-3d0ac45e3256\",\r\n                    \"path\": \"<Gamepad>/dpad/left\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MapSideInfoLast\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"6e711937-88d2-478c-9cce-4c0ede4fecd0\",\r\n                    \"path\": \"<Gamepad>/dpad/right\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"MapSideInfoNext\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7ca37062-a53b-4dba-94b3-a264b5cee8fe\",\r\n                    \"path\": \"<Gamepad>/leftStickPress\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ChangeToSelectItem\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"5cc0a75d-fbe5-4330-9a21-8f8e488dd4f5\",\r\n                    \"path\": \"<Gamepad>/rightShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"BackToTarget\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"c07f981a-a70c-47f8-ad9e-48d2682673ca\",\r\n                    \"path\": \"<Gamepad>/leftStick/up\",\r\n                    \"interactions\": \"Press\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Up\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"34f40a14-299d-4628-9382-8cd38500f65c\",\r\n                    \"path\": \"<Gamepad>/leftStick/down\",\r\n                    \"interactions\": \"Press\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Down\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"81e1551a-c687-41ca-97b8-a471f06a60a7\",\r\n                    \"path\": \"<Gamepad>/leftStick/left\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Left\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"63f3ec51-deca-4a4a-af30-63ff23dc7102\",\r\n                    \"path\": \"<Gamepad>/dpad/left\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Left\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"c6770c79-62fd-4263-9c14-b026549889a6\",\r\n                    \"path\": \"<Gamepad>/leftStick/right\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Right\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"74fda294-1702-4d90-a297-97ef8a65598d\",\r\n                    \"path\": \"<Gamepad>/dpad/right\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Right\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                }\r\n            ]\r\n        },\r\n        {\r\n            \"name\": \"Conversation\",\r\n            \"id\": \"65df15b0-3ca1-4fb4-906c-bc97d48b7bb7\",\r\n            \"actions\": [\r\n                {\r\n                    \"name\": \"ConversationNext\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"64f31d6f-0374-4956-a484-93dd53da866f\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ConversationAutoPlay\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"78f4a784-27d7-45f0-8b90-cdbcdb4478a8\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ConversationReview\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"2d0e84f4-eaf6-494c-9e7c-d7b062d31638\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ConversationHide\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"2878d84f-59a6-4402-bba3-3cbfefa79b71\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ConversationReviewClose\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"58ca73a7-53a5-437b-adf3-1b6bce9e61af\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ConversationReviewScroll\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"345f8a1d-2cc0-4b44-acf6-4908120fc255\",\r\n                    \"expectedControlType\": \"Vector2\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ConversationLastChoice\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"2782c03d-76e9-4eff-a3b7-15b466ec0469\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ConversationLastChoice1\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"b9e5bfb0-9f14-4dfe-a373-9da3cb798a3b\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ConversationNextChoice\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"2536cbaa-b8a4-4a6a-b5e3-dac8b4e4d8ef\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ConversationNextChoice1\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"51c18e5e-9305-4f65-b213-f8aed7d8451a\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ConversationSkip\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"57181520-f0f9-4802-a9f7-1b4da4c479a8\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ConversationChoose\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"b8865126-e08e-4ad9-bdd4-c0596d3d1e2e\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                }\r\n            ],\r\n            \"bindings\": [\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"84ceb073-fee3-4cb2-b39e-e0fe07d366d7\",\r\n                    \"path\": \"<Keyboard>/space\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationNext\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"862e9c8d-7e53-4f39-83a9-bb519354f3ff\",\r\n                    \"path\": \"<Gamepad>/buttonSouth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationNext\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"4649cb8e-1f84-42a7-abdd-db7f3ee0b4a8\",\r\n                    \"path\": \"<Keyboard>/e\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationAutoPlay\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"aac95849-fed3-49ba-8d5b-9df1654b35a9\",\r\n                    \"path\": \"<Gamepad>/rightShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationAutoPlay\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"341e3518-00cb-4c4b-860d-339b1640693b\",\r\n                    \"path\": \"<Keyboard>/r\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationReview\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f039e184-158e-4499-b794-3de94815f1f6\",\r\n                    \"path\": \"<Gamepad>/buttonNorth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationReview\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"a0979fe6-2f8f-432b-a541-16b4f4593ac3\",\r\n                    \"path\": \"<Keyboard>/q\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationHide\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"0ab7d435-bba3-468b-94af-81811465cebb\",\r\n                    \"path\": \"<Gamepad>/buttonWest\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationHide\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"bfa87d5e-b98d-4b7c-99a9-dc6a718edb70\",\r\n                    \"path\": \"<Keyboard>/escape\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationReviewClose\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"cc26d4ac-0106-4b8f-8fc9-3fd1860fed35\",\r\n                    \"path\": \"<Gamepad>/buttonEast\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationReviewClose\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7bfb6603-3cd1-4e18-9523-8c4a61b9acc4\",\r\n                    \"path\": \"<Gamepad>/rightStick\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"StickDeadzone\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationReviewScroll\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"e4cd920e-aa53-4903-a722-4ead592381b8\",\r\n                    \"path\": \"<Keyboard>/w\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationLastChoice\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"21888fc4-055e-4fff-8a50-935d52a9de7a\",\r\n                    \"path\": \"<Keyboard>/upArrow\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationLastChoice\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f8c91ece-3407-4db9-86ab-df29dbabfda0\",\r\n                    \"path\": \"<Gamepad>/dpad/up\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationLastChoice\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d82f6e46-9817-4539-ae79-1d245a5b5d75\",\r\n                    \"path\": \"<Keyboard>/s\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationNextChoice\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ba77688c-94fc-420f-ad6e-06f6385b8146\",\r\n                    \"path\": \"<Keyboard>/downArrow\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationNextChoice\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b4bd8fdb-d29a-42ac-83ce-b4ac5b119549\",\r\n                    \"path\": \"<Gamepad>/dpad/down\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationNextChoice\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"62662894-ae69-4a88-99d0-b5289f85e143\",\r\n                    \"path\": \"<Gamepad>/start\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationSkip\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"fc8feb62-cec8-4985-a051-24606b8eaf1c\",\r\n                    \"path\": \"<Gamepad>/leftStick/down\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationNextChoice1\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"50e6f295-18fc-497a-9391-bb252e7cf112\",\r\n                    \"path\": \"<Gamepad>/leftStick/up\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationLastChoice1\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"14673da8-59e1-4ca2-bbd1-7371bd7a4ff1\",\r\n                    \"path\": \"<Keyboard>/f\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationChoose\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"438a9edb-1e9d-4c14-b72b-e310a304765d\",\r\n                    \"path\": \"<Gamepad>/buttonSouth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ConversationChoose\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                }\r\n            ]\r\n        },\r\n        {\r\n            \"name\": \"StateObject\",\r\n            \"id\": \"8a89cf02-5ab9-4786-b0cc-5b7ff9212fb2\",\r\n            \"actions\": [\r\n                {\r\n                    \"name\": \"StateObjectMove\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"34d741f2-44d8-489e-b319-e6dfb69f23dc\",\r\n                    \"expectedControlType\": \"Vector2\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": true\r\n                }\r\n            ],\r\n            \"bindings\": [\r\n                {\r\n                    \"name\": \"UpDownLeftRight\",\r\n                    \"id\": \"059ab631-d5a1-4f94-926e-607f22adca57\",\r\n                    \"path\": \"2DVector\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"StateObjectMove\",\r\n                    \"isComposite\": true,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"up\",\r\n                    \"id\": \"5b511d25-f14e-4ed8-90d9-babf90270ec0\",\r\n                    \"path\": \"<Keyboard>/upArrow\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"StateObjectMove\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"down\",\r\n                    \"id\": \"00c4ff81-ad0d-4f82-9ef1-5037efd6d4cd\",\r\n                    \"path\": \"<Keyboard>/downArrow\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"StateObjectMove\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"left\",\r\n                    \"id\": \"5e5b7f11-d301-434e-a990-c950c7e19e29\",\r\n                    \"path\": \"<Keyboard>/leftArrow\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"StateObjectMove\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"right\",\r\n                    \"id\": \"d73ebe0e-2887-4f26-89c0-cac5d2a7ebbf\",\r\n                    \"path\": \"<Keyboard>/rightArrow\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"StateObjectMove\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"WSAD\",\r\n                    \"id\": \"f8a4ad33-1120-44d8-bf90-c1db4ff9f8fe\",\r\n                    \"path\": \"2DVector\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"StateObjectMove\",\r\n                    \"isComposite\": true,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"up\",\r\n                    \"id\": \"8e484971-ba34-4185-b318-1c644bee330c\",\r\n                    \"path\": \"<Keyboard>/w\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"StateObjectMove\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"down\",\r\n                    \"id\": \"a3d8cabe-b81d-4384-a6c2-68c985d4bebd\",\r\n                    \"path\": \"<Keyboard>/s\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"StateObjectMove\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"left\",\r\n                    \"id\": \"a67a4cbd-231e-4f0e-802a-af51f3333179\",\r\n                    \"path\": \"<Keyboard>/a\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"StateObjectMove\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"right\",\r\n                    \"id\": \"aaa21453-5df3-4ac8-801f-5617bd183a82\",\r\n                    \"path\": \"<Keyboard>/d\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"StateObjectMove\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": true\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"868c6aef-c787-41d4-ac74-2bba889794f7\",\r\n                    \"path\": \"<Gamepad>/leftStick\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"StickDeadzone(min=1.401298E-45,max=1.401298E-45)\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"StateObjectMove\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"bb822122-ec31-4587-9750-25c99961b796\",\r\n                    \"path\": \"<OnScreenControlDevice>/leftStick\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"StateObjectMove\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                }\r\n            ]\r\n        },\r\n        {\r\n            \"name\": \"Settings\",\r\n            \"id\": \"4954e78a-b759-4632-a36d-6d7c691b7776\",\r\n            \"actions\": [\r\n                {\r\n                    \"name\": \"SettingsConfirm\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"482ddcd1-35ad-424a-a315-f7cc68424b1a\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsPreTab\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"5f9133c0-065e-4ccf-9101-63b17b536b3d\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsNextTab\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"b87e3f04-2f1c-4462-bcf9-3e5f2db6421a\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsSwitchDetail\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"c00b583b-7043-4727-973e-d9e84377b9b8\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsSliderLeft\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"41e08589-1b1d-4f61-9eee-6665a4aada3f\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsSliderRight\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"a07561aa-a4d0-4bdd-958b-68676c34cc71\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsSliderShift\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"752850e4-336a-49ae-ad82-eb8cf0af3f61\",\r\n                    \"expectedControlType\": \"Vector2\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsSliderLeftShift\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"97aa4c5c-e0b5-4636-ac59-23e6c224071a\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsSliderRightShift\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"441be82c-a0c3-46ed-a093-ff917764764e\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsSelectionUp\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"d9622a5b-fc97-4d64-9f7e-3c7264628d8b\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsSelectionUp1\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"bc99028a-b8fe-4820-8c91-a15c59e751e8\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsSelectionDown\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"cb61931b-9400-4637-96ca-ce65eb7c182f\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsSelectionDown1\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"9d20db34-728b-4476-b998-e45a9674f442\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsSelectionLeft\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"1b760965-9e02-44e3-9382-7cd0b174ef61\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsSelectionLeft1\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"079224bb-6b45-41a5-8be6-16e794f801f9\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsSelectionRight\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"ced6634a-6fe4-4985-83c4-9ca62886caa0\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"AxisDeadzone\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsSelectionRight1\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"17479018-0357-4402-a9df-64024fc696c4\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"AxisDeadzone\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsBackHUD\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"8ac854cc-4b23-4a41-b4d1-adfa43a469c8\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"PreTab1\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"fff07977-ebaf-4a67-b01f-0e91eb7a6f82\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"NextTab1\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"0f3a2932-4496-4521-affb-b93f01989c0e\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SettingsResetToDefault\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"56c766e9-5f62-4898-b06d-2421bfb98e37\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                }\r\n            ],\r\n            \"bindings\": [\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"da851f91-0c2a-49fb-a0c6-0e2c13b3517e\",\r\n                    \"path\": \"<Gamepad>/buttonSouth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsConfirm\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"3d5583b1-0c26-4f68-a167-d44512cfdfd9\",\r\n                    \"path\": \"<Gamepad>/leftTrigger\",\r\n                    \"interactions\": \"Press\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PreTab1\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"9ec50565-9755-42aa-a699-0b365b8f0519\",\r\n                    \"path\": \"<Gamepad>/rightShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsNextTab\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"436c872c-8d62-4015-9655-67a039c20a67\",\r\n                    \"path\": \"<Gamepad>/leftShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsPreTab\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"9ed59b2c-9a67-43bc-be65-97ee9fc56bba\",\r\n                    \"path\": \"<Gamepad>/buttonNorth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsSwitchDetail\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"904ab225-b94b-49e3-9e89-0404c9d74331\",\r\n                    \"path\": \"<Keyboard>/escape\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsBackHUD\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"3b843f2a-a49d-455f-979e-798001a9194b\",\r\n                    \"path\": \"<Gamepad>/buttonEast\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsBackHUD\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"22fa2eee-916f-4288-8255-e86979cb77c9\",\r\n                    \"path\": \"<Gamepad>/dpad/down\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsSelectionDown\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"00612b60-3de4-4b3b-b7bc-fe28e257eeb7\",\r\n                    \"path\": \"<Gamepad>/dpad/up\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsSelectionUp\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"831395b4-8439-41a9-b111-4873fffa7a25\",\r\n                    \"path\": \"<Gamepad>/dpad/left\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsSelectionLeft\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"cdf58535-34fc-42bc-ae8c-daa3f17bc0bc\",\r\n                    \"path\": \"<Gamepad>/dpad/right\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsSelectionRight\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"c3879d48-efda-4fbe-a7bf-3d97229d797e\",\r\n                    \"path\": \"<Gamepad>/dpad/right\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsSliderRight\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"5b06ee2e-fbef-465d-aa3e-f81dc8b7db67\",\r\n                    \"path\": \"<Gamepad>/dpad/left\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsSliderLeft\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"225e39f3-33d7-4dfa-bd4f-21bdc51d96f4\",\r\n                    \"path\": \"<Gamepad>/rightStick\",\r\n                    \"interactions\": \"Press\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsSliderShift\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d6967600-1d62-4678-a363-19da7d3d7fa2\",\r\n                    \"path\": \"<Gamepad>/leftStick/up\",\r\n                    \"interactions\": \"Press\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsSelectionUp1\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"370627ee-acc7-41e0-81d5-de45be91bf69\",\r\n                    \"path\": \"<Gamepad>/leftStick/down\",\r\n                    \"interactions\": \"Press\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsSelectionDown1\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b104636e-96c3-4bb0-99be-f6a4cf60a1e1\",\r\n                    \"path\": \"<Gamepad>/leftStick/left\",\r\n                    \"interactions\": \"Press\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsSelectionLeft1\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d3256553-d5fd-41ee-8e9e-8f3e12e8a024\",\r\n                    \"path\": \"<Gamepad>/leftStick/right\",\r\n                    \"interactions\": \"Press\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsSelectionRight1\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"4a116f86-eb20-4759-9770-1e57b877d420\",\r\n                    \"path\": \"<Gamepad>/rightStick/left\",\r\n                    \"interactions\": \"Press(behavior=2)\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsSliderLeftShift\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"bf1a787d-7a82-4f06-a53e-9b5dfc31c63c\",\r\n                    \"path\": \"<Gamepad>/rightStick/right\",\r\n                    \"interactions\": \"Press(behavior=2)\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsSliderRightShift\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"6bb4ff1a-e491-49b3-a9a1-d6386d515c84\",\r\n                    \"path\": \"<Gamepad>/rightTrigger\",\r\n                    \"interactions\": \"Press\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"NextTab1\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"3b3c89f1-c335-49c1-9564-9165934a0758\",\r\n                    \"path\": \"<Gamepad>/buttonNorth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SettingsResetToDefault\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                }\r\n            ]\r\n        },\r\n        {\r\n            \"name\": \"Guide\",\r\n            \"id\": \"505f022a-0dde-4364-bf2a-97a083b254a9\",\r\n            \"actions\": [\r\n                {\r\n                    \"name\": \"ClickFinshGuideStep\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"adb28912-ed6d-41ce-a399-ff01ec2e6f17\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ClickSkipGuide\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"1c08560e-0f7b-4ac8-95f1-8de343940408\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                }\r\n            ],\r\n            \"bindings\": [\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f14b7d97-2e49-4348-b3f7-cf3bc042d0ab\",\r\n                    \"path\": \"<Keyboard>/enter\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ClickFinshGuideStep\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7f63f84e-1ccc-464a-b626-0196fd9b8a44\",\r\n                    \"path\": \"<Gamepad>/buttonSouth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ClickFinshGuideStep\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"afde16f0-3da4-4243-862b-67afd04d7b88\",\r\n                    \"path\": \"<Keyboard>/escape\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ClickSkipGuide\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"1fea8449-53e1-4f2c-96f3-2d512b047bb1\",\r\n                    \"path\": \"<Gamepad>/start\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ClickSkipGuide\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                }\r\n            ]\r\n        },\r\n        {\r\n            \"name\": \"TextLibrary\",\r\n            \"id\": \"e82e00bf-db06-48f0-a747-e2d8c9111309\",\r\n            \"actions\": [\r\n                {\r\n                    \"name\": \"TextLibraryUITipGamePadModifier\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"00332238-d8af-41f0-b344-8a173ee941a8\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"TextLibraryUITipGamePadBinding\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"42aafedb-6ebb-4ca9-9360-8e658ae88961\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                }\r\n            ],\r\n            \"bindings\": [\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"373780d5-2b4b-4c7b-9ddc-c49809829c98\",\r\n                    \"path\": \"<Gamepad>/leftShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"TextLibraryUITipGamePadModifier\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"22ea43ed-0a4b-41ef-bae0-ee3c100992e8\",\r\n                    \"path\": \"<Gamepad>/rightTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"TextLibraryUITipGamePadBinding\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                }\r\n            ]\r\n        },\r\n        {\r\n            \"name\": \"CharacterView\",\r\n            \"id\": \"59ac98f8-8e37-47ee-9194-09f0758f7053\",\r\n            \"actions\": [\r\n                {\r\n                    \"name\": \"NextCharacter\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"cb4c3414-0941-4c03-8d2d-62789cb55bcc\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"PrevCharacter\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"b717249b-0adf-461b-b306-8eada81bdc7b\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"NextTab\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"3cd68a00-e108-4266-b04b-73ab4696858a\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"PrevTab\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"1bde8a7b-3aea-43b4-8e25-9a62aa2eb9ae\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"OpenCharacterList\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"edd7ed23-f3dc-4796-a1d6-eb65c38cd42e\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"OpenModelView\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"771b90ec-c784-47e5-a237-0369f9a45443\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Upgrade\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"ccb8d7e7-b436-4348-a9a2-d84a943e3416\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Destiny\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"de29a7d9-1159-4425-854d-93038fcef43b\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SelectMaxLevel\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"f108d3cb-36f7-4fb2-a6df-4f639d62b82b\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ShowCostCoinDetail\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"08497f41-10da-49a3-8565-44a2751393a3\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ToggleSkillDescriptionMode\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"ffa74061-a5c9-49be-80f6-9bdfd5c85c54\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ShowMaterialCost\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"62f3a274-130a-4dfe-a1fe-708f602a63a7\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"ShowUpdatePreview\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"e336e3cd-db80-471c-8eeb-ea4c2b7d9d53\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                }\r\n            ],\r\n            \"bindings\": [\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7d736d0a-d515-4f44-83bc-66aad55ea178\",\r\n                    \"path\": \"<Keyboard>/e\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"NextCharacter\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"ec409464-642c-48ee-9e68-d65b5d548fcb\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"NextCharacter\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"e7e286c7-dc50-4287-a13a-fd83dceff33d\",\r\n                    \"path\": \"<Gamepad>/rightShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"NextCharacter\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"da76269d-c7fe-4727-8135-4103df91a8fc\",\r\n                    \"path\": \"<Keyboard>/q\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PrevCharacter\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"5511bebe-df9f-4253-824d-2c819f5b0968\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PrevCharacter\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"61975a23-1c20-4f98-82d9-da1bb6c5bbd8\",\r\n                    \"path\": \"<Gamepad>/leftShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PrevCharacter\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"fbddf73e-c8d2-4a4c-b144-452ac689cbb9\",\r\n                    \"path\": \"<Keyboard>/o\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"NextTab\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"60d02358-8440-4aca-b7f3-cc05ddfdbb51\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"NextTab\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d60d6218-5380-40d7-a809-3385f87a44df\",\r\n                    \"path\": \"<Gamepad>/rightTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"NextTab\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"c5180029-9ff1-4e98-bfec-074142931a6c\",\r\n                    \"path\": \"<Keyboard>/u\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PrevTab\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"dfe5327d-b73e-47a1-ab7a-4ee7fe34264f\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PrevTab\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"8c9ade9d-4778-4226-96c0-5dc33e580444\",\r\n                    \"path\": \"<Gamepad>/leftTrigger\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"PrevTab\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"4bfb32b4-9271-4132-96a3-175c57312ff8\",\r\n                    \"path\": \"<Keyboard>/h\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"OpenCharacterList\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"abb5d209-dc21-4f2c-8af7-02dcd85101a3\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"OpenCharacterList\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"de768efa-f08f-4a65-a189-b00106edcbbb\",\r\n                    \"path\": \"<Gamepad>/select\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"OpenCharacterList\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"0de256b7-9cf6-4c53-b98f-9a4362bb7741\",\r\n                    \"path\": \"<Keyboard>/f\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"OpenModelView\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"5a60d390-6a9b-4b00-9ee5-93efbf0c0639\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"OpenModelView\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"bba4f8e2-42bd-48e5-979a-853c8a65f3ca\",\r\n                    \"path\": \"<Gamepad>/start\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"OpenModelView\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d1b6c8a5-eab5-43d9-bdde-637483f76799\",\r\n                    \"path\": \"<Keyboard>/j\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Destiny\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"5a5e32df-3478-48c7-a60a-5c91712552fc\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Destiny\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"b300b9bc-aa05-4bb6-b34f-e31fc843e3fd\",\r\n                    \"path\": \"<Gamepad>/buttonWest\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Destiny\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"e0150f73-09c4-4277-b66b-3502a03f5f7a\",\r\n                    \"path\": \"<Keyboard>/k\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Upgrade\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"4a644983-d11b-408e-81d1-8fbbfcc86ce9\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Upgrade\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"38347583-9732-41da-a928-59a1edf07820\",\r\n                    \"path\": \"<Gamepad>/buttonNorth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Upgrade\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"68d9e4e0-f1d3-401d-883c-39762289eea4\",\r\n                    \"path\": \"<Keyboard>/j\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SelectMaxLevel\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d27cd6f9-5aa8-4161-b574-a8e37fb3e8c9\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SelectMaxLevel\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"bb41df19-f3b0-4408-85de-7c812108d08b\",\r\n                    \"path\": \"<Gamepad>/buttonWest\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SelectMaxLevel\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"68deb7b0-d478-4424-bfc8-0eca05fb6082\",\r\n                    \"path\": \"<Keyboard>/x\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShowCostCoinDetail\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"c0a651f3-287f-4ad5-b9c4-2549d2207dd3\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShowCostCoinDetail\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"0419b5ad-adef-4924-b3e8-3ea631101dbf\",\r\n                    \"path\": \"<Gamepad>/rightStickPress\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShowCostCoinDetail\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"c1ec4bf0-0abf-4706-b3a7-43117ff465f9\",\r\n                    \"path\": \"<Keyboard>/j\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ToggleSkillDescriptionMode\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"40f38c4c-12b5-4f12-87e1-9cc264539e32\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ToggleSkillDescriptionMode\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"02d99587-2a14-4015-8b20-06e6f182ff4b\",\r\n                    \"path\": \"<Gamepad>/buttonWest\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ToggleSkillDescriptionMode\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"a3e6bb21-2a2f-4556-8f04-570a5074708b\",\r\n                    \"path\": \"<Keyboard>/z\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShowMaterialCost\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"e26b00af-0bb2-4e46-a6d9-c0805e50ccc0\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShowMaterialCost\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"4db5bd2c-248a-4ce3-ac17-b2cadd26cc89\",\r\n                    \"path\": \"<Gamepad>/leftStickPress\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShowMaterialCost\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"7f79a453-1896-42a9-88a4-e0674739ceee\",\r\n                    \"path\": \"<Keyboard>/f\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShowUpdatePreview\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"388f1a48-33ad-4df4-ac81-fb7778599dd1\",\r\n                    \"path\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShowUpdatePreview\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d20f609c-593c-4d9a-8830-57ceaf129fae\",\r\n                    \"path\": \"<Gamepad>/start\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"ShowUpdatePreview\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                }\r\n            ]\r\n        },\r\n        {\r\n            \"name\": \"Login\",\r\n            \"id\": \"d72dbcd9-24c0-4cba-b557-45b35f358d0f\",\r\n            \"actions\": [\r\n                {\r\n                    \"name\": \"Enter\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"a7bf91f2-d5a7-4a4c-8750-792e9b10e59e\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Account\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"2412f691-82d8-423a-b9af-9028d88c4295\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"SoundMute\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"0cf7f887-f4a6-4ba6-aa8e-14b4e507202a\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"AgeNotice\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"4e7085e1-b2ba-4ba5-8b70-1a56616415fb\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                },\r\n                {\r\n                    \"name\": \"Billboard\",\r\n                    \"type\": \"PassThrough\",\r\n                    \"id\": \"efa8c384-5e15-4e4d-8063-0d0d73d414fa\",\r\n                    \"expectedControlType\": \"Button\",\r\n                    \"processors\": \"\",\r\n                    \"interactions\": \"\",\r\n                    \"initialStateCheck\": false\r\n                }\r\n            ],\r\n            \"bindings\": [\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"bb3c549b-e04d-4c40-8617-1b3f8fe0b87c\",\r\n                    \"path\": \"<Keyboard>/space\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Enter\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"a6097db3-b608-414e-9ffd-219c665460df\",\r\n                    \"path\": \"<Gamepad>/buttonSouth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Enter\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"dfee0b90-29d0-4c92-8a3b-89e65e2a2403\",\r\n                    \"path\": \"<Keyboard>/k\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Account\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"be010c1d-def6-401d-8a9c-688d9f771f1a\",\r\n                    \"path\": \"<Gamepad>/buttonNorth\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Account\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"f3d2bd80-db30-4ab8-9fa0-281b84f3732a\",\r\n                    \"path\": \"<Keyboard>/i\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SoundMute\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"be9c8fc1-470c-4b1d-b594-1cd592dffd80\",\r\n                    \"path\": \"<Gamepad>/buttonWest\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"SoundMute\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"d0e90b71-e52b-4980-b3fc-1d8346459752\",\r\n                    \"path\": \"<Keyboard>/f\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Billboard\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"8f15b283-de83-40db-9d57-81d976612516\",\r\n                    \"path\": \"<Gamepad>/select\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"Billboard\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"efabbe3e-4cc2-412b-b9a9-8c65b5af8ac1\",\r\n                    \"path\": \"<Keyboard>/p\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"AgeNotice\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                },\r\n                {\r\n                    \"name\": \"\",\r\n                    \"id\": \"296befdd-093e-4806-84f8-61fb0832ff9a\",\r\n                    \"path\": \"<Gamepad>/leftShoulder\",\r\n                    \"interactions\": \"\",\r\n                    \"processors\": \"\",\r\n                    \"groups\": \"\",\r\n                    \"action\": \"AgeNotice\",\r\n                    \"isComposite\": false,\r\n                    \"isPartOfComposite\": false\r\n                }\r\n            ]\r\n        }\r\n    ],\r\n    \"controlSchemes\": []\r\n}");
		m_Player = asset.FindActionMap("Player", throwIfNotFound: true);
		m_Player_Move = m_Player.FindAction("Move", throwIfNotFound: true);
		m_Player_RegularAttack = m_Player.FindAction("RegularAttack", throwIfNotFound: true);
		m_Player_SkillAttack = m_Player.FindAction("SkillAttack", throwIfNotFound: true);
		m_Player_Dodge = m_Player.FindAction("Dodge", throwIfNotFound: true);
		m_Player_Jump = m_Player.FindAction("Jump", throwIfNotFound: true);
		m_Player_Vibrate = m_Player.FindAction("Vibrate", throwIfNotFound: true);
		m_Player_ShortCut = m_Player.FindAction("ShortCut", throwIfNotFound: true);
		m_Player_Claw = m_Player.FindAction("Claw", throwIfNotFound: true);
		m_Player_Switch1Character = m_Player.FindAction("Switch1Character", throwIfNotFound: true);
		m_Player_Switch2Character = m_Player.FindAction("Switch2Character", throwIfNotFound: true);
		m_Player_Switch3Character = m_Player.FindAction("Switch3Character", throwIfNotFound: true);
		m_UI = asset.FindActionMap("UI", throwIfNotFound: true);
		m_UI_RightClick = m_UI.FindAction("RightClick", throwIfNotFound: true);
		m_UI_OpenAreaExplore = m_UI.FindAction("OpenAreaExplore", throwIfNotFound: true);
		m_UI_OpenSubAreaExplore = m_UI.FindAction("OpenSubAreaExplore", throwIfNotFound: true);
		m_UI_MoveMap = m_UI.FindAction("MoveMap", throwIfNotFound: true);
		m_UI_OpenTIps = m_UI.FindAction("OpenTIps", throwIfNotFound: true);
		m_UI_ImportCollect = m_UI.FindAction("ImportCollect", throwIfNotFound: true);
		m_UI_LSUpDownSelect = m_UI.FindAction("LSUpDownSelect", throwIfNotFound: true);
		m_UI_LSLeftRightSelect = m_UI.FindAction("LSLeftRightSelect", throwIfNotFound: true);
		m_UI_RSLeftRightSelect = m_UI.FindAction("RSLeftRightSelect", throwIfNotFound: true);
		m_UI_RSUpDownSelect = m_UI.FindAction("RSUpDownSelect", throwIfNotFound: true);
		m_UI_ScrollViewRightStickControl = m_UI.FindAction("ScrollViewRightStickControl", throwIfNotFound: true);
		m_UI_MiddleClick = m_UI.FindAction("MiddleClick", throwIfNotFound: true);
		m_UI_ScrollWheel = m_UI.FindAction("ScrollWheel", throwIfNotFound: true);
		m_UI_ScrollWheelY = m_UI.FindAction("ScrollWheelY", throwIfNotFound: true);
		m_UI_Click = m_UI.FindAction("Click", throwIfNotFound: true);
		m_UI_Point = m_UI.FindAction("Point", throwIfNotFound: true);
		m_UI_Navigate = m_UI.FindAction("Navigate", throwIfNotFound: true);
		m_UI_GamePadNavigate = m_UI.FindAction("GamePadNavigate", throwIfNotFound: true);
		m_UI_SwitchInteract = m_UI.FindAction("SwitchInteract", throwIfNotFound: true);
		m_UI_SwitchInteractGamePadX = m_UI.FindAction("SwitchInteractGamePadX", throwIfNotFound: true);
		m_UI_SwitchInteractGamePadY = m_UI.FindAction("SwitchInteractGamePadY", throwIfNotFound: true);
		m_UI_ZoomFovGamePadY = m_UI.FindAction("ZoomFovGamePadY", throwIfNotFound: true);
		m_UI_ZoomFovPageUp = m_UI.FindAction("ZoomFovPageUp", throwIfNotFound: true);
		m_UI_ZoomFovPageDown = m_UI.FindAction("ZoomFovPageDown", throwIfNotFound: true);
		m_UI_MenuDisc = m_UI.FindAction("MenuDisc", throwIfNotFound: true);
		m_UI_Bag = m_UI.FindAction("Bag", throwIfNotFound: true);
		m_UI_Character = m_UI.FindAction("Character", throwIfNotFound: true);
		m_UI_Summary = m_UI.FindAction("Summary", throwIfNotFound: true);
		m_UI_CardPool = m_UI.FindAction("CardPool", throwIfNotFound: true);
		m_UI_Activity = m_UI.FindAction("Activity", throwIfNotFound: true);
		m_UI_Task = m_UI.FindAction("Task", throwIfNotFound: true);
		m_UI_Team = m_UI.FindAction("Team", throwIfNotFound: true);
		m_UI_BattlePass = m_UI.FindAction("BattlePass", throwIfNotFound: true);
		m_UI_MissionTarget = m_UI.FindAction("MissionTarget", throwIfNotFound: true);
		m_UI_Map = m_UI.FindAction("Map", throwIfNotFound: true);
		m_UI_Back = m_UI.FindAction("Back", throwIfNotFound: true);
		m_UI_Esc = m_UI.FindAction("Esc", throwIfNotFound: true);
		m_UI_Interact = m_UI.FindAction("Interact", throwIfNotFound: true);
		m_UI_GM = m_UI.FindAction("GM", throwIfNotFound: true);
		m_UI_GMConsole = m_UI.FindAction("GMConsole", throwIfNotFound: true);
		m_UI_ShowCursor = m_UI.FindAction("ShowCursor", throwIfNotFound: true);
		m_UI_CommonSelect = m_UI.FindAction("CommonSelect", throwIfNotFound: true);
		m_UI_LeftSwitchRole = m_UI.FindAction("LeftSwitchRole", throwIfNotFound: true);
		m_UI_RightSwitchRole = m_UI.FindAction("RightSwitchRole", throwIfNotFound: true);
		m_UI_SelectNameInput = m_UI.FindAction("SelectNameInput", throwIfNotFound: true);
		m_UI_Confirm = m_UI.FindAction("Confirm", throwIfNotFound: true);
		m_UI_RightStickPress = m_UI.FindAction("RightStickPress", throwIfNotFound: true);
		m_UI_SNSOpenMission = m_UI.FindAction("SNSOpenMission", throwIfNotFound: true);
		m_UI_GuideToturial = m_UI.FindAction("GuideToturial", throwIfNotFound: true);
		m_UI_SpecialProppickTrigger = m_UI.FindAction("SpecialProppickTrigger", throwIfNotFound: true);
		m_UI_TextLibrary = m_UI.FindAction("TextLibrary", throwIfNotFound: true);
		m_UI_RightStickNavigate = m_UI.FindAction("RightStickNavigate", throwIfNotFound: true);
		m_UI_LeftStackPress = m_UI.FindAction("LeftStackPress", throwIfNotFound: true);
		m_UI_LeftTrigger = m_UI.FindAction("LeftTrigger", throwIfNotFound: true);
		m_UI_View = m_UI.FindAction("View", throwIfNotFound: true);
		m_UI_Start = m_UI.FindAction("Start", throwIfNotFound: true);
		m_UI_TriggerSearchInPutField = m_UI.FindAction("TriggerSearchInPutField", throwIfNotFound: true);
		m_UI_SearchSubmit = m_UI.FindAction("SearchSubmit", throwIfNotFound: true);
		m_UI_SwitchPageLeft = m_UI.FindAction("SwitchPageLeft", throwIfNotFound: true);
		m_UI_SwitchPageRight = m_UI.FindAction("SwitchPageRight", throwIfNotFound: true);
		m_UI_SwitchPageUp = m_UI.FindAction("SwitchPageUp", throwIfNotFound: true);
		m_UI_SwitchPageDown = m_UI.FindAction("SwitchPageDown", throwIfNotFound: true);
		m_UI_UISpecial1 = m_UI.FindAction("UISpecial1", throwIfNotFound: true);
		m_UI_UISpecial2 = m_UI.FindAction("UISpecial2", throwIfNotFound: true);
		m_UI_UISpecial3 = m_UI.FindAction("UISpecial3", throwIfNotFound: true);
		m_UI_UISpecial4 = m_UI.FindAction("UISpecial4", throwIfNotFound: true);
		m_UI_UISpecial5 = m_UI.FindAction("UISpecial5", throwIfNotFound: true);
		m_UI_UISpecial6 = m_UI.FindAction("UISpecial6", throwIfNotFound: true);
		m_UI_UISpecial7 = m_UI.FindAction("UISpecial7", throwIfNotFound: true);
		m_UI_UISpecial8 = m_UI.FindAction("UISpecial8", throwIfNotFound: true);
		m_UI_UISpecial9 = m_UI.FindAction("UISpecial9", throwIfNotFound: true);
		m_UI_UISpecial10 = m_UI.FindAction("UISpecial10", throwIfNotFound: true);
		m_UI_LongPressX = m_UI.FindAction("LongPressX", throwIfNotFound: true);
		m_UI_RightTrigger = m_UI.FindAction("RightTrigger", throwIfNotFound: true);
		m_UI_Next = m_UI.FindAction("Next", throwIfNotFound: true);
		m_UI_Prev = m_UI.FindAction("Prev", throwIfNotFound: true);
		m_UI_SelectItemCell = m_UI.FindAction("SelectItemCell", throwIfNotFound: true);
		m_UI_Lock = m_UI.FindAction("Lock", throwIfNotFound: true);
		m_UI_ShowCoinDetail = m_UI.FindAction("ShowCoinDetail", throwIfNotFound: true);
		m_UI_PressAnyKey = m_UI.FindAction("PressAnyKey", throwIfNotFound: true);
		m_UI_ButtonUp = m_UI.FindAction("ButtonUp", throwIfNotFound: true);
		m_UI_ButtonDown = m_UI.FindAction("ButtonDown", throwIfNotFound: true);
		m_UI_ButtonLeft = m_UI.FindAction("ButtonLeft", throwIfNotFound: true);
		m_UI_ButtonRight = m_UI.FindAction("ButtonRight", throwIfNotFound: true);
		m_UI_LSUp = m_UI.FindAction("LSUp", throwIfNotFound: true);
		m_UI_LSDown = m_UI.FindAction("LSDown", throwIfNotFound: true);
		m_UI_LSLeft = m_UI.FindAction("LSLeft", throwIfNotFound: true);
		m_UI_LSRight = m_UI.FindAction("LSRight", throwIfNotFound: true);
		m_UI_StopChallenge = m_UI.FindAction("StopChallenge", throwIfNotFound: true);
		m_UI_WorldLevelBreakTips = m_UI.FindAction("WorldLevelBreakTips", throwIfNotFound: true);
		m_LargeMapView = asset.FindActionMap("LargeMapView", throwIfNotFound: true);
		m_LargeMapView_mapScaleReduce = m_LargeMapView.FindAction("mapScaleReduce", throwIfNotFound: true);
		m_LargeMapView_mapScaleReduceFloat = m_LargeMapView.FindAction("mapScaleReduceFloat", throwIfNotFound: true);
		m_LargeMapView_mapScaleAdd = m_LargeMapView.FindAction("mapScaleAdd", throwIfNotFound: true);
		m_LargeMapView_mapScaleAddFloat = m_LargeMapView.FindAction("mapScaleAddFloat", throwIfNotFound: true);
		m_LargeMapView_Select = m_LargeMapView.FindAction("Select", throwIfNotFound: true);
		m_LargeMapView_MapItem = m_LargeMapView.FindAction("MapItem", throwIfNotFound: true);
		m_LargeMapView_Return = m_LargeMapView.FindAction("Return", throwIfNotFound: true);
		m_LargeMapView_MapCollection = m_LargeMapView.FindAction("MapCollection", throwIfNotFound: true);
		m_LargeMapView_WorldMap = m_LargeMapView.FindAction("WorldMap", throwIfNotFound: true);
		m_LargeMapView_MapTemple = m_LargeMapView.FindAction("MapTemple", throwIfNotFound: true);
		m_LargeMapView_Delete = m_LargeMapView.FindAction("Delete", throwIfNotFound: true);
		m_LargeMapView_MoveMap = m_LargeMapView.FindAction("MoveMap", throwIfNotFound: true);
		m_LargeMapView_MoveCursor = m_LargeMapView.FindAction("MoveCursor", throwIfNotFound: true);
		m_LargeMapView_BackToPlayer = m_LargeMapView.FindAction("BackToPlayer", throwIfNotFound: true);
		m_LargeMapView_WorldMapChooseLast = m_LargeMapView.FindAction("WorldMapChooseLast", throwIfNotFound: true);
		m_LargeMapView_WorldMapChooseNext = m_LargeMapView.FindAction("WorldMapChooseNext", throwIfNotFound: true);
		m_LargeMapView_MapSideInfoLast = m_LargeMapView.FindAction("MapSideInfoLast", throwIfNotFound: true);
		m_LargeMapView_MapSideInfoNext = m_LargeMapView.FindAction("MapSideInfoNext", throwIfNotFound: true);
		m_LargeMapView_ChangeToSelectItem = m_LargeMapView.FindAction("ChangeToSelectItem", throwIfNotFound: true);
		m_LargeMapView_BackToTarget = m_LargeMapView.FindAction("BackToTarget", throwIfNotFound: true);
		m_LargeMapView_Up = m_LargeMapView.FindAction("Up", throwIfNotFound: true);
		m_LargeMapView_Down = m_LargeMapView.FindAction("Down", throwIfNotFound: true);
		m_LargeMapView_Left = m_LargeMapView.FindAction("Left", throwIfNotFound: true);
		m_LargeMapView_Right = m_LargeMapView.FindAction("Right", throwIfNotFound: true);
		m_Conversation = asset.FindActionMap("Conversation", throwIfNotFound: true);
		m_Conversation_ConversationNext = m_Conversation.FindAction("ConversationNext", throwIfNotFound: true);
		m_Conversation_ConversationAutoPlay = m_Conversation.FindAction("ConversationAutoPlay", throwIfNotFound: true);
		m_Conversation_ConversationReview = m_Conversation.FindAction("ConversationReview", throwIfNotFound: true);
		m_Conversation_ConversationHide = m_Conversation.FindAction("ConversationHide", throwIfNotFound: true);
		m_Conversation_ConversationReviewClose = m_Conversation.FindAction("ConversationReviewClose", throwIfNotFound: true);
		m_Conversation_ConversationReviewScroll = m_Conversation.FindAction("ConversationReviewScroll", throwIfNotFound: true);
		m_Conversation_ConversationLastChoice = m_Conversation.FindAction("ConversationLastChoice", throwIfNotFound: true);
		m_Conversation_ConversationLastChoice1 = m_Conversation.FindAction("ConversationLastChoice1", throwIfNotFound: true);
		m_Conversation_ConversationNextChoice = m_Conversation.FindAction("ConversationNextChoice", throwIfNotFound: true);
		m_Conversation_ConversationNextChoice1 = m_Conversation.FindAction("ConversationNextChoice1", throwIfNotFound: true);
		m_Conversation_ConversationSkip = m_Conversation.FindAction("ConversationSkip", throwIfNotFound: true);
		m_Conversation_ConversationChoose = m_Conversation.FindAction("ConversationChoose", throwIfNotFound: true);
		m_StateObject = asset.FindActionMap("StateObject", throwIfNotFound: true);
		m_StateObject_StateObjectMove = m_StateObject.FindAction("StateObjectMove", throwIfNotFound: true);
		m_Settings = asset.FindActionMap("Settings", throwIfNotFound: true);
		m_Settings_SettingsConfirm = m_Settings.FindAction("SettingsConfirm", throwIfNotFound: true);
		m_Settings_SettingsPreTab = m_Settings.FindAction("SettingsPreTab", throwIfNotFound: true);
		m_Settings_SettingsNextTab = m_Settings.FindAction("SettingsNextTab", throwIfNotFound: true);
		m_Settings_SettingsSwitchDetail = m_Settings.FindAction("SettingsSwitchDetail", throwIfNotFound: true);
		m_Settings_SettingsSliderLeft = m_Settings.FindAction("SettingsSliderLeft", throwIfNotFound: true);
		m_Settings_SettingsSliderRight = m_Settings.FindAction("SettingsSliderRight", throwIfNotFound: true);
		m_Settings_SettingsSliderShift = m_Settings.FindAction("SettingsSliderShift", throwIfNotFound: true);
		m_Settings_SettingsSliderLeftShift = m_Settings.FindAction("SettingsSliderLeftShift", throwIfNotFound: true);
		m_Settings_SettingsSliderRightShift = m_Settings.FindAction("SettingsSliderRightShift", throwIfNotFound: true);
		m_Settings_SettingsSelectionUp = m_Settings.FindAction("SettingsSelectionUp", throwIfNotFound: true);
		m_Settings_SettingsSelectionUp1 = m_Settings.FindAction("SettingsSelectionUp1", throwIfNotFound: true);
		m_Settings_SettingsSelectionDown = m_Settings.FindAction("SettingsSelectionDown", throwIfNotFound: true);
		m_Settings_SettingsSelectionDown1 = m_Settings.FindAction("SettingsSelectionDown1", throwIfNotFound: true);
		m_Settings_SettingsSelectionLeft = m_Settings.FindAction("SettingsSelectionLeft", throwIfNotFound: true);
		m_Settings_SettingsSelectionLeft1 = m_Settings.FindAction("SettingsSelectionLeft1", throwIfNotFound: true);
		m_Settings_SettingsSelectionRight = m_Settings.FindAction("SettingsSelectionRight", throwIfNotFound: true);
		m_Settings_SettingsSelectionRight1 = m_Settings.FindAction("SettingsSelectionRight1", throwIfNotFound: true);
		m_Settings_SettingsBackHUD = m_Settings.FindAction("SettingsBackHUD", throwIfNotFound: true);
		m_Settings_PreTab1 = m_Settings.FindAction("PreTab1", throwIfNotFound: true);
		m_Settings_NextTab1 = m_Settings.FindAction("NextTab1", throwIfNotFound: true);
		m_Settings_SettingsResetToDefault = m_Settings.FindAction("SettingsResetToDefault", throwIfNotFound: true);
		m_Guide = asset.FindActionMap("Guide", throwIfNotFound: true);
		m_Guide_ClickFinshGuideStep = m_Guide.FindAction("ClickFinshGuideStep", throwIfNotFound: true);
		m_Guide_ClickSkipGuide = m_Guide.FindAction("ClickSkipGuide", throwIfNotFound: true);
		m_TextLibrary = asset.FindActionMap("TextLibrary", throwIfNotFound: true);
		m_TextLibrary_TextLibraryUITipGamePadModifier = m_TextLibrary.FindAction("TextLibraryUITipGamePadModifier", throwIfNotFound: true);
		m_TextLibrary_TextLibraryUITipGamePadBinding = m_TextLibrary.FindAction("TextLibraryUITipGamePadBinding", throwIfNotFound: true);
		m_CharacterView = asset.FindActionMap("CharacterView", throwIfNotFound: true);
		m_CharacterView_NextCharacter = m_CharacterView.FindAction("NextCharacter", throwIfNotFound: true);
		m_CharacterView_PrevCharacter = m_CharacterView.FindAction("PrevCharacter", throwIfNotFound: true);
		m_CharacterView_NextTab = m_CharacterView.FindAction("NextTab", throwIfNotFound: true);
		m_CharacterView_PrevTab = m_CharacterView.FindAction("PrevTab", throwIfNotFound: true);
		m_CharacterView_OpenCharacterList = m_CharacterView.FindAction("OpenCharacterList", throwIfNotFound: true);
		m_CharacterView_OpenModelView = m_CharacterView.FindAction("OpenModelView", throwIfNotFound: true);
		m_CharacterView_Upgrade = m_CharacterView.FindAction("Upgrade", throwIfNotFound: true);
		m_CharacterView_Destiny = m_CharacterView.FindAction("Destiny", throwIfNotFound: true);
		m_CharacterView_SelectMaxLevel = m_CharacterView.FindAction("SelectMaxLevel", throwIfNotFound: true);
		m_CharacterView_ShowCostCoinDetail = m_CharacterView.FindAction("ShowCostCoinDetail", throwIfNotFound: true);
		m_CharacterView_ToggleSkillDescriptionMode = m_CharacterView.FindAction("ToggleSkillDescriptionMode", throwIfNotFound: true);
		m_CharacterView_ShowMaterialCost = m_CharacterView.FindAction("ShowMaterialCost", throwIfNotFound: true);
		m_CharacterView_ShowUpdatePreview = m_CharacterView.FindAction("ShowUpdatePreview", throwIfNotFound: true);
		m_Login = asset.FindActionMap("Login", throwIfNotFound: true);
		m_Login_Enter = m_Login.FindAction("Enter", throwIfNotFound: true);
		m_Login_Account = m_Login.FindAction("Account", throwIfNotFound: true);
		m_Login_SoundMute = m_Login.FindAction("SoundMute", throwIfNotFound: true);
		m_Login_AgeNotice = m_Login.FindAction("AgeNotice", throwIfNotFound: true);
		m_Login_Billboard = m_Login.FindAction("Billboard", throwIfNotFound: true);
	}

	~ACTInputActions()
	{
	}

	public void Dispose()
	{
		UnityEngine.Object.Destroy(asset);
	}

	public bool Contains(InputAction action)
	{
		return asset.Contains(action);
	}

	public IEnumerator<InputAction> GetEnumerator()
	{
		return asset.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public void Enable()
	{
		asset.Enable();
	}

	public void Disable()
	{
		asset.Disable();
	}

	public InputAction FindAction(string actionNameOrId, bool throwIfNotFound = false)
	{
		return asset.FindAction(actionNameOrId, throwIfNotFound);
	}

	public int FindBinding(InputBinding bindingMask, out InputAction action)
	{
		return asset.FindBinding(bindingMask, out action);
	}
}
