class = var_0_10000

local var_0_0 = "CoreStoryTemplatePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "bg_story")

	local var_1_1 = arg_1_0._tf

	arg_1_0.ad = var_1.Find(var_1_1, "AD")

	local var_1_2 = arg_1_0._tf

	arg_1_0.goBtn = var_1.Find(var_1_2, "AD/go_btn")
	CoreScenarioTemplatePage = var_1
	arg_1_0.scenario = var_1.New(arg_1_0._tf)

	local var_1_3 = arg_1_0.scenario

	var_1.SetCoreStoryPage(var_1_3, arg_1_0)

	AutoLoader = var_1
	arg_1_0.loader = var_1.New()
	arg_1_0.mapGroup = {}
	arg_1_0.currentBG = nil

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.goBtn

	local function var_2_2()
		local var_3_0 = arg_2_0.scenario

		var_0.Load(var_3_0)

		local var_3_1 = arg_2_0.scenario

		var_0.SetActivity(var_3_1, arg_2_0.activity)

		local var_3_2 = arg_2_0.scenario

		var_0.UpdateStoryTask(var_3_2)

		local var_3_3 = arg_2_0.scenario

		var_0.ActionInvoke(var_3_3, "UpdateView")

		local var_3_4 = arg_2_0

		var_0.ShowScenarioLayer(var_3_4, true)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	return
end

function var_0_1.OnShowFlush(arg_4_0)
	var_0_1.super.OnShowFlush(arg_4_0)

	if arg_4_0.coreActivityUI.contextData.activeScenario then
		local var_4_0 = arg_4_0.scenario

		var_4_0.needFocusStory = true
		triggerButton = var_4_0

		var_4_0(arg_4_0.goBtn)
	end

	return
end

function var_0_1.SwitchBG(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_1 or #arg_5_1 <= 0 then
		existCall = var_1_10004

		var_1_10004(arg_5_2)

		return
	elseif arg_5_3 then
		-- block empty
	else
		table = var_1_10004

		if var_1_10004.equal(arg_5_0.currentBG, arg_5_1) then
			return
		end
	end

	arg_5_0.currentBG = arg_5_1
	ipairs = var_1_10004

	for iter_5_0, iter_5_1 in var_1_10004(arg_5_0.mapGroup) do
		local var_5_0 = arg_5_0.loader

		var_9.ClearRequest(var_5_0, iter_5_1)
	end

	table = var_4

	var_4.clear(arg_5_0.mapGroup)

	local var_5_1 = arg_5_0.loader
	local var_5_2 = var_4.GetSpriteDirect(var_5_1, "bg/" .. arg_5_1[1].BG, "", function(arg_6_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_5_0.bg, arg_6_0)

		SetActive = var_2_10001

		var_2_10001(arg_5_0.bg, true)

		return
	end)

	table = var_5

	var_5.insert(arg_5_0.mapGroup, var_5_2)

	return
end

function var_0_1.ShowScenarioLayer(arg_7_0, arg_7_1)
	if arg_7_1 then
		local var_7_0 = arg_7_0.scenario

		var_2.ActionInvoke(var_7_0, "Show")

		local var_7_1 = arg_7_0.coreActivityUI

		var_2.ActiveScenarioLayer(var_7_1, true)

		SetActive = var_2

		var_2(arg_7_0.ad, false)

		SetActive = var_2

		var_2(arg_7_0.bg, true)
	else
		local var_7_2 = arg_7_0.scenario

		var_2.Hide(var_7_2)

		local var_7_3 = arg_7_0.coreActivityUI

		var_2.ActiveScenarioLayer(var_7_3, false)

		SetActive = var_2

		var_2(arg_7_0.ad, true)

		SetActive = var_2

		var_2(arg_7_0.bg, false)
	end

	return
end

function var_0_1.IsShowingPopWindow(arg_8_0)
	local var_8_0 = arg_8_0.scenario

	return var_1.isShowing(var_8_0)
end

function var_0_1.ClosePopWindow(arg_9_0)
	local var_9_0 = arg_9_0.scenario

	var_1.Hide(var_9_0)
	arg_9_0:ShowScenarioLayer(false)

	return
end

return var_0_1
