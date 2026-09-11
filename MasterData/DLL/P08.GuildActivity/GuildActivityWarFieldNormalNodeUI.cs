using System;
using UnityEngine;

public class GuildActivityWarFieldNormalNodeUI : MonoBehaviour
{
	private GuildActivityNodeData _data;

	private GuildActivityWarFieldNode _nodeData;

	private IUIController _typeController;

	private IUIController _stateController;

	private IUIController _challengedFlashController;

	private IUIController _nobodyFlashController;

	private IUIController _selectController;

	private IUIController _resourceController;

	[SerializeField]
	private GameObject _levelTextGo;

	private IText2D _levelText;

	[SerializeField]
	private GameObject _resourceTextGo;

	private IText2D _resourceText;

	private void Awake()
	{
		_nodeData = GetComponent<GuildActivityWarFieldNode>();
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
		if (_nodeData.level == 0)
		{
			Debug.Log("level is zero");
		}
		bool flag = GuildActivityManager.GetInstance().IsNodeCanReach(_nodeData.id);
		bool flag2 = false;
		bool flag3 = false;
		_levelText.SetText(_data.level.ToString());
		if (_data.occupied_num > 0)
		{
			flag3 = flag && _data.myOccupiedTimestamp <= 0;
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
			flag2 = flag;
			_resourceController.SetSelectedState("off");
			if (flag)
			{
				_typeController.SetSelectedState("nobody");
				_stateController.SetSelectedState("nobody");
			}
			else
			{
				_typeController.SetSelectedState("cannot");
				_stateController.SetSelectedState("cannot");
			}
		}
		_nobodyFlashController.SetSelectedState(flag2 ? "on" : "off");
		_challengedFlashController.SetSelectedState(flag3 ? "on" : "off");
		OnTimer();
	}

	private void OnTimer()
	{
		if (_data.myOccupiedTimestamp > 0)
		{
			int serverTime = GuildActivityManager.GetInstance().GetServerTime();
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
	}
}
