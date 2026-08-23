local var_0_0 = g.core.config.tower_stage_info
local var_0_1 = g.core.config.tower_start_info
local var_0_2 = g.core.config.tower_reward_info
local var_0_3 = g.core.const.ConstMgr
local var_0_4 = g.core.model.User.towerHardData
local var_0_5 = g.core.const.ConstMgr.TowerConst
local var_0_6 = g.core.module.ModuleManager
local var_0_7 = 404
local var_0_8 = 5
local TowerHardRankRewardPop = class("TowerHardRankRewardPop", require("app.fairyGUI.tower.UI_TowerHardRankRewardPop"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/tower/tower",
		resName = "TowerHardRankRewardPop",
		pkgName = "tower"
	}, ...)
end)
local var_0_10 = {
	FIRST_PASS = 2,
	REWARD = 1,
	RANK = 0
}
local var_0_11 = {
	[6] = {
		stageType = g.core.const.ConstMgr.TowerConst.STAGE_TYPE_HARD.MAIN,
		rankProtoEnum = g.core.network.proto.TOWER_MAIN_DIFF
	},
	[7] = {
		stageType = g.core.const.ConstMgr.TowerConst.STAGE_TYPE_HARD.JIAO_GUO,
		rankProtoEnum = g.core.network.proto.TOWER_EMPIRE_DIFF
	},
	[8] = {
		stageType = g.core.const.ConstMgr.TowerConst.STAGE_TYPE_HARD.LIN_DONG,
		rankProtoEnum = g.core.network.proto.TOWER_BIFROST_DIFF
	},
	[9] = {
		stageType = g.core.const.ConstMgr.TowerConst.STAGE_TYPE_HARD.DONG_XI,
		rankProtoEnum = g.core.network.proto.TOWER_EASTRISE_DIFF
	},
	[10] = {
		stageType = g.core.const.ConstMgr.TowerConst.STAGE_TYPE_HARD.LI_JIN,
		rankProtoEnum = g.core.network.proto.TOWER_NEBU_DIFF
	}
}

function TowerHardRankRewardPop:ctor(arg_2_1)
	self._listData = {}
	self._curList = nil
	self._curTabIndex = var_0_10.RANK
	self._curStageType = arg_2_1 or var_0_3.TowerConst.STAGE_TYPE_HARD.MAIN
	self._redPoints = {}
	self._firstPassData = {}
	self._firstPassInfoMap = {}
	self._rankPassStageDataMap = {}
	self._isPlayerCellTransition = true
	self._tabLen = table.nums(var_0_11)
	self._towerStartId = {
		[var_0_5.STAGE_TYPE_HARD.MAIN] = var_0_1.get(16).parameter,
		[var_0_5.STAGE_TYPE_HARD.JIAO_GUO] = var_0_1.get(17).parameter,
		[var_0_5.STAGE_TYPE_HARD.LIN_DONG] = var_0_1.get(18).parameter,
		[var_0_5.STAGE_TYPE_HARD.DONG_XI] = var_0_1.get(19).parameter,
		[var_0_5.STAGE_TYPE_HARD.LI_JIN] = var_0_1.get(20).parameter
	}
	self._canGetIdList = {}
	self._isUnload = false

	self:_initView()
end

function TowerHardRankRewardPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self.updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_GETFIRSTPASSINFO, self._onS2CGetFirstPassInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_FIRSTPASSAWARD, self._onsS2CFirstPassAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_ONEKEYFIRSTPASSAWARD, self._onsS2COneKeyFirstPassAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_GETINFO, self._onGetInfo, self)
	self.m_tabList:setSelectedIndex(math.max(0, self._curStageType - self._tabLen - 1))

	if not self._isUnload then
		self:updateView()
	end
end

function TowerHardRankRewardPop:_onGetInfo()
	self._listData = {}
	self._firstPassData = {}

	self.m_tabList:setSelectedIndex(math.max(0, self._curStageType - self._tabLen - 1))
	self:updateView()
end

function TowerHardRankRewardPop:_initView()
	self:getView():center(true)
	self:addBg("bg/common/pic_bb_beijing.jpg")

	local var_5_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_5_1 = self.m_rankList:getWidth() * (display.width / CC_DESIGN_RESOLUTION.width)

	if var_5_0.x > 0 then
		var_5_1 = var_5_1 - var_5_0.x * 2
	end

	self.m_rankList:setWidth(var_5_1)
	self.m_rewardList:setWidth(var_5_1)
	self.m_firstPassList:setWidth(var_5_1)
	self.m_topBg:setWidth(var_5_1)
	self.m_downBg:setWidth(var_5_1)

	if var_0_4:hasFirstPassRewardRed({
		stageType = self._curStageType
	}) then
		self._curTabIndex = var_0_10.FIRST_PASS
	end

	self.m_oneKeyGetFirstRewardBtn:addClickListener(handler(self, self._onClickOneKeyGetBtn))
	self.m_showListController:setSelectedIndex(self._curTabIndex)
	self.m_showListController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onShowListChanged))
	self.m_topBar:setResInfoById(302)
	self.m_tabList:setIniter()
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickTabList))
	self.m_tabList:setSelectedIndex(math.max(0, self._curStageType - self._tabLen - 1))
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRendererRankList))
	self.m_rewardList:setVirtual()
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onRendererRewardList))
	self.m_firstPassList:setVirtual()
	self.m_firstPassList:doFairyBatching(false)
	self.m_firstPassList:setItemRenderer(handler(self, self._onRendererFirstPassList))

	for iter_5_0, iter_5_1 in ipairs((self.m_tabList:getChildren())) do
		table.insert(self._redPoints, iter_5_1:getChild("redPointComp"))
		self._redPoints[iter_5_0]:setId(var_0_7)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_firstAwardBtn,
		customData = {
			stageType = self._curStageType
		}
	})
end

function TowerHardRankRewardPop:_onClickTabList()
	local var_6_0 = self.m_tabList:getSelectedIndex() + self._tabLen + 1

	if var_6_0 == self._curStageType then
		return
	end

	self._isPlayerCellTransition = true
	self._curStageType = var_6_0

	self:updateView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_firstAwardBtn,
		customData = {
			stageType = self._curStageType
		}
	})
end

function TowerHardRankRewardPop:_onShowListChanged()
	local var_7_0 = self.m_showListController:getSelectedIndex()

	if var_7_0 == self._curTabIndex then
		return
	end

	self._isPlayerCellTransition = true
	self._curTabIndex = var_7_0
	self._isUnload = false

	self:updateView()
end

function TowerHardRankRewardPop:updateView()
	local var_8_0 = self:_getList(self._curStageType, self._curTabIndex)

	if var_8_0 then
		self._curList = var_8_0

		if self._curTabIndex == var_0_10.RANK then
			self.m_rankList:setNumItems(#var_8_0)

			if self._isPlayerCellTransition then
				self._isPlayerCellTransition = false

				self.m_rankList:transitionShowCells("enter_left", 0.03)
			end

			if not self._isUnload then
				self.m_rankList:scrollToView(0, false)
			end
		elseif self._curTabIndex == var_0_10.REWARD then
			self.m_rewardList:setNumItems(#var_8_0)

			if self._isPlayerCellTransition then
				self._isPlayerCellTransition = false

				self.m_rewardList:transitionShowCells("enter_left", 0.03)
			end

			if not self._isUnload then
				self.m_rewardList:scrollToView(0, false)
			end
		elseif self._curTabIndex == var_0_10.FIRST_PASS then
			self.m_firstPassList:setNumItems(#var_8_0)

			if self._isPlayerCellTransition then
				self._isPlayerCellTransition = false

				self.m_firstPassList:transitionShowCells("enter_left", 0.03)
			end

			if not self._isUnload then
				self.m_firstPassList:scrollToView(0, false)
			end

			self:updateOneKeyBtn(var_8_0)
		end

		self.m_isNullListController:setSelectedIndex(#var_8_0 > 0 and 0 or 1)
	end

	local var_8_1 = var_0_4:getMySelfRank(var_0_11[self._curStageType].rankProtoEnum)

	if var_8_1 == 0 then
		var_8_1 = g.core.lang:get(1157)
	end

	self.m_rankValue:setText(var_8_1)

	local var_8_3 = {}

	var_8_3.stageOrder = (var_0_0.fetch((var_0_4:getCurTowerIdByType(self._curStageType))) or {}).stage_order or 0

	self.m_passValue:setText(g.core.lang:get(308022, var_8_3))
	self:updateRed()
end

function TowerHardRankRewardPop:updateOneKeyBtn(arg_9_1)
	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_3.FUNCTION_TYPE.TOWER_ONE_KEY_GET) then
		self.m_isShowOneKeyBtnController:setSelectedIndex(0)

		return
	end

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		local var_9_1 = iter_9_1
		local var_9_4 = (self._rankPassStageDataMap[iter_9_1.require_value] or {}).user_records or {}

		if var_9_4[1] then
			if (var_9_4[1].snapshot or {}).id ~= nil and not var_0_4:getFirstPassAwardIsGetById(var_9_1.id) and var_0_4:getIsFirstPassByStageAndId(var_0_0.get(iter_9_1.require_value).stage_type, iter_9_1.require_value) then
				table.insert(var_9_0, var_9_1.id)
			end
		end
	end

	self._canGetIdList = var_9_0

	self.m_isShowOneKeyBtnController:setSelectedIndex(#var_9_0 >= var_0_8 and 1 or 0)
end

function TowerHardRankRewardPop:updateRed()
	for iter_10_0, iter_10_1 in pairs(self._redPoints) do
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self._redPoints[iter_10_0],
			customData = {
				stageType = var_0_11[iter_10_0 + self._tabLen].stageType
			}
		})
	end
end

function TowerHardRankRewardPop:_getList(arg_11_1, arg_11_2)
	if self._listData[arg_11_1] == nil then
		self._listData[arg_11_1] = {}
	end

	local var_11_0 = self._listData[arg_11_1]

	if self._listData[arg_11_1][arg_11_2] == nil then
		if arg_11_2 == var_0_10.REWARD then
			var_11_0[arg_11_2] = var_0_4:getRankRewardListByStageType(arg_11_1)

			if var_0_4:getRankListByStageType(var_0_11[arg_11_1].rankProtoEnum) == nil then
				g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
					size = 100,
					id = var_0_11[arg_11_1].rankProtoEnum
				})
			end
		elseif arg_11_2 == var_0_10.RANK then
			var_11_0[arg_11_2] = var_0_4:getRankListByStageType(var_0_11[arg_11_1].rankProtoEnum)

			if var_11_0[arg_11_2] == nil then
				g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
					size = 100,
					id = var_0_11[arg_11_1].rankProtoEnum
				})

				return nil
			end
		elseif arg_11_2 == var_0_10.FIRST_PASS then
			var_11_0[arg_11_2] = self:getFirstPassData(arg_11_1)

			if var_11_0[arg_11_2] == nil then
				g.core.network.GameNetProxy:send_C2S_Tower_GetFirstPassInfo({
					play_type = 2,
					ids = self:getShowFirstPassIds(arg_11_1)
				})

				return nil
			else
				return var_11_0[arg_11_2]
			end
		end
	end

	return var_11_0[arg_11_2]
end

function TowerHardRankRewardPop:_onRendererRankList(arg_12_1, arg_12_2)
	if self._curList[arg_12_1 + 1] and self._curTabIndex == var_0_10.RANK then
		arg_12_2:update({
			data = self._curList[arg_12_1 + 1]
		})
		arg_12_2:setCtrlState("isShowBg", {
			index = arg_12_1 % 2 ~= 0 and 1 or 0
		})
	end
end

function TowerHardRankRewardPop:_onRendererRewardList(arg_13_1, arg_13_2)
	if self._curList[arg_13_1 + 1] and self._curTabIndex == var_0_10.REWARD then
		arg_13_2:update({
			data = self._curList[arg_13_1 + 1]
		})
		arg_13_2:setCtrlState("isShowBg", {
			index = arg_13_1 % 2 ~= 0 and 1 or 0
		})
	end
end

function TowerHardRankRewardPop:_onRendererFirstPassList(arg_14_1, arg_14_2)
	if self._curList[arg_14_1 + 1] and self._curTabIndex == var_0_10.FIRST_PASS then
		arg_14_2:update({
			data = self._rankPassStageDataMap[self._curList[arg_14_1 + 1].require_value],
			info = self._curList[arg_14_1 + 1]
		})
	end
end

function TowerHardRankRewardPop:_onsS2CFirstPassAward(arg_15_1, arg_15_2, arg_15_3)
	if arg_15_3 then
		if self._listData[self._curStageType] == nil then
			self._listData[self._curStageType] = {}
		end

		self._listData[self._curStageType][var_0_10.FIRST_PASS] = self:getFirstPassData(self._curStageType)

		var_0_6:awardSummary(arg_15_3.awards, false, nil, nil, nil)
		self:updateView()
	end
end

function TowerHardRankRewardPop:_onsS2COneKeyFirstPassAward(arg_16_1, arg_16_2, arg_16_3)
	if arg_16_3 then
		local var_16_0 = arg_16_3.ids or {}

		if not next(var_16_0) then
			return
		end

		local var_16_1 = {}

		for iter_16_0, iter_16_1 in pairs(var_16_0) do
			local var_16_2 = var_0_2.get(iter_16_1)

			table.insert(var_16_1, {
				info = var_16_2,
				towerStageFirstRecord = self._rankPassStageDataMap[var_16_2.require_value]
			})
		end

		var_0_6:pushPopup(require("app.view.module.tower.view.hard.TowerHardOneKeyGetFirstRewardPop").new(var_16_1, handler(self, self.updateView)), {
			touchDisappear = false,
			ignoreTouch = false
		})
	end
end

function TowerHardRankRewardPop:_onS2CGetFirstPassInfo(arg_17_1, arg_17_2, arg_17_3)
	if arg_17_3 then
		local var_17_0 = {}

		if arg_17_3.ids and #arg_17_3.ids > 0 then
			for iter_17_0, iter_17_1 in ipairs(arg_17_3.ids) do
				local var_17_1 = var_0_2.fetch(iter_17_1)

				if var_17_1 then
					table.insert(var_17_0, var_17_1)
				end
			end
		end

		self._firstPassData[self._curStageType] = var_17_0

		if arg_17_3.stage_records and #arg_17_3.stage_records > 0 then
			for iter_17_2, iter_17_3 in ipairs(arg_17_3.stage_records) do
				self._rankPassStageDataMap[iter_17_3.stageId] = iter_17_3

				if iter_17_3.is_award then
					var_0_4:setFirstPassGetAward(self._firstPassInfoMap[iter_17_3.stageId].id, true)
				end
			end
		end

		if self._listData[self._curStageType] == nil then
			self._listData[self._curStageType] = {}
		end

		self._listData[self._curStageType][var_0_10.FIRST_PASS] = self:getFirstPassData(self._curStageType)

		self:updateView()
	end
end

function TowerHardRankRewardPop:getFirstPassData(arg_18_1)
	if self._firstPassData[arg_18_1] then
		table.sort(self._firstPassData[arg_18_1], function(arg_19_0, arg_19_1)
			local var_19_0 = self:_getPassRankWeight(arg_19_0)
			local var_19_1 = self:_getPassRankWeight(arg_19_1)

			if var_19_0 ~= var_19_1 then
				return var_19_1 < var_19_0
			end

			return arg_19_0.id < arg_19_1.id
		end)

		return self._firstPassData[arg_18_1]
	else
		return nil
	end
end

function TowerHardRankRewardPop:_getPassRankWeight(arg_20_1)
	local var_20_0 = 100

	if self._rankPassStageDataMap[arg_20_1.require_value] then
		var_20_0 = var_0_4:getFirstPassAwardIsGetById(arg_20_1.id) and var_20_0 - 100 or var_20_0 + 100
	end

	return var_20_0
end

function TowerHardRankRewardPop:getShowFirstPassIds(arg_21_1)
	local var_21_0 = {}
	local var_21_1 = {}

	local function var_21_2(arg_22_0)
		local var_22_0 = var_0_2.get(arg_22_0)

		if self._firstPassInfoMap[var_22_0.require_value] == nil then
			self._firstPassInfoMap[var_22_0.require_value] = var_22_0
		end

		table.insert(var_21_0, var_22_0.require_value)
	end

	local function var_21_4(arg_23_0, arg_23_1)
		if #var_21_0 >= var_0_5.FIRST_PASS_LIST_MAX_COUNT then
			return
		end

		local var_23_0 = var_0_2.get(arg_23_0)

		if arg_23_1 then
			local var_23_1 = var_23_0.before_stage or var_23_0.next_stage

			if var_23_1 ~= 0 and var_21_1[var_23_1] == nil then
				var_21_2(var_23_1)
				var_21_4(var_23_1, arg_23_1)
			end
		end
	end

	for iter_21_0, iter_21_1 in ipairs((var_0_4:getTowerCanAwardIdsByType(arg_21_1))) do
		var_21_2(iter_21_1)

		var_21_1[iter_21_1] = true
	end

	if #var_21_0 < var_0_5.FIRST_PASS_LIST_MAX_COUNT then
		local var_21_5 = var_0_4:getFirstPassMaxId(self._curStageType)

		if var_21_5 == nil or var_21_5 == 0 then
			var_21_5 = self._towerStartId[arg_21_1]
		end

		if var_21_1[var_21_5] == nil then
			var_21_2(var_21_5)
		end

		var_21_4(var_21_5)
		var_21_4(var_21_5, true)
		table.sort(var_21_0, function(arg_24_0, arg_24_1)
			return arg_24_0 < arg_24_1
		end)
	else
		var_21_0 = {
			unpack(var_21_0, 1, var_0_5.FIRST_PASS_LIST_MAX_COUNT)
		}
	end

	return var_21_0
end

function TowerHardRankRewardPop:_onClickOneKeyGetBtn()
	if g.core.common.ModuleUnlock:isModuleUnlock(var_0_3.FUNCTION_TYPE.TOWER_ONE_KEY_GET) and #self._canGetIdList >= var_0_8 then
		g.core.network.GameNetProxy:send_C2S_Tower_OnekeyFirstPassAward({
			play_type = 2,
			ids = self._canGetIdList
		})
	end
end

function TowerHardRankRewardPop:onUnload()
	self._listData = {}
	self._firstPassData = {}
	self._isUnload = true

	var_0_4:resetData()
end

return TowerHardRankRewardPop
