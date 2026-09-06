-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/assistancebox/view/AssistanceboxopenView.lua

module("logic.extensions.assistancebox.view.AssistanceboxopenView", package.seeall)

local AssistanceboxopenView = class("AssistanceboxopenView", ViewComponent)

function AssistanceboxopenView:ctor()
	AssistanceboxopenView.super.ctor(self)
end

function AssistanceboxopenView:unbindEvents()
	AssistanceboxopenView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function AssistanceboxopenView:bindEvents()
	AssistanceboxopenView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function AssistanceboxopenView:onExit()
	AssistanceboxopenView.super.onExit(self)
end

function AssistanceboxopenView:buildUI()
	AssistanceboxopenView.super.buildUI(self)

	self._btnCloseGo = self:getGo("viewBoxGo")
	self._btnClose = GameUtil.asBtn(self._btnCloseGo)
	self._bgGo = self:getGo("viewBgGo")
	self._txtCanvas = self:getGo("canvas")
end

function AssistanceboxopenView:onEnter()
	AssistanceboxopenView.super.onEnter(self)

	local trans

	if self._txtCanvas then
		trans = self._txtCanvas.gameObject:GetComponent(goutil.Type_RectTransform)
	end

	if trans then
		trans.anchorMax = Vector2.New(1, 1)
		trans.offsetMax = Vector2.zero
		trans.offsetMin = Vector2.zero
	end

	local effectPath = "20220729/lingwenbaoxiang/fx_ui_bx_cfbx.prefab"

	UIEffectManager.instance:stopEffect(self._effect)

	self._effect = UIEffectManager.instance:playEffect(self, effectPath, nil, 0, 0, false, nil, function()
		self:_onClickClose()
	end)

	self._effect:setParent(self._btnCloseGo.transform)
	self._effect:setScale(1, 1, 1)
end

function AssistanceboxopenView:_waitToClose()
	settimer(1, self._onClickClose, self)
end

function AssistanceboxopenView:_onClickClose()
	self:close()
end

function AssistanceboxopenView:onExit()
	AssistanceboxopenView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._effect)
	removetimer(self._onClickClose, self)
end

return AssistanceboxopenView
