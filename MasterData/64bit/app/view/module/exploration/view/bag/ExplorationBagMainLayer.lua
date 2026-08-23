local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.config.exploration_parameter_info
local var_0_3 = g.core.const.ConstMgr.ExplorationConst
local var_0_4 = g.core.model.User.explorationData
local ExplorationBagMainLayer = class("ExplorationBagMainLayer", require("app.fairyGUI.exploration.UI_ExplorationBagMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "exploration",
		isFullScreen = true,
		pkgPath = "ui/exploration/exploration",
		resName = "ExplorationBagMainLayer"
	}, ...)
end)

function ExplorationBagMainLayer:ctor()
	self._formationData = var_0_4:getFormationData()
	self._curIndex = var_0_3.BAG_TYPE.KNIGHT
	self._showCardList = {}
	self._listDict = {}

	self:initView()
	self.m_enterTransition:play()
end

function ExplorationBagMainLayer:initView()
	self:addBg("bg/exploration/bg_slmj_cangku.jpg", false, nil, 1)
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.EXPLORATION_LAYER)

	local var_3_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_3_1 = self.m_showList:getWidth() * (display.width / CC_DESIGN_RESOLUTION.width)

	if var_3_0.x > 0 then
		var_3_1 = var_3_1 - var_3_0.x * 2
	end

	self.m_showList:setWidth(var_3_1)
	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onRenderTabList))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickTabList))
	self.m_showList:setVirtual(self)
	self.m_showList:doFairyBatching(false)
	self.m_showList:setItemRenderer(handler(self, self._onRenderShowCardList))
	self.m_recoveryBtn:addClickListener(handler(self, self._onClickRecoveryBtn))
end

function ExplorationBagMainLayer:_onClickTabList(arg_4_1)
	local var_4_0 = arg_4_1:getDataValue()

	if var_4_0 == self._curIndex then
		return
	end

	self._curIndex = var_4_0

	self:updateShowList()
end

function ExplorationBagMainLayer:_onRenderTabList(arg_5_1, arg_5_2)
	arg_5_2:setTitle(self:getShowName(arg_5_1))
end

function ExplorationBagMainLayer:_onRenderShowCardList(arg_6_1, arg_6_2)
	if self._curIndex == var_0_3.BAG_TYPE.KNIGHT then
		arg_6_2:updateByKnight(self._showCardList[arg_6_1 + 1])
	elseif self._curIndex == var_0_3.BAG_TYPE.ARTIFACT then
		arg_6_2:updateByArtifact(self._showCardList[arg_6_1 + 1])
	elseif self._curIndex == var_0_3.BAG_TYPE.UNITE_TOKEN then
		arg_6_2:updateByUniteToken(self._showCardList[arg_6_1 + 1])
	elseif self._curIndex == var_0_3.BAG_TYPE.PET then
		arg_6_2:updateByPet(self._showCardList[arg_6_1 + 1])
	end
end

function ExplorationBagMainLayer:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_EXPLORATION_SELL, self._onS2CSell, self)
	self:updateView()
	self.m_tabList:setSelectedIndex(self._curIndex)
end

function ExplorationBagMainLayer:updateRedPoint()
	var_0_1:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_recoveryBtn:getChild("redPointComp")
	})
end

function ExplorationBagMainLayer:_onS2CSell(arg_9_1, arg_9_2, arg_9_3)
	self._listDict = {}

	self:updateShowList()
	self:updateRedPoint()
end

function ExplorationBagMainLayer:getShowName(arg_10_1)
	if arg_10_1 == var_0_3.BAG_TYPE.KNIGHT then
		return g.core.lang:get(408704)
	elseif arg_10_1 == var_0_3.BAG_TYPE.ARTIFACT then
		return g.core.lang:get(408714)
	elseif arg_10_1 == var_0_3.BAG_TYPE.UNITE_TOKEN then
		return g.core.lang:get(408705)
	elseif arg_10_1 == var_0_3.BAG_TYPE.PET then
		return g.core.lang:get(408717)
	end
end

function ExplorationBagMainLayer:updateView()
	self.m_tabList:setNumItems(1)
	self:updateShowList()
	self:updateRedPoint()
end

function ExplorationBagMainLayer:updateShowList()
	self._showCardList = self:getShowList(self._curIndex)

	self.m_showList:setNumItems(#self._showCardList)
	self.m_isEmptyController:setSelectedIndex(#self._showCardList == 0 and 1 or 0)

	local var_12_0 = var_0_2.get(var_0_3.BAG_MAX_PARAMETER_ID).parameter

	self.m_curNumText:setText(#self._showCardList)
	self.m_maxText:setText(g.core.lang:get(201028, {
		num = var_12_0
	}))

	if var_12_0 <= #self._showCardList then
		self.m_isMaxController:setSelectedIndex(1)

		local var_12_1 = self:getShowName(self._curIndex)

		self.m_maxTipText:setText(g.core.lang:get(420652, {
			name1 = var_12_1,
			name2 = var_12_1
		}))
	else
		self.m_isMaxController:setSelectedIndex(0)
	end
end

function ExplorationBagMainLayer:getShowList(arg_13_1)
	if not self._listDict[arg_13_1] then
		local var_13_0 = {}

		if arg_13_1 == var_0_3.BAG_TYPE.KNIGHT then
			for iter_13_0, iter_13_1 in ipairs(self._formationData:getAllKnightList()) do
				if not self._formationData:isSelfKnight(iter_13_1:getServerId()) then
					table.insert(var_13_0, iter_13_1)
				end
			end

			table.sort(var_13_0, function(arg_14_0, arg_14_1)
				local var_14_0 = arg_14_0:getInfo().source_type == var_0_3.KNIGHT_TYPE_RES.OTHER and 1 or 0
				local var_14_1 = arg_14_1:getInfo().source_type == var_0_3.KNIGHT_TYPE_RES.OTHER and 1 or 0

				if var_14_0 ~= var_14_1 then
					return var_14_1 < var_14_0
				end

				local var_14_2 = arg_14_0:getQuality()
				local var_14_3 = arg_14_1:getQuality()

				if var_14_2 ~= var_14_3 then
					return var_14_3 < var_14_2
				end

				local var_14_4 = arg_14_0:getAdvanceId()
				local var_14_5 = arg_14_1:getAdvanceId()

				if var_14_4 ~= var_14_5 then
					return var_14_5 < var_14_4
				end

				return arg_14_0:getStarLv() > arg_14_1:getStarLv()
			end)
		elseif arg_13_1 == var_0_3.BAG_TYPE.ARTIFACT then
			var_13_0 = self._formationData:getAllArtifactList()

			table.sort(var_13_0, function(arg_15_0, arg_15_1)
				local var_15_0 = arg_15_0:getQuality()
				local var_15_1 = arg_15_1:getQuality()

				if var_15_0 ~= var_15_1 then
					return var_15_1 < var_15_0
				end

				local var_15_2 = arg_15_0:getStar()
				local var_15_3 = arg_15_1:getStar()

				if var_15_2 ~= var_15_3 then
					return var_15_3 < var_15_2
				end

				return arg_15_0:getAdvanceId() > arg_15_1:getAdvanceId()
			end)
		elseif arg_13_1 == var_0_3.BAG_TYPE.UNITE_TOKEN then
			var_13_0 = self._formationData:getAllUniteTokenList()

			table.sort(var_13_0, function(arg_16_0, arg_16_1)
				local var_16_0 = arg_16_0:getQuality()
				local var_16_1 = arg_16_1:getQuality()

				if var_16_0 ~= var_16_1 then
					return var_16_1 < var_16_0
				end

				local var_16_2 = arg_16_0:getStarLevel()
				local var_16_3 = arg_16_1:getStarLevel()

				if var_16_2 ~= var_16_3 then
					return var_16_3 < var_16_2
				end

				return arg_16_0:getAdvanceId() > arg_16_1:getAdvanceId()
			end)
		elseif arg_13_1 == var_0_3.BAG_TYPE.PET then
			var_13_0 = self._formationData:getAllPetList()

			table.sort(var_13_0, function(arg_17_0, arg_17_1)
				local var_17_0 = arg_17_0:getQuality()
				local var_17_1 = arg_17_1:getQuality()

				if var_17_0 ~= var_17_1 then
					return var_17_1 < var_17_0
				end

				local var_17_2 = arg_17_0:getStarNum()
				local var_17_3 = arg_17_1:getStarNum()

				if var_17_2 ~= var_17_3 then
					return var_17_3 < var_17_2
				end

				return arg_17_0:getAdvanceId() > arg_17_1:getAdvanceId()
			end)
		end

		self._listDict[arg_13_1] = var_13_0
	end

	return self._listDict[arg_13_1]
end

function ExplorationBagMainLayer:_onClickRecoveryBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.exploration.view.formation.ExplorationFormationRecyclePop").new(), {
		ignoreTouch = false,
		touchDisappear = false
	})
	self:updateRedPoint()
end

function ExplorationBagMainLayer:onUnload()
	for iter_19_0, iter_19_1 in ipairs((self._formationData:getWithinKnightList())) do
		var_0_4:saveWithInKnightStatus((iter_19_1:getAdvanceId()))
	end
end

return ExplorationBagMainLayer
