using ACT.Config;
using ACT.Core;
using ACT.World.Asset;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class CharacterElement : UIBehaviour
{
	public BImage characterElementAtlasImage;

	public BImage environmentResonanceAtlasImage;

	private ElementBitmask _characterElement;

	public void Init(int characterId)
	{
		EntityData data = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityDatas);
		_characterElement = ElementHelper.Id2Element(data.element);
		EnvironmentElement data2 = CoreUtils.GetData(data.element, RuntimeConfigs.data.EnvironmentElements);
		this.GetImageStation().LoadSprite(GameLoader.meta.realElementAtlasAssetID, data2.characterAtlasId, characterElementAtlasImage);
		OnEnvironmentElementChanged(Singleton<GameManager>.instance.worldManager.EnvironmentModule.EnvironmentElementData);
	}

	public void UnInit()
	{
	}

	public void OnEnvironmentElementChanged(EnvironmentElementData data)
	{
		if (data == null || data.element != _characterElement)
		{
			environmentResonanceAtlasImage.icon.gameObject.SetActive(value: false);
			return;
		}
		environmentResonanceAtlasImage.icon.gameObject.SetActive(value: true);
		EnvironmentElement data2 = CoreUtils.GetData(ElementHelper.Element2Id(_characterElement), RuntimeConfigs.data.EnvironmentElements);
		this.GetImageStation().LoadSprite(GameLoader.meta.realElementAtlasAssetID, data2.environmentResonanceAtlasId, environmentResonanceAtlasImage);
	}
}
