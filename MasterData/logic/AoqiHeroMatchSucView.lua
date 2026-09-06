-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroMatchSucView.lua

module("logic.extensions.aoqihero.view.AoqiHeroMatchSucView", package.seeall)

local AoqiHeroMatchSucView = class("AoqiHeroMatchSucView", ViewComponent)

function AoqiHeroMatchSucView:ctor()
	AoqiHeroMatchSucView.super.ctor(self)
end

function AoqiHeroMatchSucView:unbindEvents()
	AoqiHeroMatchSucView.super.unbindEvents(self)
end

function AoqiHeroMatchSucView:bindEvents()
	AoqiHeroMatchSucView.super.bindEvents(self)
end

function AoqiHeroMatchSucView:buildUI()
	AoqiHeroMatchSucView.super.buildUI(self)

	self._suc = self:getGo("suc")
	self._headLeft = self:getGo("suc/animNode/root/left/information/head")
	self._Text01Left = self:getTxt("suc/animNode/root/left/information/group/Text01")
	self._Text03Left = self:getTxt("suc/animNode/root/left/information/group/Text03")
	self._Text02Left = self:getTxt("suc/animNode/root/left/information/group/Text02")
	self._headRight = self:getGo("suc/animNode/root/right/information/head")
	self._Text01Right = self:getTxt("suc/animNode/root/right/information/group/Text01")
	self._Text02Right = self:getTxt("suc/animNode/root/right/information/group/Text02")
	self._Text03Right = self:getTxt("suc/animNode/root/right/information/group/Text03")
	self._effectVS = self:getGo("suc/effectVS")
	self._effectSuccess = self:getGo("suc/effectSuccess")
end

function AoqiHeroMatchSucView:onExit()
	AoqiHeroMatchSucView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._headLeft)
	HeadItemController.instance:resetHeadCell(self._headRight)
	removetimer(self._finishPlayAni, self)
end

function AoqiHeroMatchSucView:onEnter()
	AoqiHeroMatchSucView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	GameUtil.SetActive(self._suc, false)
	HeadItemController.instance:setMyHeadCell(self._headLeft)

	self._Text01Left.text = RoleModel.instance:getUserName()
	self._Text02Left.text = string.format("%s", RoleModel.instance:getAreaName())
	self._Text03Left.text = string.format("积分：%s", AoQiHeroModel.instance:getPvPScroe(self._activityId))

	local opponentInfo = AoQiHeroModel.instance:getPvPOpInfo()

	if opponentInfo then
		HeadItemController.instance:setHeadCellByInfo(self._headRight, opponentInfo.opHeadInfo)

		self._Text01Right.text = opponentInfo.opHeadInfo.userName
		self._Text02Right.text = string.format("%s", opponentInfo.opHeadInfo.areaName)
		self._Text03Right.text = string.format("积分：%s", opponentInfo.opScore)
	else
		goutil.setActive(self._matching, true)
		goutil.setActive(self._enemyRole, false)
	end

	self:_playAni()
end

function AoqiHeroMatchSucView:_playAni()
	goutil.setActive(self._suc, true)
	settimer(3, self._finishPlayAni, self, false)
end

function AoqiHeroMatchSucView:_finishPlayAni()
	local activityCfg = AoQiHeroConfig.instance:getActivityCfg(self._activityId)

	AoQiHeroController.instance:setAutoStartPvPTime(activityCfg.pvpFormationTime)
	UIStateManager.instance:push(ViewName.AoqiHeroPvPFmtView, self._activityId)
	self:close()
end

return AoqiHeroMatchSucView
