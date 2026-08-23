local UserBackConst = require("app.view.module.userBack.const.UserBackConst")
local var_0_1 = g.core.model.User.userBackData
local UserBackAwardCell = class("UserBackAwardCell", require("app.fairyGUI.userBack.UI_UserBackAwardCell"))

function UserBackAwardCell:ctor()
	self._itemData = nil
	self._day = nil
	self._id = nil
	self._signStatus = nil

	self:addClickListener(handler(self, self._onItemsClick))
end

function UserBackAwardCell:updateView(arg_2_1)
	self._day = arg_2_1.day
	self._id = arg_2_1.id
	self._isBig = self._day % 7 == 0

	if not self._isBig then
		self:_updateSmallCell(arg_2_1)
	else
		self:_updateBigCell(arg_2_1)
	end
end

function UserBackAwardCell:_updateSmallCell(arg_3_1)
	local var_3_0 = g.core.common.Goods:convert(arg_3_1)

	if var_3_0 then
		self.m_icon:setURL(var_3_0.icon)
	end

	self.m_awardCountTxt:setText("x" .. arg_3_1.size)

	self._itemData = arg_3_1

	self:addSpineEffect("eff_ui_userBack_getsm")
end

function UserBackAwardCell:removeEffect()
	if self._spineNode then
		self._spineNode:removeFromParent()

		self._spineNode = nil
	end
end

function UserBackAwardCell:_updateBigCell(arg_5_1)
	self.m_icon:updateIcon(arg_5_1)
	self:addSpineEffect("eff_ui_userBack_getbig")
end

function UserBackAwardCell:addSpineEffect(arg_6_1)
	self:removeEffect()

	self._signStatus = var_0_1:getSignItemStatus(self._day)

	if self._signStatus == UserBackConst.SIGN_STATUS.CAN_NOT_SIGH then
		self.m_awardStatusController:setSelectedIndex(0)
	elseif self._signStatus == UserBackConst.SIGN_STATUS.CAN_SIGN then
		self.m_awardStatusController:setSelectedIndex(1)

		self._spineNode = self.m_effGetsm:addEffectSpine({
			isLoop = true,
			anim = "play",
			name = arg_6_1
		})
	elseif self._signStatus == UserBackConst.SIGN_STATUS.HAD_SIGNED then
		self.m_awardStatusController:setSelectedIndex(2)
	end
end

function UserBackAwardCell:_onItemsClick()
	if self._signStatus == UserBackConst.SIGN_STATUS.CAN_SIGN then
		g.core.network.GameNetProxy:send_C2S_UserBack_GetSignReward({
			day = self._day
		})
	elseif not self._isBig then
		local var_7_0 = clone(self._itemData)

		var_7_0.component = self

		g.core.common.GlobalFunc.pushInfoPop(var_7_0)
	end
end

return UserBackAwardCell
