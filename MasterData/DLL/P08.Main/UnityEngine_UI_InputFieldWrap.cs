using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UnityEngine_UI_InputFieldWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(InputField), typeof(Selectable));
		L.RegFunction("MoveTextEnd", MoveTextEnd);
		L.RegFunction("MoveTextStart", MoveTextStart);
		L.RegFunction("OnBeginDrag", OnBeginDrag);
		L.RegFunction("OnDrag", OnDrag);
		L.RegFunction("OnEndDrag", OnEndDrag);
		L.RegFunction("OnPointerDown", OnPointerDown);
		L.RegFunction("ProcessEvent", ProcessEvent);
		L.RegFunction("OnUpdateSelected", OnUpdateSelected);
		L.RegFunction("ForceLabelUpdate", ForceLabelUpdate);
		L.RegFunction("Rebuild", Rebuild);
		L.RegFunction("LayoutComplete", LayoutComplete);
		L.RegFunction("GraphicUpdateComplete", GraphicUpdateComplete);
		L.RegFunction("ActivateInputField", ActivateInputField);
		L.RegFunction("OnSelect", OnSelect);
		L.RegFunction("OnPointerClick", OnPointerClick);
		L.RegFunction("DeactivateInputField", DeactivateInputField);
		L.RegFunction("OnDeselect", OnDeselect);
		L.RegFunction("OnSubmit", OnSubmit);
		L.RegFunction("CalculateLayoutInputHorizontal", CalculateLayoutInputHorizontal);
		L.RegFunction("CalculateLayoutInputVertical", CalculateLayoutInputVertical);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("shouldHideMobileInput", get_shouldHideMobileInput, set_shouldHideMobileInput);
		L.RegVar("text", get_text, set_text);
		L.RegVar("isFocused", get_isFocused, null);
		L.RegVar("caretBlinkRate", get_caretBlinkRate, set_caretBlinkRate);
		L.RegVar("caretWidth", get_caretWidth, set_caretWidth);
		L.RegVar("textComponent", get_textComponent, set_textComponent);
		L.RegVar("placeholder", get_placeholder, set_placeholder);
		L.RegVar("caretColor", get_caretColor, set_caretColor);
		L.RegVar("customCaretColor", get_customCaretColor, set_customCaretColor);
		L.RegVar("selectionColor", get_selectionColor, set_selectionColor);
		L.RegVar("onEndEdit", get_onEndEdit, set_onEndEdit);
		L.RegVar("onValueChanged", get_onValueChanged, set_onValueChanged);
		L.RegVar("onValidateInput", get_onValidateInput, set_onValidateInput);
		L.RegVar("characterLimit", get_characterLimit, set_characterLimit);
		L.RegVar("contentType", get_contentType, set_contentType);
		L.RegVar("lineType", get_lineType, set_lineType);
		L.RegVar("inputType", get_inputType, set_inputType);
		L.RegVar("touchScreenKeyboard", get_touchScreenKeyboard, null);
		L.RegVar("keyboardType", get_keyboardType, set_keyboardType);
		L.RegVar("characterValidation", get_characterValidation, set_characterValidation);
		L.RegVar("readOnly", get_readOnly, set_readOnly);
		L.RegVar("multiLine", get_multiLine, null);
		L.RegVar("asteriskChar", get_asteriskChar, set_asteriskChar);
		L.RegVar("wasCanceled", get_wasCanceled, null);
		L.RegVar("caretPosition", get_caretPosition, set_caretPosition);
		L.RegVar("selectionAnchorPosition", get_selectionAnchorPosition, set_selectionAnchorPosition);
		L.RegVar("selectionFocusPosition", get_selectionFocusPosition, set_selectionFocusPosition);
		L.RegVar("minWidth", get_minWidth, null);
		L.RegVar("preferredWidth", get_preferredWidth, null);
		L.RegVar("flexibleWidth", get_flexibleWidth, null);
		L.RegVar("minHeight", get_minHeight, null);
		L.RegVar("preferredHeight", get_preferredHeight, null);
		L.RegVar("flexibleHeight", get_flexibleHeight, null);
		L.RegVar("layoutPriority", get_layoutPriority, null);
		L.RegFunction("OnValidateInput", UnityEngine_UI_InputField_OnValidateInput);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveTextEnd(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InputField obj = (InputField)ToLua.CheckObject<InputField>(L, 1);
			bool shift = LuaDLL.luaL_checkboolean(L, 2);
			obj.MoveTextEnd(shift);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveTextStart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InputField obj = (InputField)ToLua.CheckObject<InputField>(L, 1);
			bool shift = LuaDLL.luaL_checkboolean(L, 2);
			obj.MoveTextStart(shift);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnBeginDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InputField obj = (InputField)ToLua.CheckObject<InputField>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnBeginDrag(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InputField obj = (InputField)ToLua.CheckObject<InputField>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnDrag(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnEndDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InputField obj = (InputField)ToLua.CheckObject<InputField>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnEndDrag(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerDown(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InputField obj = (InputField)ToLua.CheckObject<InputField>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerDown(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ProcessEvent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InputField obj = (InputField)ToLua.CheckObject<InputField>(L, 1);
			Event e = (Event)ToLua.CheckObject(L, 2, typeof(Event));
			obj.ProcessEvent(e);
			return 0;
		}
		catch (Exception e2)
		{
			return LuaDLL.toluaL_exception(L, e2);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnUpdateSelected(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InputField obj = (InputField)ToLua.CheckObject<InputField>(L, 1);
			BaseEventData eventData = (BaseEventData)ToLua.CheckObject<BaseEventData>(L, 2);
			obj.OnUpdateSelected(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ForceLabelUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((InputField)ToLua.CheckObject<InputField>(L, 1)).ForceLabelUpdate();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Rebuild(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InputField obj = (InputField)ToLua.CheckObject<InputField>(L, 1);
			CanvasUpdate update = (CanvasUpdate)ToLua.CheckObject(L, 2, typeof(CanvasUpdate));
			obj.Rebuild(update);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LayoutComplete(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((InputField)ToLua.CheckObject<InputField>(L, 1)).LayoutComplete();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GraphicUpdateComplete(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((InputField)ToLua.CheckObject<InputField>(L, 1)).GraphicUpdateComplete();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ActivateInputField(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((InputField)ToLua.CheckObject<InputField>(L, 1)).ActivateInputField();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnSelect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InputField obj = (InputField)ToLua.CheckObject<InputField>(L, 1);
			BaseEventData eventData = (BaseEventData)ToLua.CheckObject<BaseEventData>(L, 2);
			obj.OnSelect(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerClick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InputField obj = (InputField)ToLua.CheckObject<InputField>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerClick(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeactivateInputField(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((InputField)ToLua.CheckObject<InputField>(L, 1)).DeactivateInputField();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnDeselect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InputField obj = (InputField)ToLua.CheckObject<InputField>(L, 1);
			BaseEventData eventData = (BaseEventData)ToLua.CheckObject<BaseEventData>(L, 2);
			obj.OnDeselect(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnSubmit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InputField obj = (InputField)ToLua.CheckObject<InputField>(L, 1);
			BaseEventData eventData = (BaseEventData)ToLua.CheckObject<BaseEventData>(L, 2);
			obj.OnSubmit(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalculateLayoutInputHorizontal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((InputField)ToLua.CheckObject<InputField>(L, 1)).CalculateLayoutInputHorizontal();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalculateLayoutInputVertical(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((InputField)ToLua.CheckObject<InputField>(L, 1)).CalculateLayoutInputVertical();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_shouldHideMobileInput(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool shouldHideMobileInput = ((InputField)obj).shouldHideMobileInput;
			LuaDLL.lua_pushboolean(L, shouldHideMobileInput);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shouldHideMobileInput on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_text(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string text = ((InputField)obj).text;
			LuaDLL.lua_pushstring(L, text);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index text on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isFocused(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isFocused = ((InputField)obj).isFocused;
			LuaDLL.lua_pushboolean(L, isFocused);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isFocused on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_caretBlinkRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float caretBlinkRate = ((InputField)obj).caretBlinkRate;
			LuaDLL.lua_pushnumber(L, caretBlinkRate);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index caretBlinkRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_caretWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int caretWidth = ((InputField)obj).caretWidth;
			LuaDLL.lua_pushinteger(L, caretWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index caretWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_textComponent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Text textComponent = ((InputField)obj).textComponent;
			ToLua.Push(L, textComponent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index textComponent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_placeholder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Graphic placeholder = ((InputField)obj).placeholder;
			ToLua.Push(L, placeholder);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index placeholder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_caretColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color caretColor = ((InputField)obj).caretColor;
			ToLua.Push(L, caretColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index caretColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_customCaretColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool customCaretColor = ((InputField)obj).customCaretColor;
			LuaDLL.lua_pushboolean(L, customCaretColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index customCaretColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_selectionColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Color selectionColor = ((InputField)obj).selectionColor;
			ToLua.Push(L, selectionColor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectionColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onEndEdit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField.SubmitEvent onSubmit = ((InputField)obj).onSubmit;
			ToLua.PushObject(L, onSubmit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onEndEdit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onValueChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField.OnChangeEvent onValueChanged = ((InputField)obj).onValueChanged;
			ToLua.PushObject(L, onValueChanged);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValueChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_onValidateInput(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField.OnValidateInput onValidateInput = ((InputField)obj).onValidateInput;
			ToLua.Push(L, onValidateInput);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValidateInput on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_characterLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int characterLimit = ((InputField)obj).characterLimit;
			LuaDLL.lua_pushinteger(L, characterLimit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index characterLimit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_contentType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField.ContentType contentType = ((InputField)obj).contentType;
			ToLua.Push(L, contentType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index contentType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lineType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField.LineType lineType = ((InputField)obj).lineType;
			ToLua.Push(L, lineType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lineType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_inputType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField.InputType inputType = ((InputField)obj).inputType;
			ToLua.Push(L, inputType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index inputType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_touchScreenKeyboard(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TouchScreenKeyboard touchScreenKeyboard = ((InputField)obj).touchScreenKeyboard;
			ToLua.PushObject(L, touchScreenKeyboard);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index touchScreenKeyboard on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_keyboardType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			TouchScreenKeyboardType keyboardType = ((InputField)obj).keyboardType;
			ToLua.Push(L, keyboardType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index keyboardType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_characterValidation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField.CharacterValidation characterValidation = ((InputField)obj).characterValidation;
			ToLua.Push(L, characterValidation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index characterValidation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_readOnly(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool readOnly = ((InputField)obj).readOnly;
			LuaDLL.lua_pushboolean(L, readOnly);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index readOnly on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_multiLine(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool multiLine = ((InputField)obj).multiLine;
			LuaDLL.lua_pushboolean(L, multiLine);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index multiLine on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_asteriskChar(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			char asteriskChar = ((InputField)obj).asteriskChar;
			LuaDLL.lua_pushnumber(L, (int)asteriskChar);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index asteriskChar on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_wasCanceled(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool wasCanceled = ((InputField)obj).wasCanceled;
			LuaDLL.lua_pushboolean(L, wasCanceled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index wasCanceled on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_caretPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int caretPosition = ((InputField)obj).caretPosition;
			LuaDLL.lua_pushinteger(L, caretPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index caretPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_selectionAnchorPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int selectionAnchorPosition = ((InputField)obj).selectionAnchorPosition;
			LuaDLL.lua_pushinteger(L, selectionAnchorPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectionAnchorPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_selectionFocusPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int selectionFocusPosition = ((InputField)obj).selectionFocusPosition;
			LuaDLL.lua_pushinteger(L, selectionFocusPosition);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectionFocusPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_minWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float minWidth = ((InputField)obj).minWidth;
			LuaDLL.lua_pushnumber(L, minWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_preferredWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float preferredWidth = ((InputField)obj).preferredWidth;
			LuaDLL.lua_pushnumber(L, preferredWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index preferredWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_flexibleWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float flexibleWidth = ((InputField)obj).flexibleWidth;
			LuaDLL.lua_pushnumber(L, flexibleWidth);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index flexibleWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_minHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float minHeight = ((InputField)obj).minHeight;
			LuaDLL.lua_pushnumber(L, minHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index minHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_preferredHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float preferredHeight = ((InputField)obj).preferredHeight;
			LuaDLL.lua_pushnumber(L, preferredHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index preferredHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_flexibleHeight(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float flexibleHeight = ((InputField)obj).flexibleHeight;
			LuaDLL.lua_pushnumber(L, flexibleHeight);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index flexibleHeight on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_layoutPriority(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int layoutPriority = ((InputField)obj).layoutPriority;
			LuaDLL.lua_pushinteger(L, layoutPriority);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index layoutPriority on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_shouldHideMobileInput(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			bool shouldHideMobileInput = LuaDLL.luaL_checkboolean(L, 2);
			obj2.shouldHideMobileInput = shouldHideMobileInput;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index shouldHideMobileInput on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_text(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			string text = ToLua.CheckString(L, 2);
			obj2.text = text;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index text on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_caretBlinkRate(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			float caretBlinkRate = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.caretBlinkRate = caretBlinkRate;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index caretBlinkRate on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_caretWidth(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			int caretWidth = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.caretWidth = caretWidth;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index caretWidth on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_textComponent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			Text textComponent = (Text)ToLua.CheckObject<Text>(L, 2);
			obj2.textComponent = textComponent;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index textComponent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_placeholder(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			Graphic placeholder = (Graphic)ToLua.CheckObject<Graphic>(L, 2);
			obj2.placeholder = placeholder;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index placeholder on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_caretColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			Color caretColor = ToLua.ToColor(L, 2);
			obj2.caretColor = caretColor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index caretColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_customCaretColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			bool customCaretColor = LuaDLL.luaL_checkboolean(L, 2);
			obj2.customCaretColor = customCaretColor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index customCaretColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_selectionColor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			Color selectionColor = ToLua.ToColor(L, 2);
			obj2.selectionColor = selectionColor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectionColor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onEndEdit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			InputField.EndEditEvent onEndEdit = (InputField.EndEditEvent)ToLua.CheckObject<InputField.EndEditEvent>(L, 2);
			obj2.onEndEdit = onEndEdit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onEndEdit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onValueChanged(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			InputField.OnChangeEvent onValueChanged = (InputField.OnChangeEvent)ToLua.CheckObject<InputField.OnChangeEvent>(L, 2);
			obj2.onValueChanged = onValueChanged;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValueChanged on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_onValidateInput(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			InputField.OnValidateInput onValidateInput = (InputField.OnValidateInput)ToLua.CheckDelegate<InputField.OnValidateInput>(L, 2);
			obj2.onValidateInput = onValidateInput;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index onValidateInput on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_characterLimit(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			int characterLimit = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.characterLimit = characterLimit;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index characterLimit on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_contentType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			InputField.ContentType contentType = (InputField.ContentType)ToLua.CheckObject(L, 2, typeof(InputField.ContentType));
			obj2.contentType = contentType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index contentType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lineType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			InputField.LineType lineType = (InputField.LineType)ToLua.CheckObject(L, 2, typeof(InputField.LineType));
			obj2.lineType = lineType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lineType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_inputType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			InputField.InputType inputType = (InputField.InputType)ToLua.CheckObject(L, 2, typeof(InputField.InputType));
			obj2.inputType = inputType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index inputType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_keyboardType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			TouchScreenKeyboardType keyboardType = (TouchScreenKeyboardType)ToLua.CheckObject(L, 2, typeof(TouchScreenKeyboardType));
			obj2.keyboardType = keyboardType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index keyboardType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_characterValidation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			InputField.CharacterValidation characterValidation = (InputField.CharacterValidation)ToLua.CheckObject(L, 2, typeof(InputField.CharacterValidation));
			obj2.characterValidation = characterValidation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index characterValidation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_readOnly(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			bool readOnly = LuaDLL.luaL_checkboolean(L, 2);
			obj2.readOnly = readOnly;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index readOnly on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_asteriskChar(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			char asteriskChar = (char)LuaDLL.luaL_checknumber(L, 2);
			obj2.asteriskChar = asteriskChar;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index asteriskChar on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_caretPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			int caretPosition = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.caretPosition = caretPosition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index caretPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_selectionAnchorPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			int selectionAnchorPosition = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.selectionAnchorPosition = selectionAnchorPosition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectionAnchorPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_selectionFocusPosition(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InputField obj2 = (InputField)obj;
			int selectionFocusPosition = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.selectionFocusPosition = selectionFocusPosition;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index selectionFocusPosition on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityEngine_UI_InputField_OnValidateInput(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			LuaFunction func = ToLua.CheckLuaFunction(L, 1);
			if (num == 1)
			{
				Delegate ev = DelegateTraits<InputField.OnValidateInput>.Create(func);
				ToLua.Push(L, ev);
			}
			else
			{
				LuaTable self = ToLua.CheckLuaTable(L, 2);
				Delegate ev2 = DelegateTraits<InputField.OnValidateInput>.Create(func, self);
				ToLua.Push(L, ev2);
			}
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
