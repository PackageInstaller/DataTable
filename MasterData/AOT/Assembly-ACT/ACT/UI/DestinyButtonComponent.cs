using System;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.UI;
using Utility;

namespace ACT.UI;

public class DestinyButtonComponent : MonoBehaviour
{
	private readonly int _destinyCapacity = 8;

	private readonly int _helfActiveCount = 3;

	private readonly int _maxActiveCount = 6;

	private int _curCharacterCostId;

	private DestinySubView _parentView;

	private Action<int, bool> _openSwitchDestinyPanel;

	[SerializeField]
	private DestinyBtnBase[] _inputDestinyBtns;

	public OperateBtnPrompt[] btnPrompts;

	public GameObject promptsBoard;

	[SerializeField]
	private DestinyBtn[] _destinyBtns;

	[SerializeField]
	private ExtraDestinyComp[] _extraDestinyComps;

	[SerializeField]
	private BetterAnimation _animator;

	[SerializeField]
	private DestinyTriggerIcon[] _desTriggerIcons;

	[SerializeField]
	private Image[] _desLines;

	[SerializeField]
	private Color _normalLineColor;

	[SerializeField]
	private Color _activeLineColor;

	public BImage _characterTape;

	private bool costIsEnough
	{
		get
		{
			if (_curCharacterCostId != 0)
			{
				return G.localPlayer.Inventory.GetItemCount(_curCharacterCostId) > 0;
			}
			return false;
		}
	}

	public int curSelectDestinyIndex { get; private set; } = -1;

	public DestinyBtn[] DestinyBtns => _destinyBtns;

	public ExtraDestinyComp[] ExtraDestinyComps => _extraDestinyComps;

	public void RegisterDestinyBtn(DestinySubView view, Character character, Action<int, bool> openSwitchDestinyPanel, int activeDestinyCount, ImageAssetStation station, int costId, int destinyMaxBGMVersion)
	{
		_parentView = view;
		_curCharacterCostId = costId;
		_openSwitchDestinyPanel = openSwitchDestinyPanel;
		station?.LoadImageAsync(152, character.Id, _characterTape);
		UpdateLineColor(activeDestinyCount);
		_characterTape.icon.gameObject.SetActive(costIsEnough);
		_desTriggerIcons.ForEach((DestinyTriggerIcon x) =>
		{
			x.InitDisplay(isActive: false);
		});
		for (int num = _desTriggerIcons.Length - 1; num >= 0; num--)
		{
			_desTriggerIcons[num]?.InitDisplay(num + 1 <= activeDestinyCount);
		}
		for (int num2 = 0; num2 < _destinyCapacity; num2++)
		{
			int num3 = character.Id * 10 + num2 + 1;
			bool destinyActive = character.GetDestinyActive(num3);
			CharacterConstellationData data = CoreUtils.GetData(num3, RuntimeConfigs.data.characterConstellationDatas);
			if (num2 + 1 <= 6)
			{
				DestinyBtn destinyBtn = _destinyBtns[num2];
				destinyBtn.Init(data, destinyActive, (int selectedDestinyId, bool isCommon) =>
				{
					OnDestinyBtnSelected(destinyBtn, selectedDestinyId, isCommon);
				}, _desTriggerIcons[num2], character.IsTrailCharacter);
				continue;
			}
			int num4 = ((num2 + 1 == 7) ? _helfActiveCount : _maxActiveCount);
			bool active = activeDestinyCount >= num4;
			ExtraDestinyComp extraDestinyBtn = _extraDestinyComps[num2 - 6];
			extraDestinyBtn.Init(data, active, activeDestinyCount, (int selectedDestinyId, bool isCommon) =>
			{
				OnDestinyBtnSelected(extraDestinyBtn, selectedDestinyId, isCommon);
			}, (bool b) =>
			{
				_parentView?.ControlDestinyMaxBGM(b, destinyMaxBGMVersion);
			});
		}
		SetBtnPromptsBoardActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			SetInputSelectDesBtn(0);
		}
	}

	public void UpdateDisPlay(int activeIndex, int activeDestinyCount, bool curDestinyActive)
	{
		UpdateMiddleAnim(activeIndex, activeDestinyCount, curDestinyActive);
		UpdateLineColor(activeDestinyCount);
	}

	private void UpdateMiddleAnim(int activeIndex, int activeDestinyCount, bool curDestinyActive)
	{
		_characterTape.icon.gameObject.SetActive(value: true);
		_animator?.GetSequence(curDestinyActive ? "TriggerUnlock" : "TriggerCancle").Play();
		_desTriggerIcons[activeIndex - 1].PlayAnim(curDestinyActive, null);
		bool active = activeDestinyCount >= _helfActiveCount;
		bool active2 = activeDestinyCount == _maxActiveCount;
		_extraDestinyComps[1].SetState(active2, isASide: false, null);
		_extraDestinyComps[0].SetState(active, isASide: true, null);
		PlayTapeAddAnim(curDestinyActive);
	}

	public void UpdateLineColor(int activeDestinyCount)
	{
		bool flag = activeDestinyCount >= _helfActiveCount && activeDestinyCount < _maxActiveCount;
		bool flag2 = activeDestinyCount == _maxActiveCount;
		_desLines[0].color = ((flag | flag2) ? _activeLineColor : _normalLineColor);
		_desLines[1].color = (flag2 ? _activeLineColor : _normalLineColor);
	}

	public void UpdateHelfObj(bool alreadyActiveHelf)
	{
	}

	public void UpdateFullObj(bool allDestinyActive)
	{
	}

	private void PlayTapeAddAnim(bool isActive)
	{
		if (costIsEnough & isActive)
		{
			_animator.GetSequence("TriggerAdd").Play();
		}
	}

	private void OnDestroy()
	{
		_curCharacterCostId = 0;
	}

	private void OnDestinyBtnSelected(DestinyBtnBase selectedDestinyBtn, int destinyId, bool isCommon)
	{
		int num = Array.IndexOf(_inputDestinyBtns, selectedDestinyBtn);
		if (num >= 0)
		{
			SetInputSelectDesBtn(num);
		}
		_openSwitchDestinyPanel?.Invoke(destinyId, isCommon);
	}

	public void SetInputSelectDesBtn(int index)
	{
		if (index < 0)
		{
			curSelectDestinyIndex = _inputDestinyBtns.Length - 1;
		}
		else if (index >= _inputDestinyBtns.Length)
		{
			curSelectDestinyIndex = 0;
		}
		else
		{
			curSelectDestinyIndex = index;
		}
		SetBtnSelectState();
	}

	private void SetBtnSelectState()
	{
		for (int i = 0; i < _inputDestinyBtns.Length; i++)
		{
			if (i == curSelectDestinyIndex)
			{
				_inputDestinyBtns[i].SetSelectState(active: true);
			}
			else
			{
				_inputDestinyBtns[i].SetSelectState(active: false);
			}
		}
	}

	public void ClickInputOpenSwitchDestinyPanel()
	{
		for (int i = 0; i < _inputDestinyBtns.Length; i++)
		{
			if (i == curSelectDestinyIndex)
			{
				_inputDestinyBtns[i].Select();
				break;
			}
		}
	}

	public void SetBtnPromptsBoardActive(bool active)
	{
		promptsBoard?.SetActive(active);
	}

	public void OnDeviceChange(DeviceInputMode mode)
	{
		if (mode == DeviceInputMode.Gamepad)
		{
			SetBtnPromptsBoardActive(active: true);
			SetBtnSelectState();
		}
		else
		{
			SetBtnPromptsBoardActive(active: false);
			SetInputSelectDesBtn(curSelectDestinyIndex);
		}
	}
}
