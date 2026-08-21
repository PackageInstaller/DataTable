#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Cysharp.Text;
using GameFramework;
using GameFramework.Runtime;
using Unity.Mathematics;

namespace Ase;

public class CopyItemDetail1ViewModel : OptionBase
{
	private CopyData data;

	private List<int> adItemList;

	private string desc;

	private List<ReceiveItemViewModel> dropProps;

	private InteractionRequest<string> optRequest;

	private SimpleCommand<string> optCommand;

	private Dictionary<int, List<MonsterInfoData>> monsterInfoDatas;

	private int maxCol;

	public IInteractionRequest OptRequest => optRequest;

	public ICommand OptCommand => optCommand;

	public CopyData Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
		}
	}

	public string Desc
	{
		get
		{
			return desc;
		}
		private set
		{
			Set(ref desc, value, "Desc");
		}
	}

	public int MaxCol => maxCol;

	public Dictionary<int, List<MonsterInfoData>> MonsterInfoDatas => monsterInfoDatas;

	public List<ReceiveItemViewModel> DropProps => dropProps;

	public List<int> AdItemList => adItemList;

	public CopyItemDetail1ViewModel()
	{
	}

	public CopyItemDetail1ViewModel(OptionBase parent)
	{
		base.parent = parent;
		optRequest = new InteractionRequest<string>();
		optCommand = new SimpleCommand<string>(OnOpt);
		dropProps = new List<ReceiveItemViewModel>();
	}

	public void RefreshData(CopyData data, int dropType)
	{
		Data = data;
		Desc = ReplaceDesc(this.data.Desc);
		adItemList = data.Buffs;
		if (adItemList == null)
		{
			adItemList = new List<int>();
		}
		GetCopyDrops(dropType);
	}

	private string ReplaceDesc(string desc)
	{
		if (!string.IsNullOrEmpty(desc) && desc.Contains("\\n"))
		{
			using (Utf16ValueStringBuilder utf16ValueStringBuilder = ZString.CreateStringBuilder())
			{
				utf16ValueStringBuilder.Append(desc);
				utf16ValueStringBuilder.Replace("\\n", "\n");
				return utf16ValueStringBuilder.ToString();
			}
		}
		return desc;
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is ReceiveItemViewModel)
		{
			parent.ItemOnClick(obj);
		}
	}

	public void GetCopyDrops(int dropType)
	{
		dropProps.Clear();
		DRCopyDrop dataRow = GameEntry.DataTable.GetDataRow((DRCopyDrop p) => p.RewardGroupId == data.Drops && p.DropeType == dropType);
		if (dataRow != null)
		{
			if (dataRow.PropTypeShow.Count != dataRow.PropIDShow.Count)
			{
				return;
			}
			for (int num = 0; num < dataRow.PropTypeShow.Count; num++)
			{
				PropDataBase propDataBase = PropDataBase.CreateByType(dataRow.PropTypeShow[num], dataRow.PropIDShow[num]);
				if (propDataBase == null)
				{
					Log.Error($"CopyDrop2 配置表，Id【{dataRow.Id}】CopyDrop.PropTypeShow {dataRow.PropTypeShow[num]}，CopyDrop.PropIDShow {dataRow.PropIDShow[num]}配置有误！");
					continue;
				}
				ReceiveItemViewModel receiveItemViewModel = new ReceiveItemViewModel(propDataBase, this);
				dropProps.Add(receiveItemViewModel);
				if (dataRow.IsShowNum.Count > num && dataRow.IsShowNum[num] == 1 && dataRow.PropNumShow.Count > num)
				{
					receiveItemViewModel.SetCountRange(dataRow.PropNumShow[num]);
				}
				else
				{
					receiveItemViewModel.SetCountRange("");
				}
			}
			if (data.IsNeedFirst)
			{
				if (dataRow.FirstDropShow.Count != dataRow.FirstDropType.Count || dataRow.FirstDropShow.Count != dataRow.FirstDropNum.Count)
				{
					return;
				}
				for (int num2 = 0; num2 < dataRow.FirstDropShow.Count; num2++)
				{
					PropDataBase propDataBase2 = PropDataBase.CreateByType(dataRow.FirstDropType[num2], dataRow.FirstDropShow[num2], dataRow.FirstDropNum[num2]);
					if (propDataBase2 != null)
					{
						ReceiveItemViewModel receiveItemViewModel2 = new ReceiveItemViewModel(propDataBase2, this);
						receiveItemViewModel2.SetLock(isLock: true);
						if (data.IsAccessed)
						{
							dropProps.Add(receiveItemViewModel2);
							receiveItemViewModel2.SetGot(isGot: true);
						}
						else
						{
							dropProps.Insert(num2, receiveItemViewModel2);
							receiveItemViewModel2.SetGot(isGot: false);
						}
					}
				}
			}
		}
		optRequest.Raise("RefreshDrops");
	}

	public void SetDropEquipCopy(DRCopyKit copyKit)
	{
		if (dropProps == null || dropProps.Count <= 0 || copyKit.DropUp == null || copyKit.DropUp.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < dropProps.Count; i++)
		{
			dropProps[i].SetUp(isUp: false);
			dropProps[i].SetTeam(isTeam: false);
		}
		for (int j = 0; j < copyKit.DropUp.Count; j++)
		{
			int num = copyKit.DropUp[j];
			if (dropProps.Count > num && !dropProps[num].IsGot)
			{
				dropProps[num].SetUp(isUp: true);
			}
		}
		for (int k = 0; k < copyKit.TeamUp.Count; k++)
		{
			int num2 = copyKit.TeamUp[k];
			if (dropProps.Count > num2 && !dropProps[num2].IsGot)
			{
				dropProps[num2].SetTeam(isTeam: true);
			}
		}
	}

	public async void OnOpt(string optName)
	{
		optCommand.Enabled = false;
		if ("OpenMonsterInfo".Equals(optName))
		{
			if (data.IsBoss)
			{
				optCommand.Enabled = true;
				return;
			}
			GetMonsterInfos();
			optRequest.Raise(optName);
		}
		else if ("OpenSingle".Equals(optName))
		{
			parent.ItemOnClick(optName);
		}
		optCommand.Enabled = true;
	}

	public void RefreshDropRank()
	{
		if (!data.IsNeedFirst || !data.IsAccessed)
		{
			return;
		}
		int num = 0;
		int count = dropProps.Count;
		for (int i = 0; i < count; i++)
		{
			if (dropProps[i].IsLock)
			{
				num = i;
				dropProps[i].SetGot(isGot: true);
				dropProps.Add(dropProps[i]);
			}
		}
		for (int num2 = num; num2 >= 0; num2--)
		{
			dropProps.RemoveAt(num2);
		}
	}

	private void GetMonsterInfos()
	{
		if (monsterInfoDatas == null)
		{
			monsterInfoDatas = new Dictionary<int, List<MonsterInfoData>>();
		}
		else
		{
			monsterInfoDatas.Clear();
		}
		if (data.BossTypes.Count != data.Waves.Count)
		{
			return;
		}
		int num = 0;
		int num2 = 0;
		maxCol = 0;
		int i;
		for (i = 0; i < data.Waves.Count; i++)
		{
			if (data.Waves[i] != num)
			{
				num = data.Waves[i];
				monsterInfoDatas.Add(num, new List<MonsterInfoData>());
				num2 = 0;
			}
			DRMonsterInfo dataRow = GameEntry.DataTable.GetDataRow((DRMonsterInfo p) => p.Id == data.BossTypes[i]);
			if (dataRow != null)
			{
				monsterInfoDatas[num].Add(new MonsterInfoData(data.BossTypes[i], dataRow.MonsterIcon));
			}
			num2++;
			maxCol = math.max(num2, maxCol);
		}
		maxCol++;
	}

	public int GetIndex(int index)
	{
		if (index % maxCol == 0)
		{
			return index / maxCol + 1;
		}
		return 0;
	}

	public int GetMonsterCount()
	{
		return maxCol * monsterInfoDatas.Count;
	}

	public MonsterInfoData GetMonster(int index)
	{
		if (monsterInfoDatas == null)
		{
			return null;
		}
		if (index % maxCol == 0)
		{
			return null;
		}
		if (monsterInfoDatas.ContainsKey(index / maxCol + 1))
		{
			int num = index - index / maxCol * maxCol;
			if (monsterInfoDatas[index / maxCol + 1].Count >= num)
			{
				return monsterInfoDatas[index / maxCol + 1][num - 1];
			}
			return null;
		}
		return null;
	}

	public void EnableOpt()
	{
		optCommand.Enabled = true;
	}
}
