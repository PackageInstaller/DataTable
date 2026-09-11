using UnityEngine;

[DisallowMultipleComponent]
public class VehicleController : MonoBehaviour
{
	[Header("Refs")]
	[SerializeField]
	private VehicleAssembler assembler;

	[SerializeField]
	private VehiclePhysicsController physicsController;

	[SerializeField]
	private VehicleWeaponSystem weaponSystem;

	[Header("Preset (1~4)")]
	[SerializeField]
	private VehicleBuildPreset preset1_LightSmallWheelLightGun;

	[SerializeField]
	private VehicleBuildPreset preset2_BigWheelFrontHeavyCannon;

	[SerializeField]
	private VehicleBuildPreset preset3_AsymmetricWheelSideWeapon;

	[SerializeField]
	private VehicleBuildPreset preset4_WithBalanceBlock;

	[SerializeField]
	private int startPresetIndex;

	[Header("Input")]
	[SerializeField]
	private KeyCode fireKey = KeyCode.Space;

	[SerializeField]
	private KeyCode nextWeaponKey = KeyCode.Tab;

	private VehicleBuildPreset[] cachedPresets;

	private void Awake()
	{
		if (assembler == null)
		{
			assembler = GetComponent<VehicleAssembler>();
		}
		if (physicsController == null)
		{
			physicsController = GetComponent<VehiclePhysicsController>();
		}
		if (weaponSystem == null)
		{
			weaponSystem = GetComponent<VehicleWeaponSystem>();
		}
		cachedPresets = new VehicleBuildPreset[4] { preset1_LightSmallWheelLightGun, preset2_BigWheelFrontHeavyCannon, preset3_AsymmetricWheelSideWeapon, preset4_WithBalanceBlock };
	}

	private void Start()
	{
		ApplyPreset(Mathf.Clamp(startPresetIndex, 0, 3));
	}

	private void Update()
	{
		float num = 0f;
		if (Input.GetKey(KeyCode.A) || Input.GetKey(KeyCode.LeftArrow))
		{
			num--;
		}
		if (Input.GetKey(KeyCode.D) || Input.GetKey(KeyCode.RightArrow))
		{
			num++;
		}
		float num2 = 0f;
		if (Input.GetKey(KeyCode.W) || Input.GetKey(KeyCode.UpArrow))
		{
			num2++;
		}
		if (Input.GetKey(KeyCode.S) || Input.GetKey(KeyCode.DownArrow))
		{
			num2--;
		}
		if (physicsController != null)
		{
			physicsController.ApplyDrive(num);
			physicsController.ApplySteering(num2);
		}
		if (Input.GetKeyDown(fireKey) && weaponSystem != null)
		{
			weaponSystem.FireSelectedWeapon();
		}
		if (Input.GetKeyDown(nextWeaponKey) && weaponSystem != null)
		{
			weaponSystem.SelectNextWeapon();
		}
		if (Input.GetKeyDown(KeyCode.Alpha1))
		{
			ApplyPreset(0);
		}
		if (Input.GetKeyDown(KeyCode.Alpha2))
		{
			ApplyPreset(1);
		}
		if (Input.GetKeyDown(KeyCode.Alpha3))
		{
			ApplyPreset(2);
		}
		if (Input.GetKeyDown(KeyCode.Alpha4))
		{
			ApplyPreset(3);
		}
	}

	[ContextMenu("Apply Preset 1 LightWheel+LightGun")]
	public void ApplyPreset1()
	{
		ApplyPreset(0);
	}

	[ContextMenu("Apply Preset 2 BigWheel+FrontCannon")]
	public void ApplyPreset2()
	{
		ApplyPreset(1);
	}

	[ContextMenu("Apply Preset 3 AsymWheel+SideWeapon")]
	public void ApplyPreset3()
	{
		ApplyPreset(2);
	}

	[ContextMenu("Apply Preset 4 WithBalanceBlock")]
	public void ApplyPreset4()
	{
		ApplyPreset(3);
	}

	public void ApplyPreset(int index)
	{
		if (assembler == null || cachedPresets == null || index < 0 || index >= cachedPresets.Length)
		{
			return;
		}
		VehicleBuildPreset vehicleBuildPreset = cachedPresets[index];
		if (vehicleBuildPreset == null)
		{
			return;
		}
		assembler.ClearAllModules();
		for (int i = 0; i < vehicleBuildPreset.entries.Count; i++)
		{
			VehicleBuildPreset.Entry entry = vehicleBuildPreset.entries[i];
			if (!(entry.module == null) && !string.IsNullOrEmpty(entry.mountId))
			{
				assembler.InstallModule(entry.mountId, entry.module);
			}
		}
		if (weaponSystem != null)
		{
			weaponSystem.RefreshWeapons();
			weaponSystem.SelectWeapon(0);
		}
		if (physicsController != null)
		{
			physicsController.RebuildVehiclePhysics();
		}
	}
}
