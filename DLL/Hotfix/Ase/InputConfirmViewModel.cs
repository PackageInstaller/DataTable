using System;
using TMPro;
using UnityEngine;

namespace Ase;

public class InputConfirmViewModel : OptionBase
{
	private string title;

	private string tips;

	private string placeholderText;

	private string inputContent;

	private int characterLimit;

	private TextAlignmentOptions tipsAnchor;

	private TextAnchor placeholderAnchor;

	private TextAnchor inputAnchor;

	private bool showPasteBtn;

	private Action<string> callback;

	public string PlaceholderText
	{
		get
		{
			return placeholderText;
		}
		set
		{
			Set(ref placeholderText, value, "PlaceholderText");
		}
	}

	public bool ShowPasteBtn
	{
		get
		{
			return showPasteBtn;
		}
		set
		{
			Set(ref showPasteBtn, value, "ShowPasteBtn");
		}
	}

	public string Tips
	{
		get
		{
			return tips;
		}
		set
		{
			Set(ref tips, value, "Tips");
		}
	}

	public string Title
	{
		get
		{
			return title;
		}
		set
		{
			Set(ref title, value, "Title");
		}
	}

	public string InputContent
	{
		get
		{
			return inputContent;
		}
		set
		{
			Set(ref inputContent, value, "InputContent");
		}
	}

	public int CharacterLimit
	{
		get
		{
			return characterLimit;
		}
		set
		{
			Set(ref characterLimit, value, "CharacterLimit");
		}
	}

	public TextAlignmentOptions TipsAnchor
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return tipsAnchor;
		}
		set
		{
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			Set(ref tipsAnchor, value, "TipsAnchor");
		}
	}

	public TextAnchor PlaceholderAnchor
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return placeholderAnchor;
		}
		set
		{
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			Set(ref placeholderAnchor, value, "PlaceholderAnchor");
		}
	}

	public TextAnchor InputAnchor
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return inputAnchor;
		}
		set
		{
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			Set(ref inputAnchor, value, "InputAnchor");
		}
	}

	public InputConfirmViewModel()
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		tipsAnchor = (TextAlignmentOptions)513;
		placeholderAnchor = (TextAnchor)4;
		inputAnchor = (TextAnchor)4;
		base._002Ector();
	}

	public InputConfirmViewModel(OptionBase parent)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		tipsAnchor = (TextAlignmentOptions)513;
		placeholderAnchor = (TextAnchor)4;
		inputAnchor = (TextAnchor)4;
		base._002Ector();
		base.parent = parent;
	}

	public void SetConfirmCallback(Action<string> callback)
	{
		this.callback = (Action<string>)Delegate.Combine(this.callback, callback);
	}

	public void OnBtnConfirmClick()
	{
		callback?.Invoke(InputContent);
	}

	public void Paste()
	{
		if (!string.IsNullOrEmpty(GUIUtility.systemCopyBuffer))
		{
			InputContent = GUIUtility.systemCopyBuffer;
		}
	}
}
