-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bountypkcompete/view/BountyPKCompetePrepareView.lua

module("logic.extensions.bountypkcompete.view.BountyPKCompetePrepareView", package.seeall)

local BountyPKCompetePrepareView = class("BountyPKCompetePrepareView", ViewComponent)

function BountyPKCompetePrepareView:ctor()
	BountyPKCompetePrepareView.super.ctor(self)
end

function BountyPKCompetePrepareView:unbindEvents()
	BountyPKCompetePrepareView.super.unbindEvents(self)
end

function BountyPKCompetePrepareView:bindEvents()
	BountyPKCompetePrepareView.super.bindEvents(self)
end

function BountyPKCompetePrepareView:buildUI()
	BountyPKCompetePrepareView.super.buildUI(self)

	self._leftGo = self:getGo("animNode/root/left")
	self._rightGo = self:getGo("animNode/root/right")
	self._goEffectVS = self:getGo("effectVS")
	self._goEffectSuccess = self:getGo("effectSuccess")
end

function BountyPKCompetePrepareView:onExit()
	BountyPKCompetePrepareView.super.onExit(self)
	removetimer(self._applyClose, self)
	self:_removeEffect()
	HeadItemController.instance:resetHeadCell(goutil.findChild(self._leftGo, "infomation/icon"))
	HeadItemController.instance:resetHeadCell(goutil.findChild(self._rightGo, "infomation/icon"))
end

function BountyPKCompetePrepareView:onEnter()
	BountyPKCompetePrepareView.super.onEnter(self)

	local params = self:getFirstParam()

	self._players = params.players
	self._cdSec = params.cdSec
	self._callback = params.callback

	self:_updatePlayer(self._players[1], self._leftGo)
	self:_updatePlayer(self._players[2], self._rightGo)
end

function BountyPKCompetePrepareView:onEnterFinished()
	BountyPKCompetePrepareView.super.onEnterFinished(self)

	self._vsUIEffect = UIEffectManager.instance:playEffect(self, "fx_ui_jinglingdaluandou/fx_ui_pipei_vs.prefab", self._goEffectVS.transform, 0, 0, true, false)

	self._vsUIEffect:setParent(self._goEffectVS.transform)
	self._vsUIEffect:setScale(1)

	self._imgUIEffect = UIEffectManager.instance:playEffect(self, "fx_ui_jinglingdaluandou/fx_ui_pipei_ing.prefab", self._goEffectVS.transform, 0, 0, true, false)

	self._imgUIEffect:setParent(self._goEffectVS.transform)
	self._imgUIEffect:setScale(1)
	self._imgUIEffect:setLocalPos(0, 298, 0)

	self._successUIEffect = UIEffectManager.instance:playEffect(self, "fx_ui_jinglingdaluandou/fx_ui_pipeichenggong.prefab", self._goEffectSuccess.transform, 0, 0, false, false)

	self._successUIEffect:setParent(self._goEffectSuccess.transform)
	self._successUIEffect:setScale(1)
	settimer(math.max(self._cdSec, 0.2), self._applyClose, self)
end

function BountyPKCompetePrepareView:_removeEffect()
	if self._vsUIEffect then
		UIEffectManager.instance:stopEffect(self._vsUIEffect)

		self._vsUIEffect = nil
	end

	if self._imgUIEffect then
		UIEffectManager.instance:stopEffect(self._imgUIEffect)

		self._imgUIEffect = nil
	end

	if self._successUIEffect then
		UIEffectManager.instance:stopEffect(self._successUIEffect)

		self._successUIEffect = nil
	end
end

function BountyPKCompetePrepareView:_updatePlayer(playerInfo, container)
	local headIcon = goutil.findChild(container, "information/icon")
	local txtName = goutil.findChildTextComponent(container, "information/group/Text01")
	local txtZoneName = goutil.findChildTextComponent(container, "information/group/Text02")
	local txtDetail = goutil.findChildTextComponent(container, "information/group/Text03")
	local headInfo = playerInfo.headInfo

	if headInfo then
		txtName.text = headInfo.userName or ""
		txtZoneName.text = headInfo.areaName or ""

		HeadItemController.instance:setHeadCellByInfo(headIcon, headInfo)
	else
		local roleModel = RoleModel.instance

		txtName.text = roleModel:getUserName()
		txtZoneName.text = roleModel:getAreaName()

		HeadItemController.instance:setMyHeadCell(headIcon)
	end

	txtDetail.text = langPara("bountypk__14", playerInfo.score)
end

function BountyPKCompetePrepareView:_applyClose()
	self:close()
	GameUtil.callBack(self._callback)
end

return BountyPKCompetePrepareView
