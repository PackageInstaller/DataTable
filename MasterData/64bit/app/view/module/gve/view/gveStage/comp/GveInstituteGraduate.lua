local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.gveDataMgr
local var_0_2 = g.core.model.User.gveDataMgr:getGveInstituteData()
local var_0_3 = g.core.const.ConstMgr.SpineConst
local var_0_4 = g.core.model.User.knightsData
local var_0_5 = 5
local var_0_6 = {
	ZERO_POINT_REFRESH = 1
}
local GveInstituteGraduate = class("GveInstituteGraduate", require("app.fairyGUI.gve.UI_GveInstituteGraduate"))

function GveInstituteGraduate:ctor()
	var_0_2 = var_0_1:getGveInstituteData()
	self._curMissionKnights = {}
	self._curUpKnightPos = -1
	self._curServerKnightId = 0

	self.m_uploadBtn:addClickListener(handler(self, self._onClickUpload))
	self.m_detailBtn:addClickListener(handler(self, self._onClickDetail))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRank))
	self.m_detailAllBtn:addClickListener(handler(self, self._onClickDetailAll))
	self.m_knightList:setVirtual()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightRenderer))
	self.m_knightList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onKnightLineUpClick))
end

function GveInstituteGraduate:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_RESEARCHMISSION, self._onUpLoadKnightChange, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_RESEARCHAWARD, self._onResearchReward, self)
	self:checkTipsGuide()
end

function GveInstituteGraduate:playEnterAnim()
	self.m_enterTransition:play()
	self.m_effLine:addEffectSpine({
		remove = true,
		isLoop = false,
		name = "eff_ui_gveII_line"
	})

	self._hudEff = self._hudEff or self.m_effHud:addEffectSpine({
		isLoop = true,
		anim = "play3",
		name = "eff_ui_gveII_hud"
	})
end

function GveInstituteGraduate:updateGveCompObj(arg_4_1)
	arg_4_1 = arg_4_1 or self._struct
	self._struct = arg_4_1

	self.m_progress:setProgress(arg_4_1:getProgressValue(), arg_4_1:getUpLvValue())

	local var_4_0 = self._struct:getLevel()

	self.m_lvTxt:setText(g.core.lang:get(120) .. var_4_0)

	if var_4_0 == 0 then
		self.m_lockedController:setSelectedIndex(1)
		self.m_nameTxt:setText(self._struct:getResearchName() .. g.core.lang:get(309177))
	else
		self.m_lockedController:setSelectedIndex(0)
		self.m_nameTxt:setText(self._struct:getResearchName())
	end

	local var_4_1 = arg_4_1:getGainResearchPoint()

	if var_4_1 ~= 0 then
		self:showAddPointPop(var_4_1)
	end

	self:checkAndShowAllKnights()
	self:onCD(0)
end

function GveInstituteGraduate:_onKnightLineUpClick(arg_5_1)
	local var_5_0 = var_0_4:getKnightByAdvanceId(self._curMissionKnights[arg_5_1:getDataValue() + 1])

	self.m_knightList:setSelectedIndex(self._curUpKnightPos)

	if var_5_0:isOwn() and var_5_0:getServerId() ~= self._curServerKnightId then
		local var_5_1 = var_0_0:getTime()

		if not self._operaTime or var_5_1 - self._operaTime > var_0_5 then
			self._operaTime = var_5_1

			g.core.network.GameNetProxy:send_C2S_GVE_ResearchMission({
				knight_id = var_5_0:getServerId()
			})
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_PSXY_LongSelection)
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(309184))
		end
	elseif not var_5_0:isOwn() then
		g.core.module.ModuleManager:tip(g.core.lang:get(309183))
	end
end

function GveInstituteGraduate:_onUpLoadKnightChange(arg_6_1, arg_6_2, arg_6_3)
	self:updateGveCompObj()
	self:playKnightUpAnim()
end

function GveInstituteGraduate:_onResearchReward(arg_7_1, arg_7_2, arg_7_3)
	self:updateGveCompObj()
	self.m_progress:playAwardPoint()
end

function GveInstituteGraduate:showAddPointPop(arg_8_1)
	g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
		singleButton = true,
		title = g.core.lang:get(1257),
		desc = g.core.lang:get(309180, {
			num = arg_8_1
		})
	}):addEventListener(fgui.UIEventType.ExitFinish, handler(self, self.onRewardPopClose))
end

function GveInstituteGraduate:onRewardPopClose()
	self.m_effScreen:addEffectSpine({
		remove = true,
		anim = "play",
		isLoop = false,
		name = "eff_ui_gveII_get"
	})
	self.m_progress:playAwardPoint()
end

function GveInstituteGraduate:playKnightUpAnim()
	self._hudEff = self._hudEff or self.m_effHud:addEffectSpine({
		isLoop = true,
		anim = "play3",
		name = "eff_ui_gveII_hud"
	})

	self._hudEff:addSpineEventListener(handler(self, self._onUpKnightFinishAnim))
	self._hudEff:setAnimation(0, "play", false)

	self._screenEff = self._screenEff or self.m_effScreen:addEffectSpine({
		isLoop = true,
		anim = "play",
		name = "eff_ui_gveII_screen"
	})

	self._screenEff:addSpineEventListener(handler(self, self._onUpKnightFinishAnim2))
	self._screenEff:setAnimation(0, "play", false)
	self.m_selectTransition:play()

	local var_10_0 = self.m_knightList:getSelectedIndex()

	if var_10_0 >= 0 then
		local var_10_1 = self.m_knightList:getChildAt(var_10_0)

		if var_10_1 and var_10_1.playSelectEff then
			var_10_1:playSelectEff()
		end
	end
end

function GveInstituteGraduate:_onUpKnightFinishAnim(arg_11_1)
	if arg_11_1.type == var_0_3.SPINE_EVENT.COMPLETE then
		self._hudEff:addSpineEventListener(nil)
		self._hudEff:setAnimation(0, "play2", true)
	end
end

function GveInstituteGraduate:_onUpKnightFinishAnim2(arg_12_1)
	if arg_12_1.type == var_0_3.SPINE_EVENT.COMPLETE then
		self._screenEff:addSpineEventListener(nil)
		self._screenEff:setAnimation(0, "play2", true)
	end
end

function GveInstituteGraduate:checkAndShowAllKnights()
	if not self._struct then
		return
	end

	local var_13_0 = self._struct:getServerDataByName("mission_knights")

	self._curServerKnightId = self._struct:getServerDataByName("mission_knight_id") or 0
	self._curMissionKnights = var_13_0 or {}
	self._curUpKnightPos = -1

	for iter_13_0, iter_13_1 in ipairs(self._curMissionKnights) do
		local var_13_1 = var_0_4:getKnightByAdvanceId(iter_13_1):getServerId()

		if var_13_1 ~= 0 and var_13_1 == self._curServerKnightId then
			self._curUpKnightPos = iter_13_0 - 1

			break
		end
	end

	self.m_knightList:setNumItems(#self._curMissionKnights)
	self.m_knightList:setSelectedIndex(self._curUpKnightPos)

	if self._curServerKnightId and self._curServerKnightId ~= 0 then
		self.m_upKnightController:setSelectedIndex(1)

		local var_13_2 = var_0_4:getKnightById(self._curServerKnightId)
		local var_13_3 = var_13_2:getSkin()

		self.m_knightComp:setIcon(g.core.common.Path:getMiddleKnightPicById(var_13_3 ~= 0 and var_13_3 or var_13_2:getResInfo().id))
		self.m_speedTxt:setText(var_0_2:getKnightResearchSpeed(var_13_2:getAdvanceId(), var_13_2:getStarLv()))

		self._screenEff = self._screenEff or self.m_effScreen:addEffectSpine({
			isLoop = true,
			anim = "play2",
			name = "eff_ui_gveII_screen"
		})
	else
		self.m_upKnightController:setSelectedIndex(0)
	end
end

function GveInstituteGraduate:onCD(arg_14_1)
	if self._struct:getEventValue(2) == var_0_6.ZERO_POINT_REFRESH then
		self.m_timeTxt:setText((var_0_0:getAwardLeftTime(24, 0, 0)))
	end

	if self._curServerKnightId ~= 0 then
		local var_14_0 = var_0_4:getKnightById(self._curServerKnightId)

		if var_0_2:getCanRewardTime(var_14_0:getAdvanceId(), var_14_0:getStarLv()) <= var_0_0:getTime() - (self._struct:getServerDataByName("mission_start_time") or var_0_0:getTime()) then
			self.m_uploadBtn:setVisible(true)
		else
			self.m_uploadBtn:setVisible(false)
		end
	else
		self.m_uploadBtn:setVisible(false)
	end
end

function GveInstituteGraduate:updateGICompShow()
	self:updateGveCompObj()
end

function GveInstituteGraduate:_onClickUpload()
	g.core.network.GameNetProxy:send_C2S_GVE_ResearchAward({})
end

function GveInstituteGraduate:_onClickDetail()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.gve.view.gveStage.GveInstituteInfoPop").new(self._struct:getHelpId())))
end

function GveInstituteGraduate:_onClickDetailAll()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.gve.view.gveStage.GveInstituteAttrPop").new(self._struct)))
end

function GveInstituteGraduate:_onClickRank()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.gve.view.gveStage.GveInstituteRankPop").new()))
end

function GveInstituteGraduate:checkTipsGuide()
	self:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
			key = "GVE_RESEARCH_TASK",
			objects = {
				[2] = self.m_knightList,
				[3] = self.m_guideHelper
			}
		})
	end, 0)
end

function GveInstituteGraduate:_onKnightRenderer(arg_22_1, arg_22_2)
	arg_22_2:updateByKnightAdvId(self._curMissionKnights[arg_22_1 + 1])
end

return GveInstituteGraduate
