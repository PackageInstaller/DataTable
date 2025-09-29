-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/monitor/MonitorViewItem.lua

module("logic.extensions.controlaction.view.monitor.MonitorViewItem", package.seeall)

local M = class("MonitorViewItem")
local TITLES = {
	"CAM1",
	"CAM2",
	"CAM3",
	"CAM4"
}

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()

	self._viewId = 1
	self._isValid = true
	self._toggleIndex = 0
end

function M:_buildUI()
	self._unlockGo = goutil.findChild(self._mainGo, "unlock")
	self._lockGo = goutil.findChild(self._mainGo, "lock")
	self._selectGo = goutil.findChild(self._mainGo, "select")
	self._levelGo = goutil.findChild(self._mainGo, "unlock/levelList")
	self._headGo = goutil.findChild(self._mainGo, "unlock/head")
	self._bgParticleGo = goutil.findChild(self._mainGo, "ui_particle_bg")
	self._transitParticleGo = goutil.findChild(self._mainGo, "ui_transitions")
	self._imgIcon = goutil.findChildImageComponent(self._mainGo, "unlock/imgIcon")
	self._txtTitle = goutil.findChildTextComponent(self._mainGo, "unlock/Image1/txtTitle")
	self._txtPosition = goutil.findChildTextComponent(self._mainGo, "unlock/Image2/txtPos")
	self._txtDate = goutil.findChildTextComponent(self._mainGo, "unlock/bottom/txtDate")
	self._btnClick = Astral.ButtonAdapter.Get(self._mainGo)
	self._toggleCompList = {}
	self._toggleGroup = self._levelGo:GetComponent(UIComponentType.SpaceXToggleGroup)
	self._toggleGoList = Astral.GameObjectUtil.GetChildren(self._levelGo)

	for index = 0, self._toggleGoList.Length - 1 do
		Astral.ButtonAdapter.Get(self._toggleGoList[index])

		local toggleComp = self._toggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._toggleCompList, toggleComp)
		toggleComp:AddListener(function(_, isOn)
			if isOn then
				self:_dealToggleClick(index + 1, isOn)
			end
		end, nil)
	end

	goutil.setActive(self._levelGo, false)
	self:_bindEvents()
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
	GlobalDispatcher:addEventListener(EventType.CONTROLACTION_MONITOR_SELECT, self.setStatus, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.CONTROLACTION_MONITOR_SELECT, self.setStatus, self)
end

function M:OnDestroy()
	self._isValid = true

	IconLoader.clearSprite(self._imgIcon)
	self:_unbindEvents()
end

function M:initViewID(id)
	self._viewId = id
end

function M:onExit()
	self._toggleGroup.allowSwitchOff = true

	for i = 1, #self._toggleCompList do
		self._toggleCompList[i].IsOn = false
	end

	self._toggleIndex = 0
end

function M:setValid(isValid)
	self._isValid = isValid
end

function M:_onClick()
	GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_MONITOR_SELECT, self._viewId)

	if not self._isValid then
		GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_MONITOR_INVALID)
	end
end

function M:setStatus(e, id, difficultIndex)
	if id ~= 0 and self._selectGo.activeSelf and self._viewId == id then
		return
	end

	self._toggleGroup.allowSwitchOff = true

	goutil.setActive(self._selectGo, self._viewId == id)
	goutil.setActive(self._levelGo, self._viewId == id)

	if not self._isValid then
		return
	end

	local diffIndex = difficultIndex or 1

	if self._selectGo.activeSelf and self._unlockGo.activeSelf then
		self._toggleIndex = 0
		self._toggleCompList[diffIndex].IsOn = false
		self._toggleCompList[diffIndex].IsOn = true
	end

	self._toggleGroup.allowSwitchOff = false
end

function M:setAirRoom(isIn)
	if not self._isValid then
		goutil.setActive(self._bgParticleGo, true)

		return
	end

	goutil.setActive(self._unlockGo, isIn)
	goutil.setActive(self._lockGo, not isIn)

	local battleInfo = ControlActionModel.instance:getBattleInfo()

	if not battleInfo then
		goutil.setActive(self._bgParticleGo, true)

		if isIn then
			settimer(0.5 * self._viewId, function()
				goutil.setActive(self._transitParticleGo, true)
			end, self, false)
			settimer(0.5 * self._viewId + 0.2, self._particlePlayDone, self, false)
		end
	end
end

function M:_particlePlayDone()
	goutil.setActive(self._bgParticleGo, false)
	goutil.setActive(self._transitParticleGo, false)
end

function M:refresh(data)
	if not self._isValid then
		return
	end

	self._monitorMo = data

	local postCo = self._monitorMo:getThemePostCo()

	self._txtTitle.text = self._monitorMo:getZoneName()
	self._txtPosition.text = postCo.area

	printWarn("=====refresh======", self._monitorMo)
	IconLoader.setSprite(self._imgIcon, IconType.ControlActionMonitor, postCo.picture)

	local dungeonCodes = self._monitorMo:getDungeonGroupCo().dungeonCodes

	for i = 1, #self._toggleCompList do
		local dungeonCo = DungeonConfig.instance:getDungeonCfgById(dungeonCodes[i])
		local toggleGo = self._toggleCompList[i].gameObject
		local text1 = goutil.findChildTextComponent(toggleGo, "select/Text1")
		local text2 = goutil.findChildTextComponent(toggleGo, "normal/Text1")
		local lockGo = goutil.findChild(toggleGo, "normal/lock")

		text1.text = dungeonCo.index
		text2.text = dungeonCo.index

		if i > 1 and ControlActionUtil.isInGuideSecond() then
			goutil.setActive(lockGo, true)
		else
			goutil.setActive(lockGo, self:_getDifficultLockFlag(i, false))
		end
	end
end

function M:getMonitorMO()
	return self._monitorMo
end

function M:_getDifficultLockFlag(index, isShowTips)
	local groupCo = self._monitorMo:getDungeonGroupCo()
	local dungeonCode = groupCo.dungeonCodes[index]
	local preDungeonCode = groupCo.dungeonCodes[index - 1]
	local hasPassed = false

	if preDungeonCode then
		local preDungeonMo = DungeonModel.instance:getDungeonMoById(preDungeonCode)

		hasPassed = preDungeonMo:hasPassed()
	end

	self._limitCo = ControlActionConfig.instance:getMonitorDungeonLimitCfg(dungeonCode)

	local isTeaching = self._limitCo.canMultiplicityCost == 0
	local levelLimit = PlayerModel.instance:getLevel() < self._limitCo.level

	if levelLimit then
		if isShowTips then
			FloatWordMgr.instance:show(string.format(lang("tip_player_not_reach_level"), StringUtil.convertLevel(self._limitCo.level)))
		end

		return true
	end

	if index ~= 1 and not isTeaching and not hasPassed then
		if isShowTips then
			FloatWordMgr.instance:show(lang("tip_pre_difficult_notpass"))
		end

		return true
	end

	return false
end

function M:_dealToggleClick(index)
	if self:_getDifficultLockFlag(index, true) then
		self._toggleGroup.allowSwitchOff = true

		if self._toggleIndex > 0 then
			self._toggleCompList[self._toggleIndex].IsOn = true
		else
			self._toggleCompList[index].IsOn = false
		end

		self._toggleGroup.allowSwitchOff = false

		return
	end

	if self._toggleIndex == index then
		return
	end

	self._toggleIndex = index

	local groupCo = self._monitorMo:getDungeonGroupCo()
	local dungeonCode = groupCo.dungeonCodes[index]
	local preDungeonCode = groupCo.dungeonCodes[index - 1]
	local rewardCodeInfo = groupCo.reward[index]
	local rewardCodeZone = self._monitorMo:getZoneCo().reward[index]

	if index == #groupCo.dungeonCodes then
		preDungeonCode = nil
	end

	printWarn("====click toggle index====", index, self._viewId, dungeonCode, preDungeonCode, rewardCode)

	local info = {}

	info.id = groupCo.code
	info.viewId = self._viewId
	info.difficultIndex = index
	info.dungeonCode = dungeonCode
	info.preDungeonCode = preDungeonCode
	info.rewardCodeInfo = rewardCodeInfo
	info.rewardCodeZone = rewardCodeZone
	info.title = TITLES[self._viewId]

	GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_MONITOR_TAB, info)
end

return M
