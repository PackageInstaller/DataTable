using Unity.VisualScripting;
using UnityEngine;

[UnitTitle("Initialize Pool")]
[UnitCategory("Community\\ObjectPooling")]
public class InitializePoolNode : Unit
{
	[UnitHeaderInspectable("CustomParent")]
	public bool CustomParent = true;

	[DoNotSerialize]
	public ControlInput Enter;

	[DoNotSerialize]
	public ControlOutput Initialized;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueInput Prefab;

	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput InitialPoolSize;

	[DoNotSerialize]
	[PortLabelHidden]
	public ValueOutput ObjectPool;

	[NullMeansSelf]
	[PortLabelHidden]
	[DoNotSerialize]
	public ValueInput parent;

	protected override void Definition()
	{
		Enter = ControlInput("Enter", OnEnter);
		Initialized = ControlOutput("Initialized");
		if (CustomParent)
		{
			parent = ValueInput<GameObject>("parent", null).NullMeansSelf();
		}
		Prefab = ValueInput<GameObject>("Prefab", null);
		InitialPoolSize = ValueInput("InitialPoolSize", 10);
		ObjectPool = ValueOutput<CustomObjectPool>("ObjectPool");
		Succession(Enter, Initialized);
		Assignment(Enter, ObjectPool);
	}

	private ControlOutput OnEnter(Flow flow)
	{
		GameObject value = flow.GetValue<GameObject>(Prefab);
		int value2 = flow.GetValue<int>(InitialPoolSize);
		GameObject gameObject = null;
		gameObject = ((!CustomParent) ? new GameObject("ObjectPoolParent") : flow.GetValue<GameObject>(parent));
		CustomObjectPool customObjectPool = gameObject.AddComponent<CustomObjectPool>();
		flow.SetValue(ObjectPool, gameObject.GetComponent<CustomObjectPool>());
		customObjectPool.Initialize(value, value2);
		Transform[] componentsInChildren = gameObject.GetComponentsInChildren<Transform>();
		foreach (Transform transform in componentsInChildren)
		{
			if (transform != gameObject.transform)
			{
				transform.SetParent(gameObject.transform);
			}
		}
		return Initialized;
	}
}
