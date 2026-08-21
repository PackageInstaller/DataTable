using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class CopyMainData : ViewModelBase
{
	private int mainId;

	private int copyType;

	private string icon;

	private int copyIndex;

	private string copyMainName;

	private bool isLock;

	private bool isSystemLock;

	private bool hasPlayUnlock;

	private bool hasNew;

	private Dictionary<int, CopyTypeData> copyTypeOpenDic;

	public int MainId => mainId;

	public int CopyType
	{
		get
		{
			return copyType;
		}
		private set
		{
			Set(ref copyType, value, "CopyType");
		}
	}

	public int CopyIndex
	{
		get
		{
			return copyIndex;
		}
		private set
		{
			Set(ref copyIndex, value, "CopyIndex");
		}
	}

	public string CopyMainName
	{
		get
		{
			return copyMainName;
		}
		private set
		{
			Set(ref copyMainName, value, "CopyMainName");
		}
	}

	public string Icon
	{
		get
		{
			return icon;
		}
		private set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public bool IsLock
	{
		get
		{
			return isLock;
		}
		private set
		{
			Set(ref isLock, value, "IsLock");
		}
	}

	public bool HasPlayUnlock
	{
		get
		{
			return hasPlayUnlock;
		}
		private set
		{
			Set(ref hasPlayUnlock, value, "HasPlayUnlock");
		}
	}

	public bool HasNew
	{
		get
		{
			return hasNew;
		}
		private set
		{
			Set(ref hasNew, value, "HasNew");
		}
	}

	public Dictionary<int, CopyTypeData> CopyTypeOpenDic => copyTypeOpenDic;

	public static CopyMainData Create(DRCopyMain mainCopy, Dictionary<int, CopyTypeData> copyTypes)
	{
		CopyMainData copyMainData = new CopyMainData();
		copyMainData.mainId = mainCopy.Id;
		copyMainData.copyType = mainCopy.Type;
		copyMainData.copyIndex = mainCopy.Pos;
		copyMainData.copyMainName = mainCopy.Name;
		copyMainData.copyTypeOpenDic = copyTypes;
		copyMainData.icon = mainCopy.Icon;
		bool flag = true;
		foreach (CopyTypeData value in copyTypes.Values)
		{
			if (!value.IsLock)
			{
				flag = false;
			}
		}
		copyMainData.isSystemLock = !Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(GetServiceId(mainCopy.Id));
		copyMainData.isLock = flag || copyMainData.isSystemLock;
		return copyMainData;
	}

	public void CheckMainCopyOpen()
	{
		bool flag = true;
		foreach (CopyTypeData value in copyTypeOpenDic.Values)
		{
			if (!value.IsLock)
			{
				flag = false;
			}
		}
		IsLock = flag || isSystemLock;
	}

	private static int GetServiceId(int mainId)
	{
		return mainId switch
		{
			1 => 70019, 
			2 => 70010, 
			3 => 70016, 
			4 => 70017, 
			5 => 70018, 
			_ => 0, 
		};
	}

	public void SetLock(bool isSystemOpen)
	{
		isSystemLock = !isSystemOpen;
		bool flag = true;
		foreach (CopyTypeData value in copyTypeOpenDic.Values)
		{
			if (!value.IsLock)
			{
				flag = false;
			}
		}
		IsLock = flag || isSystemLock;
	}

	public void PlayUnlockEffect()
	{
		HasPlayUnlock = true;
	}

	public void ResetPlayUnlockEffect()
	{
		HasPlayUnlock = false;
	}

	public void SetPlayUnlockEffect(bool playEffect)
	{
		HasPlayUnlock = playEffect;
	}

	public void SetRed(bool hasNew)
	{
		HasNew = hasNew;
	}
}
