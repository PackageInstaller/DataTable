using System.Collections.Generic;
using ACT.Battle;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class CharacterTutorialEntranceBaseView : BaseUIView<CharacterTutorialEntranceInputController>
{
	protected CharacterTutorialEntranceBaseViewData m_data;

	[SerializeReference]
	private GameObject entrancePrefab;

	[SerializeReference]
	private RectTransform entranceRoot;

	[SerializeReference]
	private ActButton BtnEnter;

	public GamePadTipsComp bottomBtnPrompt;

	[SerializeField]
	private float _characterShowDelayTime = 0.05f;

	[SerializeField]
	private RectTransform _content;

	private List<Character> characters;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

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
		BtnEnter.SetBtnClick(EnterTrainingGround);
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>();
		_tipsActions = new List<GamePadTipsAction>();
		_allInputPrompt["UI/Back"] = new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		};
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		CreateEntrance();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").Goto(0f);
		betterAnimation.GetSequence("Show")?.OnAnimationPlay((AnimationBuilder _) =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Open");
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		_allInputPrompt?.Clear();
		_tipsActions?.Clear();
		DestroyEntrance();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide")?.Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
		if (MonoECS.instance.sceneStatus == SceneStatus.Raid)
		{
			Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main).Forget();
		}
	}

	private void CreateEntrance()
	{
		characters = CharacterDataHelper.GetBagCharacters();
		characters.Sort(Sort);
		foreach (Character character in characters)
		{
			CharacterTutorialRaidEntrance component = Object.Instantiate(entrancePrefab, entranceRoot).GetComponent<CharacterTutorialRaidEntrance>();
			if (!(component == null))
			{
				CharacterTutorialRaidInfo characterTutorialRaidInfoByCharacterId = Model<CharacterTutorialModel>.Interface.GetCharacterTutorialRaidInfoByCharacterId(character.Id);
				if (characterTutorialRaidInfoByCharacterId != null)
				{
					component.InitData(characterTutorialRaidInfoByCharacterId);
				}
			}
		}
		PlayCharacterCellAnimation().Forget();
	}

	private int Sort(Character l, Character r)
	{
		bool flag = CharacterTutorialIsComplete(l);
		bool flag2 = CharacterTutorialIsComplete(r);
		if (flag != flag2)
		{
			if (flag)
			{
				return 1;
			}
			return -1;
		}
		if (!flag && !flag2)
		{
			l.GotTime.CompareTo(r.GotTime);
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

	private async UniTask PlayCharacterCellAnimation()
	{
		for (int i = 0; i < characters.Count; i++)
		{
			_content.GetChild(i).GetComponent<CharacterTutorialRaidEntrance>().GotoShow();
		}
		for (int j = 0; j < characters.Count; j++)
		{
			_content.GetChild(j).GetComponent<CharacterTutorialRaidEntrance>().PlayAnimation();
			await UniTask.Delay((int)_characterShowDelayTime * 1000);
		}
	}

	private void DestroyEntrance()
	{
		for (int i = 0; i < entranceRoot.childCount; i++)
		{
			Object.Destroy(entranceRoot.GetChild(i).gameObject);
		}
	}

	public void EnterTrainingGround()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/TrainingGround/Play");
		if (MonoECS.instance.playState != PlayState.UnBattle)
		{
			GameUtility.OpenToolTip(1184);
			return;
		}
		MonoECS.instance.SyncGameInfos();
		Model<TrainingGroundModel>.Interface.MainWorldBattleCharaPostion = Vector3.zero;
		Model<TrainingGroundModel>.Interface.MainWorldBattleCharaPostion = MonoECS.instance.localPlayer.battleEntity.GetCompPhysics().SyncPosition;
		G.service.EnterTrainingGround((bool r) =>
		{
			if (r)
			{
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Trainingground);
			}
		});
	}

	public void RefreshBottomBtnPrompt()
	{
		bottomBtnPrompt?.ClearAllPrompts();
		_tipsActions?.Clear();
		_tipsActions?.Add(_allInputPrompt["UI/Back"]);
	}

	public void HandleGamePadSpecial1()
	{
		if (BtnEnter != null && BtnEnter.IsInteractable())
		{
			BtnEnter.OnSubmit(null);
		}
	}
}
