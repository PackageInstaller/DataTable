local BackYardLargeSpriteLoader = class("BackYardLargeSpriteLoader")

function BackYardLargeSpriteLoader:Ctor(arg_1_1)
	self.cnt = arg_1_1 or 6
	self.maxCnt = arg_1_1 * 2 + 1
	self.cache = {}
	self.paths = {}

	return
end

function BackYardLargeSpriteLoader:LoadSpriteAsync(arg_2_1, arg_2_2)
	if self.cache[arg_2_1] then
		arg_2_2(self.cache[arg_2_1])

		return
	end

	LoadSpriteAsync(arg_2_1, function(arg_3_0)
		self.cache[arg_2_1] = arg_3_0

		table.insert(self.paths, arg_2_1)
		arg_2_2(arg_3_0)
		self:Check()

		return
	end)

	return
end

function BackYardLargeSpriteLoader:Check()
	if #self.paths >= self.maxCnt then
		self:Clear()
	end

	return
end

function BackYardLargeSpriteLoader:Clear()
	for iter_5_0 = self.cnt, 1, -1 do
		self.cache[self.paths[iter_5_0]] = nil

		table.remove(self.paths, iter_5_0)
	end

	gcAll(false)

	return
end

function BackYardLargeSpriteLoader:Dispose()
	self.cache = nil
	self.paths = nil

	return
end

return BackYardLargeSpriteLoader
