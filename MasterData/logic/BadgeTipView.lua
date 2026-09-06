-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/badge/view/BadgeTipView.lua

module("logic.extensions.badge.view.BadgeTipView", package.seeall)

local BadgeTipView = class("BadgeTipView", ViewComponent)

function BadgeTipView:ctor()
	BadgeTipView.super.ctor(self)
end

function BadgeTipView:buildUI()
	BadgeTipView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._name = goutil.findChildTextComponent(self.mainGO, "bg/name")
	self._tipText = goutil.findChildTextComponent(self.mainGO, "bg/tipView/Viewport/tipText")
	self._badgeIcon = self:getGo("bg/badgeIcon")
	self._piece = self:getGo("bg/piece")
	self._pieceNum = goutil.findChildTextComponent(self._piece, "num")
end

function BadgeTipView:bindEvents()
	BadgeTipView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
end

function BadgeTipView:unbindEvents()
	BadgeTipView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function BadgeTipView:destroyUI()
	BadgeTipView.super.destroyUI(self)
end

function BadgeTipView:onEnter()
	BadgeTipView.super.onEnter(self)

	local id = tonumber(self:getFirstParam())
	local badgeInfo = BadgeConfig.instance:getDefineById(id)

	self._name.text = badgeInfo.name
	self._tipText.text = badgeInfo.tip

	local proxy = MaterialMgr.setCell(MatType.Item_Badge, id, self._badgeIcon)

	proxy.binder:setActiveImgC_Bg(false)
	proxy.binder:setAutoTips(false)

	if BadgeModel.instance:getBadgeInfoById(id) or badgeInfo.piece == "" then
		goutil.setActive(self._piece, false)
	else
		local str = string.split(badgeInfo.piece, ":")
		local mo = MaterialMgr.getModel(tonumber(str[1]), tonumber(str[2]))

		self._pieceNum.text = mo and string.format("%d/%s", mo.num, str[3]) or string.format("0/%s", str[3])

		goutil.setActive(self._piece, true)
	end
end

function BadgeTipView:onEnterFinished()
	BadgeTipView.super.onEnterFinished(self)
end

function BadgeTipView:onExit()
	BadgeTipView.super.onExit(self)
	MaterialMgr.resetAll(self._badgeIcon)
end

function BadgeTipView:onExitFinished()
	BadgeTipView.super.onExitFinished(self)
end

function BadgeTipView:_onClickClose()
	CommonTipsMgr.instance:closeAllTips()
end

return BadgeTipView
