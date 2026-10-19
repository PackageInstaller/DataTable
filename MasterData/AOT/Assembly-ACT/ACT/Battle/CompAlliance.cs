using System;

namespace ACT.Battle;

public class CompAlliance : EcsComponent, IEquatable<CompAlliance>
{
	public Alliance alliance;

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		alliance = Alliance.Character;
	}

	public static Alliance GetOp(Alliance a)
	{
		return Alliance.All ^ a;
	}

	public bool Equals(CompAlliance other)
	{
		if ((object)other == null || !other.owner.IsValid || !owner.IsValid)
		{
			return false;
		}
		return alliance == other.alliance;
	}

	public static bool operator ==(CompAlliance left, CompAlliance right)
	{
		return left?.Equals(right) ?? false;
	}

	public static bool operator !=(CompAlliance left, CompAlliance right)
	{
		return left?.Equals(right) ?? false;
	}
}
