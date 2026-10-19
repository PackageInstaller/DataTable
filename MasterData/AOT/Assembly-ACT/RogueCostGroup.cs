using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using Fundamental;
using TMPro;
using UnityEngine;

public class RogueCostGroup : MonoBehaviour
{
	public TextMeshProUGUI TextTicketNum;

	public TextMeshProUGUI TextOptionalNum;

	public TextMeshProUGUI TextSceneNum;

	public TextMeshProUGUI TextAllNum;

	private int Ticket;

	private int OptionalNum;

	private int SceneNum;

	private void Start()
	{
		RogueStage data = CoreUtils.GetData(101, RuntimeConfigs.data.rogueStages);
		Ticket = data.stageTicket;
		TextTicketNum.SetText("{0:0}", Ticket);
	}

	private void OnEnable()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Rogue_Table_CostGroup_Effect, OnTableFreshSceneNum);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Rogue_Table_CostGroup_OptionCard, OnTableFreshOptionCardNum);
	}

	public void Init()
	{
		SetNum();
	}

	private void SetNum()
	{
		ReFreshOptionalNum();
		ReFreshTextSceneNum();
		RefreshAllNum();
	}

	private void OnTableFreshSceneNum(BaseEventContent obj)
	{
		ReFreshTextSceneNum();
		RefreshAllNum();
	}

	private void OnTableFreshOptionCardNum(BaseEventContent obj)
	{
		ReFreshOptionalNum();
		RefreshAllNum();
	}

	private void ReFreshOptionalNum()
	{
		List<int> rogueTableBuff = Model<RoGueModel>.Interface._RogueTableBuff;
		int num = 0;
		if (rogueTableBuff.Count > 0)
		{
			for (int i = 0; i < rogueTableBuff.Count; i++)
			{
				RogueTableBuffCard data = CoreUtils.GetData(rogueTableBuff[i], RuntimeConfigs.data.rogueTableBuffCards);
				if (data != null)
				{
					num += data.cardCost;
				}
			}
		}
		OptionalNum = num;
		TextOptionalNum.SetText("{0:0}", num);
	}

	private void ReFreshTextSceneNum()
	{
		int num = 0;
		if (Model<RoGueModel>.Interface.CurrentRogueStage.tableStageEffect != Model<RoGueModel>.Interface._RogueTableStageEffectId)
		{
			num = RuntimeConfigs.data.game.rogueTableStageCost;
		}
		SceneNum = num;
		TextSceneNum.SetText("{0:0}", num);
	}

	private void RefreshAllNum()
	{
		int num = Ticket + OptionalNum + SceneNum;
		if (Model<RoGueModel>.Interface._RogueTableAllCost != num)
		{
			Model<RoGueModel>.Interface._RogueTableAllCost = num;
		}
		TextAllNum.SetText("{0:0}", num);
	}

	private void OnDisable()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Rogue_Table_CostGroup_Effect, OnTableFreshSceneNum);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Rogue_Table_CostGroup_OptionCard, OnTableFreshOptionCardNum);
	}

	private void Update()
	{
	}
}
