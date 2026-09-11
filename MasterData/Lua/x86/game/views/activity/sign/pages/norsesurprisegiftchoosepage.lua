local NorseSurpriseGiftChoosePage = class("NorseSurpriseGiftChoosePage", ReduxView)

function NorseSurpriseGiftChoosePage:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftChooseUI"
end

function NorseSurpriseGiftChoosePage:UIParent()
	return manager.ui.uiPop.transform
end

function NorseSurpriseGiftChoosePage:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, NorseSurpriseGiftChooseItem)
	self.stateCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function NorseSurpriseGiftChoosePage:indexItem(arg_4_1, arg_4_2)
	HeroLongHead.SetProxy(arg_4_2, self.heroDataProxy)
	arg_4_2:SetData(self.heroList[arg_4_1])

	if self.heartList and #self.heartList > 0 then
		arg_4_2:SetHeart(self.heartList)
	end

	if self.deleteList and #self.deleteList > 0 then
		arg_4_2:SetDelete(self.deleteList)
	end

	if self.drawList and #self.drawList > 0 then
		arg_4_2:SetDraw(self.drawList)
	end

	if self.result_role_id then
		arg_4_2:SetResultRoleId(self.result_role_id)
	end
end

function NorseSurpriseGiftChoosePage:AddListeners()
	self:AddBtnListener(self.btnClose_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btnAll_, nil, function()
		self.heroList = GameSetting.activity_optional_random_role_list.value
		self.heroList = self:SortList(self.heroList)

		self.uiList_:StartScroll(#self.heroList)
		self.stateCtrl:SetSelectedIndex(0)

		self.btnIndex = -1
	end)
	self:AddBtnListener(self.btn_0, nil, function()
		self:RefreshHeroList(0)
		self.stateCtrl:SetSelectedIndex(1)

		self.btnIndex = 0
	end)
	self:AddBtnListener(self.btn_2, nil, function()
		self:RefreshHeroList(2)
		self.stateCtrl:SetSelectedIndex(2)

		self.btnIndex = 2
	end)
	self:AddBtnListener(self.btn_4, nil, function()
		self:RefreshHeroList(4)
		self.stateCtrl:SetSelectedIndex(3)

		self.btnIndex = 4
	end)
	self:AddBtnListener(self.btn_14, nil, function()
		self:RefreshHeroList(14)
		self.stateCtrl:SetSelectedIndex(4)

		self.btnIndex = 14
	end)
	self:AddBtnListener(self.btn_10, nil, function()
		self:RefreshHeroList(10)
		self.stateCtrl:SetSelectedIndex(5)

		self.btnIndex = 10
	end)
	self:AddBtnListener(self.btn_12, nil, function()
		self:RefreshHeroList(12)
		self.stateCtrl:SetSelectedIndex(6)

		self.btnIndex = 12
	end)
	self:AddBtnListener(self.btn_6, nil, function()
		self:RefreshHeroList(6)
		self.stateCtrl:SetSelectedIndex(7)

		self.btnIndex = 6
	end)
	self:AddBtnListener(self.btn_8, nil, function()
		self:RefreshHeroList(8)
		self.stateCtrl:SetSelectedIndex(8)

		self.btnIndex = 8
	end)
end

function NorseSurpriseGiftChoosePage:SortList(arg_16_1)
	if arg_16_1 == nil then
		return {}
	end

	local var_16_0 = {}
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		local var_16_2 = {
			type = 6,
			id = iter_16_1
		}

		for iter_16_2, iter_16_3 in ipairs(self.deleteList) do
			if iter_16_1 == iter_16_3 then
				var_16_2.type = 5
			end
		end

		for iter_16_4, iter_16_5 in ipairs(self.drawList) do
			if iter_16_1 == iter_16_5 then
				var_16_2.type = 4
			end
		end

		for iter_16_6, iter_16_7 in ipairs(self.heartList) do
			if iter_16_1 == iter_16_7 and var_16_2.type == 4 then
				var_16_2.type = 2
			elseif iter_16_1 == iter_16_7 then
				var_16_2.type = 3
			end
		end

		if iter_16_1 == self.result_role_id then
			var_16_2.type = 1
		end

		table.insert(var_16_1, var_16_2)
	end

	table.sort(var_16_1, function(arg_17_0, arg_17_1)
		return arg_17_0.type < arg_17_1.type
	end)

	for iter_16_8, iter_16_9 in ipairs(var_16_1) do
		table.insert(var_16_0, iter_16_9.id)
	end

	return var_16_0
end

function NorseSurpriseGiftChoosePage:RefreshHeroList(arg_18_1)
	self.heroList = GameSetting.activity_optional_random_role_list.value

	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(self.heroList) do
		if HeroCfg[iter_18_1].ATK_attribute[1] == arg_18_1 then
			table.insert(var_18_0, iter_18_1)
		end
	end

	self.heroList = self:SortList(var_18_0)

	self.uiList_:StartScroll(#self.heroList)
end

function NorseSurpriseGiftChoosePage:OnEnter()
	NorseSurpriseGiftChoosePage.super.OnEnter(self)

	self.heartList = NorseSurpriseGiftReceiveData:GetChooseRoleData()
	self.deleteList = NorseSurpriseGiftReceiveData:GetDelRoleData()
	self.drawList = NorseSurpriseGiftReceiveData:GetDrawRoleData()
	self.result_role_id = NorseSurpriseGiftReceiveData:GetResultRoleId()

	if self.btnIndex and self.btnIndex >= 0 then
		self:RefreshHeroList(self.btnIndex)
	else
		self.heroList = GameSetting.activity_optional_random_role_list.value
		self.heroList = self:SortList(self.heroList)

		self.uiList_:StartScroll(#self.heroList)
		self.stateCtrl:SetSelectedIndex(0)
	end
end

function NorseSurpriseGiftChoosePage:OnExit()
	NorseSurpriseGiftChoosePage.super.OnExit(self)
end

function NorseSurpriseGiftChoosePage:Dispose()
	if self.heroDataProxy then
		self.heroDataProxy = nil
	end

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	NorseSurpriseGiftChoosePage.super.Dispose(self)
end

return NorseSurpriseGiftChoosePage
