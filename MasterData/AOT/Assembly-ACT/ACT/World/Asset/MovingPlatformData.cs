using System;
using ACT.Battle;
using ACT.Config;
using ACT.Sound;
using ACT.World.StateObject;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class MovingPlatformData : StateWorldAssetData
{
	[SerializeField]
	private YooAssetReference _addressAssetID;

	[SerializeField]
	private YooAssetReference _modelAssetID;

	[SerializeField]
	private int _initialStateId;

	[SerializeField]
	private MovingPlatformRunMode _runMode;

	[SerializeField]
	private bool _manualSequentialMove = true;

	[SerializeField]
	private int _initialPointIndex;

	[SerializeField]
	private MovingPlatformLinkObjects[] _linkObjects;

	[SerializeField]
	private MovingPlatformPoint[] _runningPoints;

	[SerializeField]
	[Header("交互入口配置")]
	private InteractEntry _entryConfig;

	[SerializeField]
	[Header("交互提示位置")]
	private Pos _tipIconPos;

	[SerializeField]
	[Header("交互范围")]
	private BoxColliderParameters _triggerField;

	[SerializeField]
	private PushImpetusData _pushImpetusData;

	[SerializeField]
	[Header("开始运行音效")]
	private AudioEventReference _audioStartSound;

	[SerializeField]
	[Header("停止运行音效")]
	private AudioEventReference _audioStopSound;

	[SerializeField]
	[Header("运行中音效")]
	private AudioEventReference _audioRunLoopSound;

	public AudioEventReference AudioStartSound => _audioStartSound;

	public AudioEventReference AudioStopSound => _audioStopSound;

	public AudioEventReference AudioRunLoopSound => _audioRunLoopSound;

	public PushImpetusData PushImpetusData => _pushImpetusData;

	public BoxColliderParameters TriggerField => _triggerField;

	public Pos TipIconPos => _tipIconPos;

	public InteractEntry entryConfig => _entryConfig;

	public MovingPlatformRunMode runMode => _runMode;

	public bool manualSequentialMove => _manualSequentialMove;

	public YooAssetReference modelAssetID => _modelAssetID;

	public int initialPointIndex => _initialPointIndex;

	public MovingPlatformPoint[] runningPoints => _runningPoints;

	public override YooAssetReference addressAssetID => _addressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => _initialStateId;

	public MovingPlatformLinkObjects[] LinkObjects => _linkObjects;

	public bool IsValidStateId(int stateId)
	{
		if (_runMode != MovingPlatformRunMode.Auto)
		{
			if (0 <= stateId)
			{
				return stateId < _runningPoints.Length;
			}
			return false;
		}
		if (stateId >= 0)
		{
			return stateId <= 2;
		}
		return false;
	}
}
