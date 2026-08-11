using UnityEngine;

namespace Ase.ECS;

public class EntityViewFactory : UnityGameObjectFactoryBase
{
	private GameObject template;

	private Transform parent;

	private Vector3 normalScale;

	private string _entityPath;

	public EntityViewFactory(string entityPath, GameObject template, Transform parent)
	{
		if (!(template == null))
		{
			this.template = Object.Instantiate(template, parent);
			this.template.hideFlags = HideFlags.HideInHierarchy;
			this.template.SetActive(value: false);
			this.parent = parent;
			normalScale = template.transform.localScale;
			_entityPath = entityPath;
		}
	}

	protected override GameObject Create()
	{
		if (template == null)
		{
			return null;
		}
		GameObject gameObject = Object.Instantiate(template, parent);
		gameObject.hideFlags = HideFlags.None;
		return gameObject;
	}

	public override void Reset(GameObject obj)
	{
		obj.SetActive(value: false);
		obj.transform.SetParent(parent, worldPositionStays: false);
		obj.transform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
	}

	public override void Dispose()
	{
		Object.Destroy(template);
		GameEntry.Resource.UnloadAsset(_entityPath);
	}
}
