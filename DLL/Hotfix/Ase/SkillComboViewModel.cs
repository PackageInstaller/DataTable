using System.Text.RegularExpressions;

namespace Ase;

public class SkillComboViewModel : OptionBase
{
	private bool selectSkill;

	private bool finishSkill;

	private bool failSkill;

	private bool chargeStart;

	private string skillDes1;

	private string skillDes2;

	private string skillIcon;

	private float chargeFillAmount;

	private int skillId;

	public bool SelectSkill
	{
		get
		{
			return selectSkill;
		}
		set
		{
			Set(ref selectSkill, value, "SelectSkill");
		}
	}

	public bool FinishSkill
	{
		get
		{
			return finishSkill;
		}
		set
		{
			Set(ref finishSkill, value, "FinishSkill");
		}
	}

	public bool FailSkill
	{
		get
		{
			return failSkill;
		}
		set
		{
			Set(ref failSkill, value, "FailSkill");
		}
	}

	public string SkillDes => skillDes1;

	public string SkillDes2 => skillDes2;

	public string SkillIcon => skillIcon;

	public float ChargeFillAmount
	{
		get
		{
			return chargeFillAmount;
		}
		set
		{
			Set(ref chargeFillAmount, value, "ChargeFillAmount");
		}
	}

	public bool ChargeStart
	{
		get
		{
			return chargeStart;
		}
		set
		{
			Set(ref chargeStart, value, "ChargeStart");
		}
	}

	public int SkillId => skillId;

	public SkillComboViewModel(int skillId, float skillChargeTime, string btnText)
	{
		this.skillId = skillId;
		DRHeroSKillConfig dataRow = GameEntry.DataTable.GetDataRow<DRHeroSKillConfig>(skillId);
		skillDes1 = Regex.Replace(btnText, "<.*?>", string.Empty);
		skillDes2 = btnText;
		skillIcon = dataRow.Icon;
	}
}
