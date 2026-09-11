using UnityEngine;

public class GuildActivityWarFieldBossNodeUI : MonoBehaviour
{
	private GuildActivityNodeData _data;

	private GuildActivityWarFieldNode _nodeData;

	[SerializeField]
	private GameObject _hpTextGo;

	private IText2D _hpText;

	private IUIController _stateController;

	private IUIController _arrivableController;

	private void Awake()
	{
		_hpText = _hpTextGo.GetComponent<IText2D>();
		_nodeData = GetComponent<GuildActivityWarFieldNode>();
		IUIController[] components = GetComponents<IUIController>();
		foreach (IUIController iUIController in components)
		{
			string text = iUIController.GetName();
			if (!(text == "attackStatus"))
			{
				if (text == "arrivable")
				{
					_arrivableController = iUIController;
				}
			}
			else
			{
				_stateController = iUIController;
			}
		}
	}

	public void SetData(GuildActivityNodeData data)
	{
		_data = data;
	}

	public void UpdateView()
	{
		if (_data == null)
		{
			return;
		}
		if (_data.health == _data.boss_score)
		{
			_hpText.SetText("100");
		}
		else
		{
			int num = 100 * _data.health / _data.boss_score;
			if (num == 0)
			{
				num = 1;
			}
			_hpText.SetText(num.ToString());
		}
		if (GuildActivityManager.GetInstance().IsNodeCanReach(_nodeData.id))
		{
			_arrivableController.SetSelectedState("true");
		}
		else
		{
			_arrivableController.SetSelectedState("false");
		}
		if (_data.health <= 0)
		{
			if (GuildActivityManager.GetInstance().luaData.maxNodeId == _nodeData.id)
			{
				_stateController.SetSelectedState("finalLevelDefeat");
			}
			else
			{
				_stateController.SetSelectedState("defeat");
			}
		}
		else if (_data.health < _data.boss_score)
		{
			_stateController.SetSelectedState("attacking");
		}
		else
		{
			_stateController.SetSelectedState("notAttacking");
		}
	}
}
