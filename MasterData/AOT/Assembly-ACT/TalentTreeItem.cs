using System.Collections.Generic;
using ACT.Config;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using Runtime.Model;
using TMPro;
using UnityEngine;

public class TalentTreeItem : MonoBehaviour
{
	public TextMeshProUGUI TextAllConsumptionNum;

	public List<TalentTreeGroup> TalentTreeGroupList;

	private void Start()
	{
	}

	public void Init(Dictionary<int, List<TalentNode>> _talentDic, ImageAssetStation station)
	{
		for (int i = 0; i < TalentTreeGroupList.Count; i++)
		{
			if (_talentDic.TryGetValue((int)TalentTreeGroupList[i].type, out var value))
			{
				for (int j = 0; j < value.Count; j++)
				{
					if (j == value[j].nodeIdx)
					{
						TalentTreeGroupList[i].TalentOneGroupList[j].Init(value[j], station);
						if (TalentTreeGroupList[i].type == TalentType.one)
						{
							TalentTreeGroupList[i].TextGroupNum.StringReference.TableEntryReference = 2536L;
						}
						else if (TalentTreeGroupList[i].type == TalentType.two)
						{
							TalentTreeGroupList[i].TextGroupNum.StringReference.TableEntryReference = 2537L;
						}
						else
						{
							TalentTreeGroupList[i].TextGroupNum.StringReference.TableEntryReference = 2538L;
						}
						TalentTreeGroupList[i].TextGroupNum.StringReference.GetVariable<string>("0").Value = Model<RogueNewModel>.Interface.GetTalentNodeCostByType((int)TalentTreeGroupList[i].type).ToString();
					}
				}
			}
			TextAllConsumptionNum.SetText("{0:0}", Model<RogueNewModel>.Interface.GetAllTalentNodeCost());
		}
	}

	private void Update()
	{
	}
}
