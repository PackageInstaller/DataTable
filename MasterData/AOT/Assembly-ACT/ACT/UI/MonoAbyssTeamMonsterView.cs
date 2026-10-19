using System.Collections.Generic;
using ACT.Core;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoAbyssTeamMonsterView : BaseUIView
{
	private MonoAbyssTeamMonsterViewData m_data;

	public TextMeshProUGUI UpNameText;

	public RectTransform UpParent;

	public GameObject DownName;

	public TextMeshProUGUI DownNameText;

	public RectTransform DownParent;

	public AbyssMonsterItem AbyssMonsterItemAsset;

	private List<AbyssMonsterItem> abyssMonsterItems;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		if (abyssMonsterItems == null)
		{
			abyssMonsterItems = new List<AbyssMonsterItem>();
		}
	}

	protected override void Init()
	{
		base.Init();
		m_data = uiViewData as MonoAbyssTeamMonsterViewData;
		int abyssId = m_data.abyssId;
		if (!RuntimeConfigs.data.abyssDatas.TryGetValue(abyssId, out var value))
		{
			return;
		}
		string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value.abyssNameLocal);
		UpNameText.text = $"{localizeString}·{LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2288)}";
		for (int i = 0; i < value.enemyShowList.Count; i++)
		{
			CreateAbyssMonsterItem(value.enemyShowList[i].id, value.enemyShowList[i].count, UpParent);
		}
		if (value.enemyShowListDown.Count <= 0)
		{
			DownName.SetActive(value: false);
			return;
		}
		DownNameText.text = $"{localizeString}·{LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2289)}";
		DownName.SetActive(value: true);
		for (int j = 0; j < value.enemyShowListDown.Count; j++)
		{
			CreateAbyssMonsterItem(value.enemyShowListDown[j].id, value.enemyShowListDown[j].count, DownParent);
		}
		LayoutRebuilder.ForceRebuildLayoutImmediate(UpParent);
		LayoutRebuilder.ForceRebuildLayoutImmediate(DownParent);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		ClearAbyssMonsterItems();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void CreateAbyssMonsterItem(int monsterId, int level, RectTransform parent)
	{
		AbyssMonsterItem component = Object.Instantiate(AbyssMonsterItemAsset.gameObject, parent).GetComponent<AbyssMonsterItem>();
		component.RefreshUI(monsterId, level);
		abyssMonsterItems.Add(component);
	}

	private void ClearAbyssMonsterItems()
	{
		for (int num = abyssMonsterItems.Count - 1; num >= 0; num--)
		{
			Object.Destroy(abyssMonsterItems[num].gameObject);
		}
		abyssMonsterItems.Clear();
	}
}
