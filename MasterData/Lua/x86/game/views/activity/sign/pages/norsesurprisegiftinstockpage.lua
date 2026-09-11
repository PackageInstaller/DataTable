local NorseSurpriseGiftInStockPage = class("NorseSurpriseGiftInStockPage", ReduxView)

function NorseSurpriseGiftInStockPage:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftInStockUI"
end

function NorseSurpriseGiftInStockPage:UIParent()
	return manager.ui.uiPop.transform
end

function NorseSurpriseGiftInStockPage:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.listGo_, NorseSurpriseGiftInStockItem)
	self.stateCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("state")
	self.btnCtrl = self.transform_:GetComponent("ControllerExCollection"):GetController("choosebtn")
	self.sortList = {}
	self.isSel = {}
end

function NorseSurpriseGiftInStockPage:indexItem(arg_4_1, arg_4_2)
	HeroLongHead.SetProxy(arg_4_2, self.heroDataProxy)
	arg_4_2:SetData(self.heroList[arg_4_1])

	arg_4_2.isChoose = self.isSel[arg_4_1]

	arg_4_2:SetChoose(self.sortList)
	arg_4_2:RegistCallBack(function(arg_5_0)
		self.scroPos = self.uiList_:GetScrolledPosition()

		if arg_4_2.isChoose == 1 then
			arg_4_2.isChoose = 0

			local var_5_0 = {}

			for iter_5_0, iter_5_1 in ipairs(self.sortList) do
				if iter_5_1.id ~= arg_5_0 then
					table.insert(var_5_0, iter_5_1)
				end
			end

			self.sortList = var_5_0
		elseif self.sortList and #self.sortList >= 6 then
			ShowTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_1")
		else
			arg_4_2.isChoose = 1

			table.insert(self.sortList, {
				id = arg_5_0,
				flag = arg_4_2.isChoose
			})
		end

		self.isSel[arg_4_1] = arg_4_2.isChoose

		self.uiList_:StartScroll(#self.heroList)
		self.uiList_:SetScrolledPosition(self.scroPos)
		self:RefreshChooseBtn()
	end)
end

function NorseSurpriseGiftInStockPage:AddListeners()
	self:AddBtnListener(self.btn_choose, nil, function()
		if #self.sortList == 6 then
			JumpTools.OpenPageByJump("norseSurpriseGiftChooseAgainPage", {
				sortList = self.sortList
			})
		else
			ShowTips("ACTIVITY_OPTIONAL_RANDOM_TIPS_2")
		end
	end)
	self:AddBtnListener(self.btnClose_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.btnAll_, nil, function()
		self.heroList = GameSetting.activity_optional_random_role_list.value

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

function NorseSurpriseGiftInStockPage:RefreshHeroList(arg_18_1)
	self.heroList = GameSetting.activity_optional_random_role_list.value

	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(self.heroList) do
		if HeroCfg[iter_18_1].ATK_attribute[1] == arg_18_1 then
			table.insert(var_18_0, iter_18_1)
		end
	end

	self.heroList = var_18_0

	self.uiList_:StartScroll(#var_18_0)
end

function NorseSurpriseGiftInStockPage:OnEnter()
	NorseSurpriseGiftInStockPage.super.OnEnter(self)

	self.sortList = {}
	self.isSel = {}
	self.heartList = NorseSurpriseGiftReceiveData:GetChooseRoleData()

	self:RefreshView()

	if self.btnIndex and self.btnIndex >= 0 then
		self:RefreshHeroList(self.btnIndex)
	else
		self.heroList = GameSetting.activity_optional_random_role_list.value

		self.uiList_:StartScroll(#self.heroList)
		self.stateCtrl:SetSelectedIndex(0)
	end
end

function NorseSurpriseGiftInStockPage:RefreshView()
	self.btnCtrl:SetSelectedState("false")

	self.chooseTxt_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_2")
	self.tipsTxt_.text = GetTips("ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_3")
end

function NorseSurpriseGiftInStockPage:RefreshChooseBtn()
	if #self.sortList == 6 then
		self.btnCtrl:SetSelectedState("true")
	else
		self.btnCtrl:SetSelectedState("false")
	end
end

function NorseSurpriseGiftInStockPage:OnExit()
	NorseSurpriseGiftInStockPage.super.OnExit(self)
end

function NorseSurpriseGiftInStockPage:Dispose()
	if self.heroDataProxy then
		self.heroDataProxy = nil
	end

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	if self.heartList then
		self.heartList = nil
	end

	if self.heroList then
		self.heroList = nil
	end

	if self.sortList then
		self.sortList = nil
	end

	NorseSurpriseGiftInStockPage.super.Dispose(self)
end

return NorseSurpriseGiftInStockPage
