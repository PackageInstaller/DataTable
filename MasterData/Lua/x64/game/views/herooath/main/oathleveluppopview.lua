local OathLevelUpPopView = class("OathLevelUpPopView", ReduxView)

function OathLevelUpPopView:UIName()
	return "Widget/System/Hero_Oath/OathCaptureView/HeroOathlvlpopUI"
end

function OathLevelUpPopView:UIParent()
	return manager.ui.uiPop.transform
end

local var_0_1 = {
	ONLY_SHOW_IN_LEVEL_UP_POP = 1,
	ONLY_SHOW_IN_RIGHT_DETAIL_POP = 0,
	ALL = 2
}

function OathLevelUpPopView:Init()
	self.items = {}

	self:BindCfgUI()
	self:AddUIListeners()
end

function OathLevelUpPopView:Dispose()
	self:RemoveAllListeners()

	if self.items then
		for iter_4_0, iter_4_1 in pairs(self.items) do
			iter_4_1:Dispose()
			Object.Destroy(iter_4_1.gameObject_)
		end
	end

	OathLevelUpPopView.super.Dispose(self)
end

local function var_0_2(arg_5_0, arg_5_1)
	for iter_5_0 = arg_5_0.list_.childCount + 1, arg_5_1 do
		local var_5_0 = Object.Instantiate(arg_5_0.itemPrefab_, arg_5_0.list_)
	end

	for iter_5_1 = 1, arg_5_0.list_.childCount do
		arg_5_0.items[iter_5_1] = arg_5_0.items[iter_5_1] or OathLevelUpPopView.Item.New(arg_5_0.list_:GetChild(iter_5_1 - 1).gameObject)

		arg_5_0.items[iter_5_1]:SetIsShow(iter_5_1 <= arg_5_1)
	end
end

function OathLevelUpPopView:OnEnter()
	local var_6_0 = self.params_.prevLevel or self.params_.level - 1

	self.prevLevel_.text = OathTools.GetOathLvShowTips(var_6_0) or ""
	self.curLevel_.text = OathTools.GetOathLvShowTips(self.params_.level)

	local var_6_2 = self:CalcLevelUpUnlockedRight(self.params_.heroID, self.params_.level, var_6_0)

	var_0_2(self, #var_6_2)

	for iter_6_0, iter_6_1 in ipairs(var_6_2) do
		self.items[iter_6_0]:SetData(iter_6_1)
	end
end

function OathLevelUpPopView:OnExit()
	OathCollectionContentData:OnLevelUpdateMsgRead(self.params_.heroID)
end

function OathLevelUpPopView:AddUIListeners()
	self:AddBtnListener(self.maskBtn_, nil, JumpTools.Back)
end

function OathLevelUpPopView:CalcLevelUpUnlockedRight(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = {}

	if WeddingRightCfg.get_id_list_by_hero_id[arg_9_1] then
		for iter_9_0, iter_9_1 in ipairs(WeddingRightCfg.get_id_list_by_hero_id[arg_9_1]) do
			local var_9_1 = WeddingRightCfg[iter_9_1]

			if WeddingRightCfg[iter_9_1].is_show ~= var_0_1.ONLY_SHOW_IN_RIGHT_DETAIL_POP and arg_9_3 < var_9_1.level and arg_9_2 >= var_9_1.level then
				table.insert(var_9_0, iter_9_1)
			end
		end
	end

	return var_9_0
end

local OathLevelUpRightItem = class("OathLevelUpRightItem", BaseView)

OathLevelUpPopView.Item = OathLevelUpRightItem

function OathLevelUpRightItem:Ctor(arg_10_1)
	self.gameObject_ = arg_10_1
	self.transform_ = arg_10_1.transform

	self:BindCfgUI()
end

function OathLevelUpRightItem:SetData(arg_11_1)
	self.desc_.text = WeddingRightCfg[arg_11_1].desc
end

function OathLevelUpRightItem:SetIsShow(arg_12_1)
	SetActive(self.gameObject_, arg_12_1)
end

return OathLevelUpPopView
