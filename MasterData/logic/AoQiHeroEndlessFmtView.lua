-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoQiHeroEndlessFmtView.lua

module("logic.extensions.aoqihero.view.AoQiHeroEndlessFmtView", package.seeall)

local AoQiHeroEndlessFmtView = class("AoQiHeroEndlessFmtView", AoQiHeroFormationView)

function AoQiHeroEndlessFmtView:onEnter()
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroEndlessChallengeRes, self._PM_AoQiHeroEndlessChallengeRes, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._stageId = 1

	self:_initData()
	self:_genarateMap()
	self:_genarateEntity()
	self:_refreshPetView()
end

function AoQiHeroEndlessFmtView:_initData()
	local stageCfg = AoQiHeroConfig.instance:getEndlessStageCfg(self._activityId, self._stageId)
	local teamCfg = AoQiHeroConfig.instance:getTeamCfg(self._activityId, stageCfg.creepsMasterId)

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

	local creepCfgs = AoQiHeroConfig.instance:getCreepsCfg(self._activityId, stageCfg.creepsMasterId)

	for i, v in ipairs(creepCfgs) do
		local attrData = FightingPowerFormula.instance:parseAttrValues(v.extproperties)
		local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, v.raceId)
		local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, v.lv)
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

	self._txtName.text = teamCfg.name
end

function AoQiHeroEndlessFmtView:_onClickStart()
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
			AoQiHeroController.instance:sendPM_AoQiHeroEndlessChallengeReq(self._activityId, self._stageId, raceIds)
		end)
	else
		AoQiHeroController.instance:sendPM_AoQiHeroEndlessChallengeReq(self._activityId, self._stageId, raceIds)
	end
end

function AoQiHeroEndlessFmtView:_onClickTeam()
	UIStateManager.instance:push(ViewName.AoqiHeroStrengthenView, self._activityId)
end

function AoQiHeroEndlessFmtView:_onClickTips()
	local ruleCfgs = AoQiHeroConfig.instance:getImageRuleCfg(2)
	local list = {}

	for i, v in ipairs(ruleCfgs) do
		table.insert(list, {
			url = v.resName,
			desc = v.desc
		})
	end

	TipsFacade.instance:openImageRuleView(list, ruleCfgs[1].title)
end

function AoQiHeroEndlessFmtView:_PM_AoQiHeroEndlessChallengeRes()
	self:close()
	UIStateManager.instance:push(ViewName.AoQiHeroEndlessBtlView, self._activityId)
end

return AoQiHeroEndlessFmtView
