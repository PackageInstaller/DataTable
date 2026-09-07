local CourtYardFurniture = class("CourtYardFurniture", import("..map.CourtYardDepthItem"))

CourtYardFurniture.STATE_IDLE = 1
CourtYardFurniture.STATE_DRAG = 2
CourtYardFurniture.STATE_INTERACT = 3
CourtYardFurniture.STATE_TOUCH_PREPARE = 4
CourtYardFurniture.STATE_TOUCH = 5
CourtYardFurniture.STATE_PLAY_MUSIC = 6
CourtYardFurniture.STATE_STOP_MUSIC = 7

function CourtYardFurniture:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_2.id
	self.configId = arg_1_2.configId or self.id
	self.config = pg.furniture_data_template[self.configId]

	CourtYardFurniture.super.Ctor(self, arg_1_1, self.id, self.config.size[1], self.config.size[2])

	self.date = arg_1_2.date or 0
	self.selectedFlag = false
	self.slots = {}

	self:InitSlots()

	self.musicDatas = {}
	self.musicData = nil

	self:InitMusicData()

	self.state = CourtYardFurniture.STATE_IDLE

	return
end

function CourtYardFurniture:InitSlots()
	if self:IsSpine() then
		table.insert(self.slots, CourtYardFurnitureSpineSlot.New(1, self.config.spine, self.config.spine_combine_action_replace, self.host))

		if type(self.config.spine_extra) == "table" then
			for iter_2_0, iter_2_1 in ipairs(self.config.spine_extra) do
				table.insert(self.slots, CourtYardFurnitureSpineSlot.New(iter_2_0 + 1, {
					{},
					[3] = self.config.spine[3],
					[4] = iter_2_1[1],
					[5] = iter_2_1[2],
					[6] = iter_2_1[3]
				}, self.config.spine_combine_action_replace, self.host))
			end
		end

		if type(self.config.followBone) == "table" then
			if type(self.config.followBone[1]) == "table" then
				for iter_2_2, iter_2_3 in ipairs(self.config.followBone) do
					if self.slots[iter_2_2] then
						self.slots[iter_2_2]:SetFollower(iter_2_3)
					end
				end
			elseif type(self.config.followBone[1]) == "string" then
				self.slots[1]:SetFollower(self.config.followBone)
			end
		elseif type(self.config.animator) == "table" then
			for iter_2_4, iter_2_5 in ipairs(self.slots) do
				iter_2_5:SetAnimators(self.config.animator)
			end
		end

		if type(self.config.spine_action_replace) == "table" then
			for iter_2_6, iter_2_7 in ipairs(self.slots) do
				iter_2_7:SetSubstitute(self.config.spine_action_replace)
			end
		end
	elseif type(self.config.interAction) == "table" then
		for iter_2_8, iter_2_9 in ipairs(self.config.interAction) do
			table.insert(self.slots, CourtYardFurnitureSlot.New(iter_2_8, iter_2_9, self.config.spine_combine_action_replace, self.host))
		end
	end

	return
end

function CourtYardFurniture:GetLevel()
	return self.config.level
end

function CourtYardFurniture:_InitMusicData(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = type(arg_4_3) == "table" and arg_4_3 or {
		arg_4_3
	}

	for iter_4_0, iter_4_1 in ipairs(type(arg_4_2) == "table" and arg_4_2 or {
		arg_4_2
	}) do
		table.insert(self.musicDatas, {
			voice = iter_4_1,
			voiceType = arg_4_1,
			action = var_4_0[iter_4_0],
			effect = arg_4_4
		})
	end

	return
end

function CourtYardFurniture:InitMusicData()
	if self.config.can_trigger[1] == 3 then
		self:_InitMusicData(1, self.config.can_trigger[2][1], self.config.can_trigger[2][2], self.config.can_trigger[2][3])
		self:_InitMusicData(2, self.config.can_trigger[3][1], self.config.can_trigger[3][2], self.config.can_trigger[3][3])
	else
		self:_InitMusicData(self.config.can_trigger[1], self.config.can_trigger[2], self.config.can_trigger[3], self.config.can_trigger[4])
	end

	return
end

function CourtYardFurniture:Init(arg_6_1, arg_6_2)
	self:SetPosition(arg_6_1)
	self:SetDir(arg_6_2)

	return
end

function CourtYardFurniture:DisableRotation()
	return self.config.can_rotate ~= 0 or self:IsType(Furniture.TYPE_WALL) or self:IsType(Furniture.TYPE_WALL_MAT)
end

function CourtYardFurniture:IsType(arg_8_1)
	return self.config.type == arg_8_1
end

function CourtYardFurniture:IsMusicalInstruments()
	return self:IsType(Furniture.TYPE_LUTE)
end

function CourtYardFurniture:IsRandomSlotType()
	return self:IsType(Furniture.TYPE_RANDOM_SLOT)
end

function CourtYardFurniture:RawGetOffset()
	return Vector3(self.config.offset[1], self.config.offset[2], 0)
end

function CourtYardFurniture:SetPosition(arg_12_1)
	CourtYardFurniture.super.SetPosition(self, arg_12_1)
	self:DispatchEvent(CourtYardEvent.FURNITURE_POSITION_CHANGE, arg_12_1, self:GetOffset())

	return
end

function CourtYardFurniture:UpdateOpFlag(arg_13_1)
	CourtYardFurniture.super.UpdateOpFlag(self, arg_13_1)
	self:DispatchEvent(CourtYardEvent.FURNITURE_OP_FLAG_CHANGE, self.opFlag)

	return
end

function CourtYardFurniture:InActivityRange(arg_14_1)
	local var_14_0 = self:GetHost():GetStorey():GetRange()

	return arg_14_1.x < var_14_0.x and arg_14_1.y < var_14_0.y and arg_14_1.x >= 0 and arg_14_1.y >= 0
end

function CourtYardFurniture:GetObjType()
	return CourtYardConst.OBJ_TYPE_COMMOM
end

function CourtYardFurniture:GetDeathType()
	return CourtYardConst.DEPTH_TYPE_FURNITURE
end

function CourtYardFurniture:GetType()
	return self.config.type
end

function CourtYardFurniture:GetPicture()
	return self.config.picture
end

function CourtYardFurniture:IsOverlap(arg_19_1)
	return _.any(self:GetArea(), function(arg_20_0)
		return arg_20_0 == arg_19_1
	end)
end

function CourtYardFurniture:Rotate()
	CourtYardFurniture.super.SetDir(self, self.dir == 1 and 2 or 1)
	self:DispatchEvent(CourtYardEvent.ROTATE_FURNITURE, self.dir)

	return
end

function CourtYardFurniture:GetSize()
	return self.sizeX, self.sizeY
end

function CourtYardFurniture:GetArchMask()
	return self.config.picture .. "_using"
end

function CourtYardFurniture:HasDescription()
	return #self.config.can_trigger > 0 and self.config.can_trigger[1] > 0
end

function CourtYardFurniture:ExistVoice()
	return self.config.can_trigger[2] ~= nil, self.config.can_trigger[1]
end

function CourtYardFurniture:GetIcon()
	return self.config.icon
end

function CourtYardFurniture:GetName()
	return self.config.name
end

function CourtYardFurniture:GetAddDate()
	if self.date > 0 then
		return pg.TimeMgr.GetInstance():STimeDescS(self.date, "%Y/%m/%d")
	end

	return
end

function CourtYardFurniture:GetComfortable()
	return self.config.comfortable
end

function CourtYardFurniture:GetDescription()
	return self.config.describe
end

function CourtYardFurniture:GetAddMode()
	return self.config.gain_by
end

function CourtYardFurniture:GetGametipType()
	return ({
		i18n("word_wallpaper"),
		i18n("word_furniture"),
		i18n("word_decorate"),
		i18n("word_floorpaper"),
		i18n("word_mat"),
		i18n("word_wall"),
		i18n("word_collection"),
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		i18n("word_collection")
	})[self:GetType()]
end

function CourtYardFurniture:CanTouch()
	return self.config.spine and self.config.spine[1] and self.config.spine[1][3] ~= nil
end

function CourtYardFurniture:GetTouchAction()
	if self:CanTouch() then
		local var_34_0 = {}

		table.insert(var_34_0, self.config.spine[1][3][1])

		for iter_34_0, iter_34_1 in ipairs(self.config.spine[1][3][3] or {}) do
			table.insert(var_34_0, iter_34_1)
		end

		return var_34_0[math.random(1, #var_34_0)], self.config.spine[1][3][2]
	end

	return
end

function CourtYardFurniture:GetTouchPrepareAction()
	if self:CanTouch() then
		return self.config.spine[1][3][6]
	end

	return
end

function CourtYardFurniture:GetTouchBg()
	if self:CanTouch() then
		return self.config.spine[1][3][7]
	end

	return
end

function CourtYardFurniture:TriggerTouchDefault()
	if self:CanTouch() and self.config.spine[1][3][8] and self.config.spine[1][3][8] > 0 then
		return true
	end

	return false
end

function CourtYardFurniture:GetTouchSound()
	if self:CanTouch() then
		if type(self.config.spine[1][3][4]) == "table" then
			return self.config.spine[1][3][4][math.random(1, #self.config.spine[1][3][4])]
		else
			return self.config.spine[1][3][4]
		end
	end

	return
end

function CourtYardFurniture:GetTouchEffect()
	if self:CanTouch() then
		return self.config.spine[1][3][5]
	end

	return
end

function CourtYardFurniture:IsTouchState()
	return self.state == CourtYardFurniture.STATE_TOUCH or self.state == CourtYardFurniture.STATE_TOUCH_PREPARE
end

function CourtYardFurniture:IsDragingState()
	return self.state == CourtYardFurniture.STATE_DRAG
end

function CourtYardFurniture:IsSpine()
	return type(self.config.spine) == "table"
end

function CourtYardFurniture:GetFirstSlot()
	return self.slots[1]
end

function CourtYardFurniture:AnySlotIsLoop()
	for iter_44_0, iter_44_1 in pairs(self.slots) do
		if iter_44_1.loop then
			return true
		end
	end

	return false
end

function CourtYardFurniture:GetMaskNames()
	local var_45_0 = {}

	for iter_45_0, iter_45_1 in ipairs(self.slots) do
		local var_45_1 = iter_45_1:GetMask()

		if var_45_1 then
			var_45_0[iter_45_1.id] = var_45_1
		end
	end

	return var_45_0
end

function CourtYardFurniture:IsMultiMask()
	return not self:IsSpine() and table.getCount((self:GetMaskNames())) > 0 and self:GetSlotCnt() > 1
end

function CourtYardFurniture:GetBodyMasks()
	local var_47_0 = {}

	for iter_47_0, iter_47_1 in ipairs(self.slots) do
		local var_47_1 = iter_47_1:GetBodyMask()

		if var_47_1 then
			var_47_0[iter_47_1.id] = var_47_1
		end
	end

	return var_47_0
end

function CourtYardFurniture:GetAnimators()
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in ipairs(self.slots) do
		for iter_48_2, iter_48_3 in pairs(iter_48_1:GetAnimators()) do
			table.insert(var_48_0, iter_48_3)
		end
	end

	return var_48_0
end

function CourtYardFurniture:GetAnimatorMask()
	if not self.config.animator then
		return nil
	end

	local var_49_0 = self.config.animator[3]

	if self.config.animator[3] then
		return {
			size = Vector2(var_49_0[1][1], var_49_0[1][2]),
			offset = Vector2(var_49_0[2][1], var_49_0[2][2])
		}
	end

	return
end

function CourtYardFurniture:CanInterAction(arg_50_1)
	return _.any(self.slots, function(arg_51_0)
		return arg_51_0:IsEmpty()
	end) and not self:IsPlayMusicState() and (#self.config.interAction_group == 0 or _.any(self.config.interAction_group, function(arg_52_0)
		return arg_50_1:GetGroupID() == arg_52_0
	end))
end

function CourtYardFurniture:IsPlayMusicState()
	return self.state == CourtYardFurniture.STATE_PLAY_MUSIC
end

function CourtYardFurniture:GetInteractionSlot()
	if self:IsRandomSlotType() then
		local var_54_0 = {}

		for iter_54_0, iter_54_1 in ipairs(self.slots) do
			if iter_54_1:IsEmpty() then
				table.insert(var_54_0, iter_54_1)
			end
		end

		return var_54_0[math.random(1, #var_54_0)]
	else
		return _.detect(self.slots, function(arg_55_0)
			return arg_55_0:IsEmpty()
		end)
	end

	return
end

function CourtYardFurniture:_ChangeState(arg_56_1)
	self.state = arg_56_1

	self:DispatchEvent(CourtYardEvent.FURNITURE_STATE_CHANGE, arg_56_1)

	return
end

function CourtYardFurniture:ChangeState(arg_57_1)
	if self:IsPlayMusicState() and arg_57_1 ~= CourtYardFurniture.STATE_STOP_MUSIC then
		return
	end

	if self:IsInteractionState() then
		return
	end

	if arg_57_1 == CourtYardFurniture.STATE_TOUCH and self:GetTouchPrepareAction() then
		self:_ChangeState(CourtYardFurniture.STATE_TOUCH_PREPARE)
	elseif arg_57_1 == CourtYardFurniture.STATE_PLAY_MUSIC then
		local var_57_0 = _.select(self.musicDatas, function(arg_58_0)
			return arg_58_0.voiceType == 2
		end)

		if #var_57_0 > 0 then
			self.musicData = var_57_0[math.random(1, #var_57_0)]

			self:_ChangeState(arg_57_1)
		end
	elseif arg_57_1 == CourtYardFurniture.STATE_STOP_MUSIC then
		self:_ChangeState(CourtYardFurniture.STATE_IDLE)

		self.musicData = nil
	else
		self:_ChangeState(arg_57_1)
	end

	return
end

function CourtYardFurniture:IsInteractionState()
	return self.state == CourtYardFurniture.STATE_INTERACT
end

function CourtYardFurniture:WillInteraction(arg_60_1)
	self:DispatchEvent(CourtYardEvent.FURNITURE_WILL_INTERACTION, arg_60_1)

	return
end

function CourtYardFurniture:StartInteraction(arg_61_1)
	local var_61_0 = {}

	_.each(self.slots, function(arg_62_0)
		if arg_62_0.id ~= arg_61_1.id and arg_62_0:IsUsing() then
			table.insert(var_61_0, arg_62_0)
			self:DispatchEvent(CourtYardEvent.FURNITURE_STOP_INTERACTION, arg_62_0)
		end

		return
	end)

	if #var_61_0 > 0 then
		self:_ChangeState(CourtYardFurniture.STATE_IDLE)
	end

	self:_ChangeState(CourtYardFurniture.STATE_INTERACT)

	if #var_61_0 > 0 then
		arg_61_1:OnStart()
	end

	for iter_61_0, iter_61_1 in ipairs(var_61_0) do
		iter_61_1:OnStart()
		self:DispatchEvent(CourtYardEvent.FURNITURE_START_INTERACTION, iter_61_1)
	end

	self:DispatchEvent(CourtYardEvent.FURNITURE_START_INTERACTION, arg_61_1)

	return
end

function CourtYardFurniture:OnPreheatActionEnd()
	return
end

function CourtYardFurniture:UpdateInteraction(...)
	self:DispatchEvent(CourtYardEvent.FURNITURE_UPDATE_INTERACTION, ...)

	return
end

function CourtYardFurniture:AnySlotIsUsing()
	return _.any(self.slots, function(arg_66_0)
		return arg_66_0:IsUsing()
	end)
end

function CourtYardFurniture:ClearInteraction(arg_67_1)
	local var_67_0 = _.select(self.slots, function(arg_68_0)
		return arg_68_0.id ~= arg_67_1.id and arg_68_0:IsUsing()
	end)

	for iter_67_0, iter_67_1 in ipairs(var_67_0) do
		iter_67_1:Reset()
	end

	if #var_67_0 <= 0 then
		self:_ChangeState(CourtYardFurniture.STATE_IDLE)
	end

	onNextTick(function()
		self:DispatchEvent(CourtYardEvent.FURNITURE_STOP_INTERACTION, arg_67_1)

		return
	end)

	return
end

function CourtYardFurniture:RefreshState()
	local var_70_0 = _.select(self.slots, function(arg_71_0)
		return arg_71_0:IsUsing()
	end)

	if #var_70_0 <= 0 then
		self:_ChangeState(CourtYardFurniture.STATE_IDLE)
	else
		for iter_70_0, iter_70_1 in ipairs(var_70_0) do
			iter_70_1:OnStart()
		end
	end

	return
end

function CourtYardFurniture:GetUsingSlots()
	local var_72_0 = {}

	for iter_72_0, iter_72_1 in ipairs(self.slots) do
		if iter_72_1:IsUsing() then
			table.insert(var_72_0, iter_72_1)
		end
	end

	return var_72_0
end

function CourtYardFurniture:GetSlotCnt()
	return #self.slots
end

function CourtYardFurniture:GetMusicData()
	return self.musicData
end

function CourtYardFurniture:GetInterActionBgm()
	local var_75_0 = type(self.config.interaction_bgm)

	if var_75_0 == "string" then
		return self.config.interaction_bgm, 0
	elseif var_75_0 == "table" then
		return self.config.interaction_bgm[2], self.config.interaction_bgm[1]
	else
		return nil
	end

	return
end

function CourtYardFurniture:CanClickWhenExitEditMode()
	return self:HasDescription() or self:CanTouch()
end

function CourtYardFurniture:Dispose()
	CourtYardFurniture.super.Dispose(self)

	for iter_77_0, iter_77_1 in ipairs(self:GetUsingSlots()) do
		iter_77_1:Stop()
	end

	return
end

function CourtYardFurniture:ToTable()
	local var_78_0 = self:GetPosition()
	local var_78_1 = {
		id = self.id,
		configId = self.configId,
		dir = self.dir,
		position = var_78_0,
		x = var_78_0.x,
		y = var_78_0.y
	}

	if self.parent then
		var_78_1.parent = self.parent.id or 0
	end

	var_78_1.child = {}

	return var_78_1
end

return CourtYardFurniture
