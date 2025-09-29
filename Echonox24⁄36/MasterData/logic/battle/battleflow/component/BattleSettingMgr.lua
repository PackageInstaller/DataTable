-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/BattleSettingMgr.lua

module("logic.battle.battleflow.component.BattleSettingMgr", package.seeall)

local BattleSettingMgr = class("BattleSettingMgr", IBattleFlowComp)

function BattleSettingMgr:onStart()
	self._model = self.flow.model or false
	self._settingModel = self.flow.settingModel or false

	self:_setEvent(true)
	self:_adjustUISettings()
end

function BattleSettingMgr:onEnterDone()
	local index = self._settingModel:getBattleSpeed()
	local speed = self:_index2Speed(index)

	self.flow:setSpeed(speed)
end

function BattleSettingMgr:onClear()
	self._model = false
	self._settingModel = false

	self:_setEvent(false)
	BattleUISettings.clearAllSettings()
end

function BattleSettingMgr:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SETTING_CONTENT_CHANGE, self._onSettingContentChanged, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SETTING_CONTENT_CHANGE, self._onSettingContentChanged, self)
	end
end

function BattleSettingMgr:_adjustUISettings()
	local operateCampId = self._model:getOperateCampId()
	local battleFieldInfo = self._model:getBattleFieldInfo()
	local campInfos = battleFieldInfo.campInfos

	for _, campInfo in pairs(campInfos) do
		local campId = campInfo.campId
		local relationType = self._model:getCampRelation(operateCampId, campId)

		if relationType == BattleEnum.CampRelation.SAME then
			BattleUISettings.setCampSettingCO(campId, BattleUISettings.WhiteSetting)
		elseif relationType == BattleEnum.CampRelation.ENEMY then
			BattleUISettings.setCampSettingCO(campId, BattleUISettings.RedSetting)
		elseif relationType == BattleEnum.CampRelation.FRIEND then
			BattleUISettings.setCampSettingCO(campId, BattleUISettings.GreenSetting)
		elseif relationType == BattleEnum.CampRelation.NORMAL then
			BattleUISettings.setCampSettingCO(campId, BattleUISettings.GreenSetting)
		elseif BattleLog.enableError then
			BattleLog.error(string.format("BattleSettingMgr::unhandle relation type %s", relationType))
		end
	end

	BattleUISettings.setCampSettingCO(BattleConst.DEFAULT_CAMP_ID, BattleUISettings.WhiteSetting)
end

function BattleSettingMgr:_onSettingContentChanged(evt, settingKey, value)
	if settingKey == SettingConst.kSpeedAdjust then
		local speed = self:_index2Speed(value)

		self.flow:setSpeed(speed)
	elseif settingKey == SettingConst.kAutoShowDangerous then
		BattleDispatcher:dispatchEvent(BattleEventType.ON_SWITCH_DANGER_AREA, value)
	elseif settingKey == SettingConst.kTargetPrediction then
		BattleDispatcher:dispatchEvent(BattleEventType.ON_SWITCH_AI_FORECAST, value)
	end
end

function BattleSettingMgr:_index2Speed(index)
	if index == 1 then
		return 1
	end

	return ConstConfig.instance:getFloatValueByKey(ConstConfigKeyEnum.BattleSpeed)
end

return BattleSettingMgr
