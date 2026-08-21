using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Ase.Paradox;

[Name("控制场景物体显示隐藏", 0)]
[Category("✫ DragonLost/Scene")]
[Description("控制场景物体显示隐藏")]
public class SceneObjectActive : ActionTaskBase
{
	[Name("跟节点名", 0)]
	public string rootGameObjectName;

	[Name("子路径", 0)]
	public string childPath;

	[Name("显示/隐藏", 0)]
	public bool isActive;

	[Name("是否跟随行为树结束还原", 0)]
	public bool isFollowDispose;

	private Transform target;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (string.IsNullOrEmpty(childPath))
		{
			EndAction();
			return;
		}
		if (string.IsNullOrEmpty(rootGameObjectName))
		{
			GameObject entityObject = ownerEntity.GetEntityObject();
			if (entityObject == null)
			{
				EndAction();
				return;
			}
			target = entityObject.transform.root.transform.Find(childPath);
			if (target != null)
			{
				target.gameObject.SetActive(isActive);
			}
			EndAction();
			return;
		}
		GameObject[] rootGameObjects = SceneManager.GetActiveScene().GetRootGameObjects();
		if (rootGameObjects.IsNullOrEmpty())
		{
			return;
		}
		GameObject[] array = rootGameObjects;
		foreach (GameObject gameObject in array)
		{
			if (gameObject.name.Equals(rootGameObjectName))
			{
				target = gameObject.transform.Find(childPath);
				if (target != null)
				{
					target.gameObject.SetActive(isActive);
				}
				break;
			}
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		if (isFollowDispose && !(target == null))
		{
			target.gameObject.SetActive(!isActive);
		}
	}
}
