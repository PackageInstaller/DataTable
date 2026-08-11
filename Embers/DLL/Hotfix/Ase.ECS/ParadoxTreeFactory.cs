using Cysharp.Threading.Tasks;
using NodeCanvas.Framework;
using UnityEngine;

namespace Ase.ECS;

public class ParadoxTreeFactory : UnityGameObjectFactoryBase
{
	private GameObject template;

	private Transform parent;

	private string _fullPath;

	public ParadoxTreeFactory(string fullPath, GameObject template, Transform parent, int cacheNumber)
	{
		this.template = template;
		this.parent = parent;
		_fullPath = fullPath;
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

	public override void Dispose()
	{
		GameEntry.Resource.UnloadAsset(_fullPath, "Paradoxs");
	}

	public override async UniTask<bool> PreLoadData()
	{
		GraphOwner component = template.GetComponent<GraphOwner>();
		if (component == null)
		{
			return false;
		}
		await component.SyncInitialize(1);
		return true;
	}
}
