using System;
using System.Collections.Generic;
using UnityEngine;

public static class SummerRaceRuntimeAssemblyBootstrap
{
	public static bool ApplyBuild(GameObject host, SummerRaceRuntimeVehicleBuild build, Transform aimTarget, out VehicleAssembler assembler, out VehiclePhysicsController physicsController, out VehicleWeaponSystem weaponSystem)
	{
		assembler = null;
		physicsController = null;
		weaponSystem = null;
		if (host == null || build == null || build.chassis == null)
		{
			return false;
		}
		assembler = host.GetComponent<VehicleAssembler>();
		if (assembler == null)
		{
			assembler = host.AddComponent<VehicleAssembler>();
		}
		physicsController = host.GetComponent<VehiclePhysicsController>();
		if (physicsController == null)
		{
			physicsController = host.AddComponent<VehiclePhysicsController>();
		}
		weaponSystem = host.GetComponent<VehicleWeaponSystem>();
		if (weaponSystem == null)
		{
			weaponSystem = host.AddComponent<VehicleWeaponSystem>();
		}
		if (host.GetComponent<SummerRaceCombatPresentationEffectSink>() == null)
		{
			host.AddComponent<SummerRaceCombatPresentationEffectSink>();
		}
		if (host.GetComponent<SummerRaceCombatPresentationComEffectSink>() == null)
		{
			host.AddComponent<SummerRaceCombatPresentationComEffectSink>();
		}
		if (host.GetComponent<SummerRaceCombatPresentationAudioSink>() == null)
		{
			host.AddComponent<SummerRaceCombatPresentationAudioSink>();
		}
		physicsController.SetRebuildSuspended(suspended: true);
		try
		{
			VehicleSimpleProjectile projectilePrefab = SummerRaceConfigLoader.LoadVehicleSimpleProjectilePrefab();
			assembler.SetRuntimeChassisDefinition(build.chassis);
			assembler.ClearAllModules();
			InstallBindingListStrict(assembler, build.wheelBindings);
			InstallBindingListStrict(assembler, build.weaponBindings);
			InstallBindingListStrict(assembler, build.utilityBindings);
			physicsController.ApplyRuntimeTuning(build.physicsTuning);
			physicsController.SetRebuildSuspended(suspended: false);
			physicsController.RebuildVehiclePhysics();
			weaponSystem.SetProjectilePrefab(projectilePrefab);
			weaponSystem.SetAimTarget(aimTarget);
			weaponSystem.RefreshWeapons();
		}
		finally
		{
			physicsController.SetRebuildSuspended(suspended: false);
		}
		return true;
	}

	private static void InstallBindingListStrict(VehicleAssembler assembler, List<SummerRaceRuntimeVehicleBuild.MountModuleBinding> bindings)
	{
		if (assembler == null || bindings == null)
		{
			return;
		}
		for (int i = 0; i < bindings.Count; i++)
		{
			SummerRaceRuntimeVehicleBuild.MountModuleBinding mountModuleBinding = bindings[i];
			if (mountModuleBinding != null && !string.IsNullOrEmpty(mountModuleBinding.mountId) && !(mountModuleBinding.module == null) && !assembler.InstallModule(mountModuleBinding.mountId, mountModuleBinding.module))
			{
				throw new InvalidOperationException("[SummerRace][ModularBootstrap] Install failed mount=" + mountModuleBinding.mountId + " module=" + mountModuleBinding.module.name);
			}
		}
	}
}
