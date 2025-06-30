module("LyScrollerSelectVo", Class.impl())

function ctor(self)
	self:__init()
end

function __init(self)
	self.m_dataVo = nil
	self.m_isSelect = nil
	self.m_args = nil
end

function setDataVo(self, cusVO)
	self.m_dataVo = cusVO
end

function getDataVo(self)
	return self.m_dataVo
end

function setSelect(self, cusValue)
	self.m_isSelect = cusValue
end

function getSelect(self)
	return self.m_isSelect
end

function setArgs(self, cusArgs)
	self.m_args = cusArgs
end

function getArgs(self)
	return self.m_args
end

function onRecover(self)
	self:__init()
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
