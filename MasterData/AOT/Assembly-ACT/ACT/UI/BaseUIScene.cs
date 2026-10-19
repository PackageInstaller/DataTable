using ACT.Utility;
using Lumin.LoungeSystem.UI;
using UnityEngine;
using UnityEngine.Rendering.Universal;
using UnityEngine.Serialization;

namespace ACT.UI;

public class BaseUIScene : LuminSerializedMonoBehaviour
{
	[FormerlySerializedAs("mainCamera")]
	public Camera uiSceneCamera;

	private bool m_Open;

	private DeferredSceneLightingRegistry m_DeferredSceneLightingRegistry;

	private void SetDeferredSceneLightingRegistryEnabled(bool isEnabled)
	{
		if (m_DeferredSceneLightingRegistry == null)
		{
			m_DeferredSceneLightingRegistry = DeferredSceneLightingRegistry.GetActiveLightingRegistry();
		}
		if (m_DeferredSceneLightingRegistry != null)
		{
			m_DeferredSceneLightingRegistry.enabled = isEnabled;
		}
	}

	public virtual void Open()
	{
		if (!m_Open)
		{
			m_Open = true;
			SetDeferredSceneLightingRegistryEnabled(isEnabled: false);
			gameObject.SetActive(value: true);
			uiSceneCamera.gameObject.SetActive(value: true);
			GameUtility.mainCamera.gameObject.SetActive(value: false);
			uiSceneCamera.GetUniversalAdditionalCameraData().cameraStack.Add(GameUtility.uiCamera);
			if (LoungeUIScene.instance != null)
			{
				LoungeUIScene.instance.uiSceneCamera.enabled = false;
			}
		}
	}

	public virtual void Close()
	{
		if (m_Open)
		{
			m_Open = false;
			gameObject.SetActive(value: false);
			uiSceneCamera.gameObject.SetActive(value: false);
			GameUtility.mainCamera?.gameObject.SetActive(value: true);
			uiSceneCamera.GetUniversalAdditionalCameraData().cameraStack.Remove(GameUtility.uiCamera);
			if (LoungeUIScene.instance != null)
			{
				LoungeUIScene.instance.uiSceneCamera.enabled = true;
			}
			SetDeferredSceneLightingRegistryEnabled(isEnabled: true);
		}
	}

	public virtual void OnLoadComplete()
	{
	}

	public virtual void OnRelease()
	{
	}

	protected virtual void OnDestroy()
	{
	}
}
