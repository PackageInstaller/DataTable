using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.World.StateObject;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class InteractObjectData : InteractObjectDataBase, IExposedTable
{
	[HideInInspector]
	public Vector3 size;

	[HideInInspector]
	public Vector3 center;

	[SerializeField]
	internal int m_initialStateId;

	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	[SerializeField]
	private Dictionary<VarName, int> refTable = new Dictionary<VarName, int>();

	public override int initialStateId => m_initialStateId;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override void OnStateObjectCreate(StateObjectBase stateObject)
	{
		BoxCollider component = stateObject.GetComponent<BoxCollider>();
		if (component != null)
		{
			component.center = center;
			component.size = size;
		}
	}

	void IExposedTable.SetValue(VarName name, int swid)
	{
		refTable[name] = swid;
	}

	bool IExposedTable.GetValue(VarName name, out int swid)
	{
		bool result = refTable.TryGetValue(name, out var value);
		swid = value;
		return result;
	}

	void IExposedTable.ClearValue(VarName name)
	{
		refTable.Remove(name);
	}

	public override void Bake(object baker)
	{
		InteractObjectComp obj = baker as InteractObjectComp;
		InteractObjectData interactObjectData = obj.AssetData as InteractObjectData;
		BoxCollider componentInChildren = obj.GetComponentInChildren<BoxCollider>();
		if (componentInChildren != null)
		{
			interactObjectData.center = componentInChildren.center;
			interactObjectData.size = componentInChildren.size;
			if (interactObjectData.size.z == 0f)
			{
				interactObjectData.center.z = 1f;
				interactObjectData.size.z = 2f;
			}
		}
	}
}
