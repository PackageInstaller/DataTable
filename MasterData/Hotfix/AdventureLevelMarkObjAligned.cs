#define LOG_ERROR
using UnityEngine;

public class AdventureLevelMarkObjAligned : MonoBehaviour
{
	public string alignedObjectName;

	private void OnEnable()
	{
		if (string.IsNullOrEmpty(alignedObjectName))
		{
			NovaLogger.Error(name + "要同步的目标物体名字为空!");
			return;
		}
		GameObject gameObject = GameObject.Find("==== Environment ====");
		if (gameObject == null)
		{
			NovaLogger.Error("没有找到目标节点:==== Environment ====");
			return;
		}
		Transform transform = gameObject.transform.FindInChildren(alignedObjectName);
		if (null == transform)
		{
			NovaLogger.Error("没有找到目标节点:" + alignedObjectName);
			return;
		}
		base.transform.localScale = transform.transform.localScale;
		base.transform.position = transform.transform.position;
		base.transform.rotation = transform.transform.rotation;
	}
}
