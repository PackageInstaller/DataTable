local MemoryCard = class("MemoryCard")

function MemoryCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tf = arg_1_1.transform
	self.lock = findTF(self.tf, "lock")
	self.txCondition = findTF(self.lock, "condition")
	self.normal = findTF(self.tf, "normal")
	self.txTitle = findTF(self.normal, "title")
	self.txSubtitle = findTF(self.normal, "subtitle")
	self.group = findTF(self.tf, "group")
	self.groupTitle = findTF(self.group, "title")
	self.groupCount = findTF(self.group, "count")
	self.itemIndexTF = findTF(self.tf, "id")

	return
end

function MemoryCard:update(arg_2_1, arg_2_2)
	self.isGroup = arg_2_1
	self.info = arg_2_2

	self:flush()

	return
end

function MemoryCard:flush()
	setActive(self.lock, false)
	setActive(self.normal, false)
	setActive(self.group, false)

	if self.isGroup then
		setActive(self.group, true)
		setText(self.groupTitle, self.info.title)
		GetImageSpriteFromAtlasAsync("memoryicon/" .. self.info.icon, "", self.group)

		local var_3_0 = 0

		for iter_3_0, iter_3_1 in ipairs(self.info.memories) do
			if pg.memory_template[iter_3_1].is_open ~= 1 then
				if pg.NewStoryMgr.GetInstance():IsPlayed(pg.memory_template[iter_3_1].unlock_pre, true) then
					var_3_0 = var_3_0 + 1
				end
			end
		end

		setText(self.groupCount, var_3_0 .. "/" .. #self.info.memories)
	else
		if self.info.is_open ~= 1 then
			if pg.NewStoryMgr.GetInstance():IsPlayed(self.info.unlock_pre, true) then
				setActive(self.normal, true)
				setText(self.txTitle, self.info.title)
				setText(self.txSubtitle, self.info.subtitle)
				GetImageSpriteFromAtlasAsync("memoryicon/" .. self.info.icon, "", self.normal)

				goto label_3_0
			end
		end

		setActive(self.lock, true)
		setText(self.txCondition, self.info.condition)
	end

	::label_3_0::

	if self.itemIndexTF then
		setActive(self.itemIndexTF, not self.isGroup)

		if not self.isGroup and self.info.index then
			setText(self.itemIndexTF, string.format("%02u", self.info.index))
		end
	end

	return
end

function MemoryCard:clear()
	return
end

return MemoryCard
