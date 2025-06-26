--[[    
    英雄回忆录数据vo
]]
module("battleMap.BiographyVo", Class.impl())

function parseData(self, cusMsg)
    self.heroTid = cusMsg.hero_tid
    self.biographyId = cusMsg.biography_id
    self.isFollow = cusMsg.is_follow == nil and 0 or cusMsg.is_follow
    self.passDupList = cusMsg.pass_dup
    self.historyDupList = cusMsg.history_pass_dup
    self.restTime = cusMsg.challenge_times

    self.curDupMax = false
    self.curDupId = nil
    local dupList = battleMap.BiographyManager:getDupList(self.biographyId)
    if(#dupList == #self.historyDupList)then
        -- 已经全部通过，则设置当前副本id为最大副本id
        for i = 1, #self.historyDupList do
            if(self.curDupId == nil)then
                self.curDupId = self.historyDupList[i]
            end
            if(self.historyDupList[i] >= self.curDupId)then
                self.curDupId = self.historyDupList[i]
            end
        end
        self.curDupMax = true
    else
        if(#self.historyDupList > 0)then
            for i = 1, #self.historyDupList do
                if(self.curDupId == nil)then
                    self.curDupId = self.historyDupList[i]
                end
                if(self.historyDupList[i] >= self.curDupId)then
                    self.curDupId = self.historyDupList[i]
                end
            end
            -- 手动+1设置当前攻打的章节id
            self.curDupId = self.curDupId + 1
        else
            for i = 1, #dupList do
                if(self.curDupId == nil)then
                    self.curDupId = dupList[i]
                end
                if(dupList[i] <= self.curDupId)then
                    -- 手动设置初始的章节id
                    self.curDupId = dupList[i]
                end
            end
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
