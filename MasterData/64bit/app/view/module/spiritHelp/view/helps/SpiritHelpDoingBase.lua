local var_0_0 = g.core.const.ConstMgr.SpiritHelpConst
local SpiritHelpDoingBase = class("SpiritHelpDoingBase")

function SpiritHelpDoingBase:ctor(arg_1_1)
	self._info = arg_1_1
	self._state = var_0_0.STATE.LOCK
	self._doingState = var_0_0.DOING_STATE.SUCCESS
	self._isFinish = false
	self._isSelect = true
	self._cellName = "SpiritHelpCell1"
	self._curCount = 0
	self._sendingCount = 0
	self._needAddEventList = {}
	self._isTip = false
	self._tipStr = ""
	self._serverCanDoState = var_0_0.SERVER_STATE.FINISH
	self._curDoAwardList = {}
	self._awardText = {}
	self._costText = {}
	self._isLoadCount = true
	self._hasCount = true
	self._hasHelpShow = false
	self._helpTipText = ""
	self._helpPopId = 0
	self._hasMindBtn = false
	self._isMind = false

	self:initData()
end

function SpiritHelpDoingBase:initData()
	return
end

function SpiritHelpDoingBase:resetDoingData()
	self._sendingCount = 0
	self._isFinish = false
	self._curDoAwardList = {}

	self:setDoingState(var_0_0.DOING_STATE.DOING)
end

function SpiritHelpDoingBase:hasMindBtn()
	return self._hasMindBtn
end

function SpiritHelpDoingBase:hasCountComp()
	return self._hasCount
end

function SpiritHelpDoingBase:getHelpTipText()
	return self._helpTipText
end

function SpiritHelpDoingBase:getHelpPopId()
	return self._helpPopId
end

function SpiritHelpDoingBase:hasHelpBtn()
	return self._hasHelpShow
end

function SpiritHelpDoingBase:hasSending()
	return self._sendingCount > 0
end

function SpiritHelpDoingBase:getState()
	return self._state
end

function SpiritHelpDoingBase:getInfo()
	return self._info
end

function SpiritHelpDoingBase:getItemName()
	return self._cellName
end

function SpiritHelpDoingBase:isSelect()
	return self._isSelect
end

function SpiritHelpDoingBase:setSelect(arg_14_1)
	self._isSelect = arg_14_1 == true
end

function SpiritHelpDoingBase:isMind()
	return self._isMind
end

function SpiritHelpDoingBase:isLoadCount()
	return self._isLoadCount
end

function SpiritHelpDoingBase:setMind(arg_17_1)
	self._isMind = arg_17_1 == true
end

function SpiritHelpDoingBase:getServerState()
	return self._serverCanDoState
end

function SpiritHelpDoingBase:setServerCanDoState(arg_19_1)
	self._serverCanDoState = arg_19_1
end

function SpiritHelpDoingBase:setCurCount(arg_20_1)
	self._curCount = math.clamp(arg_20_1, self:getMinCount(), self:getMaxCount())
end

function SpiritHelpDoingBase:getMinCount()
	return 0
end

function SpiritHelpDoingBase:getMaxCount()
	return 0
end

function SpiritHelpDoingBase:getCurCount()
	if self._curCount == 0 then
		self._curCount = self:getMaxCount()
	end

	return self._curCount
end

function SpiritHelpDoingBase:getCountCostItem()
	return {}
end

function SpiritHelpDoingBase:refreshState()
	self._state = var_0_0.STATE.LOCK
end

function SpiritHelpDoingBase:isTip()
	return self._isTip
end

function SpiritHelpDoingBase:getTipStr()
	return self._tipStr
end

function SpiritHelpDoingBase:getCurDoingAward(arg_28_1)
	return self._curDoAwardList
end

function SpiritHelpDoingBase:addCurDoAward(arg_29_1)
	table.insertto(self._curDoAwardList, arg_29_1 or {})
end

function SpiritHelpDoingBase:getCurDoingCost()
	return self:getCountCostItem()
end

function SpiritHelpDoingBase:getAwardText()
	return self._awardText
end

function SpiritHelpDoingBase:getCostText(arg_32_1)
	return self._costText
end

function SpiritHelpDoingBase:getNeedAddEventList()
	return self._needAddEventList
end

function SpiritHelpDoingBase:isDone()
	return self:isFinish() and not self:hasSending()
end

function SpiritHelpDoingBase:isFinish()
	return self._isFinish
end

function SpiritHelpDoingBase:send(arg_36_1)
	if arg_36_1 then
		arg_36_1()
		self:setDoingState(var_0_0.DOING_STATE.DOING)
		self:addSending()
	end
end

function SpiritHelpDoingBase:addSending()
	self._sendingCount = self._sendingCount + 1
end

function SpiritHelpDoingBase:releaseSending()
	self._sendingCount = self._sendingCount - 1
end

function SpiritHelpDoingBase:doing()
	self._isFinish = true

	return ""
end

function SpiritHelpDoingBase:getLogSuccessParams(arg_40_1)
	return {
		failText = "",
		doingState = self:getDoingState(),
		awardList = self:getCurDoingAward(),
		spiritId = self:getInfo().id,
		awardText = self:getAwardText(arg_40_1),
		costText = self:getCostText(arg_40_1)
	}
end

function SpiritHelpDoingBase:getDoingState()
	return self._doingState
end

function SpiritHelpDoingBase:setDoingState(arg_42_1)
	self._doingState = arg_42_1
end

function SpiritHelpDoingBase:isDoingSuccess()
	self._isFinish = true

	return ""
end

function SpiritHelpDoingBase:onBaseS2CNet(arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	if self._needAddEventList[arg_44_2] then
		self:releaseSending()
		self._needAddEventList[arg_44_2](arg_44_1, arg_44_2, arg_44_3, arg_44_4)
		self:setServerCanDoState(var_0_0.SERVER_STATE.FINISH)
		self:refreshState()

		return true
	end

	return false
end

return SpiritHelpDoingBase
