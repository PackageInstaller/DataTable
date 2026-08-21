local var_0_0 = class("NewNavalTacticsSelSkillsPage", import("....base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "NewNavalTacticsSkillsPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.confrimBtn = arg_2_0._tf:Find("frame/confirm_btn")
	arg_2_0.skillTpl = arg_2_0._tf:Find("frame/skill_container/content/skill")
	arg_2_0.emptyTpl = arg_2_0._tf:Find("frame/skill_container/content/empty")
	arg_2_0.toggleGroup = arg_2_0._tf:Find("frame/skill_container/content"):GetComponent(typeof(ToggleGroup))
	arg_2_0.skillCards = {
		NewNavalTacticsSkillCard.New(arg_2_0.skillTpl)
	}
	arg_2_0.emptyTpls = {
		arg_2_0.emptyTpl
	}

	setText(arg_2_0.confrimBtn:Find("Image"), i18n("tactics_class_start"))
	setText(arg_2_0._tf:Find("frame/bg/title"), i18n("nav_tactics_sel_skill_title"))

	return
end

function var_0_0.SetCancelCallback(arg_3_0, arg_3_1)
	arg_3_0.onCancelCallback = arg_3_1

	return
end

function var_0_0.SetHideCallback(arg_4_0, arg_4_1)
	arg_4_0.onHideCallback = arg_4_1

	return
end

function var_0_0.OnInit(arg_5_0)
	onButton(arg_5_0, arg_5_0._tf, function()
		arg_5_0:Cancel()
		arg_5_0:Hide()

		if arg_5_0.onCancelCallback then
			arg_5_0.onCancelCallback()

			arg_5_0.onCancelCallback = nil
		end

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.confrimBtn, function()
		if not arg_5_0.selSkill or not arg_5_0.selIndex then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_should_exist_skill"))

			return
		end

		if arg_5_0.selSkill:IsMaxLevel() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("tactics_max_level"))

			return
		end

		arg_5_0.student:setSkillIndex(arg_5_0.selIndex)
		arg_5_0:emit(NewNavalTacticsLayer.ON_SKILL_SELECTED, arg_5_0.student)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_8_0, arg_8_1, arg_8_2)
	var_0_0.super.Show(arg_8_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_8_0._tf)

	if arg_8_1 ~= arg_8_0.student then
		arg_8_0.skillIndex = arg_8_2
		arg_8_0.student = arg_8_1
		arg_8_0.selSkill = nil
		arg_8_0.selIndex = nil

		arg_8_0:UpdateSkillList(arg_8_1)
	end

	return
end

function var_0_0.Cancel(arg_9_0)
	arg_9_0:emit(NewNavalTacticsMediator.ON_CANCEL_ADD_STUDENT)

	return
end

function var_0_0.Hide(arg_10_0)
	var_0_0.super.Hide(arg_10_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf, pg.UIMgr.GetInstance().UIMain)

	if arg_10_0.onHideCallback then
		arg_10_0.onHideCallback()

		arg_10_0.onHideCallback = nil
	end

	return
end

function var_0_0.UpdateSkillList(arg_11_0, arg_11_1)
	local var_11_0 = getProxy(BayProxy):RawGetShipById(arg_11_1.shipId)
	local var_11_1 = var_11_0:getSkillList()
	local var_11_2 = #var_11_1
	local var_11_3 = #var_11_1 >= 3 and var_11_2 or 3

	for iter_11_0 = 1, #var_11_1 do
		arg_11_0:UpdateSkill(iter_11_0, ShipSkill.New(var_11_0.skills[var_11_1[iter_11_0]], var_11_0.id))
	end

	local var_11_4 = 0

	for iter_11_1 = var_11_2 + 1, var_11_3 do
		var_11_4 = var_11_4 + 1

		arg_11_0:UpdateEmptySkill(var_11_4, iter_11_1)
	end

	arg_11_0:ClearShipCards(arg_11_0.skillCards, var_11_2)
	arg_11_0:ClearEmtptyTpls(arg_11_0.emptyTpls, var_11_4)

	if var_11_2 > 0 then
		arg_11_0.toggleGroup:SetAllTogglesOff()
		triggerToggle(arg_11_0.skillCards[1]._tf, true)
	end

	if arg_11_0.skillIndex then
		arg_11_0:TriggerDefault(var_11_1)
	end

	return
end

function var_0_0.TriggerDefault(arg_12_0, arg_12_1)
	if arg_12_0.skillIndex and arg_12_0.skillIndex > 0 then
		triggerToggle(arg_12_0.skillCards[arg_12_0.skillIndex]._tf, true)
		triggerButton(arg_12_0.confrimBtn)
	end

	arg_12_0.skillIndex = nil

	return
end

function var_0_0.UpdateSkill(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.skillCards[arg_13_1]

	if not arg_13_0.skillCards[arg_13_1] then
		var_13_0 = NewNavalTacticsSkillCard.New(Object.Instantiate(arg_13_0.skillTpl, arg_13_0.skillTpl.parent))
		arg_13_0.skillCards[arg_13_1] = var_13_0
	end

	var_13_0._tf:SetSiblingIndex(arg_13_1 - 1)
	var_13_0:Enable()
	var_13_0:Update(arg_13_2)
	onToggle(arg_13_0, var_13_0._tf, function(arg_14_0)
		if arg_14_0 then
			arg_13_0.selSkill = arg_13_2
			arg_13_0.selIndex = arg_13_1
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.ClearShipCards(arg_15_0, arg_15_1, arg_15_2)
	for iter_15_0 = #arg_15_1, arg_15_2 + 1, -1 do
		arg_15_1[iter_15_0]:Disable()
	end

	return
end

function var_0_0.UpdateEmptySkill(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.emptyTpls[arg_16_1]

	if not arg_16_0.emptyTpls[arg_16_1] then
		var_16_0 = Object.Instantiate(arg_16_0.emptyTpl, arg_16_0.emptyTpl.parent)
		arg_16_0.emptyTpls[arg_16_1] = var_16_0
	end

	var_16_0:SetSiblingIndex(arg_16_2 - 1)
	setActive(var_16_0, true)

	return
end

function var_0_0.ClearEmtptyTpls(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0 = #arg_17_1, arg_17_2 + 1, -1 do
		setActive(arg_17_1[iter_17_0], false)
	end

	return
end

function var_0_0.OnDestroy(arg_18_0)
	if arg_18_0:isShowing() then
		arg_18_0:Hide()
	end

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.skillCards) do
		iter_18_1:Dispose()
	end

	arg_18_0.skillCards = nil

	return
end

return var_0_0
