using ACT.MultiPlayer;
using UnityEngine;

namespace ACT.UI;

public class DamageNumberHeal : DamageNumberStyle
{
	[SerializeField]
	private RectTransform criticalIconRoot;

	[SerializeField]
	private float offset = 20f;

	public override void Init(CmdDamageNumber cmd, DamageNumberConfig config)
	{
		base.Init(cmd, config);
		ApplyDamageNum(_config.healNumSprites);
		SetPlusTrans();
	}

	public void SetPlusTrans()
	{
		int damageNumDigits = GetDamageNumDigits(_damage, numImages.Length);
		criticalIconRoot.localPosition = new Vector3(numImages[damageNumDigits].rectTransform.localPosition.x + offset, criticalIconRoot.localPosition.y, criticalIconRoot.localPosition.z);
	}
}
