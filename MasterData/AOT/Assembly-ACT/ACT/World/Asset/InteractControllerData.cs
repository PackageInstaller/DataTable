using System;
using ACT.Config;
using ACT.Sound;
using FMODUnity;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.World.Asset;

[Serializable]
public class InteractControllerData : StateWorldAssetData
{
	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	[SerializeField]
	internal int m_initialStateId;

	public int weight;

	public LocalizedString name;

	public int iconId;

	public float speed;

	public float CheckDis;

	[Tooltip("一般检测盒宽度和模型大小一致")]
	public Vector3 boxSize;

	public LayerMask colliderLayer;

	public PathDir pathDir;

	public Orbit[] orbits;

	public string[] abilities;

	public StateWorldUid[] IgnoreStateWorldUids;

	public EventReference mineCarLoopEvent;

	public AudioEventReference audioMineCarLoopEvent;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public override void Bake(object assetComp)
	{
	}
}
