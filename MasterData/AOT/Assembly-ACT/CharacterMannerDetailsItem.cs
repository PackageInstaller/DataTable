using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

public class CharacterMannerDetailsItem : MonoBehaviour
{
	public LocalizeStringEvent TextTitle;

	public LocalizeStringEvent TextDescription;

	public BImage ImageIcon;

	private void Start()
	{
	}

	public void Init(int mananerId, ImageAssetStation station)
	{
		EntityCharacterType data = CoreUtils.GetData(mananerId, RuntimeConfigs.data.entityCharacterTypes);
		station?.LoadImage(199, mananerId, ImageIcon);
		TextTitle.StringReference.TableEntryReference = data.typeTitle;
		TextDescription.StringReference.TableEntryReference = data.typeDescLocal;
	}

	private void Update()
	{
	}
}
