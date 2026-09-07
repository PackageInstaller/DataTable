local PuzzlaView = class("PuzzlaView")
local var_0_1 = 0.3
local var_0_2 = 0
local var_0_3 = 5
local var_0_4 = 4
local var_0_5 = 4
local var_0_6 = {
	3,
	3,
	2,
	4,
	2,
	4,
	2,
	3,
	1,
	3,
	2,
	4,
	1,
	4,
	1,
	3,
	2,
	2,
	3,
	1,
	4,
	1,
	1,
	3,
	3,
	2,
	4,
	4,
	2,
	2,
	3,
	1,
	4,
	1,
	1,
	3,
	2,
	4,
	2,
	4,
	2,
	3,
	3,
	3,
	1,
	4,
	2,
	3,
	1,
	4,
	1,
	3,
	1,
	4,
	2,
	2,
	3,
	1,
	1,
	4,
	2,
	4,
	2,
	3,
	3,
	1,
	4,
	2,
	2,
	3,
	1,
	4,
	4,
	2,
	4,
	1,
	1,
	1,
	3,
	3,
	3,
	2,
	4,
	4,
	2,
	2,
	4,
	1,
	1,
	1,
	3,
	3,
	2,
	4,
	4,
	1,
	3,
	2,
	2,
	2,
	1,
	1,
	1,
	4
}
local var_0_7 = true
local var_0_8 = {
	"BOTTOM",
	"TOP",
	"LEFT",
	"RIGHT"
}
local var_0_9 = {
	TOP = 2,
	BOTTOM = 1,
	LEFT = 3,
	RIGHT = 4
}
local var_0_10 = {
	BOTTOM = 2,
	TOP = 1,
	LEFT = 4,
	RIGHT = 3
}

function PuzzlaView:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self.showDesc = arg_1_1.descs
	self.openlist = arg_1_1.list
	self._go = arg_1_1.go
	self._tf = tf(self._go)
	self.fetch = arg_1_1.fetch

	self:load(arg_1_1.bg, arg_1_2)

	self.onFinish = nil

	return
end

function PuzzlaView:load(arg_2_1, arg_2_2)
	self.puzzlaWidth, self.puzzlaHeight = 0, 0
	self.startPosition = Vector2(0, 0)
	self.totalCount = var_0_4 * var_0_5
	self.pics = {}

	for iter_2_0 = 1, self.totalCount do
		self.pics[iter_2_0] = GetSpriteFromAtlas("puzzla/" .. arg_2_1, "pic_" .. iter_2_0)
	end

	if #self.pics > 0 then
		self.puzzlaWidth = self.pics[1].rect.width * var_0_4
		self.puzzlaHeight = self.pics[1].rect.height * var_0_5
		self.startPosition = Vector2(self.puzzlaWidth / 2, self.puzzlaHeight / 2)

		self:init()
	end

	if arg_2_2 then
		arg_2_2()
	end

	return
end

function PuzzlaView:init()
	self.puzzlaItems = {}

	for iter_3_0 = 1, var_0_4 do
		local var_3_0 = {}

		for iter_3_1 = 1, var_0_5 do
			local var_3_1 = table.contains(self.openlist, 1)
			local var_3_3 = self:createItem(self.pics[1], Vector2(iter_3_1, iter_3_0), 1, var_3_1, (not var_3_1 and self.showDesc[1] or nil) and self.showDesc[1])

			var_3_3:setLocalPosition((Vector2((iter_3_1 - 1) * var_3_3.width - self.startPosition.x, self.startPosition.y + (iter_3_0 - 1) * var_3_3.height * -1)))
			table.insert(var_3_0, var_3_3)
		end

		table.insert(self.puzzlaItems, var_3_0)
	end

	if self.fetch then
		self.blockEvent = true

		self:getBlockItem():setHightLight()

		return
	end

	if var_0_7 and #var_0_6 > 0 then
		self:disorganizePuzzla(var_0_6)
	else
		self:disorganizePuzzla()
	end

	return
end

function PuzzlaView:createItem(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	local var_4_0 = GameObject(arg_4_2.x .. "-" .. arg_4_2.y)

	var_4_0:AddComponent(typeof(Image))
	SetParent(var_4_0, self._tf)

	local var_4_1 = PuzzlaItem.New(var_4_0, arg_4_3, arg_4_4, arg_4_5)

	var_4_1:update(arg_4_1, arg_4_2, arg_4_3 == self.totalCount)
	onButton(self, var_4_1._go, function()
		if self.blockEvent then
			return
		end

		self:checkSurround(var_4_1)

		return
	end, SFX_PANEL)

	return var_4_1
end

function PuzzlaView:checkSurround(arg_6_1)
	local var_6_0 = self:getBlockItemByPositions((arg_6_1:getSurroundPosition()))

	if var_6_0 then
		self:swop(arg_6_1, var_6_0)
	end

	return
end

function PuzzlaView:swop(arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2:getPosition()
	local var_7_1 = arg_7_1:getPosition()

	arg_7_1:setPosition(var_7_0, (arg_7_2:getCurrIndex()))
	arg_7_2:setPosition(var_7_1, (arg_7_1:getCurrIndex()))

	self.puzzlaItems[var_7_1.y][var_7_1.x] = arg_7_2
	self.puzzlaItems[var_7_0.y][var_7_0.x] = arg_7_1

	arg_7_2:setLocalPosition((arg_7_1:getLocalPosition()))
	arg_7_1:setLocalPosition((arg_7_2:getLocalPosition()))

	if self:isFinish() then
		self.blockEvent = true

		arg_7_2:setHightLight()

		if self.onFinish then
			self.onFinish()
		end
	else
		arg_7_2:setBlock()
	end

	return
end

function PuzzlaView:getBlockItemByPositions(arg_8_1)
	local var_8_0

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if self:isValidPosition(iter_8_1) and self:isBlockItem(iter_8_1) then
			var_8_0 = self:getItemByPosition(iter_8_1)

			break
		end
	end

	return var_8_0
end

function PuzzlaView:isBlockItem(arg_9_1)
	return self:getItemByPosition(arg_9_1):isBlock()
end

function PuzzlaView:getItemByPosition(arg_10_1)
	assert(self.puzzlaItems[arg_10_1.y], "position y" .. arg_10_1.y)

	return self.puzzlaItems[arg_10_1.y][arg_10_1.x]
end

function PuzzlaView:isValidPosition(arg_11_1)
	if arg_11_1.x > 0 and arg_11_1.y > 0 and arg_11_1.x <= var_0_4 and arg_11_1.y <= var_0_5 then
		return true
	end

	return false
end

function PuzzlaView:printTable()
	for iter_12_0, iter_12_1 in ipairs(self.puzzlaItems) do
		local var_12_0 = ""

		for iter_12_2, iter_12_3 in ipairs(iter_12_1) do
			var_12_0 = var_12_0 .. iter_12_0 .. "-" .. iter_12_2 .. "-" .. iter_12_3:getCurrIndex() .. " "
		end

		print(var_12_0)
	end

	return
end

function PuzzlaView:disorganizePuzzla(arg_13_1)
	self.paths = {}

	local function var_13_0()
		return
	end

	if arg_13_1 and #arg_13_1 > 0 then
		self:orderDisorganize(arg_13_1, var_0_2, function(arg_15_0)
			self.paths = arg_15_0

			var_13_0()

			return
		end)
	else
		for iter_13_0 = 1, var_0_3 do
			local var_13_1 = self:disorganizeStep()

			table.insert(self.paths, var_13_1)

			self.prevDir = var_0_10[var_13_1]
		end

		var_13_0()
	end

	return
end

function PuzzlaView:disorganizeStep()
	local var_16_0 = self:getBlockItem()

	local function var_16_1(arg_17_0)
		if self.prevDir then
			return self.prevDir == arg_17_0
		end

		return false
	end

	local var_16_2 = {}

	for iter_16_0, iter_16_1 in ipairs((var_16_0:getSurroundPosition())) do
		if self:isValidPosition(iter_16_1) and not var_16_1(iter_16_0) then
			table.insert(var_16_2, {
				pos = iter_16_1,
				dir = var_0_8[iter_16_0]
			})
		end
	end

	local var_16_3 = var_16_2[math.random(1, #var_16_2)]

	self:swop(self:getItemByPosition(var_16_3.pos), var_16_0)

	return var_16_3.dir
end

function PuzzlaView:printPaths()
	local var_18_0 = ""

	for iter_18_0, iter_18_1 in ipairs(self.paths or {}) do
		var_18_0 = var_18_0 .. var_0_9[iter_18_1] .. ","
	end

	print(var_18_0)

	return
end

function PuzzlaView:decodePuzzla(arg_19_1)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1 or {}) do
		table.insert(var_19_0, 1, {
			dir = var_0_8[var_0_10[iter_19_1]],
			index = var_0_9[var_0_8[var_0_10[iter_19_1]]]
		})
	end

	return var_19_0
end

function PuzzlaView:aotuDecode()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs((self:decodePuzzla(self.paths))) do
		table.insert(var_20_0, iter_20_1.index)
	end

	self:revertPuzzla(var_20_0)

	return
end

function PuzzlaView:printDecode()
	local var_21_0 = ""

	for iter_21_0, iter_21_1 in ipairs((self:decodePuzzla(self.paths))) do
		var_21_0 = var_21_0 .. " - " .. iter_21_1.dir
	end

	print(var_21_0)

	return
end

function PuzzlaView:revertPuzzla(arg_22_1)
	self:orderDisorganize(arg_22_1, var_0_1)

	return
end

function PuzzlaView:getBlockItem()
	local var_23_0

	for iter_23_0, iter_23_1 in ipairs(self.puzzlaItems) do
		for iter_23_2, iter_23_3 in ipairs(iter_23_1) do
			if iter_23_3:isBlock() then
				var_23_0 = iter_23_3

				break
			end
		end
	end

	return var_23_0
end

function PuzzlaView:orderDisorganize(arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = {}

	self.blockEvent = true

	local var_24_1 = self:getBlockItem()
	local var_24_2 = {}

	local function var_24_3(arg_25_0)
		self:swop(self:getItemByPosition(var_24_1:getSurroundPosition()[arg_25_0]), var_24_1)
		table.insert(var_24_0, var_0_8[arg_25_0])

		return
	end

	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		table.insert(var_24_2, function(arg_26_0)
			if arg_24_2 == 0 then
				var_24_3(iter_24_1)
				arg_26_0()
			else
				self:removeTimer()

				self.delayTimer = Timer.New(function()
					self:removeTimer()
					var_24_3(iter_24_1)
					arg_26_0()

					return
				end, arg_24_2, 1)

				self.delayTimer:Start()
			end

			return
		end)
	end

	seriesAsync(var_24_2, function()
		self.blockEvent = nil

		if arg_24_3 then
			arg_24_3(var_24_0)
		end

		return
	end)

	return
end

function PuzzlaView:isFinish()
	for iter_29_0, iter_29_1 in ipairs(self.puzzlaItems) do
		for iter_29_2, iter_29_3 in ipairs(iter_29_1) do
			assert(isa(iter_29_3, PuzzlaItem), "item should instance of PuzzlaItem")

			if not iter_29_3:isRestoration() then
				return false
			end
		end
	end

	return true
end

function PuzzlaView:removeTimer()
	if self.delayTimer then
		self.delayTimer:Stop()

		self.delayTimer = nil
	end

	return
end

function PuzzlaView:dispose()
	pg.DelegateInfo.Dispose(self)
	self:removeTimer()

	return
end

return PuzzlaView
