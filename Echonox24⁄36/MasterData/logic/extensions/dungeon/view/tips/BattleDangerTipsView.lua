-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/tips/BattleDangerTipsView.lua

module("logic.extensions.dungeon.view.tips.BattleDangerTipsView", package.seeall)

local M = class("BattleDangerTipsView", ViewComponent)

function M:buildUI()
	self._dungeonScoreRateGo = self:getGoByPath("content/instance_danger")
	self._ensureBtn = self:getBtnByPath("content/btnConfirm")
	self._cancelBtn = self:getBtnByPath("content/btnCancel")
	self._closeBtn = self:getBtnByPath("universal_second_tips_common_bg/content/btnClose")
	self._jumpLevelBtn = self:getBtnByPath("content/upContent/levelItem")
	self._jumpAuthorityBtn = self:getBtnByPath("content/upContent/authorityItem")
	self._jumpEquipBtn = self:getBtnByPath("content/upContent/equipItem")
	self._levelRedDotGo = self:getGoByPath("content/upContent/levelItem/red_point")
	self._authorityRedDotGo = self:getGoByPath("content/upContent/authorityItem/red_point")
	self._equipRedDotGo = self:getGoByPath("content/upContent/equipItem/red_point")
	self._levelUnlock = self:getGoByPath("content/upContent/levelItem/unlock")
	self._authorityUnlock = self:getGoByPath("content/upContent/authorityItem/unlock")
	self._equipUnlock = self:getGoByPath("content/upContent/equipItem/unlock")
	self._levelLock = self:getGoByPath("content/upContent/levelItem/lock")
	self._authorityLock = self:getGoByPath("content/upContent/authorityItem/lock")
	self._equipLock = self:getGoByPath("content/upContent/equipItem/lock")
	self._levelCanvasGroup = self._levelUnlock:GetComponent(ComponentType.CanvasGroup)
	self._authorityCanvasGroup = self._authorityUnlock:GetComponent(ComponentType.CanvasGroup)
	self._equipCanvasGroup = self._equipUnlock:GetComponent(ComponentType.CanvasGroup)
	self._openAgainToggle = self:getGoByPath("content/upContent/toggleTips"):GetComponent(UIComponentType.SpaceXToggle)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._ensureBtn:AddClickListener(self._onClickEnsure, self)
	self._cancelBtn:AddClickListener(self._onClickClose, self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._jumpLevelBtn:AddClickListener(self._onClickJumpLevel, self)
	self._jumpAuthorityBtn:AddClickListener(self._onClickJumpAutority, self)
	self._jumpEquipBtn:AddClickListener(self._onClickJumpEquip, self)
	self._openAgainToggle:AddListener(self._onToggleChange, self)
end

function M:unbindEvents()
	self._ensureBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
	self._closeBtn:RemoveClickListener()
	self._jumpLevelBtn:RemoveClickListener()
	self._jumpAuthorityBtn:RemoveClickListener()
	self._jumpEquipBtn:RemoveClickListener()
	self._openAgainToggle:RemoveListener()
end

function M:_onClickEnsure()
	GlobalDispatcher:dispatchEvent(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._info)
	self:close()
end

function M:_onClickClose()
	self:close()
end

function M:onEnter()
	local params = self:getOpenParam()

	self._scoreCO = params[1]
	self._info = params[2]

	self:_refreshView()
	self._openAgainToggle:ForceSetOn(false)
end

function M:_refreshView()
	local heroIdList = DungeonModel.instance:getHighestScoreHero()

	DifficultyUtil.setDifficultyFlag(self._dungeonScoreRateGo, self._scoreCO)

	self._jumpEquipHeroId = EquipController.instance:checkHerosEquipRedpointInDungeonPre(heroIdList)
	self._jumpLevelHeroId = CharacterUtil.hasHeroCanUpgradeInLst(heroIdList)
	self._jumpAuthorityHeroId = CharacterAuthorityModel.instance:checkRedPointForBattle(heroIdList)
	self._jumpLevelIsLock = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleUpgrade, false)
	self.__jumpAuthorityIsLock = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleAffinity, false)
	self._jumpEquipIsLock = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEquip, false)

	self:_levelSetLock()
	self:_authoritySetLock()
	self:_equipSetLock()
	goutil.setActive(self._equipRedDotGo, self._jumpEquipHeroId and self._jumpEquipIsLock)
	goutil.setActive(self._levelRedDotGo, self._jumpLevelHeroId and self._jumpLevelIsLock)
	goutil.setActive(self._authorityRedDotGo, self._jumpAuthorityHeroId and self.__jumpAuthorityIsLock)
end

function M:_levelSetLock()
	if not self._jumpLevelIsLock then
		goutil.setActive(self._levelLock, not self._jumpLevelIsLock)

		self._levelCanvasGroup.alpha = 0.2
	end
end

function M:_authoritySetLock()
	if not self.__jumpAuthorityIsLock then
		goutil.setActive(self._authorityLock, not self.__jumpAuthorityIsLock)

		self._authorityCanvasGroup.alpha = 0.2
	end
end

function M:_equipSetLock()
	if not self._jumpEquipIsLock then
		goutil.setActive(self._equipLock, not self._jumpEquipIsLock)

		self._equipCanvasGroup.alpha = 0.2
	end
end

function M:_onClickJumpLevel()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleUpgrade, true) then
		return
	end

	SystemJumpController.instance:jumpToCharacterSystem(self._jumpLevelHeroId, CommEnum.CharacterSystemTab.Detail)
end

function M:_onClickJumpAutority()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleAffinity, true) then
		return
	end

	SystemJumpController.instance:jumpToCharacterSystem(self._jumpAuthorityHeroId, CommEnum.CharacterSystemTab.Authority)
end

function M:_onClickJumpEquip()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEquip, true) then
		return
	end

	SystemJumpController.instance:jumpToCharacterSystem(self._jumpEquipHeroId, CommEnum.CharacterSystemTab.Equip)
end

function M:_onToggleChange(_, isOn)
	if isOn then
		Astral.LocalStorage.Instance:SetInt("BattleDangerTips", ServerTime.now())
	else
		Astral.LocalStorage.Instance:DeleteKey("BattleDangerTips")
	end
end

function M:onExit()
	return
end

return M
