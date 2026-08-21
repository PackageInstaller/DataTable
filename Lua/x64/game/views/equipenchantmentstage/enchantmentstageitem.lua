local var_0_0 = class("EnchantmentStageItem", ReduxView)
local var_0_1 = {
	"icon_ee_boss_b",
	"icon_ee_boss_a",
	"icon_ee_boss_s"
}
local var_0_2 = {
	"bg_ee_boss_b",
	"bg_ee_boss_a",
	"bg_ee_boss_s"
}

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.onClick_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.selectBtn_, nil, function()
		if arg_3_0.onClick_ then
			arg_3_0.onClick_()
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.bg1_.sprite = getSprite("Atlas/EnchantmentStageAtlas", var_0_2[arg_5_2])
	arg_5_0.bg2_.sprite = getSprite("Atlas/EnchantmentStageAtlas", var_0_2[arg_5_2])
	arg_5_0.bg3_.sprite = getSprite("Atlas/EnchantmentStageAtlas", var_0_2[arg_5_2])
	arg_5_0.bossImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EnchantmentStage/" .. BattleEnchantmentStageCfg[arg_5_1].hd_image)
	arg_5_0.rareTagImg_.sprite = pureGetSpriteWithoutAtlas("I18NImg/BattleStage/" .. var_0_1[arg_5_2])
	arg_5_0.buff_ = getHeroAffixs(BattleEnchantmentStageCfg[arg_5_1].affix_type)

	if arg_5_0.buff_ and arg_5_0.buff_ ~= "" and arg_5_0.buff_[1] then
		arg_5_0.buffImg_.sprite = getAffixSprite(arg_5_0.buff_[1])
	else
		arg_5_0.buffImg_.sprite = nil
	end

	arg_5_0.debuff_ = BattleEnchantmentStageCfg[arg_5_1].affix_type_in_map == "" and getMosterAffix(BattleEnchantmentStageCfg[arg_5_1].affix_type) or BattleEnchantmentStageCfg[arg_5_1].affix_type_in_map

	if arg_5_0.debuff_ and arg_5_0.debuff_ ~= "" and arg_5_0.debuff_[1] then
		arg_5_0.debuffImg_.sprite = getAffixSprite(arg_5_0.debuff_[1])
	else
		arg_5_0.debuffImg_.sprite = nil
	end

	arg_5_0.stageID_ = arg_5_1
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
