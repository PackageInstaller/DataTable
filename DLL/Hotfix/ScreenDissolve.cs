using Ase;
using Ase.ECS;
using UnityEngine;

public class ScreenDissolve : MonoBehaviour
{
	private Material mat;

	private float valuefrom;

	private float valueto = 1f;

	public float enterSpeed = 1f;

	public float enterValue = 0.3f;

	public float exitSpeed = 1f;

	public float exitValue = 0.3f;

	private bool closeFlag;

	public LevelAreaTriggerType triggerType = LevelAreaTriggerType.Box;

	private void OnTriggerTypeChanged()
	{
		if (triggerType == LevelAreaTriggerType.Box)
		{
			Collider component = base.gameObject.GetComponent<Collider>();
			if (component is BoxCollider)
			{
				return;
			}
			Object.DestroyImmediate((Object)(object)component);
			component = (Collider)(object)base.gameObject.AddComponent<BoxCollider>();
			component.isTrigger = true;
			component = null;
		}
		if (triggerType == LevelAreaTriggerType.Sphere)
		{
			Collider component2 = base.gameObject.GetComponent<Collider>();
			if (!(component2 is SphereCollider))
			{
				Object.DestroyImmediate((Object)(object)component2);
				component2 = (Collider)(object)base.gameObject.AddComponent<SphereCollider>();
				component2.isTrigger = true;
				component2 = null;
			}
		}
	}

	private void Start()
	{
		mat = GetComponent<MeshRenderer>().sharedMaterial;
		valuefrom = mat.GetFloat("_DissoleveRadius");
		valueto = mat.GetFloat("_DissoleveRadius");
	}

	private void OnTriggerEnter(Collider other)
	{
		if (((Component)(object)other).TryGetComponent(out EntityView component) && component.Entity != null && component.Entity.IsActorEntity)
		{
			valueto = enterValue;
			closeFlag = false;
		}
	}

	private void OnTriggerExit(Collider other)
	{
		if (((Component)(object)other).TryGetComponent(out EntityView component) && component.Entity != null && component.Entity.IsActorEntity)
		{
			closeFlag = true;
			valueto = exitValue;
		}
	}

	private void Update()
	{
		if (valuefrom != valueto)
		{
			valueto = Mathf.Lerp(valuefrom, valueto, Time.deltaTime * (closeFlag ? exitSpeed : enterSpeed));
			mat.SetFloat("_DissoleveRadius", valuefrom);
		}
	}
}
