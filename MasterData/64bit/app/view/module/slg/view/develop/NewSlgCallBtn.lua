local var_0_0 = g.core.model.User.newSlgDevelopData
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local var_0_2 = g.core.module.ModuleManager
local NewSlgCallBtn = class("NewSlgCallBtn", require("app.fairyGUI.newSlg.UI_NewSlgCallBtn"))

function NewSlgCallBtn:ctor()
	self._callItem = var_0_0:getSupplyCallItem()
	self._callNum = 0

	self:addClickListener(handler(self, self._onClickCallBtn))
end

function NewSlgCallBtn:updateCallBtn()
	local var_2_0 = math.max(var_0_0:getCanCallNum(), 1)

	self.m_costComp:updateByTVS({
		type = self._callItem.type,
		value = self._callItem.value,
		size = var_2_0
	})
	self:setTitle(g.core.lang:get(429540, {
		num = var_2_0
	}))
end

function NewSlgCallBtn:_onClickCallBtn()
	local var_3_0, var_3_1 = var_0_0:getSupplyCallState()

	self._callNum = var_3_1

	if var_3_0 == var_0_1.SLG_DEVELOP_PRODUCT_CALL_STATE.NO_CALL_ITEM then
		g.core.common.GlobalFunc.pushInfoPop({
			isGetShow = true,
			type = self._callItem.type,
			value = self._callItem.value
		})

		return
	end

	if var_3_0 == var_0_1.SLG_DEVELOP_PRODUCT_CALL_STATE.STORAGE_FULL then
		var_0_2:tip(g.core.lang:get(429574))

		return
	end

	if var_3_0 == var_0_1.SLG_DEVELOP_PRODUCT_CALL_STATE.STORAGE_LIMIT then
		var_0_2:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(429517),
			desc = g.core.lang:get(429522),
			onConfirm = handler(self, self._sendC2SCall)
		}), {
			touchDisappear = false,
			ignoreTouch = false
		})

		return
	end

	self:_sendC2SCall()
end

function NewSlgCallBtn:_sendC2SCall()
	g.core.network.GameNetProxy:send_C2S_NewSlg_UseSupplyToken({
		id = self._callItem.value,
		size = self._callNum
	})
end

return NewSlgCallBtn
