local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.CampaignConst
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.common.Path
local var_0_4 = g.core.common.ServerTime
local var_0_5 = g.core.module.ModuleManager
local var_0_7 = g.core.model.User.CampaignData
local CampaignCell = class("CampaignCell", require("app.fairyGUI.campaign.UI_CampaignCell"))

function CampaignCell:ctor()
	self._entranceStruct = nil

	self.getSharedTrans(self, "listCardAUiLeftIn", "CombineBagList", self)
	self:addClickListener(handler(self, self._onClick))
end

function CampaignCell:updateInfo(arg_2_1)
	local var_2_0 = g.core.event.EventManager

	g.core.event.EventManager:removeListenerWithTarget(self)

	if arg_2_1.functionId == var_0_0.FUNCTION_TYPE.TEAM_BATTLE then
		var_2_0:addEventListener(g.core.event.enum.EVENT_NET_S2C_TEAM_BATTLE_TEAMINFO, handler(self, self._checkTeamBattleHasTeam), self)
	end

	self._entranceStruct = arg_2_1

	self.m_image:setURL((var_0_3:getEntrancePicById(arg_2_1.info.pic)))
	self.m_image:setGrayed(not arg_2_1.unlocked)
	self.m_title:setText(arg_2_1.info.name)
	self.m_englishTitle:setText(arg_2_1.info.english_name)

	if arg_2_1.unlocked then
		self.m_resIcon:setIcon((var_0_3:getOutPutIconById(arg_2_1.info.output_pic)))
		self.m_resComp:setTitle(arg_2_1.info.output_des)
		self.m_isLockController:setSelectedIndex(1)
	else
		self.m_unLockText:setText(g.core.lang:get(100528))
		self.m_isLockController:setSelectedIndex(0)
	end

	if arg_2_1.limitTime then
		self.m_speTxt:setText((arg_2_1:getLimitTimeTipStr()))
		self:updateCDTxt()
		self.m_limitedTimeController:setSelectedIndex(1)
	elseif arg_2_1:isOpenLimitTimeMode() then
		self.m_speTxt:setText((arg_2_1:getLimitTimeTipStr()))
		self:updateCDTxt()
		self.m_limitedTimeController:setSelectedIndex(1)
	else
		self.m_speTxt:setText("")
		self.m_limitedTimeController:setSelectedIndex(0)
	end

	if var_0_1.RED_POINT_ID[arg_2_1.functionId] then
		self.m_redPointComp:setId(var_0_1.RED_POINT_ID[arg_2_1.functionId])
		var_2_0:dispatchEvent(var_0_2.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp
		})
	end
end

function CampaignCell:updateCDTxt()
	local var_3_0 = ""

	if self._entranceStruct then
		if self._entranceStruct.limitTime then
			local var_3_1, var_3_2, var_3_3, var_3_4 = var_0_4:getLeftTimeParts((self._entranceStruct:getCDEndTimeStamp()))

			var_3_0 = g.core.lang:get(100537, {
				day = var_3_1,
				hour = var_3_2,
				minute = var_3_3,
				second = var_3_4
			})
		elseif self._entranceStruct:isOpenLimitTimeMode() then
			local var_3_5, var_3_6, var_3_7, var_3_8 = var_0_4:getLeftTimeParts((self._entranceStruct:getCDEndTimeStamp()))

			var_3_0 = g.core.lang:get(100537, {
				day = var_3_5,
				hour = var_3_6,
				minute = var_3_7,
				second = var_3_8
			})
		end
	end

	self.m_openCDTxt:setText(var_3_0)
end

function CampaignCell:_onClick()
	if not self._entranceStruct then
		return
	end

	if self._entranceStruct.unlocked then
		if var_0_7:isFuncHasEnter(self._entranceStruct.functionId) then
			self:_goToModule(nil, true)
		else
			local var_4_0 = self._entranceStruct.info.video

			if self._entranceStruct.info.video == "" then
				self:_goToModule(nil, true)
			else
				self:_openMoviePop(var_4_0)
			end

			var_0_7:saveFuncFirstEnter(self._entranceStruct.functionId)
		end
	elseif self._entranceStruct.functionId == var_0_0.FUNCTION_TYPE.GUILD_WAR then
		local var_4_1, var_4_2 = g.core.model.User.guildWarData:isOpen()

		var_0_5:tip(var_4_2)
	else
		var_0_5:tip(g.core.config.function_info.get(self._entranceStruct.functionId).lock_direction)
	end

	if self._entranceStruct.functionId == var_0_0.FUNCTION_TYPE.GVE and g.core.model.User.gveDataMgr:isInSignUpStage() then
		g.core.sound.SoundManager:playSound(var_0_1.SOUND_NAME[self._entranceStruct.functionId])
	end
end

function CampaignCell:_goToModule(arg_5_1, arg_5_2)
	if arg_5_2 then
		if self._entranceStruct.functionId == var_0_0.FUNCTION_TYPE.TOWER then
			if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.TOWER_HARD) then
				var_0_5:pushModule(g.view.entrance.TOWER_CHOOSE)
			else
				var_0_5:pushModule(g.view.entrance.TOWER, {
					towerType = g.core.const.ConstMgr.TowerConst.TOWER_DIFFICULTY.NORMAL
				})
			end
		elseif self._entranceStruct.functionId == var_0_0.FUNCTION_TYPE.WUSH_TRIAL then
			if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.WUSH_TOWER) then
				var_0_5:pushModule(g.view.entrance.WUSH_TOWER_CHOOSE)
			else
				var_0_5:pushModule(g.view.entrance.WUSH)
			end
		elseif self._entranceStruct.functionId == var_0_0.FUNCTION_TYPE.TEAM_BATTLE then
			g.core.network.GameNetProxy:send_C2S_TeamBattle_TeamInfo({})
		else
			self:_goTo()
		end
	elseif self._entranceStruct.functionId == var_0_0.FUNCTION_TYPE.ARENA and arg_5_1 then
		var_0_5:pushModule(g.view.entrance.ARENA_FIRST)
	else
		self:_goTo()
	end
end

function CampaignCell:_goTo()
	if self._entranceStruct.info.route_id <= 0 then
		return
	end

	local var_6_0 = g.view.entrance.ModuleGotoProxy
	local var_6_1, var_6_2 = g.view.entrance.ModuleGotoProxy:getModule(self._entranceStruct.info.route_id)

	if not var_0_5:isCurModule(var_6_1) then
		var_6_0:gotoModule(self._entranceStruct.info.route_id, false)
	end
end

function CampaignCell:_openMoviePop(arg_7_1)
	var_0_5:pushPopup(require("app.view.module.campaign.view.CampaignMoviePop").new({
		movieInfo = {
			moduleName = "campaign",
			movieName = arg_7_1
		},
		functionId = self._entranceStruct.functionId,
		callBack = handler(self, self._goToModule)
	}), {
		withoutAni = true,
		blackOpacity = 0
	})
end

function CampaignCell:_checkTeamBattleHasTeam()
	if g.core.model.User.teamBattleData:getCurStage() == g.core.const.ConstMgr.TeamBattleConst.ACTIVITY_STATE.OPEN then
		if g.core.model.User.teamBattleData:getTeamUpData():getMyTeam() then
			if #g.core.model.User.teamBattleData:getFormationData():getAllKnightList() > 0 then
				var_0_5:pushModule(g.view.entrance.TEAM_BATTLE_MAP_LAYER)

				return
			end
		end
	end

	self:_goTo()
end

return CampaignCell
