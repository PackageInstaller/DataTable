local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.common.ServerTime
local var_0_3 = g.core.common.Path
local var_0_4 = g.core.model.User.richmanData
local var_0_5 = g.core.config.richman_map_level_info
local var_0_6 = g.core.utils.Number.getFormatNum
local RichmanBuildPop = class("RichmanBuildPop", require("app.fairyGUI.richman.UI_RichmanBuildPop"), function()
	return fgui.GComponent:create({
		resName = "RichmanBuildPop",
		pkgPath = "ui/richman/richman",
		pkgName = "richman"
	})
end)

function RichmanBuildPop:ctor(arg_2_1)
	self._buildType = arg_2_1

	self:showAtCenter()

	self._buildData = nil
	self._previewList = nil
	self._formationList = {}

	self.m_previewList:setVirtual()
	self.m_previewList:setItemRenderer(handler(self, self._onPreviewItemRenderer))
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onPreviewAwardRenderer))
	self.m_knightList:setVirtual()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightItemRenderer))
	self.m_lvUpRewardList:setVirtual()
	self.m_lvUpRewardList:setItemRenderer(handler(self, self._onLvUpRewardRenderer))
	self.m_otherRewardList:setVirtual()
	self.m_otherRewardList:setItemRenderer(handler(self, self._onOtherRewardRenderer))
	self.m_getBtn:addClickListener(handler(self, self._onGetBtnClick))
	self.m_attackBtn:addClickListener(handler(self, self._onAttackRobClick))
	self.m_closeBtn:setClickCallBack(handler(self, self._onClosePop))
	self.m_closeGraph:addClickListener(handler(self, self._onClosePop))
	self:updateBuildView()
end

function RichmanBuildPop:onLoad()
	self.m_enterTransition:play()
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_RICH_MAN_GETCONSTRUCT, self.updateBuildView, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_RICH_MAN_ROBDATA, self.updateBuildView, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_RICH_MAN_CONSTRUCTAWARD, self.onRewardBuildItem, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self.updateBuildView, self)

	self._schedulerUpdate = self._schedulerUpdate or self:newSchedule(handler(self, self.updateTimeShow), 1)

	g.core.network.GameNetProxy:send_C2S_RichMan_GetConstruct({})
end

function RichmanBuildPop:onRewardBuildItem(arg_4_1, arg_4_2, arg_4_3)
	self:updateBuildView()
end

function RichmanBuildPop:updateBuildView()
	local var_5_0 = var_0_4:getCurRobData()

	if not var_5_0 then
		self.m_stateController:setSelectedIndex(0)

		self._buildData = var_0_4:getBuildData()
	else
		self.m_stateController:setSelectedIndex(2)

		self._buildData = var_0_4:formatRobConstruct(var_5_0.construct)
	end

	self.m_typeController:setSelectedIndex(self._buildType - 1)

	local var_5_2 = var_0_4:getBuildCfgByTypeAndLv(self._buildType, (var_5_0 or nil) and (self._buildData:getBuildLevelByMapLvAndType(var_5_0.map_level, self._buildType) or self._buildData:getBuildLevel(self._buildType)))

	self._buildCfg = var_5_2

	self.m_buildLoader:setURL(var_0_3:getRichmanBuildRes(1, var_5_2.res))

	if not var_5_0 then
		self.m_lvTxt:setText(g.core.lang:get(120) .. self._buildData:getBuildLevel(self._buildType))
		self.m_productTimeTxt:setText(g.core.lang:get(426010, {
			min = math.ceil(var_0_4:getHangUpTime() / 60)
		}))

		self._previewList = self._buildData:getPreviewReward(self._buildType, self._buildData:getBuildLevel(self._buildType))

		self.m_previewList:setNumItems(#self._previewList)

		self._rewardList = self._buildData:getTypeBuild(self._buildType).awards or {}

		self.m_rewardList:setNumItems(#self._rewardList)
		self.m_productDesTxt:setVisible(#self._rewardList <= 0)
		self.m_getBtn:setVisible(#self._rewardList > 0)
		self.m_fightValueText:setText(g.core.model.User:getFightValue())

		if var_0_4:getMapMaxLevel() > var_0_4:getMapLevel() then
			self.m_curLvTxt:setText(var_0_4:getMapLevel())
			self.m_nextLvTxt:setText(math.min(var_0_4:getMapLevel() + 1, var_0_4:getMapMaxLevel()))
			self.m_levelStateController:setSelectedIndex(0)

			self._rewardLvUpAddList = self._buildData:getPreviewReward(self._buildType, self._buildData:getBuildLevel(self._buildType) + 1)

			self.m_lvUpRewardList:setNumItems(#self._rewardLvUpAddList)

			local var_5_3 = self._buildData:getBuildNeedMapLv(self._buildType, self._buildData:getBuildLevel(self._buildType) + 1)

			if var_5_3 == 0 then
				self.m_lvUpDescTxt:setText(g.core.lang:get(426023))
			else
				self.m_lvUpDescTxt:setText(g.core.lang:get(426013, {
					level = var_5_3
				}))
			end
		else
			self.m_lvUpDescTxt:setText(g.core.lang:get(426012))
			self.m_levelStateController:setSelectedIndex(1)
		end

		self:updateTimeShow()
	else
		local var_5_4 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_5_0.user_id)

		self._rewardList = clone(self._buildData:getTypeBuild(self._buildType).awards) or {}

		local var_5_5 = {
			type = self._buildCfg.fixed_reward_type,
			value = self._buildCfg.fixed_reward_value,
			size = self._buildCfg.fixed_reward_size
		}
		local var_5_6 = var_0_5.get(var_0_4:getMapLevel())
		local var_5_7 = {}

		for iter_5_0 = 1, 5 do
			if var_5_6["limit_reward_type_" .. iter_5_0] > 0 then
				var_5_7[var_5_6["limit_reward_type_" .. iter_5_0] .. "_" .. var_5_6["limit_reward_value_" .. iter_5_0]] = var_5_6["limit_reward_size_" .. iter_5_0]
			end
		end

		for iter_5_1, iter_5_2 in ipairs(self._rewardList) do
			iter_5_2.size = math.floor(iter_5_2.size * var_0_4:getCanStealTh() / 1000)

			if var_5_7[iter_5_2.type .. "_" .. iter_5_2.value] then
				iter_5_2.size = math.min(iter_5_2.size, var_5_7[iter_5_2.type .. "_" .. iter_5_2.value])
			end

			if var_5_5 and iter_5_2.type == var_5_5.type and iter_5_2.value == var_5_5.value then
				iter_5_2.size = iter_5_2.size + var_5_5.size
				var_5_5 = nil
			end
		end

		for iter_5_3 = #self._rewardList, 1, -1 do
			if self._rewardList[iter_5_3].size <= 0 then
				table.remove(self._rewardList, iter_5_3)
			end
		end

		if var_5_5 then
			table.insert(self._rewardList, var_5_5)
		end

		self.m_otherRewardList:setNumItems(#self._rewardList)

		if var_5_4 then
			if var_5_4 then
				self._formationList = var_5_4.knights or {
					0,
					0,
					0,
					0,
					0,
					0
				}
			end

			self.m_fightValueText:setText(var_5_4.fight_value)
		end

		self.m_lvTxt:setText(g.core.lang:get(120) .. self._buildData:getBuildLevelByMapLvAndType(var_5_0.map_level, self._buildType))
	end

	self.m_knightList:setNumItems(6)
	self.m_buildNameTxt:setText(var_5_2.name)
end

function RichmanBuildPop:_onKnightItemRenderer(arg_6_1, arg_6_2)
	local var_6_0 = var_0_4:getCurRobData()
	local var_6_1 = ""

	if var_6_0 then
		local var_6_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_6_0.user_id)

		if var_6_2 then
			var_6_1 = var_6_2.name
		end
	end

	arg_6_2:updateKnight(arg_6_1 + 1, self._formationList[arg_6_1 + 1], var_6_1)
end

function RichmanBuildPop:getTimeDesStr(arg_7_1)
	return var_0_6(2, ((arg_7_1 - arg_7_1 % 3600) / 3600 - (arg_7_1 - arg_7_1 % 3600) / 3600 % 24) / 24 * 24 + (arg_7_1 - arg_7_1 % 3600) / 3600 % 24) .. ":" .. var_0_6(2, (arg_7_1 - (arg_7_1 - arg_7_1 % 3600) / 3600 * 3600 - arg_7_1 % 60) / 60) .. ":" .. var_0_6(2, arg_7_1 % 60)
end

function RichmanBuildPop:_onPreviewItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateIcon(self._previewList[arg_8_1 + 1])
end

function RichmanBuildPop:_onPreviewAwardRenderer(arg_9_1, arg_9_2)
	arg_9_2:updateIcon(self._rewardList[arg_9_1 + 1])
end

function RichmanBuildPop:_onLvUpRewardRenderer(arg_10_1, arg_10_2)
	arg_10_2:updateIcon(self._rewardLvUpAddList[arg_10_1 + 1])
end

function RichmanBuildPop:_onOtherRewardRenderer(arg_11_1, arg_11_2)
	arg_11_2:updateIcon(self._rewardList[arg_11_1 + 1])
end

function RichmanBuildPop:updateTimeShow()
	local var_12_0 = var_0_4:getCurRobData()
	local var_12_1 = var_0_2:getTime() - self._buildData:getBuildHangUpStartTime()

	if not var_12_0 then
		self.m_hangupTimeTxt:setText(g.core.lang:get(426011, {
			time = self:getTimeDesStr(math.min(var_12_1, var_0_4:getHangUpTimeMax()))
		}))
	end

	if self._buildCfg and var_12_1 % var_0_4:getHangUpTime() == 0 then
		if var_12_0 then
			g.core.network.GameNetProxy:send_C2S_RichMan_RobData({
				user_id = var_12_0.user_id,
				event_id = var_12_0.event_id
			})
		else
			g.core.network.GameNetProxy:send_C2S_RichMan_GetConstruct({})
		end
	end
end

function RichmanBuildPop:_onGetBtnClick()
	if not var_0_4:getCurRobData() then
		g.core.network.GameNetProxy:send_C2S_RichMan_ConstructAward({})
	end
end

function RichmanBuildPop:_onAttackRobClick()
	local var_14_0 = var_0_4:getCurRobData()

	if var_14_0 then
		if var_14_0.construct.armistice > g.core.common.ServerTime:getTime() then
			g.core.module.ModuleManager:tip(g.core.lang:get(426015))
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)

			return
		end

		g.core.network.GameNetProxy:send_C2S_RichMan_RobBegin({
			tp = var_0_4:getRobType(),
			user_id = var_14_0.user_id,
			construct = self._buildType,
			event_id = var_14_0.event_id
		})
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function RichmanBuildPop:_onClosePop()
	if self._inClose then
		return
	end

	self._inClose = true

	self.m_backTransition:play(handler(self, self._onRemoveSelf))
end

function RichmanBuildPop:_onRemoveSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return RichmanBuildPop
