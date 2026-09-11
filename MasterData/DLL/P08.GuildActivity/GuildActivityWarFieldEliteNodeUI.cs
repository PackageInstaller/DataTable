using System;
using UnityEngine;

public class GuildActivityWarFieldEliteNodeUI : MonoBehaviour
{
	private GuildActivityNodeData _data;

	private GuildActivityWarFieldNode _nodeData;

	[SerializeField]
	private GameObject _levelTextGo;

	private IUIController _typeController;

	private IUIController _stateController;

	private IUIController _challengedFlashController;

	private IUIController _nobodyFlashController;

	private IUIController _selectController;

	private IUIController _resourceController;

	private IUIController _countdownController;

	private IText2D _levelText;

	[SerializeField]
	private GameObject _resourceTextGo;

	private IText2D _resourceText;

	[SerializeField]
	private GameObject _countdownTextGo;

	private IText2D _countdownText;

	private void Awake()
	{
		_countdownText = _countdownTextGo.GetComponent<IText2D>();
		_resourceText = _resourceTextGo.GetComponent<IText2D>();
		_levelText = _levelTextGo.GetComponent<IText2D>();
		_nodeData = GetComponent<GuildActivityWarFieldNode>();
		IUIController[] components = GetComponents<IUIController>();
		foreach (IUIController iUIController in components)
		{
			switch (iUIController.GetName())
			{
			case "type":
				_typeController = iUIController;
				break;
			case "state":
				_stateController = iUIController;
				break;
			case "challengedFlash":
				_challengedFlashController = iUIController;
				break;
			case "nobodyFlash":
				_nobodyFlashController = iUIController;
				break;
			case "select":
				_selectController = iUIController;
				break;
			case "resource":
				_resourceController = iUIController;
				break;
			case "countdown":
				_countdownController = iUIController;
				break;
			}
		}
	}

	public void SetData(GuildActivityNodeData data)
	{
		if (_data == null)
		{
			GuildActivityManager.GetInstance().AddTimer(OnTimer);
		}
		_data = data;
	}

	public void UpdateView()
	{
		if (_data == null)
		{
			return;
		}
		_levelText.SetText(_data.level.ToString());
		bool flag = false;
		bool flag2 = false;
		bool flag3 = GuildActivityManager.GetInstance().IsNodeCanReach(_nodeData.id);
		if (_data.occupied_num > 0)
		{
			flag2 = flag3 && _data.myOccupiedTimestamp <= 0;
			if (_data.myOccupiedTimestamp > 0)
			{
				_typeController.SetSelectedState("bonus");
				_stateController.SetSelectedState("done");
				_resourceController.SetSelectedState("on");
			}
			else
			{
				_typeController.SetSelectedState("challenged");
				_stateController.SetSelectedState("challenged");
				_resourceController.SetSelectedState("off");
			}
		}
		else
		{
			flag = flag3;
			_resourceController.SetSelectedState("off");
			if (flag3)
			{
				_stateController.SetSelectedState("nobody");
				_typeController.SetSelectedState("nobody");
			}
			else
			{
				_stateController.SetSelectedState("cannot");
				_typeController.SetSelectedState("cannot");
			}
		}
		_nobodyFlashController.SetSelectedState(flag ? "on" : "off");
		_challengedFlashController.SetSelectedState(flag2 ? "on" : "off");
		OnTimer();
	}

	private void OnTimer()
	{
		if (_data == null)
		{
			return;
		}
		int serverTime = GuildActivityManager.GetInstance().GetServerTime();
		if (_data.myOccupiedTimestamp > 0)
		{
			int num = Math.Max(GuildActivityManager.GetInstance().luaData.myLastReceiveTimestamp, _data.myOccupiedTimestamp);
			int benchmark_time = GuildActivityManager.GetInstance().luaData.benchmark_time;
			int num2 = GuildActivityManager.GetInstance().luaData.coinRefreshMinutes * 60;
			int num3 = (serverTime - benchmark_time) / num2;
			int num4 = (num - benchmark_time) / num2;
			int num5 = (int)((float)((num3 - num4) * _data.token_get) / (3600f / (float)num2));
			if (num5 > 0)
			{
				_resourceController.SetSelectedState("on");
			}
			else
			{
				_resourceController.SetSelectedState("off");
			}
			_resourceText.SetText(num5.ToString());
		}
		else if (_data.myProcessingTimestamp > 0 && _data.processingType == 3)
		{
			if (serverTime < _data.myProcessingTimestamp)
			{
				int num6 = _data.myProcessingTimestamp - serverTime;
				int num7 = num6 / 60;
				int num8 = num6 % 60;
				_countdownText.SetText(num7.ToString("00") + ":" + num8.ToString("00"));
				_countdownController.SetSelectedState("on");
			}
			else
			{
				_countdownController.SetSelectedState("off");
			}
		}
		else
		{
			_countdownController.SetSelectedState("off");
		}
	}
}
