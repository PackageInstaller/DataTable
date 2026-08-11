using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Ase;

public class TowerRandomBuffViewModel : OptionBase
{
	private int refreshCount;

	private int selectCount;

	private int randomBuffCount;

	private string selectCountText;

	private int randomPoolId;

	private int canSelectCount;

	private int copyId;

	private List<RandomBuffItemViewModel> randomBuffVM;

	private List<RandomBuffItemViewModel> selectBuffVM;

	private HashSet<int> refreshBuffs = new HashSet<int>(10);

	private List<int> weightGroup;

	private List<int> randomIndexs;

	private List<int> randomBuffGroupWeight;

	private List<int> holdBuffs;

	private bool canConfirm;

	private bool canRefresh;

	public int RandomBuffCount => randomBuffCount;

	public List<RandomBuffItemViewModel> RandomBuffVM => randomBuffVM;

	public int RefreshCount
	{
		get
		{
			return refreshCount;
		}
		set
		{
			Set(ref refreshCount, value, "RefreshCount");
		}
	}

	public string SelectCountText
	{
		get
		{
			return selectCountText;
		}
		set
		{
			Set(ref selectCountText, value, "SelectCountText");
		}
	}

	public bool CanConfirm
	{
		get
		{
			return canConfirm;
		}
		set
		{
			Set(ref canConfirm, value, "CanConfirm");
		}
	}

	public bool CanRefresh
	{
		get
		{
			return canRefresh;
		}
		set
		{
			Set(ref canRefresh, value, "CanRefresh");
		}
	}

	public bool SelectFinish { get; set; }

	public TowerRandomBuffViewModel(int refreshCount, int randomPoolId, int randomBuffCount, int canSelectCount, int copyId, List<int> holdBuffs)
	{
		if (canSelectCount <= randomBuffCount)
		{
			RefreshCount = refreshCount;
			this.randomBuffCount = randomBuffCount;
			this.randomPoolId = randomPoolId;
			CanRefresh = RefreshCount > 0;
			CanConfirm = selectCount >= canSelectCount;
			this.canSelectCount = canSelectCount;
			SelectCountText = $"{selectCount}/{canSelectCount}";
			randomBuffVM = new List<RandomBuffItemViewModel>(randomBuffCount);
			randomBuffGroupWeight = new List<int>(randomBuffCount);
			randomIndexs = new List<int>(randomBuffCount);
			selectBuffVM = new List<RandomBuffItemViewModel>(canSelectCount);
			this.copyId = copyId;
			this.holdBuffs = new List<int>(holdBuffs.Count);
			this.holdBuffs.AddRange(holdBuffs);
			RandomBuff();
		}
	}

	private void RandomBuff()
	{
		DRRandomBuff dataRow = GameEntry.DataTable.GetDataRow<DRRandomBuff>(randomPoolId);
		if (dataRow != null && dataRow.WeightGroup.Count >= randomBuffCount)
		{
			GetToatlWeightGroup(dataRow);
			GetRandomBuffIndex();
			GetRandomBuff(dataRow);
		}
	}

	private void RandomBuffClear()
	{
		randomIndexs.Clear();
		randomBuffGroupWeight.Clear();
		randomBuffVM.Clear();
		selectBuffVM.Clear();
	}

	private void GetToatlWeightGroup(DRRandomBuff drRandomBuff)
	{
		if (weightGroup != null)
		{
			return;
		}
		weightGroup = new List<int>(drRandomBuff.WeightGroup.Count);
		for (int i = 0; i < drRandomBuff.WeightGroup.Count; i++)
		{
			int num = 0;
			for (int j = 0; j < drRandomBuff.WeightGroup[i].Count; j++)
			{
				num += drRandomBuff.WeightGroup[i][j];
			}
			weightGroup.Add(num);
		}
	}

	private void GetRandomBuffIndex()
	{
		for (int i = 0; i < randomBuffCount; i++)
		{
			int totalRandomWeight = GetTotalRandomWeight();
			if (totalRandomWeight <= 0)
			{
				break;
			}
			int num = Random.Range(0, totalRandomWeight);
			int num2 = 0;
			for (int j = 0; j < weightGroup.Count; j++)
			{
				if (!randomIndexs.Contains(j))
				{
					num2 += weightGroup[j];
					if (num < num2)
					{
						randomIndexs.Add(j);
						randomBuffGroupWeight.Add(weightGroup[j]);
						break;
					}
				}
			}
		}
	}

	private void GetRandomBuff(DRRandomBuff drRandomBuff)
	{
		for (int i = 0; i < randomIndexs.Count; i++)
		{
			int index = randomIndexs[i];
			List<int> list = drRandomBuff.BuffGroup[index];
			List<int> list2 = drRandomBuff.WeightGroup[index];
			int num = Random.Range(0, randomBuffGroupWeight[i]);
			int num2 = 0;
			for (int j = 0; j < list2.Count; j++)
			{
				num2 += list2[j];
				if (num < num2)
				{
					int num3 = list[j];
					bool recommend = RecommendBuff(num3);
					randomBuffVM.Add(new RandomBuffItemViewModel(this, num3, copyId, recommend));
					if (!refreshBuffs.Contains(num3))
					{
						refreshBuffs.Add(num3);
					}
					break;
				}
			}
		}
	}

	private bool RecommendBuff(int buffId)
	{
		bool flag = false;
		if (holdBuffs.Contains(buffId))
		{
			flag = true;
		}
		DRTowerBuffUp dataRow = GameEntry.DataTable.GetDataRow<DRTowerBuffUp>(buffId);
		if (!flag)
		{
			DRTowerBuffUp minLvBuffConfig = dataRow;
			while (minLvBuffConfig != null && !flag && minLvBuffConfig.Bufflv > 1)
			{
				minLvBuffConfig = GameEntry.DataTable.GetDataRow((DRTowerBuffUp config) => config.UpBuff == minLvBuffConfig.Id);
				if (minLvBuffConfig != null && holdBuffs.Contains(minLvBuffConfig.Id))
				{
					flag = true;
				}
			}
		}
		DRTowerBuffUp dRTowerBuffUp = dataRow;
		while (dRTowerBuffUp != null && dRTowerBuffUp.UpBuff != 0)
		{
			dRTowerBuffUp = GameEntry.DataTable.GetDataRow<DRTowerBuffUp>(dRTowerBuffUp.UpBuff);
			if (!flag && dRTowerBuffUp != null && holdBuffs.Contains(dRTowerBuffUp.Id))
			{
				flag = true;
			}
		}
		if (flag && dRTowerBuffUp != null && !holdBuffs.Contains(dRTowerBuffUp.Id))
		{
			return true;
		}
		return false;
	}

	private int GetTotalRandomWeight()
	{
		int num = 0;
		for (int i = 0; i < weightGroup.Count; i++)
		{
			if (!randomIndexs.Contains(i))
			{
				num += weightGroup[i];
			}
		}
		return num;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (!(obj is RandomBuffItemViewModel randomBuffItemViewModel))
		{
			return;
		}
		if (randomBuffItemViewModel.SelectItem)
		{
			if (selectBuffVM.Count >= canSelectCount)
			{
				selectBuffVM[0].SelectItem = false;
				selectBuffVM.RemoveAt(0);
				SelectBuff(isSelect: false);
			}
			selectBuffVM.Add(randomBuffItemViewModel);
			SelectBuff(isSelect: true);
		}
		else if (selectBuffVM.Contains(randomBuffItemViewModel))
		{
			selectBuffVM.Remove(randomBuffItemViewModel);
			SelectBuff(isSelect: false);
		}
	}

	private void SelectBuff(bool isSelect)
	{
		if (!isSelect)
		{
			selectCount--;
		}
		else
		{
			selectCount++;
		}
		CanConfirm = selectCount >= canSelectCount;
		SelectCountText = $"{selectCount}/{canSelectCount}";
	}

	public void ClickRefresh()
	{
		if (RefreshCount > 0)
		{
			RandomBuffClear();
			RandomBuff();
			RefreshCount--;
			CanRefresh = RefreshCount > 0;
			selectCount = 0;
			CanConfirm = selectCount >= canSelectCount;
			SelectCountText = $"{selectCount}/{canSelectCount}";
		}
	}

	public void ClickConfirm()
	{
		if (CanConfirm)
		{
			SelectFinish = true;
			Close();
			weightGroup = null;
			randomIndexs = null;
			randomBuffGroupWeight = null;
		}
	}

	public void AchievementBuffSend(List<int> selectBuffs, List<int> seeBuffs)
	{
		for (int i = 0; i < selectBuffVM.Count; i++)
		{
			selectBuffs.Add(selectBuffVM[i].BuffId);
		}
		seeBuffs.AddRange(refreshBuffs);
	}

	public void AddSelectBuff(List<int> selectBuff)
	{
		for (int i = 0; i < selectBuffVM.Count; i++)
		{
			selectBuff.Add(selectBuffVM[i].BuffId);
		}
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		foreach (int item in selectBuff)
		{
			if (dictionary.ContainsKey(item))
			{
				dictionary[item]++;
			}
			else
			{
				dictionary[item] = 1;
			}
		}
		selectBuff.Clear();
		bool flag;
		do
		{
			flag = false;
			foreach (int item2 in dictionary.Keys.OrderBy((int x) => x).ToList())
			{
				if (!dictionary.ContainsKey(item2))
				{
					continue;
				}
				int num = dictionary[item2];
				if (num < 2)
				{
					continue;
				}
				DRTowerBuffUp dataRow = GameEntry.DataTable.GetDataRow<DRTowerBuffUp>(item2);
				if (dataRow != null && dataRow.UpBuff != 0)
				{
					int num2 = num / 2;
					int num3 = num % 2;
					if (num3 > 0)
					{
						dictionary[item2] = num3;
					}
					else
					{
						dictionary.Remove(item2);
					}
					int upBuff = dataRow.UpBuff;
					if (dictionary.ContainsKey(upBuff))
					{
						dictionary[upBuff] += num2;
					}
					else
					{
						dictionary[upBuff] = num2;
					}
					flag = true;
					break;
				}
			}
		}
		while (flag);
		foreach (KeyValuePair<int, int> item3 in dictionary)
		{
			for (int num4 = 0; num4 < item3.Value; num4++)
			{
				selectBuff.Add(item3.Key);
			}
		}
	}
}
