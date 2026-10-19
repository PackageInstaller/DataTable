using ACT.MultiPlayer;
using UnityEngine;

namespace ACT.UI;

public class DamageNumberNormal : DamageNumberStyle
{
	[SerializeField]
	private DamageNumberWeakEffect weakEffect;

	public override void Init(CmdDamageNumber cmd, DamageNumberConfig config)
	{
	}
}
