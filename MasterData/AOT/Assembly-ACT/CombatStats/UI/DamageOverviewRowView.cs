using ACT.Core;
using ACT.Utility;
using CombatStats.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace CombatStats.UI;

public sealed class DamageOverviewRowView : MonoBehaviour
{
	[SerializeField]
	private LocalizeStringEvent nameText;

	[SerializeField]
	private TextMeshProUGUI damageText;

	[SerializeField]
	private TextMeshProUGUI dpsText;

	[SerializeField]
	private TextMeshProUGUI hitsText;

	[SerializeField]
	private TextMeshProUGUI critsText;

	[SerializeField]
	private TextMeshProUGUI critRateText;

	[SerializeField]
	private TextMeshProUGUI shareText;

	[SerializeField]
	private RectTransform slider;

	[SerializeField]
	private Image sliderFill;

	public void Bind(CharacterDamageRowSnapshot snapshot)
	{
		if (nameText != null)
		{
			nameText.StringReference.TableEntryReference = snapshot.CharacterNameId;
		}
		if (damageText != null)
		{
			damageText.text = snapshot.TotalDamage.ToString();
		}
		if (dpsText != null)
		{
			dpsText.SetText("{0:0}", snapshot.Dps);
		}
		if (hitsText != null)
		{
			hitsText.SetText("{0:0}", snapshot.HitCount);
		}
		if (critsText != null)
		{
			critsText.SetText("{0:0}", snapshot.CritCount);
		}
		if (critRateText != null)
		{
			critRateText.SetText("{0:0.0}%", snapshot.CritRate * 100f);
		}
		if (shareText != null)
		{
			shareText.SetText("{0:0.0}%", snapshot.DamageShare * 100f);
		}
		if (slider != null)
		{
			slider.anchorMax = new Vector2(snapshot.DamageShareOfTop, slider.anchorMax.y);
		}
		if (sliderFill != null)
		{
			sliderFill.color = GameUtility.GetCharacterElementColor((Element)snapshot.DamageType);
		}
	}
}
