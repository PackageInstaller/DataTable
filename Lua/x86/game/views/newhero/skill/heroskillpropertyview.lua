local var_0_0 = class("HeroSkillPropertyView", HeroPageBase)
local var_0_1 = {
	showState = {
		max = "max",
		up = "up",
		notup = "notup",
		none = "none"
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
	arg_2_0:CreateCostList()
	arg_2_0:AddUIListener()

	arg_2_0.stateController_ = arg_2_0.controllerexcollection_:GetController("state")
end

function var_0_0.CreateCostList(arg_3_0)
	arg_3_0.costItem = {}

	for iter_3_0 = 1, 4 do
		local var_3_0 = arg_3_0["costitem" .. iter_3_0 .. "Go_"]

		arg_3_0.costItem[iter_3_0] = CommonItemView.New(var_3_0)
	end

	arg_3_0.attrItemList = {}

	for iter_3_1 = 1, 4 do
		local var_3_1 = arg_3_0["attr" .. iter_3_1 .. "Go_"]

		arg_3_0.attrItemList[iter_3_1] = HeroSkillAttrItem.New(var_3_1)
	end
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddPressingByTimeListener(arg_4_0.upbtnBtn_.gameObject, 1.4, 0.2, 0.1, function()
		if not arg_4_0:isCanUpSkill() or arg_4_0.level + arg_4_0.tempAddLevel_ == HeroConst.MAX_SKILL_ATTR_LEVEL then
			arg_4_0:SendSkillAttrUpgrade()

			return false
		end

		if not arg_4_0.costEnough then
			arg_4_0:SendSkillAttrUpgrade()
			ShowTips("ERROR_HERO_NO_SKILL_ENHANCE_UP_MAT")

			return false
		end

		arg_4_0.tempAddLevel_ = (arg_4_0.tempAddLevel_ or 0) + 1

		arg_4_0:SendSkillAttrUpgrade()
		arg_4_0:RefreshUi()

		return true
	end, handler(arg_4_0, arg_4_0.SendSkillAttrUpgrade))
	arg_4_0:AddBtnListener(arg_4_0.limitBtn_, nil, function()
		ShowTips("NOTE_SKILL_ATTR_LIMIT")
	end)
	arg_4_0:AddBtnListener(arg_4_0.oneKeyUpBtn_, nil, function()
		arg_4_0:OnOneKeyUpBtn()
	end)
end

function var_0_0.OnOneKeyUpBtn(arg_8_0)
	if SkillTools.GetSkillAttrMaxUpLv(arg_8_0.skillId, arg_8_0.level) == arg_8_0.level then
		ShowTips("ERROR_HERO_NO_SKILL_ENHANCE_UP_MAT")
	else
		JumpTools.OpenPageByJump("skillUpTip", {
			isAttr = true,
			proxy = arg_8_0.heroViewDataProxy,
			heroId = arg_8_0.heroId,
			skillId = arg_8_0.skillId
		})
	end
end

function var_0_0.isCanUpSkill(arg_9_0)
	if SkillTools.GetIsDodgeSkill(arg_9_0.skillId) or not arg_9_0.nextAttrCfg then
		return false
	end

	return true
end

function var_0_0.SendSkillAttrUpgrade(arg_10_0)
	if arg_10_0.tempAddLevel_ and arg_10_0.tempAddLevel_ > 0 then
		HeroAction.HeroSkillAttrUpgrade(arg_10_0.heroId, arg_10_0.skillIndex, arg_10_0.tempAddLevel_)
	end
end

function var_0_0.OnHeroSkillAttrUpgradeInView(arg_11_0, arg_11_1, arg_11_2)
	if isSuccess(arg_11_1.result) then
		ShowTips("SKILL_ATTR_UPGRATE_SUCCESS", string.format("LEVEL\n<size=60>%s</size>", arg_11_0.level))
		SetActive(arg_11_0.lvbgGo_, false)
		SetActive(arg_11_0.lvbgGo_, true)
		arg_11_0.switchIconAnimator_:Play("Fx_right_huan_change", -1, 0)
	else
		ShowTips(arg_11_1.result)
	end

	arg_11_0.tempAddLevel_ = 0

	arg_11_0:RefreshUi()
end

function var_0_0.UpdatePropertyData(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:InitData(arg_12_1)

	if arg_12_2 then
		arg_12_0.switchIconAnimator_:Play("Fx_right_huan_change", -1, 0)
	end

	arg_12_0.skilliconImg_.sprite = getSprite("Atlas/" .. arg_12_0.heroId, arg_12_0.realSkillId)

	if SkillTools.GetIsDodgeSkill(arg_12_0.skillId) then
		arg_12_0:RefreshAttrList()
		arg_12_0.stateController_:SetSelectedState(var_0_1.showState.none)
	else
		arg_12_0:RefreshUi()
	end
end

function var_0_0.InitData(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.id
	local var_13_1 = arg_13_1.heroId
	local var_13_2 = arg_13_0.heroViewDataProxy:GetRealSkillId(var_13_1, var_13_0)
	local var_13_3 = SkillTools.GetSkillIdIndex(var_13_0)

	arg_13_0.skillId = var_13_0
	arg_13_0.heroId = var_13_1
	arg_13_0.realSkillId = var_13_2
	arg_13_0.skillIndex = var_13_3
end

function var_0_0.OnEnter(arg_14_0, arg_14_1)
	arg_14_0.heroViewDataProxy = arg_14_1
	arg_14_0.tempAddLevel_ = 0
end

function var_0_0.RefreshUi(arg_15_0)
	local var_15_0 = arg_15_0.heroViewDataProxy:GetSkillAttrLv(arg_15_0.heroId, arg_15_0.skillIndex) + arg_15_0.tempAddLevel_

	arg_15_0.level = var_15_0
	arg_15_0.attrCfg = SkillTools.GetSkillAttrCfg(arg_15_0.heroId, arg_15_0.skillIndex, var_15_0)
	arg_15_0.nextAttrCfg = SkillTools.GetSkillAttrCfg(arg_15_0.heroId, arg_15_0.skillIndex, var_15_0 + 1)

	arg_15_0:RefreshCost()
	arg_15_0:RefreshAttrList()
	arg_15_0:UpdateUpStateController()

	arg_15_0.lvNowText_.text = arg_15_0.level
	arg_15_0.lvLaterText_.text = arg_15_0.level + 1
	arg_15_0.sliderSlr_.value = arg_15_0.heroViewDataProxy:GetSkillAtrrProgressValue(arg_15_0.heroId, arg_15_0.skillIndex, arg_15_0.level)
end

function var_0_0.UpdateUpStateController(arg_16_0)
	if not arg_16_0.heroViewDataProxy:CheckIsSelf() then
		arg_16_0.stateController_:SetSelectedState(var_0_1.showState.none)

		return
	end

	if arg_16_0:RefreshCondition() then
		arg_16_0.stateController_:SetSelectedState(var_0_1.showState.notup)
	elseif not arg_16_0.nextAttrCfg then
		arg_16_0.stateController_:SetSelectedState(var_0_1.showState.max)
	else
		arg_16_0.stateController_:SetSelectedState(var_0_1.showState.up)
	end
end

function var_0_0.RefreshCondition(arg_17_0)
	local var_17_0 = arg_17_0.skillIndex
	local var_17_1 = arg_17_0.heroViewDataProxy:GetHeroData(arg_17_0.heroId)
	local var_17_2 = arg_17_0.heroViewDataProxy:GetSkillLv(arg_17_0.heroId, arg_17_0.skillId)
	local var_17_3 = false

	if var_17_2 < HeroConst.MAX_SKILL_LEVEL then
		arg_17_0.conditiondescireText_.text = GetTips("NOTE_SKILL_ATTR_LIMIT")
		arg_17_0.conditionvalueText_.text = string.format("%s/%s", var_17_2, HeroConst.MAX_SKILL_LEVEL)
		var_17_3 = true
	end

	return var_17_3
end

function var_0_0.RefreshCost(arg_18_0)
	arg_18_0.costCfg = arg_18_0.nextAttrCfg and arg_18_0.nextAttrCfg.cost or nil
	arg_18_0.costEnough = true

	for iter_18_0 = 1, 4 do
		if arg_18_0.costCfg and arg_18_0.costCfg[iter_18_0] then
			arg_18_0.costItem[iter_18_0].gameObject_:SetActive(true)

			local var_18_0 = arg_18_0.costCfg[iter_18_0][1]
			local var_18_1 = arg_18_0.costCfg[iter_18_0][2]
			local var_18_2 = ItemTools.getItemNum(var_18_0)
			local var_18_3 = clone(ItemTemplateData)

			var_18_3.id = var_18_0
			var_18_3.number = var_18_1

			function var_18_3.clickFun(arg_19_0)
				ShowPopItem(POP_SOURCE_ITEM, {
					arg_19_0.id,
					arg_19_0.number
				})
			end

			arg_18_0.costItem[iter_18_0]:SetData(var_18_3)
			arg_18_0.costItem[iter_18_0]:RefreshBottomText({
				var_18_2,
				var_18_1
			})
			arg_18_0.costItem[iter_18_0]:RefreshBottomRightText(true)

			if var_18_2 < var_18_1 then
				arg_18_0.costEnough = false
			end
		else
			arg_18_0.costItem[iter_18_0].gameObject_:SetActive(false)
		end
	end
end

function var_0_0.RefreshAttrList(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = arg_20_0:GetAttrDataList(var_20_0, true)
	local var_20_2 = arg_20_0:GetAttrDataList(var_20_1, false)
	local var_20_3 = {}

	for iter_20_0, iter_20_1 in pairs(var_20_2) do
		table.insert(var_20_3, iter_20_1)
	end

	table.sort(var_20_3, function(arg_21_0, arg_21_1)
		return arg_21_0.attrType < arg_21_1.attrType
	end)

	for iter_20_2, iter_20_3 in pairs(arg_20_0.attrItemList) do
		local var_20_4 = var_20_3[iter_20_2]

		if var_20_4 then
			SetActive(iter_20_3.gameObject_, true)
			iter_20_3:RefreshUI(var_20_4, arg_20_0.heroViewDataProxy:CheckIsSelf())
		else
			SetActive(iter_20_3.gameObject_, false)
		end
	end
end

function var_0_0.GetAttrDataList(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0

	if arg_22_2 then
		var_22_0 = arg_22_0.attrCfg
	else
		var_22_0 = arg_22_0.nextAttrCfg
	end

	if var_22_0 then
		for iter_22_0, iter_22_1 in pairs(var_22_0.attr) do
			local var_22_1 = iter_22_1[1]
			local var_22_2 = iter_22_1[2]

			if not arg_22_1[var_22_1] then
				arg_22_1[var_22_1] = {}
				arg_22_1[var_22_1].nowValue = 0
				arg_22_1[var_22_1].nextValue = 0
				arg_22_1[var_22_1].attrType = var_22_1
			end

			if arg_22_2 then
				arg_22_1[var_22_1].nowValue = var_22_2
			else
				arg_22_1[var_22_1].nextValue = var_22_2
			end
		end
	end

	return arg_22_1
end

function var_0_0.Dispose(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.attrItemList or {}) do
		if iter_23_1 then
			iter_23_1:Dispose()
		end
	end

	for iter_23_2, iter_23_3 in pairs(arg_23_0.costItem or {}) do
		if iter_23_3 then
			iter_23_3:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
