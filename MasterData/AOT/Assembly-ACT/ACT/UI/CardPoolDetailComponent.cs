using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CardPoolDetailComponent : MonoBehaviour
{
	public BImage icon;

	public LocalizeStringEvent itemName;

	public void Init(int nameLocal, int iconId = 0)
	{
		itemName.StringReference.TableEntryReference = nameLocal;
	}

	public void UnLoad()
	{
		icon.UnLoad();
	}
}
