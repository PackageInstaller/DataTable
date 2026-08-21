using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Internal;

namespace UnityEngine;

[NativeHeader("Runtime/Input/KeyboardOnScreen.h")]
[NativeHeader("Runtime/Export/TouchScreenKeyboard/TouchScreenKeyboard.bindings.h")]
[NativeConditional("ENABLE_ONSCREEN_KEYBOARD")]
public class TouchScreenKeyboard
{
	public enum Status
	{
		Visible,
		Done,
		Canceled,
		LostFocus
	}

	[NonSerialized]
	internal IntPtr m_Ptr;

	public static bool isSupported
	{
		get
		{
			switch (Application.platform)
			{
			case RuntimePlatform.IPhonePlayer:
			case RuntimePlatform.Android:
			case RuntimePlatform.MetroPlayerX86:
			case RuntimePlatform.MetroPlayerX64:
			case RuntimePlatform.MetroPlayerARM:
			case RuntimePlatform.PS4:
			case RuntimePlatform.tvOS:
			case RuntimePlatform.Switch:
			case RuntimePlatform.Stadia:
			case RuntimePlatform.GameCoreXboxSeries:
			case RuntimePlatform.GameCoreXboxOne:
			case RuntimePlatform.PS5:
				return true;
			default:
				return false;
			}
		}
	}

	internal static bool disableInPlaceEditing { get; }

	public static bool isInPlaceEditingAllowed
	{
		get
		{
			if (disableInPlaceEditing)
			{
				return false;
			}
			return IsInPlaceEditingAllowed();
		}
	}

	internal static bool isRequiredToForceOpen => IsRequiredToForceOpen();

	public extern string text
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetText")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("SetText")]
		set;
	}

	public static extern bool hideInput
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("SetInputHidden")]
		set;
	}

	public extern bool active
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("IsActive")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("SetActive")]
		set;
	}

	public extern Status status
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("GetKeyboardStatus")]
		get;
	}

	public extern int characterLimit
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("SetCharacterLimit")]
		set;
	}

	public extern bool canGetSelection
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("CanGetSelection")]
		get;
	}

	public extern bool canSetSelection
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("CanSetSelection")]
		get;
	}

	public RangeInt selection
	{
		get
		{
			RangeInt result = default(RangeInt);
			GetSelection(out result.start, out result.length);
			return result;
		}
		set
		{
			if (value.start < 0 || value.length < 0 || value.start + value.length > text.Length)
			{
				throw new ArgumentOutOfRangeException("selection", "Selection is out of range.");
			}
			SetSelection(value.start, value.length);
		}
	}

	public static extern bool visible
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("IsVisible")]
		get;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("TouchScreenKeyboard_Destroy", IsThreadSafe = true)]
	private static extern void Internal_Destroy(IntPtr ptr);

	private void Destroy()
	{
		if (m_Ptr != IntPtr.Zero)
		{
			Internal_Destroy(m_Ptr);
			m_Ptr = IntPtr.Zero;
		}
		GC.SuppressFinalize(this);
	}

	~TouchScreenKeyboard()
	{
		Destroy();
	}

	public TouchScreenKeyboard(string text, TouchScreenKeyboardType keyboardType, bool autocorrection, bool multiline, bool secure, bool alert, string textPlaceholder, int characterLimit)
	{
		TouchScreenKeyboard_InternalConstructorHelperArguments arguments = new TouchScreenKeyboard_InternalConstructorHelperArguments
		{
			keyboardType = Convert.ToUInt32(keyboardType),
			autocorrection = Convert.ToUInt32(autocorrection),
			multiline = Convert.ToUInt32(multiline),
			secure = Convert.ToUInt32(secure),
			alert = Convert.ToUInt32(alert),
			characterLimit = characterLimit
		};
		m_Ptr = TouchScreenKeyboard_InternalConstructorHelper(ref arguments, text, textPlaceholder);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("TouchScreenKeyboard_InternalConstructorHelper")]
	private static extern IntPtr TouchScreenKeyboard_InternalConstructorHelper(ref TouchScreenKeyboard_InternalConstructorHelperArguments arguments, string text, string textPlaceholder);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("TouchScreenKeyboard_IsInplaceEditingAllowed")]
	private static extern bool IsInPlaceEditingAllowed();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("TouchScreenKeyboard_IsRequiredToForceOpen")]
	private static extern bool IsRequiredToForceOpen();

	public static TouchScreenKeyboard Open(string text, [DefaultValue("TouchScreenKeyboardType.Default")] TouchScreenKeyboardType keyboardType, [DefaultValue("true")] bool autocorrection, [DefaultValue("false")] bool multiline, [DefaultValue("false")] bool secure, [DefaultValue("false")] bool alert, [DefaultValue("\"\"")] string textPlaceholder, [DefaultValue("0")] int characterLimit)
	{
		return new TouchScreenKeyboard(text, keyboardType, autocorrection, multiline, secure, alert, textPlaceholder, characterLimit);
	}

	[ExcludeFromDocs]
	public static TouchScreenKeyboard Open(string text, TouchScreenKeyboardType keyboardType, bool autocorrection, bool multiline, bool secure)
	{
		int num = 0;
		string textPlaceholder = "";
		bool alert = false;
		return Open(text, keyboardType, autocorrection, multiline, secure, alert, textPlaceholder, num);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetSelection(out int start, out int length);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetSelection(int start, int length);
}
