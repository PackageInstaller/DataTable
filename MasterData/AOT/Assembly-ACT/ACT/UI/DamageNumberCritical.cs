using ACT.MultiPlayer;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class DamageNumberCritical : DamageNumberStyle
{
	[SerializeField]
	private RectTransform criticalIconRoot;

	[SerializeField]
	private Image criticalIcon1;

	[SerializeField]
	private Image criticalIcon2;

	[SerializeField]
	private DamageNumberWeakEffect weakEffect;

	[SerializeField]
	private DamageNumberCriticalEffect criticalEffect;

	private const float CriticalIconOffset = 40f;

	public override void Init(CmdDamageNumber cmd, DamageNumberConfig config)
	{
	}
}
