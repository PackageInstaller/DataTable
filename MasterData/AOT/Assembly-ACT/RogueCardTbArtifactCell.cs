using ACT.UI;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;

public class RogueCardTbArtifactCell : MonoBehaviour
{
	public BImage ArtfactIocn;

	public GameObject GoAdd;

	private void Start()
	{
	}

	private void Update()
	{
	}

	public void OpenRogueChooseArtifactView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUECHOOSEARTIFACT);
	}
}
