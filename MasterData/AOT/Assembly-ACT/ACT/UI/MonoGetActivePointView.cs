using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.UI.ViewComponent.GetActivePointView;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoGetActivePointView : BaseUIView
{
	[SerializeField]
	private LoopScrollRect _activePointLoopScroll;

	private MonoGetActivePointViewViewData m_data;

	private List<ActivePointDailyMission> _allActivePointDailyMissions;

	private void Awake()
	{
		_allActivePointDailyMissions = ListPool<ActivePointDailyMission>.Get();
	}

	private void OnDestroy()
	{
		ListPool<ActivePointDailyMission>.Release(_allActivePointDailyMissions);
	}

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
		_allActivePointDailyMissions.Clear();
		foreach (KeyValuePair<int, ActivePointDailyMission> activePointDailyMission in RuntimeConfigs.data.activePointDailyMissions)
		{
			_allActivePointDailyMissions.Add(activePointDailyMission.Value);
		}
		_activePointLoopScroll.totalCount = _allActivePointDailyMissions.Count;
		_activePointLoopScroll.OnItemShow.RemoveAllListeners();
		_activePointLoopScroll.OnItemShow.AddListener((ILoopScrollDataSource l) =>
		{
			if (l is GetActivePointItem getActivePointItem)
			{
				getActivePointItem.ActivePointDailyMissionID = _allActivePointDailyMissions[getActivePointItem.index].id;
			}
		});
		_activePointLoopScroll.RefillCells();
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
