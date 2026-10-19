using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using Cinemachine;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Drama;

public class ConversationCameraManager
{
	private List<GameObject> m_TempCameras = new List<GameObject>();

	public GameObject currentCamera
	{
		get
		{
			return m_TempCameras.Last();
		}
		set
		{
			m_TempCameras.Add(value);
		}
	}

	public CinemachineBlenderSettings CmBlenderSetting => GameLoader.meta.dialogResources.dialogVmBlends;

	public RealTimeConversationResources Resources => GameLoader.meta.dialogResources;

	public int TotalCamera => m_TempCameras.Count;

	public async void ReleaseCamera()
	{
		int millisecondsDelay = GameManager.cameraSystem.EndCinemachineMovement(MonoECS.instance.mainEntity);
		foreach (GameObject tempCamera in m_TempCameras)
		{
			tempCamera.SetActive(value: false);
		}
		await UniTask.Delay(millisecondsDelay);
		foreach (GameObject tempCamera2 in m_TempCameras)
		{
			Object.Destroy(tempCamera2);
		}
		m_TempCameras.Clear();
	}
}
