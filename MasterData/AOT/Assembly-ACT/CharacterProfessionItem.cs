using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

public class CharacterProfessionItem : MonoBehaviour
{
	public LocalizeStringEvent TextTitle;

	public LocalizeStringEvent TextDescription;

	public BImage ImageIcon;

	private void Start()
	{
	}

	public void Init(int characterId, ImageAssetStation station)
	{
		EntityCharacterData data = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		station?.LoadImageAsync(170, data.characterDamageType, ImageIcon);
		EntityCharacterProfession data2 = CoreUtils.GetData(data.characterDamageType, RuntimeConfigs.data.entityCharacterProfessions);
		TextTitle.StringReference.TableEntryReference = data2.characterProfessionName;
		TextDescription.StringReference.TableEntryReference = data2.professionDescLocal;
	}

	private void Update()
	{
	}
}
