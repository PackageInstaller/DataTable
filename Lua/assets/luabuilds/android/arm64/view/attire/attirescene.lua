local var_0_0 = class("AttireScene", import("..base.BaseUI"))

var_0_0.PAGE_ICONFRAME = 1
var_0_0.PAGE_CHATFRAME = 2
var_0_0.PAGE_ACHIEVEMENT = 3

function var_0_0.getUIName(arg_1_0)
	return "AttireUI"
end

function var_0_0.setAttires(arg_2_0, arg_2_1)
	arg_2_0.rawAttireVOs = arg_2_1

	arg_2_0:updateTips(getProxy(AttireProxy):needTip(arg_2_1))

	return
end

function var_0_0.setPlayer(arg_3_0, arg_3_1)
	arg_3_0.playerVO = arg_3_1

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0.backBtn = arg_4_0._tf:Find("blur_panel/adapt/top/back_btn")
	arg_4_0.blurPanel = arg_4_0._tf:Find("blur_panel")
	arg_4_0.toggles = {
		arg_4_0.blurPanel:Find("adapt/left_length/frame/tagRoot/iconframe"),
		arg_4_0.blurPanel:Find("adapt/left_length/frame/tagRoot/chatframe"),
		arg_4_0.blurPanel:Find("adapt/left_length/frame/tagRoot/achievement"),
		arg_4_0.blurPanel:Find("adapt/left_length/frame/tagRoot/combatUI"),
		arg_4_0.blurPanel:Find("adapt/left_length/frame/tagRoot/loadingpic")
	}
	arg_4_0.panels = {
		AttireIconFramePanel.New(arg_4_0._tf, arg_4_0.event, arg_4_0.contextData),
		AttireChatFramePanel.New(arg_4_0._tf, arg_4_0.event, arg_4_0.contextData),
		AttireAchievementPanel.New(arg_4_0._tf, arg_4_0.event, arg_4_0.contextData),
		AttireCombatUIPanel.New(arg_4_0._tf, arg_4_0.event, arg_4_0.contextData),
		AttireLoadingPicPanel.New(arg_4_0._tf, arg_4_0.event, arg_4_0.contextData)
	}

	return
end

function var_0_0.didEnter(arg_5_0)
	onButton(arg_5_0, arg_5_0.backBtn, function()
		arg_5_0:emit(var_0_0.ON_BACK)

		return
	end, SOUND_BACK)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.toggles) do
		onToggle(arg_5_0, iter_5_1, function(arg_7_0)
			if arg_7_0 then
				arg_5_0:switchPage(iter_5_0)
			end

			return
		end, SFX_PANEL)
	end

	local var_5_0 = arg_5_0.contextData.index or var_0_0.PAGE_ICONFRAME

	triggerToggle(arg_5_0.toggles[var_5_0], true)

	return
end

function var_0_0.switchPage(arg_8_0, arg_8_1)
	if arg_8_0.page then
		arg_8_0.panels[arg_8_0.page]:ActionInvoke("Hide")
	end

	arg_8_0.page = arg_8_1

	arg_8_0.panels[arg_8_0.page]:Load()
	arg_8_0.panels[arg_8_0.page]:ActionInvoke("Show")
	arg_8_0:updateCurrPage()

	return
end

function var_0_0.updateCurrPage(arg_9_0)
	assert(arg_9_0.page)
	arg_9_0.panels[arg_9_0.page]:ActionInvoke("Update", arg_9_0.rawAttireVOs, arg_9_0.playerVO)

	return
end

function var_0_0.updateTips(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		setActive(arg_10_0.toggles[iter_10_0]:Find("tip"), iter_10_1)
	end

	return
end

function var_0_0.onBackPressed(arg_11_0)
	if arg_11_0.panels[arg_11_0.page].onBackPressed and arg_11_0.panels[arg_11_0.page]:onBackPressed() then
		-- block empty
	else
		var_0_0.super.onBackPressed(arg_11_0)
	end

	return
end

function var_0_0.willExit(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.panels) do
		iter_12_1:Destroy()
	end

	return
end

return var_0_0
