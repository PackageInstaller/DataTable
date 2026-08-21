using System;

namespace civilization;

[Serializable]
public enum FactorType
{
	Target_Skill_Cost_Sub = 1,
	Food_Zero_Bonus,
	Food_Bonus,
	Free_Skill,
	Get_Source_By_Other,
	Get_Source_By_Buildings,
	Kill_Beast,
	Free_Target_Skill,
	Skill_Move_Fast,
	Bom_Bonus,
	Unlock_Skill,
	Max_Lv_Change,
	Min_Lv_Change,
	Skill_Swap,
	Skill_Cost_Change,
	No_Beast,
	Move_Fast,
	Win
}
