-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/BackListView.lua

module("logic.extensions.playerreturn.view.BackListView", package.seeall)

local BackListView = class("BackListView", TableViewComponent)

function BackListView:ctor()
	BackListView.super.ctor(self)
end

function BackListView:bindEvents()
	BackListView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function BackListView:unbindEvents()
	BackListView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function BackListView:onExit()
	BackListView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataBackInviteList, self.updataItemListShow, self)

	self._curViewDatas = nil
end

function BackListView:destroyUI()
	BackListView.super.destroyUI(self)
end

function BackListView:buildUI()
	BackListView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._srBgGo = self:getGo("srBgGo")
	self._noListGo = self:getGo("noListGo")

	self._srBgGo:SetActive(false)
	self._noListGo:SetActive(false)
end

function BackListView:onEnter()
	BackListView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataBackInviteList, self.updataItemListShow, self)
	self:updataItemListShow()
	PlayerReturnController.instance:csGetCIGetInviteListReq()
end

function BackListView:updataItemListShow(list)
	self._curViewDatas = {}

	if list and #list > 0 then
		self._curViewDatas = list
	end

	if #self._curViewDatas > 0 then
		self._srBgGo:SetActive(true)
		self._noListGo:SetActive(false)
		table.sort(self._curViewDatas, function(a, b)
			return a.timeMillis > b.timeMillis
		end)
	else
		self._srBgGo:SetActive(false)
		self._noListGo:SetActive(true)
	end

	self._tableview:ReloadData()
end

function BackListView:_getPath()
	return {
		cellPath = "itemList",
		viewPath = "itemListSR"
	}
end

function BackListView:_cellSize()
	return 582, 94
end

function BackListView:_updateCell(view, cell, data)
	local headPos = goutil.findChild(cell, "headPos")
	local tagIma = goutil.findChild(cell, "tagGo/tagIma"):GetComponent("UIImageColorChange")
	local tagTxt = goutil.findChildTextComponent(cell, "tagGo/tagTxt")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local powerTxt = goutil.findChildTextComponent(cell, "powerGo/powerTxt")
	local severTxt = goutil.findChildTextComponent(cell, "severTxt")
	local timeTxt = goutil.findChildTextComponent(cell, "timeTxt")

	MaterialMgr.resetAll(headPos)
	tagIma:SetState(data.type - 1)

	tagTxt.text = PlayerReturnModel.instance:_getTaskGradeName(data.type) .. "玩家"

	HeadItemController.instance:setHeadCellByInfo(headPos, data.headInfo)

	nameTxt.text = data.headInfo.userName
	powerTxt.text = tostring(data.curZdl)
	severTxt.text = data.areaName

	local time = GameUtil.time2date(checknumber(data.timeMillis / 1000))

	timeTxt.text = langPara("text_timeinfo", time.month, time.day, time.hour, time.min, time.sec)
end

return BackListView
