-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchwinView.lua

module("logic.extensions.annimatch.view.AnnimatchwinView", package.seeall)

local AnnimatchwinView = class("AnnimatchwinView", ViewComponent)

function AnnimatchwinView:ctor()
	AnnimatchwinView.super.ctor(self)
end

function AnnimatchwinView:unbindEvents()
	AnnimatchwinView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function AnnimatchwinView:bindEvents()
	AnnimatchwinView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.onClickClose, self)
end

function AnnimatchwinView:buildUI()
	AnnimatchwinView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.winNum = self:getGo("winNum/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self.lostGoList = {}

	for i = 1, 3 do
		local go = self:getGo("failNum/flase_" .. i)

		table.insert(self.lostGoList, go)
	end

	self.txtDesc = self:getTxt("txt")
end

function AnnimatchwinView:onExit()
	AnnimatchwinView.super.onExit(self)
end

function AnnimatchwinView:onEnter()
	AnnimatchwinView.super.onEnter(self)
	self:refreshUI()
end

function AnnimatchwinView:onClickClose()
	BattleController.instance:endBattle()
	self:close()
end

function AnnimatchwinView:refreshUI()
	local activityId = AnnimatchModel.instance:getCurrActId()
	local info = AnnimatchModel.instance:getInfo(activityId)
	local hasTicket = AnnimatchModel.instance:getIsAdmission(activityId)
	local isWin = self:getFirstParam()

	self.txtDesc.text = isWin and (hasTicket and AnnimatchConfig.instance:getCommonByKey("BATTLE_WIN_GO_NEXT") or AnnimatchConfig.instance:getCommonByKey("BATTLE_WIN_GO_PRIZE")) or hasTicket and AnnimatchConfig.instance:getCommonByKey("BATTLE_FAIL_GO_NEXT") or AnnimatchConfig.instance:getCommonByKey("BATTLE_FAIL_GO_PRIZE")

	self.winNum:SetNum(info.winTimes)

	for i, v in ipairs(self.lostGoList) do
		GameUtil.SetActive(v, i <= info.failTimes)
	end
end

return AnnimatchwinView
