using UnityEngine;

namespace Ase.ECS;

public class EntityInfoItemViewFactory : UnityGameObjectFactoryBase
{
	private GameObject template;

	private Transform parent;

	private Vector3 normalScale;

	private string _fullPath;

	private readonly string _itemName;

	private readonly bool _templateInitActive;

	public EntityInfoItemViewFactory(string fullPath, GameObject template, Transform parent, string itemName = null, bool templateInitActive = false)
	{
		this.template = template;
		this.parent = parent;
		_fullPath = fullPath;
		_itemName = itemName;
		_templateInitActive = templateInitActive;
		this.template.SetActive(_templateInitActive);
	}

	protected override GameObject Create()
	{
		GameObject gameObject = Object.Instantiate(template, parent);
		if (!string.IsNullOrEmpty(_itemName))
		{
			gameObject.name = _itemName;
		}
		if (_templateInitActive)
		{
			gameObject.transform.position = VectorExtensions.ScreenOutPos;
		}
		return gameObject;
	}

	public override void Reset(GameObject obj)
	{
		obj.transform.position = VectorExtensions.ScreenOutPos;
		obj.transform.rotation = Quaternion.Euler(Vector3.zero);
	}

	public override void Dispose()
	{
		GameEntry.Resource.UnloadAsset(_fullPath);
	}
}
