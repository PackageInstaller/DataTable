using System;
using ACT.Battle;
using ACT.Config;
using ACT.Sound;
using FMODUnity;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class SubmergePlatformData : StateWorldAssetData
{
	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	public YooAssetReference endPointModelAssetID;

	[SerializeField]
	internal int m_initialStateId;

	public PathInfo[] pathInfos;

	public float waitTime;

	public float reverseWaitTime;

	public float inchingTime;

	public float speed;

	public float inPlatformTime = 1f;

	public EventReference startToEndEvent;

	public AudioEventReference audioStartToEndEvent;

	public EventReference startToEndLoopEvent;

	public AudioEventReference audioStartToEndLoopEvent;

	public EventReference endToStartEvent;

	public AudioEventReference audioEndToStartEvent;

	public EventReference endToStartLoopEvent;

	public AudioEventReference audioEndToStartLoopEvent;

	public PushImpetusData pushImpetusConfig;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public override void Bake(object assetComp)
	{
	}
}
