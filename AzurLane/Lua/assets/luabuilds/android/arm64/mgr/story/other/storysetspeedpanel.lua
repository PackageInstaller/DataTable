local var_0_0 = class("StorySetSpeedPanel")
local var_0_1 = Color.New(1, 0.8705, 0.4196, 1)
local var_0_2 = Color.New(1, 1, 1, 1)
local var_0_3 = 0
local var_0_4 = 1
local var_0_5 = 2

local function var_0_6(arg_1_0)
	return ({
		"0.5",
		"1",
		"2",
		"10"
	})[arg_1_0]
end

local function var_0_7(arg_2_0)
	local var_2_0 = table.indexof(Story.STORY_AUTO_SPEED, arg_2_0:GetPlaySpeed() or 0)

	if var_2_0 <= 0 or var_2_0 > #Story.STORY_AUTO_SPEED then
		var_2_0 = 1
	end

	return var_0_6(var_2_0)
end

function var_0_0.Ctor(arg_3_0, arg_3_1, arg_3_2)
	pg.DelegateInfo.New(arg_3_0)

	arg_3_0._tf = arg_3_1
	arg_3_0.speedBtn = findTF(arg_3_0._tf, "front/btns/btns/speed")
	arg_3_0.speedImg = arg_3_0.speedBtn:Find("Text"):GetComponent(typeof(Image))
	arg_3_0.speedAnim = arg_3_0.speedBtn:GetComponent(typeof(Animation))
	arg_3_0.speedAniEvent = arg_3_0.speedBtn:GetComponent(typeof(DftAniEvent))
	arg_3_0.speedPanel = findTF(arg_3_0._tf, "front/speed_panel")
	arg_3_0.speedList = {
		arg_3_0.speedPanel:Find("adpter/frame/content/0.5"),
		arg_3_0.speedPanel:Find("adpter/frame/content/1"),
		arg_3_0.speedPanel:Find("adpter/frame/content/2"),
		arg_3_0.speedPanel:Find("adpter/frame/content/10")
	}
	arg_3_0.speedPanelImg = arg_3_0.speedPanel:Find("adpter/frame/speed/Text"):GetComponent(typeof(Image))
	arg_3_0.speedPanelAnim = arg_3_0.speedPanel:GetComponent(typeof(Animation))
	arg_3_0.speedPanelAniEvent = arg_3_0.speedPanel:GetComponent(typeof(DftAniEvent))
	arg_3_0.onUpdate = arg_3_2

	arg_3_0:Init()

	return
end

function var_0_0.Init(arg_4_0)
	onButton(arg_4_0, arg_4_0.speedBtn, function()
		arg_4_0:ShowSettings()

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.speedPanel, function()
		if arg_4_0.speedPanelStatus == var_0_5 then
			arg_4_0:ShowSettings()
		elseif arg_4_0.speedPanelStatus == var_0_3 then
			arg_4_0:HideSettings()
		end

		return
	end, SFX_PANEL)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.speedList) do
		onButton(arg_4_0, iter_4_1, function()
			if arg_4_0.onUpdate then
				arg_4_0.onUpdate(Story.STORY_AUTO_SPEED[iter_4_0])
			end

			arg_4_0:HideSettings()

			return
		end, SFX_PANEL)
	end

	arg_4_0.speedPanelStatus = var_0_3

	return
end

function var_0_0.Show(arg_8_0, arg_8_1)
	arg_8_0.story = arg_8_1

	setActive(arg_8_0.speedBtn, true)
	setActiveByCanvasGroup(arg_8_0.speedBtn, true)

	arg_8_0.speedImg.sprite = GetSpriteFromAtlas("ui/story_atlas", var_0_7(arg_8_1))

	arg_8_0.speedImg:SetNativeSize()
	arg_8_0.speedAniEvent:SetEndEvent(function()
		setActive(arg_8_0.speedBtn, false)
		arg_8_0.speedAniEvent:SetEndEvent(nil)

		return
	end)
	arg_8_0.speedAnim:Stop()
	arg_8_0.speedAnim:Play("anim_newstoryUI_speed_in")

	return
end

function var_0_0.Hide(arg_10_0)
	arg_10_0:RemoveTimer()
	arg_10_0.speedAnim:Stop()
	arg_10_0.speedAnim:Play("anim_newstoryUI_speed_out")

	return
end

function var_0_0.ShowSettings(arg_11_0)
	setActiveByCanvasGroup(arg_11_0.speedBtn, false)
	setActive(arg_11_0.speedPanel, true)

	local var_11_0 = var_0_7(arg_11_0.story)

	arg_11_0.speedPanelImg.sprite = GetSpriteFromAtlas("ui/story_atlas", var_11_0)

	arg_11_0.speedPanelImg:SetNativeSize()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.speedList) do
		local var_11_1 = iter_11_1:Find("Text"):GetComponent(typeof(Image))

		if iter_11_1.name == var_11_0 then
			var_11_1.color = var_0_1 or var_0_2
		end
	end

	arg_11_0.speedPanelAniEvent:SetEndEvent(function()
		if arg_11_0.speedPanelStatus == var_0_5 then
			setActive(arg_11_0.speedPanel, false)
			arg_11_0.speedPanelAniEvent:SetEndEvent(nil)
		elseif arg_11_0.speedPanelStatus == var_0_3 then
			-- block empty
		end

		arg_11_0.speedPanelStatus = var_0_3

		return
	end)
	arg_11_0.speedPanelAnim:Stop()
	arg_11_0.speedPanelAnim:Play("anim_newstoryUI_speedpanel_in")

	arg_11_0.speedPanelStatus = var_0_4

	arg_11_0:AddHideSettingsTimer()

	return
end

function var_0_0.AddHideSettingsTimer(arg_13_0)
	arg_13_0:RemoveTimer()

	arg_13_0.timer = Timer.New(function()
		arg_13_0:HideSettings()

		return
	end, 5, 1)

	arg_13_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_15_0)
	if arg_15_0.timer then
		arg_15_0.timer:Stop()

		arg_15_0.timer = nil
	end

	return
end

function var_0_0.HideSettings(arg_16_0)
	arg_16_0:RemoveTimer()
	arg_16_0:Show(arg_16_0.story)
	arg_16_0.speedPanelAnim:Stop()
	arg_16_0.speedPanelAnim:Play("anim_newstoryUI_speedpanel_out")

	arg_16_0.speedPanelStatus = var_0_5

	return
end

function var_0_0.Clear(arg_17_0)
	arg_17_0:RemoveTimer()
	setActive(arg_17_0.speedBtn, false)
	setActiveByCanvasGroup(arg_17_0.speedBtn, true)
	setActive(arg_17_0.speedPanel, false)
	arg_17_0.speedAnim:Stop()
	arg_17_0.speedPanelAnim:Stop()

	return
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0:Clear()

	return
end

return var_0_0
