using System;
using System.Collections.Generic;
using UnityEngine;

[DisallowMultipleComponent]
public class MountPoint : MonoBehaviour
{
	[Header("Mount Meta")]
	[SerializeField]
	private string localId = "mount_id";

	[SerializeField]
	private VehicleMountType mountType = VehicleMountType.Utility;

	[SerializeField]
	private bool isMirroredPair;

	[Header("Compatibility")]
	[SerializeField]
	private Vector2 sizeLimitMin = new Vector2(0.1f, 0.1f);

	[SerializeField]
	private Vector2 sizeLimitMax = new Vector2(3f, 3f);

	[SerializeField]
	private List<string> allowedTags = new List<string>();

	[Header("Runtime")]
	[SerializeField]
	private ModuleDefinition installedModule;

	[SerializeField]
	private GameObject visualInstance;

	public string LocalId => localId;

	public VehicleMountType MountType => mountType;

	public bool IsMirroredPair => isMirroredPair;

	public Vector2 SizeLimitMin => sizeLimitMin;

	public Vector2 SizeLimitMax => sizeLimitMax;

	public IReadOnlyList<string> AllowedTags => allowedTags;

	public ModuleDefinition InstalledModule => installedModule;

	public GameObject VisualInstance => visualInstance;

	public bool IsOccupied => installedModule != null;

	public void SetupFromTemplate(ChassisDefinition.MountPointTemplate template)
	{
		localId = template.localId;
		mountType = template.mountType;
		isMirroredPair = template.isMirroredPair;
		sizeLimitMin = template.sizeLimitMin;
		sizeLimitMax = template.sizeLimitMax;
		allowedTags = ((template.allowedTags != null) ? new List<string>(template.allowedTags) : new List<string>());
		base.transform.localPosition = template.localPosition;
		base.transform.localRotation = Quaternion.Euler(0f, 0f, template.localRotation);
	}

	public bool IsCompatible(ModuleDefinition module, out string reason)
	{
		if (module == null)
		{
			reason = "module is null";
			return false;
		}
		if (module.MountType != mountType)
		{
			reason = "mount type mismatch";
			return false;
		}
		Vector2 size = module.size;
		if (size.x < sizeLimitMin.x || size.y < sizeLimitMin.y || size.x > sizeLimitMax.x || size.y > sizeLimitMax.y)
		{
			reason = "module size out of mount limits";
			return false;
		}
		if (allowedTags != null && allowedTags.Count > 0 && !HasAnyTag(module.tags, allowedTags))
		{
			reason = "module tags are not allowed";
			return false;
		}
		reason = string.Empty;
		return true;
	}

	public void Attach(ModuleDefinition module)
	{
		Detach();
		installedModule = module;
		if (!(installedModule == null) && !(installedModule.visualPrefab == null))
		{
			visualInstance = UnityEngine.Object.Instantiate(installedModule.visualPrefab, base.transform);
			visualInstance.name = installedModule.moduleId + "_Visual";
			visualInstance.transform.localPosition = Vector3.zero;
			visualInstance.transform.localRotation = Quaternion.identity;
			visualInstance.transform.localScale = Vector3.one;
			visualInstance.SetActive(value: true);
		}
	}

	public void Detach()
	{
		installedModule = null;
		if (visualInstance != null)
		{
			UnityEngine.Object.Destroy(visualInstance);
			visualInstance = null;
		}
	}

	private static bool HasAnyTag(string[] source, List<string> allowed)
	{
		if (source == null || source.Length == 0 || allowed == null || allowed.Count == 0)
		{
			return false;
		}
		foreach (string text in source)
		{
			if (string.IsNullOrEmpty(text))
			{
				continue;
			}
			for (int j = 0; j < allowed.Count; j++)
			{
				if (string.Equals(text, allowed[j], StringComparison.OrdinalIgnoreCase))
				{
					return true;
				}
			}
		}
		return false;
	}
}
