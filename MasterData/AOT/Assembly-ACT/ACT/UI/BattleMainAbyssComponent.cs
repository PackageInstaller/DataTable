using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Game.Data;
using ACT.Model;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class BattleMainAbyssComponent : MonoBehaviour, IBattleMainComponent
{
	[SerializeField]
	private GameObject abyssObj;

	public TextMeshProUGUI CurrentTime;

	public LocalizeStringEvent Title;

	public List<CommonSubWorldTargetItem> targetItems;

	protected const string TIME_FORMAT = "00";

	private StringBuilder _stringBuilder;

	private void ActiveTimer(bool active)
	{
		if (active)
		{
			UpdateTimer();
		}
	}

	private void UpdateTimer()
	{
		int abyssTotalTime = Model<AbyssModel>.Interface.GetAbyssTotalTime();
		int num = abyssTotalTime / 60;
		int num2 = abyssTotalTime % 60;
		_stringBuilder.Clear();
		_stringBuilder.AppendFormat("{0:d2}:{1:d2}", num, num2);
		CurrentTime.SetText(_stringBuilder);
	}

	private void UpdateTimerEvt()
	{
		UpdateTimer();
	}

	private void SetAbyssUI(AbyssData abyssData, int subStageIndex)
	{
		abyssObj.SetActive(MonoECS.instance.sceneStatus == SceneStatus.Abyss && abyssData != null && subStageIndex >= 0);
		if (abyssData == null)
		{
			return;
		}
		Title.StringReference.TableEntryReference = abyssData.abyssNameLocal;
		List<int> list = new List<int>();
		for (int i = 0; i < abyssData.abyssReward.Count; i++)
		{
			list.Add(abyssData.abyssReward[i].id);
		}
		for (int j = 0; j < targetItems.Count; j++)
		{
			if (j < list.Count)
			{
				targetItems[j].gameObject.SetActive(value: true);
				targetItems[j].UpdateState(list[j]);
			}
			else
			{
				targetItems[j].gameObject.SetActive(value: false);
			}
		}
		UpdateTimer();
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
		_stringBuilder = new StringBuilder();
		Model<AbyssModel>.Interface.ActiveTimerAction += ActiveTimer;
		Model<AbyssModel>.Interface.UpdateTimerAction += UpdateTimerEvt;
		ActiveTimer(Model<AbyssModel>.Interface.TimerUpdate);
		SetAbyssUI(Model<AbyssModel>.Interface.AbyssData, Model<AbyssModel>.Interface.CurAbyssSubStageIndex);
	}

	public void UnInitialize()
	{
		Model<AbyssModel>.Interface.ActiveTimerAction -= ActiveTimer;
		Model<AbyssModel>.Interface.UpdateTimerAction -= UpdateTimerEvt;
		_stringBuilder = null;
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
