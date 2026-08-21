#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class MonsterInfoViewModel : OptionBase
{
	private DRMonsterInfo _drMonsterInfo;

	private string _monsterName;

	private string _monsterDesc;

	private string _monsterIcon = "";

	private List<KeyValuePair<PropDataBase, int>> _drops = new List<KeyValuePair<PropDataBase, int>>();

	private Vector2 _vector2;

	private bool _showOutsideMask = true;

	private InteractionRequest refreshRst = new InteractionRequest();

	public DRMonsterInfo DrMonsterInfo
	{
		get
		{
			return _drMonsterInfo;
		}
		set
		{
			_drMonsterInfo = value;
			MonsterName = value.Name;
			MonsterDesc = value.Information;
			MonsterIcon = value.MonsterIcon;
		}
	}

	public string MonsterName
	{
		get
		{
			return _monsterName;
		}
		set
		{
			Set(ref _monsterName, value, "MonsterName");
		}
	}

	public string MonsterDesc
	{
		get
		{
			return _monsterDesc;
		}
		set
		{
			Set(ref _monsterDesc, value, "MonsterDesc");
		}
	}

	public string MonsterIcon
	{
		get
		{
			return _monsterIcon;
		}
		set
		{
			Set(ref _monsterIcon, value, "MonsterIcon");
		}
	}

	public Vector2 Vector2
	{
		get
		{
			return _vector2;
		}
		set
		{
			Set(ref _vector2, value, "Vector2");
		}
	}

	public bool ShowOutsideMask
	{
		get
		{
			return _showOutsideMask;
		}
		set
		{
			Set(ref _showOutsideMask, value, "ShowOutsideMask");
		}
	}

	public List<KeyValuePair<PropDataBase, int>> Drops => _drops;

	public InteractionRequest RefreshRst => refreshRst;

	public MonsterInfoViewModel()
	{
	}

	public MonsterInfoViewModel(OptionBase parent)
	{
		base.parent = parent;
	}

	public MonsterInfoViewModel(OptionBase parent, int monsterId, bool showAllLevels = true, bool showOutsideMask = true)
	{
		base.parent = parent;
		RefreshData(monsterId, Vector2.zero, showAllLevels, showOutsideMask);
	}

	public MonsterInfoViewModel(OptionBase parent, int monsterId, Vector2 vec2, bool showAllLevels = true, bool showOutsideMask = true)
	{
		base.parent = parent;
		RefreshData(monsterId, vec2, showAllLevels, showOutsideMask);
	}

	public void RefreshData(int monsterId, bool showAllLevels = true, bool showOutsideMask = true)
	{
		RefreshData(monsterId, Vector2, showAllLevels, showOutsideMask);
	}

	public void RefreshData(int monsterId, Vector2 showPos, bool showAllLevels = true, bool showOutsideMask = true)
	{
		Vector2 = showPos;
		ShowOutsideMask = showOutsideMask;
		GetMonsterInfo(monsterId, showAllLevels);
		refreshRst.Raise();
	}

	private void GetMonsterInfo(int monsterId, bool showAllLevels)
	{
		_drops.Clear();
		try
		{
			DrMonsterInfo = GameEntry.DataTable.GetDataRow<DRMonsterInfo>(monsterId);
			if (DrMonsterInfo == null)
			{
				return;
			}
			Dictionary<int, int> dictionary = new Dictionary<int, int>();
			if (!showAllLevels)
			{
				int rank = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Rank;
				GameEntry.DataTable.GetDataRow((DRMonsterDrops p) => p.MonsterId.Equals(monsterId) && p.Rank.Equals(rank));
			}
			foreach (KeyValuePair<int, int> levelGroup in dictionary)
			{
				DRDropGroups dataRow = GameEntry.DataTable.GetDataRow((DRDropGroups p) => p.GroupId.Equals(levelGroup.Value));
				if (dataRow.ChildrenSetId == null)
				{
					continue;
				}
				foreach (int goodsGroupId in dataRow.ChildrenSetId)
				{
					DRGoodsGroup[] dataRows = GameEntry.DataTable.GetDataRows((DRGoodsGroup p) => p.ChildSetId.Equals(goodsGroupId));
					if (dataRows == null)
					{
						continue;
					}
					DRGoodsGroup[] array = dataRows;
					foreach (DRGoodsGroup dRGoodsGroup in array)
					{
						int type = dRGoodsGroup.Type;
						if (type == 1 || type == 2 || type == 5)
						{
							_drops.Add(new KeyValuePair<PropDataBase, int>(PropDataBase.CreateByType(type, dRGoodsGroup.GoodsId), levelGroup.Key));
						}
					}
				}
			}
		}
		catch (Exception message)
		{
			Log.Error(message);
		}
	}

	public override void Close()
	{
		parent?.ItemOnClick(this);
		base.Close();
	}
}
