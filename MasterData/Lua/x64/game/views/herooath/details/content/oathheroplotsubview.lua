local OathHeroPlotSubView = class("OathHeroPlotSubView", BaseView)

function OathHeroPlotSubView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.items = {}

	self:BindCfgUI()
end

function OathHeroPlotSubView:OnEnter()
	SetActive(self.gameObject_, true)
end

function OathHeroPlotSubView:OnExit()
	SetActive(self.gameObject_, false)
end

function OathHeroPlotSubView:Dispose()
	if self.items then
		for iter_4_0, iter_4_1 in pairs(self.items) do
			iter_4_1:Dispose()
			Object.Destroy(iter_4_1.gameObject_)
		end
	end

	self.items = nil
end

local function var_0_1(arg_5_0, arg_5_1)
	for iter_5_0 = arg_5_0.list_.childCount + 1, arg_5_1 do
		local var_5_0 = Object.Instantiate(arg_5_0.itemPrefab_, arg_5_0.list_)
	end

	for iter_5_1 = 1, arg_5_0.list_.childCount do
		arg_5_0.items[iter_5_1] = arg_5_0.items[iter_5_1] or OathHeroPlotSubView.PlotItem.New(arg_5_0.list_:GetChild(iter_5_1 - 1).gameObject)

		arg_5_0.items[iter_5_1]:SetIsShow(iter_5_1 <= arg_5_1)
	end
end

function OathHeroPlotSubView:RefreshUI(arg_6_1)
	local var_6_0 = self:GetAllPlots(arg_6_1)

	var_0_1(self, #var_6_0)

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		self.items[iter_6_0]:SetData(iter_6_1)
	end
end

function OathHeroPlotSubView:GetAllPlots(arg_7_1)
	return WeddingNewsCfg.get_id_list_by_hero[arg_7_1]
end

local OathHeroPlotItem = class("OathHeroPlotItem", BaseView)

OathHeroPlotSubView.PlotItem = OathHeroPlotItem

function OathHeroPlotItem:Ctor(arg_8_1)
	self.gameObject_ = arg_8_1
	self.transform_ = arg_8_1.transform

	self:BindCfgUI()

	self.unlockController = self.controllers_:GetController("unlock")
end

function OathHeroPlotItem:SetData(arg_9_1)
	local var_9_0 = WeddingNewsCfg[arg_9_1]
	local var_9_1 = OathTools.IsCharaSecretUnlocked(arg_9_1)

	self.unlockController:SetSelectedState(var_9_1 and "true" or "false")

	if var_9_1 then
		self.desc_.text = GetI18NText(var_9_0.desc)
	else
		self.lockCondition_.text = self:GetUnlockCondition(var_9_0.condition)
	end
end

function OathHeroPlotItem:SetIsShow(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

local function var_0_3(arg_11_0)
	if ConditionCfg[arg_11_0] then
		return GetI18NText(ConditionCfg[arg_11_0].desc)
	end
end

function OathHeroPlotItem:GetUnlockCondition(arg_12_1)
	if arg_12_1 == nil or #arg_12_1 == 0 then
		return ""
	end

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_1 = var_0_3(iter_12_1)

		if var_12_1 and var_12_1 ~= "" then
			table.insert(var_12_0, var_12_1)
		end
	end

	return table.concat(var_12_0, "\n")
end

return OathHeroPlotSubView
