#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using UnityEngine;

namespace Ase;

public class MsgBubble : MonoBehaviour
{
	[SerializeField]
	private GameObject recRoot;

	[SerializeField]
	private GameObject recResPath1Go;

	[SerializeField]
	private GameObject recResPath2Go;

	[SerializeField]
	private GameObject sendRoot;

	[SerializeField]
	private GameObject sendResPath1Go;

	[SerializeField]
	private GameObject sendResPath2Go;

	private bool inited;

	public void ApplyStyle(bool isSend, bool useResPath1)
	{
		EnsureRefs();
		if (recRoot != null)
		{
			recRoot.SetActive(!isSend);
		}
		if (sendRoot != null)
		{
			sendRoot.SetActive(isSend);
		}
		if (isSend)
		{
			ToggleResPath(sendResPath1Go, sendResPath2Go, useResPath1, "Send");
		}
		else
		{
			ToggleResPath(recResPath1Go, recResPath2Go, useResPath1, "Rec");
		}
	}

	private void ToggleResPath(GameObject resPath1Go, GameObject resPath2Go, bool useResPath1, string rootName)
	{
		if (useResPath1 && resPath1Go == null)
		{
			Log.Error("MsgBubble missing ResPath1 GameObject on " + rootName + "Root.");
			useResPath1 = false;
		}
		if (resPath1Go != null)
		{
			resPath1Go.SetActive(useResPath1);
		}
		if (resPath2Go != null)
		{
			resPath2Go.SetActive(!useResPath1);
		}
	}

	private void EnsureRefs()
	{
		if (!inited)
		{
			if (recRoot == null)
			{
				recRoot = FindChildGoByName(base.transform, "RecRoot");
			}
			if (sendRoot == null)
			{
				sendRoot = FindChildGoByName(base.transform, "SendRoot");
			}
			if (recResPath1Go == null && recRoot != null)
			{
				recResPath1Go = FindChildGoByName(recRoot.transform, "MsgBubble_P1");
			}
			if (recResPath2Go == null && recRoot != null)
			{
				recResPath2Go = FindChildGoByName(recRoot.transform, "MsgBubble_P2");
			}
			if (sendResPath1Go == null && sendRoot != null)
			{
				sendResPath1Go = FindChildGoByName(sendRoot.transform, "MsgBubble_P1");
			}
			if (sendResPath2Go == null && sendRoot != null)
			{
				sendResPath2Go = FindChildGoByName(sendRoot.transform, "MsgBubble_P2");
			}
			inited = true;
		}
	}

	private static GameObject FindChildGoByName(Transform root, string name)
	{
		if (root == null)
		{
			return null;
		}
		Transform[] componentsInChildren = root.GetComponentsInChildren<Transform>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (componentsInChildren[i] != null && componentsInChildren[i].name == name)
			{
				return componentsInChildren[i].gameObject;
			}
		}
		return null;
	}
}
