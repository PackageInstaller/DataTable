using System;
using UnityEngine;

public class GuildActivitySPWarFieldNormalNodeUI : MonoBehaviour
{
	private GuildActivitySPNodeData _data;

	private GuildActivitySPWarFieldNode _nodeData;

	private IUIController _typeController;

	private IUIController _stateController;

	private IUIController _challengedFlashController;

	private IUIController _selectController;

	private IUIController _dispatchController;

	[SerializeField]
	private SpriteRenderer _icon;

	[SerializeField]
	private GameObject _levelTextGo;

	private IText2D _levelText;

	[SerializeField]
	private GameObject _resourceTextGo;

	private IText2D _resourceText;

	private void Awake()
	{
		_nodeData = GetComponent<GuildActivitySPWarFieldNode>();
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
		if (_nodeData.level == 0)
		{
			Debug.Log("level is zero");
		}
		bool flag = GuildActivitySPManager.GetInstance().IsNodeCanReach(_nodeData.id);
		bool flag2 = false;
		_levelText.SetText(_data.level.ToString());
		if (_data.occupied_num > 0)
		{
			flag2 = flag && _data.is_occupied <= 0;
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
			}
		}
		else
		{
			flag2 = flag;
			_dispatchController.SetSelectedState("off");
			if (flag)
			{
				_typeController.SetSelectedState("challenged");
				_stateController.SetSelectedState("challenged");
			}
			else
			{
				_typeController.SetSelectedState("nobody");
				_stateController.SetSelectedState("nobody");
			}
		}
		_challengedFlashController.SetSelectedState(flag2 ? "on" : "off");
		OnTimer();
	}

	private void OnTimer()
	{
		if (_data.myDispatchTime <= 0)
		{
			return;
		}
		int serverTime = GuildActivitySPManager.GetInstance().GetServerTime();
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
