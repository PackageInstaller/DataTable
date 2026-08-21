using System;
using UnityEngine;

[DisallowMultipleComponent]
[AddComponentMenu("CRIWARE/CRI Atom Transceiver")]
public class CriAtomTransceiver : CriMonoBehaviour
{
	private delegate void SetControlIdMethod(ushort id);

	[SerializeField]
	private CriAtomRegion regionOnStart;

	[SerializeField]
	private bool useDedicatedInput;

	[SerializeField]
	private GameObject dedicatedInput;

	[SerializeField]
	[Range(0f, 1f)]
	private float outputVolume = 1f;

	[SerializeField]
	private float directAudioRadius;

	[SerializeField]
	private float crossFadeDistance = 10f;

	[Range(0f, 360f)]
	[SerializeField]
	private float coneInsideAngle = 360f;

	[SerializeField]
	[Range(0f, 360f)]
	private float coneOutsideAngle = 360f;

	[SerializeField]
	[Range(0f, 1f)]
	private float coneOutsideVolume;

	[SerializeField]
	private float transceiverRadius = 1f;

	[SerializeField]
	private float interiorDistance = 3f;

	[SerializeField]
	public float minAttenuation = 1f;

	[SerializeField]
	public float maxAttenuation = 100f;

	[SerializeField]
	private string globalAisacName = string.Empty;

	[SerializeField]
	private float maxAngleAisacDelta = 1f;

	[SerializeField]
	private string distanceAisacControlId = string.Empty;

	[SerializeField]
	private string listenerAzimuthAisacControlId = string.Empty;

	[SerializeField]
	private string listenerElevationAisacControlId = string.Empty;

	[SerializeField]
	private string outputAzimuthAisacControlId = string.Empty;

	[SerializeField]
	private string outputElevationAisacControlId = string.Empty;

	[NonSerialized]
	public bool inspectorAisacSettingFoldout;

	private bool isInitialized;

	private bool dedicatedInputNotSetWarned;

	private CriAtomRegion currentRegion;

	public CriAtomEx3dTransceiver transceiverHn { get; protected set; }

	public Vector3 inputPos { get; private set; }

	public Vector3 inputFront { get; private set; }

	public Vector3 inputUp { get; private set; }

	public CriAtomRegion region3d
	{
		get
		{
			return currentRegion;
		}
		set
		{
			if (currentRegion == value)
			{
				return;
			}
			if (currentRegion != null)
			{
				currentRegion.referringTransceivers.Remove(this);
			}
			CriAtomEx3dRegion criAtomEx3dRegion = ((value == null) ? null : value.region3dHn);
			if (transceiverHn != null)
			{
				transceiverHn.Set3dRegion(criAtomEx3dRegion);
				transceiverHn.Update();
				currentRegion = value;
				if (currentRegion != null)
				{
					currentRegion.referringTransceivers.Add(this);
				}
			}
			else
			{
				Debug.LogError("[CRIWARE] Internal: The Transcevier is not initialized correctly.");
				currentRegion = null;
			}
		}
	}

	private void Awake()
	{
		InternalInitialize();
	}

	private void Start()
	{
		if (regionOnStart != null)
		{
			region3d = regionOnStart;
		}
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
		transceiverHn = new CriAtomEx3dTransceiver();
		isInitialized = true;
	}

	protected virtual void InternalFinalize()
	{
		isInitialized = false;
		region3d = null;
		transceiverHn.Dispose();
		transceiverHn = null;
		CriAtomPlugin.FinalizeLibrary();
	}

	protected virtual void InitializeParameters()
	{
		if (transceiverHn != null)
		{
			ApplyCurrentPosition();
			ApplyParameters();
		}
		else
		{
			Debug.LogError("[CRIWARE] Internal: CriAtomEx3dTranceiver is not created correctly.", this);
		}
	}

	public override void CriInternalUpdate()
	{
	}

	public override void CriInternalLateUpdate()
	{
		ApplyCurrentPosition();
	}

	private void ApplyCurrentPosition()
	{
		if (!isInitialized || transceiverHn == null)
		{
			return;
		}
		Vector3 position = base.transform.position;
		Vector3 forward = base.transform.forward;
		Vector3 up = base.transform.up;
		transceiverHn.SetOutputPosition(position);
		transceiverHn.SetOutputOrientation(forward, up);
		if (useDedicatedInput)
		{
			if (dedicatedInput != null)
			{
				Transform transform = dedicatedInput.transform;
				inputPos = transform.position;
				inputFront = transform.forward;
				inputUp = transform.up;
			}
			else
			{
				if (!dedicatedInputNotSetWarned)
				{
					Debug.LogWarning("[CRIWARE] " + GetType().ToString() + " : dedicated input is not specified. The output object will also be used as input.", this);
					dedicatedInputNotSetWarned = true;
				}
				inputPos = position;
				inputFront = -forward;
				inputUp = up;
			}
		}
		else
		{
			inputPos = position;
			inputFront = -forward;
			inputUp = up;
		}
		transceiverHn.SetInputPosition(inputPos);
		transceiverHn.SetInputOrientation(inputFront, inputUp);
		transceiverHn.Update();
	}

	private void ApplyParameters()
	{
		if (isInitialized && transceiverHn != null)
		{
			transceiverHn.SetOutputVolume(outputVolume);
			transceiverHn.SetInputCrossFadeField(directAudioRadius, crossFadeDistance);
			transceiverHn.SetOutputConeParameter(coneInsideAngle, coneOutsideAngle, coneOutsideVolume);
			transceiverHn.SetOutputInteriorPanField(transceiverRadius, interiorDistance);
			transceiverHn.SetOutputMinMaxDistance(minAttenuation, maxAttenuation);
			if (!string.IsNullOrEmpty(globalAisacName))
			{
				transceiverHn.AttachAisac(globalAisacName);
			}
			transceiverHn.SetMaxAngleAisacDelta(maxAngleAisacDelta);
			TrySetAisacControlId(distanceAisacControlId, transceiverHn.SetDistanceAisacControlId);
			TrySetAisacControlId(listenerAzimuthAisacControlId, transceiverHn.SetListenerBasedAzimuthAngleAisacControlId);
			TrySetAisacControlId(listenerElevationAisacControlId, transceiverHn.SetListenerBasedElevationAngleAisacControlId);
			TrySetAisacControlId(outputAzimuthAisacControlId, transceiverHn.SetTransceiverOutputBasedAzimuthAngleAisacControlId);
			TrySetAisacControlId(outputElevationAisacControlId, transceiverHn.SetTransceiverOutputBasedElevationAngleAisacControlId);
			transceiverHn.Update();
		}
	}

	private void TrySetAisacControlId(string strId, SetControlIdMethod callback)
	{
		if (!string.IsNullOrEmpty(strId))
		{
			if (ushort.TryParse(strId, out var result))
			{
				callback(result);
			}
			else
			{
				Debug.LogError("[CRIWARE] " + GetType().ToString() + " : invalid AISAC control ID.", this);
			}
		}
	}
}
