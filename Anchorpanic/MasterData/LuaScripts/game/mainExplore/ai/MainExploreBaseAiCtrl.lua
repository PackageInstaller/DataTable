--[[ 
-----------------------------------------------------
@filename       : MainExploreBaseAiCtrl
@Description    : 主线探索基类 AI
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("mainExplore.MainExploreBaseAiCtrl", Class.impl())

--构造
function ctor(self)
    self:initData()
end

--析构
function dtor(self)
end

function poolGet(self)
    return LuaPoolMgr:poolGet(self)
end

function poolRecover(self)
    LuaPoolMgr:poolRecover(self)
end

function onRecover(self)
    self:reset()
end

function initData(self)
    self.mThing = nil
end

function create(self, thing)
    self.mThing = thing
    self:addEvents()
end

function reset(self)
    self:removeEvents()
    self:initData()
end

function addEvents(self)
end

function removeEvents(self)
end

-- 帧循环
function step(self, deltaTime)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
