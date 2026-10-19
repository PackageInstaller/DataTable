using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行控制MagicaCloths", "Action", new string[] { "control", "magica", "cloths", "state", "status", "tag" })]
public class ActionControlMagicaCloths : ConfigAction
{
	public bool enable;

	public override void Do(ActionMemory memory)
	{
		MonoMagicaCloth monoMagicaCloth = memory.target.entity.GetMono().monoMagicaCloth;
		if (monoMagicaCloth != null)
		{
			monoMagicaCloth.Control(enable);
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
	}
}
