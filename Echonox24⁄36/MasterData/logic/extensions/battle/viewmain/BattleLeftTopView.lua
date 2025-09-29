-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/BattleLeftTopView.lua

module("logic.extensions.battle.viewmain.BattleLeftTopView", package.seeall)

local BattleLeftTopView = class("BattleLeftTopView", ViewComponent)
local kRoundRegex = "回合%s/%s"

function BattleLeftTopView:buildUI()
	self.mainGO = self:getGoByPath("leftTopHint")
	self._enableState = GameObjectEnableState.New(self.mainGO)
	self._btnRestrainHint = Astral.ButtonAdapter.GetFrom(self.mainGO, "imgHint")
end

function BattleLeftTopView:destroyUI()
	self._txtRound = nil
	self._txtCondition = nil
	self._btnRestrainHint = nil
end

function BattleLeftTopView:bindEvents()
	self._btnRestrainHint:AddClickListener(self._onClickRestrainHint, self)
end

function BattleLeftTopView:unbindEvents()
	self._btnRestrainHint:RemoveClickListener()
end

function BattleLeftTopView:onEnter()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	if dungeonCode then
		self._dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)
	end

	self:_updateView()
end

function BattleLeftTopView:onExit()
	self._enableState:clear()
end

function BattleLeftTopView:setVisible(visible, key)
	self._enableState:setEnable(key, visible)
end

function BattleLeftTopView:_updateView()
	return
end

function BattleLeftTopView:_onClickRestrainHint()
	BattleAudioUtil.playSEByName("ui_battle_kezhiguanxi")
	ViewMgr.instance:open(ViewName.BattleExplainTips)
end

return BattleLeftTopView
