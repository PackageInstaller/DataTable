local DormLevelAwardItem = class("DormLevelAwardItem", ReduxView)

function DormLevelAwardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function DormLevelAwardItem:Init()
	self:InitUI()

	self.selController = ControllerUtil.GetController(self.transform_, "selectItem")
end

function DormLevelAwardItem:InitUI()
	self:BindCfgUI()
end

function DormLevelAwardItem:RefreshUI(arg_4_1, arg_4_2, arg_4_3)
	self.index = arg_4_2
	self.levelText.text = string.format(GetTips("DORM_LEVEL_TIPS"), arg_4_2)
	self.rewardItemList_ = {}

	local var_4_0 = ""

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if BackHomeDormLevelRewardCfg[iter_4_1].type == 3 then
			table.insert(self.rewardItemList_, BackHomeDormLevelRewardCfg[iter_4_1].reward)
		elseif BackHomeDormLevelRewardCfg[iter_4_1].type == 1 then
			var_4_0 = var_4_0 .. string.format(GetTips("DORM_LEVEL_AWARD_ATTRIB"), GetI18NText(PublicAttrCfg[BackHomeDormLevelRewardCfg[iter_4_1].reward[1]].name), BackHomeDormLevelRewardCfg[iter_4_1].reward[2]) .. "\n"
		elseif BackHomeDormLevelRewardCfg[iter_4_1].type == 2 then
			var_4_0 = var_4_0 .. string.format(GetTips("DORM_LEVEL_AWARD_VOICE"), (GetI18NText(HeroVoiceCfg[BackHomeDormLevelRewardCfg[iter_4_1].reward[1]].title))) .. "\n"
		end
	end

	self.decText.text = var_4_0 .. string.format(GetTips("DORM_FATIGUE_BASE_INFO"), GameSetting.dorm_fatigue_increase.value[arg_4_2][2] / 100 * (3600 / GameSetting.dorm_fatigue_time.value[1]))

	if self.index == arg_4_3 then
		self.selController:SetSelectedState("select")
	else
		self.selController:SetSelectedState("normal")
	end
end

function DormLevelAwardItem:Dispose()
	if self.itemList then
		for iter_5_0, iter_5_1 in ipairs(self.itemList) do
			iter_5_1:Dispose()
		end
	end

	DormLevelAwardItem.super.Dispose(self)
end

return DormLevelAwardItem
