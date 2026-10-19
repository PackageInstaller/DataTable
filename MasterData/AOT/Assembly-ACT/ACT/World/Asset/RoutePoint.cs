using System;
using ACT.Sound;
using FMODUnity;

namespace ACT.World.Asset;

[Serializable]
public class RoutePoint : IDataToBake
{
	public Pos position;

	public uint curveIndex;

	public float moveTime;

	public float waitTime;

	public bool moveAttack;

	public YooAssetReference startEffectAssetID;

	public YooAssetReference endEffectAssetID;

	public EventReference startSound;

	public AudioEventReference audioStartSound;

	public EventReference endSound;

	public AudioEventReference audioEndSound;
}
