using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class TrackTrapRound : TrapRound
{
	[SerializeField]
	[Header("生成落雷和角色之间的距离最小值")]
	private float _characterDisMin;

	[SerializeField]
	[Header("生成落雷和角色之间的距离最大值")]
	private float _characterDisMax;

	public float CharacterDisMin => _characterDisMin;

	public float CharacterDisMax => _characterDisMax;
}
