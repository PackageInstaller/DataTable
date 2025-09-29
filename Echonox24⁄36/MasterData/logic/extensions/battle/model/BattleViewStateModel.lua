-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleViewStateModel.lua

module("logic.extensions.battle.model.BattleViewStateModel", package.seeall)

local M = class("BattleViewStateModel", BaseModel)
local kSystemOpenTable = {
	[BattleUIElement.Auto] = GameEnum.SystemEnum.AutoFight,
	[BattleUIElement.Speed] = GameEnum.SystemEnum.FightSpeed,
	[BattleUIElement.Setting] = GameEnum.SystemEnum.FightSetting,
	[BattleUIElement.Undo] = GameEnum.SystemEnum.BattleRetract,
	[BattleUIElement.RoundFinish] = GameEnum.SystemEnum.FightRoundEnd,
	[BattleUIElement.DangerZone] = GameEnum.SystemEnum.FightDangerRange,
	[BattleUIElement.RotateCamera] = GameEnum.SystemEnum.FightSight,
	[BattleUIElement.RoundCount] = GameEnum.SystemEnum.FightRoundCount,
	[BattleUIElement.WinCondition] = GameEnum.SystemEnum.FightWinCondition,
	[BattleUIElement.SanityStrengthen] = GameEnum.SystemEnum.FightSanStrengthen
}

function M:onInit()
	self._uiElementStateTable = {}

	self:onReset()
end

function M:onReset()
	self._uiElementStateTable = {}
end

function M:setUIElementVisible(elementEnum, visible, key)
	local invisibleSignalAmount = self._uiElementStateTable[elementEnum]

	if not invisibleSignalAmount then
		invisibleSignalAmount = SignalAmount.New()
		self._uiElementStateTable[elementEnum] = invisibleSignalAmount
	end

	if visible then
		invisibleSignalAmount:remove(key)
	else
		invisibleSignalAmount:addUnique(key)
	end

	return self:isUIElementVisible(elementEnum)
end

function M:isUIElementVisible(elementEnum)
	local systemOpenKey = kSystemOpenTable[elementEnum]
	local isSystemOpen = BattleTestUtil.isTest or not systemOpenKey or SystemOpenFacade.instance:isOpen(systemOpenKey)
	local invisibleSignalAmount = self._uiElementStateTable[elementEnum]
	local visible = not invisibleSignalAmount or invisibleSignalAmount:isUnactive()

	return isSystemOpen and visible
end

function M:clear()
	for _, invisibleSignalAmount in pairs(self._uiElementStateTable) do
		invisibleSignalAmount:clear()
	end
end

M.instance = M.New()

return M
