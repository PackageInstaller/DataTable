-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guidepopup/view/AttacktypepopupView.lua

module("logic.extensions.guidepopup.view.AttacktypepopupView", package.seeall)

local AttacktypepopupView = class("AttacktypepopupView", ViewComponent)
local configStr = lang("精灵攻击类型分为%s<color=#eb4642ff>物理</color>，%s<color=#08a0d8ff>魔法</color>共2种\n在计算伤害时，会按<color=#11a568ff>攻击方</color>的攻击类型计算<color=#eb4642ff>物理</color>和<color=#08a0d8ff>魔法</color>伤害的其中一种")

function AttacktypepopupView:ctor()
	AttacktypepopupView.super.ctor(self)
end

function AttacktypepopupView:buildUI()
	AttacktypepopupView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._btnClose = self:getBtn("btnClose")

	local txt = self:getGo("txtDesc"):GetComponent("UIGraphicTextNew")

	txt:SetLuaCallBack(function(go, name, size)
		local arr = string.split(name, "|")

		uGuiUtil.setSpriteToImage(go.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("other", arr[1]))
	end, nil)

	local iconWuli = MaterialMgr.getContentMatStr("icon_smll_sx02", 30, -6, true)
	local iconMoFa = MaterialMgr.getContentMatStr("icon_smll_sx04", 30, -6, true)

	txt.text = string.format(configStr, iconWuli, iconMoFa)
end

function AttacktypepopupView:bindEvents()
	AttacktypepopupView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnClose:AddClickListener(self._onClickSure, self)
end

function AttacktypepopupView:unbindEvents()
	AttacktypepopupView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function AttacktypepopupView:destroyUI()
	AttacktypepopupView.super.destroyUI(self)
end

function AttacktypepopupView:onEnter()
	AttacktypepopupView.super.onEnter(self)
end

function AttacktypepopupView:onEnterFinished()
	AttacktypepopupView.super.onEnterFinished(self)
end

function AttacktypepopupView:onExit()
	AttacktypepopupView.super.onExit(self)
end

function AttacktypepopupView:onExitFinished()
	AttacktypepopupView.super.onExitFinished(self)
end

function AttacktypepopupView:_onClickSure()
	GuideController.instance:finishGuide()
	self:close()
end

return AttacktypepopupView
