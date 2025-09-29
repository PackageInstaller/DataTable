-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/music/HandbookMusicItemCell.lua

module("logic.extensions.playerinfo.view.handbook.music.HandbookMusicItemCell", package.seeall)

local M = class("HandbookMusicItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local registry = self:getRegistry()

	self._txtName1 = registry:findUIElement("handbook_music_item_1356079551", UIComponentType.Text)
	self._txtName2 = registry:findUIElement("handbook_music_item_1874345711", UIComponentType.Text)
	self._goNormal = registry:findUIElement("handbook_music_item_895811935")
	self._goSelect = registry:findUIElement("handbook_music_item_201353057")
	self._goLock = registry:findUIElement("handbook_music_item_1228704323")
	self._goNewSignMark = registry:findUIElement("handbook_music_item_1928516937")
	self._btnClick = UIComponentType.ButtonAdapter(registry:findUIElement("handbook_music_item_235923349"))
end

function M:destroyUI()
	self:setHandler(nil)

	self._txtName1 = nil
	self._txtName2 = nil
	self._goNormal = nil
	self._goSelect = nil
	self._goLock = nil
	self._goNewSignMark = nil
	self._btnClick = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function M:unbindEvents()
	self:setHandler(nil)
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getRegistry()
	return self._registry
end

function M:_onClickSelf()
	local handler = self:getHandler()

	if handler then
		handler:onCellClick(self)
	end

	if self:getIsNew() then
		HandbookController.instance:setHandbookTypIdRead(GameEnum.UnlockTypeEnum.Music, self._id, true)
		self:setNewMark(false)
	end
end

function M:setData(cfgData)
	self._id = cfgData.id

	local isLock = not GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.Music, self._id)

	self._txtName1.text = cfgData.name
	self._txtName2.text = cfgData.name

	self:setLock(isLock)
	self:setNewMark(GalleryModel.instance:getIsIdUnRead(GameEnum.UnlockTypeEnum.Music, self._id))
end

function M:setIsSelected(selected)
	goutil.setActive(self._goSelect, selected)
	goutil.setActive(self._goNormal, not selected)

	if selected and self:getIsNew() then
		HandbookController.instance:setHandbookTypIdRead(GameEnum.UnlockTypeEnum.Music, self:getId(), true)
		self:setNewMark(false)
	end
end

function M:setLock(lock)
	self._isLock = lock

	goutil.setActive(self._goLock, lock)
	goutil.setActive(self._goSelect, false)
	goutil.setActive(self._goNormal, false)
end

function M:getIsLock()
	return self._isLock
end

function M:setNewMark(show)
	self._isNew = show

	goutil.setActive(self._goNewSignMark, show)
end

function M:getIsNew()
	return self._isNew
end

function M:getId()
	return self._id or -1
end

return M
