class = var_0_10000

local var_0_0 = "NewNavalTacticsSelSkillsPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewNavalTacticsSkillsPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.confrimBtn = var_1.Find(var_2_0, "frame/confirm_btn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.skillTpl = var_1.Find(var_2_1, "frame/skill_container/content/skill")

	local var_2_2 = arg_2_0._tf

	arg_2_0.emptyTpl = var_1.Find(var_2_2, "frame/skill_container/content/empty")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/skill_container/content")
	local var_2_5 = var_1.GetComponent

	typeof = var_4
	ToggleGroup = var_1_10006
	arg_2_0.toggleGroup = var_2_5(var_2_4, var_4(var_1_10006))

	local var_2_6 = {}

	NewNavalTacticsSkillCard = var_1_10002
	var_2_6[1] = var_1_10002.New(arg_2_0.skillTpl)
	arg_2_0.skillCards = var_2_6
	arg_2_0.emptyTpls = {
		arg_2_0.emptyTpl
	}
	setText = var_1

	local var_2_7 = arg_2_0.confrimBtn
	local var_2_8 = var_3.Find(var_2_7, "Image")

	i18n = var_4

	var_1(var_2_8, var_4("tactics_class_start"))

	setText = var_1

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_3.Find(var_2_9, "frame/bg/title")

	i18n = var_4

	var_1(var_2_10, var_4("nav_tactics_sel_skill_title"))

	return
end

function var_0_1.SetCancelCallback(arg_3_0, arg_3_1)
	arg_3_0.onCancelCallback = arg_3_1

	return
end

function var_0_1.SetHideCallback(arg_4_0, arg_4_1)
	arg_4_0.onHideCallback = arg_4_1

	return
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.Cancel(var_6_0)

		local var_6_1 = arg_5_0

		var_0.Hide(var_6_1)

		if arg_5_0.onCancelCallback then
			arg_5_0.onCancelCallback()

			arg_5_0.onCancelCallback = nil
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.confrimBtn

	local function var_5_5()
		if not arg_5_0.selSkill or not arg_5_0.selIndex then
			pg = var_0

			local var_7_0 = var_0.TipsMgr.GetInstance()
			local var_7_1 = var_0.ShowTips

			i18n = var_2_10003

			var_7_1(var_7_0, var_2_10003("tactics_should_exist_skill"))

			return
		end

		local var_7_2 = arg_5_0.selSkill

		if var_0.IsMaxLevel(var_7_2) then
			pg = var_0

			local var_7_3 = var_0.TipsMgr.GetInstance()
			local var_7_4 = var_0.ShowTips

			i18n = var_2_10003

			var_7_4(var_7_3, var_2_10003("tactics_max_level"))

			return
		end

		local var_7_5 = arg_5_0.student

		var_0.setSkillIndex(var_7_5, arg_5_0.selIndex)

		local var_7_6 = arg_5_0
		local var_7_7 = var_0.emit

		NewNavalTacticsLayer = var_3

		var_7_7(var_7_6, var_3.ON_SKILL_SELECTED, arg_5_0.student)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10006)

	return
end

function var_0_1.Show(arg_8_0, arg_8_1, arg_8_2)
	var_0_1.super.Show(arg_8_0)

	pg = var_3

	local var_8_0 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_8_0, arg_8_0._tf)

	if arg_8_1 ~= arg_8_0.student then
		arg_8_0.skillIndex = arg_8_2
		arg_8_0.student = arg_8_1
		arg_8_0.selSkill = nil
		arg_8_0.selIndex = nil

		arg_8_0:UpdateSkillList(arg_8_1)
	end

	return
end

function var_0_1.Cancel(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.emit

	NewNavalTacticsMediator = var_1_10004

	var_9_1(var_9_0, var_1_10004.ON_CANCEL_ADD_STUDENT)

	return
end

function var_0_1.Hide(arg_10_0)
	var_0_1.super.Hide(arg_10_0)

	pg = var_1

	local var_10_0 = var_1.UIMgr.GetInstance()
	local var_10_1 = var_1.UnOverlayPanel
	local var_10_2 = arg_10_0._tf

	pg = var_1_10005

	var_10_1(var_10_0, var_10_2, var_1_10005.UIMgr.GetInstance().UIMain)

	if arg_10_0.onHideCallback then
		arg_10_0.onHideCallback()

		arg_10_0.onHideCallback = nil
	end

	return
end

function var_0_1.UpdateSkillList(arg_11_0, arg_11_1)
	getProxy = var_1_10002
	BayProxy = var_1_10004

	local var_11_0 = var_1_10002(var_1_10004)
	local var_11_1 = var_2.RawGetShipById(var_11_0, arg_11_1.shipId)
	local var_11_2 = #var_2.getSkillList(var_11_1) >= 3 and var_4 or 3

	for iter_11_0 = 1, var_4 do
		local var_11_3 = var_3[iter_11_0]
		local var_11_4 = arg_11_0
		local var_11_5 = arg_11_0.UpdateSkill
		local var_11_6 = iter_11_0

		ShipSkill = var_1_10015

		var_11_5(var_11_4, var_11_6, var_1_10015.New(var_2.skills[var_11_3], var_2.id))
	end

	local var_11_7 = 0

	for iter_11_1 = var_4 + 1, var_11_2 do
		var_11_7 = var_11_7 + 1

		arg_11_0:UpdateEmptySkill(var_11_7, iter_11_1)
	end

	arg_11_0:ClearShipCards(arg_11_0.skillCards, var_4)
	arg_11_0:ClearEmtptyTpls(arg_11_0.emptyTpls, var_11_7)

	if var_4 > 0 then
		local var_11_8 = arg_11_0.toggleGroup

		var_7.SetAllTogglesOff(var_11_8)

		triggerToggle = var_7

		var_7(arg_11_0.skillCards[1]._tf, true)
	end

	if arg_11_0.skillIndex then
		arg_11_0:TriggerDefault(var_3)
	end

	return
end

function var_0_1.TriggerDefault(arg_12_0, arg_12_1)
	if arg_12_0.skillIndex and 0 < var_2 then
		triggerToggle = var_3

		var_3(arg_12_0.skillCards[var_2]._tf, true)

		triggerButton = var_3

		var_3(arg_12_0.confrimBtn)
	end

	arg_12_0.skillIndex = nil

	return
end

function var_0_1.UpdateSkill(arg_13_0, arg_13_1, arg_13_2)
	local var_13_1

	if not arg_13_0.skillCards[arg_13_1] then
		NewNavalTacticsSkillCard = var_1_10004

		local var_13_0 = var_1_10004.New

		Object = var_1_10006
		var_13_1 = var_13_0(var_1_10006.Instantiate(arg_13_0.skillTpl, arg_13_0.skillTpl.parent))
		arg_13_0.skillCards[arg_13_1] = var_13_1
	end

	local var_13_2 = var_13_1._tf

	var_4.SetSiblingIndex(var_13_2, arg_13_1 - 1)
	var_13_1:Enable()
	var_13_1:Update(arg_13_2)

	onToggle = var_4

	local var_13_3 = arg_13_0
	local var_13_4 = var_13_1._tf

	local function var_13_5(arg_14_0)
		if arg_14_0 then
			arg_13_0.selSkill = arg_13_2
			arg_13_0.selIndex = arg_13_1
		end

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_13_3, var_13_4, var_13_5, var_1_10009)

	return
end

function var_0_1.ClearShipCards(arg_15_0, arg_15_1, arg_15_2)
	for iter_15_0 = #arg_15_1, arg_15_2 + 1, -1 do
		local var_15_0 = arg_15_1[iter_15_0]

		var_7.Disable(var_15_0)
	end

	return
end

function var_0_1.UpdateEmptySkill(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0

	if not arg_16_0.emptyTpls[arg_16_1] then
		Object = var_1_10004
		var_16_0 = var_1_10004.Instantiate(arg_16_0.emptyTpl, arg_16_0.emptyTpl.parent)
		arg_16_0.emptyTpls[arg_16_1] = var_16_0
	end

	var_16_0:SetSiblingIndex(arg_16_2 - 1)

	setActive = var_4

	var_4(var_16_0, true)

	return
end

function var_0_1.ClearEmtptyTpls(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0 = #arg_17_1, arg_17_2 + 1, -1 do
		setActive = var_1_10007

		var_1_10007(arg_17_1[iter_17_0], false)
	end

	return
end

function var_0_1.OnDestroy(arg_18_0)
	if arg_18_0:isShowing() then
		arg_18_0:Hide()
	end

	ipairs = var_1

	for iter_18_0, iter_18_1 in var_1(arg_18_0.skillCards) do
		iter_18_1:Dispose()
	end

	arg_18_0.skillCards = nil

	return
end

return var_0_1
