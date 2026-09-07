local AttireScene = class("AttireScene", import("..base.BaseUI"))

AttireScene.PAGE_ICONFRAME = 1
AttireScene.PAGE_CHATFRAME = 2
AttireScene.PAGE_ACHIEVEMENT = 3

function AttireScene:getUIName()
	return "AttireUI"
end

function AttireScene:setAttires(arg_2_1)
	self.rawAttireVOs = arg_2_1

	self:updateTips(getProxy(AttireProxy):needTip(arg_2_1))

	return
end

function AttireScene:setPlayer(arg_3_1)
	self.playerVO = arg_3_1

	return
end

function AttireScene:init()
	self.backBtn = self._tf:Find("blur_panel/adapt/top/back_btn")
	self.blurPanel = self._tf:Find("blur_panel")
	self.toggles = {
		self.blurPanel:Find("adapt/left_length/frame/tagRoot/iconframe"),
		self.blurPanel:Find("adapt/left_length/frame/tagRoot/chatframe"),
		self.blurPanel:Find("adapt/left_length/frame/tagRoot/achievement"),
		self.blurPanel:Find("adapt/left_length/frame/tagRoot/combatUI"),
		self.blurPanel:Find("adapt/left_length/frame/tagRoot/loadingpic")
	}
	self.panels = {
		AttireIconFramePanel.New(self._tf, self.event, self.contextData),
		AttireChatFramePanel.New(self._tf, self.event, self.contextData),
		AttireAchievementPanel.New(self._tf, self.event, self.contextData),
		AttireCombatUIPanel.New(self._tf, self.event, self.contextData),
		AttireLoadingPicPanel.New(self._tf, self.event, self.contextData)
	}

	return
end

function AttireScene:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(AttireScene.ON_BACK)

		return
	end, SOUND_BACK)

	for iter_5_0, iter_5_1 in ipairs(self.toggles) do
		onToggle(self, iter_5_1, function(arg_7_0)
			if arg_7_0 then
				self:switchPage(iter_5_0)
			end

			return
		end, SFX_PANEL)
	end

	triggerToggle(self.toggles[self.contextData.index or AttireScene.PAGE_ICONFRAME], true)

	return
end

function AttireScene:switchPage(arg_8_1)
	if self.page then
		self.panels[self.page]:ActionInvoke("Hide")
	end

	self.page = arg_8_1

	self.panels[self.page]:Load()
	self.panels[self.page]:ActionInvoke("Show")
	self:updateCurrPage()

	return
end

function AttireScene:updateCurrPage()
	assert(self.page)
	self.panels[self.page]:ActionInvoke("Update", self.rawAttireVOs, self.playerVO)

	return
end

function AttireScene:updateTips(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		setActive(self.toggles[iter_10_0]:Find("tip"), iter_10_1)
	end

	return
end

function AttireScene:onBackPressed()
	if self.panels[self.page].onBackPressed and self.panels[self.page]:onBackPressed() then
		-- block empty
	else
		AttireScene.super.onBackPressed(self)
	end

	return
end

function AttireScene:willExit()
	for iter_12_0, iter_12_1 in ipairs(self.panels) do
		iter_12_1:Destroy()
	end

	return
end

return AttireScene
