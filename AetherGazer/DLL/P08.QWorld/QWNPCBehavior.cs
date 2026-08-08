using UnityEngine;

public class QWNPCBehavior : QWAgentBehaviour
{
	[HideInInspector]
	public new QWNPCAgent mAgent => m_agent as QWNPCAgent;
}
