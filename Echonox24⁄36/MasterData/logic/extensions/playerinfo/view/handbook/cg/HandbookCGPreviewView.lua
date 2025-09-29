-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/cg/HandbookCGPreviewView.lua

module("logic.extensions.playerinfo.view.handbook.cg.HandbookCGPreviewView", package.seeall)

local M = class("HandbookCGPreviewView", ViewComponent)

M.AutoHideUITime = 5

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnReturn = self:getBtn("0&title_view_-878360263")
	self._txtCGName = self:getText("0&title_view_-788888785")
	self._imgCg = UIComponentType.ImageBigBG(self:getGo("handbook_cg_preview_view_-73715183"))
	self._goTitleView = self:getGo("0&title_view_-478490097")
	self._goBtnRoot = self:getGo("handbook_cg_preview_view_-1380031554")
	self._btnClick = self:getBtn("handbook_cg_preview_view_-271538343")
	self._btnPre = self:getBtn("handbook_cg_preview_view_-1644465562")
	self._btnNext = self:getBtn("handbook_cg_preview_view_-94605659")
	self._btnSave = self:getBtn("handbook_cg_preview_view_-883333092")

	goutil.setActive(self._btnSave.gameObject, false)

	self._btnShare = self:getBtn("handbook_cg_preview_view_-1688571511")
end

function M:destroyUI()
	self._btnReturn = nil
	self._txtCGName = nil
	self._imgCg = nil
	self._goTitleView = nil
	self._goBtnRoot = nil
	self._btnClick = nil
	self._btnPre = nil
	self._btnNext = nil
	self._btnSave = nil
	self._btnShare = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnClick:AddClickListener(self._onClickClick, self)
	self._btnPre:AddClickListener(self._onClickPre, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._btnSave:AddClickListener(self._onClickSave, self)
	self._btnShare:AddClickListener(self._onClickShare, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnClick:RemoveClickListener()
	self._btnPre:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnShare:RemoveClickListener()
end

function M:onEnter()
	self:setUIShow(true)

	local info = self:getFirstParam()

	self:setId(info.id)

	self._typ = info.typ
	self._lst = info.lst
	self._index = -1

	for index, value in ipairs(self._lst or {}) do
		if value.id == self:getId() then
			self._index = index

			break
		end
	end

	if self._index < 0 then
		printError("index->", self._index)
		self:close()
	end

	self:updateShow(self._index)
end

function M:onExit()
	self._imgCg:ClearImage()
	self:_autoHideUIController(false)

	if self._captureScreen and self._captureFrameCache then
		self._captureScreen:Clear(self._captureFrameCache)
	end

	self._captureFrameCache = nil
end

function M:_onClickReturn()
	self:close()
end

function M:_onClickClick()
	self:setUIShow(not self._uishow)
end

function M:_onClickPre()
	local finalIndex = self:_getPreUnlockIndex(self._index)

	if finalIndex > 0 then
		self._index = finalIndex

		self:updateShow(self._index)
	end
end

function M:_onClickNext()
	local finalIndex = self:_getNextUnlockIndex(self._index)

	if finalIndex > 0 then
		self._index = finalIndex

		self:updateShow(self._index)
	end
end

function M:_getPreUnlockIndex(index)
	local _index = index
	local finalIndex = -1

	while _index > 1 do
		_index = _index - 1

		local id = self._lst[_index].id

		if GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.CG, id) then
			finalIndex = _index

			break
		end
	end

	return finalIndex
end

function M:_getNextUnlockIndex(index)
	local _index = index
	local finalIndex = -1

	while _index < #self._lst do
		_index = _index + 1

		local id = self._lst[_index].id

		if GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.CG, id) then
			finalIndex = _index

			break
		end
	end

	return finalIndex
end

function M:_onClickSave()
	self:_autoHideUIController(false)

	local dialog = Dialog.showMessage("提示", "是否截图并保存该CG")

	dialog:setConfirmListener(function()
		self:setUIShow(false)
	end, self)
	dialog:setCancelListener(function()
		self:_autoHideUIController(true)
	end, self)
	dialog:setCloseListener(function()
		self:_autoHideUIController(true)
	end, self)
end

function M:_onClickShare()
	self:_autoHideUIController(false)
	self:setUIShow(false)

	local shareType = ShareEnum.CG
	local fileName = string.format("CG_%s", self:getId())
	local showToast = true
	local shareOpen = ShareFacade.instance:openShare(shareType, fileName, showToast, self._onShareViewExist, self)
end

function M:_onShareViewExist()
	printWarn("-----onShareViewExist")
end

function M:_onCaptureFrameFinish(renderTexture)
	self._captureFrameCache = renderTexture

	self:_autoHideUIController(true)
end

function M:getId()
	return self._id
end

function M:setId(id)
	self._id = id
end

function M:setUIShow(show)
	self._uishow = show

	goutil.setActive(self._goTitleView, show)
	goutil.setActive(self._goBtnRoot, show)
	self:_autoHideUIController(show)
end

function M:updateShow(index)
	local cfgData = self._lst[index]

	if cfgData then
		local id = cfgData.id

		self:setId(id)
		self:updateCg(cfgData.res)

		self._txtCGName.text = cfgData.name

		self:_autoHideUIController(true)

		if GalleryModel.instance:getIsIdUnRead(GameEnum.UnlockTypeEnum.CG, id) then
			HandbookController.instance:setHandbookTypIdRead(GameEnum.UnlockTypeEnum.CG, id, true)
		end
	end

	local preUnlockIndex = self:_getPreUnlockIndex(index)
	local nextUnlockIndex = self:_getNextUnlockIndex(index)

	goutil.setActive(self._btnPre.gameObject, preUnlockIndex > 0)
	goutil.setActive(self._btnNext.gameObject, nextUnlockIndex > 0)
end

function M:updateCg(res)
	local path = string.format("ui/bigbg/%s.png", res)

	self._imgCg:ClearImage()
	self._imgCg:SetImage(path, self._onImageLoaded, self)
end

function M:_onImageLoaded()
	return
end

function M:_autoHideUIController(start)
	removetimer(self._timerFuncForAutoHideUI, self)

	if start then
		settimer(self.AutoHideUITime, self._timerFuncForAutoHideUI, self, false)
	end
end

function M:_timerFuncForAutoHideUI()
	self:setUIShow(false)
end

return M
