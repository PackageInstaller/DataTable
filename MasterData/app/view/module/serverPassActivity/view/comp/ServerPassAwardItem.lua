local var_0_0 = g.core.const.ConstMgr.ServerPassActivityConst
local var_0_1 = g.core.model.User.serverPassActivityData
local ServerPassAwardItem = class("ServerPassAwardItem", require("app.fairyGUI.serverPassActivity.UI_ServerPassAwardItem"))

function ServerPassAwardItem:ctor()
	self._itemData = nil

	self.m_groupComp1:setPayType(var_0_0.PAY_TYPE.FREE)
	self:addListen(self.m_groupComp1)
	self.m_groupComp2:setPayType(var_0_0.PAY_TYPE.PAY_TYPE_NORMAL)
	self:addListen(self.m_groupComp2)
	self.m_groupComp3:setPayType(var_0_0.PAY_TYPE.PAY_TYPE_ADVANCE)
	self:addListen(self.m_groupComp3)
	self.getSharedTrans(self, "enter_right", "CommonLongCellList", self)
end

function ServerPassAwardItem:updateAwardItemComp(arg_2_1)
	self._itemData = arg_2_1

	self.m_levelTxt:setText(self._itemData.cfg.level)

	for iter_2_0 = 1, 3 do
		self[g.core.common.GlobalFunc.contactParamByString("m_", "groupComp", iter_2_0)]:updateGroupComp(self._itemData.awardGroupList[iter_2_0], (var_0_1:getAwardStatue(self._itemData.cfg.level, iter_2_0 - 1)))
	end
end

function ServerPassAwardItem:playUnlockAnim()
	for iter_3_0 = 1, 3 do
		self[g.core.common.GlobalFunc.contactParamByString("m_", "groupComp", iter_3_0)]:playUnlockAnim((var_0_1:getAwardStatue(self._itemData.cfg.level, iter_3_0 - 1)))
	end
end

function ServerPassAwardItem:receiveCompEvent(arg_4_1, arg_4_2)
	if arg_4_1 == "requestAward" then
		local var_4_0 = arg_4_2.payType

		self:newScheduleOnce(handler(self, function(arg_5_0)
			arg_5_0:dispatchCompEvent("getAward", {
				payType = var_4_0,
				level = arg_5_0._itemData.cfg.level
			})
		end))

		return true
	end
end

return ServerPassAwardItem
