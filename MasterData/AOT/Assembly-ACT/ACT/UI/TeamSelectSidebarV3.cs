using System;
using System.Threading;
using ACT.Battle;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TeamSelectSidebarV3 : SelectSidebarBase
{
	private TeamModel _model;

	public int curSelectTeamIndex;

	[SerializeField]
	private ActButton _closeBtn;

	[SerializeField]
	[Header("快速编队按钮")]
	private ActButton _quickFormationBtn;

	[SerializeField]
	[Header("出战按钮")]
	private ActButton _battleBtn;

	[SerializeField]
	private LocalizeStringEvent _battleBtnStringEvent;

	[SerializeField]
	[Header("确认按钮的operate组件")]
	private OperateBtnPrompt _confirmOperateBtnPrompt;

	[SerializeField]
	private ActButton _maskBtn;

	[SerializeField]
	private BetterAnimation _sidebarAnim;

	public ActButton QuickFormationBtn => _quickFormationBtn;

	public ActButton BattleBtn => _battleBtn;

	public OperateBtnPrompt ConfirmOperateBtnPrompt => _confirmOperateBtnPrompt;

	public Action OnQuickFormation { get; set; }

	public Action OnClosed { get; set; }

	public Action<int> OnTeamChanged { get; set; }

	public bool IsRaidOrBossMode { get; set; }

	public void InvokeTeamSelectBattle()
	{
		if (_battleBtn != null && _battleBtn.IsInteractable())
		{
			_battleBtn.OnClick?.Invoke();
		}
	}

	public override void Init()
	{
		if (!isHidden)
		{
			return;
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/Left_Animation");
		_model = Model<TeamModel>.Interface;
		initialComplete = false;
		switch (_model.source)
		{
		case TeamProfileSource.World:
			loopScrollRect.totalCount = _model.uiTeamProfiles.Count;
			break;
		case TeamProfileSource.Raid:
			loopScrollRect.totalCount = _model.raidTeamProfiles.Count;
			break;
		}
		curSelectTeamIndex = _model.curSelectedIndex;
		defaultSelectIndex = _model.curSelectedIndex;
		_closeBtn.SetBtnClick(UnInit);
		if (_quickFormationBtn != null)
		{
			_quickFormationBtn.SetBtnClick(() =>
			{
				OnQuickFormation?.Invoke();
			});
		}
		if (_battleBtn != null)
		{
			_battleBtn.SetBtnClick(OnConfirmBtn);
			RefreshBattleBtn();
		}
		_maskBtn.SetBtnClick(UnInit);
		maxVisibleRowNum = GetVisibleRowNum();
		ShowStart();
		_sidebarAnim.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			ShowEnd();
		}).Play();
		if (defaultSelectIndex != -1)
		{
			loopScrollRect.ScrollToCellWithinTime(defaultSelectIndex, 0f);
		}
		else
		{
			loopScrollRect.RefillCells();
		}
	}

	protected override void ShowStart()
	{
		base.ShowStart();
		MonoECS.instance.PushPauseAllInput();
	}

	protected override void ShowEnd()
	{
		base.ShowEnd();
		MonoECS.instance.PopPauseAllInput();
	}

	protected override void HideStart()
	{
		base.HideStart();
		MonoECS.instance.PushPauseAllInput();
	}

	protected override void HideEnd()
	{
		base.HideEnd();
		MonoECS.instance.PopPauseAllInput();
		OnClosed?.Invoke();
	}

	public override void UnInit()
	{
		if (isNormal)
		{
			cts?.Cancel();
			HideStart();
			initialComplete = false;
			_sidebarAnim.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				HideEnd();
			}).Play();
		}
	}

	public override async void PlayCellAnimationByRow()
	{
		try
		{
			cts = new CancellationTokenSource();
			await PlayCellAnimationByRowAsync(cts.Token).SuppressCancellationThrow();
		}
		catch (Exception)
		{
			throw;
		}
	}

	protected override async UniTask PlayCellAnimationByRowAsync(CancellationToken ct)
	{
		loopScrollRect.vertical = false;
		int count = loopScrollRect.Children.Count;
		int curVisibleRowNum = Mathf.Min(Mathf.CeilToInt(count), maxVisibleRowNum);
		for (int i = 0; i < curVisibleRowNum; i++)
		{
			BetterAnimation component = loopScrollRect.Children[i].GetComponent<BetterAnimation>();
			if (loopScrollRect.Children[i].GetComponent<TeamItemV3>().isChosen)
			{
				component?.GetSequence("SelectedShow").Play();
			}
			else
			{
				component?.GetSequence("NormalShow").Play();
			}
			if (i != curVisibleRowNum - 1)
			{
				await UniTask.Delay(TimeSpan.FromSeconds(showRowInterval), ignoreTimeScale: false, PlayerLoopTiming.Update, ct);
			}
		}
		loopScrollRect.vertical = true;
		initialComplete = true;
	}

	public void OnSelectedTeamChange(TeamItemV3 teamItem, int targetIndex)
	{
		if (curSelectTeamIndex != targetIndex)
		{
			TeamItemV3 teamItemByTeamIndex = GetTeamItemByTeamIndex(curSelectTeamIndex);
			if (teamItemByTeamIndex != null)
			{
				teamItemByTeamIndex.SetNormal();
			}
			curSelectTeamIndex = targetIndex;
			RefreshBattleBtn();
			OnTeamChanged?.Invoke(targetIndex);
		}
	}

	public TeamItemV3 GetTeamItemByTeamIndex(int teamIndex)
	{
		for (int i = 0; i < loopScrollRect.content.childCount; i++)
		{
			TeamItemV3 component = loopScrollRect.content.GetChild(i).GetComponent<TeamItemV3>();
			if (component.index == teamIndex)
			{
				return component;
			}
		}
		return null;
	}

	public void RefreshBattleBtn()
	{
		if (_battleBtn == null)
		{
			return;
		}
		RepeatedField<int> repeatedField = ((_model.source == TeamProfileSource.World) ? _model.uiTeamProfiles[curSelectTeamIndex].CharacterIds : _model.raidTeamProfiles[curSelectTeamIndex].CharacterIds);
		bool flag = false;
		for (int i = 0; i < repeatedField.Count; i++)
		{
			if (repeatedField[i] != 0)
			{
				flag = true;
				break;
			}
		}
		_battleBtn.gameObject.SetActive(flag);
		if (flag)
		{
			if (curSelectTeamIndex != _model.curBattleIndex || IsRaidOrBossMode)
			{
				_battleBtn.Interactable(active: true);
				_battleBtnStringEvent.StringReference.TableEntryReference = LocalizationCommonData.CommonString.Fight;
			}
			else
			{
				_battleBtn.Interactable(active: false);
				_battleBtnStringEvent.StringReference.TableEntryReference = LocalizationCommonData.CommonString.Fighted;
			}
		}
	}

	private void OnConfirmBtn()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Team/Play");
		int[] ids = Model<TeamModel>.Interface.DeepCopyArray(_model.CurSelectedTeamCharacters);
		if (!_model.CanBattle(ids))
		{
			GameUtility.OpenToolTip(2303);
			return;
		}
		int curBattleIndex = _model.curBattleIndex;
		TeamItemV3 teamItemByTeamIndex = GetTeamItemByTeamIndex(curBattleIndex);
		teamItemByTeamIndex.SetBattleGroup(isBattle: false);
		teamItemByTeamIndex.SetBattle(value: false);
		teamItemByTeamIndex.SetChose(value: false);
		_model.UpdateCurBattleIndex(_model.curSelectedIndex);
		TeamItemV3 teamItemByTeamIndex2 = GetTeamItemByTeamIndex(_model.curSelectedIndex);
		teamItemByTeamIndex2.SetBattleGroup(isBattle: true);
		teamItemByTeamIndex2.SetBattle(value: true);
		teamItemByTeamIndex2.SetChose(value: true);
		RefreshBattleBtn();
	}
}
