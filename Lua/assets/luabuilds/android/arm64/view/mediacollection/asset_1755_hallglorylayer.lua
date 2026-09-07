local HallGloryLayer = class("HallGloryLayer", import(".WorldMediaCollectionSubLayer"))

HallGloryLayer.type = 4

function HallGloryLayer:getUIName()
	return "HallGloryUI"
end

function HallGloryLayer:OnInit()
	HallGloryLayer.super.OnInit(self)

	self.AD = self._tf:Find("AD")
	self.progress = self.AD:Find("progress")
	self.memoryGroupList = self.AD:Find("ItemRect/Content"):GetComponent("LScrollRect")

	function self.memoryGroupList.onInitItem(arg_3_0)
		self:onInitMemoryGroup(arg_3_0)

		return
	end

	function self.memoryGroupList.onUpdateItem(arg_4_0, arg_4_1)
		self:onUpdateMemoryGroup(arg_4_0 + 1, arg_4_1)

		return
	end

	self.memoryGroups = _.map(pg.memory_group.all, function(arg_5_0)
		return pg.memory_group[arg_5_0]
	end)
	self.memories = {}

	self:MemoryFilter()

	self.memoryItems = {}
	self.loader = AutoLoader.New()

	setText(self.AD:Find("progress/Text"), i18n("memory_filter_option_2"))

	return
end

function HallGloryLayer:MemoryFilter()
	table.clear(self.memoryGroups)

	for iter_6_0, iter_6_1 in ipairs(pg.memory_group.all) do
		if pg.memory_group[iter_6_1].type == self.type then
			table.insert(self.memoryGroups, pg.memory_group[iter_6_1])
		end
	end

	self.memories = _.map(self.memoryGroups[1].memories, function(arg_7_0)
		return pg.memory_template[arg_7_0]
	end)
	self.memoryGroupList.enabled = true

	self.memoryGroupList:SetTotalCount(#self.memories / 3, 0)

	self.contextData.memoryGroup = self.memoryGroups[1].id

	setText(self.AD:Find("progress/num"), _.reduce(self.memories, 0, function(arg_8_0, arg_8_1)
		if arg_8_1.is_open ~= 1 then
			if pg.NewStoryMgr.GetInstance():IsPlayed(arg_8_1.unlock_pre, true) then
				arg_8_0 = arg_8_0 + 1
			end
		end

		return arg_8_0
	end) .. "/" .. #self.memories)

	return
end

function HallGloryLayer:onInitMemoryGroup(arg_9_1)
	if self.exited then
		return
	end

	for iter_9_0 = 1, 3 do
		local var_9_0 = tf(arg_9_1):Find("item_" .. iter_9_0)

		onButton(self, var_9_0:Find("BG/play"), function()
			if self.memoryItems[var_9_0] then
				if self.memoryItems[var_9_0].is_open ~= 1 then
					if pg.NewStoryMgr.GetInstance():IsPlayed(self.memoryItems[var_9_0].unlock_pre, true) then
						self:PlayMemory(self.memoryItems[var_9_0])
					end
				end
			end

			return
		end, SOUND_BACK)
	end

	return
end

function HallGloryLayer:onUpdateMemoryGroup(arg_11_1, arg_11_2)
	for iter_11_0 = 1, 3 do
		local var_11_0 = tf(arg_11_2):Find("item_" .. iter_11_0)

		self.memoryItems[var_11_0] = self.memories[(arg_11_1 - 1) * 3 + iter_11_0]

		local var_11_1 = self.memories[(arg_11_1 - 1) * 3 + iter_11_0].ship_group
		local var_11_3 = self.memories[(arg_11_1 - 1) * 3 + iter_11_0].title
		local var_11_4 = self.memories[(arg_11_1 - 1) * 3 + iter_11_0].condition
		local var_11_5 = self.memories[(arg_11_1 - 1) * 3 + iter_11_0].icon
		local var_11_6 = self.memories[(arg_11_1 - 1) * 3 + iter_11_0].year
		local var_11_7 = self.memories[(arg_11_1 - 1) * 3 + iter_11_0].is_open == 1 or pg.NewStoryMgr.GetInstance():IsPlayed(self.memories[(arg_11_1 - 1) * 3 + iter_11_0].unlock_pre, true)
		local var_11_8 = ShipGroup.getDefaultShipConfig(var_11_1)

		setActive(var_11_0:Find("BG/lock"), not var_11_7)
		setActive(var_11_0:Find("BG/headline"), var_11_7)
		setActive(var_11_0:Find("BG/play"), var_11_7)

		if var_11_7 then
			setText(var_11_0:Find("name_bg/name"), var_11_8.name)
			setText(var_11_0:Find("BG/lock/Text"), var_11_4)
			setText(var_11_0:Find("wire/yer"), var_11_6)
			setText(var_11_0:Find("BG/headline/Text"), var_11_3)
		else
			setText(var_11_0:Find("name_bg/name"), var_11_8.name)
			setText(var_11_0:Find("BG/headline/Text"), var_11_3)
			setText(var_11_0:Find("wire/yer"), var_11_6)
		end

		setText(var_11_0:Find("BG/lock/Text"), var_11_4)
		LoadImageSpriteAsync("MemoryIcon/" .. var_11_5, var_11_0:Find("BG/bg/bg/icon"), true)
	end

	return
end

function HallGloryLayer:SetStoryMask(arg_12_1)
	self.memoryMask = arg_12_1

	return
end

function HallGloryLayer:PlayMemory(arg_13_1)
	if arg_13_1.type == 1 then
		local var_13_0 = findTF(self.memoryMask, "pic")

		if string.len(arg_13_1.mask) > 0 then
			setActive(var_13_0, true)

			var_13_0:GetComponent(typeof(Image)).sprite = LoadSprite(arg_13_1.mask)
		else
			setActive(var_13_0, false)
		end

		setActive(self.memoryMask, true)
		pg.NewStoryMgr.GetInstance():Play(arg_13_1.story, function()
			setActive(self.memoryMask, false)

			return
		end, true)
	elseif arg_13_1.type == 2 then
		local var_13_1 = pg.NewStoryMgr.GetInstance():StoryName2StoryId(arg_13_1.story)

		assert(var_13_1 and var_13_1 ~= 0, "Missing Story Stage ID: " .. (arg_13_1.story or "NIL"))
		self:emit(WorldMediaCollectionMediator.BEGIN_STAGE, {
			memory = true,
			system = SYSTEM_PERFORM,
			stageId = var_13_1
		})
	end

	return
end

return HallGloryLayer
