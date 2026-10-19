using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using ACT.Model;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public class RegionNameTip : BaseUIComponent, IBattleMainComponent
{
	[Serializable]
	private struct AreaColorDefine
	{
		public int index;

		public Color fontColor;

		public Color imageColor1;

		public Color imageColor2;

		public string animName;
	}

	[SerializeField]
	private AreaColorDefine[] _areaColorDefines = Array.Empty<AreaColorDefine>();

	[FormerlySerializedAs("regionNameText")]
	[SerializeField]
	private TextMeshProUGUI mapNameText;

	[FormerlySerializedAs("secondaryRegionNameText")]
	[SerializeField]
	private TextMeshProUGUI areaNameText;

	[SerializeField]
	private TextMeshProUGUI areaTipText;

	[SerializeField]
	private Image[] colored1Images = Array.Empty<Image>();

	[SerializeField]
	private Image[] colored2Images = Array.Empty<Image>();

	[SerializeField]
	private Animator tipAnimator;

	[NonSerialized]
	private bool _IsOpen;

	[NonSerialized]
	private const string ShowAnimName = "RegionNameTipShow";

	[NonSerialized]
	private readonly Queue<string> _animWaitForPlays = new Queue<string>();

	[NonSerialized]
	private Dictionary<int, AreaColorDefine> _areaColorDefineDict;

	[SerializeField]
	[HideInInspector]
	private int _colorStyle;

	private const float ANIMATION_END_NORMALIZED_TIME = 1f;

	private bool TryGetColorDefine(int colorStyle, out AreaColorDefine define)
	{
		if (_areaColorDefineDict == null)
		{
			_areaColorDefineDict = _areaColorDefines.ToDictionary((AreaColorDefine k) => k.index, (AreaColorDefine v) => v);
		}
		return _areaColorDefineDict.TryGetValue(colorStyle, out define);
	}

	private void SetColorStyle(int colorStyle)
	{
		_colorStyle = colorStyle;
		if (!TryGetColorDefine(colorStyle, out var define))
		{
			return;
		}
		areaNameText.color = define.fontColor;
		Image[] array = colored1Images;
		foreach (Image image in array)
		{
			if (!(image == null))
			{
				image.color = define.imageColor1;
			}
		}
		array = colored2Images;
		foreach (Image image2 in array)
		{
			if (!(image2 == null))
			{
				image2.color = define.imageColor2;
			}
		}
	}

	public void Init(RegionNameTipData data, Action openFail)
	{
		if (_areaColorDefineDict == null)
		{
			_areaColorDefineDict = _areaColorDefines.ToDictionary((AreaColorDefine k) => k.index, (AreaColorDefine v) => v);
		}
		onClose = () =>
		{
			Model<BattleMainModel>.Interface.HudPositionUIDequeue(UIPosition.UpperMiddle);
		};
		try
		{
			_IsOpen = true;
			if (data != null && !data.regionSound.IsNull())
			{
				Singleton<GameManager>.instance.audioManager.PlaySound(data.regionSound);
			}
			mapNameText.text = data?.mapName ?? string.Empty;
			areaNameText.text = data?.areaName ?? string.Empty;
			areaTipText.text = data?.areaTips ?? string.Empty;
			SetColorStyle(data?.colorDefine ?? (-1));
			gameObject.SetActive(value: true);
			StopAllCoroutines();
			StartCoroutine(PlayAnim());
		}
		catch (Exception arg)
		{
			openFail?.Invoke();
			_IsOpen = false;
			gameObject.SetActive(value: false);
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"展示区域名称提示失败:{arg}");
			}
		}
	}

	private IEnumerator PlayAnim()
	{
		string item = "RegionNameTipShow";
		if (TryGetColorDefine(_colorStyle, out var define))
		{
			item = define.animName;
		}
		_animWaitForPlays.Enqueue(item);
		while (_animWaitForPlays.Count > 0)
		{
			string nextAnimName = _animWaitForPlays.Dequeue();
			tipAnimator.Play(nextAnimName, 0, 0f);
			yield return null;
			AnimatorStateInfo currentAnimatorStateInfo = tipAnimator.GetCurrentAnimatorStateInfo(0);
			while (currentAnimatorStateInfo.IsName(nextAnimName) && currentAnimatorStateInfo.normalizedTime < 1f)
			{
				yield return null;
				currentAnimatorStateInfo = tipAnimator.GetCurrentAnimatorStateInfo(0);
			}
		}
		UnInit();
	}

	public void UnInit()
	{
		StopAllCoroutines();
		_IsOpen = false;
		gameObject.SetActive(value: false);
		onClose?.Invoke();
		onClose = null;
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
	}

	public void UnInitialize()
	{
		if (_IsOpen)
		{
			UnInit();
		}
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}
}
