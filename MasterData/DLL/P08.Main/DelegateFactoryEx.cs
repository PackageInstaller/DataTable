using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class DelegateFactoryEx
{
	private class UnityEngine_Events_UnityAction_Packet_Event : LuaDelegate
	{
		public UnityEngine_Events_UnityAction_Packet_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Events_UnityAction_Packet_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Packet param0)
		{
			func.BeginPCall();
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Packet param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_LTEvent_Event : LuaDelegate
	{
		public System_Action_LTEvent_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_LTEvent_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(LTEvent param0)
		{
			func.BeginPCall();
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(LTEvent param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class OnVoidHandler_UnityEngine_Object_Event : LuaDelegate
	{
		public OnVoidHandler_UnityEngine_Object_Event(LuaFunction func)
			: base(func)
		{
		}

		public OnVoidHandler_UnityEngine_Object_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(UnityEngine.Object param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(UnityEngine.Object param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class LTDescr_EaseTypeDelegate_Event : LuaDelegate
	{
		public LTDescr_EaseTypeDelegate_Event(LuaFunction func)
			: base(func)
		{
		}

		public LTDescr_EaseTypeDelegate_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public Vector3 Call()
		{
			func.BeginPCall();
			func.PCall();
			Vector3 result = func.CheckVector3();
			func.EndPCall();
			return result;
		}

		public Vector3 CallWithSelf()
		{
			func.BeginPCall();
			func.Push(self);
			func.PCall();
			Vector3 result = func.CheckVector3();
			func.EndPCall();
			return result;
		}
	}

	private class LTDescr_ActionMethodDelegate_Event : LuaDelegate
	{
		public LTDescr_ActionMethodDelegate_Event(LuaFunction func)
			: base(func)
		{
		}

		public LTDescr_ActionMethodDelegate_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call()
		{
			func.Call();
		}

		public void CallWithSelf()
		{
			func.BeginPCall();
			func.Push(self);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_UI_LScrollRect_UpdateItems_Event : LuaDelegate
	{
		public UnityEngine_UI_LScrollRect_UpdateItems_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_UI_LScrollRect_UpdateItems_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Bounds param0, Bounds param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Bounds param0, Bounds param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private static DelegateFactoryEx factory = new DelegateFactoryEx();

	public static void Init()
	{
		Register();
	}

	[NoToLua]
	public static void Register()
	{
		DelegateFactory.dict.Add(typeof(UnityAction<Packet>), factory.UnityEngine_Events_UnityAction_Packet);
		DelegateFactory.dict.Add(typeof(Action<LTEvent>), factory.System_Action_LTEvent);
		DelegateFactory.dict.Add(typeof(OnVoidHandler<UnityEngine.Object>), factory.OnVoidHandler_UnityEngine_Object);
		DelegateFactory.dict.Add(typeof(LTDescr.EaseTypeDelegate), factory.LTDescr_EaseTypeDelegate);
		DelegateFactory.dict.Add(typeof(LTDescr.ActionMethodDelegate), factory.LTDescr_ActionMethodDelegate);
		DelegateFactory.dict.Add(typeof(LScrollRect.UpdateItems), factory.UnityEngine_UI_LScrollRect_UpdateItems);
		DelegateTraits<UnityAction<Packet>>.Init(factory.UnityEngine_Events_UnityAction_Packet);
		DelegateTraits<Action<LTEvent>>.Init(factory.System_Action_LTEvent);
		DelegateTraits<OnVoidHandler<UnityEngine.Object>>.Init(factory.OnVoidHandler_UnityEngine_Object);
		DelegateTraits<LTDescr.EaseTypeDelegate>.Init(factory.LTDescr_EaseTypeDelegate);
		DelegateTraits<LTDescr.ActionMethodDelegate>.Init(factory.LTDescr_ActionMethodDelegate);
		DelegateTraits<LScrollRect.UpdateItems>.Init(factory.UnityEngine_UI_LScrollRect_UpdateItems);
		TypeTraits<UnityAction<Packet>>.Init(factory.Check_UnityEngine_Events_UnityAction_Packet);
		TypeTraits<Action<LTEvent>>.Init(factory.Check_System_Action_LTEvent);
		TypeTraits<OnVoidHandler<UnityEngine.Object>>.Init(factory.Check_OnVoidHandler_UnityEngine_Object);
		TypeTraits<LTDescr.EaseTypeDelegate>.Init(factory.Check_LTDescr_EaseTypeDelegate);
		TypeTraits<LTDescr.ActionMethodDelegate>.Init(factory.Check_LTDescr_ActionMethodDelegate);
		TypeTraits<LScrollRect.UpdateItems>.Init(factory.Check_UnityEngine_UI_LScrollRect_UpdateItems);
		StackTraits<UnityAction<Packet>>.Push = factory.Push_UnityEngine_Events_UnityAction_Packet;
		StackTraits<Action<LTEvent>>.Push = factory.Push_System_Action_LTEvent;
		StackTraits<OnVoidHandler<UnityEngine.Object>>.Push = factory.Push_OnVoidHandler_UnityEngine_Object;
		StackTraits<LTDescr.EaseTypeDelegate>.Push = factory.Push_LTDescr_EaseTypeDelegate;
		StackTraits<LTDescr.ActionMethodDelegate>.Push = factory.Push_LTDescr_ActionMethodDelegate;
		StackTraits<LScrollRect.UpdateItems>.Push = factory.Push_UnityEngine_UI_LScrollRect_UpdateItems;
	}

	public UnityAction<Packet> UnityEngine_Events_UnityAction_Packet(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Events_UnityAction_Packet_Event unityEngine_Events_UnityAction_Packet_Event = new UnityEngine_Events_UnityAction_Packet_Event(func);
			UnityAction<Packet> unityAction = unityEngine_Events_UnityAction_Packet_Event.Call;
			unityEngine_Events_UnityAction_Packet_Event.method = unityAction.Method;
			return unityAction;
		}
		UnityEngine_Events_UnityAction_Packet_Event unityEngine_Events_UnityAction_Packet_Event2 = new UnityEngine_Events_UnityAction_Packet_Event(func, self);
		UnityAction<Packet> unityAction2 = unityEngine_Events_UnityAction_Packet_Event2.CallWithSelf;
		unityEngine_Events_UnityAction_Packet_Event2.method = unityAction2.Method;
		return unityAction2;
	}

	private bool Check_UnityEngine_Events_UnityAction_Packet(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UnityAction<Packet>), L, pos);
	}

	private void Push_UnityEngine_Events_UnityAction_Packet(IntPtr L, UnityAction<Packet> o)
	{
		ToLua.Push(L, o);
	}

	public Action<LTEvent> System_Action_LTEvent(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_LTEvent_Event system_Action_LTEvent_Event = new System_Action_LTEvent_Event(func);
			Action<LTEvent> action = system_Action_LTEvent_Event.Call;
			system_Action_LTEvent_Event.method = action.Method;
			return action;
		}
		System_Action_LTEvent_Event system_Action_LTEvent_Event2 = new System_Action_LTEvent_Event(func, self);
		Action<LTEvent> action2 = system_Action_LTEvent_Event2.CallWithSelf;
		system_Action_LTEvent_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_LTEvent(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<LTEvent>), L, pos);
	}

	private void Push_System_Action_LTEvent(IntPtr L, Action<LTEvent> o)
	{
		ToLua.Push(L, o);
	}

	public OnVoidHandler<UnityEngine.Object> OnVoidHandler_UnityEngine_Object(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			OnVoidHandler_UnityEngine_Object_Event onVoidHandler_UnityEngine_Object_Event = new OnVoidHandler_UnityEngine_Object_Event(func);
			OnVoidHandler<UnityEngine.Object> onVoidHandler = onVoidHandler_UnityEngine_Object_Event.Call;
			onVoidHandler_UnityEngine_Object_Event.method = onVoidHandler.Method;
			return onVoidHandler;
		}
		OnVoidHandler_UnityEngine_Object_Event onVoidHandler_UnityEngine_Object_Event2 = new OnVoidHandler_UnityEngine_Object_Event(func, self);
		OnVoidHandler<UnityEngine.Object> onVoidHandler2 = onVoidHandler_UnityEngine_Object_Event2.CallWithSelf;
		onVoidHandler_UnityEngine_Object_Event2.method = onVoidHandler2.Method;
		return onVoidHandler2;
	}

	private bool Check_OnVoidHandler_UnityEngine_Object(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(OnVoidHandler<UnityEngine.Object>), L, pos);
	}

	private void Push_OnVoidHandler_UnityEngine_Object(IntPtr L, OnVoidHandler<UnityEngine.Object> o)
	{
		ToLua.Push(L, o);
	}

	public LTDescr.EaseTypeDelegate LTDescr_EaseTypeDelegate(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return () => default(Vector3);
		}
		if (!flag)
		{
			LTDescr_EaseTypeDelegate_Event lTDescr_EaseTypeDelegate_Event = new LTDescr_EaseTypeDelegate_Event(func);
			LTDescr.EaseTypeDelegate easeTypeDelegate = lTDescr_EaseTypeDelegate_Event.Call;
			lTDescr_EaseTypeDelegate_Event.method = easeTypeDelegate.Method;
			return easeTypeDelegate;
		}
		LTDescr_EaseTypeDelegate_Event lTDescr_EaseTypeDelegate_Event2 = new LTDescr_EaseTypeDelegate_Event(func, self);
		LTDescr.EaseTypeDelegate easeTypeDelegate2 = lTDescr_EaseTypeDelegate_Event2.CallWithSelf;
		lTDescr_EaseTypeDelegate_Event2.method = easeTypeDelegate2.Method;
		return easeTypeDelegate2;
	}

	private bool Check_LTDescr_EaseTypeDelegate(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(LTDescr.EaseTypeDelegate), L, pos);
	}

	private void Push_LTDescr_EaseTypeDelegate(IntPtr L, LTDescr.EaseTypeDelegate o)
	{
		ToLua.Push(L, o);
	}

	public LTDescr.ActionMethodDelegate LTDescr_ActionMethodDelegate(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			LTDescr_ActionMethodDelegate_Event lTDescr_ActionMethodDelegate_Event = new LTDescr_ActionMethodDelegate_Event(func);
			LTDescr.ActionMethodDelegate actionMethodDelegate = lTDescr_ActionMethodDelegate_Event.Call;
			lTDescr_ActionMethodDelegate_Event.method = actionMethodDelegate.Method;
			return actionMethodDelegate;
		}
		LTDescr_ActionMethodDelegate_Event lTDescr_ActionMethodDelegate_Event2 = new LTDescr_ActionMethodDelegate_Event(func, self);
		LTDescr.ActionMethodDelegate actionMethodDelegate2 = lTDescr_ActionMethodDelegate_Event2.CallWithSelf;
		lTDescr_ActionMethodDelegate_Event2.method = actionMethodDelegate2.Method;
		return actionMethodDelegate2;
	}

	private bool Check_LTDescr_ActionMethodDelegate(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(LTDescr.ActionMethodDelegate), L, pos);
	}

	private void Push_LTDescr_ActionMethodDelegate(IntPtr L, LTDescr.ActionMethodDelegate o)
	{
		ToLua.Push(L, o);
	}

	public LScrollRect.UpdateItems UnityEngine_UI_LScrollRect_UpdateItems(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_UI_LScrollRect_UpdateItems_Event unityEngine_UI_LScrollRect_UpdateItems_Event = new UnityEngine_UI_LScrollRect_UpdateItems_Event(func);
			LScrollRect.UpdateItems updateItems = unityEngine_UI_LScrollRect_UpdateItems_Event.Call;
			unityEngine_UI_LScrollRect_UpdateItems_Event.method = updateItems.Method;
			return updateItems;
		}
		UnityEngine_UI_LScrollRect_UpdateItems_Event unityEngine_UI_LScrollRect_UpdateItems_Event2 = new UnityEngine_UI_LScrollRect_UpdateItems_Event(func, self);
		LScrollRect.UpdateItems updateItems2 = unityEngine_UI_LScrollRect_UpdateItems_Event2.CallWithSelf;
		unityEngine_UI_LScrollRect_UpdateItems_Event2.method = updateItems2.Method;
		return updateItems2;
	}

	private bool Check_UnityEngine_UI_LScrollRect_UpdateItems(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(LScrollRect.UpdateItems), L, pos);
	}

	private void Push_UnityEngine_UI_LScrollRect_UpdateItems(IntPtr L, LScrollRect.UpdateItems o)
	{
		ToLua.Push(L, o);
	}
}
