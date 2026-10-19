using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class HudRoguePropItem : MonoBehaviour
{
	public BImage Icon;

	public Button ClickButton;

	public int ItemId;

	private void Start()
	{
	}

	private void Update()
	{
	}

	public void Init(ImageAssetStation station, int itemId, int index)
	{
		ItemId = itemId;
		RogueElement data = CoreUtils.GetData(itemId, RuntimeConfigs.data.rogueElements);
		station.LoadImage(188, data.iconAddress, Icon);
	}
}
