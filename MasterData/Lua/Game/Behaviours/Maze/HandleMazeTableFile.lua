---
--- Created by zou hanjie.
--- DateTime: 2022/11/26 18:28

-- 读取迷宫配表数据 (不完全, 有一部分配表读取工作 分散在各个 Puzzle class 中)

---@class HandleMazeTableFile
local HandleMazeTableFile = Class('HandleMazeTableFile')


---@type SettingMgr
local settingMgr = SettingMgr:GetInstance() -- 读取配表


local TrackNodeGO = import('Game.Behaviours.SimpleTrack.TrackNodeGO')
local MazeEventType = import('Game.Behaviours.Maze.MazeEventType')
local EventKey = import('Game.Behaviours.Maze.EventKey')
local EventData = import('Game.Behaviours.Maze.EventData')


local Vector2Int = CS.UnityEngine.Vector2Int



---@param trackBrain_ TrackBrain
function HandleMazeTableFile:__init( trackBrain_ )
    
    self.trackBrain = trackBrain_
    self.startEventKey = nil -- EventKey 进入一个迷宫后, 会自动直接执行的 事件; 
    self.eventDatas = {} -- Dictionary<EventKey.keyStr,EventData>, 只会读取本次 迷宫章节 需要的 row数据;

    self.IDsInRooms = {} -- Dictionary<string, List<int>>

    -- "前置依赖事件":
    -- 想要自动执行事件 C, 需要先等待事件 A,B 被执行结束;
    -- key:    事件 A,B 的 key;
    -- value:  事件 C 的 key;
    -- 每执行完一起事件, 都会检查是否能触发一部分新事件;
    self.preconditionDict = {} -- Dictionary<EventKey.keyStr, List<EventKey>>

    self.iconPaths = {} -- Dic<string,1> 充当 HashSet<string>, battle/boss bubble 会用到
end


function HandleMazeTableFile:__delete()
    print("   ~~~~~~~ HandleMazeTableFile:__delete() ~~~~~~~")
end



-- =============================================================== Self -> ================================================================== -- 


---@param mazeChapter string
---@return void
function HandleMazeTableFile:Read( mazeChapter ) 
    assert( type(mazeChapter) == "string" )
    self:Read_Maze(mazeChapter)
    self:Read_IDsInRooms(mazeChapter)
end




---@param mazeChapter string
---@return void
function HandleMazeTableFile:Read_Maze( mazeChapter ) 

    local resourcesPaths = {} -- Dic<string,string>, key:id, 比如 "134"; value: 对应的path
    do
        local resourcesPathTableFile = settingMgr:Get(AutoIds.IdSetting29) -- TableFile,  资源路径表 
        local length = resourcesPathTableFile:GetRowCount()
        for i=1,length do -- (实际从表格第 5 行开始读)
            local row = resourcesPathTableFile:GetRow(i) -- TableFileRow
            local id = row:Get("id")
            local path = row:Get("resourcePath")
            assert( id and path and id~="" and  path~="" )
            resourcesPaths[id] = path
        end
        assert( table.count(resourcesPaths) > 0 )
    end

    -- ----------:
    self.eventDatas = {}

    local tableFile = settingMgr:Get(AutoIds.IdSetting3001) -- TableFile,  地图配置表 
    local length = tableFile:GetRowCount()
    for i=1,length do -- (实际从表格第 5 行开始读)
        local row = tableFile:GetRow(i) -- TableFileRow


        local chapterInfo = string.lower( row:Get("group") ) -- string
        -- 过滤掉分隔符 和 无效行;
        if chapterInfo == ""  then 
            goto continue
        end
        -- 过滤掉 不是本次迷宫章节的 rows
        if chapterInfo ~= mazeChapter  then
            goto continue
        end

        local eventKey = EventKey.New( { keyStr=row:Get("type") } ) -- EventKey
        
        -- ------- 装填本次事件 ----------:
        local eventData = EventData.New()
        eventData.eventKey = eventKey

        -- 寻找入口事件;
        if eventData.eventKey.eventType == MazeEventType.Get().Start  then
            assert( isNull(self.startEventKey), "配表中出现重复的 start 事件; 新的 eventKey: " .. eventKey.keyStr )
            self.startEventKey = eventData.eventKey
        end


        if eventData.eventKey.eventType == MazeEventType.Get().Plot  then
            eventData.storyId = tonumber( row:Get("storyId") )
            assert( eventData.storyId ~= nil )
        end

        -- 有时候 领取宝箱后存在剧情:
        if eventData.eventKey.eventType == MazeEventType.Get().Chest  then
            eventData.rewardStory = tonumber( row:Get("rewardStory") ) -- 可能为 nil, 这是合法的
        end 


        if tonumber( row:Get("isStoryHasBG") ) == 1 then 
            print( "找到 isStoryHasBG == 1" )
            eventData.isStoryHasBG = true
        else 
            eventData.isStoryHasBG = false
        end 


        do-- preconditionAutoKey
            local reconditionKeyStrs = string.split( string.lower(row:Get("preconditionAutoKeys")), ';') -- string[] table
            for i,s in pairs(reconditionKeyStrs) do
                if s ~= "" then
                    local k = EventKey.New({keyStr=s})

                    if isNull(self.preconditionDict[k.keyStr]) then
                        self.preconditionDict[k.keyStr] = {}
                    end
                    table.insert(self.preconditionDict[k.keyStr], eventData.eventKey)
                    assert( isNull( eventData.preconditions[k.keyStr] ) )
                    eventData.preconditions[k.keyStr] = k -- Dic.Add
                end
            end
        end

        do
            local s = string.lower( row:Get("isSave") ) -- string
            eventData.isSupportSave = (s == "1") -- "0" 或 空 皆为 false;
        end

        if (eventData.eventKey.eventType == MazeEventType.Get().Gear) or (eventData.eventKey.eventType == MazeEventType.Get().PuzzleCustom) then
        
            local s = row:Get("gearCondition")
            if s ~= ""  then
                eventData.gearConditionEventKey = EventKey.New({keyStr=s})
            end
        end

        do
            local newEventStrs = string.split( string.lower( row:Get("showedEvents") ), ';' ) -- string[] table
            for i,s in pairs(newEventStrs) do
                if s ~= ""  then
                    table.insert( eventData.showedEventsWhenEnd, EventKey.New({keyStr=s}) )
                end
            end
        end


        local disappearedRoomWhenEnds = string.split( string.lower( row:Get("disappearedRooms") ), ';' ) -- string[] table
        for i,s in pairs(disappearedRoomWhenEnds) do
            if s ~= ""  then
                table.insert( eventData.disappearedRoomsWhenEnd, s )
            end
        end

        local showedRoomWhenEnds = string.split( string.lower( row:Get("showedRooms") ), ';' ) -- string[] table
        for i,s in pairs(showedRoomWhenEnds) do
            if s ~= ""  then
                table.insert( eventData.showedRoomsWhenEnd, s )
            end
        end


        do-- icon:  battle/boss bubble 的角色头图path:
            local iconRawStr = row:Get("icon")
            if iconRawStr ~= "" then
                local iconStrs = string.split( iconRawStr, ':' )
                local pathID = iconStrs[1]     -- 如: "134"
                local pathSuffix = iconStrs[2] -- 如: "spring_revealing_boss001.png"
                assert( not isNull(resourcesPaths[pathID]), "pathID=" .. pathID )
                local path = resourcesPaths[pathID] .. "/" .. pathSuffix
                eventData.iconPath = path
                ---:
                self.iconPaths[path] = 1 -- 允许被重复设置
            end
        end
        
        eventData.skipTagWhenReload = string.lower( row:Get("skipTagWhenReload")) -- 可能为 "";

        
        if      eventData.eventKey.eventType == MazeEventType.Get().Battle  
            or  eventData.eventKey.eventType == MazeEventType.Get().Boss
        then 
            eventData.battleID = tonumber( row:Get("regionId") ) -- int, 若为 "", 则返回 nil
            assert( eventData.battleID ~= nil )
        end 

        eventData.customJobTagWhenAfter = string.lower( row:Get("customJobTagWhenAfter"))  -- 可能为 "";  
        eventData.customInfo = string.lower( row:Get("customInfo"))  -- 可能为 ""; 

        do-- reward:    
            local rewardStr = row:Get("reward")
            if rewardStr ~= "" then
                eventData.reward = checkInt(row:Get("reward"))
                assert( eventData.reward ~= 0 )
            end
        end 

        -- -----------------
        assert( isNull( self.eventDatas[eventData.eventKey.keyStr] ) )
        self.eventDatas[eventData.eventKey.keyStr] = eventData

        :: continue ::
    end

    assert( table.count(self.eventDatas) > 0, "没读取到任何 迷宫事件, 猜测是参数 mazeChapter 不正确: " .. mazeChapter  )

    -- ------
    local logs= "-- 打印迷宫配表信息: ---";
    for keyStr,eData in pairs(self.eventDatas) do
        logs = logs .. "\nKey: " .. keyStr
        logs = logs .. "\n " .. eData:DebugLog()
    end
    print(logs)    
end


---@param mazeChapter string
---@return void
function HandleMazeTableFile:Read_IDsInRooms( mazeChapter ) 

    -- (string) "103" -> (int) 1 
    local mapIdChar = string.sub(mazeChapter, 1,1) -- 取第一字符
    assert( (mapIdChar=='1') or (mapIdChar=='2') or (mapIdChar=='3') or (mapIdChar=='4')  ) -- 目前只有 4 个迷宫

    self.IDsInRooms = {}

    -- 读取配置表
    local tableFile = settingMgr:Get(AutoIds.IdSetting3002) -- TableFile,  地图房间对照表 
    local length = tableFile:GetRowCount()
    for i=1,length do -- (实际从表格第 5 行开始读)
        local row = tableFile:GetRow(i) -- TableFileRow

        local mapId = string.sub( row:Get("mapId"), 1,1) -- 第一字符 
        assert( (mapId=='1') or (mapId=='2') or (mapId=='3') or (mapId=='4')  ) -- 目前只有 4 个迷宫
        if mapId ~= mapIdChar then
            goto continue
        end
        --print( "read room: " .. mapId )
       
        local key = string.lower( row:Get("roomKey") ) -- string
        local idStrs = string.split( string.lower( row:Get("ids") ), ';' ) -- string[] table

        assert( isNull(self.IDsInRooms[key]) )
        self.IDsInRooms[key] = {}

        for i,s in pairs(idStrs) do
            table.insert( self.IDsInRooms[key], TrackNodeGO.StringToTrackNodeID(s) )
        end

        :: continue ::
    end

    -- ------ debug:
    local ss = "IDsInRooms: ";
    for str,ids in pairs(self.IDsInRooms) do
        ss = ss .. "\nkey = " .. str
        for i,id in pairs(ids) do
            ss = ss .. "\n   " .. id
        end
    end 
    print(ss)
end



-- todo: 翻译更多... 







-- 不光配表会用到, 游戏读取存档时也会用到...
---@param src string
---@return integer[]
function HandleMazeTableFile.String_2_InitLayout( src )
    assert( type(src) == "string" )

    local initLayoutStrs = string.split( string.lower(src), ';' ) -- string[] table

    assert( #initLayoutStrs == 9, "initLayoutStrs.Length = " .. #initLayoutStrs )
    
    local initLayout = {} -- 需要 9 个元素 

    for j=1, #initLayoutStrs do 
        local s = initLayoutStrs[j] -- string

        if s == "null" then 
            table.insert( initLayout, -1 )
        else 
            local num = tonumber(s)
            assert( type(num) == "number" )
            table.insert( initLayout, num )
        end
    end
    return initLayout
end



-- 游戏写入存档时会用到
---@param initLayout integer[]
---@return string
function HandleMazeTableFile.InitLayout_2_String( initLayout )
    assert( isTable(initLayout) )
    local initLayoutLen = table.count(initLayout) -- 保守的方式得到元素个数
    assert( initLayoutLen == 9, "initLayout.length = " .. #initLayout )

    local o = ""
    for i=1, initLayoutLen do
        local e = initLayout[i]
        assert( type(e) == "number" )
        o = o .. ((e < 0) and "null" or tostring(e))
        if i < initLayoutLen then -- 最后一个元素不用添加
            o = o .. ';'
        end
    end
    return o
end





-- (string) "1_2" -> (Vector2Int) {1,2}
---@param str string
---@return UnityEngine.Vector2Int
function HandleMazeTableFile.StringToCheckerboardIdx( str )
    assert( type(str) == "string" and (str ~= "") )

    local ss = string.split( str, '_' ) -- string[] table
    assert( #ss == 2, "str = " .. str )

    local w = tonumber( ss[1] ) -- int
    local h = tonumber( ss[2] ) -- int
    assert( type(w) == "number" and type(h) == "number" )
    return Vector2Int( w,h )
end






-- ---@param eventKey EventKey
-- ---@return List<EventKey> findedKeys -- 这些找到的事件 将被自动执行
-- function HandleMazeTableFile:FindReliantEventKeysFromPreconditionDict( eventKey )
--     assert( EventKey.CheckType(eventKey) == true )

--     local findedKeys = {} -- List<EventKey>
--     local eventKeys = self.preconditionDict[eventKey.keyStr] -- List<EventKey>

--     if isNull(eventKeys) then 
--         return findedKeys
--     end 

--     for i,eKey in pairs(eventKeys) do 
--         local eventData = self.eventDatas[eKey.keyStr]; -- must have
--         assert( not isNull( eventData ) )
--         assert( not isNull( eventData.preconditions[eventKey.keyStr] ) )

--         eventData.preconditions[eventKey.keyStr] = nil

--         if( table.count(eventData.preconditions) == 0 ) then
--             table.insert( findedKeys, eKey )
--         end
--     end

--     return findedKeys
-- end





---@param eventKeys EventKey[]
---@return boolean, EventKey[] @ 这些找到的事件 将被自动执行
function HandleMazeTableFile:FindReliantEventKeysFromPreconditionDict( eventKeys )

    assert( type(eventKeys) == "table" )
    assert( table.count(eventKeys) > 0 )

    local findedKeys = {} -- List<EventKey>

    for _,eventKey in pairs(eventKeys) do
        assert( EventKey.CheckType(eventKey) == true )
        
        local pEventKeys = self.preconditionDict[eventKey.keyStr] -- List<EventKey>
        if not isNull(pEventKeys) then 
            for i,eKey in pairs(pEventKeys) do 
                local eventData = self.eventDatas[eKey.keyStr]; -- must have
                assert( not isNull( eventData ) )
                assert( not isNull( eventData.preconditions[eventKey.keyStr] ) )

                eventData.preconditions[eventKey.keyStr] = nil

                if( table.count(eventData.preconditions) == 0 ) then
                    table.insert( findedKeys, eKey )
                end
            end
        end
    end

    return findedKeys
end





return HandleMazeTableFile


