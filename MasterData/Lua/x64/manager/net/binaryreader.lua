import("bit")

local BinaryReader = class("BinaryReader")

function BinaryReader:Initialize(arg_1_1)
	self.index_ = 1
	self.data_ = arg_1_1
	self.binaryArray_ = {}

	self:ToBinaryArray()
end

function BinaryReader:EOF()
	return string.byte(self.data_, self.index_) == nil
end

function BinaryReader:ToBinaryArray()
	for iter_3_0 = 1, #self.data_ do
		self.binaryArray_[iter_3_0] = string.byte(self.data_, iter_3_0)
	end
end

function BinaryReader:Read(arg_4_1)
	local var_4_0 = string.byte(self.data_, self.index_)

	if var_4_0 == nil then
		return 0
	end

	for iter_4_0 = self.index_ + 1, self.index_ + arg_4_1 - 1 do
		var_4_0 = bit.bor(bit.lshift(var_4_0, 8), (string.byte(self.data_, iter_4_0)))
	end

	self.index_ = self.index_ + arg_4_1

	return var_4_0
end

return BinaryReader
