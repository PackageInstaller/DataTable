using ACT.Battle.Configs;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class BuffUIV3 : MonoBehaviour
{
	[SerializeField]
	private CanvasGroup _buffCanvasGroup;

	[SerializeField]
	private CanvasGroup _debuffCanvasGroup;

	[SerializeField]
	private BImage _icon;

	[SerializeField]
	private CanvasGroup _stackCanvasGroup;

	[SerializeField]
	private TextMeshProUGUI _stackText;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	private const string Show = "Show";

	private const string Hide = "Hide";

	private int _currentIconId;

	private int _currentStack;

	private bool _hasIcon;

	private bool _hasStack;

	internal void Refresh(int iconId, BuffIconInfo info, ImageAssetStation station)
	{
		_buffCanvasGroup.alpha = ((info.Type == BuffIconType.Debuff) ? 0f : 1f);
		_debuffCanvasGroup.alpha = ((info.Type == BuffIconType.Debuff) ? 1f : 0f);
		_stackCanvasGroup.alpha = ((info.Stack > 1) ? 1f : 0f);
		if (!_hasStack || _currentStack != info.Stack)
		{
			_currentStack = info.Stack;
			_stackText.SetText("{0:0}", info.Stack);
			_hasStack = true;
		}
		if (!_hasIcon || _currentIconId != iconId)
		{
			if (_hasIcon)
			{
				_icon.UnLoad();
			}
			station.LoadImage(161, iconId, _icon);
			_currentIconId = iconId;
			_hasIcon = true;
		}
	}

	internal void Init()
	{
		_currentIconId = 0;
		_currentStack = 0;
		_hasIcon = false;
		_hasStack = false;
		_betterAnimation.GetSequence("Show").Play();
	}

	internal void UnInit()
	{
		if (_hasIcon)
		{
			_icon.UnLoad();
			_hasIcon = false;
		}
		_currentIconId = 0;
		_currentStack = 0;
		_hasStack = false;
		_betterAnimation.GetSequence("Hide").Play();
	}
}
