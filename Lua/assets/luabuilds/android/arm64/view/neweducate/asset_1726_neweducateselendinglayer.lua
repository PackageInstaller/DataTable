local NewEducateSelEndingLayer = class("NewEducateSelEndingLayer", import("view.newEducate.base.NewEducateBaseUI"))

function NewEducateSelEndingLayer:getUIName()
	return "NewEducateSelEndingUI"
end

function NewEducateSelEndingLayer:init()
	self.rootTF = self._tf:Find("root")
	self.blurPanel = self.rootTF:Find("bg")
	self.scrollrect = self.blurPanel:Find("window/view")

	local var_2_0 = self.blurPanel:Find("window/view/content")

	self.uiList = UIItemList.New(var_2_0, var_2_0:Find("tpl"))

	self.uiList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventInit then
			self:InitItem(arg_3_1, arg_3_2)
		elseif arg_3_0 == UIItemList.EventUpdate then
			setActive(arg_3_2:Find("selected"), self.selectedIdx == arg_3_1 + 1)
		end

		return
	end)

	self.sureBtn = self.blurPanel:Find("window/sure_btn")

	setText(self.sureBtn:Find("Image"), i18n("word_ok"))

	return
end

function NewEducateSelEndingLayer:didEnter()
	self:OverlayPanel(self.blurPanel, {
		groupDelta = 1,
		pbList = {
			self.blurPanel
		}
	})
	onButton(self, self.sureBtn, function()
		self:emit(NewEducateSelEndingMediator.ON_SELECT_ENDING, self.endingList[self.selectedIdx])

		return
	end, SFX_PANEL)

	self.selectedIdx = 1

	self:RefreshView()

	return
end

function NewEducateSelEndingLayer:InitItem(arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1 + 1

	setScrollText(arg_6_2:Find("name_mask/name"), pg.child2_ending[self.endingList[arg_6_1 + 1]].name)
	LoadImageSpriteAsync("neweducateicon/" .. pg.child2_ending[self.endingList[arg_6_1 + 1]].pic_preview, arg_6_2:Find("Image"))
	setActive(arg_6_2:Find("complete"), table.contains(self.completeList, self.endingList[arg_6_1 + 1]))
	onButton(self, arg_6_2, function()
		self.selectedIdx = var_6_0

		self.uiList:align(#self.endingList)

		return
	end, SFX_PANEL)

	return
end

function NewEducateSelEndingLayer:RefreshView()
	self.endingList = self.contextData.char:GetFSM():GetState(NewEducateFSM.SYSTEM.ENDING):GetEndings()
	self.completeList = self.contextData.char:GetPermanentData():GetFinishedEndings()

	table.sort(self.endingList, CompareFuncs({
		function(arg_9_0)
			return table.contains(self.completeList, arg_9_0) and 1 or 0
		end,
		function(arg_10_0)
			return -arg_10_0
		end
	}))
	self.uiList:align(#self.endingList)
	scrollTo(self.scrollrect, self.uiList.container.rect.width / 2, 0)

	return
end

function NewEducateSelEndingLayer:OnSelDone(arg_11_1)
	NewEducateHelper.PlaySpecialStory(pg.child2_ending[arg_11_1].performance, function()
		self:closeView()

		return
	end, true)

	return
end

function NewEducateSelEndingLayer:onBackPressed()
	return
end

function NewEducateSelEndingLayer:willExit()
	existCall(self.contextData.onExit)
	self:UnOverlayPanel(self.blurPanel, self._tf)

	return
end

return NewEducateSelEndingLayer
