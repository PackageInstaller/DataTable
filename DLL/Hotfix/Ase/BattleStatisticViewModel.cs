using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BattleStatisticViewModel : OptionBase
{
	private InteractionRequest<string> optRequest = new InteractionRequest<string>();

	private BattleStatDetailViewModel detailViewModel;

	private bool isOpenDetail;

	private List<BSHeroItemViewModel> bsHeroItemVMs = new List<BSHeroItemViewModel>();

	public List<BSHeroItemViewModel> BSHeroItemVMs => bsHeroItemVMs;

	public IInteractionRequest OptRequest => optRequest;

	public BattleStatDetailViewModel DetailViewModel => detailViewModel;

	public BattleStatisticViewModel()
	{
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is BSHeroItemViewModel bSHeroItemViewModel && detailViewModel != null)
		{
			detailViewModel.SelectHero(bSHeroItemViewModel.MemberId);
			isOpenDetail = true;
			optRequest.Raise("OpenDetail");
		}
	}

	public BattleStatisticViewModel(OptionBase parent, List<TeamMember> teamMembers, Dictionary<int, Dictionary<int, BSData>> accounts, BattleWorldMode battleMode)
	{
		base.parent = parent;
		float num = 0f;
		float num2 = 0f;
		float num3 = 0f;
		float num4 = 0f;
		foreach (Dictionary<int, BSData> value in accounts.Values)
		{
			if (value.ContainsKey(-1))
			{
				num2 += (float)value[-1].Damage;
				num += (float)value[-1].Cure;
				num3 += (float)value[-1].Tenacity;
				num4 += (float)value[-1].InjureValue;
			}
		}
		for (int i = 0; i < teamMembers.Count; i++)
		{
			if (!accounts.ContainsKey(teamMembers[i].MemberId))
			{
				continue;
			}
			List<BSItemViewModel> list = new List<BSItemViewModel>();
			if (accounts[teamMembers[i].MemberId].ContainsKey(-1))
			{
				BSData bSData = accounts[teamMembers[i].MemberId][-1];
				BSItemViewModel item = GetItem(1, bSData.Damage, num2);
				if (item != null)
				{
					list.Add(item);
				}
				BSItemViewModel item2 = GetItem(2, bSData.Tenacity, num3);
				if (item2 != null)
				{
					list.Add(item2);
				}
				BSItemViewModel item3 = GetItem(3, bSData.InjureValue, num4);
				if (item3 != null)
				{
					list.Add(item3);
				}
				BSItemViewModel item4 = GetItem(4, bSData.Cure, num);
				if (item4 != null)
				{
					list.Add(item4);
				}
			}
			bsHeroItemVMs.Add(new BSHeroItemViewModel(this, teamMembers[i].MemberId, teamMembers[i].HeroModel, teamMembers[i].Name, i != teamMembers.Count - 1, teamMembers[i].IsSelf, list));
		}
		detailViewModel = new BattleStatDetailViewModel(this, teamMembers, accounts, battleMode == BattleWorldMode.SyncBattle || battleMode == BattleWorldMode.GameBack);
	}

	private BSItemViewModel GetItem(int index, float val, float totalVal)
	{
		DRDamageStatistic dataRow = GameEntry.DataTable.GetDataRow<DRDamageStatistic>(index);
		Color color;
		if (dataRow != null)
		{
			ColorUtility.TryParseHtmlString(dataRow.Color, out color);
			return new BSItemViewModel(color, dataRow.Name1, (int)val, (totalVal == 0f) ? 0f : (val / totalVal));
		}
		color = Color.black;
		return new BSItemViewModel(color, "", (int)val, (totalVal == 0f) ? 0f : (val / totalVal));
	}

	public override void Close()
	{
		if (!isOpenDetail)
		{
			base.Close();
			return;
		}
		isOpenDetail = false;
		optRequest.Raise("CloseDetail");
	}
}
