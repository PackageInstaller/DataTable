local PileGameModel = class("PileGameModel")

function PileGameModel:Ctor(arg_1_1)
	self.controller = arg_1_1
	self.items = {}
	self.level = 0
	self.score = 0
	self.failedCnt = 0
	self.deathLine = Vector2(0, 0)
	self.safeLine = Vector2(0, 0)
	self.highestScore = 0
	self.screen = Vector2(0, 0)
	self.maxFailedCnt = PileGameConst.MAX_FAILED_CNT

	return
end

function PileGameModel:NetData(arg_2_1)
	self.highestScore = arg_2_1.highestScore or 0
	self.screen = Vector2(arg_2_1.screen.x, arg_2_1.screen.y)

	return
end

function PileGameModel:UpdateHighestScore()
	if self.score > self.highestScore then
		self.highestScore = self.score
	end

	return
end

function PileGameModel:RandomPile()
	return PileGameConst.Prefabs[math.random(1, #PileGameConst.Prefabs)]
end

function PileGameModel:AddHeadPile()
	return self:AddPile(PileGameConst.HEAD)
end

function PileGameModel:AddPileByRandom()
	return self:AddPile((self:RandomPile()))
end

function PileGameModel:AddPile(arg_7_1)
	self.level = self.level + 1

	local var_7_0 = {
		onTheMove = false,
		gname = arg_7_1.name,
		name = self.level,
		position = Vector3(0, PileGameConst.START_Y, 0),
		leftMaxPosition = Vector3(-PileGameConst.MAX_SLIDE_DISTANCE, PileGameConst.START_Y, 0),
		rightMaxPosition = Vector3(PileGameConst.MAX_SLIDE_DISTANCE, PileGameConst.START_Y, 0),
		speed = self:GetSpeed(),
		dropSpeed = PileGameConst.DROP_SPEED,
		sizeDelta = Vector2(arg_7_1.size[1], arg_7_1.size[2]),
		pivot = PileGameConst.ITEM_PIVOT,
		collider = {
			offset = Vector2(arg_7_1.boundary[1], arg_7_1.boundary[2]),
			sizeDelta = Vector2(arg_7_1.boundary[3], arg_7_1.boundary[4])
		}
	}

	var_7_0.speActionCount = arg_7_1.speActionCount or 0

	table.insert(self.items, var_7_0)

	return var_7_0
end

function PileGameModel:GetSpeed()
	return PileGameConst.SLIDE_SPEED * (1 + math.floor(self.level / PileGameConst.SLIDE_GROWTH[1]) * PileGameConst.SLIDE_GROWTH[2])
end

function PileGameModel:AddGround()
	self.ground = {
		position = Vector3(0, -self.screen.y / 2, 0),
		pivot = PileGameConst.GROUND_PIVOT,
		sizeDelta = PileGameConst.GROUND_SIZE
	}

	return
end

function PileGameModel:AddDeathLineRight()
	self.deathLine.x = -PileGameConst.DEATH_LINE_DISTANCE

	return
end

function PileGameModel:AddDeathLineLeft()
	self.deathLine.y = PileGameConst.DEATH_LINE_DISTANCE

	return
end

function PileGameModel:AddSafeLineRight()
	self.safeLine.x = -PileGameConst.SAFE_LINE_DISTANCE

	return
end

function PileGameModel:AddSafeLineLeft()
	self.safeLine.y = PileGameConst.SAFE_LINE_DISTANCE

	return
end

function PileGameModel:IsStopDrop(arg_14_1)
	return self:IsOnGround(arg_14_1) or self:OnPrevItem(arg_14_1)
end

function PileGameModel:IsOnGround(arg_15_1)
	return arg_15_1.position.y <= self.ground.position.y
end

function PileGameModel:GetIndex()
	return #self.items
end

function PileGameModel:OnPrevItem(arg_17_1)
	if #self.items - 1 > 0 then
		return self:IsOverlap(arg_17_1, self.items[#self.items - 1])
	end

	return
end

function PileGameModel:IsOverTailItem(arg_18_1)
	if self.items[#self.items - 1] then
		return self:IsOverItem(arg_18_1, self.items[#self.items - 1])
	end

	return false
end

function PileGameModel:IsOverItem(arg_19_1, arg_19_2)
	return arg_19_2.position.y + (0.5 - arg_19_2.pivot.y) * arg_19_2.sizeDelta.y + arg_19_2.collider.offset.y + arg_19_2.collider.sizeDelta.y / 2 >= Vector2(arg_19_1.position.x + (0.5 - arg_19_1.pivot.x) * arg_19_1.sizeDelta.x + arg_19_1.collider.offset.x, arg_19_1.position.y + (0.5 - arg_19_1.pivot.y) * arg_19_1.sizeDelta.y + arg_19_1.collider.offset.y).y - arg_19_1.collider.sizeDelta.y / 2
end

function PileGameModel:IsOverlap(arg_20_1, arg_20_2)
	if self:IsOverItem(arg_20_1, arg_20_2) then
		local var_20_0 = Vector2(arg_20_1.position.x + (0.5 - arg_20_1.pivot.x) * arg_20_1.sizeDelta.x + arg_20_1.collider.offset.x, arg_20_1.position.y + (0.5 - arg_20_1.pivot.y) * arg_20_1.sizeDelta.y + arg_20_1.collider.offset.y)
		local var_20_1 = Vector2(arg_20_2.position.x + (0.5 - arg_20_2.pivot.x) * arg_20_2.sizeDelta.x + arg_20_2.collider.offset.x - arg_20_2.collider.sizeDelta.x / 2, arg_20_2.position.x + (0.5 - arg_20_2.pivot.x) * arg_20_2.sizeDelta.x + arg_20_2.collider.offset.x + arg_20_2.collider.sizeDelta.x / 2)

		return var_20_0.x >= var_20_1.x and var_20_0.x <= var_20_1.y
	end

	return
end

function PileGameModel:CanDropOnPrev(arg_21_1)
	if #self.items - 1 > 0 then
		local var_21_0 = Vector2(arg_21_1.position.x + (0.5 - arg_21_1.pivot.x) * arg_21_1.sizeDelta.x + arg_21_1.collider.offset.x, arg_21_1.position.y + (0.5 - arg_21_1.pivot.y) * arg_21_1.sizeDelta.y + arg_21_1.collider.offset.y)
		local var_21_1 = self.items[#self.items - 1].position.x + (0.5 - self.items[#self.items - 1].pivot.x) * self.items[#self.items - 1].sizeDelta.x + self.items[#self.items - 1].collider.offset.x
		local var_21_2 = Vector2(var_21_1 - self.items[#self.items - 1].collider.sizeDelta.x / 2, var_21_1 + self.items[#self.items - 1].collider.sizeDelta.x / 2)

		return var_21_0.x >= var_21_2.x and var_21_0.x <= var_21_2.y
	end

	return
end

function PileGameModel:AddFailedCnt()
	self.failedCnt = self.failedCnt + 1

	return
end

function PileGameModel:RemoveTailItem()
	table.remove(self.items, #self.items)

	return
end

function PileGameModel:AddScore()
	self.score = self.score + 1

	return
end

function PileGameModel:IsMaxfailedCnt()
	return self.maxFailedCnt == self.failedCnt
end

function PileGameModel:IsOverDeathLine(arg_26_1)
	return arg_26_1.position.x - arg_26_1.collider.sizeDelta.x / 2 <= self.deathLine.x or arg_26_1.position.x + arg_26_1.collider.sizeDelta.x / 2 >= self.deathLine.y
end

function PileGameModel:ShouldSink()
	return self:GetIndex() == PileGameConst.SINK_LEVEL + 1
end

function PileGameModel:GetPrevItem(arg_28_1)
	arg_28_1 = arg_28_1 - 1

	return self.items[arg_28_1]
end

function PileGameModel:GetNextPos(arg_29_1)
	local var_29_0 = self.items[arg_29_1]
	local var_29_1 = self:GetPrevItem(arg_29_1)

	return Vector3(var_29_0.position.x, var_29_1 and var_29_1.position.y + var_29_1.sizeDelta.y or var_29_0.position.y - var_29_0.sizeDelta.y, 0)
end

function PileGameModel:IsExceedingTheHighestScore()
	return self.score - self.highestScore == 1
end

function PileGameModel:RemoveFirstItem()
	return table.remove(self.items, 1)
end

function PileGameModel:GetFirstItem()
	return self.items[1]
end

function PileGameModel:GetTailItem()
	return self.items[#self.items]
end

function PileGameModel:GetDropArea(arg_34_1)
	return (arg_34_1.position.x - arg_34_1.collider.sizeDelta.x / 2 <= self.deathLine.x or arg_34_1.position.x + arg_34_1.collider.sizeDelta.x / 2 >= self.deathLine.y) and PileGameController.DROP_AREA_DANGER or (arg_34_1.position.x - arg_34_1.collider.sizeDelta.x / 2 <= self.safeLine.x or arg_34_1.position.x + arg_34_1.collider.sizeDelta.x / 2 >= self.safeLine.y) and PileGameController.DROP_AREA_WARN or PileGameController.DROP_AREA_SAFE
end

function PileGameModel:GetInitPos()
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(self.items) do
		table.insert(var_35_0, {
			iter_35_1,
			iter_35_1.position.x - (PileGameConst.SHAKE_DIS + self.score * PileGameConst.SHAKE_DIS_RATIO),
			iter_35_1.position.x + (PileGameConst.SHAKE_DIS + self.score * PileGameConst.SHAKE_DIS_RATIO)
		})
	end

	return var_35_0
end

function PileGameModel:Clear()
	self.level = 0
	self.score = 0
	self.failedCnt = 0
	self.items = {}

	return
end

function PileGameModel:Dispose()
	self:Clear()

	return
end

return PileGameModel
