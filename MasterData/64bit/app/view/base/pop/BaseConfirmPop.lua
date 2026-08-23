local BaseConfirmPop = class("BaseConfirmPop", require("app.fairyGUI.base_new.UI_BaseConfirmPop"), function()
	return fgui.GComponent:create({
		pkgName = "base_new",
		resName = "BaseConfirmPop",
		pkgPath = "ui/base_new/base_new"
	})
end)

function BaseConfirmPop:ctor(arg_2_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_GUIDE_CHANGE_UI_STATE, false, {
		show = false
	})
	self:showAtCenter()

	self._params = arg_2_1
	self._cancelCallBack = arg_2_1.onCancel
	self._confirmCallBack = arg_2_1.onConfirm
	self._checkCallBack = arg_2_1.onCheck
	self._titleType = arg_2_1.titleType or 0
	self._forciblyEnd = arg_2_1.forciblyClose or false
	self._onConfirmEventParams = arg_2_1.onConfirmEventParams
	self._unTouchableCD = 0
	self._cdTips = ""
	self._cost = arg_2_1.cost
	self._opeWithOutClose = false
	self._isExitGame = arg_2_1.isExitGame or false

	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmClick))
	self.m_cancelBtn:addClickListener(handler(self, self._onCancelClick))
	self.m_checkBtn:addClickListener(handler(self, self._onCheckClick))
	self.m_titleTypeController:setSelectedIndex(self._titleType)
	self.m_popPanel:setTitle(arg_2_1.title)

	if arg_2_1.singleButton then
		self.m_typeController:setSelectedIndex(1)
	end

	self._childComp = nil

	if arg_2_1.desc then
		self.m_descText:setText(arg_2_1.desc)

		local var_2_0 = self.m_descText:getTextSize().width

		if var_2_0 < 840 then
			self.m_descText:setWidth(var_2_0)
		end
	elseif arg_2_1.childComp then
		self._childComp = arg_2_1.childComp

		self.m_placeHolderComp:addChild(arg_2_1.childComp)
	elseif arg_2_1.desc1 then
		self.m_descText1:setText(arg_2_1.desc1)
		self.m_ownFreeGoldTxt:setText(g.core.lang:get(409603, {
			num = g.core.model.User:getGold()
		}))
	end

	if arg_2_1.confirmText then
		self.m_confirmBtn:setTitle(arg_2_1.confirmText)
	end

	if arg_2_1.cancelText then
		self.m_cancelBtn:setTitle(arg_2_1.cancelText)
	end

	if arg_2_1.tip then
		self.m_showCheckController:setSelectedIndex(1)
		self.m_checkBtn:setTitle(arg_2_1.tip.txt)
		self.m_checkBtn:setSelected(arg_2_1.tip.isChecked)
	else
		self.m_showCheckController:setSelectedIndex(0)
	end

	if self._cost then
		self.m_costComp:updateByTVS(self._cost)
		self.m_costComp:setVisible(true)
	end

	if arg_2_1.midCheck then
		self:_setMidCheck()
	end
end

function BaseConfirmPop:setOpeWithOutClose(arg_3_1)
	self._opeWithOutClose = arg_3_1
end

function BaseConfirmPop:_onConfirmClick()
	if self._confirmCallBack then
		local var_4_0

		if self._childComp and self._childComp.getExData then
			var_4_0 = self._childComp:getExData()
		end

		self._confirm = true
		self._exData = var_4_0
	end

	if self._onConfirmEventParams then
		self:dispatchCompEvent(self._onConfirmEventParams[1], self._onConfirmEventParams[2])
	end

	if not self._opeWithOutClose then
		self:_onClose()
	elseif self._confirmCallBack then
		self._confirmCallBack(self._exData)
	end
end

function BaseConfirmPop:_onCancelClick()
	if self._unTouchableCD ~= 0 and string.len(self._cdTips) > 0 then
		g.core.module.ModuleManager:tip(self._cdTips)

		return
	end

	if not self._opeWithOutClose then
		self:_onClose()
	elseif self._cancelCallBack then
		self._cancelCallBack()
	end
end

function BaseConfirmPop:_onCheckClick()
	if self._checkCallBack then
		self._checkCallBack((self.m_checkBtn:isSelected()))
	end
end

function BaseConfirmPop:onUnload()
	self._cancelCallBack = nil
	self._confirmCallBack = nil
	self._checkCallBack = nil

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_GUIDE_CHANGE_UI_STATE, false, {
		show = true
	})
end

function BaseConfirmPop:_onCloseAnimEnd()
	if self._confirm then
		if self._confirmCallBack then
			self._confirmCallBack(self._exData)
		end
	elseif self._cancelCallBack then
		self._cancelCallBack()
	end
end

function BaseConfirmPop:_onClose()
	if self._isExitGame then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		self:_onCloseAnimEnd()
	else
		g.core.module.ModuleManager:checkAndPlayPopExitAnim(handler(self, self._onCloseAnimEnd))
	end
end

function BaseConfirmPop:_setMidCheck()
	return
end

function BaseConfirmPop:updateConfirmBtnText(arg_11_1)
	self.m_confirmBtn:setTitle(arg_11_1)
end

function BaseConfirmPop:setCancelTouchable(arg_12_1, arg_12_2)
	self._unTouchableCD = math.max(0, arg_12_1)
	self._cdTips = arg_12_2
	self._endCDTime = g.core.common.ServerTime:getTime() + self._unTouchableCD

	self.m_cancelBtn:setGrayed(true)
	self:_updateCDTime()

	self._cdSchedule = self._cdSchedule or self:newSchedule(handler(self, self._updateCDTime), 1)
end

function BaseConfirmPop:_updateCDTime()
	local var_13_0 = g.core.common.ServerTime:getTime()

	if var_13_0 > self._endCDTime then
		self._unTouchableCD = 0
		self._cdTips = ""

		self.m_cancelBtn:setGrayed(false)
		self:cancelSchedule(self._cdSchedule)

		if self._params.cancelText then
			self.m_cancelBtn:setTitle(self._params.cancelText)
		else
			self.m_cancelBtn:setTitle(g.core.lang:get(1037))
		end
	else
		local var_13_1 = {}

		var_13_1.txt = math.max(0, self._endCDTime - var_13_0)

		self.m_cancelBtn:setTitle(self._params.cancelText .. g.core.lang:get(1036, var_13_1))
	end
end

function BaseConfirmPop:clickConfirmBtn()
	self:_onConfirmClick()
end

function BaseConfirmPop:doAutoAction()
	if not self._inRunAuto then
		self:_onCancelClick()

		self._inRunAuto = true
	end
end

return BaseConfirmPop
