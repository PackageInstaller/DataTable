local EnchantmentStageItem = class("EnchantmentStageItem", ReduxView)
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

function EnchantmentStageItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.onClick_ = arg_1_2

	self:Init()
end

function EnchantmentStageItem:Init()
	self:BindCfgUI()
	self:AddUIListener()
end

function EnchantmentStageItem:AddUIListener()
	self:AddBtnListener(self.selectBtn_, nil, function()
		if self.onClick_ then
			self.onClick_()
		end
	end)
end

function EnchantmentStageItem:SetData(arg_5_1, arg_5_2)
	self.bg1_.sprite = getSprite("Atlas/EnchantmentStageAtlas", var_0_2[arg_5_2])
	self.bg2_.sprite = getSprite("Atlas/EnchantmentStageAtlas", var_0_2[arg_5_2])
	self.bg3_.sprite = getSprite("Atlas/EnchantmentStageAtlas", var_0_2[arg_5_2])
	self.bossImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/EnchantmentStage/" .. BattleEnchantmentStageCfg[arg_5_1].hd_image)
	self.rareTagImg_.sprite = pureGetSpriteWithoutAtlas("I18NImg/BattleStage/" .. var_0_1[arg_5_2])
	self.buff_ = getHeroAffixs(BattleEnchantmentStageCfg[arg_5_1].affix_type)
	self.buffImg_.sprite = self.buff_ and self.buff_ ~= "" and self.buff_[1] and getAffixSprite(self.buff_[1]) or nil
	self.debuff_ = BattleEnchantmentStageCfg[arg_5_1].affix_type_in_map == "" and getMosterAffix(BattleEnchantmentStageCfg[arg_5_1].affix_type) or BattleEnchantmentStageCfg[arg_5_1].affix_type_in_map
	self.debuffImg_.sprite = self.debuff_ and self.debuff_ ~= "" and self.debuff_[1] and getAffixSprite(self.debuff_[1]) or nil
	self.stageID_ = arg_5_1
end

function EnchantmentStageItem:Dispose()
	EnchantmentStageItem.super.Dispose(self)
end

return EnchantmentStageItem
