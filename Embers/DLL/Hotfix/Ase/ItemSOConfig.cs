#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ItemSOConfig : MonoBehaviour
{
	[SerializeField]
	private int serviceId;

	[SerializeField]
	private List<int> serviceIds;

	[SerializeField]
	private GameObject lockStateRoot;

	[SerializeField]
	private GameObject openStateRoot;

	[SerializeField]
	private Button btn;

	private bool isInit;

	private bool state;

	public int ServiceId => serviceId;

	public void Init()
	{
		if (isInit)
		{
			return;
		}
		bool flag = true;
		if (serviceIds != null && serviceIds.Count > 0)
		{
			for (int i = 0; i < serviceIds.Count; i++)
			{
				flag = flag && Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(serviceIds[i]);
			}
		}
		else
		{
			flag = Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(serviceId);
		}
		SetState(flag);
		if (btn != null)
		{
			btn.onClick.AddListener(OnTip);
		}
		isInit = true;
	}

	private void OnTip()
	{
		if (serviceIds != null && serviceIds.Count > 0)
		{
			for (int i = 0; i < serviceIds.Count && !OnTipByServiceId(serviceIds[i]); i++)
			{
			}
		}
		else
		{
			OnTipByServiceId(serviceId);
		}
	}

	private bool OnTipByServiceId(int serviceId)
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(serviceId))
		{
			DRSystemOpen soConfig = GameEntry.DataTable.GetDataRow((DRSystemOpen p) => p.Id == serviceId);
			if (soConfig == null)
			{
				Toast.ShowInfo("功能未开放！");
				return true;
			}
			if (Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level < soConfig.OpenLevel && soConfig.OpenLevel != 0)
			{
				Toast.ShowInfo($"等级达到{soConfig.OpenLevel}级解锁！");
				return true;
			}
			DRTask dataRow = GameEntry.DataTable.GetDataRow((DRTask p) => p.CopyOpen == soConfig.OpenList);
			if (dataRow != null && soConfig.OpenList != 0)
			{
				Toast.ShowInfo("完成主线" + dataRow.TaskTitle + "后解锁！");
				return true;
			}
			if (Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetServiceInBanState(serviceId))
			{
				bool flag = true;
				if (Enum.IsDefined(typeof(ServiceEnum), serviceId))
				{
					ServiceEnum serviceEnum = (ServiceEnum)serviceId;
					if ((uint)(serviceEnum - 70009001) <= 2u || (uint)(serviceEnum - 70009005) <= 1u)
					{
						Toast.ShowInfo("功能维护中，无法开启排行榜界面");
					}
					else
					{
						flag = false;
					}
				}
				else
				{
					Log.Error($"未定义的系统Id:{serviceId}");
				}
				if (flag)
				{
					return true;
				}
			}
			Toast.ShowInfo("功能未开放！");
			return true;
		}
		return false;
	}

	public void OnChangeState(int serviceId, bool state)
	{
		if (serviceIds != null && serviceIds.Count > 0)
		{
			if (serviceIds.Contains(serviceId))
			{
				bool flag = true;
				for (int i = 0; i < serviceIds.Count; i++)
				{
					flag = flag && Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(serviceIds[i]);
				}
				SetState(flag);
			}
		}
		else if (serviceId == this.serviceId)
		{
			SetState(state);
		}
	}

	private void SetState(bool state)
	{
		this.state = state;
		if (lockStateRoot != null)
		{
			lockStateRoot.gameObject.SetActive(!state);
		}
		if (openStateRoot != null)
		{
			openStateRoot.gameObject.SetActive(state);
		}
	}

	public void SetServiceId(int getServiceId)
	{
		serviceId = getServiceId;
	}

	public void AddControlItem(GameObject lockItem, GameObject openItem, Button btn)
	{
		lockStateRoot = lockItem;
		openStateRoot = openItem;
		this.btn = btn;
	}
}
