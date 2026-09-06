-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sharetask/view/BossTriggerView.lua

module("logic.extensions.sharetask.view.BossTriggerView", package.seeall)

local BossTriggerView = class("BossTriggerView", ViewComponent)

function BossTriggerView:ctor()
	BossTriggerView.super.ctor(self)
end

function BossTriggerView:buildUI()
	BossTriggerView.super.buildUI(self)

	self.viewBoxGo = self:getGo("viewBoxGo")
	self.textTipsGo = self:getGo("textTipsGo")
	self._txtBossTip = goutil.findChildTextComponent(self.mainGO, "viewBgGo/txtBossTip")

	GameUtil.SetActive(self.textTipsGo, false)

	self._btnGoto = self:getGo("btnGoto")
	self._btnClose = self:getGo("btnClose")
end

function BossTriggerView:bindEvents()
	BossTriggerView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, GameUtil.handler(self._onClickClose, self))
	GameUtil.addClickHandler(self._btnGoto, GameUtil.handler(self._onClickBtnClose, self, true))
end

function BossTriggerView:unbindEvents()
	BossTriggerView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGoto)
end

function BossTriggerView:onExit()
	BossTriggerView.super.onExit(self)
	removetimer(self.CalculationSurplusTime, self)
end

function BossTriggerView:destroyUI()
	BossTriggerView.super.destroyUI(self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil
end

function BossTriggerView:onEnter()
	local params = self:getOpenParam()

	if not params[1] then
		self._tipsStr = params[1].tipsStr or ""
		self._callBack = params[1].callBack
		self._txtBossTip.text = self._tipsStr

		local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

		self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

		self.pmEff:setParent(self.mainGO.transform)
		self.pmEff:setLocalPos(0, 0, 0)
		self.pmEff:setScale(1)

		self.isCanClose = false

		settimer(2, self.CalculationSurplusTime, self)
	end
end

function BossTriggerView:CalculationSurplusTime()
	self.isCanClose = true

	GameUtil.SetActive(self.textTipsGo, true)
end

function BossTriggerView:_onClickBtnClose()
	if not self.isCanClose then
		return
	end

	self:close()
	GameUtil.callBack(self._callBack)
end

function BossTriggerView:_onClickClose()
	if not self.isCanClose then
		return
	end

	self:close()
end

return BossTriggerView
