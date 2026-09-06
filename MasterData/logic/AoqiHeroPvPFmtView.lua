-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroPvPFmtView.lua

module("logic.extensions.aoqihero.view.AoqiHeroPvPFmtView", package.seeall)

local AoqiHeroPvPFmtView = class("AoqiHeroPvPFmtView", AoQiHeroFormationView)

function AoqiHeroPvPFmtView:ctor()
	AoqiHeroPvPFmtView.super.ctor(self)
end

function AoqiHeroPvPFmtView:unbindEvents()
	AoqiHeroPvPFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AoqiHeroPvPFmtView:bindEvents()
	AoqiHeroPvPFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function AoqiHeroPvPFmtView:buildUI()
	AoqiHeroPvPFmtView.super.buildUI(self)

	self._txtTime = self:getTxt("txtTime")
	self._btnClose = self:getGo("btnClose")
	self._txtName = self:getTxt("playerInfo/txtName")
	self._txtAreaName = self:getTxt("playerInfo/txtAreaName")
	self._txScore = self:getTxt("playerInfo/txScore")
	self._headIcon = self:getGo("playerInfo/headIcon")
	self._sliderTime = self:getSlider("timeSlider")
end

function AoqiHeroPvPFmtView:onExit()
	AoqiHeroPvPFmtView.super.onExit(self)
	removetimer(self._onClock, self)
	removetimer(self._updateTimeSlider, self)
	HeadItemController.instance:resetHeadCell(self._headIcon)
end

function AoqiHeroPvPFmtView:onEnter()
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroPvPFightStartRes, self._closeView, self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroPvPLeaveRoomRes, self._closeView, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._activityCfg = AoQiHeroConfig.instance:getActivityCfg(self._activityId)

	self:_initData()
	self:_genarateMap()
	self:_genarateEntity()
	self:_refreshPetView()

	self._totalTime = self:_onClock()

	settimer(1, self._onClock, self, true)
	settimer(0.02, self._updateTimeSlider, self, true)
end

function AoqiHeroPvPFmtView:_initData()
	local opponentInfo = AoQiHeroModel.instance:getPvPOpInfo()
	local teamCfg = AoQiHeroConfig.instance:getTeamCfg(self._activityId, opponentInfo.opDefCreepsMasterId)

	self._mapRow = teamCfg.row
	self._mapCol = teamCfg.col
	self._map = {}

	for i = 1, self._mapRow do
		self._map[i] = self._map[i] or {}

		for j = 1, self._mapCol do
			local gridId = (i - 1) * self._mapCol + j

			self._map[i][j] = teamCfg.map[gridId] == 0 and AoQiHeroConst.MapEmptyIndex or AoQiHeroConst.MapBlockIndex
		end
	end

	self._enemyDataList = {}

	local creepCfgs = AoQiHeroConfig.instance:getCreepsCfg(self._activityId, opponentInfo.opDefCreepsMasterId)

	for i, v in ipairs(creepCfgs) do
		local attrData = FightingPowerFormula.instance:parseAttrValues(v.extproperties)
		local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, v.raceId)
		local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, v.lv)

		if not v.isEnemy then
			local info = {
				energy = 0,
				pos = v.posId,
				hp = checknumber(attrData[GameEnum.AttrType.Hp]),
				energymax = petCfg.maxEnergy,
				size = petCfg.size,
				configId = v.raceId,
				isEnemy = v.isEnemy,
				skillId = propertyCfg.defenseNormalSkillId
			}

			table.insert(self._enemyDataList, info)
		end
	end

	for i, v in ipairs(opponentInfo.opDefItems) do
		local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, v.raceId)
		local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, v.level)
		local info = {
			isEnemy = true,
			energy = 0,
			pos = v.posId,
			hp = propertyCfg.defHp,
			energymax = petCfg.maxEnergy,
			size = petCfg.size,
			configId = v.raceId,
			skillId = propertyCfg.defenseNormalSkillId
		}

		table.insert(self._enemyDataList, info)
	end

	self._txtName.text = opponentInfo.opHeadInfo.userName
	self._txtAreaName.text = opponentInfo.opHeadInfo.areaName
	self._txScore.text = langPara("积分：%d", opponentInfo.opScore)

	HeadItemController.instance:setHeadCellByInfo(self._headIcon, opponentInfo.opHeadInfo)
end

function AoqiHeroPvPFmtView:_closeView()
	self:close()
	UIStateManager.instance:popByName(self._viewPresentor.viewName)
end

function AoqiHeroPvPFmtView:_updateTimeSlider()
	local startTime = AoQiHeroController.instance:getAutoStartPvPTime()

	if startTime > ServerTime.now() then
		local time = startTime - ServerTime.now()

		self._sliderTime:SetValue(time / self._activityCfg.pvpFormationTime)
	else
		self._sliderTime:SetValue(0)
	end
end

function AoqiHeroPvPFmtView:_onClickStart()
	local teamInfo = AoQiHeroModel.instance:getCurPetTeams(self._activityId)
	local raceIds = {}

	for i, v in ipairs(teamInfo) do
		if v.petId ~= 0 then
			table.insert(raceIds, v.petId)
		end
	end

	if #raceIds <= 0 then
		FloatWordMgr.instance:show(lang("未上阵精灵"))
	elseif #raceIds < AoQiHeroModel.instance:getUnlockNum(self._activityId) then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("仍有位置可以上阵精灵，确定要开始游戏吗？"), function()
			AoQiHeroController.instance:sendPM_AoQiHeroPvPFightStartReq(self._activityId, raceIds, ViewName.AoqiHeroPvPBtlView, ViewName.AoqiHeroPvPFmtView)
		end)
	else
		AoQiHeroController.instance:sendPM_AoQiHeroPvPFightStartReq(self._activityId, raceIds, ViewName.AoqiHeroPvPBtlView, ViewName.AoqiHeroPvPFmtView)
	end
end

function AoqiHeroPvPFmtView:_onClickTeam()
	local closeTime = AoQiHeroController.instance:getAutoStartPvPTime() - 2

	if closeTime < ServerTime.now() then
		FloatWordMgr.instance:show(lang("战斗即将开始,不可调整"))
	else
		UIStateManager.instance:push(ViewName.AoqiHeroStrengthenView, self._activityId, true)
	end
end

function AoqiHeroPvPFmtView:_onClock()
	local startTime = AoQiHeroController.instance:getAutoStartPvPTime()

	if startTime < ServerTime.now() then
		removetimer(self._onClock, self)

		local teamInfo = AoQiHeroModel.instance:getCurPetTeams(self._activityId)
		local raceIds = {}

		for i, v in ipairs(teamInfo) do
			if v.petId ~= 0 then
				table.insert(raceIds, v.petId)
			end
		end

		AoQiHeroController.instance:sendPM_AoQiHeroPvPFightStartReq(self._activityId, raceIds, ViewName.AoqiHeroPvPBtlView, ViewName.AoqiHeroPvPFmtView)
	else
		local showTime = checkint(startTime - ServerTime.now())

		self._txtTime.text = langPara("倒计时：%d", showTime)
	end
end

function AoqiHeroPvPFmtView:_onClickClose()
	TipsFacade.instance:openPopupWindow(lang("提示"), lang("确认退出吗，视为失败"), function()
		AoQiHeroAgent.instance:sendPM_AoQiHeroPvPLeaveRoomReq()
	end)
end

function AoqiHeroPvPFmtView:_onClickTips()
	local ruleCfgs = AoQiHeroConfig.instance:getImageRuleCfg(3)
	local list = {}

	for i, v in ipairs(ruleCfgs) do
		table.insert(list, {
			url = v.resName,
			desc = v.desc
		})
	end

	TipsFacade.instance:openImageRuleView(list, ruleCfgs[1].title)
end

return AoqiHeroPvPFmtView
