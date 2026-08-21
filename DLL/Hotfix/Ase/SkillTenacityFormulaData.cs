namespace Ase;

public class SkillTenacityFormulaData : FormulaZoneDataBase
{
	public bool isHitWeak;

	public float bulletTenacity;

	public float talentTenacity;

	public float techTenacity;

	public float weakTenacity;

	public float siteAddition;

	public float fixedTenacity;

	public float talentFixedTenacity;

	public float weaknessTenacityAddition;

	public override string FormulaDataName => "技能削韧乘区";

	public override void OnFormulaSettlement()
	{
		base.result = bulletTenacity * talentTenacity * techTenacity + fixedTenacity * talentFixedTenacity;
	}

	public override string ToString()
	{
		if (isHitWeak)
		{
			return $"{FormulaDataName}的最终数据: 子弹削韧系数({bulletTenacity}) * 燃点等级削韧系数({talentTenacity}) * [是否命中破绽({isHitWeak}):削韧技巧系数({techTenacity}) = 破绽削韧系数({weakTenacity}) + 部位削韧加成({siteAddition})] + 固定削韧系数({fixedTenacity}) * 燃点等级固定削韧系数({talentFixedTenacity}) = {base.result}";
		}
		return $"{FormulaDataName}的最终数据: 子弹削韧系数({bulletTenacity}) * 燃点等级削韧系数({talentTenacity}) * [是否命中破绽({isHitWeak}):削韧技巧系数({techTenacity})] + 固定削韧系数({fixedTenacity}) * 燃点等级固定削韧系数({talentFixedTenacity}) = {base.result}";
	}
}
