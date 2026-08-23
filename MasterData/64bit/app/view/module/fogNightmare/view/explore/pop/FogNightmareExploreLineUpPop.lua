local var_0_0 = g.core.model.User.fogNightmareData
local FogNightmareExploreLineUpPop = class("FogNightmareExploreLineUpPop", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreLineUpPop"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareExploreLineUpPop",
		pkgName = "fogNightmare",
		isFullScreen = true,
		pkgPath = "ui/fogNightmare/fogNightmare"
	}, ...)
end)

function FogNightmareExploreLineUpPop:ctor(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._infoGroupData = arg_2_1.infos
	self._providerPath = arg_2_1.providerPath
	self._sortFunc = arg_2_1.sortFunc
	self._selectCheckFunc = arg_2_1.selectCheckFunc
	self._selectSameFunc = arg_2_1.selectSameFunc
	self._type = arg_2_1.type
	self._cellParams = arg_2_1.cellParams or {}
	self._hideFilter = arg_2_1.hideFilter or false
	self._isFilter = arg_2_1.isFilter or false
	self._tabIndex = 1

	self:_initView()
	self:_updateTopUI(arg_2_1)
end

function FogNightmareExploreLineUpPop:_initView()
	self.m_topTabList:setVirtual()
	self.m_topTabList:setItemRenderer(handler(self, self._onRenderTabItem))
	self.m_topTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabItemSelected))
	self.m_lineList:setVirtual(self)
	self.m_lineList:setItemProvider(handler(self, self._onLineListItemProvider))
	self.m_lineList:setItemRenderer(handler(self, self._onRenderLineListItem))
	self.m_lineList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onLineListItemSelected))
	self.m_lineList:doFairyBatching(false)
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClickClose))
	self.m_filterSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onFilterSelectedChanged))

	if self._isFilter then
		self.m_filterSelController:setSelectedIndex(1)
	end

	if self._sortFunc then
		for iter_3_0, iter_3_1 in ipairs(self._infoGroupData) do
			table.sort(iter_3_1, self._sortFunc)
		end
	end

	local var_3_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_content)

	if var_3_0 then
		self._isPlayerEnter = true

		var_3_0:play(handler(self, self.onFogEnterFinish))
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.FOG_NIGHTMARE_LINEUP_SLIDE)

	if self._hideFilter then
		self.m_filterBtn:setVisible(false)
	end
end

function FogNightmareExploreLineUpPop:onFogEnterFinish()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
end

function FogNightmareExploreLineUpPop:_onFilterSelectedChanged()
	self:updateCurGroupList()
end

function FogNightmareExploreLineUpPop:updateCurGroupList()
	local var_6_0 = self._cellParams.dataList or {}

	if self.m_filterSelController:getSelectedIndex() == 1 then
		self._curGroupList = {}

		for iter_6_0, iter_6_1 in ipairs(self._infoGroupData[self._tabIndex + 1] or {}) do
			local var_6_1 = false

			if self._type == "KNIGHT" then
				var_6_1 = iter_6_1:isLineup() or iter_6_1:getTempFormationPos() > 0
			elseif self._type == "ARTIFACT" then
				var_6_1 = var_6_0[iter_6_1:getAdvanceId()]

				if var_6_1 then
					local var_6_2 = var_6_0[iter_6_1:getAdvanceId()]
					local var_6_3 = iter_6_1:getBelongToKnightAvdIdIncludingMainRole()
					local var_6_4 = var_0_0:getFormationData():getKnightByIndexAndPos(var_6_2.formationIndex, var_6_2.pos)

					var_6_1 = self._cellParams.knightAdvId ~= var_6_3 or (var_6_4 and var_6_4:getAdvanceId() or 0) == var_6_3 or not not iter_6_1:isDemo()
				end
			elseif self._type == "UNITE" then
				local var_6_5
				local var_6_6, var_6_7

				if self.m_filterSelController:getSelectedIndex() == 1 then
					var_6_5 = self._cellParams.curFormation
					var_6_6 = var_0_0:getFormationData()
					var_6_7 = iter_6_1
				end

				var_6_1 = var_6_6:checkUniteInAllFormation(var_6_7, g.core.config.multi_team_formation_info.get(g.core.const.ConstMgr.LineUpConst.MulTeamType.FOG_NIGHTMARE).unite_token_repeat == 1 and var_6_5 or nil)
			elseif self._type == "PET" then
				var_6_1 = var_0_0:getFormationData():checkPetInAllFormation(iter_6_1, (g.core.config.multi_team_formation_info.get(g.core.const.ConstMgr.LineUpConst.MulTeamType.FOG_NIGHTMARE).pet_repeat == 1 or nil) and (self._cellParams.curFormation or nil))
			elseif self._type == "SUCCUBA" then
				var_6_1 = var_0_0:getFormationData():checkSuccubaInAllFormation(iter_6_1, (g.core.config.multi_team_formation_info.get(g.core.const.ConstMgr.LineUpConst.MulTeamType.FOG_NIGHTMARE).succuba_repeat == 1 or nil) and (self._cellParams.curFormation or nil))
			end

			if not var_6_1 then
				table.insert(self._curGroupList, iter_6_1)
			end
		end
	else
		self._curGroupList = self._infoGroupData[self._tabIndex + 1]
	end

	self.m_lineList:setNumItems(#self._curGroupList)
	self.m_isEmptyController:setSelectedIndex(#self._curGroupList == 0 and 1 or 0)
end

function FogNightmareExploreLineUpPop:onLoad()
	self.m_topTabList:setSelectedIndex(0)

	if not self._topTip then
		self.m_runnerBanner:init({
			target = self.m_topTabList
		})
	end

	self:_onTabItemSelected()
end

function FogNightmareExploreLineUpPop:_updateTopUI(arg_8_1)
	self._topTip = arg_8_1.topTip

	if self._topTip then
		self.m_tipText:setText(self._topTip)
		self.m_showTopTabController:setSelectedIndex(0)
	else
		self._tabTexts = arg_8_1.tabTexts

		self.m_topTabList:setNumItems(#self._tabTexts)
		self.m_showTopTabController:setSelectedIndex(1)
	end
end

function FogNightmareExploreLineUpPop:_onRenderTabItem(arg_9_1, arg_9_2)
	arg_9_2:setTitle(self._tabTexts[arg_9_1 + 1])
end

function FogNightmareExploreLineUpPop:_onTabItemSelected()
	local var_10_0 = self.m_topTabList:getSelectedIndex()

	if var_10_0 == self._tabIndex then
		return
	end

	self._tabIndex = var_10_0

	if self._topTip then
		self._tabIndex = 0
	end

	self:_updateList()
end

function FogNightmareExploreLineUpPop:_updateList()
	self:updateCurGroupList()
	self.m_isEmptyController:setSelectedIndex(#self._curGroupList == 0 and 1 or 0)

	if #self._curGroupList == 0 then
		if self._type == "KNIGHT" then
			self.m_emptyComp:setTitle(g.core.lang:get(500165))
		elseif self._type == "ARTIFACT" then
			self.m_emptyComp:setTitle(g.core.lang:get(500166))
		elseif self._type == "UNITE" then
			self.m_emptyComp:setTitle(g.core.lang:get(500167))
		elseif self._type == "PET" then
			self.m_emptyComp:setTitle(g.core.lang:get(500241))
		elseif self._type == "SUCCUBA" then
			self.m_emptyComp:setTitle(g.core.lang:get(500272))
		end
	end
end

function FogNightmareExploreLineUpPop:_onLineListItemProvider()
	return self._providerPath
end

function FogNightmareExploreLineUpPop:_onRenderLineListItem(arg_13_1, arg_13_2)
	arg_13_2:updateComp(self._curGroupList[arg_13_1 + 1], self._cellParams)
end

function FogNightmareExploreLineUpPop:_onLineListItemSelected(arg_14_1)
	local var_14_0 = self._curGroupList[arg_14_1:getDataValue() + 1]

	if not self._selectCheckFunc or self._selectCheckFunc and self._selectCheckFunc(var_14_0) then
		self:dispatchCompEvent("LineListItemSelected", {
			struct = var_14_0
		})
		g.core.module.ModuleManager:popByDisplay(self)
	elseif self._selectSameFunc and self._selectSameFunc(var_14_0) then
		self:dispatchCompEvent("LineListSameItemSelected", {
			struct = var_14_0
		})
		g.core.module.ModuleManager:popByDisplay(self)
	end
end

function FogNightmareExploreLineUpPop:_onFilterBtnClicked()
	return
end

function FogNightmareExploreLineUpPop:_onClickClose(arg_16_1)
	if self._isOnClose then
		return
	end

	if (arg_16_1 or nil) and not self.m_bgPanel:containPoint((arg_16_1:getInput():getTouch():getLocation())) then
		self.m_lineList:setTouchable(false)

		self._isOnClose = true

		local var_16_1 = self:getView():getSharedTrans("back", "CommonRightPanelAnim", self.m_content)

		if var_16_1 then
			var_16_1:play(function()
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end)
		else
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end
	end
end

return FogNightmareExploreLineUpPop
