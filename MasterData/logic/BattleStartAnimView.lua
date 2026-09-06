-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlestartanim/view/BattleStartAnimView.lua

module("logic.extensions.battlestartanim.view.BattleStartAnimView", package.seeall)

local BattleStartAnimView = class("BattleStartAnimView", ViewComponent)

function BattleStartAnimView:ctor()
	BattleStartAnimView.super.ctor(self)
end

function BattleStartAnimView:buildUI()
	BattleStartAnimView.super.buildUI(self)

	self._previewImg = self:getGo("preview/img")
	self._btnSelect = self:getBtn("state/btnSelect")
	self._checkMark = self:getGo("state/btnSelect/background/checkmark")
	self._btnUse = self:getBtn("state/btnUse")
	self._txtUse = self:getTxt("state/btnUse/txt")
	self.scrollerGo = self:getGo("anims/tableview")
	self.cellGo = self:getGo("anims/cell")
	self.scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function BattleStartAnimView:bindEvents()
	BattleStartAnimView.super.bindEvents(self)
	self._btnSelect:AddClickListener(self._onClickSelect, self)
	self._btnUse:AddClickListener(self._onClickUse, self)
end

function BattleStartAnimView:unbindEvents()
	BattleStartAnimView.super.unbindEvents(self)
	self._btnSelect:RemoveClickListener()
	self._btnUse:RemoveClickListener()
end

function BattleStartAnimView:onEnter()
	BattleStartAnimView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.LoadAllUniquePropsRes, self._onLoadAllUniquePropsRes, self)
	GlobalDispatcher:addListener(GlobalNotify.UseUniquePropRes, self._onUseUniquePropRes, self)
	GlobalDispatcher:addListener(GlobalNotify.NotifyUniquePropChangeRes, self._onNotifyUniquePropChangeRes, self)

	self._curSelectItem = nil
	self._matType = MatType.OpeningEffect

	self:_initToggleSelect()
	BattleStartAnimController.instance:openBattleStartRulePopView()
	BattleStartAnimController.instance:sendPM_LoadAllUniquePropsReq()
end

function BattleStartAnimView:onExit()
	BattleStartAnimView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LoadAllUniquePropsRes, self._onLoadAllUniquePropsRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.UseUniquePropRes, self._onUseUniquePropRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.NotifyUniquePropChangeRes, self._onNotifyUniquePropChangeRes, self)
	self.scrollList:dispose()
	self:_clearPreviewImg()
end

function BattleStartAnimView:_onClickSelect()
	goutil.setActive(self._checkMark, not self._checkMark.activeSelf)
	BattleStartAnimController.instance:saveKeyWordSeeSelf(self._checkMark.activeSelf)
end

function BattleStartAnimView:_onClickUse()
	if self._curSelectItem then
		local state = self._curSelectItem.state

		if state == BattleStartAnimModel.Lock then
			MaterialMgr.openGetSource(self._matType, self._curSelectItem.cfg.id)
		elseif state == BattleStartAnimModel.Unuse then
			UniquePropAgent.instance:sendPM_UseUniquePropReq(self._matType, self._curSelectItem.cfg.id)
		elseif state == BattleStartAnimModel.Using then
			printInfo("test 使用中")
		end
	end
end

function BattleStartAnimView:_onLoadAllUniquePropsRes()
	printInfo("test _onLoadAllUniquePropsRes")
	self:_updateScrollList()
end

function BattleStartAnimView:_onUseUniquePropRes()
	printInfo("test _onUseUniquePropRes")
	self:_updateScrollList()

	if self._curSelectItem then
		self:_updateBtnUseState(self._curSelectItem.state)
	end
end

function BattleStartAnimView:_onNotifyUniquePropChangeRes()
	printInfo("test _onNotifyUniquePropChangeRes")
	self:_updateScrollList()

	if self._curSelectItem then
		self:_updateBtnUseState(self._curSelectItem.state)
	end
end

function BattleStartAnimView:_initToggleSelect()
	local isSeeSelf = BattleStartAnimController.instance:isSeeSelfBattleStartAnim()

	goutil.setActive(self._checkMark, isSeeSelf)
end

function BattleStartAnimView:_updateScrollList()
	self._cfgs = BattleStartAnimConfig.instance:getOpeningEffectCfgList()

	local list = {}
	local initIndex = 1

	for i, v in ipairs(self._cfgs) do
		local item = {}

		item.index = i
		item.cfg = v
		item.state = BattleStartAnimModel.instance:getState(self._matType, v.id)
		item.isSelect = item.state == BattleStartAnimModel.Using

		if item.isSelect then
			initIndex = i
		end

		table.insert(list, item)
	end

	self:_sortList(list)
	self.scrollList:reloadData(list)

	self._curSelectItem = list[initIndex]

	self:_setPreviewImage(self._cfgs[initIndex])
	self:_updateBtnUseState(list[initIndex].state)
end

function BattleStartAnimView:_sortList(list)
	table.sort(list, function(a, b)
		return a.state > b.state
	end)
end

function BattleStartAnimView:_updateSelectIndex(newIndex)
	local curViewDatas = self.scrollList:getData()

	for i, v in ipairs(curViewDatas) do
		v.isSelect = newIndex == v.index
	end

	self.scrollList:refresh()
end

function BattleStartAnimView:_updateCell(view, cell, data, tag)
	local img = goutil.findChild(cell, "img")
	local imgQuality = goutil.findChild(cell, "imgQuality")
	local lock = goutil.findChild(cell, "lock")
	local using = goutil.findChild(cell, "using")
	local select = goutil.findChild(cell, "select")
	local time = goutil.findChild(cell, "time")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtTime = goutil.findChildTextComponent(time, "txt")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	btn:AddClickListener(function()
		self._curSelectItem = data

		self:_setPreviewImage(data.cfg)
		self:_updateBtnUseState(data.state)
		self:_updateSelectIndex(data.index)
	end)
	goutil.setActive(select, data.isSelect)
	goutil.setActive(lock, data.state == BattleStartAnimModel.Lock)
	goutil.setActive(using, data.state == BattleStartAnimModel.Using)

	txtName.text = data.cfg.name

	uGuiUtil.setSpriteToImage(img, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("playerinfobg", data.cfg.icon))
	uGuiUtil.setSpriteToImage(imgQuality, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("playerinfobg", data.cfg.qualityIcon))
	goutil.setActive(time, data.state ~= BattleStartAnimModel.Lock)

	txtTime.text = BattleStartAnimModel.instance:getTimeTxt(self._matType, data.cfg.id)
end

function BattleStartAnimView:clearCell(cell)
	local img = goutil.findChild(cell, "img")
	local imgQuality = goutil.findChild(cell, "imgQuality")

	uGuiUtil.clearImage(img)
	uGuiUtil.clearImage(imgQuality)
end

function BattleStartAnimView:_setPreviewImage(cfg)
	if not cfg then
		return
	end

	uGuiUtil.setSpriteToImage(self._previewImg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("playerinfobg", cfg.previewIcon))
end

function BattleStartAnimView:_clearPreviewImg()
	uGuiUtil.clearImage(self._previewImg)
end

function BattleStartAnimView:_updateBtnUseState(state)
	self._txtUse.text = BattleStartAnimModel.BtnText[state]
end

return BattleStartAnimView
