local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")
local var_0_1 = g.core.model.User.recycleCultivateData
local RecycleCultivateConst = require("app.view.module.recycleCultivate.const.RecycleCultivateConst")
local RecycleCultivateExchangeComp = class("RecycleCultivateExchangeComp", require("app.fairyGUI.recycleCultivate.UI_RecycleCultivateExchangeComp"))

function RecycleCultivateExchangeComp:ctor()
	self.m_tabList:setIniter()
	self.m_tabList:setItemRenderer(handler(self, self._onTabCellRenderer))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabChange))
	self.m_exchangeList:setVirtual()
	self.m_exchangeList:setItemRenderer(handler(self, self._onExchangeCellRenderer))
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardCellRenderer))
	self.m_convertBtn:addClickListener(handler(self, self.onConvertClick))

	self._changeList = nil
	self._tabIndex = 0
	self._groupInfo = nil

	self:addListen(self.m_exchangeList)

	self._exchangeCache = {}
	self._curReward = {}
	self._allItemLimit = {}
	self._isLimitBan = false
	self._groupInfo = var_0_1:getRecycleInfo()
end

function RecycleCultivateExchangeComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RECYCLE_CULTIVATE_RECYCLE, handler(self, self.onRecycleBack), self)
	self.m_enterTransition:play()
	self:updateExchangeShow()
end

function RecycleCultivateExchangeComp:_onTabChange()
	local var_3_0 = self.m_tabList:getSelectedIndex()

	if self._tabIndex ~= var_3_0 then
		self._tabIndex = var_3_0

		self.m_switchTransition:play()
	end

	self:updatePageView()
end

function RecycleCultivateExchangeComp:receiveCompEvent(arg_4_1, arg_4_2)
	if arg_4_1 == "EVENT_RECYCLE_EXCHANGE_NUM" then
		if self._exchangeCache[arg_4_2.cfg.id].num == arg_4_2.num then
			return
		end

		self._exchangeCache[arg_4_2.cfg.id] = {
			num = arg_4_2.num,
			cfg = arg_4_2.cfg
		}

		self:updateReward()

		if self._isLimitBan then
			self:reCalcLimitNum()
		end

		self.m_exchangeList:setNumItems(#self._changeList)
	end
end

function RecycleCultivateExchangeComp:onRecycleBack(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self:updatePageView()
	self:updateReward()
	g.core.module.ModuleManager:awardSummary(arg_5_4.awards or {})
end

function RecycleCultivateExchangeComp:updateComp()
	self._groupInfo = var_0_1:getRecycleInfo()

	self.m_tabList:setNumItems(#self._groupInfo)
	self.m_tabList:setSelectedIndex(0)
	self:updatePageView()
end

function RecycleCultivateExchangeComp:updatePageView()
	self._exchangeCache = {}
	self._curReward = {}

	self:updateExchangeShow()
end

function RecycleCultivateExchangeComp:updateReward()
	local var_8_0 = {}
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in pairs(self._exchangeCache) do
		if not var_8_1[iter_8_1.cfg.type .. "_" .. iter_8_1.cfg.value] then
			table.insert(var_8_0, {
				type = iter_8_1.cfg.type,
				value = iter_8_1.cfg.value,
				size = iter_8_1.cfg.size * iter_8_1.num
			})

			var_8_1[iter_8_1.cfg.type .. "_" .. iter_8_1.cfg.value] = #var_8_0
		else
			var_8_0[var_8_1[iter_8_1.cfg.type .. "_" .. iter_8_1.cfg.value]].size = var_8_0[var_8_1[iter_8_1.cfg.type .. "_" .. iter_8_1.cfg.value]].size + iter_8_1.cfg.size * iter_8_1.num
		end
	end

	self._curReward = var_8_0

	self.m_rewardList:setNumItems(#self._curReward)
end

function RecycleCultivateExchangeComp:_onTabCellRenderer(arg_9_1, arg_9_2)
	arg_9_2:setTitle(self._groupInfo[arg_9_1 + 1].name)
	arg_9_2:getTransition("enter"):play()
end

function RecycleCultivateExchangeComp:_onExchangeCellRenderer(arg_10_1, arg_10_2)
	arg_10_2:updateCellExchangeData(self._changeList[arg_10_1 + 1], self._exchangeCache, arg_10_1 + 1, self._allItemLimit, self._isLimitBan)
end

function RecycleCultivateExchangeComp:_onRewardCellRenderer(arg_11_1, arg_11_2)
	arg_11_2:updateIcon(self._curReward[arg_11_1 + 1])
end

function RecycleCultivateExchangeComp:reCalcLimitNum()
	self._allItemLimit = {}

	local var_12_0 = {}
	local var_12_1 = 1

	for iter_12_0, iter_12_1 in pairs(self._exchangeCache) do
		var_12_1 = iter_12_1.cfg.group
		var_12_0[iter_12_1.cfg.id] = iter_12_1.cfg.size * iter_12_1.num
	end

	local var_12_2

	if self._curReward[1] then
		var_12_2 = self._curReward[1].size or 0
	end

	local var_12_3 = var_0_1:getGroupBanInfo(var_12_1).canExchangeNum

	for iter_12_2, iter_12_3 in pairs(self._exchangeCache) do
		self._allItemLimit[iter_12_3.cfg.id] = math.floor((var_12_3 - var_12_2 + (var_12_0[iter_12_2] or 0)) / iter_12_3.cfg.size)
	end
end

function RecycleCultivateExchangeComp:updateExchangeShow()
	if #self._groupInfo <= 0 then
		return
	end

	local var_13_0 = self._groupInfo[self.m_tabList:getSelectedIndex() + 1]

	self._isLimitBan = var_13_0.ban_type ~= RecycleCultivateConst.RECYCLE_BAN_TYPE.NONE
	self._changeList = var_0_1:getRecycleDetailGroupInfo(var_13_0.group)
	self._exchangeCache = {}

	for iter_13_0, iter_13_1 in ipairs(self._changeList) do
		self._exchangeCache[iter_13_1.id] = {
			num = 0,
			cfg = iter_13_1
		}
	end

	local var_13_1 = g.core.model.User.bagData

	table.sort(self._changeList, function(arg_14_0, arg_14_1)
		local var_14_0 = var_13_1:getOwnNum(arg_14_0.original_type, arg_14_0.original_value) >= arg_14_0.original_size

		if var_14_0 ~= (var_13_1:getOwnNum(arg_14_1.original_type, arg_14_1.original_value) >= arg_14_1.original_size) then
			return var_14_0
		end

		if arg_14_0.original_value ~= arg_14_1.original_value then
			return arg_14_0.original_value < arg_14_1.original_value
		end

		return false
	end)

	if self._isLimitBan then
		self:reCalcLimitNum()
	end

	self.m_exchangeList:setNumItems(#self._changeList)

	if var_13_0.ban_type == RecycleCultivateConst.RECYCLE_BAN_TYPE.NONE then
		self.m_convertNumTxt:setText("")
		self.m_isCanExchangeController:setSelectedIndex(0)
	else
		local var_13_2 = var_0_1:getGroupBanInfo(var_13_0.group).canExchangeNum

		self.m_convertNumTxt:setText(g.core.lang:get(430706 + var_13_0.ban_type, {
			num = var_13_2
		}))
		self.m_isCanExchangeController:setSelectedIndex(var_13_2 > 0 and 0 or 1)
	end

	self:updateReward()
end

function RecycleCultivateExchangeComp:onConvertClick()
	local var_15_0 = self._groupInfo[self.m_tabList:getSelectedIndex() + 1]
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in pairs(self._exchangeCache) do
		if iter_15_1.num > 0 then
			table.insert(var_15_1, {
				id = iter_15_1.cfg.id,
				num = iter_15_1.num
			})
		end
	end

	if var_0_1:getGroupBanInfo(var_15_0.group).canExchangeNum <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(430716))

		return
	end

	if #var_15_1 <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(430712))

		return
	end

	if var_0_1:isCurTimeNeedPopConfirm() then
		g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
			title = g.core.lang:get(430704),
			desc = g.core.lang:get(430714, {
				num = self._curReward[1].size
			}),
			onConfirm = handler(self, function()
				g.core.network.GameNetProxy:send_C2S_RecycleCultivate_Recycle({
					group = var_15_0.group,
					costs = var_15_1
				})

				self._exchangeCache = {}
			end),
			onCancel = handler(self, self._onCancelExchange),
			tip = {
				isChecked = false,
				txt = g.core.lang:get(201591)
			},
			onCheck = handler(self, self.setIsNeedConfirm)
		})
	else
		g.core.network.GameNetProxy:send_C2S_RecycleCultivate_Recycle({
			group = var_15_0.group,
			costs = var_15_1
		})

		self._exchangeCache = {}
	end
end

function RecycleCultivateExchangeComp:_onCancelExchange()
	self:updatePageView()
end

function RecycleCultivateExchangeComp:setIsNeedConfirm(arg_18_1)
	var_0_1:setNeedPopConfirm(not arg_18_1)
end

return RecycleCultivateExchangeComp
