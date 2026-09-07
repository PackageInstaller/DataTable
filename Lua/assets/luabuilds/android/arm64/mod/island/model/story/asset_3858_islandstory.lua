local IslandStory = class("IslandStory")

IslandStory.MODE_BUBBLE = 9
IslandStory.MODE_DIALOGUE = 10

function IslandStory:GetStoryStepCls()
	return ({
		[IslandStory.MODE_BUBBLE] = BubbleStep,
		[IslandStory.MODE_DIALOGUE] = Dialogue3DStep
	})[self]
end

function IslandStory:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.id = arg_2_1.id
	self.unitList = arg_2_2 or {}
	self.lockOp = defaultValue(arg_2_1.lockOp, false)
	self.unitMap = arg_2_1.map or {}
	self.lookWeight = arg_2_1.look_weight or {}

	assert(arg_2_1.map, "请确保配置文件存在map字段" .. arg_2_1.id)

	self.useUISpace = defaultValue(arg_2_1.useUISpace, true)
	self.steps = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.scripts or {}) do
		table.insert(self.steps, (IslandStory.GetStoryStepCls(arg_2_3):New(self)))
	end

	for iter_2_2, iter_2_3 in ipairs(self.steps) do
		local var_2_0, var_2_1 = self:GetUnitIdFromCharaId(iter_2_3.characterId)

		iter_2_3.unitId = var_2_0
		iter_2_3.unitType = var_2_1
	end

	local var_2_2 = arg_2_1.speed

	if not arg_2_1.speed then
		var_2_2 = getProxy(SettingsProxy):GetStorySpeed()
		var_2_2 = var_2_2 or 0
	end

	self.speedData = var_2_2
	self.fadeIn = arg_2_1.fadeIn or 0
	self.fadeOut = arg_2_1.fadeOut or 0
	self.branchCode = nil
	self.isAuto = false
	self.speed = 0
	self.skipFlag = false
	self.followOffset = arg_2_1.followOffset
	self.defultFollowOffset = Vector3(0, 1, 5)
	self.soloCamDir = defaultValue(arg_2_1.cam_dir, 0) == 0

	return
end

function IslandStory:ContainerPlayer()
	for iter_3_0, iter_3_1 in ipairs(self.steps) do
		if not iter_3_1.characterId or iter_3_1.characterId == 0 then
			return true
		end
	end

	return false
end

function IslandStory:IsFacingWhenSolo()
	return self.soloCamDir
end

function IslandStory:LastStepIsTimeline()
	if isa(self.steps[#self.steps], Dialogue3DStep) then
		return self.steps[#self.steps]:IsTimeline()
	else
		return false
	end

	return
end

function IslandStory:GetFadeInTime()
	return self.fadeIn
end

function IslandStory:GetFadeOutTime()
	return self.fadeOut
end

function IslandStory:GetDefultFollowOffset()
	return self.defultFollowOffset
end

function IslandStory:ShouldSetCamOffset()
	return self.followOffset ~= nil
end

function IslandStory:GetFollowOffset()
	if not self:ShouldSetCamOffset() then
		return nil
	end

	return BuildVector3(self.followOffset)
end

function IslandStory:SetAutoPlay()
	self.isAuto = true

	self:SetPlaySpeed(self.speedData)

	return
end

function IslandStory:StopAutoPlay()
	self.isAuto = false

	self:ResetSpeed()

	return
end

function IslandStory:GetAutoPlayFlag()
	return self.isAuto
end

function IslandStory:UpdatePlaySpeed()
	local var_14_0 = getProxy(SettingsProxy):GetStorySpeed()

	var_14_0 = var_14_0 or 0

	self:SetPlaySpeed(var_14_0)

	return
end

function IslandStory:GetPlaySpeed()
	return self.speed
end

function IslandStory:SetPlaySpeed(arg_16_1)
	self.speed = arg_16_1

	return
end

function IslandStory:ResetSpeed()
	self.speed = 0

	return
end

function IslandStory:GetTriggerDelayTime()
	local var_18_0 = table.indexof(Story.STORY_AUTO_SPEED, self.speed)

	if var_18_0 then
		return Story.TRIGGER_DELAY_TIME[var_18_0] or 0
	end

	return 0
end

function IslandStory:IsSkipAll()
	return self.skipFlag == true
end

function IslandStory:MarkSkipAll()
	self.skipFlag = true

	return
end

function IslandStory:UnMarkSkipAll()
	self.skipFlag = false

	return
end

function IslandStory:GetStepByIndex(arg_22_1)
	if not self.steps[arg_22_1] or self.branchCode and not self.steps[arg_22_1]:IsSameBranch(self.branchCode) then
		return nil
	end

	return self.steps[arg_22_1]
end

function IslandStory:SetBranchCode(arg_23_1)
	self.branchCode = arg_23_1

	return
end

function IslandStory:IsUseUISpace()
	return self.useUISpace
end

function IslandStory:GetUnitIdFromCharaId(arg_25_1)
	if not arg_25_1 or arg_25_1 == 0 then
		return 0, IslandConst.UNIT_LIST_PLAYER
	end

	for iter_25_0, iter_25_1 in ipairs(self.unitMap) do
		if iter_25_1[1] == arg_25_1 then
			return iter_25_1[2], iter_25_1[3] or IslandConst.UNIT_LIST_OBJ
		end
	end

	return 0, IslandConst.UNIT_LIST_PLAYER
end

function IslandStory:GetLookGroup()
	local var_26_0 = {}
	local var_26_1 = {}
	local var_26_2 = {}

	for iter_26_0, iter_26_1 in ipairs(self.unitMap) do
		local var_26_3 = self.lookWeight[iter_26_0] or {}
		local var_26_4 = {
			id = iter_26_1[2]
		}

		var_26_4.type = iter_26_1[3] or IslandConst.UNIT_LIST_OBJ

		local var_26_5 = self:GetRole(var_26_4)

		if var_26_5 then
			table.insert(var_26_0, var_26_5)
			table.insert(var_26_1, var_26_3[1] or 1)
			table.insert(var_26_2, var_26_3[2] or 0)
		end
	end

	local var_26_8 = self:GetPlayerRole()

	if not table.contains(var_26_0, var_26_8) then
		table.insert(var_26_0, var_26_8)

		local var_26_9 = self.lookWeight[#self.lookWeight] or {}

		table.insert(var_26_1, var_26_9[1] or 1)
		table.insert(var_26_2, var_26_9[2] or 0)
	end

	return var_26_0, var_26_1, var_26_2
end

function IslandStory:GetPlayerRole()
	for iter_27_0, iter_27_1 in ipairs(self.unitList) do
		if isa(iter_27_1, IslandPlayerUnit) then
			return iter_27_1._go
		end
	end

	return nil
end

function IslandStory:GetRole(arg_28_1)
	if not arg_28_1.id or arg_28_1.id == 0 then
		return self:GetPlayerRole()
	end

	for iter_28_0, iter_28_1 in ipairs(self.unitList) do
		if arg_28_1.id and iter_28_1.id == arg_28_1.id and iter_28_1.unitType == arg_28_1.type then
			return iter_28_1._go
		end
	end

	return nil
end

function IslandStory:GetUnitList()
	return self.unitList
end

function IslandStory:IsFreeOp()
	return not self.lockOp
end

return IslandStory
