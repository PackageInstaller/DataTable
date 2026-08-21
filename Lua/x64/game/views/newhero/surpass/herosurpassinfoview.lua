local var_0_0 = class("HeroSurpassInfoView", ReduxView)
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

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.upBtnController = arg_2_0.rootControllerexcollection_:GetController(var_0_1.infoEx.upState.name)
	arg_2_0.nameDisplayController = arg_2_0.rootControllerexcollection_:GetController("nameDisplay")
	arg_2_0.costItem = CommonItemView.New(arg_2_0.costitem_)
	arg_2_0.attrItemGrowList = {}

	for iter_2_0 = 1, 3 do
		arg_2_0.attrItemGrowList[iter_2_0] = HeroSurpassAttrItem.New(arg_2_0["attr" .. iter_2_0 .. "Go_"])
	end

	arg_2_0.attrItemBaseList = {}

	for iter_2_1 = 1, 5 do
		arg_2_0.attrItemBaseList[iter_2_1] = HeroSurpassAttrItem.New(arg_2_0["attrbase" .. iter_2_1 .. "Go_"])
	end
end

function var_0_0.OnTop(arg_3_0)
	arg_3_0:ChangeBar()
end

function var_0_0.CheckIsShowGold(arg_4_0)
	if not arg_4_0.heroInfo then
		return false
	end

	local var_4_0 = arg_4_0.heroInfo.star
	local var_4_1 = SurpassTools.GetNextSurpassStarID(var_4_0)

	if var_4_1 and var_4_1 > arg_4_0.selectStarID then
		return true
	end

	return false
end

function var_0_0.ChangeBar(arg_5_0)
	if arg_5_0:CheckIsShowGold() then
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

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.upbtnBtn_, nil, function()
		arg_6_0:OnUpBtn()
	end)
	arg_6_0:AddBtnListener(arg_6_0.btnnodeBtn_, nil, function()
		arg_6_0:OnGoToAstrolabe()
	end)
end

function var_0_0.OnGoldChange(arg_9_0)
	if arg_9_0.selectStarID then
		arg_9_0:UpdateCost(arg_9_0.selectStarID)
	end
end

function var_0_0.OnGoToAstrolabe(arg_10_0)
	JumpTools.OpenPageByJump("/newHero", {
		isEnter = true,
		pageIndex = 6,
		hid = arg_10_0.heroInfo.id,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT
	})
end

function var_0_0.OnUpBtn(arg_11_0)
	local var_11_0 = HeroStarCfg[arg_11_0.heroInfo.star]

	if var_11_0.star_up > arg_11_0.heroInfo.piece then
		ShowTips("ERROR_ITEM_NOT_ENOUGH_HERO_PIECE")

		return
	end

	if not checkGold(var_11_0.gold_cost, true) then
		return
	end

	HeroAction.HeroStarUp(arg_11_0.heroInfo.id)
end

function var_0_0.SetDataProxy(arg_12_0, arg_12_1)
	arg_12_0.dataProxy = arg_12_1
end

function var_0_0.SetHeroId(arg_13_0, arg_13_1)
	arg_13_0.heroID = arg_13_1
	arg_13_0.heroCfg = HeroCfg[arg_13_0.heroID]
	arg_13_0.titlenameText_.text = arg_13_0.heroCfg.name
	arg_13_0.nameText_.text = arg_13_0.heroCfg.suffix
end

function var_0_0.RefreshUi(arg_14_0, arg_14_1)
	arg_14_1 = arg_14_1 or arg_14_0.selectStarID
	arg_14_0.heroInfo = arg_14_0.dataProxy:GetHeroData(arg_14_0.heroID)

	local var_14_0 = arg_14_0.heroInfo.star
	local var_14_1 = SurpassTools.GetNextSurpassStarID(var_14_0)
	local var_14_2 = HeroStarCfg[arg_14_1]

	SurpassTools.ChangeIconStarSpirte(arg_14_0.iconImg_, var_14_2.star)

	if var_14_1 and var_14_1 == arg_14_1 then
		arg_14_0.upBtnController:SetSelectedState(var_0_1.infoEx.upState.up)
	elseif var_14_1 and arg_14_1 < var_14_1 then
		arg_14_0.upBtnController:SetSelectedState(var_0_1.infoEx.upState.finish)
	else
		arg_14_0.upBtnController:SetSelectedState(var_0_1.infoEx.upState.lock)
	end

	local var_14_3 = arg_14_0.dataProxy:IsHeroOath(arg_14_0.heroID)

	arg_14_0.nameDisplayController:SetSelectedState(var_14_3 and "oath" or "normal")
	arg_14_0:RefreshDescInfo(arg_14_1)
	arg_14_0:UpdateCost(arg_14_1)

	local var_14_4 = SurpassTools.GetSmallStageShow(arg_14_1)

	arg_14_0.lvtextText_.text = var_14_4

	SetActive(arg_14_0.lvnodeGo_, var_14_4 ~= "" and true or false)

	if arg_14_1 ~= arg_14_0.selectStarID then
		arg_14_0.rootAni_:Play("Fx_Common_right_cx", 0, 0)
	end

	arg_14_0.selectStarID = arg_14_1

	arg_14_0:ChangeBar()
end

function var_0_0.UpdateCost(arg_15_0, arg_15_1)
	local var_15_0 = table.indexof(HeroStarCfg.all, arg_15_1)
	local var_15_1 = HeroStarCfg[HeroStarCfg.all[var_15_0 - 1]]

	if var_15_1 then
		local var_15_2 = ItemCfg[arg_15_0.heroID].fragment
		local var_15_3 = ItemTools.getItemNum(var_15_2)
		local var_15_4 = var_15_1.star_up
		local var_15_5 = clone(ItemTemplateData)

		var_15_5.id = var_15_2
		var_15_5.number = var_15_4

		function var_15_5.clickFun(arg_16_0)
			ShowPopItem(POP_SOURCE_ITEM, {
				arg_16_0.id,
				arg_16_0.number
			})
		end

		arg_15_0.costItem:SetData(var_15_5)
		arg_15_0.costItem:RefreshBottomText({
			var_15_3,
			var_15_4
		})
		arg_15_0.costItem:RefreshBottomRightText(true)

		if not checkGold(var_15_1.gold_cost, false) then
			arg_15_0.goldCostText_.text = string.format("<color=#FF000B>%d</color>", var_15_1.gold_cost)
		else
			arg_15_0.goldCostText_.text = string.format("%d", var_15_1.gold_cost)
		end
	end
end

function var_0_0.RefreshDescInfo(arg_17_0, arg_17_1)
	local var_17_0 = HeroStarCfg[arg_17_1]
	local var_17_1 = var_17_0.star

	for iter_17_0, iter_17_1 in pairs(arg_17_0.attrItemGrowList) do
		iter_17_1:SetActive(false)
	end

	for iter_17_2, iter_17_3 in pairs(arg_17_0.attrItemBaseList) do
		iter_17_3:SetActive(false)
	end

	local var_17_2, var_17_3, var_17_4, var_17_5 = SurpassTools.GetStarUpAttrShowDesc(arg_17_0.heroCfg, arg_17_1, true)

	if var_17_0.phase == 0 then
		local var_17_6 = math.max(var_17_1 - 1, 0)

		arg_17_0.attrItemGrowList[1]:RefreshUI(arg_17_0.heroCfg.atk_ratio[var_17_6], arg_17_0.heroCfg.atk_ratio[var_17_1], 1, true)
		arg_17_0.attrItemGrowList[2]:RefreshUI(arg_17_0.heroCfg.arm_ratio[var_17_6], arg_17_0.heroCfg.arm_ratio[var_17_1], 2, true)
		arg_17_0.attrItemGrowList[3]:RefreshUI(arg_17_0.heroCfg.sta_ratio[var_17_6], arg_17_0.heroCfg.sta_ratio[var_17_1], 3, true)
	end

	for iter_17_4, iter_17_5 in pairs(var_17_5) do
		if arg_17_0.attrItemBaseList[iter_17_4] then
			arg_17_0.attrItemBaseList[iter_17_4]:RefreshUI(nil, iter_17_5.value, iter_17_5.attrId)
		end
	end

	SetActive(arg_17_0.attributeGo_, var_17_0.phase == 0)
	SetActive(arg_17_0.attrbasenodeGo_, var_17_5 and #var_17_5 > 0)

	local var_17_7 = HeroTools.IsSpHero(arg_17_0.heroInfo.id)

	SetActive(arg_17_0.btnnodeGo_, false)

	local var_17_8 = false

	if var_17_7 then
		local var_17_9 = AstrolabeTools.GetSpAstrolabeNodeBySurpass(arg_17_0.heroInfo.id, arg_17_1)

		SetActive(arg_17_0.btnnodeGo_, var_17_9 ~= 0)

		if HeroAstrolabeCfg[var_17_9] then
			var_17_8 = true
			arg_17_0.txt_dyn_name02Text_.text = string.format(GetTips("SP_SURPASS_DES"), HeroAstrolabeCfg[var_17_9].name)
		end
	end

	local var_17_10 = ""

	for iter_17_6, iter_17_7 in pairs(var_17_2) do
		var_17_10 = string.format("%s%s\n", var_17_10, iter_17_7)
	end

	local var_17_11 = string.format("%s%s\n", var_17_10, var_17_3)

	arg_17_0.describetextText_.text = var_17_11

	SetActive(arg_17_0.specialGo_, #var_17_2 > 0 or var_17_3 ~= "" or var_17_8)
end

function var_0_0.Dispose(arg_18_0)
	if arg_18_0.costItem then
		arg_18_0.costItem:Dispose()

		arg_18_0.costItem = nil
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0.attrItemGrowList) do
		if iter_18_1 then
			iter_18_1:Dispose()
		end
	end

	for iter_18_2, iter_18_3 in pairs(arg_18_0.attrItemBaseList) do
		if iter_18_3 then
			iter_18_3:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
