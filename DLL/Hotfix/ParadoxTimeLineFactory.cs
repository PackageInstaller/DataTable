using Ase;
using UnityEngine;

public class ParadoxTimeLineFactory : UnityGameObjectFactoryBase
{
	private GameObject template;

	private Transform parent;

	private string _entityPath;

	public ParadoxTimeLineFactory(string entityPath, GameObject template, Transform parent)
	{
		if (!(template == null))
		{
			this.template = Object.Instantiate(template, parent);
			this.template.hideFlags = HideFlags.HideInHierarchy;
			this.template.SetActive(value: false);
			this.parent = parent;
			_entityPath = entityPath;
		}
	}

	public override void Reset(GameObject obj)
	{
		obj.SetActive(value: false);
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

	public override void Dispose()
	{
		Object.Destroy(template);
		GameEntry.Resource.UnloadAsset(_entityPath);
	}
}
