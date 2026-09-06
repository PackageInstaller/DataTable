-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaEliteView.lua

module("logic.extensions.arena.view.ArenaEliteView", package.seeall)

local ArenaEliteView = class("ArenaEliteView", ViewComponent)

function ArenaEliteView:ctor()
	ArenaEliteView.super.ctor(self)
end

function ArenaEliteView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._inButton:AddClickListener(self._onClickIn, self)
end

function ArenaEliteView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._inButton:RemoveClickListener()
end

function ArenaEliteView:buildUI()
	self._closeButton = self:getBtn("BtnClose")
	self._inButton = self:getBtn("BtnIn")
	self._zdlTxt = self:getGo("TxtPower"):GetComponent("ImgNumber")
	self._tipTxt = self:getGo("TxtTip"):GetComponent("Text")
	self._txtImg = self:getGo("ImgZl"):GetComponent("UIImageSpriteChange")
end

function ArenaEliteView:destroyUI()
	return
end

function ArenaEliteView:onEnter()
	self._isHero = self._viewPresentor:getFirstParam()

	self._zdlTxt:SetNum(RoleModel.instance:getMaxPower())

	if self._isHero then
		self._txtImg:SetState(1)

		self._tipTxt.text = langPara("恭喜最高战斗力达到<color=#326079>%s</color>!\n将进入<color=#e58a29>英雄战场</color>\n更巅峰的决战，更丰厚的奖励！", ArenaConfig.instance:getScoreCfg(2))
	else
		self._txtImg:SetState(0)

		self._tipTxt.text = langPara("当最高战斗力达到<color=#326079>%s</color>后\n将进入<color=#e58a29>英雄战场</color>\n更巅峰的决战，更丰厚的奖励！\n努力提高战斗力吧", ArenaConfig.instance:getScoreCfg(2))
	end
end

function ArenaEliteView:onEnterFinished()
	return
end

function ArenaEliteView:onExit()
	return
end

function ArenaEliteView:onExitFinished()
	return
end

function ArenaEliteView:_onClickClose()
	self:close()
end

function ArenaEliteView:_onClickIn()
	self:close()

	if self._isHero then
		UIStateManager.instance:push("arenaChooseView")
	else
		UIStateManager.instance:push("arenaMainView")
	end
end

return ArenaEliteView
