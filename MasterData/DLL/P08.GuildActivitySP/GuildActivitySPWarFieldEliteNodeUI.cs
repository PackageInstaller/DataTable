using System;
using UnityEngine;

public class GuildActivitySPWarFieldEliteNodeUI : MonoBehaviour
{
	private GuildActivitySPNodeData _data;

	private GuildActivitySPWarFieldNode _nodeData;

	[SerializeField]
	private GameObject _levelTextGo;

	private IUIController _typeController;

	private IUIController _stateController;

	private IUIController _challengedFlashController;

	private IUIController _selectController;

	private IUIController _dispatchController;

	private IText2D _levelText;

	[SerializeField]
	private GameObject _resourceTextGo;

	private IText2D _resourceText;

	[SerializeField]
	private GameObject _progressTextGo;

	[SerializeField]
	private SpriteRenderer _icon;

	private IText2D _progressText;

	private void Awake()
	{
		_progressText = _progressTextGo.GetComponent<IText2D>();
		_resourceText = _resourceTextGo.GetComponent<IText2D>();
		_levelText = _levelTextGo.GetComponent<IText2D>();
		_nodeData = GetComponent<GuildActivitySPWarFieldNode>();
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
			case "select":
				_selectController = iUIController;
				break;
			case "dispatch":
				_dispatchController = iUIController;
				break;
			}
		}
	}

	public void SetData(GuildActivitySPNodeData data)
	{
		if (_data == null)
		{
			GuildActivitySPManager.GetInstance().AddTimer(OnTimer);
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
		bool flag2 = GuildActivitySPManager.GetInstance().IsNodeCanReach(_nodeData.id);
		if (_data.occupied_num > 0)
		{
			flag = flag2 && _data.is_occupied <= 0;
			if (_data.is_occupied > 0)
			{
				if (_data.myDispatchCatId > 0)
				{
					_dispatchController.SetSelectedState("on");
					_icon.sprite = AtlasManager.GetSpriteWithoutAtlas($"TextureConfig/Chip/Icon/{_data.myDispatchCatId}");
				}
				else
				{
					_dispatchController.SetSelectedState("add");
				}
				_typeController.SetSelectedState("done");
				_stateController.SetSelectedState("done");
			}
			else
			{
				_typeController.SetSelectedState("mate");
				_stateController.SetSelectedState("mate");
				_dispatchController.SetSelectedState("off");
				if (_data.eliteHealthRate > 0)
				{
					if (flag2)
					{
						_dispatchController.SetSelectedState("progress");
						_progressText.SetText(100 - Mathf.FloorToInt(_data.eliteHealthRate) + "%");
					}
				}
				else
				{
					_dispatchController.SetSelectedState("off");
				}
			}
		}
		else
		{
			flag = flag2;
			_dispatchController.SetSelectedState("off");
			if (flag2)
			{
				_stateController.SetSelectedState("challenged");
				_typeController.SetSelectedState("challenged");
				if (_data.eliteHealthRate > 0)
				{
					_dispatchController.SetSelectedState("progress");
					_progressText.SetText(100 - Mathf.FloorToInt(_data.eliteHealthRate) + "%");
				}
			}
			else
			{
				_stateController.SetSelectedState("nobody");
				_typeController.SetSelectedState("nobody");
			}
		}
		_challengedFlashController.SetSelectedState(flag ? "on" : "off");
		OnTimer();
	}

	private void OnTimer()
	{
		if (_data == null)
		{
			return;
		}
		int serverTime = GuildActivitySPManager.GetInstance().GetServerTime();
		if (_data.is_occupied <= 0)
		{
			return;
		}
		int num = Math.Max(GuildActivitySPManager.GetInstance().luaData.myLastReceiveTimestamp, _data.myDispatchTime);
		int benchmark_time = GuildActivitySPManager.GetInstance().luaData.benchmark_time;
		int num2 = GuildActivitySPManager.GetInstance().luaData.coinRefreshMinutes * 60;
		int num3 = (serverTime - benchmark_time) / num2;
		int num4 = (num - benchmark_time) / num2;
		if (_data.myDispatchCatId > 0)
		{
			int num5 = (int)((float)((num3 - num4) * _data.token_get) / (3600f / (float)num2));
			if (num5 > 0)
			{
				_dispatchController.SetSelectedState("resource");
				_resourceText.SetText(num5.ToString());
			}
			else
			{
				_dispatchController.SetSelectedState("on");
			}
		}
		else
		{
			_dispatchController.SetSelectedState("add");
		}
	}
}
