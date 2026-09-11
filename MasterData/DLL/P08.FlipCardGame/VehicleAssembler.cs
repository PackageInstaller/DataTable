using System;
using System.Collections.Generic;
using UnityEngine;

[DisallowMultipleComponent]
public class VehicleAssembler : MonoBehaviour
{
	[Serializable]
	public struct InstalledModuleRecord
	{
		public MountPoint mountPoint;

		public ModuleDefinition module;
	}

	[Header("Refs")]
	[SerializeField]
	private ChassisDefinition chassisDefinition;

	[SerializeField]
	private bool autoBuildMountsFromDefinition = true;

	[Header("Runtime")]
	[SerializeField]
	private List<MountPoint> mountPoints = new List<MountPoint>();

	[SerializeField]
	private List<InstalledModuleRecord> installedModules = new List<InstalledModuleRecord>();

	private readonly Dictionary<string, MountPoint> mountLookup = new Dictionary<string, MountPoint>(32);

	public ChassisDefinition ChassisDefinition => chassisDefinition;

	public IReadOnlyList<MountPoint> MountPoints => mountPoints;

	public IReadOnlyList<InstalledModuleRecord> InstalledModules => installedModules;

	public event Action OnAssemblyChanged;

	private void Awake()
	{
		CollectMountPoints();
	}

	private void OnValidate()
	{
		if (!Application.isPlaying)
		{
			CollectMountPoints();
		}
	}

	public void CollectMountPoints()
	{
		if (autoBuildMountsFromDefinition)
		{
			EnsureMountPointsFromChassis();
		}
		MountPoint[] componentsInChildren = GetComponentsInChildren<MountPoint>(includeInactive: true);
		mountPoints.Clear();
		mountLookup.Clear();
		installedModules.Clear();
		foreach (MountPoint mountPoint in componentsInChildren)
		{
			if (mountPoint == null || string.IsNullOrEmpty(mountPoint.LocalId))
			{
				throw new InvalidOperationException("[VehicleAssembler] MountPoint with empty LocalId found on " + base.name + ".");
			}
			if (mountLookup.ContainsKey(mountPoint.LocalId))
			{
				throw new InvalidOperationException("[VehicleAssembler] Duplicate LocalId '" + mountPoint.LocalId + "' found on " + base.name + ".");
			}
			mountPoints.Add(mountPoint);
			mountLookup[mountPoint.LocalId] = mountPoint;
			if (mountPoint.InstalledModule != null)
			{
				installedModules.Add(new InstalledModuleRecord
				{
					mountPoint = mountPoint,
					module = mountPoint.InstalledModule
				});
			}
		}
	}

	public bool InstallModule(string mountId, ModuleDefinition module, bool allowReplace = true)
	{
		if (!mountLookup.TryGetValue(mountId, out var value) || value == null)
		{
			return false;
		}
		return InstallModule(value, module, allowReplace);
	}

	public void SetRuntimeChassisDefinition(ChassisDefinition definition, bool rebuildMounts = true)
	{
		chassisDefinition = definition;
		autoBuildMountsFromDefinition = true;
		if (rebuildMounts)
		{
			RebuildMountPointsFromDefinition();
		}
		else
		{
			CollectMountPoints();
		}
		OnAssemblyChanged?.Invoke();
	}

	public void RebuildMountPointsFromDefinition()
	{
		EnsureMountPointsFromChassis();
		CollectMountPoints();
	}

	public bool InstallModule(MountPoint mountPoint, ModuleDefinition module, bool allowReplace = true)
	{
		if (mountPoint == null || module == null)
		{
			return false;
		}
		if (!mountPoint.IsCompatible(module, out var _))
		{
			return false;
		}
		if (mountPoint.IsOccupied && !allowReplace)
		{
			return false;
		}
		if (mountPoint.IsOccupied)
		{
			RemoveModule(mountPoint);
		}
		mountPoint.Attach(module);
		installedModules.Add(new InstalledModuleRecord
		{
			mountPoint = mountPoint,
			module = module
		});
		OnAssemblyChanged?.Invoke();
		return true;
	}

	public bool RemoveModule(string mountId)
	{
		if (!mountLookup.TryGetValue(mountId, out var value))
		{
			return false;
		}
		return RemoveModule(value);
	}

	public bool RemoveModule(MountPoint mountPoint)
	{
		if (mountPoint == null || !mountPoint.IsOccupied)
		{
			return false;
		}
		for (int num = installedModules.Count - 1; num >= 0; num--)
		{
			if (installedModules[num].mountPoint == mountPoint)
			{
				installedModules.RemoveAt(num);
			}
		}
		mountPoint.Detach();
		OnAssemblyChanged?.Invoke();
		return true;
	}

	public void ClearAllModules()
	{
		bool flag = false;
		for (int i = 0; i < mountPoints.Count; i++)
		{
			MountPoint mountPoint = mountPoints[i];
			if (!(mountPoint == null) && mountPoint.IsOccupied)
			{
				mountPoint.Detach();
				flag = true;
			}
		}
		installedModules.Clear();
		if (flag)
		{
			OnAssemblyChanged?.Invoke();
		}
	}

	public void GetInstalledWheels(List<InstalledModuleRecord> outRecords)
	{
		FillByType(VehicleMountType.Wheel, outRecords);
	}

	public void GetInstalledWeapons(List<InstalledModuleRecord> outRecords)
	{
		FillByType(VehicleMountType.Weapon, outRecords);
	}

	public void GetInstalledUtilities(List<InstalledModuleRecord> outRecords)
	{
		FillByType(VehicleMountType.Utility, outRecords);
	}

	private void FillByType(VehicleMountType type, List<InstalledModuleRecord> outRecords)
	{
		if (outRecords == null)
		{
			return;
		}
		outRecords.Clear();
		for (int i = 0; i < installedModules.Count; i++)
		{
			InstalledModuleRecord item = installedModules[i];
			if (!(item.mountPoint == null) && !(item.module == null) && item.module.MountType == type)
			{
				outRecords.Add(item);
			}
		}
	}

	private void EnsureMountPointsFromChassis()
	{
		if (chassisDefinition == null || chassisDefinition.mountPointTemplates == null || chassisDefinition.mountPointTemplates.Count == 0)
		{
			return;
		}
		Transform transform = base.transform;
		for (int i = 0; i < chassisDefinition.mountPointTemplates.Count; i++)
		{
			ChassisDefinition.MountPointTemplate template = chassisDefinition.mountPointTemplates[i];
			if (!string.IsNullOrEmpty(template.localId))
			{
				Transform transform2 = transform.Find(template.localId);
				if (transform2 == null)
				{
					GameObject obj = new GameObject(template.localId);
					obj.transform.SetParent(transform, worldPositionStays: false);
					transform2 = obj.transform;
				}
				MountPoint mountPoint = transform2.GetComponent<MountPoint>();
				if (mountPoint == null)
				{
					mountPoint = transform2.gameObject.AddComponent<MountPoint>();
				}
				mountPoint.SetupFromTemplate(template);
			}
		}
	}
}
