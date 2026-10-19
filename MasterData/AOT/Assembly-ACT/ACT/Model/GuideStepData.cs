using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.UI;
using Fundamental;
using UI.ViewComponent.CharacterView.SkillUI;

namespace ACT.Model;

public abstract class GuideStepData
{
	private int _index;

	protected int _id;

	public UI_TYPE _precondition;

	private List<bool> _conditionCompleted;

	public CharacterViewScene.CvSceneType secondViewType;

	public bool waitForIconLoaded;

	public SystemType SystemId = SystemType.None;

	public string _actionPath;

	public GuideConsts.GuideType _guideType;

	public int GachaPoolId;

	public BloodBottleView.SubPanelType bloodBottlesubViewType;

	protected IGuideStepSuccessCondition _successCondition;

	protected List<IActionUninit> _uninitActions = new List<IActionUninit>();

	public bool _needTextTips;

	public int _tipsId;

	protected bool isFinsh;

	public List<ActionGroup> _conditionalActions;

	public List<GuideStepFinishConditionConfig> _finshConditionsinshs;

	protected List<RuntimeStepCondition> _runtimeStepConditions = new List<RuntimeStepCondition>();

	protected bool[] actionsTriggered;

	public GuideStepAction[] Actions;

	public GuideStepAction[] FinshActions;

	public int Index => _index;

	public int Id => _id;

	public GuideStepType Type { get; }

	public GuideStepData(GuideStepConfig config, int index)
	{
		_id = config.id;
		_index = index;
		_precondition = config.condition;
		_needTextTips = config.needTextTips;
		_tipsId = config.tipsId;
		if (config.condition == UI_TYPE.UI_CHARACTER)
		{
			secondViewType = config.secondViewType;
		}
		else if (config.condition == UI_TYPE.UI_LARGEMAP)
		{
			waitForIconLoaded = config.waitForMapIconLoaded && config.waitForMapIconLoaded;
		}
		else if (config.condition == UI_TYPE.UI_BATTLEMAIN)
		{
			SystemId = config.SystemId;
		}
		if (config.condition == UI_TYPE.UI_BLOODBOTTLE)
		{
			bloodBottlesubViewType = config.bloodBottleSubViewType;
		}
		_actionPath = config.actionPath;
		_guideType = config.guideType;
		Type = ((config is HighlightStepConfig) ? GuideStepType.Highlight : ((config is SoftHighlightStepConfig) ? GuideStepType.SoftHighlight : ((GuideStepType)0)));
		if (config is SoftHighlightStepConfig softHighlightStepConfig)
		{
			_conditionalActions = softHighlightStepConfig.conditionalActions;
			_finshConditionsinshs = softHighlightStepConfig.finshConfig;
		}
		if (config is HighlightStepConfig highlightStepConfig)
		{
			Actions = highlightStepConfig.Actions;
			FinshActions = highlightStepConfig.FinshActions;
		}
	}

	public virtual bool Prepare()
	{
		if (_precondition != UI_TYPE.UI_NONE)
		{
			return ConditionsFunction(_precondition);
		}
		return true;
	}

	public bool TickAllConditionalActions()
	{
		if (_conditionalActions == null || _conditionalActions.Count == 0)
		{
			return true;
		}
		for (int i = 0; i < _conditionalActions.Count; i++)
		{
			if (!actionsTriggered[i])
			{
				CheckactionGroupConditions(_conditionalActions[i], i);
			}
		}
		return true;
	}

	public void CheckactionGroupConditions(ActionGroup actionGroup, int index)
	{
		GuideStepCondition[] conditions = actionGroup.conditions;
		for (int i = 0; i < conditions.Length; i++)
		{
			if (!conditions[i].CheckCondition())
			{
				return;
			}
		}
		ExecuteActions(actionGroup.actions, index);
	}

	public bool CheckStepIsFinsh()
	{
		bool flag = false;
		for (int i = 0; i < _runtimeStepConditions.Count; i++)
		{
			if (_runtimeStepConditions[i].CheckCondition())
			{
				return flag = true;
			}
		}
		if (!flag)
		{
			return isFinsh;
		}
		return true;
	}

	public void ExecuteActions(GuideStepAction[] _actions, int index)
	{
		if (actionsTriggered[index])
		{
			return;
		}
		actionsTriggered[index] = true;
		if (_actions == null || _actions.Length == 0)
		{
			return;
		}
		foreach (GuideStepAction guideStepAction in _actions)
		{
			if (guideStepAction != null)
			{
				if (guideStepAction is IActionUninit item)
				{
					_uninitActions.Add(item);
				}
				guideStepAction.Execute(this);
			}
		}
	}

	private bool ConditionsFunction(UI_TYPE _guidePrepareConditionUItype)
	{
		bool flag = false;
		IBaseUIController topActiveUI = Singleton<NewUIManager>.instance.GetTopActiveUI();
		if (topActiveUI == null || topActiveUI.UIType != _guidePrepareConditionUItype)
		{
			return false;
		}
		IBaseUIView baseUIView = Singleton<NewUIManager>.instance.FindUIViewByUIType(_guidePrepareConditionUItype);
		bool flag2 = baseUIView != null && baseUIView.UIController.State == UIState.Opened;
		if (_guidePrepareConditionUItype == UI_TYPE.UI_CHARACTER)
		{
			CharacterView characterView = baseUIView as CharacterView;
			flag = flag2 && characterView.GetSecondViewAniState(secondViewType);
			if (flag && _guideType == GuideConsts.GuideType.Skill_TalentNode_Click)
			{
				RelativeSkillItem relativeSkillItem = characterView.GetCharacterSubView(CharacterViewScene.CvSceneType.Level).GetComponent<CharacterLevelUpSubView>().RelativeSkillItems.FirstOrDefault();
				flag = (bool)relativeSkillItem && relativeSkillItem.LockReason == CharacterViewConst.ReasonType.None && !relativeSkillItem.IsUnLock;
			}
		}
		else if (_guidePrepareConditionUItype == UI_TYPE.UI_LARGEMAP && waitForIconLoaded)
		{
			LargeMapView largeMapView = baseUIView as LargeMapView;
			if (largeMapView != null)
			{
				largeMapView.GuideOpen = true;
			}
			flag = flag2 && largeMapView.InteractIconLoaded;
			if (flag)
			{
				largeMapView.GuideOpen = false;
			}
		}
		else
		{
			switch (_guidePrepareConditionUItype)
			{
			case UI_TYPE.UI_BATTLEMAIN:
			{
				MonoBattleMainBaseView monoBattleMainBaseView = baseUIView as MonoBattleMainBaseView;
				if (monoBattleMainBaseView != null)
				{
					if (SystemId == SystemType.None)
					{
						flag = flag2;
					}
					else
					{
						flag = ((SystemId != SystemType.MapUnLock) ? (flag2 && monoBattleMainBaseView.GetEscItemIsActive((int)SystemId)) : (flag2 && !Model<BattleMainModel>.Interface.MiniMapModeDisabled));
					}
				}
				break;
			}
			case UI_TYPE.UI_BLOODBOTTLE:
			{
				BloodBottleView bloodBottleView = baseUIView as BloodBottleView;
				if (bloodBottleView != null && bloodBottlesubViewType != BloodBottleView.SubPanelType.None)
				{
					flag = flag2 && bloodBottleView.CheckSubPanelIsReadyForGuide(bloodBottlesubViewType);
				}
				break;
			}
			default:
				flag = flag2;
				break;
			}
		}
		if (flag)
		{
			return !Singleton<NewUIManager>.instance.IsActivePanelBusy();
		}
		return false;
	}

	public abstract void OnStart();

	public abstract void OnFinish();

	public bool IsSuccess(GuideSuccessEventData eventData)
	{
		if (_successCondition != null)
		{
			return _successCondition.IsSuccess(eventData);
		}
		return true;
	}
}
