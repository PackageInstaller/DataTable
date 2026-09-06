-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/AssistantRewardCell.lua

module("logic.extensions.xiaonuoassistant.view.AssistantRewardCell", package.seeall)

local AssistantRewardCell = class("AssistantRewardCell")

function AssistantRewardCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._txtName = goutil.findChildTextComponent(go, "txtName")
	self._tableviewGo = goutil.findChild(go, "rewardList")
	self._cellGo = goutil.findChild(go, "item")
	self.scrollList = ScrollerList.create(self._tableviewGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._drag = Framework.UIDragTrigger.Get(self._tableviewGo)

	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddBeginDragListener(self._onBeginDrag, self)
	self._drag:AddEndDragListener(self._onEndDrag, self)

	self._emptyGo = goutil.findChild(go, "empty")
	self._txtEmpty = goutil.findChildTextComponent(go, "empty/txt")
end

function AssistantRewardCell:init(data, scrollRect)
	printInfo("test AssistantRewardCell:init", data.sendMo.funcEnum)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoAssistantFinishExcute, self._onFinishExcute, self)

	self._data = data
	self._scrollrect = scrollRect

	local cfg = XiaoNuoAssistantConfig.instance:getStrCfg(self._data.funcIndex)
	local resultItem = self._data.resultItem

	if resultItem then
		self._txtName.text = resultItem.name or cfg.name
	end

	self.scrollList:reloadData(self._data.rewardList)
	self:_updateEmpty()
end

function AssistantRewardCell:reset()
	printInfo("test AssistantRewardCell:reset")
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoAssistantFinishExcute, self._onFinishExcute, self)
	self.scrollList:dispose()

	self._data = nil
	self._scrollrect = nil
end

function AssistantRewardCell:_updateCell(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")
	local matType, gId, matNum = MaterialMgr.getMatParams(data)
	local moData = MaterialMgr.getModel(matType, gId)

	if moData then
		local proxy = MaterialMgr.setCellByData(matType, moData, node)

		if proxy and proxy.binder and proxy.binder.setNum then
			proxy.binder:setNum(matNum)
		end
	else
		MaterialMgr.setCellByCfg(data, node)
	end
end

function AssistantRewardCell:_clearCell(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll(node)
end

function AssistantRewardCell:_onDrag(eventData)
	if not goutil.isNil(self._scrollrect) then
		self._scrollrect:OnDrag(eventData)
	end
end

function AssistantRewardCell:_onBeginDrag(eventData)
	if not goutil.isNil(self._scrollrect) then
		self._scrollrect:OnBeginDrag(eventData)
	end
end

function AssistantRewardCell:_onEndDrag(eventData)
	if not goutil.isNil(self._scrollrect) then
		self._scrollrect:OnEndDrag(eventData)
	end
end

function AssistantRewardCell:_onFinishExcute()
	self:_updateEmpty()
end

function AssistantRewardCell:_updateEmpty()
	if self._data.isFinishExcute then
		GameUtil.SetActive(self._emptyGo, #self._data.rewardList == 0)

		local resultItem = self._data.resultItem

		if resultItem then
			self._txtEmpty.text = resultItem.resultText or self._data.sendMo.emptyShowText
		end
	else
		GameUtil.SetActive(self._emptyGo, false)
	end
end

return AssistantRewardCell
