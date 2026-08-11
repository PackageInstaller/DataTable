using UnityEngine.EventSystems;

namespace UnityEngine.InputSystem.UI;

[HelpURL("https://docs.unity3d.com/Packages/com.unity.inputsystem@1.7/manual/UISupport.html#multiplayer-uis")]
public class MultiplayerEventSystem : EventSystem
{
	[Tooltip("If set, only process mouse and navigation events for any game objects which are children of this game object.")]
	[SerializeField]
	private GameObject m_PlayerRoot;

	public GameObject playerRoot
	{
		get
		{
			return m_PlayerRoot;
		}
		set
		{
			m_PlayerRoot = value;
			InitializePlayerRoot();
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		InitializePlayerRoot();
	}

	protected override void OnDisable()
	{
		base.OnDisable();
	}

	private void InitializePlayerRoot()
	{
		if (!(m_PlayerRoot == null))
		{
			InputSystemUIInputModule component = GetComponent<InputSystemUIInputModule>();
			if (component != null)
			{
				component.localMultiPlayerRoot = m_PlayerRoot;
			}
		}
	}

	protected override void Update()
	{
		EventSystem eventSystem = EventSystem.current;
		EventSystem.current = this;
		try
		{
			base.Update();
		}
		finally
		{
			EventSystem.current = eventSystem;
		}
	}
}
