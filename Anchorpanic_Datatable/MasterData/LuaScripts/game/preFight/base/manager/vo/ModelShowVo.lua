module("preFight.ModelShowVo", Class.impl())

function ctor(self)
	self:__init()
end

function __init(self)
	--放置序号
	self.index = nil
	--是否攻方
	self.isAttacker = nil
	--放置的位置
	self.pos = nil
	--英雄vo
	self.heroVo = nil
end

function copy(self, showVo)
	self.index = showVo.index
	self.isAttacker = showVo.isAttacker
	self.pos = showVo.pos
	self.heroVo = showVo.heroVo
	return self
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
