-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastrichmancardbagView.lua

module("logic.extensions.beastrichman.view.BeastrichmancardbagView", package.seeall)

local BeastrichmancardbagView = class("BeastrichmancardbagView", ViewComponent)

function BeastrichmancardbagView:ctor()
	BeastrichmancardbagView.super.ctor(self)
end

function BeastrichmancardbagView:unbindEvents()
	BeastrichmancardbagView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function BeastrichmancardbagView:bindEvents()
	BeastrichmancardbagView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function BeastrichmancardbagView:buildUI()
	BeastrichmancardbagView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getBtn("bg/btnClose")
end

function BeastrichmancardbagView:onExit()
	BeastrichmancardbagView.super.onExit(self)
	self._scrollerList:dispose()
end

function BeastrichmancardbagView:onEnter()
	BeastrichmancardbagView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastRichManUseCardRes, self._updateUI, self)

	local params = self:getOpenParam() or {}

	self._activityId = params[1]

	self:_updateUI()
end

function BeastrichmancardbagView:_updateUI()
	self._cardInfo = BeastRichmanModel.instance:getCardInfo(self._activityId) or {}

	if self._cardInfo.cardIdNNum then
		self._cardIdNNum = self._cardInfo.cardIdNNum or {}
	end

	self._cardIdMap = {}

	for i, pair in pairs(self._cardIdNNum) do
		local cardId = pair.left
		local cardNum = pair.right

		if cardId then
			self._cardIdMap[cardId] = cardNum
		end
	end

	local cardCfgs = BeastRichmanConfig.instance:getCardCfgs(self._activityId)
	local sortCardCfgs = TableUtil.deepcopy(cardCfgs)

	table.sort(sortCardCfgs, function(a, b)
		if not self._cardIdMap[a.cardId] then
			local aNum = 0

			if not self._cardIdMap[b.cardId] then
				local bNum = 0

				return bNum < aNum
			end
		end
	end)
	self._scrollerList:reloadData(sortCardCfgs)
end

function BeastrichmancardbagView:_updateCell(view, cell, data, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local goItem = goutil.findChild(cell.gameObject, "item")
	local txt = goutil.findChildTextComponent(cell.gameObject, "btn/txt")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local cardId = data.cardId

	if not self._cardIdMap[cardId] then
		local cardNum = 0

		txtName.text = data.cardName

		local param = BeastRichmanModel.instance:getCardParam(self._activityId, cardId)
		local hasActiveCard = not string.nilorempty(param)
		local matType, matId, matNum = MaterialMgr.getMatParams(data.matStr)
		local proxy = MaterialMgr.setCell(matType, matId, goItem)

		proxy.binder:setNum(self._cardIdMap[cardId])
		btn:AddClickListener(function()
			if hasActiveCard then
				FloatWordMgr.instance:show("生效中")

				return
			end

			if cardNum <= 0 then
				FloatWordMgr.instance:show("卡片数量不足")

				return
			end

			local tipsContent = string.format("%s\n是否确认立即使用%s", data.cardDesc, data.cardName)

			local function okFunc()
				BeastRichmanAgent.instance:sendPM_BeastRichManUseCardReq(self._activityId, cardId)
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
		end)
		GameUtil.SetActive(btn.gameObject, data.canDirectUse)

		txt.text = hasActiveCard and "生效中" or "使用"
	end
end

function BeastrichmancardbagView:_clearCell(cell)
	local goItem = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(goItem)
end

function BeastrichmancardbagView:_onClickbtnClose()
	self:close()
end

return BeastrichmancardbagView
