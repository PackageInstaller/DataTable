-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/record/HandbookEntriesTitleCell.lua

module("logic.extensions.playerinfo.view.handbook.record.HandbookEntriesTitleCell", package.seeall)

local M = class("HandbookEntriesTitleCell")

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
	self._goNormal = goutil.findChild(self.mainGO, "normal").gameObject
	self._goSelect = goutil.findChild(self.mainGO, "select").gameObject
	self._goNew1 = goutil.findChild(self.mainGO, "normal/txtTitle/newSign").gameObject
	self._goNew2 = goutil.findChild(self.mainGO, "select/txtTitle/newSign").gameObject
	self._txtName1 = goutil.findChildTextComponent(self.mainGO, "normal/txtTitle")
	self._txtName2 = goutil.findChildTextComponent(self.mainGO, "select/txtTitle")
end

function M:destroyUI()
	self:setHandler(nil)

	self._btnClick = nil
	self._goNormal = nil
	self._goSelect = nil
	self._goNew1 = nil
	self._goNew2 = nil
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
		handler:onCellTitleClick(self)
	end
end

function M:setData(data)
	self._index = data.index
	self._itemTyp = data.itemTyp
	self._dataTyp = data.dataTyp
	self._treeIndex = data.treeIndex
	self._txtName1.text = HandbookConfig.instance:getEntriesTypTitle(self._dataTyp)
	self._txtName2.text = HandbookConfig.instance:getEntriesTypTitle(self._dataTyp)

	self:updateNewMark()
end

function M:setIsSelected(isSelected)
	goutil.setActive(self._goSelect, isSelected)
end

function M:getIsLock()
	return false
end

function M:updateNewMark()
	local ids = HandbookConfig.instance:getWordIdsByTyp(self._dataTyp)

	self:setNewMark(GalleryModel.instance:getIsIdsUnRead(GameEnum.UnlockTypeEnum.Word, ids))
end

function M:setNewMark(show)
	self._isNew = show

	goutil.setActive(self._goNew1, self._isNew)
	goutil.setActive(self._goNew2, self._isNew)
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
	return nil
end

return M
