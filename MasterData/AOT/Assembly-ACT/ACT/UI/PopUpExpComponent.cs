using ACT.Core;
using ACT.Game;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class PopUpExpComponent : MonoBehaviour
{
	[SerializeField]
	private GameObject viewGo;

	[SerializeField]
	private TextMeshProUGUI haveNumText;

	[SerializeField]
	private TextMeshProUGUI weeklyHaveNumText;

	[SerializeField]
	private TextMeshProUGUI weeklyLimitNumText;

	public void Init()
	{
		G.detailUserInfo.Attributes.TryGetValue(1, out var value);
		haveNumText.text = value.ToString();
		G.detailUserInfo.Attributes.TryGetValue(5, out var value2);
		weeklyHaveNumText.text = value2.ToString();
		weeklyLimitNumText.text = RuntimeConfigs.data.game.monsterWeeklyDropMaxExp.FastToString();
	}

	public void Open()
	{
		viewGo.gameObject.SetActive(value: true);
		Init();
	}

	public void Close()
	{
		viewGo.gameObject.SetActive(value: false);
	}
}
