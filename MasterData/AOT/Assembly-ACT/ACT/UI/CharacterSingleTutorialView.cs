using System.Collections.Generic;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.Interface;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class CharacterSingleTutorialView : BaseTabContent
{
	public LoopScrollRect scrollRect;

	public Transform content;

	[SerializeField]
	private float _characterShowDelayTime = 0.05f;

	private TrainingTabView _trainingTabView;

	private List<Character> characters;

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
			CreateEntrance();
		}
	}

	private void CreateEntrance()
	{
		_animationVersion++;
		scrollRect.ClearCellsPool();
		characters = GetTutorialCharacters();
		characters.Sort(Sort);
		scrollRect.totalCount = characters.Count;
		scrollRect.OnItemShow.RemoveAllListeners();
		scrollRect.OnItemShow.AddListener((ILoopScrollDataSource x) =>
		{
			if (x is CharacterTutorialRaidEntrance { index: >=0 } characterTutorialRaidEntrance && characterTutorialRaidEntrance.index < characters.Count)
			{
				Character character = characters[characterTutorialRaidEntrance.index];
				CharacterTutorialRaidInfo characterTutorialRaidInfoByCharacterId = Model<CharacterTutorialModel>.Interface.GetCharacterTutorialRaidInfoByCharacterId(character.Id);
				characterTutorialRaidEntrance.Init(characterTutorialRaidInfoByCharacterId, Station);
			}
		});
		scrollRect.OnItemHide.RemoveAllListeners();
		scrollRect.RefillCells();
		PlayCharacterCellAnimation(_animationVersion).Forget();
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

	private List<Character> GetTutorialCharacters()
	{
		List<Character> bagCharacters = CharacterDataHelper.GetBagCharacters();
		List<Character> list = new List<Character>();
		HashSet<int> hashSet = new HashSet<int>();
		foreach (Character item in bagCharacters)
		{
			if (item != null && hashSet.Add(item.Id) && Model<CharacterTutorialModel>.Interface.GetCharacterTutorialRaidInfoByCharacterId(item.Id) != null)
			{
				list.Add(item);
			}
		}
		return list;
	}

	private int Sort(Character l, Character r)
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
		if (!flag)
		{
			int num = l.GotTime.CompareTo(r.GotTime);
			if (num != 0)
			{
				return num;
			}
		}
		return l.Id.CompareTo(r.Id);
	}

	private bool CharacterTutorialIsComplete(Character character)
	{
		CharacterTutorialRaidInfo characterTutorialRaidInfoByCharacterId = Model<CharacterTutorialModel>.Interface.GetCharacterTutorialRaidInfoByCharacterId(character.Id);
		if (characterTutorialRaidInfoByCharacterId == null)
		{
			return false;
		}
		Raid raidInfo = Model<RaidModel>.Interface.GetRaidInfo(characterTutorialRaidInfoByCharacterId.RaidId);
		if (raidInfo == null || raidInfo.CleanNum <= 0)
		{
			return false;
		}
		return true;
	}
}
