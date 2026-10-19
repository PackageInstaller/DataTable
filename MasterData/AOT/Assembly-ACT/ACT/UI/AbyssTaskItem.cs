using System.Collections.Generic;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class AbyssTaskItem : CommonTaskItemBase
{
	[SerializeField]
	[Header("当前完成的关卡名字本地化")]
	private LocalizeStringEvent _curStageDes;

	[SerializeField]
	private List<GameObject> _targets;

	[SerializeField]
	private List<GameObject> _stars;

	[SerializeField]
	private List<LocalizeStringEvent> _descriptions;

	[SerializeField]
	[Header("任务未完成底图")]
	private List<GameObject> _faildBgBoards;

	[SerializeField]
	[Header("任务完成底图")]
	private List<GameObject> _successBgBoards;

	[SerializeField]
	[Header("深渊完成评级")]
	private GameObject[] _ratings;

	[SerializeField]
	[Header("深渊任务完成条目")]
	private GameObject _compelete;

	private SettlementType settlementType;

	public override void Refresh(SettlementType settlementType)
	{
		SetActive(active: true);
		this.settlementType = settlementType;
		int abyssNameLocal = CoreUtils.GetData(Model<AbyssModel>.Interface.CurAbyssStageId, RuntimeConfigs.data.abyssDatas).abyssNameLocal;
		_curStageDes.StringReference.TableEntryReference = abyssNameLocal;
		_title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, abyssNameLocal);
		int num = ((settlementType == SettlementType.Success) ? Model<AbyssModel>.Interface.GetAbyssLatestUseSeconds() : Model<AbyssModel>.Interface.GetAbyssTotalTime());
		UpdateTotalTime(num);
		_compelete.GetComponent<CanvasGroup>().alpha = 0f;
		List<int> abyssTarget = Model<AbyssModel>.Interface.AbyssTarget;
		int num2 = 0;
		for (int i = 0; i < _targets.Count; i++)
		{
			bool flag = i < abyssTarget.Count;
			_targets[i].SetActive(flag);
			_targets[i].GetComponent<CanvasGroup>().alpha = 0f;
			if (!flag)
			{
				continue;
			}
			int value = abyssTarget[i] / 60;
			int value2 = abyssTarget[i] % 60;
			_descriptions[i].StringReference.TableEntryReference = 615L;
			_descriptions[i].StringReference.GetVariable<int>("0").Value = value;
			_descriptions[i].StringReference.GetVariable<int>("1").Value = value2;
			bool flag2 = num <= abyssTarget[i];
			if (_stars != null && i < _stars.Count && _stars[i] != null)
			{
				_stars[i].SetActive((settlementType == SettlementType.Success) & flag2);
			}
			if (flag2)
			{
				num2++;
			}
			if (settlementType == SettlementType.Success)
			{
				if (_faildBgBoards != null && i < _faildBgBoards.Count && _faildBgBoards[i] != null)
				{
					_faildBgBoards[i].SetActive(!flag2);
				}
				if (_successBgBoards != null && i < _successBgBoards.Count && _successBgBoards[i] != null)
				{
					_successBgBoards[i].SetActive(flag2);
				}
			}
			if (num > abyssTarget[i])
			{
				_descriptions[i].GetComponent<TextMeshProUGUI>().color = new Color(1f, 1f, 1f, 1f);
			}
		}
		RefreshRating(settlementType, num2);
		Model<AbyssModel>.Interface.RefreshData();
	}

	private void RefreshRating(SettlementType settlementType, int completedTimeTaskCount)
	{
		for (int i = 0; i < _ratings.Length; i++)
		{
			_ratings[i]?.SetActive(value: false);
		}
		if (settlementType == SettlementType.Success)
		{
			int num = Mathf.Clamp(completedTimeTaskCount, 0, _ratings.Length - 1);
			if (num < _ratings.Length && _ratings[num] != null)
			{
				_ratings[num].SetActive(value: true);
			}
		}
	}

	public override async void PlayItemAnimation(SettlementType settlementType)
	{
		List<int> abyssTarget = Model<AbyssModel>.Interface.AbyssTarget;
		int time = ((settlementType == SettlementType.Success) ? Model<AbyssModel>.Interface.GetAbyssLatestUseSeconds() : Model<AbyssModel>.Interface.GetAbyssTotalTime());
		for (int i = 0; i < _targets.Count && i < abyssTarget.Count; i++)
		{
			_targets[i].GetComponent<CanvasGroup>().alpha = 1f;
			bool flag = time <= abyssTarget[i];
			BetterAnimation component = _targets[i].GetComponent<BetterAnimation>();
			if (!(component == null))
			{
				if ((settlementType == SettlementType.Success) & flag)
				{
					component.GetSequence("CompletedShow").Play();
				}
				else
				{
					component.GetSequence("NormalShow").Play();
				}
				await UniTask.Delay(30);
			}
		}
		_compelete.GetComponent<CanvasGroup>().alpha = 1f;
		if (settlementType == SettlementType.Success)
		{
			_compelete.GetComponent<BetterAnimation>().GetSequence("CompletedShow").Play();
		}
		else
		{
			_compelete.GetComponent<BetterAnimation>().GetSequence("NormalShow").Play();
		}
	}
}
