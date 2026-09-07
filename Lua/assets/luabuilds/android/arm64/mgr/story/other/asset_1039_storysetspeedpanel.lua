local StorySetSpeedPanel = class("StorySetSpeedPanel")
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

function StorySetSpeedPanel:Ctor(arg_3_1, arg_3_2)
	pg.DelegateInfo.New(self)

	self._tf = arg_3_1
	self.speedBtn = findTF(self._tf, "front/btns/btns/speed")
	self.speedImg = self.speedBtn:Find("Text"):GetComponent(typeof(Image))
	self.speedAnim = self.speedBtn:GetComponent(typeof(Animation))
	self.speedAniEvent = self.speedBtn:GetComponent(typeof(DftAniEvent))
	self.speedPanel = findTF(self._tf, "front/speed_panel")
	self.speedList = {
		self.speedPanel:Find("adpter/frame/content/0.5"),
		self.speedPanel:Find("adpter/frame/content/1"),
		self.speedPanel:Find("adpter/frame/content/2"),
		self.speedPanel:Find("adpter/frame/content/10")
	}
	self.speedPanelImg = self.speedPanel:Find("adpter/frame/speed/Text"):GetComponent(typeof(Image))
	self.speedPanelAnim = self.speedPanel:GetComponent(typeof(Animation))
	self.speedPanelAniEvent = self.speedPanel:GetComponent(typeof(DftAniEvent))
	self.onUpdate = arg_3_2

	self:Init()

	return
end

function StorySetSpeedPanel:Init()
	onButton(self, self.speedBtn, function()
		self:ShowSettings()

		return
	end, SFX_PANEL)
	onButton(self, self.speedPanel, function()
		if self.speedPanelStatus == var_0_5 then
			self:ShowSettings()
		elseif self.speedPanelStatus == var_0_3 then
			self:HideSettings()
		end

		return
	end, SFX_PANEL)

	for iter_4_0, iter_4_1 in ipairs(self.speedList) do
		onButton(self, iter_4_1, function()
			if self.onUpdate then
				self.onUpdate(Story.STORY_AUTO_SPEED[iter_4_0])
			end

			self:HideSettings()

			return
		end, SFX_PANEL)
	end

	self.speedPanelStatus = var_0_3

	return
end

function StorySetSpeedPanel:Show(arg_8_1)
	self.story = arg_8_1

	setActive(self.speedBtn, true)
	setActiveByCanvasGroup(self.speedBtn, true)

	self.speedImg.sprite = GetSpriteFromAtlas("ui/story_atlas", var_0_7(arg_8_1))

	self.speedImg:SetNativeSize()
	self.speedAniEvent:SetEndEvent(function()
		setActive(self.speedBtn, false)
		self.speedAniEvent:SetEndEvent(nil)

		return
	end)
	self.speedAnim:Stop()
	self.speedAnim:Play("anim_newstoryUI_speed_in")

	return
end

function StorySetSpeedPanel:Hide()
	self:RemoveTimer()
	self.speedAnim:Stop()
	self.speedAnim:Play("anim_newstoryUI_speed_out")

	return
end

function StorySetSpeedPanel:ShowSettings()
	setActiveByCanvasGroup(self.speedBtn, false)
	setActive(self.speedPanel, true)

	local var_11_0 = var_0_7(self.story)

	self.speedPanelImg.sprite = GetSpriteFromAtlas("ui/story_atlas", var_11_0)

	self.speedPanelImg:SetNativeSize()

	for iter_11_0, iter_11_1 in ipairs(self.speedList) do
		if iter_11_1.name == var_11_0 then
			iter_11_1:Find("Text"):GetComponent(typeof(Image)).color = var_0_1 or var_0_2
		end
	end

	self.speedPanelAniEvent:SetEndEvent(function()
		if self.speedPanelStatus == var_0_5 then
			setActive(self.speedPanel, false)
			self.speedPanelAniEvent:SetEndEvent(nil)
		elseif self.speedPanelStatus == var_0_3 then
			-- block empty
		end

		self.speedPanelStatus = var_0_3

		return
	end)
	self.speedPanelAnim:Stop()
	self.speedPanelAnim:Play("anim_newstoryUI_speedpanel_in")

	self.speedPanelStatus = var_0_4

	self:AddHideSettingsTimer()

	return
end

function StorySetSpeedPanel:AddHideSettingsTimer()
	self:RemoveTimer()

	self.timer = Timer.New(function()
		self:HideSettings()

		return
	end, 5, 1)

	self.timer:Start()

	return
end

function StorySetSpeedPanel:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function StorySetSpeedPanel:HideSettings()
	self:RemoveTimer()
	self:Show(self.story)
	self.speedPanelAnim:Stop()
	self.speedPanelAnim:Play("anim_newstoryUI_speedpanel_out")

	self.speedPanelStatus = var_0_5

	return
end

function StorySetSpeedPanel:Clear()
	self:RemoveTimer()
	setActive(self.speedBtn, false)
	setActiveByCanvasGroup(self.speedBtn, true)
	setActive(self.speedPanel, false)
	self.speedAnim:Stop()
	self.speedPanelAnim:Stop()

	return
end

function StorySetSpeedPanel:Dispose()
	self:Clear()

	return
end

return StorySetSpeedPanel
