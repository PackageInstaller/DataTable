using ACT.Config;
using ACT.Core;
using ACT.UI;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

public class UpCharacteritem : MonoBehaviour
{
	public BImage Icon;

	public BImage ImageQuality;

	public LocalizeStringEvent TextName;

	public ActButton BtnJump;

	private void Start()
	{
	}

	public void Init(int characterId, ImageAssetStation station)
	{
		EntityCharacterData data = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		EntityData data2 = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityDatas);
		TextName.StringReference.TableEntryReference = data2.nameLocal;
		station.LoadImage(176, data.stars, ImageQuality);
		station.LoadImage(178, characterId, Icon);
	}

	private void Update()
	{
	}
}
