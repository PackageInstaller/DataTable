using System.Collections.Generic;
using Ase;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

public class StatSubInfoView : UIBehaviour
{
	[SerializeField]
	private TextMeshProUGUI tmp_damageName;

	[SerializeField]
	private TextMeshProUGUI tmp_damageValue;

	[SerializeField]
	private TextMeshProUGUI tmp_tenacityName;

	[SerializeField]
	private TextMeshProUGUI tmp_tenacityValue;

	public virtual void OnReset()
	{
		TextMeshProUGUI obj = tmp_damageName;
		if (obj != null)
		{
			((TMP_Text)obj).SetText(string.Empty, true);
		}
		TextMeshProUGUI obj2 = tmp_damageValue;
		if (obj2 != null)
		{
			((TMP_Text)obj2).SetText("0", true);
		}
		TextMeshProUGUI obj3 = tmp_tenacityName;
		if (obj3 != null)
		{
			((TMP_Text)obj3).SetText(string.Empty, true);
		}
		TextMeshProUGUI obj4 = tmp_tenacityValue;
		if (obj4 != null)
		{
			((TMP_Text)obj4).SetText("0", true);
		}
	}

	public void SetShowName(string name)
	{
		((TMP_Text)tmp_damageName).SetText(name + "伤害", true);
		((TMP_Text)tmp_tenacityName).SetText(name + "削韧", true);
	}

	public virtual void UpdateStatInfo(EntityStatInfo info)
	{
		TextMeshProUGUI obj = tmp_damageValue;
		if (obj != null)
		{
			((TMP_Text)obj).SetText(info.Damage.ToString(), true);
		}
		TextMeshProUGUI obj2 = tmp_tenacityValue;
		if (obj2 != null)
		{
			((TMP_Text)obj2).SetText(info.Tenacity.ToString(), true);
		}
	}

	public virtual void UpdateStatInfo(List<EntityStatInfo> list)
	{
		float num = 0f;
		float num2 = 0f;
		foreach (EntityStatInfo item in list)
		{
			num += item.Damage;
			num2 += item.Tenacity;
		}
		TextMeshProUGUI obj = tmp_damageValue;
		if (obj != null)
		{
			((TMP_Text)obj).SetText(num.ToString(), true);
		}
		TextMeshProUGUI obj2 = tmp_tenacityValue;
		if (obj2 != null)
		{
			((TMP_Text)obj2).SetText(num2.ToString(), true);
		}
	}

	public virtual void OnResetValue()
	{
		TextMeshProUGUI obj = tmp_damageValue;
		if (obj != null)
		{
			((TMP_Text)obj).SetText("0", true);
		}
		TextMeshProUGUI obj2 = tmp_tenacityValue;
		if (obj2 != null)
		{
			((TMP_Text)obj2).SetText("0", true);
		}
	}
}
