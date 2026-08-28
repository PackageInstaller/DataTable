---
--- Created by zou hanjie.
--- DateTime: 2022/11/26 18:28


---@class EventKey
local EventKey = Class('EventKey')



--- Maze:
local MazeEventType = import('Game.Behaviours.Maze.MazeEventType')
local TrackNodeGO = import('Game.Behaviours.SimpleTrack.TrackNodeGO')


-- 使用范例:
-- local a = EventKey.New({ keyStr="12-plot" })
-- local b = EventKey.New({ id=12, type=MazeEventType.Get().Plot })
---@param args table 以此来支持 函数重载
---@return EventKey
function EventKey:__init( args )
    --print("   ~~~~~~~ EventKey:__init() ~~~~~~~")
    assert( isTable(args) )

    if not isNull(args.keyStr) then 
        assert( type(args.keyStr) == "string" )
        
        local s = string.lower(args.keyStr)
        local ss = string.split( s, '-' )
        assert( #ss >= 2 ) -- 有可能大于 2, 比如 "10-plot-1", "10-plot-2" 这种, 但目前暂未使用 
        assert( #ss == 2 ) -- todo: 临时的, 参考上条 
        self.keyStr = s 
        self.id = TrackNodeGO.StringToTrackNodeID( ss[1] )
        self.eventType = MazeEventType.StringToEventType( ss[2] )
        self.ClassID = "EventKey"
    else 
        assert( type(args.id) == "number" )
        assert( not isNull(args.type) )
        assert( type(args.type) == "number" )
            --print( "EventKey Init, type = " .. tostring(args.type) )

        -- 最保守最安全的实现方法: (int) 22 -> (string) "2.2" 
        local s = tostring(args.id //10) -- string  
        if (args.id%10) > 0 then 
            s = s .. '.' .. tostring(args.id%10)
        end 
        s = s .. '-' .. string.lower( MazeEventType.ToString(args.type) )
            --print("EventKey Init 拼装出来的 keyStr = " .. s)       -- !!!!!  记得删...
        self.keyStr = s
        self.id = args.id 
        self.eventType = args.type 
        self.ClassID = "EventKey"
    end
end



function EventKey:__delete()
    --print("   ~~~~~~~ EventKey:__delete() ~~~~~~~")
    self.keyStr = nil 
    self.id = nil
    self.eventType = nil
    self.ClassID = nil
end


-- =============================================================== Self -> ================================================================== -- 

---@param k EventKey
---@return boolean
function EventKey.CheckType( k )
    return (not isNull(k)) and (k.ClassID == "EventKey")
end



---@param a EventKey
---@param b EventKey
---@return boolean
function EventKey.IsSame( a,b ) 
    if isNull(a) or isNull(b) then 
        return false
    end
    assert( EventKey.CheckType(a) )
    assert( EventKey.CheckType(b) )
    return (a.keyStr == b.keyStr)
end



---@return string
function EventKey:Log()
    local s = self.keyStr .. "(" .. tostring(self.id) .. MazeEventType.ToString(self.eventType) .. ");"
    return s
end





return EventKey
