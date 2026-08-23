local KnightRecommendLayer = class("KnightRecommendLayer", require("app.fairyGUI.knightBag.UI_KnightRecommendLayer"), function()
	return fgui.GComponent:create({
		resName = "KnightRecommendLayer",
		pkgPath = "ui/knightBag/knightBag",
		isFullScreen = true,
		pkgName = "knightBag"
	})
end)

function KnightRecommendLayer:ctor()
	self._tabDict = {}
	self._elementTabDict = {}
	self._recommendData = {}

	self.m_huawenLoader:setURL("pic/base_new/pic_yht_huawen.png")
	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onTabRenderer))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickTab))
	self.m_elementTabList:setVirtual()
	self.m_elementTabList:setItemRenderer(handler(self, self._onElementTabRenderer))
	self.m_elementTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickElementTab))
	self.m_recommendList:setVirtual()
	self.m_recommendList:doFairyBatching(false)
	self.m_recommendList:setItemRenderer(handler(self, self._onRecommendRenderer))
end

function KnightRecommendLayer:_onTabRenderer(arg_3_1, arg_3_2)
	arg_3_2:setText(self._tabDict[arg_3_1 + 1].tabName)
end

function KnightRecommendLayer:_onClickTab()
	local var_4_0 = self._tabDict[self.m_tabList:getSelectedIndex() + 1]

	self.m_elementTabList:setNumItems(#self._elementTabDict[var_4_0.tabValue])
	self.m_elementTabList:setSelectedIndex(0)

	self._curRecommendTeams = self._recommendData[var_4_0.tabValue][self._elementTabDict[var_4_0.tabValue][self.m_elementTabList:getSelectedIndex() + 1].tabValue]

	self.m_recommendList:setNumItems(#self._curRecommendTeams)
end

function KnightRecommendLayer:_onElementTabRenderer(arg_5_1, arg_5_2)
	arg_5_2:setText(self._elementTabDict[self._tabDict[self.m_tabList:getSelectedIndex() + 1].tabValue][arg_5_1 + 1].tabName)
end

function KnightRecommendLayer:_onClickElementTab()
	local var_6_0 = self._tabDict[self.m_tabList:getSelectedIndex() + 1]

	self._curRecommendTeams = self._recommendData[var_6_0.tabValue][self._elementTabDict[var_6_0.tabValue][self.m_elementTabList:getSelectedIndex() + 1].tabValue]

	self.m_recommendList:setNumItems(#self._curRecommendTeams)
end

function KnightRecommendLayer:_onRecommendRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateComp(self._curRecommendTeams[arg_7_1 + 1])
end

function KnightRecommendLayer:onLoad()
	self:_initData()
	self:updateView()
end

function KnightRecommendLayer:_initData()
	local function var_9_0(arg_10_0, arg_10_1)
		for iter_10_0, iter_10_1 in ipairs(arg_10_0) do
			if iter_10_1.tabValue == arg_10_1 then
				return true
			end
		end

		return false
	end

	for iter_9_0 = 1, g.core.config.lineup_recommend_info.getLength() do
		local var_9_1 = g.core.config.lineup_recommend_info.indexOf(iter_9_0)

		if not var_9_0(self._tabDict, var_9_1.type) then
			table.insert(self._tabDict, {
				tabValue = var_9_1.type,
				tabName = var_9_1.type_name
			})
		end

		if not self._elementTabDict[var_9_1.type] then
			self._elementTabDict[var_9_1.type] = {}

			table.insert(self._elementTabDict[var_9_1.type], {
				tabValue = 0,
				tabName = g.core.lang:get(433501)
			})
		end

		if not var_9_0(self._elementTabDict[var_9_1.type], var_9_1.type_value) then
			table.insert(self._elementTabDict[var_9_1.type], {
				tabValue = var_9_1.type_value,
				tabName = var_9_1.type_value_name
			})
		end

		if not self._recommendData[var_9_1.type] then
			self._recommendData[var_9_1.type] = {}
			self._recommendData[var_9_1.type][0] = {}
		end

		local var_9_2, var_9_3, var_9_4, var_9_5

		if not self._recommendData[var_9_1.type][var_9_1.type_value] then
			self._recommendData[var_9_1.type][var_9_1.type_value] = {}
			var_9_2 = {}
			var_9_3 = {}
			var_9_4 = {}
			var_9_5 = {}
		end

		for iter_9_1 = 1, g.core.model.User.formationData:getUnlockFormationNum() do
			local var_9_6 = var_9_1["knight_id_" .. iter_9_1]
			local var_9_7 = var_9_1["replace_id_" .. iter_9_1]

			if var_9_1["replace_id_" .. iter_9_1] > 0 then
				var_9_3[iter_9_1] = var_9_7
			end

			local var_9_8 = g.core.model.User.knightsData:getKnightByAdvanceId(var_9_6)
			local var_9_9 = var_9_8 and g.core.model.User.artifactData:getArtifactByAdvacnceId(var_9_8:getArtifactId()) or nil
			local var_9_10 = var_9_7 > 0 and g.core.model.User.knightsData:getKnightByAdvanceId(var_9_7) or nil
			local var_9_11 = var_9_10 and g.core.model.User.artifactData:getArtifactByAdvacnceId(var_9_10:getArtifactId()) or nil

			if var_9_8 and var_9_8:isOwn() then
				var_9_2[iter_9_1] = var_9_6

				if var_9_9:isOwn() then
					var_9_4[iter_9_1] = var_9_8:getArtifactId()
				end
			elseif var_9_10 and var_9_10:isOwn() then
				var_9_2[iter_9_1] = var_9_7

				if var_9_11:isOwn() then
					var_9_4[iter_9_1] = var_9_10:getArtifactId()
				end
			else
				table.insert(var_9_5, {
					id = var_9_6,
					pos = iter_9_1
				})
			end
		end

		table.insert(self._recommendData[var_9_1.type][0], {
			cfg = var_9_1,
			matchPercent = g.core.model.User.knightsData:getRecommendMatchPercent(var_9_1),
			knightIds = var_9_2,
			artifactIds = var_9_4,
			notOwnKnightData = var_9_5,
			replaceKnightIds = var_9_3
		})

		if var_9_1.type_value ~= 0 then
			table.insert(self._recommendData[var_9_1.type][var_9_1.type_value], {
				cfg = var_9_1,
				matchPercent = g.core.model.User.knightsData:getRecommendMatchPercent(var_9_1),
				knightIds = var_9_2,
				artifactIds = var_9_4,
				notOwnKnightData = var_9_5,
				replaceKnightIds = var_9_3
			})
		end
	end

	table.sort(self._tabDict, function(arg_11_0, arg_11_1)
		return arg_11_0.tabValue < arg_11_1.tabValue
	end)

	for iter_9_2 = 1, #self._elementTabDict do
		table.sort(self._elementTabDict[iter_9_2], function(arg_12_0, arg_12_1)
			return arg_12_0.tabValue < arg_12_1.tabValue
		end)
	end

	for iter_9_3, iter_9_4 in pairs(self._recommendData) do
		for iter_9_5, iter_9_6 in pairs(iter_9_4) do
			table.sort(iter_9_6, function(arg_13_0, arg_13_1)
				if arg_13_0.matchPercent ~= arg_13_1.matchPercent then
					return arg_13_0.matchPercent > arg_13_1.matchPercent
				end

				if table.nums(arg_13_0.replaceKnightIds) ~= table.nums(arg_13_1.replaceKnightIds) then
					return table.nums(arg_13_0.replaceKnightIds) < table.nums(arg_13_1.replaceKnightIds)
				end

				return arg_13_0.cfg.sort_weight < arg_13_1.cfg.sort_weight
			end)
		end
	end
end

function KnightRecommendLayer:updateView()
	self.m_tabList:setNumItems(#self._tabDict)
	self.m_tabList:setSelectedIndex(0)
	self.m_elementTabList:setNumItems(#self._elementTabDict[self.m_tabList:getSelectedIndex() + 1])
	self.m_elementTabList:setSelectedIndex(0)
	self:_onClickTab()
end

return KnightRecommendLayer
