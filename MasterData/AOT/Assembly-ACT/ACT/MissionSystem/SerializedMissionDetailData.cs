using System;

namespace ACT.MissionSystem;

[Serializable]
public class SerializedMissionDetailData
{
	public SerializedMissionStage accept;

	public SerializedMissionStage failure;

	public SerializedMissionStage extra;

	public SerializedMissionStage start;

	public SerializedMissionStage[] flows;
}
