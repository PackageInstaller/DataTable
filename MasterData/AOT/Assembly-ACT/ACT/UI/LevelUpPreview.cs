using ACT.Model;
using Bamboo.NumberString;
using Runtime.Model;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class LevelUpPreview : MonoBehaviour
{
	[SerializeReference]
	private TextMeshProUGUI curLevelText;

	[SerializeReference]
	public GameObject maxRoot;

	[SerializeReference]
	private GameObject finallyMaxLevelRoot;

	private string _CurrentStr;

	private string _MaxStr;

	private string _AddStr;

	public void Init(int curLevel, int maxLevel, int upLevel = 0)
	{
		_CurrentStr = curLevel.FastToString();
		_MaxStr = "/" + maxLevel.FastToString();
		_AddStr = ((upLevel > 0 && maxLevel > curLevel) ? ("+" + upLevel.FastToString()) : "");
		curLevelText.text = "<color=#E4E8D7>" + _CurrentStr + "</color><color=#E4E8D7>" + _MaxStr + "</color><color=#C7FF60>" + _AddStr + "</color>";
		bool active = Model<CharacterModel>.Interface.CharacterMaxLevel == curLevel;
		finallyMaxLevelRoot.SetActive(active);
	}

	public void SetUpLevel(int upLevel)
	{
		_AddStr = ((upLevel > 0) ? ("+" + upLevel.FastToString()) : "");
		curLevelText.text = "<color=#E4E8D7>" + _CurrentStr + "</color><color=#E4E8D7>" + _MaxStr + "</color><color=#C7FF60>" + _AddStr + "</color>";
	}
}
