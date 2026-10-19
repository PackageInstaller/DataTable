using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.UI.Interface;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class BossBattleTabView : BaseTabContent, RaidTabViewInterface
{
	[SerializeField]
	private LoopVerticalScrollRect _rightBossInfos;

	private List<WorldBossMonster> _bossMonsters;

	public Transform content;

	private RaidTabView _raidTabView;

	private ActButton _activeButton;

	public int DefaultSelectedAreaID { get; set; }

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		_bossMonsters = ListPool<WorldBossMonster>.Get();
		foreach (KeyValuePair<int, WorldBossMonster> worldBossMonster in RuntimeConfigs.data.worldBossMonsters)
		{
			_bossMonsters.Add(worldBossMonster.Value);
		}
		_bossMonsters.Sort(CompareBossMonsterUnlockState);
		_rightBossInfos.OnItemShow.AddListener(OnBossInfoItemShow);
		SubscribeRaidInfoChanged();
		UpdateContent();
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		base.OnTabDeActive(tabItem);
		UnsubscribeRaidInfoChanged();
		_rightBossInfos.OnItemShow.RemoveListener(OnBossInfoItemShow);
		if (_bossMonsters != null)
		{
			ListPool<WorldBossMonster>.Release(_bossMonsters);
			_bossMonsters = null;
		}
	}

	protected override void OnUnityDestroy()
	{
		UnsubscribeRaidInfoChanged();
		base.OnUnityDestroy();
	}

	private void UpdateContent()
	{
		_rightBossInfos.totalCount = _bossMonsters?.Count ?? 0;
		_rightBossInfos.RefillCells();
		PlayBossInfoItemAnimation();
	}

	private void OnBossInfoItemShow(ILoopScrollDataSource arg0)
	{
		if (arg0 is BossInfoItem bossInfoItem)
		{
			bossInfoItem.WorldBossMonsterID = _bossMonsters[bossInfoItem.index].id;
			bossInfoItem.OnSelectItem = OnSelectItem;
			bossInfoItem.RefreshEntranceLevel();
		}
	}

	public void RefreshEntranceLevels()
	{
		if (_rightBossInfos == null)
		{
			return;
		}
		IReadOnlyList<RectTransform> children = _rightBossInfos.Children;
		if (children != null)
		{
			for (int i = 0; i < children.Count; i++)
			{
				children[i].GetComponent<BossInfoItem>()?.RefreshEntranceLevel();
			}
		}
	}

	private void SubscribeRaidInfoChanged()
	{
		if (Model<RaidModel>.HasInstance())
		{
			Model<RaidModel>.Interface.OnRaidInfoChanged -= OnRaidInfoChanged;
			Model<RaidModel>.Interface.OnRaidInfoChanged += OnRaidInfoChanged;
		}
	}

	private void UnsubscribeRaidInfoChanged()
	{
		if (Model<RaidModel>.HasInstance())
		{
			Model<RaidModel>.Interface.OnRaidInfoChanged -= OnRaidInfoChanged;
		}
	}

	private void OnRaidInfoChanged()
	{
		RefreshEntranceLevels();
	}

	private int CompareBossMonsterUnlockState(WorldBossMonster left, WorldBossMonster right)
	{
		bool flag = IsBossMonsterUnlocked(left);
		bool flag2 = IsBossMonsterUnlocked(right);
		if (flag != flag2)
		{
			return flag2.CompareTo(flag);
		}
		int id = left.id;
		return id.CompareTo(right.id);
	}

	private bool IsBossMonsterUnlocked(WorldBossMonster bossMonster)
	{
		if (bossMonster == null)
		{
			return false;
		}
		EntityEnemyData data = CoreUtils.GetData(bossMonster.worldBossID, RuntimeConfigs.data.entityEnemyDatas);
		if (data != null)
		{
			return Model<MonsterHandModel>.Interface.IsUnlockByenemyType(data.enemyType);
		}
		return false;
	}

	private void PlayBossInfoItemAnimation()
	{
		for (int i = 0; i < _rightBossInfos.Children.Count; i++)
		{
			_rightBossInfos.Children[i].GetComponent<BossInfoItem>().PlayCustomAnimation((float)i * 0.05f);
		}
	}

	private void OnSelectItem(BossInfoItem item)
	{
		if (item._unlockRoot.activeSelf && item._rewardScrollBag.ItemSource != null && item._rewardScrollBag.ItemSource.Any())
		{
			_raidTabView.SetParentRewardContent(item._rewardScrollBag.transform.GetComponent<ViewControlLayer>());
		}
		else
		{
			_raidTabView.SetParentRewardContent(null);
		}
		_activeButton = (item._unlockRoot.activeSelf ? item._confirmButton1 : item._confirmButton2);
	}

	public void SetParentView(RaidTabView raidTabView)
	{
		_raidTabView = raidTabView;
	}

	public ActButton GetActiveSelectButton()
	{
		return _activeButton;
	}
}
