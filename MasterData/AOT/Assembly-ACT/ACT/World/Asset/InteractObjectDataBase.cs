using System;
using Sirenix.Utilities;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public abstract class InteractObjectDataBase : StateWorldAssetData
{
	[SerializeField]
	[Tooltip("交互物转变改变时同步信息，比如角色状态和位置 ")]
	private bool m_IsSyncCharacterInfo = true;

	[Tooltip("在服务器存档？")]
	public bool m_ServiceSave = true;

	[Tooltip("所有状态id")]
	public int[] stateIds;

	[Tooltip("在服务器存档？")]
	public bool[] serviceSaves;

	[Tooltip("是否等待场景全部加载之后初始化")]
	public bool isWaitInit;

	public override bool IsWaitInit => isWaitInit;

	public override bool IsServiceSaveState(int stateId)
	{
		if (!m_ServiceSave)
		{
			return false;
		}
		if (!stateIds.IsNullOrEmpty())
		{
			int num = Array.IndexOf(stateIds, stateId);
			if (num >= 0)
			{
				return serviceSaves[num];
			}
		}
		return false;
	}

	public override bool IsSyncCharacterInfo(int stateId)
	{
		return m_IsSyncCharacterInfo;
	}

	public override void Bake(object assetComp)
	{
	}
}
