using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using UnityEngine.SceneManagement;

namespace UnityEngine.Experimental.Rendering;

[Serializable]
public class ProbeVolumeSceneData : ISerializationCallbackReceiver
{
	[Serializable]
	private struct SerializableBoundItem
	{
		[SerializeField]
		public string sceneGUID;

		[SerializeField]
		public Bounds bounds;
	}

	[Serializable]
	private struct SerializableHasPVItem
	{
		[SerializeField]
		public string sceneGUID;

		[SerializeField]
		public bool hasProbeVolumes;
	}

	[Serializable]
	private struct SerializablePVProfile
	{
		[SerializeField]
		public string sceneGUID;

		[SerializeField]
		public ProbeReferenceVolumeProfile profile;
	}

	[Serializable]
	private struct SerializablePVBakeSettings
	{
		[SerializeField]
		public string sceneGUID;

		[SerializeField]
		public ProbeVolumeBakingProcessSettings settings;
	}

	[Serializable]
	internal class BakingSet
	{
		public string name;

		public List<string> sceneGUIDs = new List<string>();

		public ProbeVolumeBakingProcessSettings settings;

		public ProbeReferenceVolumeProfile profile;
	}

	private static PropertyInfo s_SceneGUID = typeof(Scene).GetProperty("guid", BindingFlags.Instance | BindingFlags.NonPublic);

	[SerializeField]
	private List<SerializableBoundItem> serializedBounds;

	[SerializeField]
	private List<SerializableHasPVItem> serializedHasVolumes;

	[SerializeField]
	private List<SerializablePVProfile> serializedProfiles;

	[SerializeField]
	private List<SerializablePVBakeSettings> serializedBakeSettings;

	[SerializeField]
	private List<BakingSet> serializedBakingSets;

	internal Object parentAsset;

	internal string parentSceneDataPropertyName;

	public Dictionary<string, Bounds> sceneBounds;

	internal Dictionary<string, bool> hasProbeVolumes;

	internal Dictionary<string, ProbeReferenceVolumeProfile> sceneProfiles;

	internal Dictionary<string, ProbeVolumeBakingProcessSettings> sceneBakingSettings;

	internal List<BakingSet> bakingSets;

	private string GetSceneGUID(Scene scene)
	{
		return (string)s_SceneGUID.GetValue(scene);
	}

	public ProbeVolumeSceneData(Object parentAsset, string parentSceneDataPropertyName)
	{
		this.parentAsset = parentAsset;
		this.parentSceneDataPropertyName = parentSceneDataPropertyName;
		sceneBounds = new Dictionary<string, Bounds>();
		hasProbeVolumes = new Dictionary<string, bool>();
		sceneProfiles = new Dictionary<string, ProbeReferenceVolumeProfile>();
		sceneBakingSettings = new Dictionary<string, ProbeVolumeBakingProcessSettings>();
		bakingSets = new List<BakingSet>();
		serializedBounds = new List<SerializableBoundItem>();
		serializedHasVolumes = new List<SerializableHasPVItem>();
		serializedProfiles = new List<SerializablePVProfile>();
		serializedBakeSettings = new List<SerializablePVBakeSettings>();
		UpdateBakingSets();
	}

	public void SetParentObject(Object parent, string parentSceneDataPropertyName)
	{
		parentAsset = parent;
		this.parentSceneDataPropertyName = parentSceneDataPropertyName;
		UpdateBakingSets();
	}

	public void OnAfterDeserialize()
	{
		if (serializedBounds == null || serializedHasVolumes == null || serializedProfiles == null || serializedBakeSettings == null)
		{
			return;
		}
		sceneBounds = new Dictionary<string, Bounds>();
		hasProbeVolumes = new Dictionary<string, bool>();
		sceneProfiles = new Dictionary<string, ProbeReferenceVolumeProfile>();
		sceneBakingSettings = new Dictionary<string, ProbeVolumeBakingProcessSettings>();
		bakingSets = new List<BakingSet>();
		foreach (SerializableBoundItem serializedBound in serializedBounds)
		{
			sceneBounds.Add(serializedBound.sceneGUID, serializedBound.bounds);
		}
		foreach (SerializableHasPVItem serializedHasVolume in serializedHasVolumes)
		{
			hasProbeVolumes.Add(serializedHasVolume.sceneGUID, serializedHasVolume.hasProbeVolumes);
		}
		foreach (SerializablePVProfile serializedProfile in serializedProfiles)
		{
			sceneProfiles.Add(serializedProfile.sceneGUID, serializedProfile.profile);
		}
		foreach (SerializablePVBakeSettings serializedBakeSetting in serializedBakeSettings)
		{
			sceneBakingSettings.Add(serializedBakeSetting.sceneGUID, serializedBakeSetting.settings);
		}
		foreach (BakingSet serializedBakingSet in serializedBakingSets)
		{
			bakingSets.Add(serializedBakingSet);
		}
	}

	private void UpdateBakingSets()
	{
		foreach (BakingSet serializedBakingSet in serializedBakingSets)
		{
			if (serializedBakingSet.profile == null)
			{
				InitializeBakingSet(serializedBakingSet, serializedBakingSet.name);
			}
		}
		if (bakingSets.Count == 0)
		{
			CreateNewBakingSet("Default").sceneGUIDs = serializedProfiles.Select((SerializablePVProfile s) => s.sceneGUID).ToList();
		}
		SyncBakingSetSettings();
	}

	public void OnBeforeSerialize()
	{
		if (sceneBounds == null || hasProbeVolumes == null || sceneBakingSettings == null || sceneProfiles == null || serializedBounds == null || serializedHasVolumes == null || serializedBakeSettings == null || serializedProfiles == null || serializedBakingSets == null)
		{
			return;
		}
		serializedBounds.Clear();
		serializedHasVolumes.Clear();
		serializedProfiles.Clear();
		serializedBakeSettings.Clear();
		serializedBakingSets.Clear();
		SerializableBoundItem item = default(SerializableBoundItem);
		foreach (string key5 in sceneBounds.Keys)
		{
			string key = (item.sceneGUID = key5);
			item.bounds = sceneBounds[key];
			serializedBounds.Add(item);
		}
		SerializableHasPVItem item2 = default(SerializableHasPVItem);
		foreach (string key6 in hasProbeVolumes.Keys)
		{
			string key2 = (item2.sceneGUID = key6);
			item2.hasProbeVolumes = hasProbeVolumes[key2];
			serializedHasVolumes.Add(item2);
		}
		SerializablePVBakeSettings item3 = default(SerializablePVBakeSettings);
		foreach (string key7 in sceneBakingSettings.Keys)
		{
			string key3 = (item3.sceneGUID = key7);
			item3.settings = sceneBakingSettings[key3];
			serializedBakeSettings.Add(item3);
		}
		SerializablePVProfile item4 = default(SerializablePVProfile);
		foreach (string key8 in sceneProfiles.Keys)
		{
			string key4 = (item4.sceneGUID = key8);
			item4.profile = sceneProfiles[key4];
			serializedProfiles.Add(item4);
		}
		foreach (BakingSet bakingSet in bakingSets)
		{
			serializedBakingSets.Add(bakingSet);
		}
	}

	internal BakingSet CreateNewBakingSet(string name)
	{
		BakingSet bakingSet = new BakingSet();
		InitializeBakingSet(bakingSet, name);
		bakingSets.Add(bakingSet);
		return bakingSet;
	}

	private void InitializeBakingSet(BakingSet set, string name)
	{
		ProbeReferenceVolumeProfile profile = ScriptableObject.CreateInstance<ProbeReferenceVolumeProfile>();
		set.name = name;
		set.profile = profile;
		set.settings = new ProbeVolumeBakingProcessSettings
		{
			dilationSettings = new ProbeDilationSettings
			{
				enableDilation = true,
				dilationDistance = 1f,
				dilationValidityThreshold = 0.25f,
				dilationIterations = 1,
				squaredDistWeighting = true
			},
			virtualOffsetSettings = new VirtualOffsetSettings
			{
				useVirtualOffset = true,
				outOfGeoOffset = 0.01f,
				searchMultiplier = 0.2f
			}
		};
	}

	internal void SyncBakingSetSettings()
	{
		foreach (BakingSet bakingSet in bakingSets)
		{
			foreach (string sceneGUID in bakingSet.sceneGUIDs)
			{
				sceneBakingSettings[sceneGUID] = bakingSet.settings;
				sceneProfiles[sceneGUID] = bakingSet.profile;
			}
		}
	}
}
