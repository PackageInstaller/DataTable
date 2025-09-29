-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/record/HandbookEntriesItemCell.lua

module("logic.extensions.playerinfo.view.handbook.record.HandbookEntriesItemCell", package.seeall)

local M = class("HandbookEntriesItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
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
	self._btnClick = UIComponentType.ButtonAdapter(self.mainGO)
	self._goNormal = goutil.findChild(self.mainGO, "normal")
	self._goSelect = goutil.findChild(self.mainGO, "select")
	self._goLock = goutil.findChild(self.mainGO, "lock")
	self._goNewMark = goutil.findChild(self.mainGO, "normal/txtEntries/newSign")
	self._txtName1 = goutil.findChildTextComponent(self.mainGO, "normal/txtEntries")
	self._txtName2 = goutil.findChildTextComponent(self.mainGO, "select/txtEntries")
end

function M:destroyUI()
	self:setHandler(nil)

	self._btnClick = nil
	self._goNormal = nil
	self._goSelect = nil
	self._goLock = nil
	self._goNewMark = nil
	self._txtName1 = nil
	self._txtName2 = nil
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function M:unbindEvents()
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

function M:_onClickSelf()
	local handler = self:getHandler()

	if handler then
		handler:onCellClick(self)
	end
end

function M:setData(data)
	self._id = data.cfg.id
	self._index = data.index
	self._itemTyp = data.itemTyp
	self._dataTyp = data.dataTyp
	self._treeIndex = data.treeIndex
	self._txtName1.text = data.cfg.name
	self._txtName2.text = data.cfg.name

	local isLock = not GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.Word, self:getId())

	self:setLock(isLock)
	self:updateNewMark()
end

function M:setIsSelected(isSelected)
	goutil.setActive(self._goSelect, isSelected)

	if not self:getIsLock() then
		goutil.setActive(self._goNormal, not isSelected)
	end

	if isSelected and self:getIsNew() then
		HandbookController.instance:setHandbookTypIdRead(GameEnum.UnlockTypeEnum.Word, self:getId(), true)
		self:setNewMark(false)
	end
end

function M:setLock(lock)
	self._isLock = lock

	goutil.setActive(self._goNormal, not self._isLock)
	goutil.setActive(self._goLock, self._isLock)
end

function M:getIsLock()
	return self._isLock
end

function M:updateNewMark()
	self:setNewMark(GalleryModel.instance:getIsIdUnRead(GameEnum.UnlockTypeEnum.Word, self:getId()))
end

function M:setNewMark(show)
	self._isNew = show

	goutil.setActive(self._goNewMark, self._isNew)
end

function M:getIsNew()
	return self._isNew
end

function M:getItemTyp()
	return self._itemTyp
end

function M:getDataTyp()
	return self._dataTyp
end

function M:getTreeIndex()
	return self._treeIndex
end

function M:getIndex()
	return self._index
end

function M:getId()
	return self._id
end

return M
