-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/accumulatecharge/controller/AccumulateChargeItem.lua

module("logic.extensions.accumulatecharge.controller.AccumulateChargeItem", package.seeall)

local AccumulateChargeItem = class("AccumulateChargeItem")

function AccumulateChargeItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._go = go
	self._iconGo = goutil.findChild(go, "icon")
	self._getedGo = goutil.findChild(go, "geted")
	self._selectGo = goutil.findChild(go, "select")
	self._txtNum = goutil.findChildTextComponent(go, "txtNum")
	self._txtName = goutil.findChildTextComponent(go, "name/txtName")
	self._effectGo = goutil.findChild(go, "effect")
	self._extraGift = goutil.findChild(go, "extraGift")
	self._btnClick = Framework.ButtonAdapter.GetFrom(go, "btn")

	self._btnClick:AddClickListener(self._onClick, self)
end

function AccumulateChargeItem:init(view, cfgReward, selectCfg)
	self._view = view
	self._cfgReward = cfgReward
	self._txtNum.text = cfgReward.consumeMoney
	self._txtName.text = cfgReward.name

	goutil.setActive(self._extraGift, false)
	uGuiUtil.setSpriteToImage(self._iconGo, uGuiUtil.SpriteType.BigBg, "ui/icon/" .. cfgReward.icon .. ".png")
	self:setGetedGo()

	if cfgReward.id == selectCfg.id then
		self:_onClick()
	else
		self:setSelect(false)
	end
end

function AccumulateChargeItem:reset()
	uGuiUtil.clearImage(self._iconGo)
	self:removeEffect()
end

function AccumulateChargeItem:isSame(cfg)
	return self._cfgReward.id == cfg.id
end

function AccumulateChargeItem:setGetedGo()
	local curMoney = AccumulateChargeModel.instance:getMoney()
	local targetMoney = self._cfgReward.consumeMoney

	if targetMoney <= curMoney then
		if AccumulateChargeModel.instance:isGetedReward(self._cfgReward.id) then
			self._getedGo:SetActive(true)
			self._effectGo:SetActive(false)
		else
			self._getedGo:SetActive(false)
			self._effectGo:SetActive(true)
		end
	else
		self._getedGo:SetActive(false)
		self._effectGo:SetActive(false)
	end
end

function AccumulateChargeItem:setSelect(isSelect)
	self._isSelect = isSelect

	self._selectGo:SetActive(isSelect)
end

function AccumulateChargeItem:isActive()
	return self._isActive
end

function AccumulateChargeItem:active()
	self._isActive = true

	if not goutil.isNil(self._go) then
		self._go:SetActive(true)
		self:loadEffect()
	end
end

function AccumulateChargeItem:disActive()
	self._isActive = false

	if not goutil.isNil(self._go) then
		self._go:SetActive(false)
		self:removeEffect()
	end
end

function AccumulateChargeItem:_onClick()
	GlobalDispatcher:dispatch(GlobalNotify.AccumulateChargeSelectReward, self._cfgReward)
	self:setSelect(true)
end

function AccumulateChargeItem:playAnimation(delayTime, duration)
	if not goutil.isNil(self._go) then
		local from = Vector3.New(0, 0, 0)
		local to = Vector3.New(1, 1, 1)

		UnityTweens.TweenScale.StartTween(self._go, from, to, duration, UnityTweens.EaseType.linear, delayTime)
	end
end

function AccumulateChargeItem:loadEffect()
	self:removeEffect()

	local eff = UIEffectManager.instance:playEffect(self._view, "fx_ui_fuli/fx_ui_fuli_lingqu.prefab", self._effectGo.transform, 0, 0, true)

	eff:setParent(self._effectGo.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._uiEffect = eff
end

function AccumulateChargeItem:removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

return AccumulateChargeItem
