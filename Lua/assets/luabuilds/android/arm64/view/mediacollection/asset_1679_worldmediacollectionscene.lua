local WorldMediaCollectionScene = class("WorldMediaCollectionScene", require("view.base.BaseUI"))

WorldMediaCollectionScene.PAGE_MEMORTY = 1
WorldMediaCollectionScene.PAGE_FILE = 2
WorldMediaCollectionScene.PAGE_RECORD = 3
WorldMediaCollectionScene.PAGE_ALBUM = 4
WorldMediaCollectionScene.PAGE_SHIP = 5

function WorldMediaCollectionScene:getUIName()
	return "WorldMediaCollectionUI"
end

function WorldMediaCollectionScene:getBGM()
	self.contextData.revertBgm = nil

	if self.contextData.revertBgm then
		return self.contextData.revertBgm
	else
		return WorldMediaCollectionScene.super.getBGM(self)
	end

	return
end

function WorldMediaCollectionScene:init()
	self.top = self._tf:Find("Top")
	self.viewContainer = self._tf:Find("Main")
	self.subViews = {}

	self:OverlayPanel(self.top)

	return
end

local var_0_1 = {
	import(".WorldMediaCollectionMemoryLayer"),
	import(".WorldMediaCollectionRecordLayer"),
	import(".WorldMediaCollectionFileLayer"),
	import(".WorldMediaCollectionAlbumLayer"),
	import(".NewWorldMediaCollectionMemoryLayer")
}

function WorldMediaCollectionScene:GetCurrentPage()
	return self.contextData.page and self.subViews[self.contextData.page]
end

function WorldMediaCollectionScene:didEnter()
	onButton(self, self.top:Find("blur_panel/adapt/top/option"), function()
		self:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(self, self.top:Find("blur_panel/adapt/top/back_btn"), function()
		self:Backward()

		return
	end, SFX_UI_CANCEL)

	self.contextData.page = nil

	self:EnterPage(self.contextData.page or WorldMediaCollectionScene.PAGE_MEMORTY)
	self:UpdateView()

	return
end

function WorldMediaCollectionScene:EnterPage(arg_8_1)
	local var_8_0 = arg_8_1 == self.contextData.page
	local var_8_1 = self.subViews[arg_8_1]

	if not self.subViews[arg_8_1] then
		if not var_0_1[arg_8_1] then
			return
		end

		self.contextData[var_0_1[arg_8_1]] = self.contextData[var_0_1[arg_8_1]] or {}
		var_8_1 = var_0_1[arg_8_1].New(self, self.viewContainer, self.event, self.contextData)

		var_8_1:RegisterView(self)
		var_8_1:Load()
	end

	if self.contextData.page and self.subViews[self.contextData.page] and not var_8_0 then
		self.subViews[self.contextData.page].buffer:OnDeselected()
	end

	self.contextData.page = arg_8_1
	self.subViews[arg_8_1] = var_8_1

	if not var_8_0 then
		var_8_1.buffer:OnSelected()
	else
		var_8_1.buffer:OnReselected()
	end

	return
end

function WorldMediaCollectionScene:WarpToRecord(arg_9_1, arg_9_2, arg_9_3)
	self.contextData.recordGroup = arg_9_1
	self.contextData.storyNodeID = arg_9_3

	self:EnterPage(WorldMediaCollectionScene.PAGE_FILE)

	return
end

function WorldMediaCollectionScene:WarpToStoryNode(arg_10_1)
	self:EnterPage(WorldMediaCollectionScene.PAGE_MEMORTY)
	self.subViews[WorldMediaCollectionScene.PAGE_MEMORTY]:WrapToStoryLine(arg_10_1)

	return
end

function WorldMediaCollectionScene:Backward()
	local var_11_0 = self.subViews[self.contextData.page] and self.subViews[self.contextData.page]:OnBackward()

	if var_11_0 then
		return var_11_0
	end

	self:closeView()

	return
end

function WorldMediaCollectionScene:onBackPressed()
	self:Backward()

	return
end

function WorldMediaCollectionScene.WorldRecordLock()
	return LOCK_WORLD_COLLECTION or not (function()
		return pg.SystemOpenMgr.GetInstance():isOpenSystem(getProxy(PlayerProxy):getRawData().level, "WorldMediaCollectionRecordMediator")
	end)()
end

function WorldMediaCollectionScene:UpdateView()
	if not self.subViews[self.contextData.page] then
		return
	end

	self.subViews[self.contextData.page].buffer:UpdateView()

	return
end

function WorldMediaCollectionScene:willExit()
	local var_16_0 = self:GetCurrentPage()

	if var_16_0 then
		var_16_0.buffer:Hide()
	end

	for iter_16_0, iter_16_1 in pairs(self.subViews) do
		iter_16_1:Destroy()
	end

	table.clear(self.subViews)
	self:UnOverlayPanel(self.top, self._tf)

	return
end

return WorldMediaCollectionScene
