using ACT.Config;
using ACT.Core;
using TMPro;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MonoOnceCollectionView : BaseUIView
{
	public TextMeshProUGUI curCountText;

	public TextMeshProUGUI totalCountText;

	public LocalizeStringEvent titleLocalize;

	private MonoOnceCollectionData data;

	protected override void Init()
	{
		base.Init();
		data = uiViewData as MonoOnceCollectionData;
		string text = data.curCount.ToString();
		int count = RuntimeConfigs.data.game.eachOnceCollectionMaxShowCount.Find((ItemKv kv) => kv.id == data.itemId).count;
		string text2 = count.ToString();
		if (text.Length < text2.Length)
		{
			text = new string('0', text2.Length - text.Length) + text;
		}
		curCountText.text = text;
		totalCountText.text = text2;
		titleLocalize.StringReference.TableEntryReference = RuntimeConfigs.data.itemDatas[data.itemId].nameLocal;
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayOpenAnimation()
	{
		uiEffectAnimator.Play("OneCollectionViewShow");
	}

	protected override void PlayCloseAnimation()
	{
		uiEffectAnimator.Play("OneCollectionViewHide");
	}
}
