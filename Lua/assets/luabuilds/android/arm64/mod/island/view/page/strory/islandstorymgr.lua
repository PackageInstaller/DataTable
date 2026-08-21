local var_0_0 = class("IslandStoryMgr", import("view.base.BaseSubView"))

var_0_0.START_STORY = "IslandStoryMgr:START_STORY"
var_0_0.END_STORY = "IslandStoryMgr:END_STORY"

local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = Color.New(1, 0.8705, 0.4196, 1)
local var_0_5 = Color.New(1, 1, 1, 1)

function var_0_0.getUIName(arg_1_0)
	return "IslandStoryUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.skipBtn = arg_2_0._tf:Find("front/btns/btns/skip_button")
	arg_2_0.logBtn = arg_2_0._tf:Find("front/btns/record")
	arg_2_0.autoBtn = arg_2_0._tf:Find("front/btns/btns/auto_button")
	arg_2_0.autoBtnImg = findTF(arg_2_0._tf, "front/btns/btns/auto_button/sel"):GetComponent(typeof(Image))
	arg_2_0.animator = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.aniDft = arg_2_0._tf:GetComponent(typeof(DftAniEvent))
	arg_2_0.canvasGroup = GetOrAddComponent(arg_2_0._tf, typeof(CanvasGroup))
	arg_2_0.player = Dialogue3DPlayer.New(arg_2_0)
	arg_2_0.recordPanel = IslandStoryRecordPanel.New(arg_2_0)
	arg_2_0.recorder = IslandStoryRecorder.New()
	arg_2_0.setSpeedPanel = StorySetSpeedPanel.New(arg_2_0._tf, function(arg_3_0)
		if arg_2_0:IsRunning() and arg_2_0.script then
			arg_2_0.script:SetPlaySpeed(arg_3_0)
		end

		return
	end)

	setActive(arg_2_0._go, false)

	arg_2_0.state = var_0_1

	return
end

function var_0_0.Play(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not _IslandCore then
		return
	end

	if arg_4_0:IsRunning() then
		arg_4_3()

		return
	end

	local var_4_0 = _IslandCore:GetView():GetAllUnits()

	arg_4_0.refreshNpc = defaultValue(arg_4_2, true)
	arg_4_0.state = var_0_2

	local var_4_1 = IslandStory.New(pg.NewStoryMgr.GetInstance():GetScript(arg_4_1), var_4_0, IslandStory.MODE_DIALOGUE)

	arg_4_0.script = var_4_1

	arg_4_0:StartScript(var_4_1)
	table.insert({}, function(arg_5_0)
		arg_4_0:WaitForViewLoaded(_IslandCore:GetView(), arg_5_0)

		return
	end)
	table.insert({}, function(arg_6_0)
		arg_4_0.player:OnStartAction(var_4_1, arg_6_0)

		return
	end)

	for iter_4_0, iter_4_1 in ipairs(var_4_1.steps) do
		table.insert({}, function(arg_7_0)
			if arg_4_0.isStop then
				arg_7_0()

				return
			end

			arg_4_0.player:Play(arg_4_0.recorder, iter_4_0, var_4_1, arg_7_0)

			return
		end)
	end

	table.insert({}, function(arg_8_0)
		arg_4_0.player:OnEndAction(var_4_1, arg_8_0)

		return
	end)
	table.insert({}, function(arg_9_0)
		arg_4_0:PlayExitAniamtion(var_4_1, arg_9_0)

		return
	end)
	seriesAsync({}, function()
		arg_4_0:EndScript(var_4_1)

		if arg_4_3 then
			arg_4_3()
		end

		if arg_4_1 == IslandGuideChecker.SIGNIN_STORY_NAME then
			IslandGuideChecker.CheckGuide("ISLAND_GUIDE_26")
		end

		return
	end)

	return
end

function var_0_0.WaitForViewLoaded(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:RemoveTimer()

	if arg_11_1:IsLoaded() then
		arg_11_2()

		return
	end

	arg_11_0.timer = Timer.New(function()
		if arg_11_1:IsLoaded() then
			arg_11_0:RemoveTimer()
			arg_11_2()
		end

		return
	end, 0.1, -1)

	arg_11_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_13_0, ...)
	if arg_13_0.timer then
		arg_13_0.timer:Stop()

		arg_13_0.timer = nil
	end

	return
end

function var_0_0.StartScript(arg_14_0, arg_14_1)
	arg_14_0.isStop = false
	arg_14_0.canvasGroup.blocksRaycasts = true

	arg_14_0.recorder:Clear()
	setActive(arg_14_0._go, true)
	arg_14_0:RegisterSkipBtn()
	arg_14_0:RegisterLogBtn()
	arg_14_0:RegisterAutoBtn()
	arg_14_0.player:OnStart(arg_14_1)
	pg.m02:sendNotification(GAME.STORY_UPDATE, {
		storyId = arg_14_1.id,
		callback = function()
			IslandTaskHelper.UpdateRuntimeTaskByTargetType(IslandTaskTargetType.STORY)

			return
		end
	})
	arg_14_0:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.STORY_START)

	return
end

function var_0_0.RegisterAutoBtn(arg_16_0)
	onButton(arg_16_0, arg_16_0.autoBtn, function()
		if not arg_16_0.script then
			return
		end

		if arg_16_0.script:GetAutoPlayFlag() then
			arg_16_0.script:StopAutoPlay()
			arg_16_0.player:CancelAuto()
		else
			arg_16_0.script:SetAutoPlay()
			arg_16_0.player:NextOne()
		end

		arg_16_0:UpdateAutoBtn()

		return
	end, SFX_PANEL)
	arg_16_0:UpdateAutoBtn()

	return
end

function var_0_0.UpdateAutoBtn(arg_18_0)
	arg_18_0:ClearAutoBtn((arg_18_0.script:GetAutoPlayFlag()))

	return
end

function var_0_0.ClearAutoBtn(arg_19_0, arg_19_1)
	if not arg_19_0.script then
		return
	end

	local var_19_0 = arg_19_0.autoBtnImg

	if arg_19_1 then
		var_19_0.color = var_0_4 or var_0_5

		arg_19_0.setSpeedPanel[arg_19_1 and "Show" or "Hide"](arg_19_0.setSpeedPanel, arg_19_0.script)

		return
	end
end

function var_0_0.RegisterSkipBtn(arg_20_0)
	onButton(arg_20_0, arg_20_0.skipBtn, function()
		arg_20_0.script:MarkSkipAll()
		arg_20_0.player:NextOne()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.RegisterLogBtn(arg_22_0)
	onButton(arg_22_0, arg_22_0.logBtn, function()
		if not arg_22_0.recordPanel:CanOpen() then
			return
		end

		if arg_22_0.script:GetAutoPlayFlag() then
			arg_22_0.script:StopAutoPlay()
			arg_22_0.player:CancelAuto()
			arg_22_0:UpdateAutoBtn()
		end

		arg_22_0.recordPanel:Show(arg_22_0.recorder)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.PlayExitAniamtion(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1:LastStepIsTimeline() then
		if arg_24_2 then
			arg_24_2()
		end

		return
	end

	arg_24_0.aniDft:SetEndEvent(function()
		if arg_24_2 then
			arg_24_2()
		end

		return
	end)

	arg_24_0.canvasGroup.blocksRaycasts = false

	arg_24_0.animator:Play("anim_IslandStoryUI_Dialogue_Out")

	return
end

function var_0_0.EndScript(arg_26_0, arg_26_1)
	arg_26_0.isStop = false
	arg_26_0.canvasGroup.blocksRaycasts = true

	arg_26_0.aniDft:SetEndEvent(nil)
	setActive(arg_26_0._go, false)
	removeOnButton(arg_26_0.skipBtn)
	removeOnButton(arg_26_0.logBtn)
	arg_26_0:ClearAutoBtn(false)
	arg_26_0.recorder:Clear()
	arg_26_0.recordPanel:Hide()
	arg_26_0.setSpeedPanel:Clear()

	arg_26_0.state = var_0_3
	arg_26_0.script = nil

	arg_26_0:RemoveTimer()
	arg_26_0.player:OnEnd(arg_26_1)
	arg_26_0:emit(IslandBaseScene.LINK_CORE_EVENT, IslandProxy.STORY_END, arg_26_0.refreshNpc)

	arg_26_0.refreshNpc = nil

	return
end

function var_0_0.IsRunning(arg_27_0)
	return arg_27_0.state == var_0_2
end

function var_0_0.Stop(arg_28_0)
	if arg_28_0.isStop then
		return
	end

	if not arg_28_0:IsRunning() then
		return
	end

	arg_28_0.isStop = true

	arg_28_0.player:NextOne()

	return
end

function var_0_0.onBackPressed(arg_29_0)
	if arg_29_0.recordPanel and arg_29_0.recordPanel:IsShowing() then
		arg_29_0.recordPanel:Hide()

		return true
	end

	if arg_29_0:IsRunning() then
		arg_29_0:Stop()

		return true
	end

	return false
end

function var_0_0.OnDestroy(arg_30_0)
	arg_30_0.recorder:Dispose()
	arg_30_0.recordPanel:Dispose()
	arg_30_0.setSpeedPanel:Dispose()
	arg_30_0.player:Dispose()

	return
end

return var_0_0
