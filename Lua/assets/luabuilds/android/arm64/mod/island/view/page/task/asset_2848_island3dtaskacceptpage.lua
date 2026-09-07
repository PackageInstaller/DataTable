local Island3dTaskAcceptPage = class("Island3dTaskAcceptPage", import("view.base.BaseSubView"))

function Island3dTaskAcceptPage:getUIName()
	return "Island3dTaskAcceptUI"
end

function Island3dTaskAcceptPage:OnLoaded()
	self.chapterText = self._tf:Find("frame/chapter")
	self.nameText = self._tf:Find("frame/name")
	self.tipText = self._tf:Find("frame/tip/Text")

	setText(self.tipText, i18n("island_task_open"))

	return
end

function Island3dTaskAcceptPage:OnInit()
	onButton(self, self._tf, function()
		self:TouchEvent()

		return
	end, SFX_PANEL)

	return
end

function Island3dTaskAcceptPage:TouchEvent()
	local var_5_0 = self._tf:GetComponent(typeof(DftAniEvent))

	var_5_0:SetEndEvent(function()
		var_5_0:SetEndEvent(nil)

		if self.onExit then
			self.onExit()

			self.onExit = nil
		end

		if self.taskId == IslandGuideChecker.FIRST_TASK_ID then
			IslandGuideChecker.CheckGuide("ISLAND_GUIDE_4")
		end

		self:Hide()

		return
	end)
	self._tf:GetComponent(typeof(Animation)):Play("Anim_Island3dTaskAcceptUI_out")

	return
end

function Island3dTaskAcceptPage:Show(arg_7_1, arg_7_2)
	Island3dTaskAcceptPage.super.Show(self)

	self.taskId = arg_7_1

	local var_7_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetTask(self.taskId)

	setText(self.chapterText, var_7_0:getConfig("series"))
	setText(self.nameText, var_7_0:getConfig("series_name"))

	self.onExit = arg_7_2

	return
end

function Island3dTaskAcceptPage:OnDestroy()
	return
end

return Island3dTaskAcceptPage
