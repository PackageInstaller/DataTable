using ACT.Config;
using UnityEngine;
using UnityEngine.Localization.Components;

public class CharacterTagDetailsItem : MonoBehaviour
{
	[SerializeField]
	private LocalizeStringEvent TextTitle;

	[SerializeField]
	private CharacterOverTagtem CharacterOverTagtem;

	[SerializeField]
	private LocalizeStringEvent TextDescription;

	[SerializeField]
	private GameObject GoLine;

	private void Start()
	{
	}

	public void Init(EntityCharacterTag tagData, int index)
	{
		CharacterOverTagtem.Init(tagData.id);
		TextDescription.StringReference.TableEntryReference = tagData.tagDescLocal;
		GoLine.SetActive(index != 0);
	}

	private void Update()
	{
	}
}
