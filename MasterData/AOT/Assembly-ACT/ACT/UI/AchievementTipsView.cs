using System.Threading;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class AchievementTipsView : BaseUIView
{
	private AchievementTipsViewData m_data;

	[SerializeField]
	private Image board;

	[SerializeField]
	private BImage bg;

	[SerializeField]
	private BImage labelIcon;

	[SerializeField]
	private Image line;

	[SerializeField]
	private BImage star;

	[SerializeField]
	private TextMeshProUGUI _titleText;

	[SerializeField]
	private TextMeshProUGUI _chievementText;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	private int achievementId;

	private CancellationTokenSource _cts;

	private CancellationToken _ct;

	private AccomplishmentModel _model;

	private int localizedId1 = 2222;

	private int localizedId2 = 2223;

	private string level1Color = "#dbc0b2";

	private string level2Color = "#cee8f0";

	private string level3Color = "#fce890";

	private string normalTitleColor = "#454648";

	private string normalMainTextColor = "#15171a";

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
		await base.PreInit();
		m_data = uiViewData as AchievementTipsViewData;
	}

	protected override void Init()
	{
		base.Init();
		_model = Model<AccomplishmentModel>.Interface;
		gameObject.SetActive(value: true);
		if (m_data.Id != 0)
		{
			achievementId = m_data.Id;
			_cts = new CancellationTokenSource();
			_ct = _cts.Token;
			Refresh();
			PlayShowAnimation();
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	private void Refresh()
	{
		bool flag = _model.IsConcealAchievement(achievementId);
		if (!_model.TryGetContent(achievementId, out var content))
		{
			return;
		}
		int mainIdForContent = _model.GetMainIdForContent(achievementId);
		board.color = (flag ? Color.black : Color.white);
		line.color = (flag ? Color.white : Color.black);
		Station.LoadImage(206, 100 + content.level, bg);
		Station.LoadImage(206, mainIdForContent * 10 + content.level, labelIcon);
		star.icon.gameObject.SetActive(flag);
		Station.LoadImage(206, 1000 + content.level, star);
		_titleText.text = (flag ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, localizedId2) : LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, localizedId1));
		string empty = string.Empty;
		if (flag)
		{
			switch (content.level)
			{
			case 1:
				empty = level1Color;
				break;
			case 2:
				empty = level2Color;
				break;
			case 3:
				empty = level3Color;
				break;
			}
		}
		else
		{
			empty = normalTitleColor;
		}
		ColorUtility.TryParseHtmlString(empty, out var color);
		_titleText.color = color;
		_chievementText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, content.groupName);
		if (flag)
		{
			_chievementText.color = color;
			return;
		}
		ColorUtility.TryParseHtmlString(normalMainTextColor, out var color2);
		_chievementText.color = color2;
	}

	private void PlayShowAnimation()
	{
		_betterAnimation?.GetSequence("Show")?.OnComplete((AnimationBuilder _) =>
		{
			Hide();
		}).Play();
	}

	public void Hide()
	{
		_cts?.Cancel();
		_cts?.Dispose();
		_cts = null;
		gameObject.SetActive(value: false);
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	public override void Close()
	{
		base.Close();
	}
}
