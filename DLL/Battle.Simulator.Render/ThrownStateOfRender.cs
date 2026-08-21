using UnityEngine;

public class ThrownStateOfRender : IFramePooledObject
{
	public Vector3 Position = Vector3.zero;

	public Vector3 LastPosition = Vector3.zero;

	public Vector3 Forward = Vector3.forward;

	public uint StartChangeHeightTime;

	public ThrownFrameState m_ThrownState;

	public EnThrownUpdateState UpdateState;

	public GameObject AudioRoot;

	public EffectController EffectCtrl;

	public int currentFrame;

	public ThrownFrameState ThrownState
	{
		get
		{
			return m_ThrownState;
		}
		set
		{
			m_ThrownState = value;
			if (AudioRoot == null)
			{
				AudioRoot = new GameObject("AudioRoot");
				AudioRoot.transform.position = Vector3.zero;
			}
			AudioRoot.transform.position = (Vector3)m_ThrownState.mPosition;
		}
	}

	public int CreationIndex => ThrownState.mCreationIndex;

	public int TimelineID => ThrownState.mAbilityID;

	public int HitIndex => ThrownState.mHitIndex;

	public int CasterID => ThrownState.mCasterID;

	public int ProducerID => ThrownState.mProducerID;

	public Vector3 LogicLastPosition => (Vector3)ThrownState.mLastPosition;

	public Vector3 LogicPosition => (Vector3)ThrownState.mPosition;

	public Vector3 LogicForward => (Vector3)ThrownState.mForward;

	public ThrownStateOfRender()
	{
		Position = Vector3.zero;
		LastPosition = Vector3.zero;
		Forward = Vector3.forward;
		StartChangeHeightTime = 0u;
		UpdateState = EnThrownUpdateState.Obsolete;
		AudioRoot = new GameObject("AudioRoot");
		AudioRoot.transform.position = Vector3.zero;
		EffectCtrl = null;
	}

	public void OnEnterPool()
	{
		Position = Vector3.zero;
		LastPosition = Vector3.zero;
		Forward = Vector3.forward;
		StartChangeHeightTime = 0u;
		UpdateState = EnThrownUpdateState.Obsolete;
		AudioRoot.transform.position = Vector3.zero;
		currentFrame = 0;
		if (EffectCtrl != null)
		{
			EffectCtrl.Clean();
		}
		EffectCtrl = null;
	}
}
