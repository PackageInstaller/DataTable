namespace ACT.MultiPlayer;

public struct CmdDoActions
{
	public uint caster;

	public uint target;

	public int ability;

	public int action;

	public override string ToString()
	{
		return $"caster:{caster} targtet:{target} ability:{ability} action:{action}";
	}
}
