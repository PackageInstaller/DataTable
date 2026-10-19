using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class AbyssTeamItem : MonoBehaviour
{
	public BImage icon;

	public GameObject detailObj;

	public BImage elementIcon;

	public TextMeshProUGUI level;

	public new LocalizeStringEvent name;

	public void SetInfo(int characterId, int characterLevel)
	{
		this.GetImageStation().LoadSprite(GameLoader.meta.characterHalfBodyAtlasNameAssetID, characterId, icon);
		detailObj.SetActive(value: true);
		EntityData entityData = RuntimeConfigs.data.entityDatas[characterId];
		this.GetImageStation().LoadSprite(GameLoader.meta.elementAssetID, entityData.element, elementIcon);
		level.SetText("Lv.{0:0}", characterLevel);
		name.StringReference.TableEntryReference = entityData.nameLocal;
	}

	public void UnLoad(Sprite normalSprite)
	{
		icon.UnLoad(releaseSprite: true, normalSprite);
		elementIcon.UnLoad();
		detailObj.SetActive(value: false);
	}
}
