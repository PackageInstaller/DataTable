-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewsetting/BattleSettingBattleFragmentView.lua

module("logic.extensions.battle.viewsetting.BattleSettingBattleFragmentView", package.seeall)

local M = class("BattleSettingBattleFragmentView", StaticFragmentView)
local BattleAnimaSetting = GameEnum.SystemEnum.BattleAnimaSetting

function M:buildUI()
	self._toggleAutoEnd = goutil.findChildComponent(self.mainGO, "scroll/view/content/element1/autoEnd/toggle", UIComponentType.SpaceXToggle)
	self._toggleClickEnsure = goutil.findChildComponent(self.mainGO, "scroll/view/content/element1/clickEnsure/toggle", UIComponentType.SpaceXToggle)
	self._toggleDoubleClickStandby = goutil.findChildComponent(self.mainGO, "scroll/view/content/element1/doubleClickStandby/toggle", UIComponentType.SpaceXToggle)
	self._toggleAutoShowDangerous = goutil.findChildComponent(self.mainGO, "scroll/view/content/element1/autoShowDangerous/toggle", UIComponentType.SpaceXToggle)
	self._toggleTargetPrediction = goutil.findChildComponent(self.mainGO, "scroll/view/content/element1/targetPrediction/toggle", UIComponentType.SpaceXToggle)
	self._toggleSimpleSkill = goutil.findChildComponent(self.mainGO, "scroll/view/content/element1/simpleSkill/toggle", UIComponentType.SpaceXToggle)
	self._toggleNoneTarget = goutil.findChildComponent(self.mainGO, "scroll/view/content/element1/targetTips/toggle", UIComponentType.SpaceXToggle)
	self._animationToggleGroup = goutil.findChildComponent(self.mainGO, "scroll/view/content/element1/fightAnimation", UIComponentType.SpaceXToggleGroup)
	self._toggleBattleShake = goutil.findChildComponent(self.mainGO, "scroll/view/content/element1/shakeEnable/toggle", UIComponentType.SpaceXToggle)
	self._animationToggleCompList = {}

	for index = 1, 3 do
		local toggleComp = goutil.findChildComponent(self.mainGO, string.format("scroll/view/content/element1/fightAnimation/toggle%s", index), UIComponentType.SpaceXToggle)

		table.insert(self._animationToggleCompList, toggleComp)
	end

	self._speedToggleGroup = goutil.findChildComponent(self.mainGO, "scroll/view/content/element1/speedAdjust", UIComponentType.SpaceXToggleGroup)
	self._speedToggleCompList = {}

	for index = 1, 2 do
		local toggleComp = goutil.findChildComponent(self.mainGO, string.format("scroll/view/content/element1/speedAdjust/toggle%s", index), UIComponentType.SpaceXToggle)

		table.insert(self._speedToggleCompList, toggleComp)
	end
end

function M:bindEvents()
	self._toggleAutoEnd:AddListener(self._onToggleAutoEnd, self)
	self._toggleClickEnsure:AddListener(self._onToggleClickEnsure, self)
	self._toggleDoubleClickStandby:AddListener(self._onToggleDoubleClickStandby, self)
	self._toggleAutoShowDangerous:AddListener(self._onToggleAutoShowDangerous, self)
	self._toggleTargetPrediction:AddListener(self._onToggleTargetPrediction, self)
	self._toggleSimpleSkill:AddListener(self._onToggleSimpleSkill, self)
	self._toggleNoneTarget:AddListener(self._onToggleNoneTarget, self)
	self._toggleBattleShake:AddListener(self._onToggleShake, self)

	for k, v in pairs(self._animationToggleCompList) do
		v:AddListener(function(_, isOn, IsEnable)
			self:_dealAniBarClick(k, isOn, IsEnable)
		end, nil)
	end

	for k, v in pairs(self._speedToggleCompList) do
		v:AddListener(function(_, isOn)
			self:_dealSpeedBarClick(k, isOn)
		end, nil)
	end
end

function M:unbindEvents()
	self._toggleAutoEnd:RemoveListener()
	self._toggleClickEnsure:RemoveListener()
	self._toggleDoubleClickStandby:RemoveListener()
	self._toggleAutoShowDangerous:RemoveListener()
	self._toggleTargetPrediction:RemoveListener()
	self._toggleSimpleSkill:RemoveListener()
	self._toggleNoneTarget:RemoveListener()
	self._toggleBattleShake:RemoveListener()

	for k, v in pairs(self._animationToggleCompList) do
		v:RemoveListener()
	end

	for k, v in pairs(self._speedToggleCompList) do
		v:RemoveListener()
	end
end

function M:destroyUI()
	return
end

function M:syncSetting()
	self._toggleAutoEnd.IsOn = PlayerLocalStorageModel.instance:getAutoEnd()
	self._toggleClickEnsure.IsOn = PlayerLocalStorageModel.instance:getClickEnsure()
	self._toggleDoubleClickStandby.IsOn = PlayerLocalStorageModel.instance:getDoubleClickStandby()
	self._toggleAutoShowDangerous.IsOn = PlayerLocalStorageModel.instance:getAutoShowDangerous()
	self._toggleTargetPrediction.IsOn = PlayerLocalStorageModel.instance:getTargetPrediction()
	self._toggleSimpleSkill.IsOn = PlayerLocalStorageModel.instance:getSimpleSkillCast()
	self._toggleNoneTarget.IsOn = PlayerLocalStorageModel.instance:getNoneTarget()
	self._toggleBattleShake.IsOn = PlayerLocalStorageModel.instance:getShakeEnable()

	local aniQuality = PlayerLocalStorageModel.instance:getBattleAnimationQuality()

	self._animationToggleGroup:TryActiveChildOn(self._animationToggleCompList[aniQuality], true)

	local speed = PlayerLocalStorageModel.instance:getSpeedAdjust()

	self._speedToggleGroup:TryActiveChildOn(self._speedToggleCompList[speed], true)
end

function M:onEnter()
	self:_handleSystemOpen()
	self:syncSetting()
end

function M:_handleSystemOpen()
	local isOpen = SystemOpenFacade.instance:isOpen(BattleAnimaSetting)

	for k, v in pairs(self._animationToggleCompList) do
		if k > 1 then
			v.IsEnable = isOpen
		elseif not isOpen then
			v.IsOn = true

			PlayerLocalStorageModel.instance:setBattleAnimationQuality(1)
		end
	end
end

function M:_onToggleAutoEnd(index, isOn)
	PlayerLocalStorageModel.instance:setAutoEnd(isOn)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kAutoEnd, isOn)
end

function M:_onToggleClickEnsure(index, isOn)
	PlayerLocalStorageModel.instance:setClickEnsure(isOn)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kClickEnsure, isOn)
end

function M:_onToggleDoubleClickStandby(index, isOn)
	PlayerLocalStorageModel.instance:setDoubleClickStandby(isOn)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kDoubleClickStandby, isOn)
end

function M:_onToggleAutoShowDangerous(index, isOn)
	PlayerLocalStorageModel.instance:setAutoShowDangerous(isOn)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kAutoShowDangerous, isOn)
end

function M:_onToggleTargetPrediction(index, isOn)
	PlayerLocalStorageModel.instance:setTargetPrediction(isOn)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kTargetPrediction, isOn)
end

function M:_onToggleSimpleSkill(index, isOn)
	PlayerLocalStorageModel.instance:setSimpleSkillCast(isOn)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kSimpleSkillCast, isOn)
end

function M:_onToggleNoneTarget(index, isOn)
	PlayerLocalStorageModel.instance:setNoneTarget(isOn)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kNoneTarget, isOn)
end

function M:_dealAniBarClick(index, isOn, IsEnable)
	if not IsEnable then
		SystemOpenFacade.instance:isOpen(BattleAnimaSetting, true)

		return
	end

	if isOn then
		PlayerLocalStorageModel.instance:setBattleAnimationQuality(index)
		GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kBattleAnimationQuality, index)
	end
end

function M:_dealSpeedBarClick(index, isOn)
	if isOn then
		if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FightSpeed, false) then
			self._speedToggleCompList[1].IsOn = true

			if index == 1 then
				return
			end

			local cfgCO = SystemOpenConfig.instance:getSystemOpenCOById(GameEnum.SystemEnum.FightSpeed)
			local str = cfgCO and cfgCO:getLockTips() or lang("tip_system_open_not_online")

			FloatWordMgr.instance:show(str)

			return
		end

		PlayerLocalStorageModel.instance:setSpeedAdjust(index)
		GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kSpeedAdjust, index)
	end
end

function M:_onToggleShake(index, isOn)
	local settingModel = BattleMgr.instance:getSettingModel()

	settingModel:setShakeEnable(isOn)
end

return M
