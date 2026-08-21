using System;
using System.Collections.Generic;
using System.Text;
using UnityEngine;

namespace Oath;

[Serializable]
public abstract class OathInteractionBaseData
{
	[HideInInspector]
	public int nodeID;

	public bool isNeedSDK;

	private bool isFinish;

	private bool isInit;

	private bool isDispose;

	public bool IsIndependent;

	[NonSerialized]
	public OathInteractionBaseData parent;

	[NonSerialized]
	public List<OathInteractionBaseData> child;

	[HideInInspector]
	public virtual bool MustNeedSDK => false;

	public bool IsNeedSDK
	{
		get
		{
			if (MustNeedSDK)
			{
				return true;
			}
			return isNeedSDK;
		}
	}

	public bool IsFinish
	{
		get
		{
			return isFinish;
		}
		set
		{
			isFinish = value;
		}
	}

	public bool IsInit
	{
		get
		{
			return isInit;
		}
		set
		{
			isInit = value;
		}
	}

	public bool IsDispose
	{
		get
		{
			return isDispose;
		}
		set
		{
			isDispose = value;
		}
	}

	public virtual bool IsNeedAloneClear => false;

	public virtual void StartEvent()
	{
	}

	public virtual void UpdateEvent()
	{
	}

	public virtual void FinishEvent()
	{
	}

	public virtual void DisposeEvent()
	{
	}

	public void SetTreeNode(OathInterationTreeNode treeNode)
	{
		nodeID = treeNode.nodeID;
		parent = null;
		if (child != null)
		{
			child.Clear();
			child = null;
		}
		if (treeNode.parentNode != null)
		{
			parent = treeNode.parentNode.interationData as OathInteractionBaseData;
		}
		if (treeNode.childNodeList == null)
		{
			return;
		}
		child = new List<OathInteractionBaseData>();
		for (int i = 0; i < treeNode.childNodeList.Count; i++)
		{
			if (treeNode.childNodeList[i].interationData is OathInteractionBaseData item)
			{
				child.Add(item);
			}
		}
	}

	public void InitData()
	{
		isFinish = false;
		isInit = false;
		isDispose = false;
	}

	public virtual void InitEvent(OathInterationTreeNode treeNode)
	{
		InitData();
		SetTreeNode(treeNode);
	}

	public virtual void ClearBrotherNode()
	{
		if (parent == null || parent.child == null)
		{
			return;
		}
		for (int i = 0; i < parent.child.Count; i++)
		{
			OathInteractionBaseData oathInteractionBaseData = parent.child[i];
			if (oathInteractionBaseData != this && oathInteractionBaseData.IsIndependent == IsIndependent)
			{
				oathInteractionBaseData.IsDispose = true;
				oathInteractionBaseData.DisposeEvent();
			}
		}
	}

	public void OnStart()
	{
		IsInit = true;
		StartEvent();
	}

	public void OnUpdate()
	{
		if (IsInit)
		{
			UpdateEvent();
		}
	}

	public void OnFinish()
	{
		IsDispose = true;
		FinishEvent();
		if (IsIndependent)
		{
			OathSceneLoader.Scene.context.interationManager.character.eventContext.ClearIndependentEvent(nodeID);
		}
		else if (IsNeedAloneClear)
		{
			OathSceneLoader.Scene.context.interationManager.character.eventContext.ClearEvent(nodeID);
		}
		else
		{
			OathSceneLoader.Scene.context.interationManager.character.eventContext.ClearEvent();
		}
		SendSDK();
		ClearBrotherNode();
		AddChildEvent();
	}

	public virtual void SendSDK()
	{
		if (!IsNeedSDK)
		{
			return;
		}
		int num = 0;
		foreach (OathInteractionBaseData item in parent.child)
		{
			if (item.IsNeedSDK)
			{
				num++;
			}
		}
		if (num > 1)
		{
			StringBuilder stringBuilder = new StringBuilder();
			int num2 = parent.child.Count;
			foreach (OathInteractionBaseData item2 in parent.child)
			{
				stringBuilder.Append(item2.nodeID);
				num2--;
				if (num2 > 0)
				{
					stringBuilder.Append(",");
				}
			}
			LuaHelper.CallFunction("OathToLuaBridge.OathRecordSDK", nodeID, stringBuilder.ToString());
		}
		else
		{
			LuaHelper.CallFunction("OathToLuaBridge.OathRecordSDK", nodeID);
		}
	}

	public virtual void AddChildEvent()
	{
		if (child == null)
		{
			return;
		}
		foreach (OathInteractionBaseData item in child)
		{
			item.InitData();
			OathSceneLoader.Scene.context.interationManager.character.eventContext.AddEvent(item);
			if (item.parent == null)
			{
				item.parent = this;
			}
		}
	}
}
