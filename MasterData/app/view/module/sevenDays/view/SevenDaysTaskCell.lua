local var_0_0 = g.core.const.ConstMgr.SevenDaysConst
local var_0_1 = g.core.const.ConstMgr.SevenDaysConst.RECEIVE_STATE
local var_0_2 = g.core.const.ConstMgr.BASE_CONST.TASK_STATE_TYPE
local SevenDaysTaskCell = class("SevenDaysTaskCell", require("app.fairyGUI.sevenDaysActivity.UI_SevenDaysTaskCell"))

function SevenDaysTaskCell:ctor()
	self._taskStruct = nil

	self:_initView()
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)
end

function SevenDaysTaskCell:_initView()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListRefresh))
	self.m_rightBtn:addClickListener(handler(self, self._onClickRightBtn))
end

function SevenDaysTaskCell:_onClickRightBtn()
	if not self._taskStruct then
		return
	end

	local var_3_0 = self._taskStruct:getReceiveState()
	local var_3_1 = self._taskStruct:getInfo()

	if var_3_0 == var_0_1.NOT_ACHIEVED then
		g.view.entrance.ModuleGotoProxy:gotoModule(var_3_1.route_id)
	elseif var_3_0 == var_0_1.CAN_RECEIVE then
		local var_3_2 = g.core.model.User.sevenDaysData:getDayTabAllCanGetAwardId(var_3_1.type, var_3_1.reset)

		for iter_3_0 = 1, #var_3_2 do
			g.core.network.GameNetProxy:send_C2S_NewSevendays_Award({
				id = var_3_2[iter_3_0]
			})
		end
	end
end

function SevenDaysTaskCell:_onAwardListRefresh(arg_4_1, arg_4_2)
	local var_4_0 = self._taskStruct:getAwardList()[arg_4_1 + 1]

	var_4_0.scaleIndex = 4

	arg_4_2:updateIcon(var_4_0)

	local var_4_1 = self._taskStruct:getReceiveState() == var_0_1.RECEIVED

	arg_4_2:setIconGray(var_4_1)
	arg_4_2:setCompGray(var_4_1)
end

function SevenDaysTaskCell:updateCell(arg_5_1)
	self._taskStruct = arg_5_1

	local var_5_0 = arg_5_1:getReceiveState()
	local var_5_1 = arg_5_1:getInfo()

	self.m_descTxt:setText(var_5_1.description)

	local var_5_2 = arg_5_1:getProgress()
	local var_5_3 = var_5_1.target_value

	if var_5_1.target == var_0_0.TARGET_BIO_TEAM_CHAPTER then
		var_5_2 = var_5_2 - var_0_0.BIO_TEAM_CHAPTER_START
		var_5_2 = math.max(0, var_5_2)
		var_5_3 = var_5_3 - var_0_0.BIO_TEAM_CHAPTER_START
	elseif var_5_1.target == var_0_0.TARGET_ARENA_RANKING then
		var_5_2 = (var_5_0 == var_0_1.CAN_RECEIVE or var_5_0 == var_0_1.RECEIVED) and 1 or 0
		var_5_3 = 1
	end

	self.m_curProgressTxt:setText(var_5_2)
	self.m_targetProgTxt:setText(g.core.lang:get(403001, {
		num = var_5_3
	}))
	self.m_awardList:setNumItems(#self._taskStruct:getAwardList())
	self.m_stateController:setSelectedIndex(var_5_0)

	if var_5_0 == var_0_1.LOCKED then
		local var_5_4, var_5_5 = arg_5_1:isUnlocked()

		self.m_lockDescTxt:setText(tostring(var_5_5))
	end

	self.m_rightBtn:setTaskStateType((self:_toTaskStateType(var_5_0)))
	self.m_rightBtn:setTouchable(var_5_0 ~= var_0_1.LOCKED)
end

function SevenDaysTaskCell:_toTaskStateType(arg_6_1)
	if arg_6_1 == var_0_1.CAN_RECEIVE then
		return var_0_2.CAN_RECEIVE
	elseif arg_6_1 == var_0_1.NOT_ACHIEVED then
		return var_0_2.GO
	elseif arg_6_1 == var_0_1.LOCKED then
		return var_0_2.LOCKED
	elseif arg_6_1 == var_0_1.RECEIVED then
		return var_0_2.RECEIVED
	else
		return var_0_2.LOCKED
	end
end

return SevenDaysTaskCell
