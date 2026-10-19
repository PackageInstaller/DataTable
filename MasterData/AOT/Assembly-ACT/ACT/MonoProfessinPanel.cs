using System.Collections.Generic;
using System.Threading;
using ACT.UI;
using Cysharp.Threading.Tasks;

namespace ACT;

public class MonoProfessinPanel : BaseUIView
{
	private int m_type;

	public List<BaseTabContent> tabListView;

	public ActToggleGroup toggleGroup;

	private int m_curPageIndex = -1;

	private CancellationTokenSource m_cts;

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_curPageIndex = -1;
	}

	protected override void Init()
	{
		base.Init();
		m_type = (int)uiViewData;
		toggleGroup.Init();
	}

	protected override async void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	public async void OnBtnPageChange(int index)
	{
		if (index != m_curPageIndex)
		{
			int m_index = m_curPageIndex;
			m_curPageIndex = index;
			m_cts?.Cancel();
			m_cts?.Dispose();
			m_cts = new CancellationTokenSource();
			if (m_index != -1)
			{
				await tabListView[m_index].PlayCloseAnim(m_cts.Token);
				tabListView[m_index].Release();
				tabListView[m_index].gameObject.SetActive(value: false);
			}
			tabListView[m_curPageIndex].gameObject.SetActive(value: true);
			tabListView[m_curPageIndex].PlayOpenAnim();
		}
	}

	protected override async void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void UnInit()
	{
		base.UnInit();
		toggleGroup.SetAllToggleOff();
		CancellationTokenSource cts = m_cts;
		if (cts != null && !cts.IsCancellationRequested)
		{
			m_cts.Cancel();
		}
	}
}
