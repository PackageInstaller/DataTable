using Ase;
using UnityEngine;

public class SkillTimeLineFactory : UnityGameObjectFactoryBase
{
	private GameObject _template;

	private Transform _parent;

	private string _fullPath;

	public SkillTimeLineFactory(string fullPath, GameObject template, Transform parent)
	{
		_template = template;
		_parent = parent;
		_fullPath = fullPath;
	}

	protected override GameObject Create()
	{
		return Object.Instantiate(_template, _parent);
	}

	public override void Reset(GameObject obj)
	{
		obj.SetActive(value: false);
		obj.transform.position = Vector3.zero;
		obj.transform.rotation = Quaternion.Euler(Vector3.zero);
	}

	public override void Dispose()
	{
		GameEntry.Resource.UnloadAsset(_fullPath);
	}
}
