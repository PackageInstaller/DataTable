-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaReportView.lua

module("logic.extensions.arena.view.ArenaReportView", package.seeall)

local ArenaReportView = class("ArenaReportView", TableViewComponent)

function ArenaReportView:_getPath()
	return {
		cellPath = "Cell",
		viewPath = "Scrl"
	}
end

function ArenaReportView:ctor()
	ArenaReportView.super.ctor(self)
end

function ArenaReportView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function ArenaReportView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function ArenaReportView:buildUI()
	ArenaReportView.super.buildUI(self)

	self._closeButton = self:getBtn("Btn_close")
	self._goNodata = self:getGo("nodata")
end

function ArenaReportView:destroyUI()
	return
end

function ArenaReportView:onEnter()
	ArenaReportView.super.onEnter(self)

	self._curViewDatas = {}

	local param = self._viewPresentor:getFirstParam()

	if not param then
		return
	end

	for i, v in ipairs(param) do
		table.insert(self._curViewDatas, v)
	end

	self._goNodata:SetActive(#self._curViewDatas == 0)
	self:reloadData()
end

function ArenaReportView:onEnterFinished()
	return
end

function ArenaReportView:onExit()
	ArenaReportView.super.onExit(self)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = nil
end

function ArenaReportView:onExitFinished()
	return
end

function ArenaReportView:_cellSize()
	return 870, 90
end

function ArenaReportView:_updateCell(view, cell, data)
	local _Img_Tag = goutil.findChild(cell, "Img_Tag"):GetComponent("UIImageSpriteChange")
	local _Left_Tag = goutil.findChild(cell, "Head_Left/Img_Tag"):GetComponent("UIImageSpriteChange")
	local _Left_Head = goutil.findChild(cell, "Head_Left/Img_Head")
	local _Right_Tag = goutil.findChild(cell, "Head_Right/Img_Tag"):GetComponent("UIImageSpriteChange")
	local _Right_Head = goutil.findChild(cell, "Head_Right/Img_Head")
	local _Right_Name = goutil.findChild(cell, "Head_Right/Txt_Name"):GetComponent("Text")
	local _Left_Name = goutil.findChild(cell, "Head_Left/Txt_Name"):GetComponent("Text")
	local _Txt_Rank = goutil.findChild(cell, "Txt_Rank"):GetComponent("Text")
	local _Txt_Time = goutil.findChild(cell, "Txt_Time"):GetComponent("Text")

	if data.isChallenger == true then
		_Left_Tag:SetState(0)
		_Right_Tag:SetState(1)

		if data.afterPosition < data.beforePosition then
			_Img_Tag:SetState(0)
		else
			_Img_Tag:SetState(1)
		end
	else
		_Left_Tag:SetState(1)
		_Right_Tag:SetState(0)

		if data.afterPosition <= data.beforePosition then
			_Img_Tag:SetState(0)
		else
			_Img_Tag:SetState(1)
		end
	end

	HeadItemController.instance:setHeadCellByInfo(_Right_Head, data.opHeadInfo)
	HeadItemController.instance:setMyHeadCell(_Left_Head)
	printInfo("data.opName:" .. data.opHeadInfo.userName)
	printInfo("data.opUserId:" .. data.opHeadInfo.userId)

	_Right_Name.text = data.opHeadInfo.userId == "-1" and "替身木桩" or data.opHeadInfo.userName
	_Left_Name.text = RoleModel.instance:getUserName()
	_Txt_Rank.text = "排名 " .. data.afterPosition

	Framework.ButtonAdapter.GetFrom(cell.gameObject, "Btn_Review"):AddClickListener(function()
		UIJumper.instance:pushOneStack(ViewName.ArenaMainView, true)
		ArenaAgent.instance:sendGetVideoReq(data.battleId)
	end, self)
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "Btn_Show"):AddClickListener(function()
		TipsFacade.instance:openCommonTips(ConstString.NotRelease)
	end, self)

	_Txt_Time.text = GameUtil.formatTimeStamp("%m月%d日 %H:%M", data.challnegeTime / 1000)
end

function ArenaReportView:_clearTableview(cell)
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "Btn_Review"):RemoveClickListener()
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "Btn_Show"):RemoveClickListener()

	local _Left_Head = goutil.findChild(cell, "Head_Left/Img_Head")
	local _Right_Head = goutil.findChild(cell, "Head_Right/Img_Head")

	HeadItemController.instance:resetHeadCell(_Right_Head)
	HeadItemController.instance:resetHeadCell(_Left_Head)
end

function ArenaReportView:_onClickClose()
	self:close()
end

return ArenaReportView
