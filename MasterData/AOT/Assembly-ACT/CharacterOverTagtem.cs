using ACT.Config;
using ACT.Core;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

public class CharacterOverTagtem : MonoBehaviour
{
	public LocalizeStringEvent TmpTagName;

	public BImage ImageTagBg;

	public ActButton BtnClick;

	private void Start()
	{
	}

	public void Init(int id)
	{
		EntityCharacterTag data = CoreUtils.GetData(id, RuntimeConfigs.data.entityCharacterTags);
		TmpTagName.StringReference.TableEntryReference = data.tagTitle;
		TmpTagName.GetComponent<TextMeshProUGUI>().color = ColorParseUtility.HexToColor($"#{data.tagColor}");
		ImageTagBg.icon.color = ColorParseUtility.HexToColor($"#{data.frameColor}");
	}

	private void Update()
	{
	}
}
