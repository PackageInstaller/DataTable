using ACT.Battle;
using ACT.Core;
using ACT.Model;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class EliteTalentCell : MonoBehaviour
{
	[SerializeField]
	private PublicToggle unlockToggle;

	[SerializeField]
	private TextMeshProUGUI levelText;

	[SerializeField]
	private Image stageUnLock;

	[SerializeField]
	private Image finalStageBoard_UnLock;

	[SerializeField]
	private BImage activeIcon;

	[SerializeField]
	private Image activeIconGO;

	[SerializeField]
	private Image stageLock;

	[SerializeField]
	private Image finalStageBoard_Lock;

	[SerializeField]
	private BImage notActiveIcon;

	[SerializeField]
	private Image notActiveIconGO;

	[SerializeField]
	private Image selectIcon;

	[SerializeField]
	private GameObject _gamePadHighLightRoot;

	private int iconId;

	private ImageAssetStation _station;

	private bool isTalentActive;

	private int _talentCellIndex;

	private BetterAnimation _betterAnimation;

	public int CharacterSkillId { get; private set; }

	public int CurPointLevel { get; private set; }

	public int NeedPointLevel { get; private set; }

	public void SetData(int characterSkillId, int curPointLevel, int needPointLevel, int colorIndex, ImageAssetStation station, int talentCellIndex, int stage, bool isLevelChange, bool isTrialCharacter = false)
	{
		_betterAnimation = gameObject.GetComponent<BetterAnimation>();
		CharacterSkillId = characterSkillId;
		CurPointLevel = curPointLevel;
		NeedPointLevel = needPointLevel;
		_station = station;
		_talentCellIndex = talentCellIndex;
		stageUnLock.gameObject.SetActive(value: false);
		finalStageBoard_UnLock.gameObject.SetActive(value: false);
		stageLock.gameObject.SetActive(value: false);
		finalStageBoard_Lock.gameObject.SetActive(value: false);
		activeIconGO.gameObject.SetActive(value: false);
		notActiveIconGO.gameObject.SetActive(value: false);
		selectIcon.gameObject.SetActive(value: false);
		_gamePadHighLightRoot?.SetActive(value: false);
		isTalentActive = Model<EliteModel>.Interface.IsTalentActive(_talentCellIndex, CurPointLevel, isTrialCharacter);
		if (isLevelChange)
		{
			CheckEliteTalentAnimation(isTalentActive, _talentCellIndex, CurPointLevel);
		}
		if (isTalentActive)
		{
			switch (talentCellIndex)
			{
			case 1:
				stageUnLock.gameObject.SetActive(value: true);
				iconId = 20;
				break;
			case 2:
				stageUnLock.gameObject.SetActive(value: true);
				iconId = 21;
				break;
			default:
				finalStageBoard_UnLock.gameObject.SetActive(value: true);
				iconId = 22;
				break;
			}
			activeIconGO.gameObject.SetActive(value: true);
			_station.LoadImage(151, iconId, activeIcon);
		}
		else
		{
			switch (talentCellIndex)
			{
			case 1:
				stageLock.gameObject.SetActive(value: true);
				iconId = 10;
				break;
			case 2:
				stageLock.gameObject.SetActive(value: true);
				iconId = 11;
				break;
			default:
				finalStageBoard_Lock.gameObject.SetActive(value: true);
				iconId = 12;
				break;
			}
			notActiveIconGO.gameObject.SetActive(value: true);
			_station.LoadImage(151, iconId, notActiveIcon);
		}
		unlockToggle.isOn = isTalentActive;
		levelText.text = needPointLevel.ToString();
	}

	private void CheckEliteTalentAnimation(bool isActive, int talentCellIndex, int curPointLevel)
	{
		if (!isActive)
		{
			return;
		}
		switch (talentCellIndex)
		{
		case 1:
			if (curPointLevel == RuntimeConfigs.data.game.eliteSkill1Num)
			{
				_betterAnimation.GetSequence("Activation")?.Play();
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/ElitistStage");
			}
			break;
		case 2:
			if (curPointLevel == RuntimeConfigs.data.game.eliteSkill2Num)
			{
				_betterAnimation.GetSequence("Activation")?.Play();
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/ElitistStage");
			}
			break;
		case 3:
			if (curPointLevel == RuntimeConfigs.data.game.eliteSkill3Num)
			{
				_betterAnimation.GetSequence("Activation")?.Play();
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Elite/ElitistStage");
			}
			break;
		}
	}

	public void Refresh(int curPointLevel, int needPointLevel)
	{
		unlockToggle.isOn = curPointLevel >= needPointLevel;
	}

	public void RefreshSelect(int pointId, int talentCellIndex, bool gamePadShowPreviousTrail = false, bool prevWasTalent = false, int prevPointId = -1, int prevTalentCellIndex = -1)
	{
		bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		bool flag2 = (gamePadShowPreviousTrail & flag & prevWasTalent) && prevPointId >= 0 && prevPointId == CharacterSkillId && prevTalentCellIndex == _talentCellIndex;
		if (!Model<EliteModel>.Interface.IsTalentPoint)
		{
			selectIcon.gameObject.SetActive(value: false);
			RefreshGamePadHighlight(isCurrentSelection: false, flag2);
			return;
		}
		bool flag3 = pointId == CharacterSkillId && talentCellIndex == _talentCellIndex;
		UIState firstUIState = Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_POPUPELITELEVELUPNEW);
		bool flag4 = firstUIState == UIState.Opening || firstUIState == UIState.Opened;
		bool flag5 = flag & flag3;
		selectIcon.gameObject.SetActive(flag5 || (flag4 & flag3));
		RefreshGamePadHighlight(flag3 & flag, flag2 && !flag3);
	}

	private void RefreshGamePadHighlight(bool isCurrentSelection, bool isPreviousGamePadStep)
	{
		if (!(_gamePadHighLightRoot == null))
		{
			bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
			_gamePadHighLightRoot.SetActive(flag & isCurrentSelection);
		}
	}
}
