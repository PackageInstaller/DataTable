-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleFamilyHoudingClgView.lua

module("logic.extensions.battle.view.BattleFamilyHoudingClgView", package.seeall)

local BattleFamilyHoudingClgView = class("BattleFamilyHoudingClgView")

function BattleFamilyHoudingClgView:ctor(go, view, bloodBar)
	self._view = view
	self.mainGO = go
	self._bloodBar = bloodBar
end

function BattleFamilyHoudingClgView:buildUI()
	self._imgBox = goutil.findChild(self.mainGO, "top/box/imgBox")
	self._txtBoxNum = goutil.findChildTextComponent(self.mainGO, "top/box/txtBoxNum")
	self._roundTips = goutil.findChild(self.mainGO, "roundTips")
	self._roundTips_txt = goutil.findChildTextComponent(self.mainGO, "roundTips/txt")
end

function BattleFamilyHoudingClgView:onEnter()
	local fhcParams = BattleModel.instance.FamilyHoudingClgParams
	local fhId = checknumber(fhcParams[1])
	local dayIndex = checknumber(fhcParams[2])
	local planTimeData = FamilyHoudingClgConfig.instance:getFhPlanTimeData(fhId)
	local bossData = FamilyHoudingClgConfig.instance:getFhBossData(fhId, dayIndex)

	self._prizeCfg = FamilyHoudingClgConfig.instance:getFhDamagePrizeCfg(bossData.damagePrizePlanId)

	local masterData = FamilyHoudingClgConfig.instance:getFhCreepsMasterData(bossData.creepsMasterId)
	local winId = masterData.winId

	self._maxRoundNum = self:_getMaxRoundNumByWinId(winId)

	uGuiUtil.setSpriteToImage(self._imgBox, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl("icon_zb2"))
	self:_onBattleRoundStart(0)
	GlobalDispatcher:addListener(GlobalNotify.BattleRoundStart, self._onBattleRoundStart, self)
end

function BattleFamilyHoudingClgView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.BattleRoundStart, self._onBattleRoundStart, self)
	uGuiUtil.clearImage(self._imgBox)
end

function BattleFamilyHoudingClgView:updateValue(cur, total, isForce)
	local value = total - cur

	if self._prizeCfg == nil then
		return
	end

	value = checknumber(value)
	value = math.max(0, value)
	self._value = checknumber(self._value)
	self._value = math.max(0, self._value)

	local targetCfg, targetIdx, maxDmage = self:_getCurCfgAndNeed(value)

	self._txtBoxNum.text = targetIdx

	self._bloodBar:setTextProgress(string.format("总伤害：%s/%s", value, maxDmage))

	local sliderValue = 1 - value / maxDmage

	self._bloodBar:setProgress(sliderValue, isForce)

	self._value = value
end

function BattleFamilyHoudingClgView:_getCurCfgAndNeed(value)
	local data
	local idx = 0
	local maxDmage = 0

	for prizeGearId, prizeData in ipairs(self._prizeCfg) do
		local min, max = prizeData.damageRange[1], prizeData.damageRange[2]

		if value <= max then
			idx = prizeGearId
			data = prizeData
			maxDmage = max

			if value <= min then
				maxDmage = min

				break
			end
		end
	end

	return data, idx, maxDmage
end

function BattleFamilyHoudingClgView:_onBattleRoundStart(roundNum)
	self._roundTips_txt.text = string.format("当前回合数：%s / %s", roundNum, self._maxRoundNum)
end

function BattleFamilyHoudingClgView:_getMaxRoundNumByWinId(winId)
	local maxRoundNum = 0
	local winIdQueue = Array.New()

	winIdQueue:PushBack(winId)

	while winIdQueue:GetSize() > 0 do
		local id = winIdQueue:PopFront()
		local opData = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(id)

		if opData then
			local resultType = opData.type

			if resultType == GameEnum.Evaluate.Combination then
				local arr = string.split(opData.params, "&")

				for i, v in ipairs(arr) do
					winIdQueue:PushBack(checknumber(v))
				end
			elseif resultType == GameEnum.Evaluate.CircleCount then
				maxRoundNum = checknumber(opData.params)

				break
			end
		end
	end

	return maxRoundNum
end

return BattleFamilyHoudingClgView
