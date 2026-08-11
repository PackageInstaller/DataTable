using System;

namespace UnityEngine.Rendering.LookDev;

public class StageRuntimeInterface
{
	private Func<bool, GameObject> m_AddGameObject;

	private Func<Camera> m_GetCamera;

	private Func<Light> m_GetSunLight;

	public object SRPData;

	public Camera camera => m_GetCamera?.Invoke();

	public Light sunLight => m_GetSunLight?.Invoke();

	public StageRuntimeInterface(Func<bool, GameObject> AddGameObject, Func<Camera> GetCamera, Func<Light> GetSunLight)
	{
		m_AddGameObject = AddGameObject;
		m_GetCamera = GetCamera;
		m_GetSunLight = GetSunLight;
	}

	public GameObject AddGameObject(bool persistent = false)
	{
		return m_AddGameObject?.Invoke(persistent);
	}
}
