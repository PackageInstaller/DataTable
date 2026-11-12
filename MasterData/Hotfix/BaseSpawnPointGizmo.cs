using System;
using System.Collections.Generic;
using UnityEngine;

public abstract class BaseSpawnPointGizmo : LogicEntity, IComparable
{
	[ReadOnly]
	public int x = -1;

	[ReadOnly]
	public int y = -1;

	public virtual string id => $"({x},{y})_{transform.GetHierarchyPath()}";

	public BaseSpawnPointGizmo parentGizmo
	{
		get
		{
			Transform parent = transform.parent;
			if (!(null == parent))
			{
				return parent.GetComponent<BaseSpawnPointGizmo>();
			}
			return null;
		}
	}

	public List<BaseSpawnPointGizmo> childrenGizmos { get; protected set; }

	public bool isSpawnActived { get; set; }

	public bool isSpawnEnabled { get; set; }

	public bool hasSendClearedEventNoSummons { get; set; }

	public bool hasSendClearedEvent { get; set; }

	public bool hasSendActivedEvent { get; set; }

	public bool jumpOverBornPerformance { get; protected set; }

	public virtual void Initialize(int x1, int y1)
	{
		x = x1;
		y = y1;
		if (childrenGizmos == null)
		{
			InitChilds();
		}
		if (childrenGizmos != null)
		{
			for (int i = 0; i < childrenGizmos.Count; i++)
			{
				childrenGizmos.get_Item(i).Initialize(x, y);
			}
		}
	}

	public virtual void InitChilds()
	{
		childrenGizmos = new List<BaseSpawnPointGizmo>();
		int childCount = transform.childCount;
		for (int i = 0; i < childCount; i++)
		{
			Transform child = transform.GetChild(i);
			if (child.gameObject.activeSelf)
			{
				BaseSpawnPointGizmo component = child.GetComponent<BaseSpawnPointGizmo>();
				if (!(null == component))
				{
					component.InitChilds();
					childrenGizmos.Add(component);
				}
			}
		}
		childrenGizmos.Sort();
	}

	public virtual void EnableSpawnLogic()
	{
		if (!ActiveSelf || !gameObject.activeSelf)
		{
			return;
		}
		isSpawnEnabled = true;
		if (childrenGizmos != null)
		{
			for (int i = 0; i < childrenGizmos.Count; i++)
			{
				childrenGizmos.get_Item(i).EnableSpawnLogic();
			}
		}
	}

	public virtual void ReEnableSpawnLogic()
	{
		ResetSpawnState();
		EnableSpawnLogic();
	}

	public virtual void ResetSpawnState()
	{
		isSpawnEnabled = false;
		hasSendClearedEventNoSummons = false;
		hasSendClearedEvent = false;
		hasSendActivedEvent = false;
		if (childrenGizmos != null)
		{
			for (int i = 0; i < childrenGizmos.Count; i++)
			{
				childrenGizmos.get_Item(i).ResetSpawnState();
			}
		}
	}

	public virtual void MarkQuitSettlementMonster(bool mark)
	{
		if (childrenGizmos != null)
		{
			for (int i = 0; i < childrenGizmos.Count; i++)
			{
				childrenGizmos.get_Item(i).MarkQuitSettlementMonster(mark);
			}
		}
	}

	public virtual void DisableSpawnLogic()
	{
		if (!ActiveSelf || !gameObject.activeSelf)
		{
			return;
		}
		isSpawnEnabled = false;
		if (childrenGizmos != null)
		{
			for (int i = 0; i < childrenGizmos.Count; i++)
			{
				childrenGizmos.get_Item(i).isSpawnEnabled = false;
			}
		}
	}

	public virtual bool CheckActiveConditions()
	{
		return false;
	}

	public virtual void UpdateSpawnLogic()
	{
		if (isSpawnEnabled && childrenGizmos != null)
		{
			for (int i = 0; i < childrenGizmos.Count; i++)
			{
				childrenGizmos.get_Item(i).UpdateSpawnLogic();
			}
		}
	}

	public virtual void ExecuteSpawnLogic(AdventureActor summoner = null)
	{
		if (isSpawnEnabled && childrenGizmos != null)
		{
			for (int i = 0; i < childrenGizmos.Count; i++)
			{
				childrenGizmos.get_Item(i).ExecuteSpawnLogic(summoner);
			}
		}
	}

	public virtual void SpawnMonsterEnterAction()
	{
		if (isSpawnEnabled && childrenGizmos != null)
		{
			for (int i = 0; i < childrenGizmos.Count; i++)
			{
				childrenGizmos.get_Item(i).SpawnMonsterEnterAction();
			}
		}
	}

	public int CompareTo(object obj)
	{
		BaseSpawnPointGizmo baseSpawnPointGizmo = (BaseSpawnPointGizmo)obj;
		if (transform.GetSiblingIndex() < baseSpawnPointGizmo.transform.GetSiblingIndex())
		{
			return -1;
		}
		return 1;
	}

	public virtual bool IsAllActived()
	{
		if (!isSpawnEnabled)
		{
			return false;
		}
		if (childrenGizmos == null || childrenGizmos.Count == 0)
		{
			return true;
		}
		for (int i = 0; i < childrenGizmos.Count; i++)
		{
			if (!childrenGizmos.get_Item(i).IsAllActived())
			{
				return false;
			}
		}
		return true;
	}

	public virtual bool IsAllActivedAndDied()
	{
		if (!isSpawnEnabled)
		{
			return false;
		}
		if (childrenGizmos == null || childrenGizmos.Count == 0)
		{
			return true;
		}
		for (int i = 0; i < childrenGizmos.Count; i++)
		{
			if (!childrenGizmos.get_Item(i).IsAllActivedAndDied())
			{
				return false;
			}
		}
		return true;
	}

	public virtual bool IsAllActivedAndDied_NoSummons()
	{
		if (!isSpawnEnabled)
		{
			return false;
		}
		if (childrenGizmos == null || childrenGizmos.Count == 0)
		{
			return true;
		}
		for (int i = 0; i < childrenGizmos.Count; i++)
		{
			if (!childrenGizmos.get_Item(i).IsAllActivedAndDied_NoSummons())
			{
				return false;
			}
		}
		return true;
	}

	public virtual void SetAllActiveAndDied()
	{
		isSpawnEnabled = true;
		isSpawnActived = true;
		if (childrenGizmos == null || childrenGizmos.Count == 0)
		{
			return;
		}
		for (int i = 0; i < childrenGizmos.Count; i++)
		{
			BaseSpawnPointGizmo baseSpawnPointGizmo = childrenGizmos.get_Item(i);
			if (baseSpawnPointGizmo.IsAllActivedAndDied())
			{
				baseSpawnPointGizmo.SetAllActiveAndDied();
			}
		}
	}

	public virtual List<long> GetSpawnedEntities()
	{
		return null;
	}

	public virtual void JumpOverBornPerformance(bool jumpOver = false)
	{
		jumpOverBornPerformance = jumpOver;
		if (childrenGizmos != null)
		{
			for (int i = 0; i < childrenGizmos.Count; i++)
			{
				childrenGizmos.get_Item(i).JumpOverBornPerformance(jumpOver);
			}
		}
	}

	protected override void OnInit()
	{
		_logger = Singleton<LogManager>.Instance.get_Item("Adventure_Gizmo");
	}

	public virtual void KillAllSummoners()
	{
		if (childrenGizmos != null)
		{
			for (int i = 0; i < childrenGizmos.Count; i++)
			{
				childrenGizmos.get_Item(i).KillAllSummoners();
			}
		}
	}

	public virtual bool IsSpwanState()
	{
		if (childrenGizmos == null)
		{
			return false;
		}
		for (int i = 0; i < childrenGizmos.Count; i++)
		{
			if (childrenGizmos.get_Item(i).IsSpwanState())
			{
				return true;
			}
		}
		return false;
	}

	public virtual int DiedMonsterCount()
	{
		if (!isSpawnEnabled)
		{
			return 0;
		}
		if (childrenGizmos == null || childrenGizmos.Count == 0)
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < childrenGizmos.Count; i++)
		{
			BaseSpawnPointGizmo baseSpawnPointGizmo = childrenGizmos.get_Item(i);
			if (!(null == baseSpawnPointGizmo))
			{
				num += baseSpawnPointGizmo.DiedMonsterCount();
			}
		}
		return num;
	}

	public virtual int RemindMonsterCount()
	{
		if (!isSpawnEnabled)
		{
			return 0;
		}
		if (childrenGizmos == null || childrenGizmos.Count == 0)
		{
			return 0;
		}
		int num = 0;
		for (int i = 0; i < childrenGizmos.Count; i++)
		{
			BaseSpawnPointGizmo baseSpawnPointGizmo = childrenGizmos.get_Item(i);
			if (!(null == baseSpawnPointGizmo))
			{
				num += baseSpawnPointGizmo.RemindMonsterCount();
			}
		}
		return num;
	}
}
