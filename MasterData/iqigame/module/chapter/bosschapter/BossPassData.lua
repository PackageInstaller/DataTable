-- chunkname: @IQIGame\\Module\\Chapter\\BossChapter\\BossPassData.lua

local BossPassData = {
	isUnLock = false,
	cid = 0
}

function BossPassData.New(cid, Status)
	local obj = Clone(BossPassData)

	obj:RefreshData(cid, Status)

	return obj
end

function BossPassData:RefreshData(cid, Status)
	self.cid = cid
	self.Status = Status
	self.isUnLock = ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(self:GetCfg().UnlockConditionId))
end

function BossPassData:GetCfg()
	return CfgBossStageTable[self.cid]
end

return BossPassData
