---
--- Created by zou hanjie.
--- DateTime: 2022/11/26 18:28
---@class EventData



local EventData = Class('EventData')



--- Maze:
local EventKey = import('Game.Behaviours.Maze.EventKey')


 

function EventData:__init()
    --print("   ~~~~~~~ EventData:__init() ~~~~~~~")

    self.eventKey = nil -- EventKey

    -- 这些 前置依赖event 被全部执行后, 本 event 会被自动压入 queue 中,然后被自动执行; (而无需玩家点击)
    self.reliantEvents = {} -- Dictionary<EventKey.keyStr,EventKey>

    -- 对应 trackNodeGO id; 此事件是固定且唯一的, 可在另一个表中找到;
    self.showedEventsWhenEnd = {} -- List<EventKey>

    -- -99 表示无操作
    self.disappearedRoomsWhenEnd = {} -- List<string>

    self.showedRoomsWhenEnd = {} -- List<string>

    -- 容器中的事件被全部执行后, 本事件会被自动执行
    self.preconditions = {} -- Dictionary<EventKey.keyStr,EventKey>

    -- 有的 gear 事件需要指定对应的 解谜条件 type = Condition; (可选)
    self.gearConditionEventKey = nil -- EventKey

    -- 是否支持记录到存档中去;
    self.isSupportSave = true -- boolean

    -- 用户自定义的字符串, 用来标记在读档时本 evnetdata 是否可跳过; 可为 空字符串;
    self.skipTagWhenReload = "" -- string

    -- 战斗id, 只有当 eventKey type 为 boss 或 battle 时才会有这个值
    self.battleID = nil

    -- 有些事件结束后, 需要执行一些 puzzle 自定义的工作, 此变量记录对应的 tag 信息; (可空)
    self.customJobTagWhenAfter = ""

    -- 自定义信息
    self.customInfo = ""

    -- 若为 battle/boss bubble, 此处存储 角色头图path 
    self.iconPath = ""

    -- plot 才有的数据
    self.storyId = nil 

    -- 部分 chest 在领取之后, 存在剧情:
    self.rewardStory = nil 

    -- 当 storyId, rewardStory 中某一个存在值时, 本值有意义: 剧情是否自带背景图
    self.isStoryHasBG = false 

    -- int, 比如 宝箱涉及的 古物id
    self.reward = nil
end




function EventData:__delete()
    --print("   ~~~~~~~ EventData:__delete() ~~~~~~~")
    self.eventKey = nil
    self.reliantEvents = nil
    self.showedEventsWhenEnd = nil
    self.disappearedRoomsWhenEnd = nil
    self.showedRoomsWhenEnd = nil
    self.preconditions = nil
    self.gearConditionEventKey = nil
    self.isSupportSave = nil
    self.skipTagWhenReload = nil
    self.storyId = nil 
    self.isStoryHasBG = nil
end



---@return string
function EventData:DebugLog() 
    local s = "" -- string 
    s = s .. "\neventKey = " .. self.eventKey:Log()

    s = s .. "\nreliantEvents"
    for i,j in pairs(self.reliantEvents) do 
        s = s .. "\n    " .. i
    end

    s = s .. "\nshowedEventsWhenEnd = "
    for i,j in pairs(self.showedEventsWhenEnd) do 
        s = s .. "\n    " .. j:Log()
    end
    
    s = s .. "\ndisappearedRoomsWhenEnd = "
    for i,j in pairs(self.disappearedRoomsWhenEnd) do 
        s = s .. "\n    " .. j
    end
    
    s = s .. "\nshowedRoomsWhenEnd"
    for i,j in pairs(self.showedRoomsWhenEnd) do 
        s = s .. "\n    " .. j
    end
    
    s = s .. "\npreconditions"
    for i,j in pairs(self.preconditions) do
        s = s .. "\n    " .. i
    end

    s = s .. "\nbattleID = " .. ( isNull(self.battleID) and "nil" or tostring(self.battleID) )

    s = s .. "\ncustomJobTagWhenAfter = " .. ( isNull(self.customJobTagWhenAfter) and "nil" or tostring(self.customJobTagWhenAfter) )

    s = s .. "\ncustomInfo = " .. ( isNull(self.customInfo) and "nil" or tostring(self.customInfo) )

    s = s .. "\nreward = " .. ( isNull(self.reward) and "nil" or tostring(self.reward) )
    
    s = s .. "\n-------------------------------\n"
    return s
end


return EventData
