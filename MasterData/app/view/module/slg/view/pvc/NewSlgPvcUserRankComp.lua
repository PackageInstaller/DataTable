local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local var_0_2 = g.core.model.User.newSlgData
local NewSlgPvcUserRankComp = class("NewSlgPvcUserRankComp", require("app.fairyGUI.newSlg.UI_NewSlgPvcUserRankComp"))

function NewSlgPvcUserRankComp:ctor()
	self._allCityList = var_0_2:getNewSlgMyPathCity()
	self._curCityCfg = nil

	self:_initComp()
end

function NewSlgPvcUserRankComp:_initComp()
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(self._allCityList) do
		var_2_0[#var_2_0 + 1] = iter_2_1.type == var_0_0.CITY_TYPE.FINAL_DRAGON and iter_2_1.name or g.core.lang:get(428899, {
			level = iter_2_1.level,
			name = iter_2_1.name
		})
	end

	self.m_chooseComp:updateChooseComp(var_2_0)
	self.m_chooseComp:setSelectHandler(handler(self, self._onComboBoxChanged))
	self.m_chooseComp:setListShowHandler(handler(self, self._onChooseCompVisibleChanged))
	self.m_rankList:setVirtual(self)
	self.m_rankList:setItemRenderer(handler(self, self._onRankItemRender))
	self.m_rankList:doFairyBatching(false)
	self.m_chooseCompHideTouch:addClickListener(handler(self, self._hideChooseComp))
end

function NewSlgPvcUserRankComp:setDefaultCityId(arg_3_1)
	self.curCityId = arg_3_1

	local var_3_0 = 1

	if not self.curCityId then
		self.curCityId = self._allCityList[1].id
		self._curCityCfg = self._allCityList[1]
	else
		for iter_3_0, iter_3_1 in ipairs(self._allCityList) do
			if iter_3_1.id == self.curCityId then
				self._curCityCfg = iter_3_1
				var_3_0 = iter_3_0

				break
			end
		end

		if not self._curCityCfg then
			self._curCityCfg = g.core.config.new_slg_city_info.get(arg_3_1)

			table.insert(self._allCityList, var_3_0, self._curCityCfg)
			self.m_chooseComp:addTitleByIdx(self._curCityCfg.type == var_0_0.CITY_TYPE.FINAL_DRAGON and self._curCityCfg.name or g.core.lang:get(428899, {
				level = self._curCityCfg.level,
				name = self._curCityCfg.name
			}), 1)
		end
	end

	self.m_chooseComp:setSelectedIndex(var_3_0, true)
end

function NewSlgPvcUserRankComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateRank), self)
end

function NewSlgPvcUserRankComp:updateRankView(arg_5_1, arg_5_2)
	self._rankType = arg_5_2
	self._rankUnits = arg_5_1.rank_units

	if self._rankType == var_0_0.RANK_TYPE.PERSONAL_UNION then
		self.m_showComBoxController:setSelectedIndex(1)
	else
		self.m_showComBoxController:setSelectedIndex(0)
	end

	if not self._isReward then
		self:_updateRank()
	else
		self:_updateReward()
	end
end

function NewSlgPvcUserRankComp:setRankType(arg_6_1)
	self._rankType = arg_6_1

	self.m_showComBoxController:setSelectedIndex(0)
end

function NewSlgPvcUserRankComp:_updateRank()
	if not self:isVisible() then
		return
	end

	if self._rankUnits and #self._rankUnits > 0 then
		if #self._rankUnits > 0 then
			self.m_rankList:setNumItems(#self._rankUnits)
			self.m_emptyController:setSelectedIndex(1)
		else
			self.m_rankList:setNumItems(0)
			self.m_emptyController:setSelectedIndex(0)
		end
	else
		self.m_rankList:setNumItems(0)
		self.m_emptyController:setSelectedIndex(0)
	end
end

function NewSlgPvcUserRankComp:isRewardTab(arg_8_1)
	self._isReward = arg_8_1

	if self._rankType == var_0_0.RANK_TYPE.PERSONAL_UNION then
		self.m_showComBoxController:setSelectedIndex(1)
	else
		self.m_showComBoxController:setSelectedIndex(0)
	end

	if arg_8_1 then
		self.m_tipTypeController:setSelectedIndex(1)

		if self._rankType then
			self:_updateReward()
		end
	else
		if self._rankType then
			self:_updateRank()
		end

		self.m_tipTypeController:setSelectedIndex(0)
	end
end

function NewSlgPvcUserRankComp:_updateReward()
	self._rewardData = self._rankType == var_0_0.RANK_TYPE.PERSONAL_UNION and var_0_2:getNewSlgCurrentRankReward(self._rankType, self._curCityCfg.level) or var_0_2:getNewSlgCurrentRankReward(self._rankType)

	self.m_emptyController:setSelectedIndex(1)
	self.m_rankList:setNumItems(#self._rewardData)
end

function NewSlgPvcUserRankComp:setEmpty()
	self.m_emptyController:setSelectedIndex(0)
end

function NewSlgPvcUserRankComp:_onRankItemRender(arg_11_1, arg_11_2)
	if self._rankUnits and not self._isReward then
		arg_11_2:updateRankCell(self._rankUnits[arg_11_1 + 1], arg_11_1 + 1)
	elseif self._isReward then
		arg_11_2:updateRankCell(nil, arg_11_1 + 1, self._rewardData[arg_11_1 + 1])
	end
end

function NewSlgPvcUserRankComp:_onComboBoxChanged(arg_12_1)
	self._curCityCfg = self._allCityList[arg_12_1]

	self:dispatchCompEvent("NEW_SLG_RANK_CHANGE_CITY")
end

function NewSlgPvcUserRankComp:getCityId()
	return self._curCityCfg.id
end

function NewSlgPvcUserRankComp:_onChooseCompVisibleChanged(arg_14_1)
	self.m_chooseCompHideTouch:setVisible(arg_14_1)
end

function NewSlgPvcUserRankComp:_hideChooseComp()
	self.m_chooseComp:setShowListEnable(false)
end

return NewSlgPvcUserRankComp
