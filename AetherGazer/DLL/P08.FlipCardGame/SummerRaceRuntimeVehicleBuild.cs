using System.Collections.Generic;

public sealed class SummerRaceRuntimeVehicleBuild
{
	public sealed class MountModuleBinding
	{
		public string mountId;

		public ModuleDefinition module;
	}

	public ChassisDefinition chassis;

	public SummerRaceRuntimePhysicsTuningData physicsTuning;

	public readonly List<MountModuleBinding> wheelBindings = new List<MountModuleBinding>(8);

	public readonly List<MountModuleBinding> weaponBindings = new List<MountModuleBinding>(8);

	public readonly List<MountModuleBinding> utilityBindings = new List<MountModuleBinding>(8);
}
