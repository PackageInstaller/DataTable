local var_0_1 = g.core.module.ModuleManager
local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local var_0_3 = g.core.model.User.knightsData
local var_0_4 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_5 = g.core.model.User.artifactData
local ArtifactRightComp = require("app.view.module.artifact.view.comp.ArtifactRightComp")
local ArtifactSelectComp = require("app.view.module.artifact.view.comp.ArtifactSelectComp")
local var_0_8 = g.core.event
local var_0_9 = g.core.const.ConstMgr.BaseShowTypeConst
local var_0_10 = 244
local ArtifactLineUpLayer = class("ArtifactLineUpLayer", require("app.fairyGUI.artifact.UI_ArtifactLineUpLayer"), function()
	return fgui.GComponent:create({
		resName = "ArtifactLineUpLayer",
		pkgPath = "ui/artifact/artifact",
		isFullScreen = true,
		pkgName = "artifact"
	}, ...)
end)

function ArtifactLineUpLayer:ctor(arg_2_1)
	self:addBg("bg/common/pic_yht_beijing.jpg")

	if arg_2_1 and arg_2_1.route then
		arg_2_1.tabType = arg_2_1.route1

		if arg_2_1.route2 and arg_2_1.route2 <= 6 then
			arg_2_1.knightIndex = arg_2_1.route2
		end
	end

	self._knight = nil
	self._knightId = nil
	self._formations = nil
	self._rightDevelopComp = nil
	self._rightSelectComp = nil

	if arg_2_1 then
		self._tabType = arg_2_1.tabType or ArtifactConst.DEV_TYPE.INFO
	end

	self:_initData(arg_2_1)
	self:_initView()
end

function ArtifactLineUpLayer:_initData(arg_3_1)
	if not arg_3_1 then
		return
	end

	local var_3_0 = arg_3_1.knightIndex or 1

	self._knightIndex = var_3_0
	self._selectedIndex = var_3_0 - 1

	local var_3_1 = var_0_3:getKnightByFormationIndex(var_3_0)

	self._knight = var_3_1
	self._knightId = var_3_1:getServerId()
	self._formations = var_0_3:getFormationKnights()
end

function ArtifactLineUpLayer:_initView()
	self.m_lineUpList:setVirtual()
	self.m_lineUpList:doFairyBatching(false)
	self.m_lineUpList:setItemRenderer(handler(self, self._onLineUpItemRenderer))
	self.m_lineUpList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._lineUpListClickItem))
	self.m_artifactShowComp:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_topBarComp:setResInfoById(51)
end

function ArtifactLineUpLayer:onLoad(arg_5_1)
	var_0_8.EventManager:addEventListener(var_0_8.enum.EVENT_NET_S2C_ARTIFACT_LEVELUP, handler(self, self._onRecUpLevelSuccess), self)
	var_0_8.EventManager:addEventListener(var_0_8.enum.EVENT_NET_S2C_ARTIFACT_STAR, handler(self, self._onRecUpStarSuccess), self)
	var_0_8.EventManager:addEventListener(var_0_8.enum.EVENT_NET_S2C_ARTIFACT_SPIRITLEVELUP, handler(self, self._onRecSpiritUpLevelSuccess), self)
	var_0_8.EventManager:addEventListener(var_0_8.enum.EVENT_NET_S2C_ARTIFACT_SPIRITSTAGEUP, handler(self, self._onRecSpiritStageUpSuccess), self)
	var_0_8.EventManager:addEventListener(var_0_8.enum.EVENT_NET_S2C_FORMATION_CHANGEFORMATION, handler(self, self._recvChangeFormation), self)
	var_0_8.EventManager:addEventListener(var_0_8.enum.EVENT_NET_S2C_ARTIFACT_INHERITFORMATION, handler(self, self._recvInherit), self)
	self:_updateView()
end

function ArtifactLineUpLayer:_updateView()
	self:_updateArtifactShow()
	self:_showRightComp()
	self:_updateLineUpListView()
end

function ArtifactLineUpLayer:_updateArtifactShow()
	self._artifactStruct = var_0_5:getArtifactByPos(self._knightIndex)
	self._maxArtifactLevel = 0

	if self._artifactStruct then
		self._maxArtifactLevel = self._artifactStruct:getMaxLevel()

		self.m_isEmptyController:setSelectedIndex(0)
		self.m_artifactShowComp:updateShowView(self._artifactStruct, true)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function ArtifactLineUpLayer:_updateLineUpListView()
	self.m_lineUpList:setNumItems((var_0_3:getLineupKnightCount()))
	self.m_lineUpList:setSelectedIndex(self._selectedIndex)
	self.m_lineUpList:transitionShowCells("enter", 0.06)
end

function ArtifactLineUpLayer:_lineUpListClickItem(arg_9_1)
	local var_9_0 = self.m_lineUpList:getSelectedIndex()

	if var_9_0 == self._selectedIndex then
		return
	end

	self._selectedIndex = var_9_0
	self._knight = var_0_3:getKnightById(self._formations[var_9_0 + 1])
	self._knightIndex = self._knight:getFormationPos()

	self:_updateArtifactShow()
	self:_showRightComp()
end

function ArtifactLineUpLayer:_onLineUpItemRenderer(arg_10_1, arg_10_2)
	arg_10_2:updateCell(self._formations[arg_10_1 + 1], var_0_4["KNIGHT_LINE_UP_" .. arg_10_1 + 1], arg_10_1 + 1, var_0_10)
end

function ArtifactLineUpLayer:_showRightComp(arg_11_1)
	self.m_showRightTypeController:setSelectedIndex(self._artifactStruct and 0 or 1)

	if self._artifactStruct then
		if not self._rightDevelopComp then
			self._rightDevelopComp = ArtifactRightComp.new()

			self._rightDevelopComp:initData(self._tabType)
			self.m_ArtifactDevelopHolder:addChild(self._rightDevelopComp)
		end

		self._rightDevelopComp:updateDevPanel({
			isLineUpModel = true,
			data = self._artifactStruct,
			pos = self._knightIndex,
			noAnimation = arg_11_1
		})
	else
		self:_showRightSelectComp()
	end
end

function ArtifactLineUpLayer:_recvChangeFormation(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_4.tp == 5 then
		self:_updateArtifactShow()
		self:_showRightComp(true)
	end
end

function ArtifactLineUpLayer:_recvInherit(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_4 and arg_13_4.ret == 1 then
		self:_updateView()
		g.core.module.ModuleManager:tip(g.core.lang:get(200013))

		if arg_13_4.award then
			g.core.module.ModuleManager:awardSummary(arg_13_4.award, false, nil, g.core.lang:get(200014))
		end
	end
end

function ArtifactLineUpLayer:_onRecUpLevelSuccess(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self:_updateArtifactShow()
	self:_showRightComp(true)

	if arg_14_4 then
		if (arg_14_4.tg_lv or 0) < (self._maxArtifactLevel or 0) then
			self._rightDevelopComp:showStarEffect()
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = var_0_9.ARTIFACT_LEVEL_UP
		}
	})

	if self._artifactStruct:isActiveTalentInfo() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
			baseShowPop = {
				type = var_0_9.ARTIFACT_STRENGTH_TALENT_ACTIVE
			}
		})
	end
end

function ArtifactLineUpLayer:_onRecUpStarSuccess(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	self:_updateArtifactShow()
	self:_showRightComp(true)

	local var_15_0 = self._artifactStruct

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		frontShow = {
			{
				flag = "ArtifactStarUp",
				func = function()
					return var_0_1:pushPopup((require("app.view.module.artifact.view.ArtifactStarUpSuccessPop").new(var_15_0, arg_15_4.awards)))
				end
			}
		}
	})
end

function ArtifactLineUpLayer:_onRecSpiritUpLevelSuccess(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	self:_updateArtifactShow()
	self:_showRightComp(true)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = var_0_9.ARTIFACT_SPIRIT_LEVEL_UP
		}
	})
end

function ArtifactLineUpLayer:_onRecSpiritStageUpSuccess(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	self:_updateArtifactShow()
	self:_showRightComp(true)
	var_0_1:pushPopup((require("app.view.module.artifact.view.ArtifactSpiritStageUpPop").new({
		artifact = self._artifactStruct
	})))
end

function ArtifactLineUpLayer:receiveCompEvent(arg_19_1, arg_19_2)
	if arg_19_1 == "event_open_artifact_select_comp" then
		self.m_showRightTypeController:setSelectedIndex(1)
		self:_showRightSelectComp()
	elseif arg_19_1 == "Event_refresh_top_bar" then
		self:_updateTopBar(arg_19_2)
	elseif arg_19_1 == "Event_refresh_top_bar_res" then
		self:_updateTopBarRes(arg_19_2)
	end
end

function ArtifactLineUpLayer:_updateTopBarRes(arg_20_1)
	self.m_topBarComp:updateTopRes(arg_20_1)

	if arg_20_1 and arg_20_1.helpId then
		self.m_topBarComp:setHelpId(arg_20_1.helpId)
	end
end

function ArtifactLineUpLayer:_showRightSelectComp()
	if not self._rightSelectComp then
		self._rightSelectComp = ArtifactSelectComp.new()

		self._rightSelectComp:getView():setHeight(display.height)
		self.m_ArtifactSelectHolder:addChild(self._rightSelectComp)
	end

	self._rightSelectComp:updateView({
		pos = self._knightIndex
	})
end

function ArtifactLineUpLayer:_onTouchEnd(arg_22_1)
	arg_22_1:stopPropagation()

	if self.m_showRightTypeController:getSelectedIndex() == 1 and self._artifactStruct then
		self:_showRightComp()
	end
end

function ArtifactLineUpLayer:_updateTopBar(arg_23_1)
	self.m_topBarComp:setResInfoById(arg_23_1)
end

return ArtifactLineUpLayer
