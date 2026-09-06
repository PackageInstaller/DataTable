-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/burygame/view/BuryGameLetterView.lua

module("logic.extensions.burygame.view.BuryGameLetterView", package.seeall)

local BuryGameLetterView = class("BuryGameLetterView", ViewComponent)

function BuryGameLetterView:unbindEvents()
	BuryGameLetterView.super.unbindEvents(self)
	self._btnAccept:RemoveClickListener()
	self._btnClick:RemoveClickListener()
end

function BuryGameLetterView:bindEvents()
	BuryGameLetterView.super.bindEvents(self)
	self._btnAccept:AddClickListener(self._onClickAccept, self)
	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function BuryGameLetterView:onExit()
	BuryGameLetterView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._eff)

	self._eff = nil
end

function BuryGameLetterView:buildUI()
	BuryGameLetterView.super.buildUI(self)

	self._btnAccept = self:getBtn("btnAccept")
	self._btnClick = self:getBtn("btnClick")
	self._effPoint = self:getGo("effPoint")
end

function BuryGameLetterView:onEnter()
	BuryGameLetterView.super.onEnter(self)
	self._btnClick.gameObject:SetActive(false)
	self._btnAccept.gameObject:SetActive(false)

	local url = "fx_ui_yirenzhixia/yirenzhixia_xinfeng/yirenzhixia_mairen-ui_p.prefab"

	self._eff = UIEffectManager.instance:playEffect(self, url, self._effPoint, 0, 0, true, nil, nil, self._onEffectLoaded, self)
end

function BuryGameLetterView:_onEffectLoaded(uiEffect)
	uiEffect:setParent(self._effPoint.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos()

	self._sg = uiEffect.effGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

	self._btnClick.gameObject:SetActive(true)
	self:_playAnimation("1", true)
end

function BuryGameLetterView:_playAnimation(clipName, loop)
	local sg = self._sg

	if sg then
		sg.startingAnimation = clipName

		sg.AnimationState:SetAnimation(0, clipName, loop)
		sg:Update(0)
	end
end

function BuryGameLetterView:_onClickSelf()
	self._btnClick.gameObject:SetActive(false)
	self:_playAnimation("2", false)
	self._btnAccept.gameObject:SetActive(true)
end

function BuryGameLetterView:_onClickAccept()
	self:close()
end

return BuryGameLetterView
