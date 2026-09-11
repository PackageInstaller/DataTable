using UnityEngine;

public class QWCharacterBehavior : QWAgentBehaviour
{
	[HideInInspector]
	public new QWCharacterAgent mAgent => m_agent as QWCharacterAgent;
}
