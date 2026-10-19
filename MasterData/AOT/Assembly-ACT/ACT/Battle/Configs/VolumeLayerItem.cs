using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class VolumeLayerItem : TimelineItem
{
	public YooAssetReference volumeReferenceAssetID;

	public bool needCasterFaceDirToCheckVolume;

	public YooAssetReference volumeReference1AssetID;

	public EffectPoint point1;

	[HideInInspector]
	public bool useSpeedLine;

	[HideInInspector]
	public bool useSpeedLineWithDirection;

	[HideInInspector]
	public Vector3 speedLineDirection;

	public void StartVolumeClip(Entity entity, Animator animator)
	{
		CompMotion? compMotion = entity.GetCompMotion();
		CompMotion.VolumePlayParam volumePlayParam = new CompMotion.VolumePlayParam
		{
			useSpeedLine = useSpeedLine,
			useSpeedLineWithDirection = useSpeedLineWithDirection,
			speedLineDir = (useSpeedLineWithDirection ? speedLineDirection : Vector3.zero)
		};
		Vector3 pos = point1.SetTrans(entity);
		compMotion.VolumePlay(animator, volumePlayParam, pos);
	}

	public void EndVolumeClip(Entity entity, Animator animator)
	{
		entity.GetCompMotion()?.VolumeEnd(animator);
	}

	public override bool CanDoPeriod()
	{
		return true;
	}
}
