local var_0_0 = g.core.model.User.teamPvpData
local var_0_1 = g.core.const.ConstMgr.TeamPvpConst
local TeamPVPResultPop = class("TeamPVPResultPop", require("app.fairyGUI.teamPVP.UI_TeamPVPResultPop"), function()
	return fgui.GComponent:create({
		resName = "TeamPVPResultPop",
		pkgPath = "ui/teamPVP/teamPVP",
		pkgName = "teamPVP"
	}, ...)
end)

function TeamPVPResultPop:ctor()
	self:showAtCenter()
	self:_createBlurBg()

	self._isClosePop = false

	self:addClickListener(handler(self, self._onExit))

	self._report = var_0_0:getBattleReport()
	self._redInfos = {}
	self._blueInfos = {}
	self._redIsWin = var_0_0:isBattleWin()

	local var_2_0 = var_0_0:getTeamInfo()
	local var_2_1 = var_0_1.REQUIRED_PLAYER_NUM

	if var_0_0:getMapId() == var_0_1.MAP_TYPE.SEA then
		var_2_1 = var_0_1.SPECIAL_PLAYER_NUM
	elseif var_0_0:getMapId() == var_0_1.MAP_TYPE.FIVE then
		var_2_1 = var_0_1.MASTER_PLAYER_NUM
	end

	if var_2_0 and var_2_0.id == self._report.atk_room_id then
		for iter_2_0 = 1, var_2_1 do
			if self._report.atk_user[iter_2_0].npc_type == 0 then
				table.insert(self._redInfos, {
					snapshot = self._report.atk_user_show[iter_2_0],
					battleUser = self._report.atk_user[iter_2_0],
					mvpId = self._report.mvp_guid
				})
			end

			if self._report.def_user[iter_2_0].npc_type == 0 then
				table.insert(self._blueInfos, {
					snapshot = self._report.def_user_show[iter_2_0],
					battleUser = self._report.def_user[iter_2_0],
					mvpId = self._report.mvp_guid
				})
			end
		end
	else
		for iter_2_1 = 1, var_2_1 do
			if self._report.atk_user[iter_2_1].npc_type == 0 then
				table.insert(self._blueInfos, {
					snapshot = self._report.atk_user_show[iter_2_1],
					battleUser = self._report.atk_user[iter_2_1],
					mvpId = self._report.mvp_guid
				})
			end

			if self._report.def_user[iter_2_1].npc_type == 0 then
				table.insert(self._redInfos, {
					snapshot = self._report.def_user_show[iter_2_1],
					battleUser = self._report.def_user[iter_2_1],
					mvpId = self._report.mvp_guid
				})
			end
		end
	end

	self:_updateKillNumDict()
	self:_updateView()
	self:_playTxtEffect()
end

function TeamPVPResultPop:_updateView()
	for iter_3_0 = 1, var_0_1.REQUIRED_PLAYER_NUM do
		self["m_redComp" .. iter_3_0]:updateResultComp(self._redInfos[iter_3_0], self._killNumDict)
		self["m_blueComp" .. iter_3_0]:updateResultComp(self._blueInfos[iter_3_0], self._killNumDict)
	end

	self.m_redResult:setCtrlState("result", {
		index = self._redIsWin and 0 or 1
	})
	self.m_blueResult:setCtrlState("result", {
		index = self._redIsWin and 1 or 0
	})
end

function TeamPVPResultPop:_updateKillNumDict()
	self._killNumDict = {}

	for iter_4_0, iter_4_1 in ipairs(self._report.user_kill_num) do
		self._killNumDict[iter_4_1.guid] = iter_4_1.kill_num
	end
end

function TeamPVPResultPop:_playEnterEffect()
	self.m_enterTransition:play()
	self.m_enterEffect:addEffectSpine({
		anim = "play",
		name = "eff_ui_teamPvp_VS",
		isLoop = false
	})
end

function TeamPVPResultPop:_playTxtEffect()
	(self._redIsWin and self.m_redResult:getChild("winBtnEff") or self.m_blueResult:getChild("winBtnEff")):addEffectSpine({
		anim = "btn",
		name = "eff_ui_teamPvp_VSBtn",
		isLoop = true
	})
end

function TeamPVPResultPop:_onExit()
	self._isClosePop = true

	local var_7_0 = {
		resName = "BattleResultTeamPvpLayer",
		pkgPath = "ui/battleResult/battleResult",
		isFullScreen = true,
		pkgName = "battleResult"
	}
	local var_7_1 = g.core.model.User.teamPvpData:isBattleWin()
	local var_7_2 = var_7_1 and {
		0
	} or {
		1
	}
	local var_7_3 = {
		pages = var_7_2,
		selfResult = g.core.model.User.teamPvpData:getBattleReport(),
		isWin = var_7_1
	}

	g.core.module.ModuleManager:popAllPopupAndPush({
		modType = g.view.entrance.POPUP,
		params = {
			withoutAni = true
		},
		create = function()
			return require("app.view.module.battleResult.view.BattleResultLayer").new(var_7_0, var_7_3)
		end
	})
end

function TeamPVPResultPop:onLoad()
	self:_playEnterEffect()
end

function TeamPVPResultPop:onUnload()
	self.m_backTransition:play()

	if not self._isClosePop then
		self:_onExit()
	end
end

function TeamPVPResultPop:_createBlurBg()
	local var_11_0 = fgui.UIPackage:createObject("teamPVP", "TeamPVPBgBlurComp", self)
	local var_11_1 = var_11_0:getChild("bgLoader")
	local var_11_2 = var_11_1:getSize()

	var_11_1:setURL(g.core.common.Path:getTeamPVPTeamBg(var_0_0:getMapId()))

	local var_11_3 = cc.GLProgramState:create((g.core.shader.ShaderMgr:getShader("SHADER_GAUSSIAN_BLUR")))

	var_11_3:setUniformVec2("resolution", cc.p(var_11_2.width, var_11_2.height))
	var_11_3:setUniformFloat("blurRadius", (g.core.utils.Quality.getGaussianBlurParam()))
	var_11_3:setUniformFloat("sampleNum", 3)
	var_11_1:setOpenGlState(var_11_3)
	self.m_holdComp:addChild(var_11_0)
end

return TeamPVPResultPop
