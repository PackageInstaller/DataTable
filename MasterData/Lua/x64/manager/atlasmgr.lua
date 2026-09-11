local AtlasMgr = class("AtlasMgr")

function AtlasMgr:Ctor()
	self:OnCtor()
end

function AtlasMgr:OnCtor()
	self.spritePool_ = {}
end

function AtlasMgr:GetSprite(arg_3_1, arg_3_2)
	self.spritePool_[arg_3_1 .. arg_3_2] = self.spritePool_[arg_3_1 .. arg_3_2] or getSprite(arg_3_1, arg_3_2)

	return self.spritePool_[arg_3_1 .. arg_3_2]
end

function AtlasMgr:UnloadSprite(arg_4_1)
	for iter_4_0, iter_4_1 in pairs(self.spritePool_) do
		if string.find(iter_4_0, arg_4_1) then
			Object.Destroy(iter_4_1)

			self.spritePool_[iter_4_0] = nil
		end
	end
end

function AtlasMgr:UnloadAllSprite()
	for iter_5_0, iter_5_1 in pairs(self.spritePool_) do
		Object.Destroy(iter_5_1)

		self.spritePool_[iter_5_0] = nil
	end

	self.spritePool_ = {}
end

return AtlasMgr
