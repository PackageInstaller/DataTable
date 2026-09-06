-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guidepopup/view/AttributerestraintpopupView.lua

module("logic.extensions.guidepopup.view.AttributerestraintpopupView", package.seeall)

local AttributerestraintpopupView = class("AttributerestraintpopupView", ViewComponent)
local configStr = lang("精灵属性分为%s<color=#08a0d8ff>水</color>,%s<color=#eb4642ff>火</color>,%s<color=#11a568ff>草</color>,%s<color=#d56d08dd>光</color>,%s<color=#df4dffdd>暗</color>共5种，相互产生克制关系\n攻击方对防御方产生克制时伤害提升至<color=#11a568ff>130%%</color>，被克制时伤害降至<color=#eb4642ff>70%%</color>")

function AttributerestraintpopupView:ctor()
	AttributerestraintpopupView.super.ctor(self)
end

function AttributerestraintpopupView:buildUI()
	AttributerestraintpopupView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._btnClose = self:getBtn("btnClose")

	local txt = self:getGo("txtDesc"):GetComponent("UIGraphicTextNew")

	txt:SetLuaCallBack(function(go, name, size)
		local arr = string.split(name, "|")

		uGuiUtil.setSpriteToImage(go.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("other", arr[1]))
	end, nil)

	local iconShui = MaterialMgr.getContentMatStr("com_sx_shui", 30, -6, true)
	local iconHuo = MaterialMgr.getContentMatStr("com_sx_huo", 30, -6, true)
	local iconCao = MaterialMgr.getContentMatStr("com_sx_cao", 30, -6, true)
	local iconGuang = MaterialMgr.getContentMatStr("com_sx_guang", 30, -6, true)
	local iconAn = MaterialMgr.getContentMatStr("com_sx_an", 30, -6, true)

	txt.text = string.format(configStr, iconShui, iconHuo, iconCao, iconGuang, iconAn)
end

function AttributerestraintpopupView:bindEvents()
	AttributerestraintpopupView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnClose:AddClickListener(self._onClickSure, self)
end

function AttributerestraintpopupView:unbindEvents()
	AttributerestraintpopupView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function AttributerestraintpopupView:destroyUI()
	AttributerestraintpopupView.super.destroyUI(self)
end

function AttributerestraintpopupView:onEnter()
	AttributerestraintpopupView.super.onEnter(self)
end

function AttributerestraintpopupView:onEnterFinished()
	AttributerestraintpopupView.super.onEnterFinished(self)
end

function AttributerestraintpopupView:onExit()
	AttributerestraintpopupView.super.onExit(self)
end

function AttributerestraintpopupView:onExitFinished()
	AttributerestraintpopupView.super.onExitFinished(self)
end

function AttributerestraintpopupView:_onClickSure()
	GuideController.instance:finishGuide()
	self:close()
end

return AttributerestraintpopupView
