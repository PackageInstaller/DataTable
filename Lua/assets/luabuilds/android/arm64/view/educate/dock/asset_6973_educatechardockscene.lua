local EducateCharDockScene = class("EducateCharDockScene", import("view.base.BaseUI"))

EducateCharDockScene.ON_CLOSE_VIEW = "EducateCharDockScene.ON_CLOSE_VIEW"
EducateCharDockScene.ON_SELECT = "EducateCharDockScene.ON_SELECT"
EducateCharDockScene.ON_CONFIRM = "EducateCharDockScene.ON_CONFIRM"
EducateCharDockScene.ON_SELECTED = "EducateCharDockScene.ON_SELECTED"
EducateCharDockScene.MSG_CLEAR_TIP = "EducateCharDockScene.MSG_CLEAR_TIP"

function EducateCharDockScene:getUIName()
	return "EducateCharDockUI"
end

function EducateCharDockScene:init()
	self.backBtn = self._tf:Find("adapt/top/back")
	self.homeBtn = self._tf:Find("adapt/top/home")
	self.selectPage = EducateCharSelectPage.New(self._tf:Find("adapt/pages"), self.event)
	self.groupPage = EducateCharGroupPage.New(self._tf:Find("adapt/pages/groupPage"), self.event, self.contextData)

	return
end

function EducateCharDockScene:didEnter()
	onButton(self, self.backBtn, function()
		if self.contextData.tbSkinId then
			self:closeView()

			return
		end

		if self.selectPage and self.selectPage:GetLoaded() and self.selectPage:isShowing() then
			self.selectPage:Back(function()
				self.groupPage:Show()
				self.groupPage:InitList()
				self.selectPage:Hide()

				return
			end)

			return
		end

		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.homeBtn, function()
		self:emit(EducateCharDockScene.ON_HOME)

		return
	end, SFX_PANEL)
	self:bind(EducateCharDockScene.ON_CLOSE_VIEW, function()
		self:closeView()

		return
	end)
	self:bind(EducateCharDockScene.ON_SELECT, function(arg_8_0, arg_8_1, arg_8_2)
		self.groupPage:Hide()
		self.selectPage:ExecuteAction("Update", arg_8_1, arg_8_2)

		return
	end)
	self:bind(EducateCharDockScene.ON_SELECTED, function(arg_9_0, arg_9_1)
		self:emit(EducateCharDockMediator.ON_SELECTED, arg_9_1)

		return
	end)
	self:bind(EducateCharDockScene.ON_CONFIRM, function(arg_10_0, arg_10_1)
		if self.contextData.tbSkinId then
			self:closeView()

			return
		end

		self.groupPage:Show()
		self.selectPage:Hide()
		self.groupPage:FlushList(arg_10_1)

		return
	end)
	self.groupPage:Update()

	return
end

function EducateCharDockScene:onBackPressed()
	if self.selectPage and self.selectPage:GetLoaded() and self.selectPage:isShowing() then
		triggerButton(self.backBtn)

		return
	end

	EducateCharDockScene.super.onBackPressed(self)

	return
end

function EducateCharDockScene:willExit()
	if self.selectPage then
		self.selectPage:Destroy()

		self.selectPage = nil
	end

	if self.groupPage then
		self.groupPage:Destroy()

		self.groupPage = nil
	end

	return
end

return EducateCharDockScene
