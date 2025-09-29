-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/campadjustment/BattleCampAdjustment.lua

module("logic.battle.battleflow.component.campadjustment.BattleCampAdjustment", package.seeall)

local BattleCampAdjustment = class("BattleCampAdjustment", IBattleFlowComp)
local signsRoot = BattleGameObjectRootUtil.signsRoot

function BattleCampAdjustment:onInit()
	self._emptySignCollection = BattleGameObjectCollection.New(BattleResourceName.BornAreaEmptySign)
	self._placeSignCollection = BattleGameObjectCollection.New(BattleResourceName.BornAreaPlaceSign)
end

function BattleCampAdjustment:onStart()
	self._boardMgr = self.flow.boardMgr or false
	self._boardModel = self.flow.boardModel or false
	self._settingModel = self.flow.settingModel or false
	self._resMgr = self.flow.resMgr or false
end

function BattleCampAdjustment:onClear()
	self:_setEvent(false)

	self._boardMgr = false
	self._boardModel = false
	self._settingModel = false
	self._resMgr = false

	self:_destroyBornAreaSign()
	BattleCampAdjustmentModel.instance:clear()
end

function BattleCampAdjustment:beginCampAdjustment()
	self:_setEvent(true)
	BattleCampAdjustmentModel.instance:buildAvailableHeroMOList()
	self:_onUpdateBornAreaStatus()
end

function BattleCampAdjustment:endCampAdjustment()
	self:_setEvent(false)
	self:_destroyBornAreaSign()
	self._boardMgr:resetAllSign()
	BattleCampAdjustmentModel.instance:clear()
end

function BattleCampAdjustment:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.Adjustment_OnBoardUsedUpdate, self._onUpdateBornAreaStatus, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.Adjustment_OnBoardUsedUpdate, self._onUpdateBornAreaStatus, self)
	end
end

function BattleCampAdjustment:_destroyBornAreaSign()
	self._emptySignCollection:clear()
	self._placeSignCollection:clear()
end

function BattleCampAdjustment:_onUpdateBornAreaStatus()
	self:_destroyBornAreaSign()

	local settingModel = self._settingModel
	local bornUnionIndexList = settingModel:getBornUnionIndexList()
	local isDebug = self:_isDebug(bornUnionIndexList)

	for i, unionIndex in ipairs(bornUnionIndexList) do
		local position = self._boardMgr:getCellPosition(unionIndex)

		if BattleCampAdjustmentModel.instance:isCellIndexUsed(unionIndex) then
			local go = self._placeSignCollection:createInstance(signsRoot)

			if isDebug then
				goutil.setActive(goutil.findChild(go, "fangxing"), false)
			end

			Astral.TransformUtil.SetPos(go.transform, position.x, position.y + BattleConst.YOffsetBornArea, position.z)
		else
			local go = self._emptySignCollection:createInstance(signsRoot)

			if isDebug then
				goutil.setActive(goutil.findChild(go, "fangxing"), false)
			end

			Astral.TransformUtil.SetPos(go.transform, position.x, position.y + BattleConst.YOffsetBornArea, position.z)
		end
	end
end

function BattleCampAdjustment:_isDebug(bornUnionIndexList)
	if not enableDebug then
		return false
	end

	return #bornUnionIndexList >= 10
end

return BattleCampAdjustment
