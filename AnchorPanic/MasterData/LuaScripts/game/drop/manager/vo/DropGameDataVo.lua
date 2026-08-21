
module('drop.DropGameDataVo', Class.impl())

-- 解析建筑玩法配置数据，缓存基础字段与计分速度配置
function parseData(self, id, cusData)
    self.id = id
    self.name = cusData.name
    self.firstAward = cusData.first_award
    self.pre_id = cusData.pre_id
    self.targetScore = cusData.target_score
    self.time = cusData.time
    -- 说明：玩法参数数组 {类型总数, 层数, 物品总数, 第一层占比}，由 DropGamePanel 读取后驱动棋盘生成。
    self.copyParam = cusData.copy_param
    --self.scoreSpeed = self:parseScoreSpeed(cusData.score_speed)
    -- self.iconList = cusData.icon_list
    -- self.background = cusData.background_id
    if not table.empty(cusData.begin_time) then
        self.begin_time =
        {
            year = cusData.begin_time[1][1],
            month = cusData.begin_time[1][2],
            day = cusData.begin_time[1][3],
            hour = cusData.begin_time[2][1],
            min = cusData.begin_time[2][2],
            sec = cusData.begin_time[2][3],
        }
    end

    -- self:parseMapList(cusData.begin_list)
end

-- -- 复制并按分数节点升序排序计分速度配置
-- function parseScoreSpeed(self, list)
--     local retList = {}
--     for i = 1, #list, 1 do
--         table.insert(retList, list[i])
--     end
--     table.sort(retList, function(a, b)
--         return a[1] < b[1]
--     end)
--     return retList
-- end

-- 判断当前玩法是否已到开放时间；未配置开始时间时默认开放
function isOpen(self)
    if not self.begin_time then
        return true
    end

    local configDt = os.time(self.begin_time)
    local clientDt = GameManager:getClientTime()
    return clientDt >= configDt
end

-- -- 解析事件配置列表，并按事件 id 缓存到字典中
-- function parseMapList(self,eventList)
--     self.eventDic = {}
--     for k,v in pairs(eventList) do  
--         local eventVo = LuaPoolMgr:poolGet(drop.DropEventListVo)
--         eventVo:parseData(k,v)
--         --table.insert(self.eventList,eventVo)
--         self.eventDic[k] = eventVo
--     end
--     --table.sort(self.eventList,function(a,b) return a.id < b.id end)
-- end

-- 获取玩法名称
function getName(self)
    return self.name
end


return _M