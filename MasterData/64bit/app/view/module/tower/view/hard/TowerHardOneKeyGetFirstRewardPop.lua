local var_0_0 = g.core.config.tower_stage_info
local TowerHardOneKeyGetFirstRewardPop = class("TowerHardOneKeyGetFirstRewardPop", require("app.fairyGUI.tower.UI_TowerHardOneKeyGetFirstRewardPop"), function()
	return fgui.GComponent:create({
		resName = "TowerHardOneKeyGetFirstRewardPop",
		pkgName = "tower",
		isFullScreen = false,
		pkgPath = "ui/tower/tower"
	}, ...)
end)
local var_0_2 = 0.2

function TowerHardOneKeyGetFirstRewardPop:ctor(arg_2_1, arg_2_2)
	self._listData = arg_2_1 or {}
	self._curShowList = {}
	self._closeCallBack = arg_2_2
	self._finalRwardList = {}
	self._maxLength = #self._listData
	self._itemIndexList = {}

	self:_initView()
end

function TowerHardOneKeyGetFirstRewardPop:_initView()
	self:showAtCenter()
	self.m_confirmBtn:addClickListener(handler(self, self._onClickClose))
	self.m_rewardList:setVirtual()
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onRendererFirstPassList))
end

function TowerHardOneKeyGetFirstRewardPop:_onRendererFirstPassList(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._curShowList[arg_4_1 + 1], arg_4_1)
end

function TowerHardOneKeyGetFirstRewardPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_GETFIRSTPASSINFO, self._onGetInfo, self)
	self:_updateListBySchedule()

	if self._closeCallBack then
		self._closeCallBack()
	end

	self._closeCallBack = nil

	self:newSchedule(handler(self, self._updateListBySchedule), var_0_2)
end

function TowerHardOneKeyGetFirstRewardPop:_onGetInfo()
	return
end

function TowerHardOneKeyGetFirstRewardPop:_updateListBySchedule()
	if #self._curShowList < self._maxLength then
		local var_7_0 = self:_getRewardList(self._listData[#self._curShowList + 1].info)

		table.insert(self._curShowList, {
			isFinal = false,
			data = self._listData[#self._curShowList + 1],
			rewardList = var_7_0
		})
		self:insetFinalResultReward(var_7_0)
		self:updateListView()
	elseif #self._curShowList == self._maxLength then
		table.insert(self._curShowList, {
			isFinal = true,
			rewardList = self._finalRwardList
		})
		self:updateListView()
	elseif #self._curShowList > self._maxLength then
		self.m_isShowFinishController:setSelectedIndex(1)
		self:cancelAllSchedule()
	end
end

function TowerHardOneKeyGetFirstRewardPop:insetFinalResultReward(arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		if self._itemIndexList[iter_8_1.type .. "_" .. iter_8_1.value] then
			self._finalRwardList[self._itemIndexList[iter_8_1.type .. "_" .. iter_8_1.value]].size = iter_8_1.size + (self._finalRwardList[self._itemIndexList[iter_8_1.type .. "_" .. iter_8_1.value]].size or 0)
		else
			table.insert(self._finalRwardList, clone(iter_8_1))

			self._itemIndexList[iter_8_1.type .. "_" .. iter_8_1.value] = #self._finalRwardList
		end
	end
end

function TowerHardOneKeyGetFirstRewardPop:updateListView()
	self.m_rewardList:setNumItems(#self._curShowList)
	self.m_rewardList:scrollToView(#self._curShowList - 1)
end

function TowerHardOneKeyGetFirstRewardPop:_getRewardList(arg_10_1)
	local var_10_0 = {}
	local var_10_1 = 1

	while var_0_0.hasKey("reward_type" .. 1) do
		if arg_10_1["reward_type" .. 1] > 0 then
			table.insert(var_10_0, {
				type = arg_10_1["reward_type" .. 1],
				value = arg_10_1["reward_value" .. var_10_1],
				size = arg_10_1["reward_size" .. var_10_1]
			})
		end

		var_10_1 = var_10_1 + 1
	end

	return var_10_0
end

function TowerHardOneKeyGetFirstRewardPop:_onClickClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return TowerHardOneKeyGetFirstRewardPop
