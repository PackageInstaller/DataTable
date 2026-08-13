class = var_0_10000

local var_0_0 = "AttireScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.PAGE_ICONFRAME = 1
var_0_1.PAGE_CHATFRAME = 2
var_0_1.PAGE_ACHIEVEMENT = 3

function var_0_1.getUIName(arg_1_0)
	return "AttireUI"
end

function var_0_1.setAttires(arg_2_0, arg_2_1)
	arg_2_0.rawAttireVOs = arg_2_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.updateTips

	getProxy = var_1_10005
	AttireProxy = var_1_10007

	local var_2_2 = var_1_10005(var_1_10007)

	var_2_1(var_2_0, var_5.needTip(var_2_2, arg_2_1))

	return
end

function var_0_1.setPlayer(arg_3_0, arg_3_1)
	arg_3_0.playerVO = arg_3_1

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.backBtn = var_1.Find(var_4_0, "blur_panel/adapt/top/back_btn")

	local var_4_1 = arg_4_0._tf

	arg_4_0.blurPanel = var_1.Find(var_4_1, "blur_panel")

	local var_4_2 = {}
	local var_4_3 = arg_4_0.blurPanel

	var_4_2[1] = var_2.Find(var_4_3, "adapt/left_length/frame/tagRoot/iconframe")

	local var_4_4 = arg_4_0.blurPanel

	var_4_2[2] = var_2.Find(var_4_4, "adapt/left_length/frame/tagRoot/chatframe")

	local var_4_5 = arg_4_0.blurPanel

	var_4_2[3] = var_2.Find(var_4_5, "adapt/left_length/frame/tagRoot/achievement")

	local var_4_6 = arg_4_0.blurPanel

	var_4_2[4] = var_2.Find(var_4_6, "adapt/left_length/frame/tagRoot/combatUI")

	local var_4_7 = arg_4_0.blurPanel

	var_4_2[5] = var_2.Find(var_4_7, "adapt/left_length/frame/tagRoot/loadingpic")
	arg_4_0.toggles = var_4_2

	local var_4_8 = {}

	AttireIconFramePanel = var_2
	var_4_8[1] = var_2.New(arg_4_0._tf, arg_4_0.event, arg_4_0.contextData)
	AttireChatFramePanel = var_2
	var_4_8[2] = var_2.New(arg_4_0._tf, arg_4_0.event, arg_4_0.contextData)
	AttireAchievementPanel = var_2
	var_4_8[3] = var_2.New(arg_4_0._tf, arg_4_0.event, arg_4_0.contextData)
	AttireCombatUIPanel = var_2
	var_4_8[4] = var_2.New(arg_4_0._tf, arg_4_0.event, arg_4_0.contextData)
	AttireLoadingPicPanel = var_2
	var_4_8[5] = var_2.New(arg_4_0._tf, arg_4_0.event, arg_4_0.contextData)
	arg_4_0.panels = var_4_8

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.backBtn

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.emit(var_6_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	ipairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.toggles) do
		onToggle = var_1_10006

		local var_5_3 = arg_5_0
		local var_5_4 = iter_5_1

		local function var_5_5(arg_7_0)
			if arg_7_0 then
				local var_7_0 = arg_5_0

				var_1.switchPage(var_7_0, iter_5_0)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_5_3, var_5_4, var_5_5, var_1_10011)
	end

	local var_5_6

	if not arg_5_0.contextData.index then
		var_5_6 = var_0_1.PAGE_ICONFRAME
	end

	triggerToggle = var_2

	var_2(arg_5_0.toggles[var_5_6], true)

	return
end

function var_0_1.switchPage(arg_8_0, arg_8_1)
	if arg_8_0.page then
		local var_8_0 = arg_8_0.panels[arg_8_0.page]

		var_2.ActionInvoke(var_8_0, "Hide")
	end

	arg_8_0.page = arg_8_1

	local var_8_1 = arg_8_0.panels[arg_8_0.page]

	var_2.Load(var_8_1)

	local var_8_2 = arg_8_0.panels[arg_8_0.page]

	var_2.ActionInvoke(var_8_2, "Show")
	arg_8_0:updateCurrPage()

	return
end

function var_0_1.updateCurrPage(arg_9_0)
	assert = var_1_10001

	var_1_10001(arg_9_0.page)

	local var_9_0 = arg_9_0.panels[arg_9_0.page]

	var_1.ActionInvoke(var_9_0, "Update", arg_9_0.rawAttireVOs, arg_9_0.playerVO)

	return
end

function var_0_1.updateTips(arg_10_0, arg_10_1)
	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_1) do
		setActive = var_1_10007

		local var_10_0 = arg_10_0.toggles[iter_10_0]

		var_1_10007(var_9.Find(var_10_0, "tip"), iter_10_1)
	end

	return
end

function var_0_1.onBackPressed(arg_11_0)
	if arg_11_0.panels[arg_11_0.page].onBackPressed then
		local var_11_0 = arg_11_0.panels[arg_11_0.page]

		if var_1.onBackPressed(var_11_0) then
			goto label_11_0
		end
	end

	var_0_1.super.onBackPressed(arg_11_0)

	::label_11_0::

	return
end

function var_0_1.willExit(arg_12_0)
	ipairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0.panels) do
		iter_12_1:Destroy()
	end

	return
end

return var_0_1
