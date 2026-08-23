local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local var_0_1 = g.core.const.ConstMgr.NewSlgConst.RANK_TYPE_ID_MAP
local var_0_2 = g.core.model.User.newSlgData
local NewSlgPvcRankRewardPop = class("NewSlgPvcRankRewardPop", function()
	return fgui.GComponent:create({
		resName = "NewSlgPvcRankRewardPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)

function NewSlgPvcRankRewardPop:ctor(arg_2_1)
	self._myRewardData = {}
	self._rewardData = {}
	self._rankInfo = {}
	self._curCityCfg = nil

	self:showAtCenter()

	self._comboBox = self:getChild("Com_box")
	self._rewardList = self:getChild("List_reward")

	self._rewardList:setVirtual()
	self._rewardList:setItemRenderer(handler(self, self._onRewardItemRender))

	self._myRewardList = self:getChild("List_myReward")

	self._myRewardList:setVirtual()
	self._myRewardList:setItemRenderer(handler(self, self._onMyRewardItemRender))

	self._rewardList2 = self:getChild("List_myReward2")

	self._rewardList2:setVirtual()
	self._rewardList2:setItemRenderer(handler(self, self._onMyRewardItemRender2))

	self._allCityList = var_0_2:getNewSlgMyPathCity()

	self:initCityInfo(arg_2_1 and arg_2_1.cityId)
	self:getController("bigTab"):addEventListener(fgui.UIEventType.Changed, handler(self, self.updateReq))
	self:getController("rightTab"):addEventListener(fgui.UIEventType.Changed, handler(self, self.updateReq))

	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.rankType or 0
	end

	self:getChild("ComPopPanel"):setHelpId(468)

	if var_2_0 > 0 then
		if var_2_0 > 2 then
			self:getController("bigTab"):setSelectedIndex(1)
			self:getController("rightTab"):setSelectedIndex(var_2_0 - 3)
		else
			self:getController("bigTab"):setSelectedIndex(0)
			self:getController("rightTab"):setSelectedIndex(var_2_0 - 1)
		end
	end
end

function NewSlgPvcRankRewardPop:initCityInfo(arg_3_1)
	local var_3_0 = 1

	if not arg_3_1 then
		self._curCityCfg = self._allCityList[1]
	else
		for iter_3_0, iter_3_1 in ipairs(self._allCityList) do
			if iter_3_1.id == arg_3_1 then
				self._curCityCfg = iter_3_1
				var_3_0 = iter_3_0

				break
			end
		end

		self._curCityCfg = self._curCityCfg or g.core.config.new_slg_city_info.get(arg_3_1)
	end

	if self._curCityCfg.type == var_0_0.CITY_TYPE.FINAL_DRAGON then
		self._comboBox:setText(self._curCityCfg.name)
	else
		self._comboBox:setText(g.core.lang:get(428899, {
			level = self._curCityCfg.level,
			name = self._curCityCfg.name
		}))
	end

	local var_3_1 = {}

	for iter_3_2, iter_3_3 in ipairs(self._allCityList) do
		if iter_3_3.type == var_0_0.CITY_TYPE.FINAL_DRAGON then
			table.insert(var_3_1, {
				text = iter_3_3.name
			})
		else
			table.insert(var_3_1, {
				text = g.core.lang:get(428899, {
					level = iter_3_3.level,
					name = iter_3_3.name
				})
			})
		end
	end

	self._cityNameList = var_3_1

	self._comboBox:setChangeCallBack(handler(self, self._onComboBoxChanged))
	self._comboBox:setData(var_3_1, var_3_0)
	self._comboBox:setMaxShowNum(6)
end

function NewSlgPvcRankRewardPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETRANK, self.onS2CNewSlgGetRank, self)
	self:updateReq()
end

function NewSlgPvcRankRewardPop:onS2CNewSlgGetRank(arg_5_1, arg_5_2, arg_5_3)
	self._rankInfo[arg_5_3.id] = arg_5_3.self_unit

	self:updateRankRewardView()
end

function NewSlgPvcRankRewardPop:updateReq()
	local var_6_0 = self:getController("bigTab")
	local var_6_1 = var_6_0:getSelectedIndex() * 2 + self:getController("rightTab").getSelectedIndex(var_6_0) + 1

	self._rankInfo = self._rankInfo or {}

	if g.core.model.User.newSlgData:isForecasting() then
		self:updateRankRewardView()

		return
	end

	if not self._rankInfo[var_6_1] then
		if var_6_1 == var_0_0.RANK_TYPE.PERSONAL_UNION and not g.core.model.User.allianceData:hasAlliance() then
			self:updateRankRewardView()

			return
		end

		local var_6_2 = {
			limit = 1,
			id = var_6_1
		}

		if var_6_1 == var_0_0.RANK_TYPE.PERSONAL_UNION and self._curCityCfg then
			var_6_2.city_id = self._curCityCfg.id or nil
		end

		g.core.network.GameNetProxy:send_C2S_NewSlg_GetRank(var_6_2)
	else
		self:updateRankRewardView()
	end
end

function NewSlgPvcRankRewardPop:updateRankRewardView()
	local var_7_9000
	local var_7_0 = self:getController("bigTab")
	local var_7_1 = var_7_9000 + self:getController("rightTab").getSelectedIndex(var_7_0) + 1
	local var_7_2

	if var_7_0:getSelectedIndex() * 2 == var_0_0.RANK_TYPE.PERSONAL_UNION then
		var_7_2 = self._curCityCfg.level
	end

	self._rankType = var_7_1

	self:setCtrlState("type", {
		index = var_7_1 - 1
	})
	self._comboBox:setVisible(var_7_1 == var_0_0.RANK_TYPE.PERSONAL_UNION)

	self._rewardData = var_0_2:getNewSlgCurrentRankReward(var_7_1, var_7_2)

	self._rewardList:setNumItems(#self._rewardData)

	self._rankInfo = self._rankInfo or {}

	if self._rankInfo[var_7_1] then
		if self._rankInfo[var_7_1].rank > 0 and self._rankInfo[var_7_1].rank < var_0_2:getNewSlgParamsValueById(var_0_1[var_7_1]) then
			self:setCtrlState("inRank", {
				index = 1
			})

			for iter_7_0, iter_7_1 in ipairs(self._rewardData) do
				if self._rankInfo[var_7_1].rank >= iter_7_1.min_rank and self._rankInfo[var_7_1].rank <= iter_7_1.max_rank then
					self:setCtrlState("inRank", {
						index = 2
					})

					local var_7_3 = tostring(iter_7_1.min_rank)

					if iter_7_1.max_rank ~= iter_7_1.min_rank then
						-- block empty
					end

					self:getChild("Txt_rank"):setText(g.core.lang:get(428946, {
						rank = self._rankInfo[var_7_1].rank
					}))

					local var_7_5 = {}

					for iter_7_2 = 1, 6 do
						if iter_7_1["reward_size_" .. iter_7_2] > 0 then
							table.insert(var_7_5, {
								type = iter_7_1["reward_type_" .. iter_7_2],
								value = iter_7_1["reward_value_" .. iter_7_2],
								size = iter_7_1["reward_size_" .. iter_7_2]
							})
						end
					end

					self._myRewardData = var_7_5

					self._myRewardList:setNumItems(#var_7_5)

					if var_7_1 == var_0_0.RANK_TYPE.PERSONAL_ALL then
						self._exRewardList = {}

						for iter_7_3 = 1, 3 do
							if iter_7_1["extra_reward_size_" .. iter_7_3] > 0 then
								table.insert(self._exRewardList, {
									type = iter_7_1["extra_reward_type_" .. iter_7_3],
									value = iter_7_1["extra_reward_value_" .. iter_7_3],
									size = iter_7_1["extra_reward_size_" .. iter_7_3]
								})
							end
						end

						if self._rewardList2 then
							self._rewardList2:setNumItems(#self._exRewardList)
						end
					end

					break
				end
			end
		else
			self:setCtrlState("inRank", {
				index = 0
			})
		end
	else
		self:setCtrlState("inRank", {
			index = 0
		})
	end
end

function NewSlgPvcRankRewardPop:_onComboBoxChanged(arg_8_1)
	self._selType = arg_8_1
	self._curCityCfg = self._allCityList[self._selType]

	local var_8_0 = self._curCityCfg.id

	if self._curCityCfg.type == var_0_0.CITY_TYPE.FINAL_DRAGON then
		self._comboBox:setText(self._curCityCfg.name)
	else
		self._comboBox:setText(g.core.lang:get(428899, {
			level = self._curCityCfg.level,
			name = self._curCityCfg.name
		}))
	end

	if not g.core.model.User.allianceData:hasAlliance() or g.core.model.User.newSlgData:isForecasting() then
		self:updateRankRewardView()

		return
	end

	g.core.network.GameNetProxy:send_C2S_NewSlg_GetRank({
		limit = 1,
		id = var_0_0.RANK_TYPE.PERSONAL_UNION,
		city_id = var_8_0
	})
end

function NewSlgPvcRankRewardPop:_onRewardItemRender(arg_9_1, arg_9_2)
	arg_9_2:updateNewSlgFinalRewardCell(self._rewardData[arg_9_1 + 1], self._rankType)
	arg_9_2:setCurRank((self._rankInfo[self._rankType] or nil) and (self._rankInfo[self._rankType].rank or 0))
end

function NewSlgPvcRankRewardPop:_onMyRewardItemRender(arg_10_1, arg_10_2)
	arg_10_2:setScaleIndex(1)
	arg_10_2:updateIcon(self._myRewardData[arg_10_1 + 1], true)
end

function NewSlgPvcRankRewardPop:_onMyRewardItemRender2(arg_11_1, arg_11_2)
	arg_11_2:setScaleIndex(1)
	arg_11_2:updateIcon(self._exRewardList[arg_11_1 + 1], true)
end

return NewSlgPvcRankRewardPop
