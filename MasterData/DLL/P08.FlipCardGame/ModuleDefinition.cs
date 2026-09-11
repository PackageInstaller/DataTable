using UnityEngine;

public abstract class ModuleDefinition : ScriptableObject
{
	[Header("Common")]
	public string moduleId = "module_id";

	public string displayName = "Module";

	[Min(0f)]
	public float mass = 1f;

	public Vector2 size = new Vector2(1f, 1f);

	public string[] tags;

	public GameObject visualPrefab;

	[Min(0f)]
	public int cost = 1;

	public Vector2 localMassOffset;

	public abstract VehicleMountType MountType { get; }
}
