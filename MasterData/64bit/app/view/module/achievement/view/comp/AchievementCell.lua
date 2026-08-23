local var_0_0 = g.core.const.ConstMgr.AchievementConst
local var_0_1 = g.core.const.ConstMgr.AchievementConst.Target
local var_0_2 = g.view.entrance.ModuleGotoProxy
local AchievementCell = class("AchievementCell", require("app.fairyGUI.achievement.UI_AchievementCell"))

function AchievementCell:ctor()
	self._itemDataStruct = nil

	self.m_rightBtn:addClickListener(handler(self, self._onClickRightBtn))
	self.m_awardList:setVirtual()
	self.m_awardList:doFairyBatching(false)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRenderer))
end

function AchievementCell:updateCell(arg_2_1)
	self._itemDataStruct = arg_2_1

	local var_2_0 = arg_2_1:getInfo()
	local var_2_1 = arg_2_1:getState()

	self.m_nameText:setText(var_2_0.name)
	self.m_desText:setText(var_2_0.description)

	local var_2_2, var_2_3 = self:_getCurTargetProgStr(var_2_0.target, var_2_1, arg_2_1:getCurNum(), var_2_0.num)

	self.m_curProgTxt:setText(var_2_2)
	self.m_targetProgTxt:setText(var_2_3)
	self.m_awardList:setNumItems(#arg_2_1:getAwardList())
	self.m_rewardStatusController:setSelectedIndex(var_2_1)
end

function AchievementCell:_getCurTargetProgStr(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if table.keyof(var_0_1, arg_3_1) or arg_3_1 > var_0_1.FURNITURE_SUIT_MIN and arg_3_1 < var_0_1.FURNITURE_SUIT_MAX then
		arg_3_3 = arg_3_2 == var_0_0.RECEIVE_STATE.NOT_ACHIEVE and 0 or 1
		arg_3_4 = 1
	end

	return tostring(arg_3_3), (g.core.lang:get(113001, {
		totalValue = arg_3_4
	}))
end

function AchievementCell:_onAwardItemRenderer(arg_4_1, arg_4_2)
	local var_4_0 = self._itemDataStruct:getAwardList()[arg_4_1 + 1]

	var_4_0.scaleIndex = 3

	arg_4_2:updateIcon(var_4_0)

	local var_4_1 = self._itemDataStruct:getState() == var_0_0.RECEIVE_STATE.HAS_RECEIVED

	arg_4_2:setCompGray(var_4_1)
	arg_4_2:setIconGray(var_4_1)
end

function AchievementCell:_onClickRightBtn()
	local var_5_0 = self.m_rewardStatusController:getSelectedIndex()

	if var_5_0 == var_0_0.RECEIVE_STATE.CAN_RECEIVE then
		g.core.network.GameNetProxy:send_C2S_Achievement_Finish({
			id = self._itemDataStruct:getInfo().id
		})
	elseif var_5_0 == var_0_0.RECEIVE_STATE.NOT_ACHIEVE then
		var_0_2:gotoModule(self._itemDataStruct:getInfo().route_id)
	end
end

return AchievementCell
