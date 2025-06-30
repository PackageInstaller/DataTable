module("gm.GmCommandVo", Class.impl("lib.event.EventDispatcher"))

function ctor(self)
	self:__init()
end

function __init(self)
	-- 模块
	self.module = nil
	-- GM命令
	self.cmd = nil
	-- 描述
	self.desc = nil
	-- 例子
	self.example = nil
end

function setData(self, msg)
	self.module = msg.module
	self.cmd = msg.cmd
	self.desc = msg.desc
	self.example = msg.example
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
