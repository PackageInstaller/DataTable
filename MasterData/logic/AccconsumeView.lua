-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/AccconsumeView.lua

module("logic.extensions.payshop.view.AccconsumeView", package.seeall)

local AccconsumeView = class("AccconsumeView", TableViewComponent)

function AccconsumeView:ctor()
	AccconsumeView.super.ctor(self)
end

function AccconsumeView:buildUI()
	AccconsumeView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self.goShowType0 = goutil.findChild(self.mainGO, "showType0")
	self.goShowType1 = goutil.findChild(self.mainGO, "showType1")
	self.goShowType3 = goutil.findChild(self.mainGO, "showType3")
	self.imgShowType3 = goutil.findChild(self.mainGO, "showType3")
end

function AccconsumeView:bindEvents()
	AccconsumeView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function AccconsumeView:unbindEvents()
	AccconsumeView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function AccconsumeView:destroyUI()
	AccconsumeView.super.destroyUI(self)
end

function AccconsumeView:onEnter()
	AccconsumeView.super.onEnter(self)

	local function handler(msg)
		PayShopModel.instance:setAccConsumeMoney(msg.consumeMoney)
		PayShopModel.instance:setAccConsumeGainedList(msg.hasGained)
		self:_refresh()
	end

	PayShopController.instance:sendGetAccConsumeGiftInfoReq(handler)
end

function AccconsumeView:onEnterFinished()
	AccconsumeView.super.onEnterFinished(self)
end

function AccconsumeView:onExit()
	AccconsumeView.super.onExit(self)
	uGuiUtil.clearImage(self.imgShowType3)
end

function AccconsumeView:onExitFinished()
	AccconsumeView.super.onExitFinished(self)
end

function AccconsumeView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function AccconsumeView:_onClickClose()
	self:close()
end

function AccconsumeView:_cellSize()
	return 306, 552
end

function AccconsumeView:_updateCell(view, cell, data)
	local color = "5FE07EFF"
	local txtNeed = goutil.findChildTextComponent(cell.gameObject, "imgNeedbg/txtNeed")
	local leftConsume = data.leftConsume

	txtNeed.text = string.format("累计充值达到<color=#%s>%s</color>元", color, leftConsume)

	local consumeMoney = PayShopModel.instance:getAccConsumeMoney()
	local on = goutil.findChild(cell.gameObject, "btn/on")
	local off = goutil.findChild(cell.gameObject, "btn/off")
	local progress = goutil.findChild(cell.gameObject, "txtProgress")
	local txtProgress = goutil.findChildTextComponent(cell.gameObject, "txtProgress")

	goutil.setActive(off, data.get)
	goutil.setActive(on, not data.get and leftConsume <= consumeMoney)
	goutil.setActive(progress, not data.get and consumeMoney < leftConsume)

	txtProgress.text = string.format("<color=#%s>%s</color>/%s", color, consumeMoney, leftConsume)

	local btnGo = goutil.findChild(cell.gameObject, "btn")
	local btn = Framework.ButtonAdapter.Get(btnGo)

	btn:AddClickListener(function()
		self:_onClickGet(data)
	end)

	local gift = string.split(data.gift, "#")
	local _script = goutil.findChild(cell.gameObject, "gifts"):GetComponent("TestRecordPos")

	_script:LoadPlan(checknumber(#gift - 1))

	for i = 1, #gift do
		local itemPoint = goutil.findChild(cell.gameObject, "gifts/gift_" .. i)

		MaterialMgr.setCellByCfg(gift[i], itemPoint)
	end

	local redPoint = goutil.findChild(cell.gameObject, "redPoint")

	goutil.setActive(redPoint, not data.get and leftConsume <= consumeMoney)
end

function AccconsumeView:_refresh()
	local data = PayShopModel.instance:getAccConsumeGainedList()
	local consumeMoney = PayShopModel.instance:getAccConsumeMoney()
	local index = 2
	local res = {}
	local getList = {}

	for i, v in ipairs(data) do
		if consumeMoney >= v.leftConsume then
			index = i
		end

		if i <= index then
			if v.get == true then
				table.insert(getList, v)
			else
				table.insert(res, v)
			end
		end
	end

	for i, v in ipairs(data) do
		if index < i then
			table.insert(res, v)
		end

		if consumeMoney < v.leftConsume and v.showType ~= 0 then
			break
		end
	end

	table.insertto(res, getList)

	self._curViewDatas = res

	self:reloadData()
	self:_refreshLeft()
end

function AccconsumeView:_refreshLeft()
	local data = PayShopModel.instance:getAccConsumeNext()
	local left = goutil.findChild(self.mainGO, "left")

	if data then
		local showType = data.showType

		if showType then
			if showType == 1 then
				self:_setShowType(1)

				local gift = data.showItem
				local itemPoint = goutil.findChild(self.mainGO, "showType1/nextGifts/gift")

				MaterialMgr.setCellByCfg(gift, itemPoint)
			elseif showType == 3 then
				self:_setShowType(3)
				uGuiUtil.setSpriteToImage(self.imgShowType3, uGuiUtil.SpriteType.BigBg, GameUrl.getAccconsumeUrl(data.sprite), function()
					self.imgShowType3:GetComponent("Image"):SetNativeSize()
				end)
				GameUtil.setLocalPos(self.imgShowType3, data.pos[1], data.pos[2], 1)
			end

			goutil.setActive(left, true)

			local txtNeed = goutil.findChildTextComponent(self.mainGO, "left/txtNeed")
			local moneyNeed = data.leftConsume - PayShopModel.instance:getAccConsumeMoney()
			local color = "5FE07EFF"

			txtNeed.text = string.format("再充<color=#%s>%d</color>元可获得", color, moneyNeed)
		else
			self:_setShowType(0)
		end
	else
		self:_setShowType(0)
		goutil.setActive(left, false)
	end
end

function AccconsumeView:_setShowType(index)
	goutil.setActive(self.goShowType0, index == 0)
	goutil.setActive(self.goShowType1, index == 1)
	goutil.setActive(self.goShowType3, index == 3)
end

function AccconsumeView:_onClickGet(data)
	PayShopController.instance:sendGainAccConsumeGiftReq(data.id, function()
		PayShopModel.instance:setAccConListById(data.id, true)
		self:_refresh()
	end)
end

function AccconsumeView:_showBigGift()
	return
end

return AccconsumeView
