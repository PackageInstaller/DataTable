local var_0_0 = g.core.model.User.newSlgDevelopData
local var_0_1 = g.core.model.User.bagData
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.const.ConstMgr.NewSlgConst
local var_0_4 = g.core.module.ModuleManager
local NewSlgGetResComp = class("NewSlgGetResComp", require("app.fairyGUI.newSlg.UI_NewSlgGetResComp"))

function NewSlgGetResComp:ctor()
	self._award = var_0_0:getSupplyProductionItem()
	self._getEffect = nil

	self:addClickListener(handler(self, self._onClick))
end

function NewSlgGetResComp:updateView(arg_2_1)
	self._storageLimit = var_0_0:getSupplyCfg().storage_limit
	self._ownNum = var_0_1:getOwnNum(self._award.type, self._award.value)

	self.m_icon:setURL(var_0_2:getIconByTypeValue(self._award.type, self._award.value, false))
end

function NewSlgGetResComp:playCanGetAnim()
	self._getEffect = self._getEffect or self.m_eff:addEffectSpine({
		anim = "play",
		name = "eff_ui_newSlg_getRes",
		isLoop = true
	})
end

function NewSlgGetResComp:_onClick()
	local var_4_0 = var_0_0:getSupplyAwardState()

	if var_4_0 == var_0_3.SLG_DEVELOP_PRODUCT_AWARD_STATE.NO_AWARD then
		var_0_4:tip(g.core.lang:get(429519))

		return
	end

	if var_4_0 == var_0_3.SLG_DEVELOP_PRODUCT_AWARD_STATE.STORAGE_FULL then
		var_0_4:tip(g.core.lang:get(429516))

		return
	end

	if var_4_0 == var_0_3.SLG_DEVELOP_PRODUCT_AWARD_STATE.STORAGE_LIMIT then
		var_0_4:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(429520),
			desc = g.core.lang:get(429522),
			onConfirm = handler(self, self._sendC2SReceive)
		}), {
			touchDisappear = false,
			ignoreTouch = false
		})

		return
	end

	self:_sendC2SReceive()
end

function NewSlgGetResComp:_sendC2SReceive()
	g.core.network.GameNetProxy:send_C2S_NewSlg_ObtainSupplyAward({})
end

return NewSlgGetResComp
