using System.Collections.Generic;
using UnityEngine;

[DisallowMultipleComponent]
[AddComponentMenu("CRIWARE/CRI Atom Region")]
public class CriAtomRegion : CriMonoBehaviour
{
	internal List<CriAtomSourceBase> referringSources = new List<CriAtomSourceBase>();

	internal List<CriAtomListener> referringListeners = new List<CriAtomListener>();

	internal List<CriAtomTransceiver> referringTransceivers = new List<CriAtomTransceiver>();

	public CriAtomEx3dRegion region3dHn { get; protected set; }

	private void Awake()
	{
		InternalInitialize();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		InitializeParameters();
	}

	private void OnDestroy()
	{
		InternalFinalize();
	}

	protected virtual void InternalInitialize()
	{
		CriAtomPlugin.InitializeLibrary();
		region3dHn = new CriAtomEx3dRegion();
	}

	protected virtual void InternalFinalize()
	{
		while (referringSources.Count > 0)
		{
			referringSources[0].region3d = null;
		}
		referringSources.Clear();
		while (referringListeners.Count > 0)
		{
			referringListeners[0].region3d = null;
		}
		referringListeners.Clear();
		while (referringTransceivers.Count > 0)
		{
			referringTransceivers[0].region3d = null;
		}
		referringTransceivers.Clear();
		region3dHn.Dispose();
		region3dHn = null;
		CriAtomPlugin.FinalizeLibrary();
	}

	protected virtual void InitializeParameters()
	{
		if (region3dHn == null)
		{
			Debug.LogError("[CRIWARE] Internal: CriAtomEx3dRegion is not created correctly.", this);
		}
	}

	public override void CriInternalUpdate()
	{
	}

	public override void CriInternalLateUpdate()
	{
	}
}
