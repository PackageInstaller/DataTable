using System;
using System.Threading;
using ACT.Battle;
using ACT.Model;
using ACT.Utility;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class AchievementHudTips : BaseUIComponent, IBattleMainComponent
{
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

	public BetterAnimation betterAnimation;

	[SerializeField]
	private GameObject goldRoot;

	[SerializeField]
	private GameObject silverRoot;

	[SerializeField]
	private GameObject copperRoot;

	private int achievementId;

	private CancellationTokenSource _cts;

	private CancellationToken _ct;

	private AccomplishmentModel _model;

	private int localizedId1 = 2713;

	private int localizedId2 = 2714;

	private string level1Color = "#dbc0b2";

	private string level2Color = "#cee8f0";

	private string level3Color = "#fce890";

	public void Initialize(MonoBattleMainBaseView view)
	{
	}

	public void UnInitialize()
	{
		Hide();
	}

	public void Show(AchievementHudTipsData data, ImageAssetStation station, Action openFail)
	{
		onClose = () =>
		{
			Model<BattleMainModel>.Interface.HudPositionUIDequeue(UIPosition.UpperMiddle);
		};
		ShowAsync(data, station, openFail).Forget();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Achieve");
	}

	private async UniTaskVoid ShowAsync(AchievementHudTipsData data, ImageAssetStation station, Action openFail)
	{
		try
		{
			if (data == null || data.Id == 0)
			{
				openFail?.Invoke();
				Hide();
				return;
			}
			_model = Model<AccomplishmentModel>.Interface;
			achievementId = data.Id;
			_cts?.Cancel();
			_cts?.Dispose();
			_cts = new CancellationTokenSource();
			_ct = _cts.Token;
			await WaitUntilUltraTimelineFinished(_ct);
			gameObject.SetActive(value: true);
			Refresh(station);
			PlayShowAnimation();
		}
		catch (OperationCanceledException)
		{
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"成就Hud提示打开失败：{arg}");
			}
			openFail?.Invoke();
			Hide();
		}
	}

	private static async UniTask WaitUntilUltraTimelineFinished(CancellationToken cancellationToken)
	{
		if (IsMainEntityInUltraTimeline())
		{
			await UniTask.WaitUntil(() => !IsMainEntityInUltraTimeline(), PlayerLoopTiming.Update, cancellationToken);
		}
	}

	private static bool IsMainEntityInUltraTimeline()
	{
		MonoECS instance = MonoECS.instance;
		if (instance == null)
		{
			return false;
		}
		Entity mainEntity = instance.mainEntity;
		if (!mainEntity.IsValid)
		{
			return false;
		}
		return mainEntity.GetCompEffect()?.bInUltraTimeline ?? false;
	}

	private void Refresh(ImageAssetStation station)
	{
		goldRoot?.SetActive(value: false);
		silverRoot?.SetActive(value: false);
		copperRoot?.SetActive(value: false);
		bool flag = _model.IsConcealAchievement(achievementId);
		if (!_model.TryGetContent(achievementId, out var content))
		{
			return;
		}
		int mainIdForContent = _model.GetMainIdForContent(achievementId);
		goldRoot?.SetActive(content.level == 3);
		silverRoot?.SetActive(content.level == 2);
		copperRoot?.SetActive(content.level == 1);
		line.color = (flag ? Color.white : Color.black);
		station.LoadImage(206, mainIdForContent * 10 + content.level, labelIcon);
		star.icon.gameObject.SetActive(flag);
		station.LoadImage(206, 1000 + content.level, star);
		_titleText.text = (flag ? LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, localizedId2) : LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, localizedId1));
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
		ColorUtility.TryParseHtmlString(empty, out var color);
		_titleText.color = color;
		_chievementText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, content.groupName);
		if (flag)
		{
			_chievementText.color = color;
		}
	}

	private void PlayShowAnimation()
	{
		betterAnimation?.GetSequence("Show")?.OnComplete((AnimationBuilder _) =>
		{
			Hide();
		}).Play();
	}

	public void Hide()
	{
		_cts?.Cancel();
		_cts?.Dispose();
		_cts = null;
		onClose?.Invoke();
		onClose = null;
		gameObject.SetActive(value: false);
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}
}
