local var_0_0 = class("CoreStoryTemplatePage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("bg_story")
	arg_1_0.ad = arg_1_0._tf:Find("AD")
	arg_1_0.goBtn = arg_1_0._tf:Find("AD/go_btn")
	arg_1_0.scenario = CoreScenarioTemplatePage.New(arg_1_0._tf)

	arg_1_0.scenario:SetCoreStoryPage(arg_1_0)

	arg_1_0.loader = AutoLoader.New()
	arg_1_0.mapGroup = {}
	arg_1_0.currentBG = nil

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.goBtn, function()
		arg_2_0.scenario:Load()
		arg_2_0.scenario:SetActivity(arg_2_0.activity)
		arg_2_0.scenario:UpdateStoryTask()
		arg_2_0.scenario:ActionInvoke("UpdateView")
		arg_2_0:ShowScenarioLayer(true)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShowFlush(arg_4_0)
	var_0_0.super.OnShowFlush(arg_4_0)

	if arg_4_0.coreActivityUI.contextData.activeScenario then
		arg_4_0.scenario.needFocusStory = true

		triggerButton(arg_4_0.goBtn)
	end

	return
end

function var_0_0.SwitchBG(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_1 or #arg_5_1 <= 0 then
		existCall(arg_5_2)

		return
	elseif arg_5_3 then
		-- block empty
	elseif table.equal(arg_5_0.currentBG, arg_5_1) then
		return
	end

	arg_5_0.currentBG = arg_5_1

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.mapGroup) do
		arg_5_0.loader:ClearRequest(iter_5_1)
	end

	table.clear(arg_5_0.mapGroup)
	table.insert(arg_5_0.mapGroup, (arg_5_0.loader:GetSpriteDirect("bg/" .. arg_5_1[1].BG, "", function(arg_6_0)
		setImageSprite(arg_5_0.bg, arg_6_0)
		SetActive(arg_5_0.bg, true)

		return
	end)))

	return
end

function var_0_0.ShowScenarioLayer(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.scenario:ActionInvoke("Show")
		arg_7_0.coreActivityUI:ActiveScenarioLayer(true)
		SetActive(arg_7_0.ad, false)
		SetActive(arg_7_0.bg, true)
	else
		arg_7_0.scenario:Hide()
		arg_7_0.coreActivityUI:ActiveScenarioLayer(false)
		SetActive(arg_7_0.ad, true)
		SetActive(arg_7_0.bg, false)
	end

	return
end

function var_0_0.IsShowingPopWindow(arg_8_0)
	return arg_8_0.scenario:isShowing()
end

function var_0_0.ClosePopWindow(arg_9_0)
	arg_9_0.scenario:Hide()
	arg_9_0:ShowScenarioLayer(false)

	return
end

return var_0_0
