using System;
using Bamboo.ECS;

namespace ACT.Battle;

public class EvtBattleChange : BaseEvt
{
	[Flags]
	public enum ChangeCharacterSource
	{
		PlayerChange = 2,
		UIChange = 4,
		Dialogue = 8,
		Die = 0x10,
		PlayerAssistChange = 0x20
	}

	public Entity last;

	public Entity next;

	public ChangeCharacterSource source;

	public Entity GetLastEntityBehave()
	{
		return last;
	}

	public Entity GetNextEntityBehave()
	{
		return next;
	}

	public override void Reset()
	{
		last = default;
		next = default;
	}
}
