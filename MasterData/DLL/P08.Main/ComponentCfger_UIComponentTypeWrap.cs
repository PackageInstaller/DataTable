using System;
using LuaInterface;

public class ComponentCfger_UIComponentTypeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(ComponentCfger.UIComponentType));
		L.RegVar("GameObject", get_GameObject, null);
		L.RegVar("RectTransform", get_RectTransform, null);
		L.RegVar("Button", get_Button, null);
		L.RegVar("Text", get_Text, null);
		L.RegVar("Image", get_Image, null);
		L.RegVar("Slider", get_Slider, null);
		L.RegVar("Toggle", get_Toggle, null);
		L.RegVar("Dropdown", get_Dropdown, null);
		L.RegVar("Input", get_Input, null);
		L.RegVar("ScrollRect", get_ScrollRect, null);
		L.RegVar("ScrollRectEx", get_ScrollRectEx, null);
		L.RegVar("Scrollbar", get_Scrollbar, null);
		L.RegVar("RawImage", get_RawImage, null);
		L.RegVar("ToggleGroup", get_ToggleGroup, null);
		L.RegVar("CanvasGroup", get_CanvasGroup, null);
		L.RegVar("SpriteRenderer", get_SpriteRenderer, null);
		L.RegVar("LayoutGroup", get_LayoutGroup, null);
		L.RegVar("InputField", get_InputField, null);
		L.RegVar("UIList", get_UIList, null);
		L.RegVar("PlayableDirector", get_PlayableDirector, null);
		L.RegVar("Animator", get_Animator, null);
		L.RegVar("EventTriggerListener", get_EventTriggerListener, null);
		L.RegVar("SelfAdaptImage", get_SelfAdaptImage, null);
		L.RegVar("ControllerExCollection", get_ControllerExCollection, null);
		L.RegVar("TextMesh", get_TextMesh, null);
		L.RegVar("TextMeshPro", get_TextMeshPro, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<ComponentCfger.UIComponentType>.Check = CheckType;
		StackTraits<ComponentCfger.UIComponentType>.Push = Push;
	}

	private static void Push(IntPtr L, ComponentCfger.UIComponentType arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(ComponentCfger.UIComponentType), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_GameObject(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.GameObject);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RectTransform(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.RectTransform);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Button(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.Button);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Text(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.Text);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Image(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.Image);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Slider(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.Slider);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Toggle(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.Toggle);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Dropdown(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.Dropdown);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Input(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.Input);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ScrollRect(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.ScrollRect);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ScrollRectEx(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.ScrollRectEx);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Scrollbar(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.Scrollbar);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_RawImage(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.RawImage);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ToggleGroup(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.ToggleGroup);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CanvasGroup(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.CanvasGroup);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SpriteRenderer(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.SpriteRenderer);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_LayoutGroup(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.LayoutGroup);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_InputField(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.InputField);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UIList(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.UIList);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PlayableDirector(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.PlayableDirector);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Animator(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.Animator);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_EventTriggerListener(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.EventTriggerListener);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SelfAdaptImage(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.SelfAdaptImage);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ControllerExCollection(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.ControllerExCollection);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TextMesh(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.TextMesh);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TextMeshPro(IntPtr L)
	{
		ToLua.Push(L, ComponentCfger.UIComponentType.TextMeshPro);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		ComponentCfger.UIComponentType uIComponentType = (ComponentCfger.UIComponentType)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, uIComponentType);
		return 1;
	}
}
