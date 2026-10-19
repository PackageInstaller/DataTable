using ACT.Config;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class BattleMainCharacterTeamTutorialComponent : MonoBehaviour, IBattleMainComponent
{
	[SerializeField]
	private BImage targetBoard;

	[SerializeField]
	private BImage targetIcon;

	[SerializeField]
	private TextMeshProUGUI targetText;

	private LocalizeStringEvent _targetTextLocalize;

	private ImageAssetStation _imageStation;

	private OperateBtnComp _operateBtnComp;

	private CharacterTutorialHighLight _characterTutorialHighLight;

	private OperateNodeData _curNodeData;

	private LocalizeStringData _defaultTargetLocalizeData;

	private RectTransform _battleMainViewControlTransform;

	private int _targetImageState = -1;

	private const int localizeId = 2747;

	private const int TargetBoardDoingImageId = 1;

	private const int TargetBoardCompletedImageId = 2;

	private const int TargetIconDoingImageId = 11;

	private const int TargetIconCompletedImageId = 12;

	public void Initialize(MonoBattleMainBaseView view)
	{
		_imageStation = view.Station;
		_targetImageState = -1;
		_operateBtnComp = view.operateBtnComp;
		_battleMainViewControlTransform = view.ControlTransform;
		_targetTextLocalize = ((targetText != null) ? targetText.GetComponent<LocalizeStringEvent>() : null);
		_characterTutorialHighLight = GetComponentInChildren<CharacterTutorialHighLight>(includeInactive: true);
		_defaultTargetLocalizeData = new LocalizeStringData(LocalizeTable.Common, 2747);
		ShowDefaultTarget();
	}

	public void UnInitialize()
	{
		UnSubscribeEvents();
		ClearTarget();
		_targetImageState = -1;
	}

	public void OpenComponent()
	{
		SubscribeEvents();
		if (!ShouldShowComponent())
		{
			ClearTarget();
			gameObject.SetActive(value: false);
		}
		else
		{
			gameObject.SetActive(value: true);
			ShowDefaultTargetIfTutorialInactive();
		}
	}

	public void CloseComponent()
	{
		UnSubscribeEvents();
		ClearTarget();
		gameObject.SetActive(value: false);
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	private void SubscribeEvents()
	{
		UnSubscribeEvents();
		Model<CharacterTutorialModel>.Interface.OnInteractRefresh += OnInteractRefresh;
		Model<CharacterTutorialModel>.Interface.OnCharacterTeamTutorialStart += OnCharacterTeamTutorialStart;
		Model<CharacterTutorialModel>.Interface.OnCharacterTeamTutorialFinish += OnCharacterTeamTutorialFinish;
		Model<CharacterTutorialModel>.Interface.OnPromptProcessChanged += OnPromptProcessChanged;
		Model<CharacterTutorialModel>.Interface.OnToNextOperateNode += OnToNextOperateNode;
		Model<CharacterTutorialModel>.Interface.OnOperateNodeBackTo += OnOperateNodeBackTo;
		Model<CharacterTutorialModel>.Interface.OnOperateNodeSuccess += OnOperateNodeSuccess;
		Model<CharacterTutorialModel>.Interface.OnOperateNodeSecondEnergyShowDesc += OnOperateNodeSecondEnergyShowDesc;
	}

	private void UnSubscribeEvents()
	{
		if (Model<CharacterTutorialModel>.HasInstance())
		{
			Model<CharacterTutorialModel>.Interface.OnInteractRefresh -= OnInteractRefresh;
			Model<CharacterTutorialModel>.Interface.OnCharacterTeamTutorialStart -= OnCharacterTeamTutorialStart;
			Model<CharacterTutorialModel>.Interface.OnCharacterTeamTutorialFinish -= OnCharacterTeamTutorialFinish;
			Model<CharacterTutorialModel>.Interface.OnPromptProcessChanged -= OnPromptProcessChanged;
			Model<CharacterTutorialModel>.Interface.OnToNextOperateNode -= OnToNextOperateNode;
			Model<CharacterTutorialModel>.Interface.OnOperateNodeBackTo -= OnOperateNodeBackTo;
			Model<CharacterTutorialModel>.Interface.OnOperateNodeSuccess -= OnOperateNodeSuccess;
			Model<CharacterTutorialModel>.Interface.OnOperateNodeSecondEnergyShowDesc -= OnOperateNodeSecondEnergyShowDesc;
		}
	}

	private void OnInteractRefresh()
	{
		ShowDefaultTarget(completed: true);
	}

	private void OnCharacterTeamTutorialStart()
	{
		if (ShouldShowComponent())
		{
			gameObject.SetActive(value: true);
			ShowDefaultTarget();
		}
	}

	private void OnCharacterTeamTutorialFinish()
	{
		ShowDefaultTarget(completed: true);
		OpenSettleViewIfTutorialCompleted();
	}

	private void OpenSettleViewIfTutorialCompleted()
	{
		if (Model<CharacterTutorialModel>.Interface.TryConsumeTutorialCompleteFlag() && Model<RaidModel>.HasInstance())
		{
			Model<RaidModel>.Interface.RaidSettlement();
		}
	}

	private void OnPromptProcessChanged(PromptProcessData processData)
	{
		if (!Model<CharacterTutorialModel>.Interface.InCharacterTeamTutorial)
		{
			ShowDefaultTarget();
		}
		else if (processData == null)
		{
			_curNodeData = null;
			SetTargetImages(completed: true);
			HideHighLight();
		}
		else
		{
			ApplyProcessTarget(processData);
		}
	}

	private void ApplyProcessTarget(PromptProcessData processData)
	{
		_curNodeData = null;
		SetTargetImages(completed: false);
		SetTargetText(GetTeamProcessTargetText(processData, processData.titleLocalizeData));
	}

	private void OnToNextOperateNode(OperateNodeData nodeData)
	{
		if (Model<CharacterTutorialModel>.Interface.InCharacterTeamTutorial)
		{
			ApplyNodeTarget(nodeData);
		}
	}

	private void ApplyNodeTarget(OperateNodeData nodeData)
	{
		_curNodeData = nodeData;
		SetTargetImages(completed: false);
		SetTargetText(GetTeamNodeTargetText(nodeData, GetCurrentTeamProcessTargetText(nodeData?.NodeNameLocalizeData)));
	}

	private void OnOperateNodeBackTo(OperateNodeData nodeData)
	{
		if (Model<CharacterTutorialModel>.Interface.InCharacterTeamTutorial)
		{
			ApplyNodeTarget(nodeData);
		}
	}

	private void OnOperateNodeSuccess(OperateNodeData nodeData, bool isLast)
	{
		if (Model<CharacterTutorialModel>.Interface.InCharacterTeamTutorial && (_curNodeData == null || nodeData == null || _curNodeData.Index == nodeData.Index) && isLast)
		{
			SetTargetImages(completed: true);
			_curNodeData = null;
			HideHighLight();
		}
	}

	private void OnOperateNodeSecondEnergyShowDesc(int nodeId)
	{
		if (Model<CharacterTutorialModel>.Interface.InCharacterTeamTutorial && !(_characterTutorialHighLight == null) && !(_operateBtnComp == null))
		{
			_characterTutorialHighLight.gameObject.SetActive(value: true);
			_characterTutorialHighLight.InitTeam(_operateBtnComp, _battleMainViewControlTransform, nodeId, gameObject);
		}
	}

	private void SetTargetText(LocalizeStringData localizeStringData)
	{
		if (targetText == null)
		{
			return;
		}
		if (localizeStringData != null && localizeStringData.IsValid())
		{
			if (_targetTextLocalize != null)
			{
				_targetTextLocalize.SetReference(localizeStringData);
			}
			targetText.SetText(LocalizationUtility.GetLocalizeString(localizeStringData));
		}
		else
		{
			targetText.SetText(string.Empty);
		}
	}

	private bool ShouldShowComponent()
	{
		if (Model<CharacterTutorialModel>.Interface.InCharacterTeamTutorial)
		{
			return true;
		}
		if (Model<BattleMainModel>.HasInstance())
		{
			return Model<BattleMainModel>.Interface.hudType == HudType.CharacterTeamTutorial;
		}
		return false;
	}

	private void ShowDefaultTargetIfTutorialInactive()
	{
		if (!Model<CharacterTutorialModel>.Interface.InCharacterTeamTutorial)
		{
			ShowDefaultTarget();
		}
	}

	private void ShowDefaultTarget(bool completed = false)
	{
		_curNodeData = null;
		SetTargetImages(completed);
		SetTargetText(_defaultTargetLocalizeData);
		HideHighLight();
	}

	private void SetTargetImages(bool completed)
	{
		if (_imageStation == null)
		{
			return;
		}
		int num = (completed ? 1 : 0);
		if (_targetImageState != num)
		{
			_targetImageState = num;
			int id = ((!completed) ? 1 : 2);
			int id2 = (completed ? 12 : 11);
			if (targetBoard != null)
			{
				_imageStation.LoadImage(217, id, targetBoard);
			}
			if (targetIcon != null)
			{
				_imageStation.LoadImage(217, id2, targetIcon);
			}
		}
	}

	private LocalizeStringData GetTeamNodeTargetText(OperateNodeData nodeData, LocalizeStringData fallback)
	{
		if (nodeData == null)
		{
			return fallback;
		}
		int nodeId = Model<CharacterTutorialModel>.Interface.GetNodeId(nodeData.Index);
		TeamAtackRutorial teamAtackRutorial = Model<CharacterTutorialModel>.Interface.GetTeamAtackRutorial(nodeId);
		if (teamAtackRutorial == null || teamAtackRutorial.missionDesText <= 0)
		{
			return fallback;
		}
		return new LocalizeStringData(LocalizeTable.LongCommon, teamAtackRutorial.missionDesText);
	}

	private LocalizeStringData GetTeamProcessTargetText(PromptProcessData processData, LocalizeStringData fallback)
	{
		if (processData == null)
		{
			return fallback;
		}
		TeamAtackRutorial teamAtackRutorial = Model<CharacterTutorialModel>.Interface.GetTeamAtackRutorial(processData.id);
		if (teamAtackRutorial == null || teamAtackRutorial.missionDesText <= 0)
		{
			return fallback;
		}
		return new LocalizeStringData(LocalizeTable.LongCommon, teamAtackRutorial.missionDesText);
	}

	private LocalizeStringData GetCurrentTeamProcessTargetText(LocalizeStringData fallback)
	{
		return GetTeamProcessTargetText(Model<CharacterTutorialModel>.Interface.CurrentPromptProcessData, fallback);
	}

	private void ClearTarget()
	{
		_curNodeData = null;
		if (targetText != null)
		{
			targetText.SetText(string.Empty);
		}
		HideHighLight();
	}

	private void HideHighLight()
	{
		if (_characterTutorialHighLight != null)
		{
			_characterTutorialHighLight.gameObject.SetActive(value: false);
		}
	}
}
