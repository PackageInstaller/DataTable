using ACT.Battle;
using ACT.EventTrack;
using ACT.Model;
using ACT.UI.InputController;
using ACT.ViewControl;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Settings;
using UnityEngine.UI;

namespace ACT.UI;

public class TutorialCell : LoopScrollBaseItem
{
	public GraphicGuideView view;

	public ActButton btn;

	public BetterAnimation betterAnimation;

	public TextMeshProUGUI normalText;

	public TextMeshProUGUI selectedText;

	public RectTransform splitLine;

	public RedDotItem redDot;

	public CanvasGroup canvasGroup;

	public ACT.ViewControl.SelectableEx cellSelectable;

	private Vector2 normalSize = new Vector2(660f, 100f);

	private Vector2 splitLineSize = new Vector2(660f, 120f);

	private TutorialModel.TutorialData tutorialData;

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		tutorialData = view.GetTutorialDataByIndex(index);
		if (tutorialData == view.CurShowTutorialData)
		{
			betterAnimation.GetSequence("OffToOn").Play().Complete();
		}
		else
		{
			betterAnimation.GetSequence("OnToOff").Play().Complete();
		}
		Init(!view.IsShowAll || idx != Model<TutorialModel>.Interface.SplitLineCellIndex);
	}

	public override void Hide()
	{
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("OnToOff")?.Play().Complete();
		}
		base.Hide();
	}

	private void Init(bool normal)
	{
		_ = tutorialData.id;
		string localizedString = LocalizationSettings.StringDatabase.GetLocalizedString(tutorialData.table, tutorialData.localizeId, LocalizationSettings.ProjectLocale, FallbackBehavior.DontUseFallback, null);
		string text = localizedString;
		string text2 = localizedString;
		if (!string.IsNullOrEmpty(view.SearchText))
		{
			text = localizedString.Replace(view.SearchText, "<color=#EBE27B>" + view.SearchText + "</color>");
			text2 = localizedString.Replace(view.SearchText, "<color=#EBE27B>" + view.SearchText + "</color>");
		}
		normalText.text = text;
		selectedText.text = text2;
		UpdateRedDot();
		InitRedDot();
		btn.OnClick.RemoveListener(ShowTutorialInfo);
		btn.OnClick.AddListener(ShowTutorialInfo);
	}

	public void ShowTutorialInfo()
	{
		if (view.CurShowTutorialData != tutorialData)
		{
			if (MonoECS.instance.InputMode != DeviceInputMode.Gamepad && EventSystemHelper.CurrentSelected != gameObject && cellSelectable != null)
			{
				EventSystemHelper.SetSelectedGameObject(gameObject);
			}
			view.SelectTutorialCell(tutorialData);
			GuideTutorialEvent evt = EventTrackSolver.Instance.GetEvt<GuideTutorialEvent>();
			evt.op = 1;
			evt.type = (int)tutorialData.type;
			evt.tutorialId = tutorialData.id;
			evt.isRednote = redDot.gameObject.activeSelf;
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}

	public void PlayOn(bool immediately)
	{
		if (immediately)
		{
			betterAnimation.GetSequence("OffToOn").Play().Complete();
		}
		else
		{
			betterAnimation.GetSequence("OffToOn").Play();
		}
	}

	public void PlayOff(bool immediately)
	{
		if (immediately)
		{
			betterAnimation.GetSequence("OnToOff").Play().Complete();
		}
		else
		{
			betterAnimation.GetSequence("OnToOff").Play();
		}
	}

	public override void PlayCustomAnimation(float delaySecond = 0f)
	{
		base.PlayCustomAnimation(delaySecond);
		betterAnimation?.GetSequence("Show").Goto(0f).SetDelay(delaySecond)
			.Play();
	}

	public void InitRedDot()
	{
		string fullPath = RedDotPathDefine.TutorialUnRead + $"|{tutorialData.id}";
		redDot.InitRedDot(fullPath);
	}

	public void UpdateRedDot()
	{
		string nodeFullPath = RedDotPathDefine.TutorialUnRead + $"|{tutorialData.id}";
		Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, tutorialData.UnRead());
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.TutorialUnReadAll, Model<TutorialModel>.Interface.HasUnReadTutorial());
	}
}
