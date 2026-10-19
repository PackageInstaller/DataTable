using Fundamental;

namespace ACT.Battle.Configs;

public class CheckIsProtagonist : ConfigPredicate
{
	public override bool Check(ActionMemory memory)
	{
		return Singleton<ProtagonistManager>.instance.IsProtagonist;
	}
}
