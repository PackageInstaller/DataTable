using ACT.SceneLightVolume;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

[DisallowMultipleComponent]
[RequireComponent(typeof(Light))]
public sealed class PlayerPointLightFollower : MonoBehaviour
{
	[SerializeField]
	[Tooltip("Offset from the player root for this point light.")]
	private Vector3 worldOffset = new Vector3(0f, 2f, 0f);

	private Light m_PointLight;

	private void Awake()
	{
		m_PointLight = GetComponent<Light>();
	}

	private void OnEnable()
	{
		if (m_PointLight == null)
		{
			m_PointLight = GetComponent<Light>();
		}
		SceneLightManager.RegisterPlayerPointLight(m_PointLight);
	}

	private void LateUpdate()
	{
		Transform transform = null;
		MonoECS instance = MonoECS.instance;
		if (instance != null && instance.mainEntity.IsValid)
		{
			transform = instance.mainEntity.GetRootTransform();
		}
		bool flag = transform != null;
		if (flag)
		{
			base.transform.position = transform.position + worldOffset;
		}
		SceneLightManager.SetPlayerPointLightTargetAvailable(m_PointLight, flag);
	}

	private void OnDisable()
	{
		SceneLightManager.UnregisterPlayerPointLight(m_PointLight);
	}
}
