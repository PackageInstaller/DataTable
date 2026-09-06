-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleWinnerOpView.lua

module("logic.extensions.battle.view.BattleWinnerOpView", package.seeall)

local BattleWinnerOpView = class("BattleWinnerOpView", ViewComponent)
local CUSTOM_TXT_TYPE = "CUSTOM_TXT_TYPE"

function BattleWinnerOpView:buildUI()
	BattleWinnerOpView.super.buildUI(self)

	self._gridConditions = self:getGo("gridConditions")
end

function BattleWinnerOpView:onEnter()
	BattleWinnerOpView.super.onEnter(self)
	self:_clearDatas()

	if BattleModel.instance.familyTeamPlayType then
		self._winnerOpIds = {
			22
		}
	elseif BattleModel.instance.curMissionType == GameEnum.MissionType.LIGHTKING then
		self._winnerOpIds = LightKingModel.instance:getCurStageWinId()
	elseif BattleModel.instance.curMissionType == GameEnum.MissionType.BING_LING_WANG then
		self._ruleCfg = BinglingwangModel.instance:getCurrMonsterCfg()
		self._winnerOpIds = self._ruleCfg and checknumber(self._ruleCfg.perfectWinId) > 0 and {
			self._ruleCfg.perfectWinId
		} or {}
	elseif BattleModel.instance.curMissionType == GameEnum.MissionType.LONG_NV then
		self._ruleCfg = LongnvModel.instance:getCurrMonsterCfg()
		self._winnerOpIds = self._ruleCfg and checknumber(self._ruleCfg.perfectWinId) > 0 and {
			self._ruleCfg.perfectWinId
		} or {}
	elseif BattleModel.instance.curMissionType == GameEnum.MissionType.SaintKnightRui then
		printInfo("test 执行了 BattleWinnerOpView", BattleModel.instance.curMissionType)

		local winId = SaintKnightRuiModel.instance:getWinId()

		self._winnerOpIds = checknumber(winId) > 0 and {
			winId
		} or {}
	elseif BattleModel.instance.isAnheimm then
		local ruleId = AnheimmModel.instance:getCurRuleId()

		self._ruleCfg = AnheimmConfig.instance:getRuleCfgById(ruleId or 1)
		self._winnerOpIds = checknumber(self._ruleCfg.perfectWinId) > 0 and {
			self._ruleCfg.perfectWinId
		} or {}
	elseif BattleModel.instance.perfectRuleModeChanllengeId then
		local challengeId = BattleModel.instance.perfectRuleModeChanllengeId

		curInfo = PerfectRuleModeModel.instance:getInfo(challengeId)

		if curInfo then
			local ruleId = curRuleId

			self._ruleCfg = PerfectRuleModeConfig.instance:getRuleCfgById(challengeId, ruleId)
			self._winnerOpIds = self._ruleCfg and (checknumber(self._ruleCfg.perfectWinId) > 0 and {
				self._ruleCfg.perfectWinId
			} or {}) or {}
		end
	elseif BattleModel.instance.goddesGloryChallengeId then
		local eventCo = GoddessGloryConfig.instance:getEventCo(BattleModel.instance.goddesGloryEventId)
		local monsterCo = GoddessGloryConfig.instance:getMonsterCo(eventCo.creepsMasterId)

		if monsterCo and checknumber(monsterCo.winId) > 0 then
			self._winnerOpIds = {
				checknumber(monsterCo.winId)
			}
			self._ruleCfg = monsterCo
		else
			self._ruleCfg = nil
			self._winnerOpIds = {}
		end
	elseif BattleModel.instance.isDishitianSQ then
		local winId = checknumber(BattleModel.instance.dishitianSQWinId)

		printInfo("test BattleModel.instance.isDishitianSQ", winId)

		self._winnerOpIds = winId > 0 and {
			winId
		} or {}
	elseif BattleFacade.instance:getBattleWinnerOpHandler() then
		self._initHandler, self._updateHandler, self._isReachHandler = BattleFacade.instance:getBattleWinnerOpHandler()
		self._winnerOpIds = {}
	else
		return
	end

	GlobalDispatcher:addListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleRoundStart, self._onBattleRoundStart, self)
	self:_initConditions()
end

function BattleWinnerOpView:_initConditions()
	self._conditions = {}

	local parent = self._gridConditions.transform
	local childCount = parent.childCount
	local firstChild = parent:GetChild(0).gameObject

	for k = 1, childCount do
		parent:GetChild(k - 1).gameObject:SetActive(false)
	end

	for k, v in ipairs(self._winnerOpIds) do
		local cfg = AnheimmConfig.instance:getPerfectWinOpCfg(v)

		if BattleModel.instance.curMissionType == GameEnum.MissionType.LIGHTKING then
			cfg = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(v)

			print("params = " .. cfg.params)
		end

		if BattleModel.instance.curMissionType == GameEnum.MissionType.BING_LING_WANG then
			cfg = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(v)
		end

		if BattleModel.instance.curMissionType == GameEnum.MissionType.LONG_NV then
			cfg = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(v)
		end

		if BattleModel.instance.curMissionType == GameEnum.MissionType.SaintKnightRui then
			cfg = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(v)
		end

		if BattleModel.instance.goddesGloryChallengeId then
			cfg = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(v)
		end

		if BattleModel.instance.isDishitianSQ then
			cfg = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(v)
		end

		local obj = {}
		local go = k < childCount and parent:GetChild(k).gameObject or goutil.cloneAndSetParent(firstChild, parent)

		go:SetActive(true)

		obj.cfg = cfg
		obj.go = go
		self._conditions[cfg.type] = obj

		self:_updateOneCondition(cfg.type, obj)
	end

	if self._initHandler then
		local go = childCount > #self._winnerOpIds + 1 and parent:GetChild(#self._winnerOpIds).gameObject or goutil.cloneAndSetParent(firstChild, parent)

		go:SetActive(true)

		self._conditions[CUSTOM_TXT_TYPE] = GameUtil.callBack(self._initHandler, go)

		self:_updateOneCondition(CUSTOM_TXT_TYPE)
	end
end

function BattleWinnerOpView:onExit()
	BattleWinnerOpView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleRoundStart, self._onBattleRoundStart, self)
	self:_clearDatas()
	BattleFacade.instance:registerBattleWinnerOpHandler(nil, nil, nil)
end

function BattleWinnerOpView:_clearDatas()
	print("clearDatas")

	self._myCriticalNum = 0
	self._myDodgeNum = 0
	self._curRoundNum = 1
	self._curAttrRestrainNum = 0

	local parent = self._gridConditions.transform
	local firstChild = parent:GetChild(0).gameObject

	firstChild:SetActive(false)

	if self._conditions then
		for k, v in pairs(self._conditions) do
			goutil.destroy(v.go)
		end
	end

	self._conditions = nil
	self._ruleCfg = nil
end

function BattleWinnerOpView:_onBattleHurtData(hurtData)
	if hurtData then
		local attacker = hurtData.attacker
		local target = hurtData.target

		self:_updateOneCondition(GameEnum.BattleWinnerOpType.MyPosIdMustActive)
		self:_updateOneCondition(GameEnum.BattleWinnerOpType.ActiveCount)
		self:_updateOneCondition(GameEnum.BattleWinnerOpType.MyActivePetContainsAttrs)
		print("hurtData.donotResult = " .. tostring(hurtData.donotResult))

		if hurtData.donotResult == true then
			return
		end

		if hurtData.isCritical and attacker.teamId == BattleModel.instance.myTeamId then
			self._myCriticalNum = self._myCriticalNum + 1

			self:_updateOneCondition(GameEnum.BattleWinnerOpType.MyCriticalNum)
		end

		if hurtData.isSkillEffected and not hurtData.isHit and target.teamId == BattleModel.instance.myTeamId then
			self._myDodgeNum = self._myDodgeNum + 1

			self:_updateOneCondition(GameEnum.BattleWinnerOpType.MyDodgeNum)
		end
	end
end

function BattleWinnerOpView:_onBattleRoundStart(roundNum)
	self._curRoundNum = roundNum

	printInfo("test 回合开始", roundNum)
	self:_updateOneCondition(GameEnum.BattleWinnerOpType.CircleCount)
	self:_updateOneCondition(GameEnum.BattleWinnerOpType.EqualCircleCount)
	self:_updateOneCondition(CUSTOM_TXT_TYPE)
end

function BattleWinnerOpView:_updateOneCondition(opType)
	local obj = self._conditions[opType]

	if obj == nil then
		return
	end

	local go = obj.go
	local cfg = obj.cfg
	local achieved, text

	if opType == GameEnum.BattleWinnerOpType.MyCriticalNum then
		achieved, text = self:parseMyCriticalNum(cfg)
	elseif opType == GameEnum.BattleWinnerOpType.ActiveCount then
		achieved, text = self:parseActiveCount(cfg)
	elseif opType == GameEnum.BattleWinnerOpType.CircleCount then
		achieved, text = self:parseCircleCount(cfg)
	elseif opType == GameEnum.BattleWinnerOpType.MyPosIdMustActive then
		achieved, text = self:parseMyPosIdMustActive(cfg)
	elseif opType == GameEnum.BattleWinnerOpType.MyActivePetContainsAttrs then
		achieved, text = self:parseMyActivePetContainAttrs(cfg)
	elseif opType == GameEnum.BattleWinnerOpType.MyDodgeNum then
		achieved, text = self:parseMyDodgeNum(cfg)
	elseif opType == GameEnum.BattleWinnerOpType.DamageTotal then
		achieved, text = self:parseDamageTotal(cfg)
	elseif opType == GameEnum.BattleWinnerOpType.DamageTotalRange then
		achieved, text = self:parseDamageTotalRange(cfg)
	elseif opType == GameEnum.BattleWinnerOpType.EqualCircleCount then
		achieved, text = self:parseEqualCircleCount(cfg)
	elseif opType == CUSTOM_TXT_TYPE then
		achieved, text = self:parseCustomTxtType(obj)
	end

	local trueObj = goutil.findChild(go, "true")
	local falseObj = goutil.findChild(go, "false")
	local txtCondition = goutil.findChildTextComponent(go, "txtCondition")

	trueObj:SetActive(achieved == true)
	falseObj:SetActive(achieved == false)

	txtCondition.alignment = achieved == nil and UnityEngine.TextAnchor.MiddleCenter or UnityEngine.TextAnchor.MiddleLeft

	if self._ruleCfg ~= nil then
		txtCondition.text = not string.nilorempty(text) and string.format("%s：%s", self._ruleCfg.battleDesc, text) or self._ruleCfg.battleDesc

		if self._ruleCfg.isHideOp == 1 then
			trueObj:SetActive(false)
			falseObj:SetActive(false)
		end
	elseif opType == GameEnum.BattleWinnerOpType.EqualCircleCount then
		txtCondition.text = string.format("坚持回合数：%s", text)
	elseif opType == GameEnum.BattleWinnerOpType.RestraintAtt then
		trueObj:SetActive(false)
		falseObj:SetActive(false)

		txtCondition.text = string.format("属性克制次数：%s", self._curAttrRestrainNum)
	else
		txtCondition.text = opType == CUSTOM_TXT_TYPE and text or string.format("当前回合数：%s", text)
	end
end

function BattleWinnerOpView:parseMyCriticalNum(cfg)
	local needNum = checknumber(cfg.params)
	local achieved = needNum <= self._myCriticalNum
	local text = string.format("%d/%d", self._myCriticalNum, needNum)

	return achieved, text
end

function BattleWinnerOpView:parseMyDodgeNum(cfg)
	local needNum = checknumber(cfg.params)
	local achieved = needNum <= self._myDodgeNum
	local text = string.format("%d/%d", self._myDodgeNum, needNum)

	return achieved, text
end

function BattleWinnerOpView:parseDamageTotal(cfg)
	return false, ""
end

function BattleWinnerOpView:parseDamageTotalRange(cfg)
	return false, ""
end

function BattleWinnerOpView:parseActiveCount(cfg)
	local needNum = checknumber(cfg.params)
	local units = self:getAllAliveUnits()
	local achieved = needNum <= #units
	local text = string.format("%d/%d", #units, needNum)

	return achieved, text
end

function BattleWinnerOpView:parseCircleCount(cfg)
	local needNum = checknumber(cfg.params)
	local achieved = needNum >= self._curRoundNum
	local text = string.format("%d/%d", self._curRoundNum, needNum)

	return achieved, text
end

function BattleWinnerOpView:parseEqualCircleCount(cfg)
	local needNum = checknumber(cfg.params)
	local achieved = self._curRoundNum == needNum
	local text = string.format("%d/%d", self._curRoundNum, needNum)

	return achieved, text
end

function BattleWinnerOpView:parseMyPosIdMustActive(cfg)
	local posIds = string.splitToNumber(cfg.params, ",")
	local curNum = 0
	local needNum = #posIds
	local myUnits = self:getAllAliveUnits()

	for _, v in ipairs(myUnits) do
		for _, posId in ipairs(posIds) do
			local unitPos = v.y * 3 + v.x

			if unitPos == posId then
				curNum = curNum + 1

				break
			end
		end
	end

	return needNum <= curNum, string.format("%d/%d", curNum, needNum)
end

function BattleWinnerOpView:parseMyActivePetContainAttrs(cfg)
	local attrs = string.split(cfg.params, ",")
	local needNum = checknumber(attrs[1])
	local curNum = 0

	table.remove(attrs, 1)

	local myUnits = self:getAllAliveUnits()

	for _, v in ipairs(myUnits) do
		for _, v2 in ipairs(attrs) do
			if PetSkinConfig.instance:checkHasEleAttr((v.modelId > 0 or nil) and v.modelId, v2) then
				curNum = curNum + 1

				break
			end
		end
	end

	return needNum <= curNum, string.format("%d/%d", curNum, needNum)
end

function BattleWinnerOpView:parseCustomTxtType(obj)
	local text = ""
	local isReach

	if self._updateHandler then
		text = GameUtil.callBack(self._updateHandler, obj, self)
	end

	return (self._isReachHandler or nil) and GameUtil.callBack(self._isReachHandler, obj, self), text
end

function BattleWinnerOpView:getAllAliveUnits()
	local scene = SceneMgr.instance:getCurScene()
	local unitFactory = scene.unitFactory

	if scene then
		local leftTeamId = BattleModel.instance:getLeftTeamId()

		return unitFactory:getBttleAliveUnits(leftTeamId)
	else
		return {}
	end
end

return BattleWinnerOpView
