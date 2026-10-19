using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;
using UnityEngine.Rendering;
using XPostProcessing;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行Volume", "Action", new string[] { "volume", "camera", "fov" })]
public class ActionVolume : ConfigAction
{
	public YooAssetReference volumeReferenceAssetID;

	[Tooltip("时长，秒数")]
	public float duration;

	public bool needCasterFaceDirToCheckVolume;

	public YooAssetReference volumeReference1AssetID;

	public EffectPoint point1;

	[HideInInspector]
	public bool useSpeedLine;

	[HideInInspector]
	public bool useSpeedLineWithDirection;

	[HideInInspector]
	public Vector3 speedLineDirection;

	protected override AbilityAuth defaultAuth => AbilityAuth.ClientOwner;

	public override void Do(ActionMemory memory)
	{
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		Animator volume = systemAbility.GetVolume(volumeReferenceAssetID);
		if (memory.caster.IsFaceLeft() && needCasterFaceDirToCheckVolume)
		{
			volume = systemAbility.GetVolume(volumeReference1AssetID);
		}
		Volume component = volume.GetComponent<Volume>();
		List<VolumeComponent> components = component.profile.components;
		Transform rootTransform = memory.owner.GetRootTransform();
		for (int i = 0; i < components.Count; i++)
		{
			VolumeSetting volumeSetting = components[i] as VolumeSetting;
			if (volumeSetting != null)
			{
				Vector3 vector = MonoECS.instance.entityLocal.compCamera.mainCamera.WorldToScreenPoint(rootTransform.position);
				volumeSetting.SetCenter(vector.x / (float)Screen.width, vector.y / (float)Screen.height);
			}
		}
		CompMotion? compMotion = memory.caster.GetCompMotion();
		CompMotion.VolumePlayParam volumePlayParam = new CompMotion.VolumePlayParam
		{
			duration = duration,
			useSpeedLine = useSpeedLine,
			useSpeedLineWithDirection = useSpeedLineWithDirection,
			speedLineDir = speedLineDirection
		};
		CompMotion.SetSpeedLineVolumeComponent(component, volumePlayParam);
		Vector3 pos = point1.SetTrans(memory.target.entity);
		compMotion.VolumePlay(volume, volumePlayParam, pos);
	}
}
