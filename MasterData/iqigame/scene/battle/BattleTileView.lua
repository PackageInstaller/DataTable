-- chunkname: @IQIGame\\Scene\\Battle\\BattleTileView.lua

local BattleBuffView = require("IQIGame.Scene.Battle.BattleBuffView")
local BattleTileView = {
	fightBattleUnitID = 0,
	tileIndex = 0,
	moveTransformInstanceID = 0,
	battlePos = 0,
	battleUnitID = 0,
	troopType = 0
}

function BattleTileView.New(index, view)
	local obj = Clone(BattleTileView)

	obj:__Init(index, view)

	return obj
end

function BattleTileView:__Init(index, view)
	self.tileIndex = index
	self.gameObject = view

	self.gameObject:SetActive(true)

	self.fightBattleUnitID = 0

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:ShowNormalState()
	self:RefreshTileShowStateWithBattleFightUnitID(0)

	self.buffsViewData = {}
	self.tagPoint = self.gameObject.transform:Find("StabdPoint").gameObject

	self.tagPoint:SetActive(false)

	self.effectRoot = self.gameObject.transform:Find("EffectRoot").gameObject
	self.commonEffectRoot = self.gameObject.transform:Find("CommonEffectRoot").gameObject

	self:__AddListeners()
end

function BattleTileView:__AddListeners()
	return
end

function BattleTileView:__RemoveListeners()
	return
end

function BattleTileView:Dispose()
	self:__RemoveListeners()
	self:Clear()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function BattleTileView:Clear()
	for _buffCid, _buffData in pairs(self.buffsViewData) do
		self:RemoveBuff(_buffCid)
	end
end

function BattleTileView:InitByTileData(battleTileData)
	self.battleTileData = battleTileData
	self.battleUnitID = battleTileData.battleUnitID
	self.battlePos = battleTileData.battlePos
	self.troopType = battleTileData.troopType
	self.fightBattleUnitID = 0

	self.landLayer.gameObject:SetActive(true)
	self.warningLayerFriend.gameObject:SetActive(false)
	self.warningLayerEnemy.gameObject:SetActive(false)
	self.moveLayer.gameObject:SetActive(false)

	self.moveTransformInstanceID = self.moveLayer.gameObject:GetInstanceID()

	for _, _buffData in pairs(battleTileData.buffsData) do
		self:AddBuff(_buffData)
	end
end

function BattleTileView:UpdateTerrainCid(terrainCid)
	local terrainConfig = CfgTerrainTable[terrainCid]
end

function BattleTileView:AddBuff(battleBuffData)
	local buff = self.buffsViewData[battleBuffData.cid]

	if buff ~= nil then
		return
	end

	buff = BattleBuffView.New(battleBuffData, self, Constant.UpdateScope.BattleTile)
	self.buffsViewData[buff.cid] = buff
end

function BattleTileView:UpdateBuff(battleBuffData)
	local buff = self.buffsViewData[battleBuffData.cid]

	if buff == nil then
		return
	end

	buff:Update(battleBuffData.leftCount, battleBuffData.stack)
end

function BattleTileView:TriggerBuff(buffConfigID)
	local buff = self.buffsViewData[buffConfigID]

	if buff == nil then
		logError("TriggerBuff error, buffConfigID " .. buffConfigID)

		return
	end

	buff:Trigger()
end

function BattleTileView:RemoveBuff(buffConfigID)
	local buff = self.buffsViewData[buffConfigID]

	if buff == nil then
		return
	end

	buff:Remove()

	self.buffsViewData[buffConfigID] = nil
end

function BattleTileView:GetHasBuff()
	return self.battleTileData.buffsData ~= nil and table.len(self.battleTileData.buffsData) > 0
end

function BattleTileView:GetMovePointInstanceID()
	return self.moveTransformInstanceID
end

function BattleTileView:RefreshTileShowStateWithBattleFightUnitID(battleUnitID)
	self.fightBattleUnitID = battleUnitID

	local isNoneUnit = false

	if battleUnitID == nil then
		isNoneUnit = true
	end

	if battleUnitID == 0 then
		isNoneUnit = true
	end

	if isNoneUnit then
		self.fightBattleUnitID = 0
	end

	local battleTileData = BattleModule.GetBattleTileDataByUnitID(self.battleUnitID)

	if battleTileData == nil then
		return
	end

	battleTileData:UpdateFightBattleUnitID(self.fightBattleUnitID)
end

function BattleTileView:ShowSkillTargetState(isFriend, isMain)
	local warningSpriteGo = self.warningLayerFriend.gameObject

	if isFriend then
		self.warningLayerEnemy.gameObject:SetActive(false)
	else
		self.warningLayerFriend.gameObject:SetActive(false)

		warningSpriteGo = self.warningLayerEnemy.gameObject
	end

	warningSpriteGo:SetActive(true)

	local spriteRenderer = warningSpriteGo:GetComponent(typeof(UnityEngine.SpriteRenderer))

	if isMain then
		spriteRenderer.color = BattleConstant.BattleTileBlockWarningColor.MainTarget
	else
		spriteRenderer.color = BattleConstant.BattleTileBlockWarningColor.SubTarget
	end
end

function BattleTileView:HideSkillTargetState()
	self.warningLayerEnemy.gameObject:SetActive(false)
	self.warningLayerFriend.gameObject:SetActive(false)
end

function BattleTileView:ShowEnableMoveState(isEnable)
	self.moveLayer.gameObject:SetActive(isEnable)
end

function BattleTileView:ShowSelectState(isSelect)
	self.selectLayer.gameObject:SetActive(isSelect)
end

function BattleTileView:ShowNormalState()
	self.landLayer.gameObject:SetActive(true)
	self.warningLayerFriend.gameObject:SetActive(false)
	self.warningLayerEnemy.gameObject:SetActive(false)
	self.moveLayer.gameObject:SetActive(false)
	self.selectLayer.gameObject:SetActive(false)
	self.moveDisTag.gameObject:SetActive(false)
end

function BattleTileView:SetLandLayerActive(active)
	self.landLayer.gameObject:SetActive(active)
end

function BattleTileView:ShowMoveDisEffect(targetTileIndex)
	if targetTileIndex < 0 then
		self.moveDisTag.gameObject:SetActive(false)

		return
	end

	local diff = targetTileIndex - self.tileIndex
	local angle = BattleConstant.TileMoveDisAngleMap[diff]

	self.moveDisTag.gameObject.transform.eulerAngles = Vector3(0, angle, 0)

	self.moveDisTag.gameObject:SetActive(true)
end

function BattleTileView:SetEffectVisiable(state)
	self.effectRoot:SetActive(state)
	self.commonEffectRoot:SetActive(state)
end

return BattleTileView
