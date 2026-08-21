using UnityEngine;

public class GuildActivityWarFieldBornNodeUI : MonoBehaviour
{
	private GuildActivityWarFieldNode _nodeData;

	private IUIController _canReachController;

	private IUIController _selfController;

	private void Awake()
	{
		_nodeData = GetComponent<GuildActivityWarFieldNode>();
		IUIController[] components = GetComponents<IUIController>();
		foreach (IUIController iUIController in components)
		{
			string text = iUIController.GetName();
			if (!(text == "canReach"))
			{
				if (text == "self")
				{
					_selfController = iUIController;
				}
			}
			else
			{
				_canReachController = iUIController;
			}
		}
	}

	public void UpdateView()
	{
		if (_nodeData.level == 0)
		{
			Debug.Log("level is zero");
		}
		if (GuildActivityManager.GetInstance().luaData.spawnNodeIdList.IndexOf(_nodeData.id) >= 0)
		{
			_selfController.SetSelectedState("true");
		}
		else
		{
			_selfController.SetSelectedState("false");
		}
		if (GuildActivityManager.GetInstance().IsNodeCanReach(_nodeData.id))
		{
			_canReachController.SetSelectedState("true");
		}
		else
		{
			_canReachController.SetSelectedState("false");
		}
	}
}
