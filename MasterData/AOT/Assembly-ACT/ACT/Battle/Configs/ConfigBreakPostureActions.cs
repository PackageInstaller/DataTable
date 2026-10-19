using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigBreakPostureActions : LuminSerializedScriptableObject
{
	public bool allowNoWeak;

	public Dictionary<MonsterWeigtType, ActionChangeGlobalSpeed> breakPostureGlobalSpeeds = new Dictionary<MonsterWeigtType, ActionChangeGlobalSpeed>();

	public Dictionary<MonsterWeigtType, ActionCameraNoise> breakPostureCameraNoises = new Dictionary<MonsterWeigtType, ActionCameraNoise>();

	public Dictionary<EnemyRace, Dictionary<MonsterWeigtType, EnemyPostureHitEffectAndVoice>> PostureHitEffectAndVoiceDict = new Dictionary<EnemyRace, Dictionary<MonsterWeigtType, EnemyPostureHitEffectAndVoice>>();

	public Dictionary<EnemyRace, EnemyPostureHitEffectAndVoice> BossPostureHitEffectAndVoiceDict = new Dictionary<EnemyRace, EnemyPostureHitEffectAndVoice>();

	public YooAssetReference PostureBreakBossExtraEffect;

	[Header("战斗撞空气墙特效")]
	public YooAssetReference CollisionEffectL;

	public YooAssetReference CollisionEffectR;

	public Vector3 CollisionEffectOffset;
}
