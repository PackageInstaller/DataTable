using System.Collections.Generic;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.Interface;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class CharacterTeamTutorialView : BaseTabContent
{
	public LoopScrollRect scrollRect;

	public Transform content;

	[SerializeField]
	private float _characterShowDelayTime = 0.05f;

	private TrainingTabView _trainingTabView;

	private List<CharacterTutorialRaidInfo> _raidInfos;

	private int _animationVersion;

	public void SetParentView(TrainingTabView trainingTabView)
	{
		_trainingTabView = trainingTabView;
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		if (tabItem is TrainingSubTab)
		{
			CreateTeamTutorialEntrance();
		}
	}

	private void CreateTeamTutorialEntrance()
	{
		_animationVersion++;
		scrollRect.ClearCellsPool();
		_raidInfos = GetTeamTutorialRaidInfos();
		_raidInfos.Sort(Sort);
		scrollRect.totalCount = _raidInfos.Count;
		scrollRect.OnItemShow.RemoveAllListeners();
		scrollRect.OnItemShow.AddListener((ILoopScrollDataSource x) =>
		{
			if (x is CharacterTutorialRaidEntrance { index: >=0 } characterTutorialRaidEntrance && characterTutorialRaidEntrance.index < _raidInfos.Count)
			{
				characterTutorialRaidEntrance.Init(_raidInfos[characterTutorialRaidEntrance.index], Station);
			}
		});
		scrollRect.OnItemHide.RemoveAllListeners();
		scrollRect.RefillCells();
		PlayCharacterCellAnimation(_animationVersion).Forget();
	}

	private List<CharacterTutorialRaidInfo> GetTeamTutorialRaidInfos()
	{
		IReadOnlyList<CharacterTutorialRaidInfo> characterTeamTutorialRaidInfos = Model<CharacterTutorialModel>.Interface.GetCharacterTeamTutorialRaidInfos();
		if (characterTeamTutorialRaidInfos != null)
		{
			return new List<CharacterTutorialRaidInfo>(characterTeamTutorialRaidInfos);
		}
		return new List<CharacterTutorialRaidInfo>();
	}

	private int Sort(CharacterTutorialRaidInfo l, CharacterTutorialRaidInfo r)
	{
		bool flag = CharacterTutorialIsComplete(l);
		bool flag2 = CharacterTutorialIsComplete(r);
		if (flag != flag2)
		{
			if (!flag)
			{
				return -1;
			}
			return 1;
		}
		return l.RaidEnterId.CompareTo(r.RaidEnterId);
	}

	private bool CharacterTutorialIsComplete(CharacterTutorialRaidInfo info)
	{
		if (info == null)
		{
			return false;
		}
		Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(info.RaidId);
		if (raidInfo == null || raidInfo.CleanNum <= 0)
		{
			return false;
		}
		return true;
	}

	private async UniTask PlayCharacterCellAnimation(int animationVersion)
	{
		int childCount = scrollRect.content.childCount;
		for (int i = 0; i < childCount; i++)
		{
			if (animationVersion != _animationVersion)
			{
				return;
			}
			CharacterTutorialRaidEntrance component = scrollRect.content.GetChild(i).GetComponent<CharacterTutorialRaidEntrance>();
			if (!(component == null))
			{
				component.GotoShow();
			}
		}
		int delayMilliseconds = Mathf.RoundToInt(_characterShowDelayTime * 1000f);
		for (int j = 0; j < childCount; j++)
		{
			if (animationVersion != _animationVersion)
			{
				break;
			}
			CharacterTutorialRaidEntrance component2 = scrollRect.content.GetChild(j).GetComponent<CharacterTutorialRaidEntrance>();
			if (!(component2 == null))
			{
				component2.PlayAnimation();
				await UniTask.Delay(delayMilliseconds);
			}
		}
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		_animationVersion++;
		base.OnTabDeActive(tabItem);
		scrollRect.OnItemShow.RemoveAllListeners();
		scrollRect.OnItemHide.RemoveAllListeners();
		scrollRect.ClearCellsPool();
	}
}
