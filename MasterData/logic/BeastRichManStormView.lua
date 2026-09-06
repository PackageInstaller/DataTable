-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManStormView.lua

module("logic.extensions.beastrichman.view.BeastRichManStormView", package.seeall)

local BeastRichManStormView = class("BeastRichManStormView", ViewComponent)

function BeastRichManStormView:ctor()
	BeastRichManStormView.super.ctor(self)
end

function BeastRichManStormView:unbindEvents()
	BeastRichManStormView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function BeastRichManStormView:bindEvents()
	BeastRichManStormView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function BeastRichManStormView:buildUI()
	BeastRichManStormView.super.buildUI(self)

	self._btnClose = self:getGo("bg/btnClose")
	self._icon = self:getGo("bg/pet/mask/icon")
	self._txtTip = self:getTxt("tip/txtTip")
	self._btnSure = self:getGo("btnSure")
end

function BeastRichManStormView:onExit()
	BeastRichManStormView.super.onExit(self)
	uGuiUtil.clearImage(self._icon)
end

function BeastRichManStormView:onEnter()
	BeastRichManStormView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 558001
	end

	self._zoneId = checknumber(params[2])

	if self._zoneId <= 0 then
		self._zoneId = 1
	end

	self._stormNum = checknumber(params[3])
	self._sureFunc = params[4]

	self:_onSetUI()
end

function BeastRichManStormView:_onSetUI()
	local zoneCfg = BeastRichmanConfig.instance:getZoneCfgById(self._activityId, self._zoneId)
	local skinId = zoneCfg.skinId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if modelCo and not string.nilorempty(modelCo.cardName) then
		local imgUrl = GameUrl.getPetImgUrl(modelCo.cardName)

		uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, imgUrl)
	end

	local tipStr = string.format("太可怕了，你遇到了邪恶的龙卷风，被卷着往前走了%s步", self._stormNum)

	if self._stormNum < 0 then
		self._txtTip.text = string.format("太可怕了，你遇到了邪恶的龙卷风，被卷着往后走了%s步", self._stormNum)
	end
end

function BeastRichManStormView:_onClickBtnSure()
	GameUtil.callBack(self._sureFunc)
	GlobalDispatcher:dispatch(GlobalNotify.BeastRichManOpenClickMask, true)
	self:close()
end

return BeastRichManStormView
