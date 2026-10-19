using ACT.Game;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class AdventureLevelCell : LoopScrollBaseItem
{
	public TextMeshProUGUI textMesh_Index;

	public ScrollViewSelector selector;

	public CanvasGroup bg;

	public int level;

	public BitMaskSwitcher bitMaskSwitcher;

	public RectTransform wrap;

	private MonoAdventurePanel m_AdventurePanel;

	private LoopHorizontalScrollRect m_Rect;

	private bool m_isLock;

	private void Awake()
	{
		GetComponent<Button>().onClick.AddListener(() =>
		{
			selector.ScrollToSelected(this);
		});
	}

	public void UpdateCell()
	{
		ScrollCellIndex(selector.selected.index);
		RefreshReward();
	}

	public override void ScrollCellIndex(int id)
	{
		index = id;
		m_isLock = false;
		int num = Singleton<SystemUnlockManager>.instance.missionLevels[id];
		if (num < 0)
		{
			m_isLock = true;
			level = -num;
			if (SystemUnlockManager.playerLevel > level)
			{
				bitMaskSwitcher.SetActive(20);
			}
			else
			{
				bitMaskSwitcher.SetActive(10);
			}
		}
		else
		{
			level = num;
			if (G.localPlayer.TakeRewardLevels.Contains(level))
			{
				bitMaskSwitcher.SetActive(17);
			}
			else
			{
				bitMaskSwitcher.SetActive(9);
			}
		}
		textMesh_Index.SetText("{0:0}", level);
		bool flag = level <= SystemUnlockManager.playerLevel;
		bg.alpha = (flag ? 1f : 0.5f);
	}

	public void RefreshReward()
	{
		if (!m_AdventurePanel)
		{
			m_AdventurePanel = GetComponentInParent<MonoAdventurePanel>();
		}
		m_AdventurePanel.SetPanel(level, m_isLock);
	}
}
