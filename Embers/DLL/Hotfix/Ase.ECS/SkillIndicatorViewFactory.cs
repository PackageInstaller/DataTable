using UnityEngine;

namespace Ase.ECS;

public class SkillIndicatorViewFactory : UnityGameObjectFactoryBase
{
	private GameObject _template;

	private Transform _parent;

	private Vector3 _normalScale;

	private string _entityPath;

	public SkillIndicatorViewFactory(string entityPath, GameObject template, Transform parent)
	{
		_template = template;
		_parent = parent;
		_entityPath = entityPath;
	}

	protected override GameObject Create()
	{
		return Object.Instantiate(_template, _parent);
	}

	public override void Reset(GameObject obj)
	{
		obj.SetActive(value: false);
		obj.transform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
	}

	public override void Dispose()
	{
		GameEntry.Resource.UnloadAsset(_entityPath);
	}
}
