using System;
using LuaInterface;
using P08.Gamepad;

public class P08_Gamepad_En_ButtonTypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(En_ButtonType));
		L.RegVar("None", get_None, null);
		L.RegVar("MoveUp", get_MoveUp, null);
		L.RegVar("MoveDown", get_MoveDown, null);
		L.RegVar("MoveLeft", get_MoveLeft, null);
		L.RegVar("MoveRight", get_MoveRight, null);
		L.RegVar("Lock", get_Lock, null);
		L.RegVar("Melee", get_Melee, null);
		L.RegVar("Skill1", get_Skill1, null);
		L.RegVar("Skill2", get_Skill2, null);
		L.RegVar("Skill3", get_Skill3, null);
		L.RegVar("Avoid", get_Avoid, null);
		L.RegVar("Ultimate1", get_Ultimate1, null);
		L.RegVar("Ultimate2", get_Ultimate2, null);
		L.RegVar("Ultimate3", get_Ultimate3, null);
		L.RegVar("CameraLeft", get_CameraLeft, null);
		L.RegVar("CameraRight", get_CameraRight, null);
		L.RegVar("SubJoystickUp", get_SubJoystickUp, null);
		L.RegVar("SubJoystickDown", get_SubJoystickDown, null);
		L.RegVar("SubJoystickLeft", get_SubJoystickLeft, null);
		L.RegVar("SubJoystickRight", get_SubJoystickRight, null);
		L.RegVar("JoystickHorizontal", get_JoystickHorizontal, null);
		L.RegVar("JoystickVertical", get_JoystickVertical, null);
		L.RegVar("SubJoystickHorizontal", get_SubJoystickHorizontal, null);
		L.RegVar("SubJoystickVertical", get_SubJoystickVertical, null);
		L.RegVar("CameraHorizontal", get_CameraHorizontal, null);
		L.RegVar("MoveJoystick", get_MoveJoystick, null);
		L.RegVar("SubJoystick", get_SubJoystick, null);
		L.RegVar("CameraJoystick", get_CameraJoystick, null);
		L.RegVar("CameraUp", get_CameraUp, null);
		L.RegVar("CameraDown", get_CameraDown, null);
		L.RegVar("MoveSwitch", get_MoveSwitch, null);
		L.RegVar("Map", get_Map, null);
		L.RegVar("Task", get_Task, null);
		L.RegVar("PlayGame1", get_PlayGame1, null);
		L.RegVar("PlayGame2", get_PlayGame2, null);
		L.RegVar("TaskTrack", get_TaskTrack, null);
		L.RegVar("CameraReset", get_CameraReset, null);
		L.RegVar("KeepMove", get_KeepMove, null);
		L.RegVar("SandPlay_Confirm", get_SandPlay_Confirm, null);
		L.RegVar("SelectUp", get_SelectUp, null);
		L.RegVar("SelectDown", get_SelectDown, null);
		L.RegVar("QWWalkRunSwitch", get_QWWalkRunSwitch, null);
		L.RegVar("QWFastRunSwitch", get_QWFastRunSwitch, null);
		L.RegVar("MasterSkill", get_MasterSkill, null);
		L.RegVar("Special_Start", get_Special_Start, null);
		L.RegVar("Special_SwitchCursor", get_Special_SwitchCursor, null);
		L.RegVar("Special_JoystickClick", get_Special_JoystickClick, null);
		L.RegVar("Special_CampSkill", get_Special_CampSkill, null);
		L.RegVar("MouseScrollWheelUp", get_MouseScrollWheelUp, null);
		L.RegVar("MouseScrollWheelDown", get_MouseScrollWheelDown, null);
		L.RegVar("Sys_Start", get_Sys_Start, null);
		L.RegVar("Sys_Back", get_Sys_Back, null);
		L.RegVar("Sys_Home", get_Sys_Home, null);
		L.RegVar("Sys_Info", get_Sys_Info, null);
		L.RegVar("Sys_Skip", get_Sys_Skip, null);
		L.RegVar("Sys_Next", get_Sys_Next, null);
		L.RegVar("Sys_Confirm", get_Sys_Confirm, null);
		L.RegVar("Sys_Retry", get_Sys_Retry, null);
		L.RegVar("Sys_Hide", get_Sys_Hide, null);
		L.RegVar("Sys_Auto", get_Sys_Auto, null);
		L.RegVar("Sys_Quit", get_Sys_Quit, null);
		L.RegVar("Sys_QuitAndSettle", get_Sys_QuitAndSettle, null);
		L.RegVar("Sys_PlayerInfo", get_Sys_PlayerInfo, null);
		L.RegVar("Sys_SideBar", get_Sys_SideBar, null);
		L.RegVar("Sys_Shop", get_Sys_Shop, null);
		L.RegVar("Sys_Mailbox", get_Sys_Mailbox, null);
		L.RegVar("Sys_GoBattle", get_Sys_GoBattle, null);
		L.RegVar("Sys_Task", get_Sys_Task, null);
		L.RegVar("Sys_Characters", get_Sys_Characters, null);
		L.RegVar("Sys_Gacha", get_Sys_Gacha, null);
		L.RegVar("Sys_Chat", get_Sys_Chat, null);
		L.RegVar("Sys_Dorm", get_Sys_Dorm, null);
		L.RegVar("Sys_Repository", get_Sys_Repository, null);
		L.RegVar("Sys_Guild", get_Sys_Guild, null);
		L.RegVar("Sys_Passport", get_Sys_Passport, null);
		L.RegVar("Sys_Friends", get_Sys_Friends, null);
		L.RegVar("Sys_ChatSend", get_Sys_ChatSend, null);
		L.RegVar("Sys_StorySound", get_Sys_StorySound, null);
		L.RegVar("SYS_COMMON_START", get_SYS_COMMON_START, null);
		L.RegVar("Sys_StartBattle", get_Sys_StartBattle, null);
		L.RegVar("Sys_MiniGame1", get_Sys_MiniGame1, null);
		L.RegVar("Sys_MiniGame2", get_Sys_MiniGame2, null);
		L.RegVar("Sys_MiniGame3", get_Sys_MiniGame3, null);
		L.RegVar("SYS_SPECIAL_START", get_SYS_SPECIAL_START, null);
		L.RegVar("Sys_BattlePause", get_Sys_BattlePause, null);
		L.RegVar("Story_Option_Num1", get_Story_Option_Num1, null);
		L.RegVar("Story_Option_Num2", get_Story_Option_Num2, null);
		L.RegVar("Story_Option_Num3", get_Story_Option_Num3, null);
		L.RegVar("Story_Option_Num4", get_Story_Option_Num4, null);
		L.RegVar("Story_Option_Num5", get_Story_Option_Num5, null);
		L.RegVar("Story_Option_Num6", get_Story_Option_Num6, null);
		L.RegVar("Story_Option_Num7", get_Story_Option_Num7, null);
		L.RegVar("Story_Option_Num8", get_Story_Option_Num8, null);
		L.RegVar("Story_Option_Num9", get_Story_Option_Num9, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<En_ButtonType>.Check = CheckType;
		StackTraits<En_ButtonType>.Push = Push;
	}

	private static void Push(IntPtr L, En_ButtonType arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(En_ButtonType), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_None(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.None);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MoveUp(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.MoveUp);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MoveDown(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.MoveDown);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MoveLeft(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.MoveLeft);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MoveRight(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.MoveRight);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Lock(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Lock);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Melee(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Melee);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Skill1(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Skill1);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Skill2(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Skill2);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Skill3(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Skill3);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Avoid(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Avoid);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Ultimate1(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Ultimate1);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Ultimate2(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Ultimate2);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Ultimate3(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Ultimate3);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CameraLeft(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.CameraLeft);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CameraRight(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.CameraRight);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SubJoystickUp(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.SubJoystickUp);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SubJoystickDown(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.SubJoystickDown);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SubJoystickLeft(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.SubJoystickLeft);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SubJoystickRight(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.SubJoystickRight);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_JoystickHorizontal(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.JoystickHorizontal);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_JoystickVertical(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.JoystickVertical);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SubJoystickHorizontal(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.SubJoystickHorizontal);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SubJoystickVertical(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.SubJoystickVertical);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CameraHorizontal(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.CameraHorizontal);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MoveJoystick(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.MoveJoystick);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SubJoystick(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.SubJoystick);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CameraJoystick(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.CameraJoystick);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CameraUp(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.CameraUp);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CameraDown(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.CameraDown);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MoveSwitch(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.MoveSwitch);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Map(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Map);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Task(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Task);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PlayGame1(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.PlayGame1);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PlayGame2(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.PlayGame2);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TaskTrack(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.TaskTrack);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CameraReset(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.CameraReset);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_KeepMove(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.KeepMove);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SandPlay_Confirm(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.SandPlay_Confirm);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SelectUp(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.SelectUp);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SelectDown(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.SelectDown);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_QWWalkRunSwitch(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.QWWalkRunSwitch);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_QWFastRunSwitch(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.QWFastRunSwitch);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MasterSkill(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.MasterSkill);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Special_Start(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Special_Start);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Special_SwitchCursor(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Special_SwitchCursor);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Special_JoystickClick(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Special_JoystickClick);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Special_CampSkill(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Special_CampSkill);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MouseScrollWheelUp(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.MouseScrollWheelUp);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MouseScrollWheelDown(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.MouseScrollWheelDown);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Start(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Start);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Back(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Back);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Home(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Home);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Info(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Info);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Skip(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Skip);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Next(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Next);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Confirm(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Confirm);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Retry(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Retry);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Hide(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Hide);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Auto(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Auto);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Quit(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Quit);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_QuitAndSettle(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_QuitAndSettle);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_PlayerInfo(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_PlayerInfo);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_SideBar(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_SideBar);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Shop(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Shop);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Mailbox(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Mailbox);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_GoBattle(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_GoBattle);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Task(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Task);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Characters(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Characters);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Gacha(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Gacha);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Chat(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Chat);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Dorm(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Dorm);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Repository(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Repository);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Guild(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Guild);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Passport(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Passport);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_Friends(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_Friends);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_ChatSend(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_ChatSend);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_StorySound(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_StorySound);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SYS_COMMON_START(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.SYS_COMMON_START);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_StartBattle(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_StartBattle);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_MiniGame1(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_MiniGame1);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_MiniGame2(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_MiniGame2);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_MiniGame3(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_MiniGame3);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SYS_SPECIAL_START(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.SYS_SPECIAL_START);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Sys_BattlePause(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Sys_BattlePause);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Story_Option_Num1(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Story_Option_Num1);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Story_Option_Num2(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Story_Option_Num2);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Story_Option_Num3(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Story_Option_Num3);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Story_Option_Num4(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Story_Option_Num4);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Story_Option_Num5(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Story_Option_Num5);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Story_Option_Num6(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Story_Option_Num6);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Story_Option_Num7(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Story_Option_Num7);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Story_Option_Num8(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Story_Option_Num8);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Story_Option_Num9(IntPtr L)
	{
		ToLua.Push(L, En_ButtonType.Story_Option_Num9);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		En_ButtonType en_ButtonType = (En_ButtonType)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, en_ButtonType);
		return 1;
	}
}
