using UnityEngine;
using uLipSync;

namespace ACT.LipSync;

[CreateAssetMenu(menuName = "uLipSync/FMODLipSync Baked Data")]
public class ULipSyncBakeData : BakedData
{
	[Header("说话人")]
	public int speakerId;

	[Header("说话人是否是主角")]
	public bool speakerIsPlayer;

	[Header("语音事件文件名")]
	public string eventFileName;

	[Header("语音事件下标")]
	public int index;

	[Header("是否为抽卡固定语音")]
	public bool isGacha;
}
