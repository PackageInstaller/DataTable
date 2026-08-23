local var_0_0 = g.core.model.User
local var_0_1 = g.core.module.ModuleManager
local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local ArtifactRightComp = require("app.view.module.artifact.view.comp.ArtifactRightComp")
local var_0_4 = g.core.const.ConstMgr.BaseShowTypeConst
local var_0_5 = 200
local ArtifactDevelopLayer = class("ArtifactDevelopLayer", require("app.fairyGUI.artifact.UI_ArtifactDevelopLayer"), function()
	return fgui.GComponent:create({
		resName = "ArtifactDevelopLayer",
		pkgPath = "ui/artifact/artifact",
		isFullScreen = true,
		pkgName = "artifact"
	}, ...)
end)

function ArtifactDevelopLayer:ctor(arg_2_1)
	self:addBg("bg/common/pic_yht_beijing.jpg")

	if arg_2_1 and arg_2_1.route then
		arg_2_1.tabType = arg_2_1.route1
	end

	self._isSwitching = false
	self._isShowFullArtifact = false

	if arg_2_1 then
		self._tabType = arg_2_1.tabType or ArtifactConst.DEV_TYPE.INFO
	end

	if arg_2_1 then
		self._artifactId = arg_2_1.artifactId or 0
	end

	if arg_2_1 then
		self._artifactStruct = arg_2_1.artifact or nil
	end

	if arg_2_1.position and arg_2_1.position > 0 then
		self._artifactStruct = var_0_0.artifactData:getArtifactByFormationIndex(arg_2_1.position)
	end

	if not self._artifactStruct and self._artifactId > 0 then
		self._artifactStruct = var_0_0.artifactData:getArtifactByBaseId(self._artifactId)
	end

	self.m_rightPanelHolder:setVisible(true)
	self.m_touchComp:setVisible(false)
	self.m_touchComp:addClickListener(handler(self, self._onFullScreenClick))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self:_init()
end

function ArtifactDevelopLayer:_init()
	if not self._artifactStruct then
		return
	end

	self.m_showBtn:addClickListener(handler(self, self._onShowArtifact))
	self.m_leftBtn:addClickListener(handler(self, self._onLeftClick))
	self.m_rightBtn:addClickListener(handler(self, self._onRightClick))
	self.m_handBookBtn:addClickListener(handler(self, self._onHandBookClick))

	if not self.m_rightPanel then
		self.m_rightPanel = ArtifactRightComp.new()

		self.m_rightPanel:initData(self._tabType)
		self.m_rightPanelHolder:addChild(self.m_rightPanel)
	end

	self:addListen(self.m_rightPanel)
end

function ArtifactDevelopLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_LEVELUP, handler(self, self._onRecUpLevelSuccess), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_STAR, handler(self, self._onRecUpStarSuccess), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_SPIRITLEVELUP, handler(self, self._onRecSpiritUpLevelSuccess), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARTIFACT_SPIRITSTAGEUP, handler(self, self._onRecSpiritStageUpSuccess), self)

	self._ownArtifactList = var_0_0.artifactData:getOwnArtifactList()
	self._maxIndex = #self._ownArtifactList
	self._artifactItemIndex = var_0_0.artifactData:getItemIndexAtOwnList(self._artifactStruct:getServerOnlyId())

	self.m_isShowArrowController:setSelectedIndex(self._maxIndex > 1 and 1 or 0)

	self._maxArtifactLevel = self._artifactStruct:getMaxLevel()

	self:_updateDevCompContent()

	if self.m_enterTransition then
		self.m_enterTransition:play()
	end
end

function ArtifactDevelopLayer:_updateTopBar(arg_5_1)
	self.m_topBarComp:setResInfoById(arg_5_1)
end

function ArtifactDevelopLayer:_updateTopBarRes(arg_6_1)
	self.m_topBarComp:updateTopRes(arg_6_1)

	if arg_6_1 and arg_6_1.helpId then
		self.m_topBarComp:setHelpId(arg_6_1.helpId)
	end
end

function ArtifactDevelopLayer:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "Event_refresh_top_bar" then
		self:_updateTopBar(arg_7_2)
	elseif arg_7_1 == "Event_refresh_top_bar_res" then
		self:_updateTopBarRes(arg_7_2)
	end
end

function ArtifactDevelopLayer:_updateDevCompContent(arg_8_1)
	self.m_artifactShowComp:updateShowView(self._artifactStruct)
	self.m_rightPanel:updateDevPanel({
		initTabType = self._tabType,
		data = self._artifactStruct,
		noAnimation = arg_8_1
	})
end

function ArtifactDevelopLayer:_onRecUpLevelSuccess(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self:_updateDevCompContent(true)

	if arg_9_4 then
		if (arg_9_4.tg_lv or 0) < (self._maxArtifactLevel or 0) then
			self.m_rightPanel:showStarEffect()
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = var_0_4.ARTIFACT_LEVEL_UP
		}
	})

	if self._artifactStruct:isActiveTalentInfo() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
			baseShowPop = {
				type = var_0_4.ARTIFACT_STRENGTH_TALENT_ACTIVE
			}
		})
	end
end

function ArtifactDevelopLayer:_onRecUpStarSuccess(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self:_updateDevCompContent(true)

	local var_10_0 = self._artifactStruct

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_POP_SHOW, false, {
		showNow = true,
		frontShow = {
			{
				flag = "ArtifactStarUp",
				func = function()
					return var_0_1:pushPopup((require("app.view.module.artifact.view.ArtifactStarUpSuccessPop").new(var_10_0, arg_10_4.awards)))
				end
			}
		}
	})
end

function ArtifactDevelopLayer:_onRecSpiritUpLevelSuccess(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self:_updateDevCompContent(true)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
		baseShowPop = {
			type = var_0_4.ARTIFACT_SPIRIT_LEVEL_UP
		}
	})
end

function ArtifactDevelopLayer:_onRecSpiritStageUpSuccess(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	self:_updateDevCompContent(true)
	var_0_1:pushPopup((require("app.view.module.artifact.view.ArtifactSpiritStageUpPop").new({
		artifact = self._artifactStruct
	})))
end

function ArtifactDevelopLayer:_onLeftClick()
	if self._artifactItemIndex - 1 <= 0 then
		self._artifactItemIndex = self._maxIndex
	end

	self._artifactStruct = self._ownArtifactList[self._artifactItemIndex]

	self:_updateDevCompContent()

	if not self._isSwitching then
		-- block empty
	end
end

function ArtifactDevelopLayer:_onRightClick()
	if self._artifactItemIndex + 1 > self._maxIndex then
		self._artifactItemIndex = 1
	end

	self._artifactStruct = self._ownArtifactList[self._artifactItemIndex]

	self:_updateDevCompContent()

	if not self._isSwitching then
		-- block empty
	end
end

function ArtifactDevelopLayer:_onHandBookClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_HANDBOOK) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ARTIFACT_HANDBOOK, {
			quality = self._artifactStruct:getQuality()
		})
	end
end

function ArtifactDevelopLayer:_onFullScreenClick()
	if self._isShowFullArtifact and self.m_showTransition then
		self._isShowFullArtifact = false

		self.m_rightPanelHolder:setVisible(true)
		self.m_showTransition:play(handler(self, function(arg_18_0)
			arg_18_0.m_touchComp:setVisible(false)
		end))
	end
end

function ArtifactDevelopLayer:_onShowArtifact()
	if not self._isShowFullArtifact and self.m_hideTransition then
		self.m_touchComp:setVisible(true)
		self.m_rightPanelHolder:setVisible(false)
		self.m_hideTransition:play(handler(self, function(arg_20_0)
			arg_20_0._isShowFullArtifact = true
		end))
	end
end

function ArtifactDevelopLayer:_onTouchBegin(arg_21_1)
	self._isCanSwitch = false

	local var_21_0 = arg_21_1:getInput():getTouch()

	if self._maxIndex > 1 and self.m_artifactShowComp:containPoint(var_21_0:getLocationInView()) then
		arg_21_1:captureTouch()

		self._startPosX = var_21_0:getLocationInView().x
		self._isCanSwitch = true
	end
end

function ArtifactDevelopLayer:_onTouchEnd(arg_22_1)
	if self._isCanSwitch then
		local var_22_0 = arg_22_1:getInput():getPosition()
		local var_22_1 = var_22_0.x - (self._startPosX or var_22_0.x)

		if var_22_1 > var_0_5 then
			self:_onLeftClick()
		elseif var_22_1 < -var_0_5 then
			self:_onRightClick()
		end
	end
end

return ArtifactDevelopLayer
