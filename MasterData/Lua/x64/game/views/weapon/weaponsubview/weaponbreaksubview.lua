local WeaponBreakSubView = class("WeaponBreakSubView", ReduxView)

function WeaponBreakSubView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:Init()

	self.pageIsInOpen = false
end

function WeaponBreakSubView:Init()
	self.scrollHelper_ = LuaList.New(handler(self, self.RenderItem), self.consumeList_, CommonItemView)

	self:AddUIListener()

	self.conditionController = self.conditionController_:GetController("conditionItem")
end

function WeaponBreakSubView:OnEnter()
	return
end

function WeaponBreakSubView:OnExit()
	return
end

function WeaponBreakSubView:buildContext(arg_5_1)
	arg_5_1 = arg_5_1 or HeroConst.HERO_DATA_TYPE.DEFAULT
	self.context = {
		cost = 0,
		itemCount = 0,
		heroId = 0,
		isActive = false,
		weaponInfo = {},
		itemList = {},
		type = arg_5_1,
		dataPorxy = HeroViewDataProxy.New(arg_5_1)
	}
	self.constVar = {
		yellow = "363A42",
		red = "CD421E"
	}
end

function WeaponBreakSubView:ShowWeaponInfoLocal()
	self:UpdateWeaponInfo()
	self:ShowWeaponInfo(self.context.heroId, self.context.weaponInfo)
end

function WeaponBreakSubView:ShowWeaponInfo(arg_7_1, arg_7_2, arg_7_3)
	self:buildContext(arg_7_3)
	self:SetPageStatus(true)

	self.context.heroId = arg_7_1
	self.context.weaponInfo = arg_7_2

	self:RefreshMaterialList()
	self.scrollHelper_:StartScroll(self.context.itemCount)
	self:RenderView()
end

function WeaponBreakSubView:RenderItem(arg_8_1, arg_8_2)
	self.context.itemList[arg_8_1].index = arg_8_1

	local var_8_0 = ItemTools.getItemNum(self.context.itemList[arg_8_1][1])
	local var_8_1 = clone(ItemTemplateData)

	var_8_1.index = arg_8_1
	var_8_1.bottomText = {
		var_8_0,
		self.context.itemList[arg_8_1][2]
	}
	var_8_1.id = self.context.itemList[arg_8_1][1]
	var_8_1.number = nil

	function var_8_1:clickFun()
		ShowPopItem(POP_SOURCE_ITEM, {
			self.id,
			var_8_0
		})
	end

	arg_8_2:SetData(var_8_1)
end

function WeaponBreakSubView:RenderView()
	local var_10_0 = self.context.heroId
	local var_10_1 = self.context.weaponInfo
	local var_10_2 = self.context.weaponInfo.level
	local var_10_4 = GameSetting.weapon_exp_limit.value[self.context.weaponInfo.breakthrough + 2]
	local var_10_7 = string.format("%d", WeaponTools.WeaponAtk(self.context.weaponInfo.level, self.context.weaponInfo.breakthrough))
	local var_10_8 = string.format("%d", WeaponTools.WeaponAtk(self.context.weaponInfo.level, self.context.weaponInfo.breakthrough + 1))
	local var_10_9 = PlayerData:GetPlayerInfo().userLevel
	local var_10_10 = GameSetting.weapon_user_limit.value[self.context.weaponInfo.breakthrough + 1]

	self:RenderCost()
	SetActive(self.markObj_, var_10_10 <= var_10_9)

	if var_10_10 <= var_10_9 then
		self.conditionTxt_.text = string.format(GetTips("UPGRADE_LIMIT_LEVEL"), var_10_10)

		self.conditionController:SetSelectedState("achieve")
	else
		self.conditionTxt_.text = string.format(GetTips("UPGRADE_LIMIT_LEVEL_RED"), var_10_10)

		self.conditionController:SetSelectedState("unsuccessful")
	end

	self.beforeLvTxt_.text = var_10_2
	self.afterLvTxt_.text = var_10_4
	self.beforeAtkTxt_.text = var_10_7
	self.afterAtkTxt_.text = var_10_8

	local var_10_11, var_10_12 = SkillTools.GetAttr(HeroCfg[var_10_0].weapon_break_attribute[var_10_1.breakthrough + 1])

	self.beforeSubTxt_.text = var_10_12

	local var_10_13, var_10_14 = SkillTools.GetAttr(HeroCfg[var_10_0].weapon_break_attribute[var_10_1.breakthrough + 2])

	self.subDescTxt_.text = var_10_13
	self.afterSubTxt_.text = var_10_14
end

function WeaponBreakSubView:RefreshMaterialList()
	local var_11_0, var_11_1 = WeaponTools.BreakMaterial(self.context.weaponInfo.breakthrough)

	self.context.itemList = var_11_1
	self.context.itemCount = #var_11_1
	self.context.cost = var_11_0
end

function WeaponBreakSubView:AddUIListener()
	self:AddBtnListener(self.breakUpBtn_, nil, function()
		self:OnBreakBtnClick()
	end)
	self:AddBtnListener(self.quickLvUpBtn_, nil, function()
		JumpTools.OpenPageByJump("weaponQuickLevelUp", {
			heroID = self.context.heroId,
			weaponInfo = self.context.weaponInfo
		})
	end)
end

function WeaponBreakSubView:RenderCost()
	local var_15_0, var_15_1 = WeaponTools.BreakMaterial(self.context.weaponInfo.breakthrough)

	self.tokenTxt_.text = setTextColor(self.constVar.yellow, self.constVar.red, var_15_0, (ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD)))
end

function WeaponBreakSubView:OnGoldChange()
	self:RefreshMaterialList()
	self.scrollHelper_:StartScroll(self.context.itemCount)
	self:RenderView()
end

function WeaponBreakSubView:OnBreakBtnClick()
	if WeaponAction.CheckBreak(self.context.heroId, true) then
		WeaponAction.WeaponBreak(self.context.heroId)
	end
end

function WeaponBreakSubView:UpdateWeaponInfo()
	if self.context.heroId and self.context.heroId ~= 0 then
		self.context.weaponInfo = deepClone(self.context.dataPorxy:GetHeroWeaponInfo(self.context.heroId))
	end
end

function WeaponBreakSubView:SetPageStatus(arg_19_1)
	self.pageIsInOpen = arg_19_1
end

function WeaponBreakSubView:GetPageOpenStatus()
	return self.pageIsInOpen
end

function WeaponBreakSubView:OnExit()
	self:SetPageStatus(false)
end

function WeaponBreakSubView:Dispose()
	self.scrollHelper_:Dispose()
	self:RemoveAllListeners()
	WeaponBreakSubView.super.Dispose(self)
end

return WeaponBreakSubView
