using Ase;
using Cinemachine;
using UnityEngine;

public class VirtualCameraFactory : UnityGameObjectFactoryBase
{
	private GameObject template;

	private Transform parent;

	public VirtualCameraFactory(Transform parent)
	{
		this.parent = parent;
	}

	protected override GameObject Create()
	{
		template = new GameObject("VirtualCam");
		template.AddComponent<CinemachineVirtualCamera>().AddCinemachineComponent<CinemachineFramingTransposerAp>();
		template.SetActive(value: false);
		template.transform.parent = parent;
		return template;
	}

	public override void Reset(GameObject obj)
	{
		if (!(obj == null))
		{
			obj.SetActive(value: false);
			obj.GetComponent<CinemachineVirtualCamera>().Priority = 1;
		}
	}

	public override void Dispose()
	{
		Object.Destroy(template);
	}
}
