using System.Collections.Generic;
using UnityEngine;

namespace ACT.World.Asset;

public abstract class StateWorldAssetComp : MonoBehaviour
{
	[HideInInspector]
	public List<int> indexList = new List<int>();

	[SerializeField]
	[HideInInspector]
	private int m_id;

	public int stateWorldUid
	{
		get
		{
			return m_id;
		}
		set
		{
			m_id = value;
		}
	}

	public abstract StateWorldAssetData AssetData { get; }
}
public abstract class StateWorldAssetComp<TAssetData> : StateWorldAssetComp where TAssetData : StateWorldAssetData, new()
{
	public TAssetData assetData;

	public override StateWorldAssetData AssetData => assetData;
}
