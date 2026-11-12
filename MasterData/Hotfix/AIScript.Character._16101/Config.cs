namespace AIScript.Character._16101;

public static class Config
{
	public const string dropAlias_Res = "Drop_16101_Res";

	public const string dropAlias_ResNew = "Drop_16101_Res_P02";

	public const int buff_Res = 16100011;

	public const int maxRes = 20;

	public static readonly int hitTag_Normal = CommonHelper.StringToHash("16101_NormalAtk");

	public static readonly int hitTag_NormalSpecial = CommonHelper.StringToHash("16101_NormalAtk_Sp");

	public static readonly int hitTag_Normal_Res = CommonHelper.StringToHash("16101_NormalAtk_Res");

	public static readonly int hitTag_FWB_Probe = CommonHelper.StringToHash("16101_Camp_Sup_TanCha");

	public static readonly int hitTag_FWB_Probe_Strong = CommonHelper.StringToHash("16101_Camp_Sup_TanChaAddTag");

	public static readonly int hitTag_FWB_CeHui = CommonHelper.StringToHash("16101_Camp_Sup_CeHui");

	public static readonly int hitTag_FWB_Mark = CommonHelper.StringToHash("16101_FWB_Mark");

	public static readonly int hitTag_ChaCha = CommonHelper.StringToHash("16101_Camp_Sup_TanChaTag");

	public static readonly int hitTag_ChaCha_Damage = CommonHelper.StringToHash("16101_Camp_Sup_TanChaTag_Damage");

	public static readonly int hitTag_Skill = CommonHelper.StringToHash("16101_Skill");

	public static readonly int hitTag_Ultra = CommonHelper.StringToHash("16101_Ultra");

	public static readonly int hitTag_JuDian = CommonHelper.StringToHash("16101_Camp_Main");

	public const int buff_JuDian_P04 = 16104011;

	public const string logicTag_FangWeiBiaoLv = "161_FangWeiBiaoLv";

	public const string logicTag_JuDianCount = "161_JuDianCount";

	public const string areaEffect_FWB_CeHui = "AreaEffect_16101_CeHui";

	public static readonly int summonEvt = CommonHelper.StringToHash("summonEvt");

	public static readonly int summonFWBEvt = CommonHelper.StringToHash("summonFWBEvt");

	public static readonly int debuffP25Evt = CommonHelper.StringToHash("debuffP25Evt");

	public static readonly int playCeHuiEvt = CommonHelper.StringToHash("playCeHuiEvt");
}
