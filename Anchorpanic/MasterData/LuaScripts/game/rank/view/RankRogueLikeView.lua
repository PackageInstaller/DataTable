module('game.rank.view.RankRogueLikeView', Class.impl(rank.RankBaseView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rank/RankBaseView.prefab")

-- 初始化
function configUI(self)
    super.configUI(self)

    --肉鸽面板没有奖励
    self.mBtnReward:SetActive(false)
end

-- 使用的item（Override）
function getItemRender(self)
    return rank.RankRogueLikeItem
end

-- 标签（Override）
function getScoceLab(self)
    return "通关积分"--"通关时长"
end

-- 排行值展示（Override）
function getRankValLab(self, rankVal)
    return rankVal
end

-- 剩余时间(Override)
function getTimeStr(self)
    -- self.mEndTime = rogueLike.RogueLikeManager:getEndTime()
    -- local currentTime = GameManager:getClientTime()
    -- local reamainTime = self.mEndTime - currentTime
    -- return TimeUtil.getFormatTimeBySeconds_1(reamainTime)

    local currentTime = GameManager:getClientTime()
    local reamainTime = GameManager:getWeekResetTime() - currentTime
    return TimeUtil.getFormatTimeBySeconds_1(reamainTime)

    -- local wday = tonumber(os.date("%w")) == 0 and 7 or tonumber(os.date("%w"))
    -- wday = (wday == 1 and tonumber(os.date("%H")) < 5) and 8 or wday
    -- local endTime = ((8 - wday) * 24 * 3600) - os.date("%H") * 3600 - os.date("%M") * 60 - os.date("%S") + 5 * 3600
    -- return TimeUtil.getFormatTimeBySeconds_1(endTime)
end

function onTimer(self)
    self.mTxtTime.text = self:getTimeStr()
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
