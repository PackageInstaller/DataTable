---
--- Created by zou hanjie.
--- DateTime: 2022/11/27 18:28
---@class MazeEventType



local MazeEventType = Class('MazeEventType')


---@alias MazeEventType_ integer
local MazeEventType_ = {
    Plot = 2,       -- 剧情
    PuzzleCustom = 3,-- puzzle 自定义的事件
    Gear = 4,       -- 机关, 玩家踩到此节点后, 通过按钮进行交互
    Condition = 5,  -- 子谜题解谜条件; (一般用于 教学环节)
    Solved = 6,     -- 解谜成功后触发的事件
    Failure = 7,    -- 解谜失败后触发的事件
    Battle = 8,     -- 战斗
    Boss = 9,     -- 战斗
    Chest = 10,      -- 宝箱
    Start = 11,      -- 每章节有且仅有一个, 入口
    End = 12,       -- 每章节有且仅有一个, 出口
    None = 13,      -- 空事件
}



function MazeEventType:__init()
    print("   ~~~~~~~ MazeEventType:__init() ~~~~~~~")
    assert(false) -- 不该用到... 
end
function MazeEventType:__delete()
    print("   ~~~~~~~ MazeEventType:__delete() ~~~~~~~")
end



-- 得到 enum type 
---@return MazeEventType_
function MazeEventType.Get() 
    return MazeEventType_
end


-- 从配表中读取 type 数据:
---@param s string
---@return MazeEventType_
function MazeEventType.StringToEventType(s) 
    assert( type(s) == "string" )
    s = string.lower(s)
    if  s == "plot" then            return MazeEventType_.Plot
    elseif  s == "puzzlecustom" then    return MazeEventType_.PuzzleCustom
    elseif  s == "gear" then            return MazeEventType_.Gear
    elseif  s == "condition" then       return MazeEventType_.Condition
    elseif  s == "solved" then          return MazeEventType_.Solved
    elseif  s == "failure" then         return MazeEventType_.Failure
    elseif  s == "battle" then          return MazeEventType_.Battle
    elseif  s == "boss" then          return MazeEventType_.Boss
    elseif  s == "chest" then           return MazeEventType_.Chest
    elseif  s == "start" then           return MazeEventType_.Start
    elseif  s == "end" then             return MazeEventType_.End
    elseif  s == "none" then            return MazeEventType_.None
    else
      assert(false, "参数有问题")
      return MazeEventType_.Plot
    end
end



function MazeEventType.ToString( type ) 
    assert( not isNull(type) )
    if  type == MazeEventType_.Plot then        return "Plot"
    elseif  type == MazeEventType_.PuzzleCustom then   return "PuzzleCustom"
    elseif  type == MazeEventType_.Gear then        return "Gear"
    elseif  type == MazeEventType_.Condition then   return "Condition"
    elseif  type == MazeEventType_.Solved then      return "Solved"
    elseif  type == MazeEventType_.Failure then     return "Failure"
    elseif  type == MazeEventType_.Battle then      return "Battle"
    elseif  type == MazeEventType_.Boss then      return "Boss"
    elseif  type == MazeEventType_.Chest then       return "Chest"
    elseif  type == MazeEventType_.Start then       return "Start"
    elseif  type == MazeEventType_.End then         return "End"
    elseif  type == MazeEventType_.None then        return "None"
    else 
        assert( false, "参数有问题, type = " .. tostring(type) )
        return "Plot"
    end
end





-- 有些类型的 bubble 需要 ui 显示
---@param type MazeEventType
---@return boolean
function MazeEventType.IsHaveUIPrefab(type) 
    assert( not isNull(type) )
    local r =   (type == MazeEventType_.Plot) 
                or (type == MazeEventType_.Gear)
                or (type == MazeEventType_.Battle)
                or (type == MazeEventType_.Boss)
                or (type == MazeEventType_.Chest)
    return r
end

        


return MazeEventType
