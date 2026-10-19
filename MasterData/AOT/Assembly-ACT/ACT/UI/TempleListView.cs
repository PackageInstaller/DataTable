using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace ACT.UI;

public class TempleListView : BaseUIView
{
	public List<TempleItem> templeItemList;

	private TempleListViewData m_data;

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
	}

	protected override void Init()
	{
		base.Init();
		RefreshTempleList();
	}

	private void RefreshTempleList()
	{
		for (int i = 0; i < templeItemList.Count; i++)
		{
			templeItemList[i].gameObject.SetActive(value: true);
		}
		TempleItem.State[] array = new TempleItem.State[6]
		{
			TempleItem.State.Normal,
			(TempleItem.State)9,
			(TempleItem.State)17,
			(TempleItem.State)25,
			TempleItem.State.Locked,
			TempleItem.State.UnKnown
		};
		for (int j = 0; j < templeItemList.Count; j++)
		{
			templeItemList[j].SetState(array[j]);
		}
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
}
