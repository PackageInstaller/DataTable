--[[ 
-----------------------------------------------------
@filename       : HeroShowManager
@Description    : 英雄获得展示管理
@date           : 2022-2-18 14:54:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('hero.HeroShowManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:__init()
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

-- 设置获得的英雄展示列表
function setShowGainHeroList(self, voList)
    local heroShowList = {}
    if voList then
        for i = 1, #voList do
            local resultVo = recruit.RecruitReslutVo.new()
            resultVo:parseMsgData(voList[i])
            table.insert(heroShowList, resultVo)
        end
    end

    if (not self.mShowHeroList) then
        self.mShowHeroList = heroShowList
    else
        if (heroShowList) then
            for i, v in ipairs(heroShowList) do
                if #self.mShowHeroList < 10 then
                    table.insert(self.mShowHeroList, v)
                end
            end
        else
            self.mShowHeroList = heroShowList
        end
    end
end

-- 获取获得的英雄展示列表
function getShowGainHeroList(self)
    return self.mShowHeroList or {}
end

-- 获取是否是合成
function getIsMess(self)
    if not self.mIsMess then
        self.mIsMess = false
    end
    return self.mIsMess
end

-- 获取是否是合成
function setIsMess(self, isMess)
    self.mIsMess = isMess
end

-- 设置全部展示完毕后的回调方法
function setAllFinishCall(self, finishCall)
    self.mFinishCall = finishCall
end

-- 触发全部展示完毕后的回调方法
function runAllFinishCall(self)
    if (self.mFinishCall) then
        self.mFinishCall()
        self.mFinishCall = nil
    end
    self:setShowGainHeroList(nil)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]