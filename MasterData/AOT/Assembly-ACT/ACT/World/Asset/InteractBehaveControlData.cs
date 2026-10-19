using System;
using System.Collections.Generic;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class InteractBehaveControlData : StateWorldAssetData
{
	[SerializeField]
	internal int m_initialStateId = -1;

	public BehaveType behaveType = BehaveType.PointMove;

	[SerializeReference]
	public BehaveConfig behaveConfig;

	public TargetType targetType;

	public List<EventInfo> behavePosInfos;

	[Tooltip("不勾选代表出生时朝右，勾选代表出生时朝左")]
	public bool isLeft = true;

	[HideInInspector]
	public string entityConfigPath;

	public override bool isStatic => false;

	public override YooAssetReference addressAssetID => GameLoader.meta?.interactBehaveControlReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public override LoadTiming loadTiming => LoadTiming.AfterSceneLoad;
}
