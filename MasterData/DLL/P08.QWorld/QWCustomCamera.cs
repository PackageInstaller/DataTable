using System.Collections.Generic;
using Cinemachine;
using UnityEngine;

public class QWCustomCamera : MonoBehaviour
{
	public LinkedListNode<QWCustomCamera> node;

	public static int Priority = 30;

	public int layer = -1;

	public string cameraPath;

	public string cameraShortPath;

	public string cameraBasePath = "";

	public GameObject mCamera;

	public ICinemachineCamera camera;

	public CinemachineBlendDefinition blendDefinition = new CinemachineBlendDefinition
	{
		m_Style = CinemachineBlendDefinition.Style.Cut
	};

	public CinemachineBlendDefinition outBlendDefinition = new CinemachineBlendDefinition
	{
		m_Style = CinemachineBlendDefinition.Style.Cut
	};

	public QWCustomCamera()
	{
		node = new LinkedListNode<QWCustomCamera>(this);
	}

	public void EnableCamera()
	{
		camera = mCamera.GetComponent<ICinemachineCamera>();
		mCamera.SetActive(value: true);
	}

	public void SetOnBlend()
	{
		base.gameObject.SetActive(value: false);
	}

	public void Dispose()
	{
		Object.Destroy(base.gameObject);
		Asset.Unload(cameraPath);
	}
}
