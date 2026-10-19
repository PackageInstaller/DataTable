using System.Collections.Generic;
using Bamboo.ECS;
using Bamboo.Precache;
using UnityEngine;
using UnityEngine.Rendering;
using XPostProcessing;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("触发Volume", "Action", new string[] { "trigger", "volume", "camera", "fov" })]
public class ActionTriggerVolume : ConfigAction
{
	public YooAssetReference volumeReferenceAssetID;

	public bool isAppear;

	protected override AbilityAuth defaultAuth => AbilityAuth.ClientOwner;

	public override void Do(ActionMemory memory)
	{
		if (isAppear)
		{
			InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(volumeReferenceAssetID.GUID);
			memory.ability.abilityVolumeAssetID.Add(volumeReferenceAssetID, instanceHandle);
			Transform rootTransform = memory.owner.GetRootTransform();
			Vector3 pos = MonoECS.instance.entityLocal.compCamera.mainCamera.WorldToScreenPoint(rootTransform.position);
			instanceHandle.Completed += (InstanceHandle l) =>
			{
				List<VolumeComponent> components = l.Result.GetComponent<Volume>().profile.components;
				for (int i = 0; i < components.Count; i++)
				{
					VolumeSetting volumeSetting = components[i] as VolumeSetting;
					if (!(volumeSetting == null))
					{
						volumeSetting.SetCenter(pos.x / (float)Screen.width, pos.y / (float)Screen.height);
					}
				}
			};
			return;
		}
		foreach (KeyValuePair<YooAssetReference, InstanceHandle> item in memory.ability.abilityVolumeAssetID)
		{
			if (item.Value != null && item.Key == volumeReferenceAssetID)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(item.Value);
			}
		}
		if (memory.ability.abilityVolumeAssetID.ContainsKey(volumeReferenceAssetID))
		{
			memory.ability.abilityVolumeAssetID.Remove(volumeReferenceAssetID);
		}
	}
}
