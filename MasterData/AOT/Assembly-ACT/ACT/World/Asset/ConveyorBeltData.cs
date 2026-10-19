using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Sound;
using FMODUnity;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class ConveyorBeltData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	[SerializeField]
	public YooAssetReference conveyorBeltAddressAssetID;

	public Pos startPos;

	public Pos endPos;

	public List<StateWorldUid> linkStateComps;

	public float velocity;

	[SerializeField]
	private EventReference _runLoopEvent;

	[SerializeField]
	private EventReference _stopLoopEvent;

	[SerializeField]
	private EventReference _changeEvent;

	[SerializeField]
	private AudioEventReference _audioRunLoopEvent;

	[SerializeField]
	private AudioEventReference _audioStopLoopEvent;

	[SerializeField]
	private AudioEventReference _audioChangeEvent;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public EventReference RunLoopEvent => _runLoopEvent;

	public EventReference StopLoopEvent => _stopLoopEvent;

	public EventReference ChangeEvent => _changeEvent;

	public AudioEventReference AudioRunLoopEvent => _audioRunLoopEvent;

	public AudioEventReference AudioStopLoopEvent => _audioStopLoopEvent;

	public AudioEventReference AudioChangeEvent => _audioChangeEvent;

	public override void Bake(object assetComp)
	{
	}
}
