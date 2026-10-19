using System;
using Bamboo.ECS;

namespace ACT.Battle;

[Serializable]
public struct PushImpetusData
{
	public bool customDirection;

	public float pushImpetusBase;

	public uint pushImpetusCurve;

	[NonSerialized]
	public Entity otherEntity;

	[NonSerialized]
	public bool isGameObject;

	public PushDirection direction;
}
