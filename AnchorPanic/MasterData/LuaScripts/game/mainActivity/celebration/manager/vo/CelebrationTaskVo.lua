module('Celebration.CelebrationTaskVo', Class.impl())
--[[ 
    主线关卡城池数据
]]
function ctor(self)
end

-- 解析数据
function parseData(self,curId, cusData)
    self.id=curId
    self.state=0
    self.count=0
    self.day = cusData.day
    self.title = cusData.title
    self.uiCode=cusData.ui_code
    self.maxTime = cusData.time
    self.des = cusData.describe
    self.rewardId = cusData.reward
end

function getDes(self)
    return _TT(self.des)
end

function getTitle(self)
    return _TT(self.title)
end

function setMsgVo(self,msgVo)
    self:setCount(msgVo.count)
    self:setState(msgVo.state)
end

function setCount(self,msgCount)
    if self.count~= msgCount then
        self.count=msgCount
    end
end

function setState(self,msgState)
    if self.state~= msgState then
        self.state=msgState
    end
end

function getState(self)
    return self.state
end

function getAwardList(self)
    return AwardPackManager:getAwardListById(self.rewardId)
end

function getProgress(self)
    return self.count/self.maxTime
end

function getProgressShow(self)
    return _TT(45013,self.count,self.maxTime)
end

function getUICode(self)
    return self.uiCode
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]