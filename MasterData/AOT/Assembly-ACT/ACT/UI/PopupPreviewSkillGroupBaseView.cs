using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.ViewComponent.CharacterView.SkillUI;
using Runtime.UI.ViewComponent.CharacterViewV3.SkillUI;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class PopupPreviewSkillGroupBaseView : BaseUIView<PopupPreviewSkillGroupViewController>
{
	public LevelUpOSA levelScrollView;

	public LocalizeStringEvent skillName;

	public BImage skillIcon;

	[Header("当前等级")]
	public TextMeshProUGUI from;

	public GameObject fromSpecialTip;

	[Header("预览等级")]
	public TextMeshProUGUI to;

	public GameObject toSpecialTip;

	[Header("属性")]
	public GameObject propertyPrefab;

	public RectTransform propertyContent;

	public GameObject maxButtonRoot;

	public TMP_Text maxLevelText;

	public ScrollRect scrollRect;

	[Header("特殊等级加成")]
	public Color specialColor;

	[Header("手柄提示组件")]
	public GamePadTipsComp gamePadTips;

	public ViewControlLayer viewControlLayer;

	private List<GamePadTipsAction> _tipsActions = new List<GamePadTipsAction>();

	private Dictionary<string, GamePadTipsAction> actionDic = new Dictionary<string, GamePadTipsAction>();

	protected PopupPreviewSkillGroupBaseViewData m_data;

	private SkillGroupLevelData m_LevelData;

	private int m_currentLevel;

	private int m_MaxLevel;

	private Color m_OriginalColor;

	protected SkillGroupData m_skillGroupData;

	private const string _splitor = "<br>";

	private const string _blank = "<nbsp>";

	private readonly Stack<GameObject> m_PropertyCellPool = new Stack<GameObject>();

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
		InitGameTipsDic();
	}

	private void InitGameTipsDic()
	{
		actionDic.Add("UI/RSUpDownSelect", new GamePadTipsAction
		{
			inputAction = "UI/RSUpDownSelect",
			localizeKey = 2165,
			localizeTable = "Common"
		});
		actionDic.Add("UI/Back", new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		});
	}

	private void GamePadTipsInit()
	{
		gamePadTips.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(actionDic["UI/Back"]);
		if (scrollRect.content.rect.height > scrollRect.viewport.rect.height)
		{
			_tipsActions.Add(actionDic["UI/RSUpDownSelect"]);
		}
		gamePadTips.RegisterInputActions(_tipsActions);
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Skill/Window");
		m_data = uiViewData as PopupPreviewSkillGroupBaseViewData;
		m_skillGroupData = CoreUtils.GetData(m_data.skillGroupId, RuntimeConfigs.data.skillGroupDatas);
		skillName.StringReference.TableEntryReference = m_skillGroupData.skillSetLocal;
		int num = ((m_skillGroupData.skillType != 1) ? m_skillGroupData.skillType : m_data.skillGroupId);
		int id = num;
		Station.LoadImageAsync(141, id, skillIcon).Forget();
		m_currentLevel = m_data.character.GetSkillGroupEventualLevel(m_skillGroupData.id);
		int minLevel = 1;
		int num2 = m_currentLevel;
		if (m_data.character.SkillGroupLevels.TryGetValue(m_skillGroupData.id, out var value))
		{
			num2 = value;
		}
		int num3 = m_currentLevel - num2;
		m_MaxLevel = Mathf.Min(m_skillGroupData.maxLevel, m_skillGroupData.levelUpLimit + num3);
		maxLevelText.SetText(m_MaxLevel.FastToString());
		m_OriginalColor = to.color;
		from.color = ((num3 > 0) ? specialColor : m_OriginalColor);
		fromSpecialTip.SetActive(num3 > 0);
		from.SetText(m_currentLevel.FastToString());
		RecyclePropertyCells();
		SkillGroupLevelData data = CoreUtils.GetData(m_skillGroupData.GetSkillGroupLevelId(m_currentLevel), RuntimeConfigs.data.skillGroupLevelDatas);
		for (int i = 0; i < data.skillDes.Length; i++)
		{
			SkillLevelUpPropertyCell propertyCell = GetPropertyCell();
			propertyCell.transform.SetSiblingIndex(i);
			propertyCell.Init(data.skillDes[i], m_currentLevel, m_currentLevel);
		}
		UpdateMainPanel(Mathf.Clamp(m_currentLevel + 1, 0, m_skillGroupData.maxLevel));
		levelScrollView.Parameters.needLimitMin = false;
		levelScrollView.PassingAudioEventName = "event:/UI/Interface/Skill/Upgrade_Slide";
		levelScrollView.ItemSourceDataContext = new SkillLevelCellDataContext
		{
			baseLevel = m_skillGroupData.levelUpLimit,
			maxLevel = m_MaxLevel,
			onClickCell = OnScrollToIndex
		};
		levelScrollView.Reload(minLevel, m_MaxLevel, Mathf.Clamp(m_currentLevel + 1, 0, m_MaxLevel), 0, UpdateMainPanel);
		LayoutRebuilder.ForceRebuildLayoutImmediate(propertyContent);
		GamePadTipsInit();
		viewControlLayer.SetDefaultSelect(levelScrollView.GetMiddleSelectableEx(isVertical: true));
		viewControlLayer.Focus();
	}

	private void UpdateMainPanel(int level)
	{
		maxButtonRoot.SetActive(level != m_MaxLevel);
		to.SetText(level.FastToString());
		to.color = ((m_MaxLevel > m_skillGroupData.levelUpLimit) ? specialColor : m_OriginalColor);
		toSpecialTip.SetActive(m_MaxLevel > m_skillGroupData.levelUpLimit);
		int num = 0;
		int[] skillDes = CoreUtils.GetData(m_skillGroupData.GetSkillGroupLevelId(level), RuntimeConfigs.data.skillGroupLevelDatas).skillDes;
		foreach (int skillMessageId in skillDes)
		{
			propertyContent.GetChild(num++).GetComponent<SkillLevelUpPropertyCell>().Init(skillMessageId, m_currentLevel, level);
		}
	}

	public void OnScrollToIndex(int index)
	{
		levelScrollView.SmoothScrollTo(index - 1, 0.5f, 0.5f, 0.5f, null, () =>
		{
			UpdateMainPanel(index);
		});
	}

	public void ScrollToMax()
	{
		levelScrollView.SmoothScrollTo(m_MaxLevel - 1, 0.5f, 0.5f, 0.5f, null, () =>
		{
			UpdateMainPanel(m_MaxLevel);
		});
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		try
		{
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder x) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
			OpenEffectFinishNew();
		}
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		RecyclePropertyCells();
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		try
		{
			betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder x) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
			CloseEffectFinishNew();
		}
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void RecyclePropertyCells()
	{
		if (propertyContent == null)
		{
			return;
		}
		for (int num = propertyContent.childCount - 1; num >= 0; num--)
		{
			Transform child = propertyContent.GetChild(num);
			if ((bool)child.GetComponent<SkillLevelUpPropertyCell>())
			{
				ReturnPropertyCell(child.gameObject);
			}
		}
	}

	private SkillLevelUpPropertyCell GetPropertyCell()
	{
		SkillLevelUpPropertyCell skillLevelUpPropertyCell = ((m_PropertyCellPool.Count > 0) ? m_PropertyCellPool.Pop().GetComponent<SkillLevelUpPropertyCell>() : UnityEngine.Object.Instantiate(propertyPrefab, propertyContent).GetComponent<SkillLevelUpPropertyCell>());
		skillLevelUpPropertyCell.transform.SetParent(propertyContent);
		skillLevelUpPropertyCell.gameObject.SetActive(value: true);
		return skillLevelUpPropertyCell;
	}

	private void ReturnPropertyCell(GameObject go)
	{
		go.transform.SetParent(transform);
		go.SetActive(value: false);
		m_PropertyCellPool.Push(go);
	}
}
