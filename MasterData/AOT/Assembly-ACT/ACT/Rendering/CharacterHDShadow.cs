using Fundamental;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.Rendering;

[DisallowMultipleComponent]
[DefaultExecutionOrder(-100)]
public sealed class CharacterHDShadow : MonoBehaviour
{
	[SerializeField]
	[Tooltip("Battle 用于战斗实体，UnBattle 用于界面及剧情展示模型。")]
	private CharacterHDShadowObjectType m_ObjectType;

	private CharacterShadowRegistry.Registration m_Registration;

	private CharacterRenderingRegistry.Registration m_CharacterRenderingRegistration;

	private CharacterHDShadowManager m_Manager;

	private bool m_DesiredEnabled;

	private bool m_UseCharacterMainLight;

	private Quaternion m_MainLightRotation;

	public CharacterHDShadowObjectType ObjectType => m_ObjectType;

	public bool UseCharacterMainLight => m_UseCharacterMainLight;

	public void SetObjectType(CharacterHDShadowObjectType objectType)
	{
		if (m_ObjectType != objectType)
		{
			m_ObjectType = objectType;
			if (m_Manager != null)
			{
				m_Manager.Refresh();
			}
		}
	}

	public void SetMainLightRotation(Quaternion rotation)
	{
		m_UseCharacterMainLight = true;
		m_MainLightRotation = rotation;
		if (m_Manager != null)
		{
			m_Manager.Refresh();
		}
	}

	private void OnEnable()
	{
		m_Manager = Singleton<GameManager>.instance.characterHDShadowManager;
		m_Manager.Register(this);
	}

	private void OnDisable()
	{
		if (m_Manager != null)
		{
			m_Manager.Unregister(this);
			m_Manager = null;
		}
	}

	private void OnDestroy()
	{
		if (m_Manager != null)
		{
			m_Manager.Unregister(this);
			m_Manager = null;
		}
	}

	internal bool SetHDShadowEnabled(bool enabled)
	{
		m_DesiredEnabled = enabled;
		if (!enabled)
		{
			CharacterShadowRegistry.Unregister(m_Registration);
			m_Registration = null;
			CharacterRenderingRegistry.Unregister(m_CharacterRenderingRegistration);
			m_CharacterRenderingRegistration = null;
			return false;
		}
		if (m_UseCharacterMainLight)
		{
			m_CharacterRenderingRegistration = CharacterRenderingRegistry.Register(gameObject, new CharacterRenderingRegistry.Settings
			{
				enableHDShadow = true,
				mainLightRotation = m_MainLightRotation
			});
			return m_CharacterRenderingRegistration?.hasHDShadowSlot ?? false;
		}
		if (m_Registration == null)
		{
			m_Registration = CharacterShadowRegistry.Register(gameObject);
		}
		return m_Registration != null;
	}

	private void OnTransformChildrenChanged()
	{
		if (m_DesiredEnabled)
		{
			CharacterShadowRegistry.Unregister(m_Registration);
			m_Registration = null;
			CharacterRenderingRegistry.Unregister(m_CharacterRenderingRegistration);
			m_CharacterRenderingRegistration = null;
			if (m_Manager != null)
			{
				m_Manager.Refresh();
			}
		}
	}
}
