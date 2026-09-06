-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaChooseView.lua

module("logic.extensions.arena.view.ArenaChooseView", package.seeall)

local ArenaChooseView = class("ArenaChooseView", ViewComponent)

function ArenaChooseView:ctor()
	ArenaChooseView.super.ctor(self)
end

function ArenaChooseView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHome:AddClickListener(self._onClickHome, self)

	for i = 1, 5 do
		self._btns[i]:AddClickListener(function()
			self:_onClickBtn(i)
		end, self)
	end
end

function ArenaChooseView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnHome:RemoveClickListener()

	for i = 1, 5 do
		self._btns[i]:RemoveClickListener()
	end
end

function ArenaChooseView:buildUI()
	self._closeButton = self:getBtn("Btn_close")
	self._btnHome = self:getBtn("Btn_home")
	self._btns = {}
	self._txtBtns = {}
	self._txts = {}
	self._imgObjs = {}
	self._mskObjs = {}

	for i = 1, 5 do
		self._btns[i] = self:getBtn("Grid/D" .. i .. "/BtnIn")
		self._txtBtns[i] = goutil.findChildTextComponent(self._btns[i].gameObject, "Text")
		self._txts[i] = self:getGo("Grid/D" .. i .. "/TxtPopulation"):GetComponent("Text")
		self._imgObjs[i] = self:getGo("Grid/D" .. i .. "/ImgArraw")
		self._mskObjs[i] = self:getGo("Grid/D" .. i .. "/Mask")
	end
end

function ArenaChooseView:destroyUI()
	return
end

function ArenaChooseView:onEnter()
	ArenaController.instance:getChooseInfo()
	self:_setState()
	ArenaController.instance:registerLocalNotify("RefreshZoneInfo", self._setState, self)
end

function ArenaChooseView:onEnterFinished()
	return
end

function ArenaChooseView:onExit()
	ArenaController.instance:unregisterLocalNotify("RefreshZoneInfo", self._setState, self)
end

function ArenaChooseView:onExitFinished()
	return
end

function ArenaChooseView:_setState()
	local id = ArenaModel.instance:getZoneId() - 1

	for i = 1, 5 do
		self._btns[i].gameObject:SetActive(true)
		self._imgObjs[i]:SetActive(false)

		self._txts[i].text = langPara("战区人数：%s", ArenaModel.instance:getUserNum(i))

		self._mskObjs[i]:SetActive(false)
	end
end

function ArenaChooseView:_onClickClose()
	UIStateManager.instance:pop()
end

function ArenaChooseView:_onClickBtn(index)
	local id = ArenaModel.instance:getZoneId()

	if id == 0 then
		ArenaAgent.instance:sendJoinArenaZoneReq(ArenaModel.instance:getSeasonId(), index)
	else
		local cost = checknumber(ArenaConfig.instance:getValue("DIAMOND_SWITCH_ZONE"))

		TipsFacade.instance:openPopupCostDiamondView(cost, string.format("你确定花费<color=#d44c28>%d钻石</color>更换到英雄战区-<color=#fb7e39>%s</color>吗？", cost, ArenaModel.instance:getZoneName(index)), function()
			ArenaAgent.instance:sendSwitchArenaZoneReq(ArenaModel.instance:getSeasonId(), index)
		end)
	end
end

function ArenaChooseView:_onClickHome()
	UIStateManager.instance:clear(true)
end

return ArenaChooseView
