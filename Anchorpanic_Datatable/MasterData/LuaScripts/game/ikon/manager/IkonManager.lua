--[[  AutoScript 自动脚本 
----------------------------------------------------- 
   @CreateTime:2021/4/6 14:19:18 
   @Author:Shenxintian 
   @Copyright: (LY)2021 雷焰网络 
   @Description:广告牌展示页面 M
]] 

module('game.ikon.manager.IkonManager',Class.impl(Manager))

--构造
function ctor(self)
	super.ctor(self)
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
     super.resetData(self)
     self:__init()
end

--初始化
function __init(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
