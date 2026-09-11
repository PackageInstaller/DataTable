local HeroSurpassInfoView = class("HeroSurpassInfoView", ReduxView)
local var_0_1 = {
	infoEx = {
		upState = {
			finish = "finish",
			name = "btnState",
			lock = "lock",
			up = "up"
		}
	}
}

function HeroSurpassInfoView:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function HeroSurpassInfoView:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.upBtnController = self.rootControllerexcollection_:GetController(var_0_1.infoEx.upState.name)
	self.nameDisplayController = self.rootControllerexcollection_:GetController("nameDisplay")
	self.costItem = CommonItemView.New(self.costitem_)
	self.attrItemGrowList = {}

	for iter_2_0 = 1, 3 do
		self.attrItemGrowList[iter_2_0] = HeroSurpassAttrItem.New(self["attr" .. iter_2_0 .. "Go_"])
	end

	self.attrItemBaseList = {}

	for iter_2_1 = 1, 5 do
		self.attrItemBaseList[iter_2_1] = HeroSurpassAttrItem.New(self["attrbase" .. iter_2_1 .. "Go_"])
	end
end

function HeroSurpassInfoView:OnTop()
	self:ChangeBar()
end

function HeroSurpassInfoView:CheckIsShowGold()
	if not self.heroInfo then
		return false
	end

	local var_4_0 = SurpassTools.GetNextSurpassStarID(self.heroInfo.star)

	if var_4_0 and var_4_0 > self.selectStarID then
		return true
	end

	return false
end

function HeroSurpassInfoView:ChangeBar()
	if self:CheckIsShowGold() then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_GOLD
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	end
end

function HeroSurpassInfoView:AddUIListener()
	self:AddBtnListener(self.upbtnBtn_, nil, function()
		self:OnUpBtn()
	end)
	self:AddBtnListener(self.btnnodeBtn_, nil, function()
		self:OnGoToAstrolabe()
	end)
end

function HeroSurpassInfoView:OnGoldChange()
	if self.selectStarID then
		self:UpdateCost(self.selectStarID)
	end
end

function HeroSurpassInfoView:OnGoToAstrolabe()
	JumpTools.OpenPageByJump("/newHero", {
		isEnter = true,
		pageIndex = 6,
		hid = self.heroInfo.id,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT
	})
end

function HeroSurpassInfoView:OnUpBtn()
	if HeroStarCfg[self.heroInfo.star].star_up > self.heroInfo.piece then
		ShowTips("ERROR_ITEM_NOT_ENOUGH_HERO_PIECE")

		return
	end

	if not checkGold(HeroStarCfg[self.heroInfo.star].gold_cost, true) then
		return
	end

	HeroAction.HeroStarUp(self.heroInfo.id)
end

function HeroSurpassInfoView:SetDataProxy(arg_12_1)
	self.dataProxy = arg_12_1
end

function HeroSurpassInfoView:SetHeroId(arg_13_1)
	self.heroID = arg_13_1
	self.heroCfg = HeroCfg[self.heroID]
	self.titlenameText_.text = self.heroCfg.name
	self.nameText_.text = self.heroCfg.suffix
end

function HeroSurpassInfoView:RefreshUi(arg_14_1)
	arg_14_1 = arg_14_1 or self.selectStarID
	self.heroInfo = self.dataProxy:GetHeroData(self.heroID)

	local var_14_0 = SurpassTools.GetNextSurpassStarID(self.heroInfo.star)

	SurpassTools.ChangeIconStarSpirte(self.iconImg_, HeroStarCfg[arg_14_1].star)

	if var_14_0 and var_14_0 == arg_14_1 then
		self.upBtnController:SetSelectedState(var_0_1.infoEx.upState.up)
	elseif var_14_0 and arg_14_1 < var_14_0 then
		self.upBtnController:SetSelectedState(var_0_1.infoEx.upState.finish)
	else
		self.upBtnController:SetSelectedState(var_0_1.infoEx.upState.lock)
	end

	self.nameDisplayController:SetSelectedState(self.dataProxy:IsHeroOath(self.heroID) and "oath" or "normal")
	self:RefreshDescInfo(arg_14_1)
	self:UpdateCost(arg_14_1)

	local var_14_1 = SurpassTools.GetSmallStageShow(arg_14_1)

	self.lvtextText_.text = var_14_1

	SetActive(self.lvnodeGo_, var_14_1 ~= "" and true or false)

	if arg_14_1 ~= self.selectStarID then
		self.rootAni_:Play("Fx_Common_right_cx", 0, 0)
	end

	self.selectStarID = arg_14_1

	self:ChangeBar()
end

function HeroSurpassInfoView:UpdateCost(arg_15_1)
	local var_15_0 = HeroStarCfg[HeroStarCfg.all[table.indexof(HeroStarCfg.all, arg_15_1) - 1]]

	if var_15_0 then
		local var_15_1 = clone(ItemTemplateData)

		var_15_1.id = ItemCfg[self.heroID].fragment
		var_15_1.number = var_15_0.star_up

		function var_15_1:clickFun()
			ShowPopItem(POP_SOURCE_ITEM, {
				self.id,
				self.number
			})
		end

		self.costItem:SetData(var_15_1)
		self.costItem:RefreshBottomText({
			ItemTools.getItemNum(ItemCfg[self.heroID].fragment),
			var_15_0.star_up
		})
		self.costItem:RefreshBottomRightText(true)

		self.goldCostText_.text = not checkGold(var_15_0.gold_cost, false) and string.format("<color=#FF000B>%d</color>", var_15_0.gold_cost) or string.format("%d", var_15_0.gold_cost)
	end
end

function HeroSurpassInfoView:RefreshDescInfo(arg_17_1)
	local var_17_0 = HeroStarCfg[arg_17_1]

	for iter_17_0, iter_17_1 in pairs(self.attrItemGrowList) do
		iter_17_1:SetActive(false)
	end

	for iter_17_2, iter_17_3 in pairs(self.attrItemBaseList) do
		iter_17_3:SetActive(false)
	end

	local var_17_1, var_17_2, var_17_3, var_17_4 = SurpassTools.GetStarUpAttrShowDesc(self.heroCfg, arg_17_1, true)

	if var_17_0.phase == 0 then
		local var_17_5 = math.max(HeroStarCfg[arg_17_1].star - 1, 0)

		self.attrItemGrowList[1]:RefreshUI(self.heroCfg.atk_ratio[var_17_5], self.heroCfg.atk_ratio[HeroStarCfg[arg_17_1].star], 1, true)
		self.attrItemGrowList[2]:RefreshUI(self.heroCfg.arm_ratio[var_17_5], self.heroCfg.arm_ratio[HeroStarCfg[arg_17_1].star], 2, true)
		self.attrItemGrowList[3]:RefreshUI(self.heroCfg.sta_ratio[var_17_5], self.heroCfg.sta_ratio[HeroStarCfg[arg_17_1].star], 3, true)
	end

	for iter_17_4, iter_17_5 in pairs(var_17_4) do
		if self.attrItemBaseList[iter_17_4] then
			self.attrItemBaseList[iter_17_4]:RefreshUI(nil, iter_17_5.value, iter_17_5.attrId)
		end
	end

	SetActive(self.attributeGo_, var_17_0.phase == 0)
	SetActive(self.attrbasenodeGo_, var_17_4 and #var_17_4 > 0)
	SetActive(self.btnnodeGo_, false)

	local var_17_6 = false

	if HeroTools.IsSpHero(self.heroInfo.id) then
		local var_17_7 = AstrolabeTools.GetSpAstrolabeNodeBySurpass(self.heroInfo.id, arg_17_1)

		SetActive(self.btnnodeGo_, var_17_7 ~= 0)

		if HeroAstrolabeCfg[var_17_7] then
			var_17_6 = true
			self.txt_dyn_name02Text_.text = string.format(GetTips("SP_SURPASS_DES"), HeroAstrolabeCfg[var_17_7].name)
		end
	end

	local var_17_8 = ""

	for iter_17_6, iter_17_7 in pairs(var_17_1) do
		var_17_8 = string.format("%s%s\n", var_17_8, iter_17_7)
	end

	self.describetextText_.text = string.format("%s%s\n", var_17_8, var_17_2)

	SetActive(self.specialGo_, #var_17_1 > 0 or var_17_2 ~= "" or var_17_6)
end

function HeroSurpassInfoView:Dispose()
	if self.costItem then
		self.costItem:Dispose()

		self.costItem = nil
	end

	for iter_18_0, iter_18_1 in pairs(self.attrItemGrowList) do
		if iter_18_1 then
			iter_18_1:Dispose()
		end
	end

	for iter_18_2, iter_18_3 in pairs(self.attrItemBaseList) do
		if iter_18_3 then
			iter_18_3:Dispose()
		end
	end

	HeroSurpassInfoView.super.Dispose(self)
end

return HeroSurpassInfoView
