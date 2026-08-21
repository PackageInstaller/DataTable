-- chunkname: @IQIGame\\Module\\Chapter\\EquipChapter\\EquipPassData.lua

local EquipPassData = {
	isUnLock = false,
	cid = 0
}

function EquipPassData.New(cid, Status)
	local obj = Clone(EquipPassData)

	obj:RefreshData(cid, Status)

	return obj
end

function EquipPassData:RefreshData(cid, Status)
	self.cid = cid
	self.Status = Status
	self.isUnLock = ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(self:GetCfg().UnlockConditionId))
end

function EquipPassData:GetCfg()
	return CfgEquipDupStageTable[self.cid]
end

return EquipPassData
