using System;
using Bamboo.ECS;

namespace ACT.MultiPlayer;

public struct MPAbility : IEquatable<MPAbility>
{
	public int id;

	public MPSkill skillLevel;

	public Entity caster;

	public EntityId owner;

	public byte stack;

	public bool Equals(MPAbility other)
	{
		return id == other.id;
	}
}
