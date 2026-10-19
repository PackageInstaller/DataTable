using ACT.MultiPlayer;

namespace ACT.UI;

public class DamageNumberSacrifice : DamageNumberStyle
{
	public override void Init(CmdDamageNumber cmd, DamageNumberConfig config)
	{
		base.Init(cmd, config);
		ApplyDamageNum(_config.sacrificeSprites, setColor: true, _config.sacrificeColor);
	}
}
