using UnityEngine;

namespace Ase;

public class EnergyEffectFactory : UnityGameObjectFactoryBase
{
	private GameObject template;

	private Transform parent;

	private Vector3 normalScale;

	public EnergyEffectFactory(GameObject template, Transform parent)
	{
		this.template = template;
		this.parent = parent;
	}

	protected override GameObject Create()
	{
		return Object.Instantiate(template, parent);
	}

	public override void Reset(GameObject obj)
	{
		obj.SetActive(value: false);
		obj.transform.position = Vector3.zero;
		obj.transform.rotation = Quaternion.Euler(Vector3.zero);
	}
}
