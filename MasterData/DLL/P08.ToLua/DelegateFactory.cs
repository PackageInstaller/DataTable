using System;
using System.Collections.Generic;
using System.Net.Sockets;
using CriMana;
using LuaInterface;
using RogoDigital.Lipsync;
using Spine;
using Spine.Unity;
using Unity.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.Playables;
using UnityEngine.SceneManagement;
using UnityEngine.U2D;
using UnityEngine.UI;
using UnityEngine.Video;

public class DelegateFactory
{
	public delegate Delegate DelegateCreate(LuaFunction func, LuaTable self, bool flag);

	private class System_Action_Event : LuaDelegate
	{
		public System_Action_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_Event(LuaFunction func, LuaTable self)
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

	private class UnityEngine_Events_UnityAction_Event : LuaDelegate
	{
		public UnityEngine_Events_UnityAction_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Events_UnityAction_Event(LuaFunction func, LuaTable self)
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

	private class System_Predicate_int_Event : LuaDelegate
	{
		public System_Predicate_int_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Predicate_int_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public bool Call(int param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			bool result = func.CheckBoolean();
			func.EndPCall();
			return result;
		}

		public bool CallWithSelf(int param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			bool result = func.CheckBoolean();
			func.EndPCall();
			return result;
		}
	}

	private class System_Action_int_Event : LuaDelegate
	{
		public System_Action_int_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_int_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(int param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(int param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Comparison_int_Event : LuaDelegate
	{
		public System_Comparison_int_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Comparison_int_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public int Call(int param0, int param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			int result = (int)func.CheckNumber();
			func.EndPCall();
			return result;
		}

		public int CallWithSelf(int param0, int param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			int result = (int)func.CheckNumber();
			func.EndPCall();
			return result;
		}
	}

	private class System_Func_int_int_Event : LuaDelegate
	{
		public System_Func_int_int_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Func_int_int_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public int Call(int param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			int result = (int)func.CheckNumber();
			func.EndPCall();
			return result;
		}

		public int CallWithSelf(int param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			int result = (int)func.CheckNumber();
			func.EndPCall();
			return result;
		}
	}

	private class UnityEngine_Camera_CameraCallback_Event : LuaDelegate
	{
		public UnityEngine_Camera_CameraCallback_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Camera_CameraCallback_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Camera param0)
		{
			func.BeginPCall();
			func.PushSealed(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Camera param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushSealed(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Application_AdvertisingIdentifierCallback_Event : LuaDelegate
	{
		public UnityEngine_Application_AdvertisingIdentifierCallback_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Application_AdvertisingIdentifierCallback_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(string param0, bool param1, string param2)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.Push(param2);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(string param0, bool param1, string param2)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.Push(param2);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Application_LowMemoryCallback_Event : LuaDelegate
	{
		public UnityEngine_Application_LowMemoryCallback_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Application_LowMemoryCallback_Event(LuaFunction func, LuaTable self)
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

	private class UnityEngine_Application_LogCallback_Event : LuaDelegate
	{
		public UnityEngine_Application_LogCallback_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Application_LogCallback_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(string param0, string param1, LogType param2)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.Push(param2);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(string param0, string param1, LogType param2)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.Push(param2);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_bool_Event : LuaDelegate
	{
		public System_Action_bool_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_bool_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(bool param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(bool param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_string_Event : LuaDelegate
	{
		public System_Action_string_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_string_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(string param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(string param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Func_bool_Event : LuaDelegate
	{
		public System_Func_bool_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Func_bool_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public bool Call()
		{
			func.BeginPCall();
			func.PCall();
			bool result = func.CheckBoolean();
			func.EndPCall();
			return result;
		}

		public bool CallWithSelf()
		{
			func.BeginPCall();
			func.Push(self);
			func.PCall();
			bool result = func.CheckBoolean();
			func.EndPCall();
			return result;
		}
	}

	private class System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair_Event : LuaDelegate
	{
		public System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(PhysicsScene param0, NativeArray<ModifiableContactPair> param1)
		{
			func.BeginPCall();
			func.PushValue(param0);
			func.PushValue(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(PhysicsScene param0, NativeArray<ModifiableContactPair> param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushValue(param0);
			func.PushValue(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_AudioClip_PCMReaderCallback_Event : LuaDelegate
	{
		public UnityEngine_AudioClip_PCMReaderCallback_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_AudioClip_PCMReaderCallback_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(float[] param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(float[] param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_AudioClip_PCMSetPositionCallback_Event : LuaDelegate
	{
		public UnityEngine_AudioClip_PCMSetPositionCallback_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_AudioClip_PCMSetPositionCallback_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(int param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(int param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_UnityEngine_AsyncOperation_Event : LuaDelegate
	{
		public System_Action_UnityEngine_AsyncOperation_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_UnityEngine_AsyncOperation_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(AsyncOperation param0)
		{
			func.BeginPCall();
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(AsyncOperation param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_UnityEngine_Object_Event : LuaDelegate
	{
		public System_Action_UnityEngine_Object_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_UnityEngine_Object_Event(LuaFunction func, LuaTable self)
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

	private class OnVoidHandler_string_Event : LuaDelegate
	{
		public OnVoidHandler_string_Event(LuaFunction func)
			: base(func)
		{
		}

		public OnVoidHandler_string_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(string param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(string param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class OnVoidHandler_int_Event : LuaDelegate
	{
		public OnVoidHandler_int_Event(LuaFunction func)
			: base(func)
		{
		}

		public OnVoidHandler_int_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(int param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(int param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class OnVoidHandler_object_object_Event : LuaDelegate
	{
		public OnVoidHandler_object_object_Event(LuaFunction func)
			: base(func)
		{
		}

		public OnVoidHandler_object_object_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(object param0, object param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(object param0, object param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class OnVoidHandler_object_Event : LuaDelegate
	{
		public OnVoidHandler_object_Event(LuaFunction func)
			: base(func)
		{
		}

		public OnVoidHandler_object_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(object param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(object param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError_Event : LuaDelegate
	{
		public UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(SocketError param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(SocketError param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Events_UnityAction_string_Event : LuaDelegate
	{
		public UnityEngine_Events_UnityAction_string_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Events_UnityAction_string_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(string param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(string param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_RectTransform_ReapplyDrivenProperties_Event : LuaDelegate
	{
		public UnityEngine_RectTransform_ReapplyDrivenProperties_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_RectTransform_ReapplyDrivenProperties_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(RectTransform param0)
		{
			func.BeginPCall();
			func.PushSealed(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(RectTransform param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushSealed(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Canvas_WillRenderCanvases_Event : LuaDelegate
	{
		public UnityEngine_Canvas_WillRenderCanvases_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Canvas_WillRenderCanvases_Event(LuaFunction func, LuaTable self)
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

	private class UnityEngine_UI_InputField_OnValidateInput_Event : LuaDelegate
	{
		public UnityEngine_UI_InputField_OnValidateInput_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_UI_InputField_OnValidateInput_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public char Call(string param0, int param1, char param2)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.Push(param2);
			func.PCall();
			ushort result = (ushort)func.CheckNumber();
			func.EndPCall();
			return (char)result;
		}

		public char CallWithSelf(string param0, int param1, char param2)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.Push(param2);
			func.PCall();
			ushort result = (ushort)func.CheckNumber();
			func.EndPCall();
			return (char)result;
		}
	}

	private class System_Action_UnityEngine_UI_Image_string_Event : LuaDelegate
	{
		public System_Action_UnityEngine_UI_Image_string_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_UnityEngine_UI_Image_string_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Image param0, string param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Image param0, string param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate_Event : LuaDelegate
	{
		public Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate_Event(LuaFunction func)
			: base(func)
		{
		}

		public Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(SkeletonGraphic param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(SkeletonGraphic param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class Spine_Unity_UpdateBonesDelegate_Event : LuaDelegate
	{
		public Spine_Unity_UpdateBonesDelegate_Event(LuaFunction func)
			: base(func)
		{
		}

		public Spine_Unity_UpdateBonesDelegate_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(ISkeletonAnimation param0)
		{
			func.BeginPCall();
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(ISkeletonAnimation param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class Spine_Unity_MeshGeneratorDelegate_Event : LuaDelegate
	{
		public Spine_Unity_MeshGeneratorDelegate_Event(LuaFunction func)
			: base(func)
		{
		}

		public Spine_Unity_MeshGeneratorDelegate_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(MeshGeneratorBuffers param0)
		{
			func.BeginPCall();
			func.PushValue(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(MeshGeneratorBuffers param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushValue(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class Spine_Unity_SkeletonRenderer_InstructionDelegate_Event : LuaDelegate
	{
		public Spine_Unity_SkeletonRenderer_InstructionDelegate_Event(LuaFunction func)
			: base(func)
		{
		}

		public Spine_Unity_SkeletonRenderer_InstructionDelegate_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(SkeletonRendererInstruction param0)
		{
			func.BeginPCall();
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(SkeletonRendererInstruction param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate_Event : LuaDelegate
	{
		public Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate_Event(LuaFunction func)
			: base(func)
		{
		}

		public Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(SkeletonRenderer param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(SkeletonRenderer param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Func_string_bool_Event : LuaDelegate
	{
		public System_Func_string_bool_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Func_string_bool_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public bool Call(string param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			bool result = func.CheckBoolean();
			func.EndPCall();
			return result;
		}

		public bool CallWithSelf(string param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			bool result = func.CheckBoolean();
			func.EndPCall();
			return result;
		}
	}

	private class Spine_AnimationState_TrackEntryDelegate_Event : LuaDelegate
	{
		public Spine_AnimationState_TrackEntryDelegate_Event(LuaFunction func)
			: base(func)
		{
		}

		public Spine_AnimationState_TrackEntryDelegate_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(TrackEntry param0)
		{
			func.BeginPCall();
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(TrackEntry param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class Spine_AnimationState_TrackEntryEventDelegate_Event : LuaDelegate
	{
		public Spine_AnimationState_TrackEntryEventDelegate_Event(LuaFunction func)
			: base(func)
		{
		}

		public Spine_AnimationState_TrackEntryEventDelegate_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(TrackEntry param0, Event param1)
		{
			func.BeginPCall();
			func.PushObject(param0);
			func.PushObject(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(TrackEntry param0, Event param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushObject(param0);
			func.PushObject(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_object_Event : LuaDelegate
	{
		public System_Action_object_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_object_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(object param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(object param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_float_Event : LuaDelegate
	{
		public System_Action_float_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_float_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(float param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(float param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_float_float_Event : LuaDelegate
	{
		public System_Action_float_float_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_float_float_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(float param0, float param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(float param0, float param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_UnityEngine_Color_Event : LuaDelegate
	{
		public System_Action_UnityEngine_Color_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_UnityEngine_Color_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Color param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Color param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_UnityEngine_Color_object_Event : LuaDelegate
	{
		public System_Action_UnityEngine_Color_object_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_UnityEngine_Color_object_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Color param0, object param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Color param0, object param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_UnityEngine_Vector2_Event : LuaDelegate
	{
		public System_Action_UnityEngine_Vector2_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_UnityEngine_Vector2_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Vector2 param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Vector2 param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_UnityEngine_Vector3_Event : LuaDelegate
	{
		public System_Action_UnityEngine_Vector3_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_UnityEngine_Vector3_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Vector3 param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Vector3 param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_float_object_Event : LuaDelegate
	{
		public System_Action_float_object_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_float_object_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(float param0, object param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(float param0, object param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_UnityEngine_Vector3_object_Event : LuaDelegate
	{
		public System_Action_UnityEngine_Vector3_object_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_UnityEngine_Vector3_object_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Vector3 param0, object param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Vector3 param0, object param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class LuaHelper_ETLCallBack1_Event : LuaDelegate
	{
		public LuaHelper_ETLCallBack1_Event(LuaFunction func)
			: base(func)
		{
		}

		public LuaHelper_ETLCallBack1_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(GameObject param0, PointerEventData param1)
		{
			func.BeginPCall();
			func.PushSealed(param0);
			func.PushObject(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(GameObject param0, PointerEventData param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushSealed(param0);
			func.PushObject(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class LuaHelper_ETLCallBack2_Event : LuaDelegate
	{
		public LuaHelper_ETLCallBack2_Event(LuaFunction func)
			: base(func)
		{
		}

		public LuaHelper_ETLCallBack2_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(GameObject param0, BaseEventData param1)
		{
			func.BeginPCall();
			func.PushSealed(param0);
			func.PushObject(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(GameObject param0, BaseEventData param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushSealed(param0);
			func.PushObject(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class LuaHelper_ETLCallBack3_Event : LuaDelegate
	{
		public LuaHelper_ETLCallBack3_Event(LuaFunction func)
			: base(func)
		{
		}

		public LuaHelper_ETLCallBack3_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(GameObject param0, AxisEventData param1)
		{
			func.BeginPCall();
			func.PushSealed(param0);
			func.PushObject(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(GameObject param0, AxisEventData param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushSealed(param0);
			func.PushObject(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_UnityEngine_Vector3_int_Event : LuaDelegate
	{
		public System_Action_UnityEngine_Vector3_int_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_UnityEngine_Vector3_int_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Vector3 param0, int param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Vector3 param0, int param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Func_UnityEngine_Vector3_bool_Event : LuaDelegate
	{
		public System_Func_UnityEngine_Vector3_bool_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Func_UnityEngine_Vector3_bool_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public bool Call(Vector3 param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			bool result = func.CheckBoolean();
			func.EndPCall();
			return result;
		}

		public bool CallWithSelf(Vector3 param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			bool result = func.CheckBoolean();
			func.EndPCall();
			return result;
		}
	}

	private class UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer_Event : LuaDelegate
	{
		public UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(SpriteRenderer param0)
		{
			func.BeginPCall();
			func.PushSealed(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(SpriteRenderer param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushSealed(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Video_VideoPlayer_EventHandler_Event : LuaDelegate
	{
		public UnityEngine_Video_VideoPlayer_EventHandler_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Video_VideoPlayer_EventHandler_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(VideoPlayer param0)
		{
			func.BeginPCall();
			func.PushSealed(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(VideoPlayer param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushSealed(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Video_VideoPlayer_ErrorEventHandler_Event : LuaDelegate
	{
		public UnityEngine_Video_VideoPlayer_ErrorEventHandler_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Video_VideoPlayer_ErrorEventHandler_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(VideoPlayer param0, string param1)
		{
			func.BeginPCall();
			func.PushSealed(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(VideoPlayer param0, string param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushSealed(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Video_VideoPlayer_TimeEventHandler_Event : LuaDelegate
	{
		public UnityEngine_Video_VideoPlayer_TimeEventHandler_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Video_VideoPlayer_TimeEventHandler_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(VideoPlayer param0, double param1)
		{
			func.BeginPCall();
			func.PushSealed(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(VideoPlayer param0, double param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushSealed(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Video_VideoPlayer_FrameReadyEventHandler_Event : LuaDelegate
	{
		public UnityEngine_Video_VideoPlayer_FrameReadyEventHandler_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Video_VideoPlayer_FrameReadyEventHandler_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(VideoPlayer param0, long param1)
		{
			func.BeginPCall();
			func.PushSealed(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(VideoPlayer param0, long param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushSealed(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_UnityEngine_Playables_PlayableDirector_Event : LuaDelegate
	{
		public System_Action_UnityEngine_Playables_PlayableDirector_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_UnityEngine_Playables_PlayableDirector_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(PlayableDirector param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(PlayableDirector param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData_Event : LuaDelegate
	{
		public UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(BaseEventData param0)
		{
			func.BeginPCall();
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(BaseEventData param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Events_UnityAction_bool_Event : LuaDelegate
	{
		public UnityEngine_Events_UnityAction_bool_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Events_UnityAction_bool_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(bool param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(bool param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Events_UnityAction_int_Event : LuaDelegate
	{
		public UnityEngine_Events_UnityAction_int_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Events_UnityAction_int_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(int param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(int param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Events_UnityAction_float_Event : LuaDelegate
	{
		public UnityEngine_Events_UnityAction_float_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Events_UnityAction_float_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(float param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(float param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Events_UnityAction_UnityEngine_Vector2_Event : LuaDelegate
	{
		public UnityEngine_Events_UnityAction_UnityEngine_Vector2_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Events_UnityAction_UnityEngine_Vector2_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Vector2 param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Vector2 param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Func_UnityEngine_UI_ILayoutElement_float_Event : LuaDelegate
	{
		public System_Func_UnityEngine_UI_ILayoutElement_float_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Func_UnityEngine_UI_ILayoutElement_float_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public float Call(ILayoutElement param0)
		{
			func.BeginPCall();
			func.PushObject(param0);
			func.PCall();
			float result = (float)func.CheckNumber();
			func.EndPCall();
			return result;
		}

		public float CallWithSelf(ILayoutElement param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushObject(param0);
			func.PCall();
			float result = (float)func.CheckNumber();
			func.EndPCall();
			return result;
		}
	}

	private class UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode_Event : LuaDelegate
	{
		public UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Scene param0, LoadSceneMode param1)
		{
			func.BeginPCall();
			func.PushValue(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Scene param0, LoadSceneMode param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushValue(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_Event : LuaDelegate
	{
		public UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Scene param0)
		{
			func.BeginPCall();
			func.PushValue(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Scene param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushValue(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene_Event : LuaDelegate
	{
		public UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Scene param0, Scene param1)
		{
			func.BeginPCall();
			func.PushValue(param0);
			func.PushValue(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Scene param0, Scene param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushValue(param0);
			func.PushValue(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Events_UnityAction_DownloadRequest_Event : LuaDelegate
	{
		public UnityEngine_Events_UnityAction_DownloadRequest_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Events_UnityAction_DownloadRequest_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(DownloadRequest param0)
		{
			func.BeginPCall();
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(DownloadRequest param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class OnVoidHandler_UnityEngine_Sprite_Event : LuaDelegate
	{
		public OnVoidHandler_UnityEngine_Sprite_Event(LuaFunction func)
			: base(func)
		{
		}

		public OnVoidHandler_UnityEngine_Sprite_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Sprite param0)
		{
			func.BeginPCall();
			func.PushSealed(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Sprite param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushSealed(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_string_string_Event : LuaDelegate
	{
		public System_Action_string_string_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_string_string_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(string param0, string param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(string param0, string param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_UnityEngine_U2D_SpriteAtlas_Event : LuaDelegate
	{
		public System_Action_UnityEngine_U2D_SpriteAtlas_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_UnityEngine_U2D_SpriteAtlas_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(SpriteAtlas param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(SpriteAtlas param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_bool_string_Event : LuaDelegate
	{
		public System_Action_bool_string_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_bool_string_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(bool param0, string param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(bool param0, string param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_int_string_string_int_Event : LuaDelegate
	{
		public System_Action_int_string_string_int_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_int_string_string_int_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(int param0, string param1, string param2, int param3)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.Push(param2);
			func.Push(param3);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(int param0, string param1, string param2, int param3)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.Push(param2);
			func.Push(param3);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_LoadingUIType_Event : LuaDelegate
	{
		public System_Action_LoadingUIType_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_LoadingUIType_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(LoadingUIType param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(LoadingUIType param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class UnityEngine_Events_UnityAction_UnityEngine_Sprite_Event : LuaDelegate
	{
		public UnityEngine_Events_UnityAction_UnityEngine_Sprite_Event(LuaFunction func)
			: base(func)
		{
		}

		public UnityEngine_Events_UnityAction_UnityEngine_Sprite_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Sprite param0)
		{
			func.BeginPCall();
			func.PushSealed(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Sprite param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushSealed(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_strings_strings_Event : LuaDelegate
	{
		public System_Action_strings_strings_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_strings_strings_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(string[] param0, string[] param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(string[] param0, string[] param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_int_UnityEngine_GameObject_Event : LuaDelegate
	{
		public System_Action_int_UnityEngine_GameObject_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_int_UnityEngine_GameObject_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(int param0, GameObject param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PushSealed(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(int param0, GameObject param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PushSealed(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_int_int_Event : LuaDelegate
	{
		public System_Action_int_int_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_int_int_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(int param0, int param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(int param0, int param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_int_int_string_string_Event : LuaDelegate
	{
		public System_Action_int_int_string_string_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_int_int_string_string_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(int param0, int param1, string param2, string param3)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.Push(param2);
			func.Push(param3);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(int param0, int param1, string param2, string param3)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.Push(param2);
			func.Push(param3);
			func.PCall();
			func.EndPCall();
		}
	}

	private class CriManaMovieMaterial_OnApplicationPauseCallback_Event : LuaDelegate
	{
		public CriManaMovieMaterial_OnApplicationPauseCallback_Event(LuaFunction func)
			: base(func)
		{
		}

		public CriManaMovieMaterial_OnApplicationPauseCallback_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(CriManaMovieMaterialBase param0, bool param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(CriManaMovieMaterialBase param0, bool param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class CriMana_Player_CuePointCallback_Event : LuaDelegate
	{
		public CriMana_Player_CuePointCallback_Event(LuaFunction func)
			: base(func)
		{
		}

		public CriMana_Player_CuePointCallback_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(ref EventPoint param0)
		{
			func.BeginPCall();
			func.PushSealed(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(ref EventPoint param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushSealed(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class CriMana_Player_StatusChangeCallback_Event : LuaDelegate
	{
		public CriMana_Player_StatusChangeCallback_Event(LuaFunction func)
			: base(func)
		{
		}

		public CriMana_Player_StatusChangeCallback_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(Player.Status param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(Player.Status param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class CriMana_Player_SubtitleChangeCallback_Event : LuaDelegate
	{
		public CriMana_Player_SubtitleChangeCallback_Event(LuaFunction func)
			: base(func)
		{
		}

		public CriMana_Player_SubtitleChangeCallback_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(IntPtr param0)
		{
			func.BeginPCall();
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(IntPtr param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	private class CriMana_Player_ShaderDispatchCallback_Event : LuaDelegate
	{
		public CriMana_Player_ShaderDispatchCallback_Event(LuaFunction func)
			: base(func)
		{
		}

		public CriMana_Player_ShaderDispatchCallback_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public Shader Call(MovieInfo param0, bool param1)
		{
			func.BeginPCall();
			func.PushObject(param0);
			func.Push(param1);
			func.PCall();
			Shader result = (Shader)func.CheckObject(typeof(Shader));
			func.EndPCall();
			return result;
		}

		public Shader CallWithSelf(MovieInfo param0, bool param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushObject(param0);
			func.Push(param1);
			func.PCall();
			Shader result = (Shader)func.CheckObject(typeof(Shader));
			func.EndPCall();
			return result;
		}
	}

	private class RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate_Event : LuaDelegate
	{
		public RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate_Event(LuaFunction func)
			: base(func)
		{
		}

		public RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate_Event(LuaFunction func, LuaTable self)
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

	private class RogoDigital_Lipsync_LipSync_ResetDelegate_Event : LuaDelegate
	{
		public RogoDigital_Lipsync_LipSync_ResetDelegate_Event(LuaFunction func)
			: base(func)
		{
		}

		public RogoDigital_Lipsync_LipSync_ResetDelegate_Event(LuaFunction func, LuaTable self)
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

	private class System_Action_int_int_UnityEngine_Transform_Event : LuaDelegate
	{
		public System_Action_int_int_UnityEngine_Transform_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_int_int_UnityEngine_Transform_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(int param0, int param1, Transform param2)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.Push(param2);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(int param0, int param1, Transform param2)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.Push(param2);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_long_int_int_Event : LuaDelegate
	{
		public System_Action_long_int_int_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_long_int_int_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(long param0, int param1, int param2)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.Push(param2);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(long param0, int param1, int param2)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.Push(param2);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_long_int_Event : LuaDelegate
	{
		public System_Action_long_int_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_long_int_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(long param0, int param1)
		{
			func.BeginPCall();
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(long param0, int param1)
		{
			func.BeginPCall();
			func.Push(self);
			func.Push(param0);
			func.Push(param1);
			func.PCall();
			func.EndPCall();
		}
	}

	private class System_Action_UnityEngine_EventSystems_PointerEventData_Event : LuaDelegate
	{
		public System_Action_UnityEngine_EventSystems_PointerEventData_Event(LuaFunction func)
			: base(func)
		{
		}

		public System_Action_UnityEngine_EventSystems_PointerEventData_Event(LuaFunction func, LuaTable self)
			: base(func, self)
		{
		}

		public void Call(PointerEventData param0)
		{
			func.BeginPCall();
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}

		public void CallWithSelf(PointerEventData param0)
		{
			func.BeginPCall();
			func.Push(self);
			func.PushObject(param0);
			func.PCall();
			func.EndPCall();
		}
	}

	public static Dictionary<Type, DelegateCreate> dict = new Dictionary<Type, DelegateCreate>();

	private static DelegateFactory factory = new DelegateFactory();

	public static void Init()
	{
		Register();
	}

	public static void Register()
	{
		dict.Clear();
		dict.Add(typeof(Action), factory.System_Action);
		dict.Add(typeof(UnityAction), factory.UnityEngine_Events_UnityAction);
		dict.Add(typeof(Predicate<int>), factory.System_Predicate_int);
		dict.Add(typeof(Action<int>), factory.System_Action_int);
		dict.Add(typeof(Comparison<int>), factory.System_Comparison_int);
		dict.Add(typeof(Func<int, int>), factory.System_Func_int_int);
		dict.Add(typeof(Camera.CameraCallback), factory.UnityEngine_Camera_CameraCallback);
		dict.Add(typeof(Application.AdvertisingIdentifierCallback), factory.UnityEngine_Application_AdvertisingIdentifierCallback);
		dict.Add(typeof(Application.LowMemoryCallback), factory.UnityEngine_Application_LowMemoryCallback);
		dict.Add(typeof(Application.LogCallback), factory.UnityEngine_Application_LogCallback);
		dict.Add(typeof(Action<bool>), factory.System_Action_bool);
		dict.Add(typeof(Action<string>), factory.System_Action_string);
		dict.Add(typeof(Func<bool>), factory.System_Func_bool);
		dict.Add(typeof(Action<PhysicsScene, NativeArray<ModifiableContactPair>>), factory.System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair);
		dict.Add(typeof(AudioClip.PCMReaderCallback), factory.UnityEngine_AudioClip_PCMReaderCallback);
		dict.Add(typeof(AudioClip.PCMSetPositionCallback), factory.UnityEngine_AudioClip_PCMSetPositionCallback);
		dict.Add(typeof(Action<AsyncOperation>), factory.System_Action_UnityEngine_AsyncOperation);
		dict.Add(typeof(Action<UnityEngine.Object>), factory.System_Action_UnityEngine_Object);
		dict.Add(typeof(OnVoidHandler<string>), factory.OnVoidHandler_string);
		dict.Add(typeof(OnVoidHandler<int>), factory.OnVoidHandler_int);
		dict.Add(typeof(OnVoidHandler<object, object>), factory.OnVoidHandler_object_object);
		dict.Add(typeof(OnVoidHandler<object>), factory.OnVoidHandler_object);
		dict.Add(typeof(UnityAction<SocketError>), factory.UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError);
		dict.Add(typeof(UnityAction<string>), factory.UnityEngine_Events_UnityAction_string);
		dict.Add(typeof(RectTransform.ReapplyDrivenProperties), factory.UnityEngine_RectTransform_ReapplyDrivenProperties);
		dict.Add(typeof(Canvas.WillRenderCanvases), factory.UnityEngine_Canvas_WillRenderCanvases);
		dict.Add(typeof(InputField.OnValidateInput), factory.UnityEngine_UI_InputField_OnValidateInput);
		dict.Add(typeof(Action<Image, string>), factory.System_Action_UnityEngine_UI_Image_string);
		dict.Add(typeof(SkeletonGraphic.SkeletonRendererDelegate), factory.Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate);
		dict.Add(typeof(UpdateBonesDelegate), factory.Spine_Unity_UpdateBonesDelegate);
		dict.Add(typeof(MeshGeneratorDelegate), factory.Spine_Unity_MeshGeneratorDelegate);
		dict.Add(typeof(SkeletonRenderer.InstructionDelegate), factory.Spine_Unity_SkeletonRenderer_InstructionDelegate);
		dict.Add(typeof(SkeletonRenderer.SkeletonRendererDelegate), factory.Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate);
		dict.Add(typeof(Func<string, bool>), factory.System_Func_string_bool);
		dict.Add(typeof(AnimationState.TrackEntryDelegate), factory.Spine_AnimationState_TrackEntryDelegate);
		dict.Add(typeof(AnimationState.TrackEntryEventDelegate), factory.Spine_AnimationState_TrackEntryEventDelegate);
		dict.Add(typeof(Action<object>), factory.System_Action_object);
		dict.Add(typeof(Action<float>), factory.System_Action_float);
		dict.Add(typeof(Action<float, float>), factory.System_Action_float_float);
		dict.Add(typeof(Action<Color>), factory.System_Action_UnityEngine_Color);
		dict.Add(typeof(Action<Color, object>), factory.System_Action_UnityEngine_Color_object);
		dict.Add(typeof(Action<Vector2>), factory.System_Action_UnityEngine_Vector2);
		dict.Add(typeof(Action<Vector3>), factory.System_Action_UnityEngine_Vector3);
		dict.Add(typeof(Action<float, object>), factory.System_Action_float_object);
		dict.Add(typeof(Action<Vector3, object>), factory.System_Action_UnityEngine_Vector3_object);
		dict.Add(typeof(LuaHelper.ETLCallBack1), factory.LuaHelper_ETLCallBack1);
		dict.Add(typeof(LuaHelper.ETLCallBack2), factory.LuaHelper_ETLCallBack2);
		dict.Add(typeof(LuaHelper.ETLCallBack3), factory.LuaHelper_ETLCallBack3);
		dict.Add(typeof(Action<Vector3, int>), factory.System_Action_UnityEngine_Vector3_int);
		dict.Add(typeof(Func<Vector3, bool>), factory.System_Func_UnityEngine_Vector3_bool);
		dict.Add(typeof(UnityAction<SpriteRenderer>), factory.UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer);
		dict.Add(typeof(VideoPlayer.EventHandler), factory.UnityEngine_Video_VideoPlayer_EventHandler);
		dict.Add(typeof(VideoPlayer.ErrorEventHandler), factory.UnityEngine_Video_VideoPlayer_ErrorEventHandler);
		dict.Add(typeof(VideoPlayer.TimeEventHandler), factory.UnityEngine_Video_VideoPlayer_TimeEventHandler);
		dict.Add(typeof(VideoPlayer.FrameReadyEventHandler), factory.UnityEngine_Video_VideoPlayer_FrameReadyEventHandler);
		dict.Add(typeof(Action<PlayableDirector>), factory.System_Action_UnityEngine_Playables_PlayableDirector);
		dict.Add(typeof(UnityAction<BaseEventData>), factory.UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData);
		dict.Add(typeof(UnityAction<bool>), factory.UnityEngine_Events_UnityAction_bool);
		dict.Add(typeof(UnityAction<int>), factory.UnityEngine_Events_UnityAction_int);
		dict.Add(typeof(UnityAction<float>), factory.UnityEngine_Events_UnityAction_float);
		dict.Add(typeof(UnityAction<Vector2>), factory.UnityEngine_Events_UnityAction_UnityEngine_Vector2);
		dict.Add(typeof(Func<ILayoutElement, float>), factory.System_Func_UnityEngine_UI_ILayoutElement_float);
		dict.Add(typeof(UnityAction<Scene, LoadSceneMode>), factory.UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode);
		dict.Add(typeof(UnityAction<Scene>), factory.UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene);
		dict.Add(typeof(UnityAction<Scene, Scene>), factory.UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene);
		dict.Add(typeof(UnityAction<DownloadRequest>), factory.UnityEngine_Events_UnityAction_DownloadRequest);
		dict.Add(typeof(OnVoidHandler<Sprite>), factory.OnVoidHandler_UnityEngine_Sprite);
		dict.Add(typeof(Action<string, string>), factory.System_Action_string_string);
		dict.Add(typeof(Action<SpriteAtlas>), factory.System_Action_UnityEngine_U2D_SpriteAtlas);
		dict.Add(typeof(Action<bool, string>), factory.System_Action_bool_string);
		dict.Add(typeof(Action<int, string, string, int>), factory.System_Action_int_string_string_int);
		dict.Add(typeof(Action<LoadingUIType>), factory.System_Action_LoadingUIType);
		dict.Add(typeof(UnityAction<Sprite>), factory.UnityEngine_Events_UnityAction_UnityEngine_Sprite);
		dict.Add(typeof(Action<string[], string[]>), factory.System_Action_strings_strings);
		dict.Add(typeof(Action<int, GameObject>), factory.System_Action_int_UnityEngine_GameObject);
		dict.Add(typeof(Action<int, int>), factory.System_Action_int_int);
		dict.Add(typeof(Action<int, int, string, string>), factory.System_Action_int_int_string_string);
		dict.Add(typeof(CriManaMovieMaterialBase.OnApplicationPauseCallback), factory.CriManaMovieMaterial_OnApplicationPauseCallback);
		dict.Add(typeof(Player.CuePointCallback), factory.CriMana_Player_CuePointCallback);
		dict.Add(typeof(Player.StatusChangeCallback), factory.CriMana_Player_StatusChangeCallback);
		dict.Add(typeof(Player.SubtitleChangeCallback), factory.CriMana_Player_SubtitleChangeCallback);
		dict.Add(typeof(Player.ShaderDispatchCallback), factory.CriMana_Player_ShaderDispatchCallback);
		dict.Add(typeof(BlendSystem.BlendSystemGenericDelegate), factory.RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate);
		dict.Add(typeof(LipSync.ResetDelegate), factory.RogoDigital_Lipsync_LipSync_ResetDelegate);
		dict.Add(typeof(Action<int, int, Transform>), factory.System_Action_int_int_UnityEngine_Transform);
		dict.Add(typeof(Action<long, int, int>), factory.System_Action_long_int_int);
		dict.Add(typeof(Action<long, int>), factory.System_Action_long_int);
		DelegateTraits<Action>.Init(factory.System_Action);
		DelegateTraits<UnityAction>.Init(factory.UnityEngine_Events_UnityAction);
		DelegateTraits<Predicate<int>>.Init(factory.System_Predicate_int);
		DelegateTraits<Action<int>>.Init(factory.System_Action_int);
		DelegateTraits<Comparison<int>>.Init(factory.System_Comparison_int);
		DelegateTraits<Func<int, int>>.Init(factory.System_Func_int_int);
		DelegateTraits<Camera.CameraCallback>.Init(factory.UnityEngine_Camera_CameraCallback);
		DelegateTraits<Application.AdvertisingIdentifierCallback>.Init(factory.UnityEngine_Application_AdvertisingIdentifierCallback);
		DelegateTraits<Application.LowMemoryCallback>.Init(factory.UnityEngine_Application_LowMemoryCallback);
		DelegateTraits<Application.LogCallback>.Init(factory.UnityEngine_Application_LogCallback);
		DelegateTraits<Action<bool>>.Init(factory.System_Action_bool);
		DelegateTraits<Action<string>>.Init(factory.System_Action_string);
		DelegateTraits<Func<bool>>.Init(factory.System_Func_bool);
		DelegateTraits<Action<PhysicsScene, NativeArray<ModifiableContactPair>>>.Init(factory.System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair);
		DelegateTraits<AudioClip.PCMReaderCallback>.Init(factory.UnityEngine_AudioClip_PCMReaderCallback);
		DelegateTraits<AudioClip.PCMSetPositionCallback>.Init(factory.UnityEngine_AudioClip_PCMSetPositionCallback);
		DelegateTraits<Action<AsyncOperation>>.Init(factory.System_Action_UnityEngine_AsyncOperation);
		DelegateTraits<Action<UnityEngine.Object>>.Init(factory.System_Action_UnityEngine_Object);
		DelegateTraits<OnVoidHandler<string>>.Init(factory.OnVoidHandler_string);
		DelegateTraits<OnVoidHandler<int>>.Init(factory.OnVoidHandler_int);
		DelegateTraits<OnVoidHandler<object, object>>.Init(factory.OnVoidHandler_object_object);
		DelegateTraits<OnVoidHandler<object>>.Init(factory.OnVoidHandler_object);
		DelegateTraits<UnityAction<SocketError>>.Init(factory.UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError);
		DelegateTraits<UnityAction<string>>.Init(factory.UnityEngine_Events_UnityAction_string);
		DelegateTraits<RectTransform.ReapplyDrivenProperties>.Init(factory.UnityEngine_RectTransform_ReapplyDrivenProperties);
		DelegateTraits<Canvas.WillRenderCanvases>.Init(factory.UnityEngine_Canvas_WillRenderCanvases);
		DelegateTraits<InputField.OnValidateInput>.Init(factory.UnityEngine_UI_InputField_OnValidateInput);
		DelegateTraits<Action<Image, string>>.Init(factory.System_Action_UnityEngine_UI_Image_string);
		DelegateTraits<SkeletonGraphic.SkeletonRendererDelegate>.Init(factory.Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate);
		DelegateTraits<UpdateBonesDelegate>.Init(factory.Spine_Unity_UpdateBonesDelegate);
		DelegateTraits<MeshGeneratorDelegate>.Init(factory.Spine_Unity_MeshGeneratorDelegate);
		DelegateTraits<SkeletonRenderer.InstructionDelegate>.Init(factory.Spine_Unity_SkeletonRenderer_InstructionDelegate);
		DelegateTraits<SkeletonRenderer.SkeletonRendererDelegate>.Init(factory.Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate);
		DelegateTraits<Func<string, bool>>.Init(factory.System_Func_string_bool);
		DelegateTraits<AnimationState.TrackEntryDelegate>.Init(factory.Spine_AnimationState_TrackEntryDelegate);
		DelegateTraits<AnimationState.TrackEntryEventDelegate>.Init(factory.Spine_AnimationState_TrackEntryEventDelegate);
		DelegateTraits<Action<object>>.Init(factory.System_Action_object);
		DelegateTraits<Action<float>>.Init(factory.System_Action_float);
		DelegateTraits<Action<float, float>>.Init(factory.System_Action_float_float);
		DelegateTraits<Action<Color>>.Init(factory.System_Action_UnityEngine_Color);
		DelegateTraits<Action<Color, object>>.Init(factory.System_Action_UnityEngine_Color_object);
		DelegateTraits<Action<Vector2>>.Init(factory.System_Action_UnityEngine_Vector2);
		DelegateTraits<Action<Vector3>>.Init(factory.System_Action_UnityEngine_Vector3);
		DelegateTraits<Action<float, object>>.Init(factory.System_Action_float_object);
		DelegateTraits<Action<Vector3, object>>.Init(factory.System_Action_UnityEngine_Vector3_object);
		DelegateTraits<LuaHelper.ETLCallBack1>.Init(factory.LuaHelper_ETLCallBack1);
		DelegateTraits<LuaHelper.ETLCallBack2>.Init(factory.LuaHelper_ETLCallBack2);
		DelegateTraits<LuaHelper.ETLCallBack3>.Init(factory.LuaHelper_ETLCallBack3);
		DelegateTraits<Action<Vector3, int>>.Init(factory.System_Action_UnityEngine_Vector3_int);
		DelegateTraits<Func<Vector3, bool>>.Init(factory.System_Func_UnityEngine_Vector3_bool);
		DelegateTraits<UnityAction<SpriteRenderer>>.Init(factory.UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer);
		DelegateTraits<VideoPlayer.EventHandler>.Init(factory.UnityEngine_Video_VideoPlayer_EventHandler);
		DelegateTraits<VideoPlayer.ErrorEventHandler>.Init(factory.UnityEngine_Video_VideoPlayer_ErrorEventHandler);
		DelegateTraits<VideoPlayer.TimeEventHandler>.Init(factory.UnityEngine_Video_VideoPlayer_TimeEventHandler);
		DelegateTraits<VideoPlayer.FrameReadyEventHandler>.Init(factory.UnityEngine_Video_VideoPlayer_FrameReadyEventHandler);
		DelegateTraits<Action<PlayableDirector>>.Init(factory.System_Action_UnityEngine_Playables_PlayableDirector);
		DelegateTraits<UnityAction<BaseEventData>>.Init(factory.UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData);
		DelegateTraits<UnityAction<bool>>.Init(factory.UnityEngine_Events_UnityAction_bool);
		DelegateTraits<UnityAction<int>>.Init(factory.UnityEngine_Events_UnityAction_int);
		DelegateTraits<UnityAction<float>>.Init(factory.UnityEngine_Events_UnityAction_float);
		DelegateTraits<UnityAction<Vector2>>.Init(factory.UnityEngine_Events_UnityAction_UnityEngine_Vector2);
		DelegateTraits<Func<ILayoutElement, float>>.Init(factory.System_Func_UnityEngine_UI_ILayoutElement_float);
		DelegateTraits<UnityAction<Scene, LoadSceneMode>>.Init(factory.UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode);
		DelegateTraits<UnityAction<Scene>>.Init(factory.UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene);
		DelegateTraits<UnityAction<Scene, Scene>>.Init(factory.UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene);
		DelegateTraits<UnityAction<DownloadRequest>>.Init(factory.UnityEngine_Events_UnityAction_DownloadRequest);
		DelegateTraits<OnVoidHandler<Sprite>>.Init(factory.OnVoidHandler_UnityEngine_Sprite);
		DelegateTraits<Action<string, string>>.Init(factory.System_Action_string_string);
		DelegateTraits<Action<SpriteAtlas>>.Init(factory.System_Action_UnityEngine_U2D_SpriteAtlas);
		DelegateTraits<Action<bool, string>>.Init(factory.System_Action_bool_string);
		DelegateTraits<Action<int, string, string, int>>.Init(factory.System_Action_int_string_string_int);
		DelegateTraits<Action<LoadingUIType>>.Init(factory.System_Action_LoadingUIType);
		DelegateTraits<UnityAction<Sprite>>.Init(factory.UnityEngine_Events_UnityAction_UnityEngine_Sprite);
		DelegateTraits<Action<string[], string[]>>.Init(factory.System_Action_strings_strings);
		DelegateTraits<Action<int, GameObject>>.Init(factory.System_Action_int_UnityEngine_GameObject);
		DelegateTraits<Action<int, int>>.Init(factory.System_Action_int_int);
		DelegateTraits<Action<int, int, string, string>>.Init(factory.System_Action_int_int_string_string);
		DelegateTraits<CriManaMovieMaterialBase.OnApplicationPauseCallback>.Init(factory.CriManaMovieMaterial_OnApplicationPauseCallback);
		DelegateTraits<Player.CuePointCallback>.Init(factory.CriMana_Player_CuePointCallback);
		DelegateTraits<Player.StatusChangeCallback>.Init(factory.CriMana_Player_StatusChangeCallback);
		DelegateTraits<Player.SubtitleChangeCallback>.Init(factory.CriMana_Player_SubtitleChangeCallback);
		DelegateTraits<Player.ShaderDispatchCallback>.Init(factory.CriMana_Player_ShaderDispatchCallback);
		DelegateTraits<BlendSystem.BlendSystemGenericDelegate>.Init(factory.RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate);
		DelegateTraits<LipSync.ResetDelegate>.Init(factory.RogoDigital_Lipsync_LipSync_ResetDelegate);
		DelegateTraits<Action<int, int, Transform>>.Init(factory.System_Action_int_int_UnityEngine_Transform);
		DelegateTraits<Action<long, int, int>>.Init(factory.System_Action_long_int_int);
		DelegateTraits<Action<long, int>>.Init(factory.System_Action_long_int);
		DelegateTraits<Action<PointerEventData>>.Init(factory.System_Action_UnityEngine_EventSystems_PointerEventData);
		TypeTraits<Action>.Init(factory.Check_System_Action);
		TypeTraits<UnityAction>.Init(factory.Check_UnityEngine_Events_UnityAction);
		TypeTraits<Predicate<int>>.Init(factory.Check_System_Predicate_int);
		TypeTraits<Action<int>>.Init(factory.Check_System_Action_int);
		TypeTraits<Comparison<int>>.Init(factory.Check_System_Comparison_int);
		TypeTraits<Func<int, int>>.Init(factory.Check_System_Func_int_int);
		TypeTraits<Camera.CameraCallback>.Init(factory.Check_UnityEngine_Camera_CameraCallback);
		TypeTraits<Application.AdvertisingIdentifierCallback>.Init(factory.Check_UnityEngine_Application_AdvertisingIdentifierCallback);
		TypeTraits<Application.LowMemoryCallback>.Init(factory.Check_UnityEngine_Application_LowMemoryCallback);
		TypeTraits<Application.LogCallback>.Init(factory.Check_UnityEngine_Application_LogCallback);
		TypeTraits<Action<bool>>.Init(factory.Check_System_Action_bool);
		TypeTraits<Action<string>>.Init(factory.Check_System_Action_string);
		TypeTraits<Func<bool>>.Init(factory.Check_System_Func_bool);
		TypeTraits<Action<PhysicsScene, NativeArray<ModifiableContactPair>>>.Init(factory.Check_System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair);
		TypeTraits<AudioClip.PCMReaderCallback>.Init(factory.Check_UnityEngine_AudioClip_PCMReaderCallback);
		TypeTraits<AudioClip.PCMSetPositionCallback>.Init(factory.Check_UnityEngine_AudioClip_PCMSetPositionCallback);
		TypeTraits<Action<AsyncOperation>>.Init(factory.Check_System_Action_UnityEngine_AsyncOperation);
		TypeTraits<Action<UnityEngine.Object>>.Init(factory.Check_System_Action_UnityEngine_Object);
		TypeTraits<OnVoidHandler<string>>.Init(factory.Check_OnVoidHandler_string);
		TypeTraits<OnVoidHandler<int>>.Init(factory.Check_OnVoidHandler_int);
		TypeTraits<OnVoidHandler<object, object>>.Init(factory.Check_OnVoidHandler_object_object);
		TypeTraits<OnVoidHandler<object>>.Init(factory.Check_OnVoidHandler_object);
		TypeTraits<UnityAction<SocketError>>.Init(factory.Check_UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError);
		TypeTraits<UnityAction<string>>.Init(factory.Check_UnityEngine_Events_UnityAction_string);
		TypeTraits<RectTransform.ReapplyDrivenProperties>.Init(factory.Check_UnityEngine_RectTransform_ReapplyDrivenProperties);
		TypeTraits<Canvas.WillRenderCanvases>.Init(factory.Check_UnityEngine_Canvas_WillRenderCanvases);
		TypeTraits<InputField.OnValidateInput>.Init(factory.Check_UnityEngine_UI_InputField_OnValidateInput);
		TypeTraits<Action<Image, string>>.Init(factory.Check_System_Action_UnityEngine_UI_Image_string);
		TypeTraits<SkeletonGraphic.SkeletonRendererDelegate>.Init(factory.Check_Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate);
		TypeTraits<UpdateBonesDelegate>.Init(factory.Check_Spine_Unity_UpdateBonesDelegate);
		TypeTraits<MeshGeneratorDelegate>.Init(factory.Check_Spine_Unity_MeshGeneratorDelegate);
		TypeTraits<SkeletonRenderer.InstructionDelegate>.Init(factory.Check_Spine_Unity_SkeletonRenderer_InstructionDelegate);
		TypeTraits<SkeletonRenderer.SkeletonRendererDelegate>.Init(factory.Check_Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate);
		TypeTraits<Func<string, bool>>.Init(factory.Check_System_Func_string_bool);
		TypeTraits<AnimationState.TrackEntryDelegate>.Init(factory.Check_Spine_AnimationState_TrackEntryDelegate);
		TypeTraits<AnimationState.TrackEntryEventDelegate>.Init(factory.Check_Spine_AnimationState_TrackEntryEventDelegate);
		TypeTraits<Action<object>>.Init(factory.Check_System_Action_object);
		TypeTraits<Action<float>>.Init(factory.Check_System_Action_float);
		TypeTraits<Action<float, float>>.Init(factory.Check_System_Action_float_float);
		TypeTraits<Action<Color>>.Init(factory.Check_System_Action_UnityEngine_Color);
		TypeTraits<Action<Color, object>>.Init(factory.Check_System_Action_UnityEngine_Color_object);
		TypeTraits<Action<Vector2>>.Init(factory.Check_System_Action_UnityEngine_Vector2);
		TypeTraits<Action<Vector3>>.Init(factory.Check_System_Action_UnityEngine_Vector3);
		TypeTraits<Action<float, object>>.Init(factory.Check_System_Action_float_object);
		TypeTraits<Action<Vector3, object>>.Init(factory.Check_System_Action_UnityEngine_Vector3_object);
		TypeTraits<LuaHelper.ETLCallBack1>.Init(factory.Check_LuaHelper_ETLCallBack1);
		TypeTraits<LuaHelper.ETLCallBack2>.Init(factory.Check_LuaHelper_ETLCallBack2);
		TypeTraits<LuaHelper.ETLCallBack3>.Init(factory.Check_LuaHelper_ETLCallBack3);
		TypeTraits<Action<Vector3, int>>.Init(factory.Check_System_Action_UnityEngine_Vector3_int);
		TypeTraits<Func<Vector3, bool>>.Init(factory.Check_System_Func_UnityEngine_Vector3_bool);
		TypeTraits<UnityAction<SpriteRenderer>>.Init(factory.Check_UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer);
		TypeTraits<VideoPlayer.EventHandler>.Init(factory.Check_UnityEngine_Video_VideoPlayer_EventHandler);
		TypeTraits<VideoPlayer.ErrorEventHandler>.Init(factory.Check_UnityEngine_Video_VideoPlayer_ErrorEventHandler);
		TypeTraits<VideoPlayer.TimeEventHandler>.Init(factory.Check_UnityEngine_Video_VideoPlayer_TimeEventHandler);
		TypeTraits<VideoPlayer.FrameReadyEventHandler>.Init(factory.Check_UnityEngine_Video_VideoPlayer_FrameReadyEventHandler);
		TypeTraits<Action<PlayableDirector>>.Init(factory.Check_System_Action_UnityEngine_Playables_PlayableDirector);
		TypeTraits<UnityAction<BaseEventData>>.Init(factory.Check_UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData);
		TypeTraits<UnityAction<bool>>.Init(factory.Check_UnityEngine_Events_UnityAction_bool);
		TypeTraits<UnityAction<int>>.Init(factory.Check_UnityEngine_Events_UnityAction_int);
		TypeTraits<UnityAction<float>>.Init(factory.Check_UnityEngine_Events_UnityAction_float);
		TypeTraits<UnityAction<Vector2>>.Init(factory.Check_UnityEngine_Events_UnityAction_UnityEngine_Vector2);
		TypeTraits<Func<ILayoutElement, float>>.Init(factory.Check_System_Func_UnityEngine_UI_ILayoutElement_float);
		TypeTraits<UnityAction<Scene, LoadSceneMode>>.Init(factory.Check_UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode);
		TypeTraits<UnityAction<Scene>>.Init(factory.Check_UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene);
		TypeTraits<UnityAction<Scene, Scene>>.Init(factory.Check_UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene);
		TypeTraits<UnityAction<DownloadRequest>>.Init(factory.Check_UnityEngine_Events_UnityAction_DownloadRequest);
		TypeTraits<OnVoidHandler<Sprite>>.Init(factory.Check_OnVoidHandler_UnityEngine_Sprite);
		TypeTraits<Action<string, string>>.Init(factory.Check_System_Action_string_string);
		TypeTraits<Action<SpriteAtlas>>.Init(factory.Check_System_Action_UnityEngine_U2D_SpriteAtlas);
		TypeTraits<Action<bool, string>>.Init(factory.Check_System_Action_bool_string);
		TypeTraits<Action<int, string, string, int>>.Init(factory.Check_System_Action_int_string_string_int);
		TypeTraits<Action<LoadingUIType>>.Init(factory.Check_System_Action_LoadingUIType);
		TypeTraits<UnityAction<Sprite>>.Init(factory.Check_UnityEngine_Events_UnityAction_UnityEngine_Sprite);
		TypeTraits<Action<string[], string[]>>.Init(factory.Check_System_Action_strings_strings);
		TypeTraits<Action<int, GameObject>>.Init(factory.Check_System_Action_int_UnityEngine_GameObject);
		TypeTraits<Action<int, int>>.Init(factory.Check_System_Action_int_int);
		TypeTraits<Action<int, int, string, string>>.Init(factory.Check_System_Action_int_int_string_string);
		TypeTraits<CriManaMovieMaterialBase.OnApplicationPauseCallback>.Init(factory.Check_CriManaMovieMaterial_OnApplicationPauseCallback);
		TypeTraits<Player.CuePointCallback>.Init(factory.Check_CriMana_Player_CuePointCallback);
		TypeTraits<Player.StatusChangeCallback>.Init(factory.Check_CriMana_Player_StatusChangeCallback);
		TypeTraits<Player.SubtitleChangeCallback>.Init(factory.Check_CriMana_Player_SubtitleChangeCallback);
		TypeTraits<Player.ShaderDispatchCallback>.Init(factory.Check_CriMana_Player_ShaderDispatchCallback);
		TypeTraits<BlendSystem.BlendSystemGenericDelegate>.Init(factory.Check_RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate);
		TypeTraits<LipSync.ResetDelegate>.Init(factory.Check_RogoDigital_Lipsync_LipSync_ResetDelegate);
		TypeTraits<Action<int, int, Transform>>.Init(factory.Check_System_Action_int_int_UnityEngine_Transform);
		TypeTraits<Action<long, int, int>>.Init(factory.Check_System_Action_long_int_int);
		TypeTraits<Action<long, int>>.Init(factory.Check_System_Action_long_int);
		TypeTraits<Action<PointerEventData>>.Init(factory.Check_System_Action_UnityEngine_EventSystems_PointerEventData);
		StackTraits<Action>.Push = factory.Push_System_Action;
		StackTraits<UnityAction>.Push = factory.Push_UnityEngine_Events_UnityAction;
		StackTraits<Predicate<int>>.Push = factory.Push_System_Predicate_int;
		StackTraits<Action<int>>.Push = factory.Push_System_Action_int;
		StackTraits<Comparison<int>>.Push = factory.Push_System_Comparison_int;
		StackTraits<Func<int, int>>.Push = factory.Push_System_Func_int_int;
		StackTraits<Camera.CameraCallback>.Push = factory.Push_UnityEngine_Camera_CameraCallback;
		StackTraits<Application.AdvertisingIdentifierCallback>.Push = factory.Push_UnityEngine_Application_AdvertisingIdentifierCallback;
		StackTraits<Application.LowMemoryCallback>.Push = factory.Push_UnityEngine_Application_LowMemoryCallback;
		StackTraits<Application.LogCallback>.Push = factory.Push_UnityEngine_Application_LogCallback;
		StackTraits<Action<bool>>.Push = factory.Push_System_Action_bool;
		StackTraits<Action<string>>.Push = factory.Push_System_Action_string;
		StackTraits<Func<bool>>.Push = factory.Push_System_Func_bool;
		StackTraits<Action<PhysicsScene, NativeArray<ModifiableContactPair>>>.Push = factory.Push_System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair;
		StackTraits<AudioClip.PCMReaderCallback>.Push = factory.Push_UnityEngine_AudioClip_PCMReaderCallback;
		StackTraits<AudioClip.PCMSetPositionCallback>.Push = factory.Push_UnityEngine_AudioClip_PCMSetPositionCallback;
		StackTraits<Action<AsyncOperation>>.Push = factory.Push_System_Action_UnityEngine_AsyncOperation;
		StackTraits<Action<UnityEngine.Object>>.Push = factory.Push_System_Action_UnityEngine_Object;
		StackTraits<OnVoidHandler<string>>.Push = factory.Push_OnVoidHandler_string;
		StackTraits<OnVoidHandler<int>>.Push = factory.Push_OnVoidHandler_int;
		StackTraits<OnVoidHandler<object, object>>.Push = factory.Push_OnVoidHandler_object_object;
		StackTraits<OnVoidHandler<object>>.Push = factory.Push_OnVoidHandler_object;
		StackTraits<UnityAction<SocketError>>.Push = factory.Push_UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError;
		StackTraits<UnityAction<string>>.Push = factory.Push_UnityEngine_Events_UnityAction_string;
		StackTraits<RectTransform.ReapplyDrivenProperties>.Push = factory.Push_UnityEngine_RectTransform_ReapplyDrivenProperties;
		StackTraits<Canvas.WillRenderCanvases>.Push = factory.Push_UnityEngine_Canvas_WillRenderCanvases;
		StackTraits<InputField.OnValidateInput>.Push = factory.Push_UnityEngine_UI_InputField_OnValidateInput;
		StackTraits<Action<Image, string>>.Push = factory.Push_System_Action_UnityEngine_UI_Image_string;
		StackTraits<SkeletonGraphic.SkeletonRendererDelegate>.Push = factory.Push_Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate;
		StackTraits<UpdateBonesDelegate>.Push = factory.Push_Spine_Unity_UpdateBonesDelegate;
		StackTraits<MeshGeneratorDelegate>.Push = factory.Push_Spine_Unity_MeshGeneratorDelegate;
		StackTraits<SkeletonRenderer.InstructionDelegate>.Push = factory.Push_Spine_Unity_SkeletonRenderer_InstructionDelegate;
		StackTraits<SkeletonRenderer.SkeletonRendererDelegate>.Push = factory.Push_Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate;
		StackTraits<Func<string, bool>>.Push = factory.Push_System_Func_string_bool;
		StackTraits<AnimationState.TrackEntryDelegate>.Push = factory.Push_Spine_AnimationState_TrackEntryDelegate;
		StackTraits<AnimationState.TrackEntryEventDelegate>.Push = factory.Push_Spine_AnimationState_TrackEntryEventDelegate;
		StackTraits<Action<object>>.Push = factory.Push_System_Action_object;
		StackTraits<Action<float>>.Push = factory.Push_System_Action_float;
		StackTraits<Action<float, float>>.Push = factory.Push_System_Action_float_float;
		StackTraits<Action<Color>>.Push = factory.Push_System_Action_UnityEngine_Color;
		StackTraits<Action<Color, object>>.Push = factory.Push_System_Action_UnityEngine_Color_object;
		StackTraits<Action<Vector2>>.Push = factory.Push_System_Action_UnityEngine_Vector2;
		StackTraits<Action<Vector3>>.Push = factory.Push_System_Action_UnityEngine_Vector3;
		StackTraits<Action<float, object>>.Push = factory.Push_System_Action_float_object;
		StackTraits<Action<Vector3, object>>.Push = factory.Push_System_Action_UnityEngine_Vector3_object;
		StackTraits<LuaHelper.ETLCallBack1>.Push = factory.Push_LuaHelper_ETLCallBack1;
		StackTraits<LuaHelper.ETLCallBack2>.Push = factory.Push_LuaHelper_ETLCallBack2;
		StackTraits<LuaHelper.ETLCallBack3>.Push = factory.Push_LuaHelper_ETLCallBack3;
		StackTraits<Action<Vector3, int>>.Push = factory.Push_System_Action_UnityEngine_Vector3_int;
		StackTraits<Func<Vector3, bool>>.Push = factory.Push_System_Func_UnityEngine_Vector3_bool;
		StackTraits<UnityAction<SpriteRenderer>>.Push = factory.Push_UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer;
		StackTraits<VideoPlayer.EventHandler>.Push = factory.Push_UnityEngine_Video_VideoPlayer_EventHandler;
		StackTraits<VideoPlayer.ErrorEventHandler>.Push = factory.Push_UnityEngine_Video_VideoPlayer_ErrorEventHandler;
		StackTraits<VideoPlayer.TimeEventHandler>.Push = factory.Push_UnityEngine_Video_VideoPlayer_TimeEventHandler;
		StackTraits<VideoPlayer.FrameReadyEventHandler>.Push = factory.Push_UnityEngine_Video_VideoPlayer_FrameReadyEventHandler;
		StackTraits<Action<PlayableDirector>>.Push = factory.Push_System_Action_UnityEngine_Playables_PlayableDirector;
		StackTraits<UnityAction<BaseEventData>>.Push = factory.Push_UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData;
		StackTraits<UnityAction<bool>>.Push = factory.Push_UnityEngine_Events_UnityAction_bool;
		StackTraits<UnityAction<int>>.Push = factory.Push_UnityEngine_Events_UnityAction_int;
		StackTraits<UnityAction<float>>.Push = factory.Push_UnityEngine_Events_UnityAction_float;
		StackTraits<UnityAction<Vector2>>.Push = factory.Push_UnityEngine_Events_UnityAction_UnityEngine_Vector2;
		StackTraits<Func<ILayoutElement, float>>.Push = factory.Push_System_Func_UnityEngine_UI_ILayoutElement_float;
		StackTraits<UnityAction<Scene, LoadSceneMode>>.Push = factory.Push_UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode;
		StackTraits<UnityAction<Scene>>.Push = factory.Push_UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene;
		StackTraits<UnityAction<Scene, Scene>>.Push = factory.Push_UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene;
		StackTraits<UnityAction<DownloadRequest>>.Push = factory.Push_UnityEngine_Events_UnityAction_DownloadRequest;
		StackTraits<OnVoidHandler<Sprite>>.Push = factory.Push_OnVoidHandler_UnityEngine_Sprite;
		StackTraits<Action<string, string>>.Push = factory.Push_System_Action_string_string;
		StackTraits<Action<SpriteAtlas>>.Push = factory.Push_System_Action_UnityEngine_U2D_SpriteAtlas;
		StackTraits<Action<bool, string>>.Push = factory.Push_System_Action_bool_string;
		StackTraits<Action<int, string, string, int>>.Push = factory.Push_System_Action_int_string_string_int;
		StackTraits<Action<LoadingUIType>>.Push = factory.Push_System_Action_LoadingUIType;
		StackTraits<UnityAction<Sprite>>.Push = factory.Push_UnityEngine_Events_UnityAction_UnityEngine_Sprite;
		StackTraits<Action<string[], string[]>>.Push = factory.Push_System_Action_strings_strings;
		StackTraits<Action<int, GameObject>>.Push = factory.Push_System_Action_int_UnityEngine_GameObject;
		StackTraits<Action<int, int>>.Push = factory.Push_System_Action_int_int;
		StackTraits<Action<int, int, string, string>>.Push = factory.Push_System_Action_int_int_string_string;
		StackTraits<CriManaMovieMaterialBase.OnApplicationPauseCallback>.Push = factory.Push_CriManaMovieMaterial_OnApplicationPauseCallback;
		StackTraits<Player.CuePointCallback>.Push = factory.Push_CriMana_Player_CuePointCallback;
		StackTraits<Player.StatusChangeCallback>.Push = factory.Push_CriMana_Player_StatusChangeCallback;
		StackTraits<Player.SubtitleChangeCallback>.Push = factory.Push_CriMana_Player_SubtitleChangeCallback;
		StackTraits<Player.ShaderDispatchCallback>.Push = factory.Push_CriMana_Player_ShaderDispatchCallback;
		StackTraits<BlendSystem.BlendSystemGenericDelegate>.Push = factory.Push_RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate;
		StackTraits<LipSync.ResetDelegate>.Push = factory.Push_RogoDigital_Lipsync_LipSync_ResetDelegate;
		StackTraits<Action<int, int, Transform>>.Push = factory.Push_System_Action_int_int_UnityEngine_Transform;
		StackTraits<Action<long, int, int>>.Push = factory.Push_System_Action_long_int_int;
		StackTraits<Action<long, int>>.Push = factory.Push_System_Action_long_int;
		StackTraits<Action<PointerEventData>>.Push = factory.Push_System_Action_UnityEngine_EventSystems_PointerEventData;
	}

	public static Delegate CreateDelegate(Type t, LuaFunction func = null)
	{
		DelegateCreate value = null;
		if (!dict.TryGetValue(t, out value))
		{
			throw new LuaException($"Delegate {LuaMisc.GetTypeName(t)} not register");
		}
		if (func != null)
		{
			LuaState luaState = func.GetLuaState();
			LuaDelegate luaDelegate = luaState.GetLuaDelegate(func);
			if (luaDelegate != null)
			{
				return Delegate.CreateDelegate(t, luaDelegate, luaDelegate.method);
			}
			Delegate obj = value(func, null, flag: false);
			luaDelegate = obj.Target as LuaDelegate;
			luaState.AddLuaDelegate(luaDelegate, func);
			return obj;
		}
		return value(null, null, flag: false);
	}

	public static Delegate CreateDelegate(Type t, LuaFunction func, LuaTable self)
	{
		DelegateCreate value = null;
		if (!dict.TryGetValue(t, out value))
		{
			throw new LuaException($"Delegate {LuaMisc.GetTypeName(t)} not register");
		}
		if (func != null)
		{
			LuaState luaState = func.GetLuaState();
			LuaDelegate luaDelegate = luaState.GetLuaDelegate(func, self);
			if (luaDelegate != null)
			{
				return Delegate.CreateDelegate(t, luaDelegate, luaDelegate.method);
			}
			Delegate obj = value(func, self, flag: true);
			luaDelegate = obj.Target as LuaDelegate;
			luaState.AddLuaDelegate(luaDelegate, func, self);
			return obj;
		}
		return value(null, null, flag: true);
	}

	public static Delegate RemoveDelegate(Delegate obj, LuaFunction func)
	{
		LuaState luaState = func.GetLuaState();
		Delegate[] invocationList = obj.GetInvocationList();
		for (int i = 0; i < invocationList.Length; i++)
		{
			LuaDelegate luaDelegate = invocationList[i].Target as LuaDelegate;
			if (luaDelegate != null && luaDelegate.func == func)
			{
				obj = Delegate.Remove(obj, invocationList[i]);
				luaState.DelayDispose(luaDelegate.func);
				break;
			}
		}
		return obj;
	}

	public static Delegate RemoveDelegate(Delegate obj, Delegate dg)
	{
		LuaDelegate luaDelegate = dg.Target as LuaDelegate;
		if (luaDelegate == null)
		{
			obj = Delegate.Remove(obj, dg);
			return obj;
		}
		LuaState luaState = luaDelegate.func.GetLuaState();
		Delegate[] invocationList = obj.GetInvocationList();
		for (int i = 0; i < invocationList.Length; i++)
		{
			LuaDelegate luaDelegate2 = invocationList[i].Target as LuaDelegate;
			if (luaDelegate2 != null && luaDelegate2 == luaDelegate)
			{
				obj = Delegate.Remove(obj, invocationList[i]);
				luaState.DelayDispose(luaDelegate2.func);
				luaState.DelayDispose(luaDelegate2.self);
				break;
			}
		}
		return obj;
	}

	public Action System_Action(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_Event system_Action_Event = new System_Action_Event(func);
			Action action = system_Action_Event.Call;
			system_Action_Event.method = action.Method;
			return action;
		}
		System_Action_Event system_Action_Event2 = new System_Action_Event(func, self);
		Action action2 = system_Action_Event2.CallWithSelf;
		system_Action_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action), L, pos);
	}

	private void Push_System_Action(IntPtr L, Action o)
	{
		ToLua.Push(L, o);
	}

	public UnityAction UnityEngine_Events_UnityAction(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Events_UnityAction_Event unityEngine_Events_UnityAction_Event = new UnityEngine_Events_UnityAction_Event(func);
			UnityAction unityAction = unityEngine_Events_UnityAction_Event.Call;
			unityEngine_Events_UnityAction_Event.method = unityAction.Method;
			return unityAction;
		}
		UnityEngine_Events_UnityAction_Event unityEngine_Events_UnityAction_Event2 = new UnityEngine_Events_UnityAction_Event(func, self);
		UnityAction unityAction2 = unityEngine_Events_UnityAction_Event2.CallWithSelf;
		unityEngine_Events_UnityAction_Event2.method = unityAction2.Method;
		return unityAction2;
	}

	private bool Check_UnityEngine_Events_UnityAction(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UnityAction), L, pos);
	}

	private void Push_UnityEngine_Events_UnityAction(IntPtr L, UnityAction o)
	{
		ToLua.Push(L, o);
	}

	public Predicate<int> System_Predicate_int(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return (int param0) => false;
		}
		if (!flag)
		{
			System_Predicate_int_Event system_Predicate_int_Event = new System_Predicate_int_Event(func);
			Predicate<int> predicate = system_Predicate_int_Event.Call;
			system_Predicate_int_Event.method = predicate.Method;
			return predicate;
		}
		System_Predicate_int_Event system_Predicate_int_Event2 = new System_Predicate_int_Event(func, self);
		Predicate<int> predicate2 = system_Predicate_int_Event2.CallWithSelf;
		system_Predicate_int_Event2.method = predicate2.Method;
		return predicate2;
	}

	private bool Check_System_Predicate_int(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Predicate<int>), L, pos);
	}

	private void Push_System_Predicate_int(IntPtr L, Predicate<int> o)
	{
		ToLua.Push(L, o);
	}

	public Action<int> System_Action_int(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_int_Event system_Action_int_Event = new System_Action_int_Event(func);
			Action<int> action = system_Action_int_Event.Call;
			system_Action_int_Event.method = action.Method;
			return action;
		}
		System_Action_int_Event system_Action_int_Event2 = new System_Action_int_Event(func, self);
		Action<int> action2 = system_Action_int_Event2.CallWithSelf;
		system_Action_int_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_int(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<int>), L, pos);
	}

	private void Push_System_Action_int(IntPtr L, Action<int> o)
	{
		ToLua.Push(L, o);
	}

	public Comparison<int> System_Comparison_int(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return (int param0, int param1) => 0;
		}
		if (!flag)
		{
			System_Comparison_int_Event system_Comparison_int_Event = new System_Comparison_int_Event(func);
			Comparison<int> comparison = system_Comparison_int_Event.Call;
			system_Comparison_int_Event.method = comparison.Method;
			return comparison;
		}
		System_Comparison_int_Event system_Comparison_int_Event2 = new System_Comparison_int_Event(func, self);
		Comparison<int> comparison2 = system_Comparison_int_Event2.CallWithSelf;
		system_Comparison_int_Event2.method = comparison2.Method;
		return comparison2;
	}

	private bool Check_System_Comparison_int(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Comparison<int>), L, pos);
	}

	private void Push_System_Comparison_int(IntPtr L, Comparison<int> o)
	{
		ToLua.Push(L, o);
	}

	public Func<int, int> System_Func_int_int(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return (int param0) => 0;
		}
		if (!flag)
		{
			System_Func_int_int_Event system_Func_int_int_Event = new System_Func_int_int_Event(func);
			Func<int, int> func2 = system_Func_int_int_Event.Call;
			system_Func_int_int_Event.method = func2.Method;
			return func2;
		}
		System_Func_int_int_Event system_Func_int_int_Event2 = new System_Func_int_int_Event(func, self);
		Func<int, int> func3 = system_Func_int_int_Event2.CallWithSelf;
		system_Func_int_int_Event2.method = func3.Method;
		return func3;
	}

	private bool Check_System_Func_int_int(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Func<int, int>), L, pos);
	}

	private void Push_System_Func_int_int(IntPtr L, Func<int, int> o)
	{
		ToLua.Push(L, o);
	}

	public Camera.CameraCallback UnityEngine_Camera_CameraCallback(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Camera_CameraCallback_Event unityEngine_Camera_CameraCallback_Event = new UnityEngine_Camera_CameraCallback_Event(func);
			Camera.CameraCallback cameraCallback = unityEngine_Camera_CameraCallback_Event.Call;
			unityEngine_Camera_CameraCallback_Event.method = cameraCallback.Method;
			return cameraCallback;
		}
		UnityEngine_Camera_CameraCallback_Event unityEngine_Camera_CameraCallback_Event2 = new UnityEngine_Camera_CameraCallback_Event(func, self);
		Camera.CameraCallback cameraCallback2 = unityEngine_Camera_CameraCallback_Event2.CallWithSelf;
		unityEngine_Camera_CameraCallback_Event2.method = cameraCallback2.Method;
		return cameraCallback2;
	}

	private bool Check_UnityEngine_Camera_CameraCallback(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Camera.CameraCallback), L, pos);
	}

	private void Push_UnityEngine_Camera_CameraCallback(IntPtr L, Camera.CameraCallback o)
	{
		ToLua.Push(L, o);
	}

	public Application.AdvertisingIdentifierCallback UnityEngine_Application_AdvertisingIdentifierCallback(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Application_AdvertisingIdentifierCallback_Event unityEngine_Application_AdvertisingIdentifierCallback_Event = new UnityEngine_Application_AdvertisingIdentifierCallback_Event(func);
			Application.AdvertisingIdentifierCallback advertisingIdentifierCallback = unityEngine_Application_AdvertisingIdentifierCallback_Event.Call;
			unityEngine_Application_AdvertisingIdentifierCallback_Event.method = advertisingIdentifierCallback.Method;
			return advertisingIdentifierCallback;
		}
		UnityEngine_Application_AdvertisingIdentifierCallback_Event unityEngine_Application_AdvertisingIdentifierCallback_Event2 = new UnityEngine_Application_AdvertisingIdentifierCallback_Event(func, self);
		Application.AdvertisingIdentifierCallback advertisingIdentifierCallback2 = unityEngine_Application_AdvertisingIdentifierCallback_Event2.CallWithSelf;
		unityEngine_Application_AdvertisingIdentifierCallback_Event2.method = advertisingIdentifierCallback2.Method;
		return advertisingIdentifierCallback2;
	}

	private bool Check_UnityEngine_Application_AdvertisingIdentifierCallback(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Application.AdvertisingIdentifierCallback), L, pos);
	}

	private void Push_UnityEngine_Application_AdvertisingIdentifierCallback(IntPtr L, Application.AdvertisingIdentifierCallback o)
	{
		ToLua.Push(L, o);
	}

	public Application.LowMemoryCallback UnityEngine_Application_LowMemoryCallback(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Application_LowMemoryCallback_Event unityEngine_Application_LowMemoryCallback_Event = new UnityEngine_Application_LowMemoryCallback_Event(func);
			Application.LowMemoryCallback lowMemoryCallback = unityEngine_Application_LowMemoryCallback_Event.Call;
			unityEngine_Application_LowMemoryCallback_Event.method = lowMemoryCallback.Method;
			return lowMemoryCallback;
		}
		UnityEngine_Application_LowMemoryCallback_Event unityEngine_Application_LowMemoryCallback_Event2 = new UnityEngine_Application_LowMemoryCallback_Event(func, self);
		Application.LowMemoryCallback lowMemoryCallback2 = unityEngine_Application_LowMemoryCallback_Event2.CallWithSelf;
		unityEngine_Application_LowMemoryCallback_Event2.method = lowMemoryCallback2.Method;
		return lowMemoryCallback2;
	}

	private bool Check_UnityEngine_Application_LowMemoryCallback(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Application.LowMemoryCallback), L, pos);
	}

	private void Push_UnityEngine_Application_LowMemoryCallback(IntPtr L, Application.LowMemoryCallback o)
	{
		ToLua.Push(L, o);
	}

	public Application.LogCallback UnityEngine_Application_LogCallback(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Application_LogCallback_Event unityEngine_Application_LogCallback_Event = new UnityEngine_Application_LogCallback_Event(func);
			Application.LogCallback logCallback = unityEngine_Application_LogCallback_Event.Call;
			unityEngine_Application_LogCallback_Event.method = logCallback.Method;
			return logCallback;
		}
		UnityEngine_Application_LogCallback_Event unityEngine_Application_LogCallback_Event2 = new UnityEngine_Application_LogCallback_Event(func, self);
		Application.LogCallback logCallback2 = unityEngine_Application_LogCallback_Event2.CallWithSelf;
		unityEngine_Application_LogCallback_Event2.method = logCallback2.Method;
		return logCallback2;
	}

	private bool Check_UnityEngine_Application_LogCallback(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Application.LogCallback), L, pos);
	}

	private void Push_UnityEngine_Application_LogCallback(IntPtr L, Application.LogCallback o)
	{
		ToLua.Push(L, o);
	}

	public Action<bool> System_Action_bool(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_bool_Event system_Action_bool_Event = new System_Action_bool_Event(func);
			Action<bool> action = system_Action_bool_Event.Call;
			system_Action_bool_Event.method = action.Method;
			return action;
		}
		System_Action_bool_Event system_Action_bool_Event2 = new System_Action_bool_Event(func, self);
		Action<bool> action2 = system_Action_bool_Event2.CallWithSelf;
		system_Action_bool_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_bool(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<bool>), L, pos);
	}

	private void Push_System_Action_bool(IntPtr L, Action<bool> o)
	{
		ToLua.Push(L, o);
	}

	public Action<string> System_Action_string(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_string_Event system_Action_string_Event = new System_Action_string_Event(func);
			Action<string> action = system_Action_string_Event.Call;
			system_Action_string_Event.method = action.Method;
			return action;
		}
		System_Action_string_Event system_Action_string_Event2 = new System_Action_string_Event(func, self);
		Action<string> action2 = system_Action_string_Event2.CallWithSelf;
		system_Action_string_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_string(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<string>), L, pos);
	}

	private void Push_System_Action_string(IntPtr L, Action<string> o)
	{
		ToLua.Push(L, o);
	}

	public Func<bool> System_Func_bool(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return () => false;
		}
		if (!flag)
		{
			System_Func_bool_Event system_Func_bool_Event = new System_Func_bool_Event(func);
			Func<bool> func2 = system_Func_bool_Event.Call;
			system_Func_bool_Event.method = func2.Method;
			return func2;
		}
		System_Func_bool_Event system_Func_bool_Event2 = new System_Func_bool_Event(func, self);
		Func<bool> func3 = system_Func_bool_Event2.CallWithSelf;
		system_Func_bool_Event2.method = func3.Method;
		return func3;
	}

	private bool Check_System_Func_bool(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Func<bool>), L, pos);
	}

	private void Push_System_Func_bool(IntPtr L, Func<bool> o)
	{
		ToLua.Push(L, o);
	}

	public Action<PhysicsScene, NativeArray<ModifiableContactPair>> System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair_Event system_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair_Event = new System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair_Event(func);
			Action<PhysicsScene, NativeArray<ModifiableContactPair>> action = system_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair_Event.Call;
			system_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair_Event.method = action.Method;
			return action;
		}
		System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair_Event system_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair_Event2 = new System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair_Event(func, self);
		Action<PhysicsScene, NativeArray<ModifiableContactPair>> action2 = system_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair_Event2.CallWithSelf;
		system_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<PhysicsScene, NativeArray<ModifiableContactPair>>), L, pos);
	}

	private void Push_System_Action_UnityEngine_PhysicsScene_Unity_Collections_NativeArray_UnityEngine_ModifiableContactPair(IntPtr L, Action<PhysicsScene, NativeArray<ModifiableContactPair>> o)
	{
		ToLua.Push(L, o);
	}

	public AudioClip.PCMReaderCallback UnityEngine_AudioClip_PCMReaderCallback(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_AudioClip_PCMReaderCallback_Event unityEngine_AudioClip_PCMReaderCallback_Event = new UnityEngine_AudioClip_PCMReaderCallback_Event(func);
			AudioClip.PCMReaderCallback pCMReaderCallback = unityEngine_AudioClip_PCMReaderCallback_Event.Call;
			unityEngine_AudioClip_PCMReaderCallback_Event.method = pCMReaderCallback.Method;
			return pCMReaderCallback;
		}
		UnityEngine_AudioClip_PCMReaderCallback_Event unityEngine_AudioClip_PCMReaderCallback_Event2 = new UnityEngine_AudioClip_PCMReaderCallback_Event(func, self);
		AudioClip.PCMReaderCallback pCMReaderCallback2 = unityEngine_AudioClip_PCMReaderCallback_Event2.CallWithSelf;
		unityEngine_AudioClip_PCMReaderCallback_Event2.method = pCMReaderCallback2.Method;
		return pCMReaderCallback2;
	}

	private bool Check_UnityEngine_AudioClip_PCMReaderCallback(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(AudioClip.PCMReaderCallback), L, pos);
	}

	private void Push_UnityEngine_AudioClip_PCMReaderCallback(IntPtr L, AudioClip.PCMReaderCallback o)
	{
		ToLua.Push(L, o);
	}

	public AudioClip.PCMSetPositionCallback UnityEngine_AudioClip_PCMSetPositionCallback(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_AudioClip_PCMSetPositionCallback_Event unityEngine_AudioClip_PCMSetPositionCallback_Event = new UnityEngine_AudioClip_PCMSetPositionCallback_Event(func);
			AudioClip.PCMSetPositionCallback pCMSetPositionCallback = unityEngine_AudioClip_PCMSetPositionCallback_Event.Call;
			unityEngine_AudioClip_PCMSetPositionCallback_Event.method = pCMSetPositionCallback.Method;
			return pCMSetPositionCallback;
		}
		UnityEngine_AudioClip_PCMSetPositionCallback_Event unityEngine_AudioClip_PCMSetPositionCallback_Event2 = new UnityEngine_AudioClip_PCMSetPositionCallback_Event(func, self);
		AudioClip.PCMSetPositionCallback pCMSetPositionCallback2 = unityEngine_AudioClip_PCMSetPositionCallback_Event2.CallWithSelf;
		unityEngine_AudioClip_PCMSetPositionCallback_Event2.method = pCMSetPositionCallback2.Method;
		return pCMSetPositionCallback2;
	}

	private bool Check_UnityEngine_AudioClip_PCMSetPositionCallback(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(AudioClip.PCMSetPositionCallback), L, pos);
	}

	private void Push_UnityEngine_AudioClip_PCMSetPositionCallback(IntPtr L, AudioClip.PCMSetPositionCallback o)
	{
		ToLua.Push(L, o);
	}

	public Action<AsyncOperation> System_Action_UnityEngine_AsyncOperation(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_UnityEngine_AsyncOperation_Event system_Action_UnityEngine_AsyncOperation_Event = new System_Action_UnityEngine_AsyncOperation_Event(func);
			Action<AsyncOperation> action = system_Action_UnityEngine_AsyncOperation_Event.Call;
			system_Action_UnityEngine_AsyncOperation_Event.method = action.Method;
			return action;
		}
		System_Action_UnityEngine_AsyncOperation_Event system_Action_UnityEngine_AsyncOperation_Event2 = new System_Action_UnityEngine_AsyncOperation_Event(func, self);
		Action<AsyncOperation> action2 = system_Action_UnityEngine_AsyncOperation_Event2.CallWithSelf;
		system_Action_UnityEngine_AsyncOperation_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_UnityEngine_AsyncOperation(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<AsyncOperation>), L, pos);
	}

	private void Push_System_Action_UnityEngine_AsyncOperation(IntPtr L, Action<AsyncOperation> o)
	{
		ToLua.Push(L, o);
	}

	public Action<UnityEngine.Object> System_Action_UnityEngine_Object(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_UnityEngine_Object_Event system_Action_UnityEngine_Object_Event = new System_Action_UnityEngine_Object_Event(func);
			Action<UnityEngine.Object> action = system_Action_UnityEngine_Object_Event.Call;
			system_Action_UnityEngine_Object_Event.method = action.Method;
			return action;
		}
		System_Action_UnityEngine_Object_Event system_Action_UnityEngine_Object_Event2 = new System_Action_UnityEngine_Object_Event(func, self);
		Action<UnityEngine.Object> action2 = system_Action_UnityEngine_Object_Event2.CallWithSelf;
		system_Action_UnityEngine_Object_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_UnityEngine_Object(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<UnityEngine.Object>), L, pos);
	}

	private void Push_System_Action_UnityEngine_Object(IntPtr L, Action<UnityEngine.Object> o)
	{
		ToLua.Push(L, o);
	}

	public OnVoidHandler<string> OnVoidHandler_string(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			OnVoidHandler_string_Event onVoidHandler_string_Event = new OnVoidHandler_string_Event(func);
			OnVoidHandler<string> onVoidHandler = onVoidHandler_string_Event.Call;
			onVoidHandler_string_Event.method = onVoidHandler.Method;
			return onVoidHandler;
		}
		OnVoidHandler_string_Event onVoidHandler_string_Event2 = new OnVoidHandler_string_Event(func, self);
		OnVoidHandler<string> onVoidHandler2 = onVoidHandler_string_Event2.CallWithSelf;
		onVoidHandler_string_Event2.method = onVoidHandler2.Method;
		return onVoidHandler2;
	}

	private bool Check_OnVoidHandler_string(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(OnVoidHandler<string>), L, pos);
	}

	private void Push_OnVoidHandler_string(IntPtr L, OnVoidHandler<string> o)
	{
		ToLua.Push(L, o);
	}

	public OnVoidHandler<int> OnVoidHandler_int(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			OnVoidHandler_int_Event onVoidHandler_int_Event = new OnVoidHandler_int_Event(func);
			OnVoidHandler<int> onVoidHandler = onVoidHandler_int_Event.Call;
			onVoidHandler_int_Event.method = onVoidHandler.Method;
			return onVoidHandler;
		}
		OnVoidHandler_int_Event onVoidHandler_int_Event2 = new OnVoidHandler_int_Event(func, self);
		OnVoidHandler<int> onVoidHandler2 = onVoidHandler_int_Event2.CallWithSelf;
		onVoidHandler_int_Event2.method = onVoidHandler2.Method;
		return onVoidHandler2;
	}

	private bool Check_OnVoidHandler_int(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(OnVoidHandler<int>), L, pos);
	}

	private void Push_OnVoidHandler_int(IntPtr L, OnVoidHandler<int> o)
	{
		ToLua.Push(L, o);
	}

	public OnVoidHandler<object, object> OnVoidHandler_object_object(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			OnVoidHandler_object_object_Event onVoidHandler_object_object_Event = new OnVoidHandler_object_object_Event(func);
			OnVoidHandler<object, object> onVoidHandler = onVoidHandler_object_object_Event.Call;
			onVoidHandler_object_object_Event.method = onVoidHandler.Method;
			return onVoidHandler;
		}
		OnVoidHandler_object_object_Event onVoidHandler_object_object_Event2 = new OnVoidHandler_object_object_Event(func, self);
		OnVoidHandler<object, object> onVoidHandler2 = onVoidHandler_object_object_Event2.CallWithSelf;
		onVoidHandler_object_object_Event2.method = onVoidHandler2.Method;
		return onVoidHandler2;
	}

	private bool Check_OnVoidHandler_object_object(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(OnVoidHandler<object, object>), L, pos);
	}

	private void Push_OnVoidHandler_object_object(IntPtr L, OnVoidHandler<object, object> o)
	{
		ToLua.Push(L, o);
	}

	public OnVoidHandler<object> OnVoidHandler_object(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			OnVoidHandler_object_Event onVoidHandler_object_Event = new OnVoidHandler_object_Event(func);
			OnVoidHandler<object> onVoidHandler = onVoidHandler_object_Event.Call;
			onVoidHandler_object_Event.method = onVoidHandler.Method;
			return onVoidHandler;
		}
		OnVoidHandler_object_Event onVoidHandler_object_Event2 = new OnVoidHandler_object_Event(func, self);
		OnVoidHandler<object> onVoidHandler2 = onVoidHandler_object_Event2.CallWithSelf;
		onVoidHandler_object_Event2.method = onVoidHandler2.Method;
		return onVoidHandler2;
	}

	private bool Check_OnVoidHandler_object(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(OnVoidHandler<object>), L, pos);
	}

	private void Push_OnVoidHandler_object(IntPtr L, OnVoidHandler<object> o)
	{
		ToLua.Push(L, o);
	}

	public UnityAction<SocketError> UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError_Event unityEngine_Events_UnityAction_System_Net_Sockets_SocketError_Event = new UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError_Event(func);
			UnityAction<SocketError> unityAction = unityEngine_Events_UnityAction_System_Net_Sockets_SocketError_Event.Call;
			unityEngine_Events_UnityAction_System_Net_Sockets_SocketError_Event.method = unityAction.Method;
			return unityAction;
		}
		UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError_Event unityEngine_Events_UnityAction_System_Net_Sockets_SocketError_Event2 = new UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError_Event(func, self);
		UnityAction<SocketError> unityAction2 = unityEngine_Events_UnityAction_System_Net_Sockets_SocketError_Event2.CallWithSelf;
		unityEngine_Events_UnityAction_System_Net_Sockets_SocketError_Event2.method = unityAction2.Method;
		return unityAction2;
	}

	private bool Check_UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UnityAction<SocketError>), L, pos);
	}

	private void Push_UnityEngine_Events_UnityAction_System_Net_Sockets_SocketError(IntPtr L, UnityAction<SocketError> o)
	{
		ToLua.Push(L, o);
	}

	public UnityAction<string> UnityEngine_Events_UnityAction_string(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Events_UnityAction_string_Event unityEngine_Events_UnityAction_string_Event = new UnityEngine_Events_UnityAction_string_Event(func);
			UnityAction<string> unityAction = unityEngine_Events_UnityAction_string_Event.Call;
			unityEngine_Events_UnityAction_string_Event.method = unityAction.Method;
			return unityAction;
		}
		UnityEngine_Events_UnityAction_string_Event unityEngine_Events_UnityAction_string_Event2 = new UnityEngine_Events_UnityAction_string_Event(func, self);
		UnityAction<string> unityAction2 = unityEngine_Events_UnityAction_string_Event2.CallWithSelf;
		unityEngine_Events_UnityAction_string_Event2.method = unityAction2.Method;
		return unityAction2;
	}

	private bool Check_UnityEngine_Events_UnityAction_string(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UnityAction<string>), L, pos);
	}

	private void Push_UnityEngine_Events_UnityAction_string(IntPtr L, UnityAction<string> o)
	{
		ToLua.Push(L, o);
	}

	public RectTransform.ReapplyDrivenProperties UnityEngine_RectTransform_ReapplyDrivenProperties(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_RectTransform_ReapplyDrivenProperties_Event unityEngine_RectTransform_ReapplyDrivenProperties_Event = new UnityEngine_RectTransform_ReapplyDrivenProperties_Event(func);
			RectTransform.ReapplyDrivenProperties reapplyDrivenProperties = unityEngine_RectTransform_ReapplyDrivenProperties_Event.Call;
			unityEngine_RectTransform_ReapplyDrivenProperties_Event.method = reapplyDrivenProperties.Method;
			return reapplyDrivenProperties;
		}
		UnityEngine_RectTransform_ReapplyDrivenProperties_Event unityEngine_RectTransform_ReapplyDrivenProperties_Event2 = new UnityEngine_RectTransform_ReapplyDrivenProperties_Event(func, self);
		RectTransform.ReapplyDrivenProperties reapplyDrivenProperties2 = unityEngine_RectTransform_ReapplyDrivenProperties_Event2.CallWithSelf;
		unityEngine_RectTransform_ReapplyDrivenProperties_Event2.method = reapplyDrivenProperties2.Method;
		return reapplyDrivenProperties2;
	}

	private bool Check_UnityEngine_RectTransform_ReapplyDrivenProperties(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(RectTransform.ReapplyDrivenProperties), L, pos);
	}

	private void Push_UnityEngine_RectTransform_ReapplyDrivenProperties(IntPtr L, RectTransform.ReapplyDrivenProperties o)
	{
		ToLua.Push(L, o);
	}

	public Canvas.WillRenderCanvases UnityEngine_Canvas_WillRenderCanvases(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Canvas_WillRenderCanvases_Event unityEngine_Canvas_WillRenderCanvases_Event = new UnityEngine_Canvas_WillRenderCanvases_Event(func);
			Canvas.WillRenderCanvases willRenderCanvases = unityEngine_Canvas_WillRenderCanvases_Event.Call;
			unityEngine_Canvas_WillRenderCanvases_Event.method = willRenderCanvases.Method;
			return willRenderCanvases;
		}
		UnityEngine_Canvas_WillRenderCanvases_Event unityEngine_Canvas_WillRenderCanvases_Event2 = new UnityEngine_Canvas_WillRenderCanvases_Event(func, self);
		Canvas.WillRenderCanvases willRenderCanvases2 = unityEngine_Canvas_WillRenderCanvases_Event2.CallWithSelf;
		unityEngine_Canvas_WillRenderCanvases_Event2.method = willRenderCanvases2.Method;
		return willRenderCanvases2;
	}

	private bool Check_UnityEngine_Canvas_WillRenderCanvases(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Canvas.WillRenderCanvases), L, pos);
	}

	private void Push_UnityEngine_Canvas_WillRenderCanvases(IntPtr L, Canvas.WillRenderCanvases o)
	{
		ToLua.Push(L, o);
	}

	public InputField.OnValidateInput UnityEngine_UI_InputField_OnValidateInput(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return (string param0, int param1, char param2) => '\0';
		}
		if (!flag)
		{
			UnityEngine_UI_InputField_OnValidateInput_Event unityEngine_UI_InputField_OnValidateInput_Event = new UnityEngine_UI_InputField_OnValidateInput_Event(func);
			InputField.OnValidateInput onValidateInput = unityEngine_UI_InputField_OnValidateInput_Event.Call;
			unityEngine_UI_InputField_OnValidateInput_Event.method = onValidateInput.Method;
			return onValidateInput;
		}
		UnityEngine_UI_InputField_OnValidateInput_Event unityEngine_UI_InputField_OnValidateInput_Event2 = new UnityEngine_UI_InputField_OnValidateInput_Event(func, self);
		InputField.OnValidateInput onValidateInput2 = unityEngine_UI_InputField_OnValidateInput_Event2.CallWithSelf;
		unityEngine_UI_InputField_OnValidateInput_Event2.method = onValidateInput2.Method;
		return onValidateInput2;
	}

	private bool Check_UnityEngine_UI_InputField_OnValidateInput(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(InputField.OnValidateInput), L, pos);
	}

	private void Push_UnityEngine_UI_InputField_OnValidateInput(IntPtr L, InputField.OnValidateInput o)
	{
		ToLua.Push(L, o);
	}

	public Action<Image, string> System_Action_UnityEngine_UI_Image_string(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_UnityEngine_UI_Image_string_Event system_Action_UnityEngine_UI_Image_string_Event = new System_Action_UnityEngine_UI_Image_string_Event(func);
			Action<Image, string> action = system_Action_UnityEngine_UI_Image_string_Event.Call;
			system_Action_UnityEngine_UI_Image_string_Event.method = action.Method;
			return action;
		}
		System_Action_UnityEngine_UI_Image_string_Event system_Action_UnityEngine_UI_Image_string_Event2 = new System_Action_UnityEngine_UI_Image_string_Event(func, self);
		Action<Image, string> action2 = system_Action_UnityEngine_UI_Image_string_Event2.CallWithSelf;
		system_Action_UnityEngine_UI_Image_string_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_UnityEngine_UI_Image_string(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<Image, string>), L, pos);
	}

	private void Push_System_Action_UnityEngine_UI_Image_string(IntPtr L, Action<Image, string> o)
	{
		ToLua.Push(L, o);
	}

	public SkeletonGraphic.SkeletonRendererDelegate Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate_Event spine_Unity_SkeletonGraphic_SkeletonRendererDelegate_Event = new Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate_Event(func);
			SkeletonGraphic.SkeletonRendererDelegate skeletonRendererDelegate = spine_Unity_SkeletonGraphic_SkeletonRendererDelegate_Event.Call;
			spine_Unity_SkeletonGraphic_SkeletonRendererDelegate_Event.method = skeletonRendererDelegate.Method;
			return skeletonRendererDelegate;
		}
		Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate_Event spine_Unity_SkeletonGraphic_SkeletonRendererDelegate_Event2 = new Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate_Event(func, self);
		SkeletonGraphic.SkeletonRendererDelegate skeletonRendererDelegate2 = spine_Unity_SkeletonGraphic_SkeletonRendererDelegate_Event2.CallWithSelf;
		spine_Unity_SkeletonGraphic_SkeletonRendererDelegate_Event2.method = skeletonRendererDelegate2.Method;
		return skeletonRendererDelegate2;
	}

	private bool Check_Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(SkeletonGraphic.SkeletonRendererDelegate), L, pos);
	}

	private void Push_Spine_Unity_SkeletonGraphic_SkeletonRendererDelegate(IntPtr L, SkeletonGraphic.SkeletonRendererDelegate o)
	{
		ToLua.Push(L, o);
	}

	public UpdateBonesDelegate Spine_Unity_UpdateBonesDelegate(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			Spine_Unity_UpdateBonesDelegate_Event spine_Unity_UpdateBonesDelegate_Event = new Spine_Unity_UpdateBonesDelegate_Event(func);
			UpdateBonesDelegate updateBonesDelegate = spine_Unity_UpdateBonesDelegate_Event.Call;
			spine_Unity_UpdateBonesDelegate_Event.method = updateBonesDelegate.Method;
			return updateBonesDelegate;
		}
		Spine_Unity_UpdateBonesDelegate_Event spine_Unity_UpdateBonesDelegate_Event2 = new Spine_Unity_UpdateBonesDelegate_Event(func, self);
		UpdateBonesDelegate updateBonesDelegate2 = spine_Unity_UpdateBonesDelegate_Event2.CallWithSelf;
		spine_Unity_UpdateBonesDelegate_Event2.method = updateBonesDelegate2.Method;
		return updateBonesDelegate2;
	}

	private bool Check_Spine_Unity_UpdateBonesDelegate(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UpdateBonesDelegate), L, pos);
	}

	private void Push_Spine_Unity_UpdateBonesDelegate(IntPtr L, UpdateBonesDelegate o)
	{
		ToLua.Push(L, o);
	}

	public MeshGeneratorDelegate Spine_Unity_MeshGeneratorDelegate(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			Spine_Unity_MeshGeneratorDelegate_Event spine_Unity_MeshGeneratorDelegate_Event = new Spine_Unity_MeshGeneratorDelegate_Event(func);
			MeshGeneratorDelegate meshGeneratorDelegate = spine_Unity_MeshGeneratorDelegate_Event.Call;
			spine_Unity_MeshGeneratorDelegate_Event.method = meshGeneratorDelegate.Method;
			return meshGeneratorDelegate;
		}
		Spine_Unity_MeshGeneratorDelegate_Event spine_Unity_MeshGeneratorDelegate_Event2 = new Spine_Unity_MeshGeneratorDelegate_Event(func, self);
		MeshGeneratorDelegate meshGeneratorDelegate2 = spine_Unity_MeshGeneratorDelegate_Event2.CallWithSelf;
		spine_Unity_MeshGeneratorDelegate_Event2.method = meshGeneratorDelegate2.Method;
		return meshGeneratorDelegate2;
	}

	private bool Check_Spine_Unity_MeshGeneratorDelegate(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(MeshGeneratorDelegate), L, pos);
	}

	private void Push_Spine_Unity_MeshGeneratorDelegate(IntPtr L, MeshGeneratorDelegate o)
	{
		ToLua.Push(L, o);
	}

	public SkeletonRenderer.InstructionDelegate Spine_Unity_SkeletonRenderer_InstructionDelegate(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			Spine_Unity_SkeletonRenderer_InstructionDelegate_Event spine_Unity_SkeletonRenderer_InstructionDelegate_Event = new Spine_Unity_SkeletonRenderer_InstructionDelegate_Event(func);
			SkeletonRenderer.InstructionDelegate instructionDelegate = spine_Unity_SkeletonRenderer_InstructionDelegate_Event.Call;
			spine_Unity_SkeletonRenderer_InstructionDelegate_Event.method = instructionDelegate.Method;
			return instructionDelegate;
		}
		Spine_Unity_SkeletonRenderer_InstructionDelegate_Event spine_Unity_SkeletonRenderer_InstructionDelegate_Event2 = new Spine_Unity_SkeletonRenderer_InstructionDelegate_Event(func, self);
		SkeletonRenderer.InstructionDelegate instructionDelegate2 = spine_Unity_SkeletonRenderer_InstructionDelegate_Event2.CallWithSelf;
		spine_Unity_SkeletonRenderer_InstructionDelegate_Event2.method = instructionDelegate2.Method;
		return instructionDelegate2;
	}

	private bool Check_Spine_Unity_SkeletonRenderer_InstructionDelegate(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(SkeletonRenderer.InstructionDelegate), L, pos);
	}

	private void Push_Spine_Unity_SkeletonRenderer_InstructionDelegate(IntPtr L, SkeletonRenderer.InstructionDelegate o)
	{
		ToLua.Push(L, o);
	}

	public SkeletonRenderer.SkeletonRendererDelegate Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate_Event spine_Unity_SkeletonRenderer_SkeletonRendererDelegate_Event = new Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate_Event(func);
			SkeletonRenderer.SkeletonRendererDelegate skeletonRendererDelegate = spine_Unity_SkeletonRenderer_SkeletonRendererDelegate_Event.Call;
			spine_Unity_SkeletonRenderer_SkeletonRendererDelegate_Event.method = skeletonRendererDelegate.Method;
			return skeletonRendererDelegate;
		}
		Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate_Event spine_Unity_SkeletonRenderer_SkeletonRendererDelegate_Event2 = new Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate_Event(func, self);
		SkeletonRenderer.SkeletonRendererDelegate skeletonRendererDelegate2 = spine_Unity_SkeletonRenderer_SkeletonRendererDelegate_Event2.CallWithSelf;
		spine_Unity_SkeletonRenderer_SkeletonRendererDelegate_Event2.method = skeletonRendererDelegate2.Method;
		return skeletonRendererDelegate2;
	}

	private bool Check_Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(SkeletonRenderer.SkeletonRendererDelegate), L, pos);
	}

	private void Push_Spine_Unity_SkeletonRenderer_SkeletonRendererDelegate(IntPtr L, SkeletonRenderer.SkeletonRendererDelegate o)
	{
		ToLua.Push(L, o);
	}

	public Func<string, bool> System_Func_string_bool(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return (string param0) => false;
		}
		if (!flag)
		{
			System_Func_string_bool_Event system_Func_string_bool_Event = new System_Func_string_bool_Event(func);
			Func<string, bool> func2 = system_Func_string_bool_Event.Call;
			system_Func_string_bool_Event.method = func2.Method;
			return func2;
		}
		System_Func_string_bool_Event system_Func_string_bool_Event2 = new System_Func_string_bool_Event(func, self);
		Func<string, bool> func3 = system_Func_string_bool_Event2.CallWithSelf;
		system_Func_string_bool_Event2.method = func3.Method;
		return func3;
	}

	private bool Check_System_Func_string_bool(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Func<string, bool>), L, pos);
	}

	private void Push_System_Func_string_bool(IntPtr L, Func<string, bool> o)
	{
		ToLua.Push(L, o);
	}

	public AnimationState.TrackEntryDelegate Spine_AnimationState_TrackEntryDelegate(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			Spine_AnimationState_TrackEntryDelegate_Event spine_AnimationState_TrackEntryDelegate_Event = new Spine_AnimationState_TrackEntryDelegate_Event(func);
			AnimationState.TrackEntryDelegate trackEntryDelegate = spine_AnimationState_TrackEntryDelegate_Event.Call;
			spine_AnimationState_TrackEntryDelegate_Event.method = trackEntryDelegate.Method;
			return trackEntryDelegate;
		}
		Spine_AnimationState_TrackEntryDelegate_Event spine_AnimationState_TrackEntryDelegate_Event2 = new Spine_AnimationState_TrackEntryDelegate_Event(func, self);
		AnimationState.TrackEntryDelegate trackEntryDelegate2 = spine_AnimationState_TrackEntryDelegate_Event2.CallWithSelf;
		spine_AnimationState_TrackEntryDelegate_Event2.method = trackEntryDelegate2.Method;
		return trackEntryDelegate2;
	}

	private bool Check_Spine_AnimationState_TrackEntryDelegate(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(AnimationState.TrackEntryDelegate), L, pos);
	}

	private void Push_Spine_AnimationState_TrackEntryDelegate(IntPtr L, AnimationState.TrackEntryDelegate o)
	{
		ToLua.Push(L, o);
	}

	public AnimationState.TrackEntryEventDelegate Spine_AnimationState_TrackEntryEventDelegate(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			Spine_AnimationState_TrackEntryEventDelegate_Event spine_AnimationState_TrackEntryEventDelegate_Event = new Spine_AnimationState_TrackEntryEventDelegate_Event(func);
			AnimationState.TrackEntryEventDelegate trackEntryEventDelegate = spine_AnimationState_TrackEntryEventDelegate_Event.Call;
			spine_AnimationState_TrackEntryEventDelegate_Event.method = trackEntryEventDelegate.Method;
			return trackEntryEventDelegate;
		}
		Spine_AnimationState_TrackEntryEventDelegate_Event spine_AnimationState_TrackEntryEventDelegate_Event2 = new Spine_AnimationState_TrackEntryEventDelegate_Event(func, self);
		AnimationState.TrackEntryEventDelegate trackEntryEventDelegate2 = spine_AnimationState_TrackEntryEventDelegate_Event2.CallWithSelf;
		spine_AnimationState_TrackEntryEventDelegate_Event2.method = trackEntryEventDelegate2.Method;
		return trackEntryEventDelegate2;
	}

	private bool Check_Spine_AnimationState_TrackEntryEventDelegate(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(AnimationState.TrackEntryEventDelegate), L, pos);
	}

	private void Push_Spine_AnimationState_TrackEntryEventDelegate(IntPtr L, AnimationState.TrackEntryEventDelegate o)
	{
		ToLua.Push(L, o);
	}

	public Action<object> System_Action_object(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_object_Event system_Action_object_Event = new System_Action_object_Event(func);
			Action<object> action = system_Action_object_Event.Call;
			system_Action_object_Event.method = action.Method;
			return action;
		}
		System_Action_object_Event system_Action_object_Event2 = new System_Action_object_Event(func, self);
		Action<object> action2 = system_Action_object_Event2.CallWithSelf;
		system_Action_object_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_object(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<object>), L, pos);
	}

	private void Push_System_Action_object(IntPtr L, Action<object> o)
	{
		ToLua.Push(L, o);
	}

	public Action<float> System_Action_float(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_float_Event system_Action_float_Event = new System_Action_float_Event(func);
			Action<float> action = system_Action_float_Event.Call;
			system_Action_float_Event.method = action.Method;
			return action;
		}
		System_Action_float_Event system_Action_float_Event2 = new System_Action_float_Event(func, self);
		Action<float> action2 = system_Action_float_Event2.CallWithSelf;
		system_Action_float_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_float(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<float>), L, pos);
	}

	private void Push_System_Action_float(IntPtr L, Action<float> o)
	{
		ToLua.Push(L, o);
	}

	public Action<float, float> System_Action_float_float(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_float_float_Event system_Action_float_float_Event = new System_Action_float_float_Event(func);
			Action<float, float> action = system_Action_float_float_Event.Call;
			system_Action_float_float_Event.method = action.Method;
			return action;
		}
		System_Action_float_float_Event system_Action_float_float_Event2 = new System_Action_float_float_Event(func, self);
		Action<float, float> action2 = system_Action_float_float_Event2.CallWithSelf;
		system_Action_float_float_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_float_float(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<float, float>), L, pos);
	}

	private void Push_System_Action_float_float(IntPtr L, Action<float, float> o)
	{
		ToLua.Push(L, o);
	}

	public Action<Color> System_Action_UnityEngine_Color(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_UnityEngine_Color_Event system_Action_UnityEngine_Color_Event = new System_Action_UnityEngine_Color_Event(func);
			Action<Color> action = system_Action_UnityEngine_Color_Event.Call;
			system_Action_UnityEngine_Color_Event.method = action.Method;
			return action;
		}
		System_Action_UnityEngine_Color_Event system_Action_UnityEngine_Color_Event2 = new System_Action_UnityEngine_Color_Event(func, self);
		Action<Color> action2 = system_Action_UnityEngine_Color_Event2.CallWithSelf;
		system_Action_UnityEngine_Color_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_UnityEngine_Color(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<Color>), L, pos);
	}

	private void Push_System_Action_UnityEngine_Color(IntPtr L, Action<Color> o)
	{
		ToLua.Push(L, o);
	}

	public Action<Color, object> System_Action_UnityEngine_Color_object(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_UnityEngine_Color_object_Event system_Action_UnityEngine_Color_object_Event = new System_Action_UnityEngine_Color_object_Event(func);
			Action<Color, object> action = system_Action_UnityEngine_Color_object_Event.Call;
			system_Action_UnityEngine_Color_object_Event.method = action.Method;
			return action;
		}
		System_Action_UnityEngine_Color_object_Event system_Action_UnityEngine_Color_object_Event2 = new System_Action_UnityEngine_Color_object_Event(func, self);
		Action<Color, object> action2 = system_Action_UnityEngine_Color_object_Event2.CallWithSelf;
		system_Action_UnityEngine_Color_object_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_UnityEngine_Color_object(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<Color, object>), L, pos);
	}

	private void Push_System_Action_UnityEngine_Color_object(IntPtr L, Action<Color, object> o)
	{
		ToLua.Push(L, o);
	}

	public Action<Vector2> System_Action_UnityEngine_Vector2(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_UnityEngine_Vector2_Event system_Action_UnityEngine_Vector2_Event = new System_Action_UnityEngine_Vector2_Event(func);
			Action<Vector2> action = system_Action_UnityEngine_Vector2_Event.Call;
			system_Action_UnityEngine_Vector2_Event.method = action.Method;
			return action;
		}
		System_Action_UnityEngine_Vector2_Event system_Action_UnityEngine_Vector2_Event2 = new System_Action_UnityEngine_Vector2_Event(func, self);
		Action<Vector2> action2 = system_Action_UnityEngine_Vector2_Event2.CallWithSelf;
		system_Action_UnityEngine_Vector2_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_UnityEngine_Vector2(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<Vector2>), L, pos);
	}

	private void Push_System_Action_UnityEngine_Vector2(IntPtr L, Action<Vector2> o)
	{
		ToLua.Push(L, o);
	}

	public Action<Vector3> System_Action_UnityEngine_Vector3(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_UnityEngine_Vector3_Event system_Action_UnityEngine_Vector3_Event = new System_Action_UnityEngine_Vector3_Event(func);
			Action<Vector3> action = system_Action_UnityEngine_Vector3_Event.Call;
			system_Action_UnityEngine_Vector3_Event.method = action.Method;
			return action;
		}
		System_Action_UnityEngine_Vector3_Event system_Action_UnityEngine_Vector3_Event2 = new System_Action_UnityEngine_Vector3_Event(func, self);
		Action<Vector3> action2 = system_Action_UnityEngine_Vector3_Event2.CallWithSelf;
		system_Action_UnityEngine_Vector3_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_UnityEngine_Vector3(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<Vector3>), L, pos);
	}

	private void Push_System_Action_UnityEngine_Vector3(IntPtr L, Action<Vector3> o)
	{
		ToLua.Push(L, o);
	}

	public Action<float, object> System_Action_float_object(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_float_object_Event system_Action_float_object_Event = new System_Action_float_object_Event(func);
			Action<float, object> action = system_Action_float_object_Event.Call;
			system_Action_float_object_Event.method = action.Method;
			return action;
		}
		System_Action_float_object_Event system_Action_float_object_Event2 = new System_Action_float_object_Event(func, self);
		Action<float, object> action2 = system_Action_float_object_Event2.CallWithSelf;
		system_Action_float_object_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_float_object(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<float, object>), L, pos);
	}

	private void Push_System_Action_float_object(IntPtr L, Action<float, object> o)
	{
		ToLua.Push(L, o);
	}

	public Action<Vector3, object> System_Action_UnityEngine_Vector3_object(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_UnityEngine_Vector3_object_Event system_Action_UnityEngine_Vector3_object_Event = new System_Action_UnityEngine_Vector3_object_Event(func);
			Action<Vector3, object> action = system_Action_UnityEngine_Vector3_object_Event.Call;
			system_Action_UnityEngine_Vector3_object_Event.method = action.Method;
			return action;
		}
		System_Action_UnityEngine_Vector3_object_Event system_Action_UnityEngine_Vector3_object_Event2 = new System_Action_UnityEngine_Vector3_object_Event(func, self);
		Action<Vector3, object> action2 = system_Action_UnityEngine_Vector3_object_Event2.CallWithSelf;
		system_Action_UnityEngine_Vector3_object_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_UnityEngine_Vector3_object(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<Vector3, object>), L, pos);
	}

	private void Push_System_Action_UnityEngine_Vector3_object(IntPtr L, Action<Vector3, object> o)
	{
		ToLua.Push(L, o);
	}

	public LuaHelper.ETLCallBack1 LuaHelper_ETLCallBack1(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			LuaHelper_ETLCallBack1_Event luaHelper_ETLCallBack1_Event = new LuaHelper_ETLCallBack1_Event(func);
			LuaHelper.ETLCallBack1 eTLCallBack = luaHelper_ETLCallBack1_Event.Call;
			luaHelper_ETLCallBack1_Event.method = eTLCallBack.Method;
			return eTLCallBack;
		}
		LuaHelper_ETLCallBack1_Event luaHelper_ETLCallBack1_Event2 = new LuaHelper_ETLCallBack1_Event(func, self);
		LuaHelper.ETLCallBack1 eTLCallBack2 = luaHelper_ETLCallBack1_Event2.CallWithSelf;
		luaHelper_ETLCallBack1_Event2.method = eTLCallBack2.Method;
		return eTLCallBack2;
	}

	private bool Check_LuaHelper_ETLCallBack1(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(LuaHelper.ETLCallBack1), L, pos);
	}

	private void Push_LuaHelper_ETLCallBack1(IntPtr L, LuaHelper.ETLCallBack1 o)
	{
		ToLua.Push(L, o);
	}

	public LuaHelper.ETLCallBack2 LuaHelper_ETLCallBack2(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			LuaHelper_ETLCallBack2_Event luaHelper_ETLCallBack2_Event = new LuaHelper_ETLCallBack2_Event(func);
			LuaHelper.ETLCallBack2 eTLCallBack = luaHelper_ETLCallBack2_Event.Call;
			luaHelper_ETLCallBack2_Event.method = eTLCallBack.Method;
			return eTLCallBack;
		}
		LuaHelper_ETLCallBack2_Event luaHelper_ETLCallBack2_Event2 = new LuaHelper_ETLCallBack2_Event(func, self);
		LuaHelper.ETLCallBack2 eTLCallBack2 = luaHelper_ETLCallBack2_Event2.CallWithSelf;
		luaHelper_ETLCallBack2_Event2.method = eTLCallBack2.Method;
		return eTLCallBack2;
	}

	private bool Check_LuaHelper_ETLCallBack2(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(LuaHelper.ETLCallBack2), L, pos);
	}

	private void Push_LuaHelper_ETLCallBack2(IntPtr L, LuaHelper.ETLCallBack2 o)
	{
		ToLua.Push(L, o);
	}

	public LuaHelper.ETLCallBack3 LuaHelper_ETLCallBack3(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			LuaHelper_ETLCallBack3_Event luaHelper_ETLCallBack3_Event = new LuaHelper_ETLCallBack3_Event(func);
			LuaHelper.ETLCallBack3 eTLCallBack = luaHelper_ETLCallBack3_Event.Call;
			luaHelper_ETLCallBack3_Event.method = eTLCallBack.Method;
			return eTLCallBack;
		}
		LuaHelper_ETLCallBack3_Event luaHelper_ETLCallBack3_Event2 = new LuaHelper_ETLCallBack3_Event(func, self);
		LuaHelper.ETLCallBack3 eTLCallBack2 = luaHelper_ETLCallBack3_Event2.CallWithSelf;
		luaHelper_ETLCallBack3_Event2.method = eTLCallBack2.Method;
		return eTLCallBack2;
	}

	private bool Check_LuaHelper_ETLCallBack3(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(LuaHelper.ETLCallBack3), L, pos);
	}

	private void Push_LuaHelper_ETLCallBack3(IntPtr L, LuaHelper.ETLCallBack3 o)
	{
		ToLua.Push(L, o);
	}

	public Action<Vector3, int> System_Action_UnityEngine_Vector3_int(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_UnityEngine_Vector3_int_Event system_Action_UnityEngine_Vector3_int_Event = new System_Action_UnityEngine_Vector3_int_Event(func);
			Action<Vector3, int> action = system_Action_UnityEngine_Vector3_int_Event.Call;
			system_Action_UnityEngine_Vector3_int_Event.method = action.Method;
			return action;
		}
		System_Action_UnityEngine_Vector3_int_Event system_Action_UnityEngine_Vector3_int_Event2 = new System_Action_UnityEngine_Vector3_int_Event(func, self);
		Action<Vector3, int> action2 = system_Action_UnityEngine_Vector3_int_Event2.CallWithSelf;
		system_Action_UnityEngine_Vector3_int_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_UnityEngine_Vector3_int(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<Vector3, int>), L, pos);
	}

	private void Push_System_Action_UnityEngine_Vector3_int(IntPtr L, Action<Vector3, int> o)
	{
		ToLua.Push(L, o);
	}

	public Func<Vector3, bool> System_Func_UnityEngine_Vector3_bool(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return (Vector3 param0) => false;
		}
		if (!flag)
		{
			System_Func_UnityEngine_Vector3_bool_Event system_Func_UnityEngine_Vector3_bool_Event = new System_Func_UnityEngine_Vector3_bool_Event(func);
			Func<Vector3, bool> func2 = system_Func_UnityEngine_Vector3_bool_Event.Call;
			system_Func_UnityEngine_Vector3_bool_Event.method = func2.Method;
			return func2;
		}
		System_Func_UnityEngine_Vector3_bool_Event system_Func_UnityEngine_Vector3_bool_Event2 = new System_Func_UnityEngine_Vector3_bool_Event(func, self);
		Func<Vector3, bool> func3 = system_Func_UnityEngine_Vector3_bool_Event2.CallWithSelf;
		system_Func_UnityEngine_Vector3_bool_Event2.method = func3.Method;
		return func3;
	}

	private bool Check_System_Func_UnityEngine_Vector3_bool(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Func<Vector3, bool>), L, pos);
	}

	private void Push_System_Func_UnityEngine_Vector3_bool(IntPtr L, Func<Vector3, bool> o)
	{
		ToLua.Push(L, o);
	}

	public UnityAction<SpriteRenderer> UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer_Event unityEngine_Events_UnityAction_UnityEngine_SpriteRenderer_Event = new UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer_Event(func);
			UnityAction<SpriteRenderer> unityAction = unityEngine_Events_UnityAction_UnityEngine_SpriteRenderer_Event.Call;
			unityEngine_Events_UnityAction_UnityEngine_SpriteRenderer_Event.method = unityAction.Method;
			return unityAction;
		}
		UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer_Event unityEngine_Events_UnityAction_UnityEngine_SpriteRenderer_Event2 = new UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer_Event(func, self);
		UnityAction<SpriteRenderer> unityAction2 = unityEngine_Events_UnityAction_UnityEngine_SpriteRenderer_Event2.CallWithSelf;
		unityEngine_Events_UnityAction_UnityEngine_SpriteRenderer_Event2.method = unityAction2.Method;
		return unityAction2;
	}

	private bool Check_UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UnityAction<SpriteRenderer>), L, pos);
	}

	private void Push_UnityEngine_Events_UnityAction_UnityEngine_SpriteRenderer(IntPtr L, UnityAction<SpriteRenderer> o)
	{
		ToLua.Push(L, o);
	}

	public VideoPlayer.EventHandler UnityEngine_Video_VideoPlayer_EventHandler(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Video_VideoPlayer_EventHandler_Event unityEngine_Video_VideoPlayer_EventHandler_Event = new UnityEngine_Video_VideoPlayer_EventHandler_Event(func);
			VideoPlayer.EventHandler eventHandler = unityEngine_Video_VideoPlayer_EventHandler_Event.Call;
			unityEngine_Video_VideoPlayer_EventHandler_Event.method = eventHandler.Method;
			return eventHandler;
		}
		UnityEngine_Video_VideoPlayer_EventHandler_Event unityEngine_Video_VideoPlayer_EventHandler_Event2 = new UnityEngine_Video_VideoPlayer_EventHandler_Event(func, self);
		VideoPlayer.EventHandler eventHandler2 = unityEngine_Video_VideoPlayer_EventHandler_Event2.CallWithSelf;
		unityEngine_Video_VideoPlayer_EventHandler_Event2.method = eventHandler2.Method;
		return eventHandler2;
	}

	private bool Check_UnityEngine_Video_VideoPlayer_EventHandler(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(VideoPlayer.EventHandler), L, pos);
	}

	private void Push_UnityEngine_Video_VideoPlayer_EventHandler(IntPtr L, VideoPlayer.EventHandler o)
	{
		ToLua.Push(L, o);
	}

	public VideoPlayer.ErrorEventHandler UnityEngine_Video_VideoPlayer_ErrorEventHandler(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Video_VideoPlayer_ErrorEventHandler_Event unityEngine_Video_VideoPlayer_ErrorEventHandler_Event = new UnityEngine_Video_VideoPlayer_ErrorEventHandler_Event(func);
			VideoPlayer.ErrorEventHandler errorEventHandler = unityEngine_Video_VideoPlayer_ErrorEventHandler_Event.Call;
			unityEngine_Video_VideoPlayer_ErrorEventHandler_Event.method = errorEventHandler.Method;
			return errorEventHandler;
		}
		UnityEngine_Video_VideoPlayer_ErrorEventHandler_Event unityEngine_Video_VideoPlayer_ErrorEventHandler_Event2 = new UnityEngine_Video_VideoPlayer_ErrorEventHandler_Event(func, self);
		VideoPlayer.ErrorEventHandler errorEventHandler2 = unityEngine_Video_VideoPlayer_ErrorEventHandler_Event2.CallWithSelf;
		unityEngine_Video_VideoPlayer_ErrorEventHandler_Event2.method = errorEventHandler2.Method;
		return errorEventHandler2;
	}

	private bool Check_UnityEngine_Video_VideoPlayer_ErrorEventHandler(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(VideoPlayer.ErrorEventHandler), L, pos);
	}

	private void Push_UnityEngine_Video_VideoPlayer_ErrorEventHandler(IntPtr L, VideoPlayer.ErrorEventHandler o)
	{
		ToLua.Push(L, o);
	}

	public VideoPlayer.TimeEventHandler UnityEngine_Video_VideoPlayer_TimeEventHandler(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Video_VideoPlayer_TimeEventHandler_Event unityEngine_Video_VideoPlayer_TimeEventHandler_Event = new UnityEngine_Video_VideoPlayer_TimeEventHandler_Event(func);
			VideoPlayer.TimeEventHandler timeEventHandler = unityEngine_Video_VideoPlayer_TimeEventHandler_Event.Call;
			unityEngine_Video_VideoPlayer_TimeEventHandler_Event.method = timeEventHandler.Method;
			return timeEventHandler;
		}
		UnityEngine_Video_VideoPlayer_TimeEventHandler_Event unityEngine_Video_VideoPlayer_TimeEventHandler_Event2 = new UnityEngine_Video_VideoPlayer_TimeEventHandler_Event(func, self);
		VideoPlayer.TimeEventHandler timeEventHandler2 = unityEngine_Video_VideoPlayer_TimeEventHandler_Event2.CallWithSelf;
		unityEngine_Video_VideoPlayer_TimeEventHandler_Event2.method = timeEventHandler2.Method;
		return timeEventHandler2;
	}

	private bool Check_UnityEngine_Video_VideoPlayer_TimeEventHandler(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(VideoPlayer.TimeEventHandler), L, pos);
	}

	private void Push_UnityEngine_Video_VideoPlayer_TimeEventHandler(IntPtr L, VideoPlayer.TimeEventHandler o)
	{
		ToLua.Push(L, o);
	}

	public VideoPlayer.FrameReadyEventHandler UnityEngine_Video_VideoPlayer_FrameReadyEventHandler(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Video_VideoPlayer_FrameReadyEventHandler_Event unityEngine_Video_VideoPlayer_FrameReadyEventHandler_Event = new UnityEngine_Video_VideoPlayer_FrameReadyEventHandler_Event(func);
			VideoPlayer.FrameReadyEventHandler frameReadyEventHandler = unityEngine_Video_VideoPlayer_FrameReadyEventHandler_Event.Call;
			unityEngine_Video_VideoPlayer_FrameReadyEventHandler_Event.method = frameReadyEventHandler.Method;
			return frameReadyEventHandler;
		}
		UnityEngine_Video_VideoPlayer_FrameReadyEventHandler_Event unityEngine_Video_VideoPlayer_FrameReadyEventHandler_Event2 = new UnityEngine_Video_VideoPlayer_FrameReadyEventHandler_Event(func, self);
		VideoPlayer.FrameReadyEventHandler frameReadyEventHandler2 = unityEngine_Video_VideoPlayer_FrameReadyEventHandler_Event2.CallWithSelf;
		unityEngine_Video_VideoPlayer_FrameReadyEventHandler_Event2.method = frameReadyEventHandler2.Method;
		return frameReadyEventHandler2;
	}

	private bool Check_UnityEngine_Video_VideoPlayer_FrameReadyEventHandler(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(VideoPlayer.FrameReadyEventHandler), L, pos);
	}

	private void Push_UnityEngine_Video_VideoPlayer_FrameReadyEventHandler(IntPtr L, VideoPlayer.FrameReadyEventHandler o)
	{
		ToLua.Push(L, o);
	}

	public Action<PlayableDirector> System_Action_UnityEngine_Playables_PlayableDirector(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_UnityEngine_Playables_PlayableDirector_Event system_Action_UnityEngine_Playables_PlayableDirector_Event = new System_Action_UnityEngine_Playables_PlayableDirector_Event(func);
			Action<PlayableDirector> action = system_Action_UnityEngine_Playables_PlayableDirector_Event.Call;
			system_Action_UnityEngine_Playables_PlayableDirector_Event.method = action.Method;
			return action;
		}
		System_Action_UnityEngine_Playables_PlayableDirector_Event system_Action_UnityEngine_Playables_PlayableDirector_Event2 = new System_Action_UnityEngine_Playables_PlayableDirector_Event(func, self);
		Action<PlayableDirector> action2 = system_Action_UnityEngine_Playables_PlayableDirector_Event2.CallWithSelf;
		system_Action_UnityEngine_Playables_PlayableDirector_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_UnityEngine_Playables_PlayableDirector(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<PlayableDirector>), L, pos);
	}

	private void Push_System_Action_UnityEngine_Playables_PlayableDirector(IntPtr L, Action<PlayableDirector> o)
	{
		ToLua.Push(L, o);
	}

	public UnityAction<BaseEventData> UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData_Event unityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData_Event = new UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData_Event(func);
			UnityAction<BaseEventData> unityAction = unityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData_Event.Call;
			unityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData_Event.method = unityAction.Method;
			return unityAction;
		}
		UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData_Event unityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData_Event2 = new UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData_Event(func, self);
		UnityAction<BaseEventData> unityAction2 = unityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData_Event2.CallWithSelf;
		unityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData_Event2.method = unityAction2.Method;
		return unityAction2;
	}

	private bool Check_UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UnityAction<BaseEventData>), L, pos);
	}

	private void Push_UnityEngine_Events_UnityAction_UnityEngine_EventSystems_BaseEventData(IntPtr L, UnityAction<BaseEventData> o)
	{
		ToLua.Push(L, o);
	}

	public UnityAction<bool> UnityEngine_Events_UnityAction_bool(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Events_UnityAction_bool_Event unityEngine_Events_UnityAction_bool_Event = new UnityEngine_Events_UnityAction_bool_Event(func);
			UnityAction<bool> unityAction = unityEngine_Events_UnityAction_bool_Event.Call;
			unityEngine_Events_UnityAction_bool_Event.method = unityAction.Method;
			return unityAction;
		}
		UnityEngine_Events_UnityAction_bool_Event unityEngine_Events_UnityAction_bool_Event2 = new UnityEngine_Events_UnityAction_bool_Event(func, self);
		UnityAction<bool> unityAction2 = unityEngine_Events_UnityAction_bool_Event2.CallWithSelf;
		unityEngine_Events_UnityAction_bool_Event2.method = unityAction2.Method;
		return unityAction2;
	}

	private bool Check_UnityEngine_Events_UnityAction_bool(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UnityAction<bool>), L, pos);
	}

	private void Push_UnityEngine_Events_UnityAction_bool(IntPtr L, UnityAction<bool> o)
	{
		ToLua.Push(L, o);
	}

	public UnityAction<int> UnityEngine_Events_UnityAction_int(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Events_UnityAction_int_Event unityEngine_Events_UnityAction_int_Event = new UnityEngine_Events_UnityAction_int_Event(func);
			UnityAction<int> unityAction = unityEngine_Events_UnityAction_int_Event.Call;
			unityEngine_Events_UnityAction_int_Event.method = unityAction.Method;
			return unityAction;
		}
		UnityEngine_Events_UnityAction_int_Event unityEngine_Events_UnityAction_int_Event2 = new UnityEngine_Events_UnityAction_int_Event(func, self);
		UnityAction<int> unityAction2 = unityEngine_Events_UnityAction_int_Event2.CallWithSelf;
		unityEngine_Events_UnityAction_int_Event2.method = unityAction2.Method;
		return unityAction2;
	}

	private bool Check_UnityEngine_Events_UnityAction_int(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UnityAction<int>), L, pos);
	}

	private void Push_UnityEngine_Events_UnityAction_int(IntPtr L, UnityAction<int> o)
	{
		ToLua.Push(L, o);
	}

	public UnityAction<float> UnityEngine_Events_UnityAction_float(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Events_UnityAction_float_Event unityEngine_Events_UnityAction_float_Event = new UnityEngine_Events_UnityAction_float_Event(func);
			UnityAction<float> unityAction = unityEngine_Events_UnityAction_float_Event.Call;
			unityEngine_Events_UnityAction_float_Event.method = unityAction.Method;
			return unityAction;
		}
		UnityEngine_Events_UnityAction_float_Event unityEngine_Events_UnityAction_float_Event2 = new UnityEngine_Events_UnityAction_float_Event(func, self);
		UnityAction<float> unityAction2 = unityEngine_Events_UnityAction_float_Event2.CallWithSelf;
		unityEngine_Events_UnityAction_float_Event2.method = unityAction2.Method;
		return unityAction2;
	}

	private bool Check_UnityEngine_Events_UnityAction_float(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UnityAction<float>), L, pos);
	}

	private void Push_UnityEngine_Events_UnityAction_float(IntPtr L, UnityAction<float> o)
	{
		ToLua.Push(L, o);
	}

	public UnityAction<Vector2> UnityEngine_Events_UnityAction_UnityEngine_Vector2(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Events_UnityAction_UnityEngine_Vector2_Event unityEngine_Events_UnityAction_UnityEngine_Vector2_Event = new UnityEngine_Events_UnityAction_UnityEngine_Vector2_Event(func);
			UnityAction<Vector2> unityAction = unityEngine_Events_UnityAction_UnityEngine_Vector2_Event.Call;
			unityEngine_Events_UnityAction_UnityEngine_Vector2_Event.method = unityAction.Method;
			return unityAction;
		}
		UnityEngine_Events_UnityAction_UnityEngine_Vector2_Event unityEngine_Events_UnityAction_UnityEngine_Vector2_Event2 = new UnityEngine_Events_UnityAction_UnityEngine_Vector2_Event(func, self);
		UnityAction<Vector2> unityAction2 = unityEngine_Events_UnityAction_UnityEngine_Vector2_Event2.CallWithSelf;
		unityEngine_Events_UnityAction_UnityEngine_Vector2_Event2.method = unityAction2.Method;
		return unityAction2;
	}

	private bool Check_UnityEngine_Events_UnityAction_UnityEngine_Vector2(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UnityAction<Vector2>), L, pos);
	}

	private void Push_UnityEngine_Events_UnityAction_UnityEngine_Vector2(IntPtr L, UnityAction<Vector2> o)
	{
		ToLua.Push(L, o);
	}

	public Func<ILayoutElement, float> System_Func_UnityEngine_UI_ILayoutElement_float(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return (ILayoutElement param0) => 0f;
		}
		if (!flag)
		{
			System_Func_UnityEngine_UI_ILayoutElement_float_Event system_Func_UnityEngine_UI_ILayoutElement_float_Event = new System_Func_UnityEngine_UI_ILayoutElement_float_Event(func);
			Func<ILayoutElement, float> func2 = system_Func_UnityEngine_UI_ILayoutElement_float_Event.Call;
			system_Func_UnityEngine_UI_ILayoutElement_float_Event.method = func2.Method;
			return func2;
		}
		System_Func_UnityEngine_UI_ILayoutElement_float_Event system_Func_UnityEngine_UI_ILayoutElement_float_Event2 = new System_Func_UnityEngine_UI_ILayoutElement_float_Event(func, self);
		Func<ILayoutElement, float> func3 = system_Func_UnityEngine_UI_ILayoutElement_float_Event2.CallWithSelf;
		system_Func_UnityEngine_UI_ILayoutElement_float_Event2.method = func3.Method;
		return func3;
	}

	private bool Check_System_Func_UnityEngine_UI_ILayoutElement_float(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Func<ILayoutElement, float>), L, pos);
	}

	private void Push_System_Func_UnityEngine_UI_ILayoutElement_float(IntPtr L, Func<ILayoutElement, float> o)
	{
		ToLua.Push(L, o);
	}

	public UnityAction<Scene, LoadSceneMode> UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode_Event unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode_Event = new UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode_Event(func);
			UnityAction<Scene, LoadSceneMode> unityAction = unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode_Event.Call;
			unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode_Event.method = unityAction.Method;
			return unityAction;
		}
		UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode_Event unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode_Event2 = new UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode_Event(func, self);
		UnityAction<Scene, LoadSceneMode> unityAction2 = unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode_Event2.CallWithSelf;
		unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode_Event2.method = unityAction2.Method;
		return unityAction2;
	}

	private bool Check_UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UnityAction<Scene, LoadSceneMode>), L, pos);
	}

	private void Push_UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_LoadSceneMode(IntPtr L, UnityAction<Scene, LoadSceneMode> o)
	{
		ToLua.Push(L, o);
	}

	public UnityAction<Scene> UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_Event unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_Event = new UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_Event(func);
			UnityAction<Scene> unityAction = unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_Event.Call;
			unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_Event.method = unityAction.Method;
			return unityAction;
		}
		UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_Event unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_Event2 = new UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_Event(func, self);
		UnityAction<Scene> unityAction2 = unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_Event2.CallWithSelf;
		unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_Event2.method = unityAction2.Method;
		return unityAction2;
	}

	private bool Check_UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UnityAction<Scene>), L, pos);
	}

	private void Push_UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene(IntPtr L, UnityAction<Scene> o)
	{
		ToLua.Push(L, o);
	}

	public UnityAction<Scene, Scene> UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene_Event unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene_Event = new UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene_Event(func);
			UnityAction<Scene, Scene> unityAction = unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene_Event.Call;
			unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene_Event.method = unityAction.Method;
			return unityAction;
		}
		UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene_Event unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene_Event2 = new UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene_Event(func, self);
		UnityAction<Scene, Scene> unityAction2 = unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene_Event2.CallWithSelf;
		unityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene_Event2.method = unityAction2.Method;
		return unityAction2;
	}

	private bool Check_UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UnityAction<Scene, Scene>), L, pos);
	}

	private void Push_UnityEngine_Events_UnityAction_UnityEngine_SceneManagement_Scene_UnityEngine_SceneManagement_Scene(IntPtr L, UnityAction<Scene, Scene> o)
	{
		ToLua.Push(L, o);
	}

	public UnityAction<DownloadRequest> UnityEngine_Events_UnityAction_DownloadRequest(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Events_UnityAction_DownloadRequest_Event unityEngine_Events_UnityAction_DownloadRequest_Event = new UnityEngine_Events_UnityAction_DownloadRequest_Event(func);
			UnityAction<DownloadRequest> unityAction = unityEngine_Events_UnityAction_DownloadRequest_Event.Call;
			unityEngine_Events_UnityAction_DownloadRequest_Event.method = unityAction.Method;
			return unityAction;
		}
		UnityEngine_Events_UnityAction_DownloadRequest_Event unityEngine_Events_UnityAction_DownloadRequest_Event2 = new UnityEngine_Events_UnityAction_DownloadRequest_Event(func, self);
		UnityAction<DownloadRequest> unityAction2 = unityEngine_Events_UnityAction_DownloadRequest_Event2.CallWithSelf;
		unityEngine_Events_UnityAction_DownloadRequest_Event2.method = unityAction2.Method;
		return unityAction2;
	}

	private bool Check_UnityEngine_Events_UnityAction_DownloadRequest(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UnityAction<DownloadRequest>), L, pos);
	}

	private void Push_UnityEngine_Events_UnityAction_DownloadRequest(IntPtr L, UnityAction<DownloadRequest> o)
	{
		ToLua.Push(L, o);
	}

	public OnVoidHandler<Sprite> OnVoidHandler_UnityEngine_Sprite(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			OnVoidHandler_UnityEngine_Sprite_Event onVoidHandler_UnityEngine_Sprite_Event = new OnVoidHandler_UnityEngine_Sprite_Event(func);
			OnVoidHandler<Sprite> onVoidHandler = onVoidHandler_UnityEngine_Sprite_Event.Call;
			onVoidHandler_UnityEngine_Sprite_Event.method = onVoidHandler.Method;
			return onVoidHandler;
		}
		OnVoidHandler_UnityEngine_Sprite_Event onVoidHandler_UnityEngine_Sprite_Event2 = new OnVoidHandler_UnityEngine_Sprite_Event(func, self);
		OnVoidHandler<Sprite> onVoidHandler2 = onVoidHandler_UnityEngine_Sprite_Event2.CallWithSelf;
		onVoidHandler_UnityEngine_Sprite_Event2.method = onVoidHandler2.Method;
		return onVoidHandler2;
	}

	private bool Check_OnVoidHandler_UnityEngine_Sprite(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(OnVoidHandler<Sprite>), L, pos);
	}

	private void Push_OnVoidHandler_UnityEngine_Sprite(IntPtr L, OnVoidHandler<Sprite> o)
	{
		ToLua.Push(L, o);
	}

	public Action<string, string> System_Action_string_string(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_string_string_Event system_Action_string_string_Event = new System_Action_string_string_Event(func);
			Action<string, string> action = system_Action_string_string_Event.Call;
			system_Action_string_string_Event.method = action.Method;
			return action;
		}
		System_Action_string_string_Event system_Action_string_string_Event2 = new System_Action_string_string_Event(func, self);
		Action<string, string> action2 = system_Action_string_string_Event2.CallWithSelf;
		system_Action_string_string_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_string_string(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<string, string>), L, pos);
	}

	private void Push_System_Action_string_string(IntPtr L, Action<string, string> o)
	{
		ToLua.Push(L, o);
	}

	public Action<SpriteAtlas> System_Action_UnityEngine_U2D_SpriteAtlas(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_UnityEngine_U2D_SpriteAtlas_Event system_Action_UnityEngine_U2D_SpriteAtlas_Event = new System_Action_UnityEngine_U2D_SpriteAtlas_Event(func);
			Action<SpriteAtlas> action = system_Action_UnityEngine_U2D_SpriteAtlas_Event.Call;
			system_Action_UnityEngine_U2D_SpriteAtlas_Event.method = action.Method;
			return action;
		}
		System_Action_UnityEngine_U2D_SpriteAtlas_Event system_Action_UnityEngine_U2D_SpriteAtlas_Event2 = new System_Action_UnityEngine_U2D_SpriteAtlas_Event(func, self);
		Action<SpriteAtlas> action2 = system_Action_UnityEngine_U2D_SpriteAtlas_Event2.CallWithSelf;
		system_Action_UnityEngine_U2D_SpriteAtlas_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_UnityEngine_U2D_SpriteAtlas(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<SpriteAtlas>), L, pos);
	}

	private void Push_System_Action_UnityEngine_U2D_SpriteAtlas(IntPtr L, Action<SpriteAtlas> o)
	{
		ToLua.Push(L, o);
	}

	public Action<bool, string> System_Action_bool_string(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_bool_string_Event system_Action_bool_string_Event = new System_Action_bool_string_Event(func);
			Action<bool, string> action = system_Action_bool_string_Event.Call;
			system_Action_bool_string_Event.method = action.Method;
			return action;
		}
		System_Action_bool_string_Event system_Action_bool_string_Event2 = new System_Action_bool_string_Event(func, self);
		Action<bool, string> action2 = system_Action_bool_string_Event2.CallWithSelf;
		system_Action_bool_string_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_bool_string(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<bool, string>), L, pos);
	}

	private void Push_System_Action_bool_string(IntPtr L, Action<bool, string> o)
	{
		ToLua.Push(L, o);
	}

	public Action<int, string, string, int> System_Action_int_string_string_int(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_int_string_string_int_Event system_Action_int_string_string_int_Event = new System_Action_int_string_string_int_Event(func);
			Action<int, string, string, int> action = system_Action_int_string_string_int_Event.Call;
			system_Action_int_string_string_int_Event.method = action.Method;
			return action;
		}
		System_Action_int_string_string_int_Event system_Action_int_string_string_int_Event2 = new System_Action_int_string_string_int_Event(func, self);
		Action<int, string, string, int> action2 = system_Action_int_string_string_int_Event2.CallWithSelf;
		system_Action_int_string_string_int_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_int_string_string_int(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<int, string, string, int>), L, pos);
	}

	private void Push_System_Action_int_string_string_int(IntPtr L, Action<int, string, string, int> o)
	{
		ToLua.Push(L, o);
	}

	public Action<LoadingUIType> System_Action_LoadingUIType(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_LoadingUIType_Event system_Action_LoadingUIType_Event = new System_Action_LoadingUIType_Event(func);
			Action<LoadingUIType> action = system_Action_LoadingUIType_Event.Call;
			system_Action_LoadingUIType_Event.method = action.Method;
			return action;
		}
		System_Action_LoadingUIType_Event system_Action_LoadingUIType_Event2 = new System_Action_LoadingUIType_Event(func, self);
		Action<LoadingUIType> action2 = system_Action_LoadingUIType_Event2.CallWithSelf;
		system_Action_LoadingUIType_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_LoadingUIType(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<LoadingUIType>), L, pos);
	}

	private void Push_System_Action_LoadingUIType(IntPtr L, Action<LoadingUIType> o)
	{
		ToLua.Push(L, o);
	}

	public UnityAction<Sprite> UnityEngine_Events_UnityAction_UnityEngine_Sprite(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			UnityEngine_Events_UnityAction_UnityEngine_Sprite_Event unityEngine_Events_UnityAction_UnityEngine_Sprite_Event = new UnityEngine_Events_UnityAction_UnityEngine_Sprite_Event(func);
			UnityAction<Sprite> unityAction = unityEngine_Events_UnityAction_UnityEngine_Sprite_Event.Call;
			unityEngine_Events_UnityAction_UnityEngine_Sprite_Event.method = unityAction.Method;
			return unityAction;
		}
		UnityEngine_Events_UnityAction_UnityEngine_Sprite_Event unityEngine_Events_UnityAction_UnityEngine_Sprite_Event2 = new UnityEngine_Events_UnityAction_UnityEngine_Sprite_Event(func, self);
		UnityAction<Sprite> unityAction2 = unityEngine_Events_UnityAction_UnityEngine_Sprite_Event2.CallWithSelf;
		unityEngine_Events_UnityAction_UnityEngine_Sprite_Event2.method = unityAction2.Method;
		return unityAction2;
	}

	private bool Check_UnityEngine_Events_UnityAction_UnityEngine_Sprite(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(UnityAction<Sprite>), L, pos);
	}

	private void Push_UnityEngine_Events_UnityAction_UnityEngine_Sprite(IntPtr L, UnityAction<Sprite> o)
	{
		ToLua.Push(L, o);
	}

	public Action<string[], string[]> System_Action_strings_strings(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_strings_strings_Event system_Action_strings_strings_Event = new System_Action_strings_strings_Event(func);
			Action<string[], string[]> action = system_Action_strings_strings_Event.Call;
			system_Action_strings_strings_Event.method = action.Method;
			return action;
		}
		System_Action_strings_strings_Event system_Action_strings_strings_Event2 = new System_Action_strings_strings_Event(func, self);
		Action<string[], string[]> action2 = system_Action_strings_strings_Event2.CallWithSelf;
		system_Action_strings_strings_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_strings_strings(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<string[], string[]>), L, pos);
	}

	private void Push_System_Action_strings_strings(IntPtr L, Action<string[], string[]> o)
	{
		ToLua.Push(L, o);
	}

	public Action<int, GameObject> System_Action_int_UnityEngine_GameObject(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_int_UnityEngine_GameObject_Event system_Action_int_UnityEngine_GameObject_Event = new System_Action_int_UnityEngine_GameObject_Event(func);
			Action<int, GameObject> action = system_Action_int_UnityEngine_GameObject_Event.Call;
			system_Action_int_UnityEngine_GameObject_Event.method = action.Method;
			return action;
		}
		System_Action_int_UnityEngine_GameObject_Event system_Action_int_UnityEngine_GameObject_Event2 = new System_Action_int_UnityEngine_GameObject_Event(func, self);
		Action<int, GameObject> action2 = system_Action_int_UnityEngine_GameObject_Event2.CallWithSelf;
		system_Action_int_UnityEngine_GameObject_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_int_UnityEngine_GameObject(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<int, GameObject>), L, pos);
	}

	private void Push_System_Action_int_UnityEngine_GameObject(IntPtr L, Action<int, GameObject> o)
	{
		ToLua.Push(L, o);
	}

	public Action<int, int> System_Action_int_int(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_int_int_Event system_Action_int_int_Event = new System_Action_int_int_Event(func);
			Action<int, int> action = system_Action_int_int_Event.Call;
			system_Action_int_int_Event.method = action.Method;
			return action;
		}
		System_Action_int_int_Event system_Action_int_int_Event2 = new System_Action_int_int_Event(func, self);
		Action<int, int> action2 = system_Action_int_int_Event2.CallWithSelf;
		system_Action_int_int_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_int_int(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<int, int>), L, pos);
	}

	private void Push_System_Action_int_int(IntPtr L, Action<int, int> o)
	{
		ToLua.Push(L, o);
	}

	public Action<int, int, string, string> System_Action_int_int_string_string(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_int_int_string_string_Event system_Action_int_int_string_string_Event = new System_Action_int_int_string_string_Event(func);
			Action<int, int, string, string> action = system_Action_int_int_string_string_Event.Call;
			system_Action_int_int_string_string_Event.method = action.Method;
			return action;
		}
		System_Action_int_int_string_string_Event system_Action_int_int_string_string_Event2 = new System_Action_int_int_string_string_Event(func, self);
		Action<int, int, string, string> action2 = system_Action_int_int_string_string_Event2.CallWithSelf;
		system_Action_int_int_string_string_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_int_int_string_string(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<int, int, string, string>), L, pos);
	}

	private void Push_System_Action_int_int_string_string(IntPtr L, Action<int, int, string, string> o)
	{
		ToLua.Push(L, o);
	}

	public CriManaMovieMaterialBase.OnApplicationPauseCallback CriManaMovieMaterial_OnApplicationPauseCallback(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			CriManaMovieMaterial_OnApplicationPauseCallback_Event criManaMovieMaterial_OnApplicationPauseCallback_Event = new CriManaMovieMaterial_OnApplicationPauseCallback_Event(func);
			CriManaMovieMaterialBase.OnApplicationPauseCallback onApplicationPauseCallback = criManaMovieMaterial_OnApplicationPauseCallback_Event.Call;
			criManaMovieMaterial_OnApplicationPauseCallback_Event.method = onApplicationPauseCallback.Method;
			return onApplicationPauseCallback;
		}
		CriManaMovieMaterial_OnApplicationPauseCallback_Event criManaMovieMaterial_OnApplicationPauseCallback_Event2 = new CriManaMovieMaterial_OnApplicationPauseCallback_Event(func, self);
		CriManaMovieMaterialBase.OnApplicationPauseCallback onApplicationPauseCallback2 = criManaMovieMaterial_OnApplicationPauseCallback_Event2.CallWithSelf;
		criManaMovieMaterial_OnApplicationPauseCallback_Event2.method = onApplicationPauseCallback2.Method;
		return onApplicationPauseCallback2;
	}

	private bool Check_CriManaMovieMaterial_OnApplicationPauseCallback(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(CriManaMovieMaterialBase.OnApplicationPauseCallback), L, pos);
	}

	private void Push_CriManaMovieMaterial_OnApplicationPauseCallback(IntPtr L, CriManaMovieMaterialBase.OnApplicationPauseCallback o)
	{
		ToLua.Push(L, o);
	}

	public Player.CuePointCallback CriMana_Player_CuePointCallback(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			CriMana_Player_CuePointCallback_Event criMana_Player_CuePointCallback_Event = new CriMana_Player_CuePointCallback_Event(func);
			Player.CuePointCallback cuePointCallback = criMana_Player_CuePointCallback_Event.Call;
			criMana_Player_CuePointCallback_Event.method = cuePointCallback.Method;
			return cuePointCallback;
		}
		CriMana_Player_CuePointCallback_Event criMana_Player_CuePointCallback_Event2 = new CriMana_Player_CuePointCallback_Event(func, self);
		Player.CuePointCallback cuePointCallback2 = criMana_Player_CuePointCallback_Event2.CallWithSelf;
		criMana_Player_CuePointCallback_Event2.method = cuePointCallback2.Method;
		return cuePointCallback2;
	}

	private bool Check_CriMana_Player_CuePointCallback(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Player.CuePointCallback), L, pos);
	}

	private void Push_CriMana_Player_CuePointCallback(IntPtr L, Player.CuePointCallback o)
	{
		ToLua.Push(L, o);
	}

	public Player.StatusChangeCallback CriMana_Player_StatusChangeCallback(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			CriMana_Player_StatusChangeCallback_Event criMana_Player_StatusChangeCallback_Event = new CriMana_Player_StatusChangeCallback_Event(func);
			Player.StatusChangeCallback statusChangeCallback = criMana_Player_StatusChangeCallback_Event.Call;
			criMana_Player_StatusChangeCallback_Event.method = statusChangeCallback.Method;
			return statusChangeCallback;
		}
		CriMana_Player_StatusChangeCallback_Event criMana_Player_StatusChangeCallback_Event2 = new CriMana_Player_StatusChangeCallback_Event(func, self);
		Player.StatusChangeCallback statusChangeCallback2 = criMana_Player_StatusChangeCallback_Event2.CallWithSelf;
		criMana_Player_StatusChangeCallback_Event2.method = statusChangeCallback2.Method;
		return statusChangeCallback2;
	}

	private bool Check_CriMana_Player_StatusChangeCallback(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Player.StatusChangeCallback), L, pos);
	}

	private void Push_CriMana_Player_StatusChangeCallback(IntPtr L, Player.StatusChangeCallback o)
	{
		ToLua.Push(L, o);
	}

	public Player.SubtitleChangeCallback CriMana_Player_SubtitleChangeCallback(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			CriMana_Player_SubtitleChangeCallback_Event criMana_Player_SubtitleChangeCallback_Event = new CriMana_Player_SubtitleChangeCallback_Event(func);
			Player.SubtitleChangeCallback subtitleChangeCallback = criMana_Player_SubtitleChangeCallback_Event.Call;
			criMana_Player_SubtitleChangeCallback_Event.method = subtitleChangeCallback.Method;
			return subtitleChangeCallback;
		}
		CriMana_Player_SubtitleChangeCallback_Event criMana_Player_SubtitleChangeCallback_Event2 = new CriMana_Player_SubtitleChangeCallback_Event(func, self);
		Player.SubtitleChangeCallback subtitleChangeCallback2 = criMana_Player_SubtitleChangeCallback_Event2.CallWithSelf;
		criMana_Player_SubtitleChangeCallback_Event2.method = subtitleChangeCallback2.Method;
		return subtitleChangeCallback2;
	}

	private bool Check_CriMana_Player_SubtitleChangeCallback(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Player.SubtitleChangeCallback), L, pos);
	}

	private void Push_CriMana_Player_SubtitleChangeCallback(IntPtr L, Player.SubtitleChangeCallback o)
	{
		ToLua.Push(L, o);
	}

	public Player.ShaderDispatchCallback CriMana_Player_ShaderDispatchCallback(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return (MovieInfo param0, bool param1) => (Shader)null;
		}
		if (!flag)
		{
			CriMana_Player_ShaderDispatchCallback_Event criMana_Player_ShaderDispatchCallback_Event = new CriMana_Player_ShaderDispatchCallback_Event(func);
			Player.ShaderDispatchCallback shaderDispatchCallback = criMana_Player_ShaderDispatchCallback_Event.Call;
			criMana_Player_ShaderDispatchCallback_Event.method = shaderDispatchCallback.Method;
			return shaderDispatchCallback;
		}
		CriMana_Player_ShaderDispatchCallback_Event criMana_Player_ShaderDispatchCallback_Event2 = new CriMana_Player_ShaderDispatchCallback_Event(func, self);
		Player.ShaderDispatchCallback shaderDispatchCallback2 = criMana_Player_ShaderDispatchCallback_Event2.CallWithSelf;
		criMana_Player_ShaderDispatchCallback_Event2.method = shaderDispatchCallback2.Method;
		return shaderDispatchCallback2;
	}

	private bool Check_CriMana_Player_ShaderDispatchCallback(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Player.ShaderDispatchCallback), L, pos);
	}

	private void Push_CriMana_Player_ShaderDispatchCallback(IntPtr L, Player.ShaderDispatchCallback o)
	{
		ToLua.Push(L, o);
	}

	public BlendSystem.BlendSystemGenericDelegate RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate_Event rogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate_Event = new RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate_Event(func);
			BlendSystem.BlendSystemGenericDelegate blendSystemGenericDelegate = rogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate_Event.Call;
			rogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate_Event.method = blendSystemGenericDelegate.Method;
			return blendSystemGenericDelegate;
		}
		RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate_Event rogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate_Event2 = new RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate_Event(func, self);
		BlendSystem.BlendSystemGenericDelegate blendSystemGenericDelegate2 = rogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate_Event2.CallWithSelf;
		rogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate_Event2.method = blendSystemGenericDelegate2.Method;
		return blendSystemGenericDelegate2;
	}

	private bool Check_RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(BlendSystem.BlendSystemGenericDelegate), L, pos);
	}

	private void Push_RogoDigital_Lipsync_BlendSystem_BlendSystemGenericDelegate(IntPtr L, BlendSystem.BlendSystemGenericDelegate o)
	{
		ToLua.Push(L, o);
	}

	public LipSync.ResetDelegate RogoDigital_Lipsync_LipSync_ResetDelegate(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			RogoDigital_Lipsync_LipSync_ResetDelegate_Event rogoDigital_Lipsync_LipSync_ResetDelegate_Event = new RogoDigital_Lipsync_LipSync_ResetDelegate_Event(func);
			LipSync.ResetDelegate resetDelegate = rogoDigital_Lipsync_LipSync_ResetDelegate_Event.Call;
			rogoDigital_Lipsync_LipSync_ResetDelegate_Event.method = resetDelegate.Method;
			return resetDelegate;
		}
		RogoDigital_Lipsync_LipSync_ResetDelegate_Event rogoDigital_Lipsync_LipSync_ResetDelegate_Event2 = new RogoDigital_Lipsync_LipSync_ResetDelegate_Event(func, self);
		LipSync.ResetDelegate resetDelegate2 = rogoDigital_Lipsync_LipSync_ResetDelegate_Event2.CallWithSelf;
		rogoDigital_Lipsync_LipSync_ResetDelegate_Event2.method = resetDelegate2.Method;
		return resetDelegate2;
	}

	private bool Check_RogoDigital_Lipsync_LipSync_ResetDelegate(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(LipSync.ResetDelegate), L, pos);
	}

	private void Push_RogoDigital_Lipsync_LipSync_ResetDelegate(IntPtr L, LipSync.ResetDelegate o)
	{
		ToLua.Push(L, o);
	}

	public Action<int, int, Transform> System_Action_int_int_UnityEngine_Transform(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_int_int_UnityEngine_Transform_Event system_Action_int_int_UnityEngine_Transform_Event = new System_Action_int_int_UnityEngine_Transform_Event(func);
			Action<int, int, Transform> action = system_Action_int_int_UnityEngine_Transform_Event.Call;
			system_Action_int_int_UnityEngine_Transform_Event.method = action.Method;
			return action;
		}
		System_Action_int_int_UnityEngine_Transform_Event system_Action_int_int_UnityEngine_Transform_Event2 = new System_Action_int_int_UnityEngine_Transform_Event(func, self);
		Action<int, int, Transform> action2 = system_Action_int_int_UnityEngine_Transform_Event2.CallWithSelf;
		system_Action_int_int_UnityEngine_Transform_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_int_int_UnityEngine_Transform(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<int, int, Transform>), L, pos);
	}

	private void Push_System_Action_int_int_UnityEngine_Transform(IntPtr L, Action<int, int, Transform> o)
	{
		ToLua.Push(L, o);
	}

	public Action<long, int, int> System_Action_long_int_int(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_long_int_int_Event system_Action_long_int_int_Event = new System_Action_long_int_int_Event(func);
			Action<long, int, int> action = system_Action_long_int_int_Event.Call;
			system_Action_long_int_int_Event.method = action.Method;
			return action;
		}
		System_Action_long_int_int_Event system_Action_long_int_int_Event2 = new System_Action_long_int_int_Event(func, self);
		Action<long, int, int> action2 = system_Action_long_int_int_Event2.CallWithSelf;
		system_Action_long_int_int_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_long_int_int(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<long, int, int>), L, pos);
	}

	private void Push_System_Action_long_int_int(IntPtr L, Action<long, int, int> o)
	{
		ToLua.Push(L, o);
	}

	public Action<long, int> System_Action_long_int(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_long_int_Event system_Action_long_int_Event = new System_Action_long_int_Event(func);
			Action<long, int> action = system_Action_long_int_Event.Call;
			system_Action_long_int_Event.method = action.Method;
			return action;
		}
		System_Action_long_int_Event system_Action_long_int_Event2 = new System_Action_long_int_Event(func, self);
		Action<long, int> action2 = system_Action_long_int_Event2.CallWithSelf;
		system_Action_long_int_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_long_int(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<long, int>), L, pos);
	}

	private void Push_System_Action_long_int(IntPtr L, Action<long, int> o)
	{
		ToLua.Push(L, o);
	}

	public Action<PointerEventData> System_Action_UnityEngine_EventSystems_PointerEventData(LuaFunction func, LuaTable self, bool flag)
	{
		if (func == null)
		{
			return delegate
			{
			};
		}
		if (!flag)
		{
			System_Action_UnityEngine_EventSystems_PointerEventData_Event system_Action_UnityEngine_EventSystems_PointerEventData_Event = new System_Action_UnityEngine_EventSystems_PointerEventData_Event(func);
			Action<PointerEventData> action = system_Action_UnityEngine_EventSystems_PointerEventData_Event.Call;
			system_Action_UnityEngine_EventSystems_PointerEventData_Event.method = action.Method;
			return action;
		}
		System_Action_UnityEngine_EventSystems_PointerEventData_Event system_Action_UnityEngine_EventSystems_PointerEventData_Event2 = new System_Action_UnityEngine_EventSystems_PointerEventData_Event(func, self);
		Action<PointerEventData> action2 = system_Action_UnityEngine_EventSystems_PointerEventData_Event2.CallWithSelf;
		system_Action_UnityEngine_EventSystems_PointerEventData_Event2.method = action2.Method;
		return action2;
	}

	private bool Check_System_Action_UnityEngine_EventSystems_PointerEventData(IntPtr L, int pos)
	{
		return TypeChecker.CheckDelegateType(typeof(Action<PointerEventData>), L, pos);
	}

	private void Push_System_Action_UnityEngine_EventSystems_PointerEventData(IntPtr L, Action<PointerEventData> o)
	{
		ToLua.Push(L, o);
	}
}
