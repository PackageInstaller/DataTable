using System;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using Bamboo.Collections;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class EliteProgress : MonoBehaviour
{
	[SerializeField]
	private Transform _talentCellRoot;

	private const int SKILL_NUM = 3;

	private BArray<int> _skillUnlockNum;

	private int _maxNum;

	private int stage;

	public EliteTalentCell[] talentCellList;

	public void Init(Character character, ImageAssetStation station, Action<int, int> onSelectPoint, bool isLevelChange)
	{
		int eliteActiveLevel = character.GetEliteActiveLevel();
		_skillUnlockNum = BArrayPool<int>.Default.Get(3);
		_skillUnlockNum[0] = RuntimeConfigs.data.game.eliteSkill1Num;
		_skillUnlockNum[1] = RuntimeConfigs.data.game.eliteSkill2Num;
		_skillUnlockNum[2] = RuntimeConfigs.data.game.eliteSkill3Num;
		_maxNum = _skillUnlockNum[2];
		int element = RuntimeConfigs.data.entityDatas[character.Id].element;
		stage = Model<EliteModel>.Interface.GetEliteStage(character);
		if (_talentCellRoot != null)
		{
			talentCellList = _talentCellRoot.GetComponentsInChildren<EliteTalentCell>();
			int[] allSkillIds = CoreUtils.GetData(character.Id, RuntimeConfigs.data.eliteTrainingMaps).characterSkill;
			for (int i = 0; i < talentCellList.Length; i++)
			{
				int index = i;
				talentCellList[i].SetData(allSkillIds[i], eliteActiveLevel, _skillUnlockNum[i], element, station, index + 1, stage, isLevelChange, character.IsTrailCharacter);
				talentCellList[i].GetComponent<ActButton>().OnClick.RemoveAllListeners();
				talentCellList[i].GetComponent<ActButton>().OnClick.AddListener(() =>
				{
					Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/Talent");
					Model<EliteModel>.Interface.IsTalentPoint = true;
					onSelectPoint?.Invoke(allSkillIds[index], index + 1);
					if (character != null)
					{
						if (Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_POPUPELITELEVELUPNEW) != UIState.Opened)
						{
							Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPELITELEVELUPNEW, new PopupEliteLevelUpNewViewData
							{
								character = character,
								elitePointId = allSkillIds[index],
								isTalentPoint = true,
								indexOfThreeProgress = index,
								pointStageIndex = index + 1
							});
							CharacterViewCanvasGroupRefreshEvt evt = Singleton<EventManager>.instance.GetEvt<CharacterViewCanvasGroupRefreshEvt>();
							evt.alphaValue = 0f;
							Singleton<EventManager>.instance.EventDispatch(ClientEvent.SetCharacterViewCanvasGroup, evt);
							Singleton<EventManager>.instance.ReleaseEvt(evt);
						}
						else
						{
							EliteSelectPointRefresh evt2 = Singleton<EventManager>.instance.GetEvt<EliteSelectPointRefresh>();
							evt2.elitePointId = allSkillIds[index];
							evt2.isTalent = true;
							evt2.indexOfThreeProgress = i;
							evt2.pointStageIndex = i + 1;
							Singleton<EventManager>.instance.EventDispatch(ClientEvent.EliteRefreshSelectPoint, evt2);
							Singleton<EventManager>.instance.ReleaseEvt(evt2);
						}
					}
				});
			}
		}
		SetActiveNumText(eliteActiveLevel);
	}

	public void UnInit()
	{
		BArrayPool<int>.Default.Recycle(_skillUnlockNum);
		_skillUnlockNum = null;
		_maxNum = 0;
	}

	public void OnActiveNumChange(int activeNum)
	{
		SetActiveNumText(activeNum);
	}

	private void SetActiveNumText(int activeNum)
	{
	}

	public void RefreshSelectedPoint(int pointId, int talentCellIndex, bool gamePadShowPreviousTrail = false, bool prevWasTalent = false, int prevPointId = -1, int prevTalentCellIndex = -1)
	{
		if (talentCellList != null)
		{
			EliteTalentCell[] array = talentCellList;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].RefreshSelect(pointId, talentCellIndex, gamePadShowPreviousTrail, prevWasTalent, prevPointId, prevTalentCellIndex);
			}
		}
	}
}
