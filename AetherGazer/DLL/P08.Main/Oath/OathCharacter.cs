using System.Collections.Generic;
using UnityEngine;

namespace Oath;

public class OathCharacter
{
	private OathDragManager _dragManager;

	private int skinID = -1;

	private GameObject modelObj;

	public OathTimlineBehavior timelineBehavior;

	public OathEventContext eventContext;

	public OathDragManager dragManager
	{
		get
		{
			if (_dragManager == null)
			{
				_dragManager = U3DUtil.Get<OathDragManager>(modelObj);
				_dragManager.Init();
			}
			return _dragManager;
		}
	}

	public GameObject GetModel()
	{
		return modelObj;
	}

	private void LoadModel(OathCharacterData characterData)
	{
		modelObj = Asset.Load<GameObject>(OathConst.GetModelAssetPath(OathSceneLoader.Scene.context.characterID));
		modelObj = Object.Instantiate(modelObj);
		modelObj.transform.position = characterData.pos;
		modelObj.transform.eulerAngles = characterData.rot;
		skinID = characterData.characterID;
		timelineBehavior = U3DUtil.Get<OathTimlineBehavior>(modelObj);
		LuaHelper.CallFunction("OathToLuaBridge.OathLoadModel", modelObj);
	}

	private void SetEventTree(OathCharacterData characterData)
	{
		for (int i = 0; i < characterData.treeNodeList.Count; i++)
		{
			OathInterationTreeNode oathInterationTreeNode = characterData.treeNodeList[i];
			oathInterationTreeNode.parentNode = null;
			oathInterationTreeNode.childNodeList = new List<OathInterationTreeNode>();
			for (int j = 0; j < characterData.treeNodeList.Count; j++)
			{
				int nodeID = characterData.treeNodeList[j].nodeID;
				if (nodeID == oathInterationTreeNode.parentTreeID)
				{
					oathInterationTreeNode.parentNode = characterData.treeNodeList[j];
				}
				for (int k = 0; k < oathInterationTreeNode.childTreeIDList.Count; k++)
				{
					if (oathInterationTreeNode.childTreeIDList[k] == nodeID)
					{
						if (oathInterationTreeNode.childNodeList.Count <= k)
						{
							oathInterationTreeNode.childNodeList.Add(characterData.treeNodeList[j]);
						}
						else
						{
							oathInterationTreeNode.childNodeList.Insert(k, characterData.treeNodeList[j]);
						}
					}
				}
			}
		}
	}

	private void LoadEvent(OathCharacterData characterData)
	{
		SetEventTree(characterData);
		if (eventContext == null)
		{
			eventContext = new OathEventContext();
		}
		for (int i = 0; i < characterData.treeNodeList.Count; i++)
		{
			(characterData.treeNodeList[i].interationData as OathInteractionBaseData).InitEvent(characterData.treeNodeList[i]);
			if (characterData.treeNodeList[i].interationData is OathInteractionAndLogic)
			{
				(characterData.treeNodeList[i].interationData as OathInteractionAndLogic).InitConditionEventList(characterData.treeNodeList);
			}
		}
		OathInteractionBaseData eventData = characterData.treeNodeList[characterData.beginTreeNodeIndex - 1].interationData as OathInteractionBaseData;
		eventContext.AddEvent(eventData);
	}

	public void Init(OathCharacterData characterData)
	{
		LoadModel(characterData);
		LoadEvent(characterData);
	}

	public void Tick()
	{
		if (eventContext != null)
		{
			eventContext?.EventProcess();
			eventContext?.EventIndependentProcess();
		}
	}

	public void Dispose()
	{
		if (eventContext != null)
		{
			eventContext.ClearEvent();
			eventContext = null;
		}
		if (_dragManager != null)
		{
			_dragManager.Dispose();
			_dragManager = null;
		}
		timelineBehavior.CloseExcutePlayable();
		timelineBehavior = null;
		Asset.Unload(OathConst.GetModelAssetPath(skinID));
		Object.Destroy(modelObj);
	}
}
