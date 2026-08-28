---
--- Created by zou hanjie
--- DateTime: 2022-11-26
---@class TrackDataReader
local TrackDataReader = Class('TrackDataReader')


-- -------------------------------------------------

local rapidjson = require('rapidjson') -- 读取 json 文件

local GameObject = CS.UnityEngine.GameObject
local Vector3 = CS.UnityEngine.Vector3

---@type Engine.Modules.ResourceModule
local ResourceModule = CS.Engine.Modules.ResourceModule

local cs_coroutine = require 'XLua.cs_coroutine' -- 协程
local Yielders = CS.Engine.Lib.Yielders


-- -------------------------------------------------
local JsonPaths = {
    "Presets/JsonDatas/maze_1.json",
    "Presets/JsonDatas/maze_2.json",
    "Presets/JsonDatas/maze_3.json",
    "Presets/JsonDatas/maze_4.json"
}


-- -------------------------------------------------
function TrackDataReader:__init()
    -- 等效于 c# 中的 TrackData class, 但忽略了所有 非runtime 的数据;
    self.trackData = {} 
end

function TrackDataReader:__delete()
    self.trackData = nil
end



---@param mapId integer
---@return System.Collections.IEnumerator
function TrackDataReader:ReadJsonAsync( mapId )
    -- todo: 完全体应该根据 jsonFilePath 拿到 json string, 目前暂先使用 本地的 tmpJsonData 来做试验... 

    assert( (mapId==1) or (mapId==2) or (mapId==3) or (mapId==4)  )
    local testJsonFilePath = JsonPaths[mapId]

    -- ---------------- 异步加载资源 trackData ----------------------
    local jsonData = ""
    local loader_json = ResourceModule.LoadBundleAsync( testJsonFilePath, nil, true ) -- 不设回调, 不删除资源
    while not loader_json.IsCompleted do
        coroutine.yield(Yielders.EndOfFrame)
    end

    if loader_json.IsSuccess then
        jsonData = tostring(loader_json.ResultObject)
    else
        assert( false,  "!!! trackData 加载失败... " )
    end
    
    -- 原始数据尾端有杂余信息, 比如: "{\"a\":123}: 408484", 需要剥离
    jsonData = TrackDataReader.StripTail(jsonData)

    self.trackData = table.deserialize(jsonData) -- rapidjson.decode()
    assert( not isNull(self.trackData) )

    -------- 现在, self.trackData 就是完整的 trackData 数据 ----------
    
    -- 把 所有 pos 都替换成 vector3 类型:
    for i=1, #self.trackData.trackNodePesists do
        local tnp = self.trackData.trackNodePesists[i]
        local newPos = Vector3( tnp.pos.x, tnp.pos.y, tnp.pos.z )
        tnp.pos = newPos -- swap 这其实用到的是个指针的概念... 
    end

    for i=1, #self.trackData.trackPesists do 
        local e = self.trackData.trackPesists[i] 
        for j=1, #e.nodes do 
            local node = e.nodes[j]
            local newPos = Vector3( node.pos.x, node.pos.y, node.pos.z )
            node.pos = newPos -- swap 这其实用到的是个指针的概念... 
        end
    end


    loader_json:Release() -- 不需要持有, 直接释放

    print("~~ tpr ~~ TrackDataReader.ReadJson() success")
end



-- 从 .json ab资源中读取的 字符串尾段存在杂余信息, 比如: "{\"a\":123}: 408484", 需要剥离
---@return string
function TrackDataReader.StripTail( s )
    local ts = string.reverse(s)    -- 倒序
    local _,i = string.find(ts, '}') --获取k在反转后的str字符串ts的位置
    local m = string.len(ts) - i + 1 --获取k在字符串str中的位置
    local ret = string.sub(s, 1, m)  --返回字符串str字符k之前的部分
    return ret
end


-- 简单地打印 TrackData 内的数据
---@return void
function TrackDataReader:PrintTrackData() 

    local oStr = "TrackData 文件数据:"

    -- ------------------------------------------------------ 
    -- todo: editor 用数据, runtime 无意义
    -- maxBezierNodeDensity:
    oStr = oStr .. "\nmaxBezierNodeDensity [editor] = " .. tostring(self.trackData.maxBezierNodeDensity) 

    -- ------------------------------------------------------ 
    -- todo: editor 用数据, runtime 无意义
    -- currentTrackNodeGOId:
    oStr = oStr .."\ncurrentTrackNodeGOId [editor] = " .. tostring(self.trackData.currentTrackNodeGOId)

    -- ------------------------------------------------------ 
    -- trackNodePesists:
    oStr = oStr .. "\ntrackNodePesists: ------- num = " ..  #self.trackData.trackNodePesists
    for i=1, #self.trackData.trackNodePesists do
        local tnp = self.trackData.trackNodePesists[i]
        oStr = oStr .. "\n"
        .. "\n   id = "     .. tostring(tnp.id)
        .. "\n   isGear = " .. tostring(tnp.isGear)
        .. "\n   pos = " .. tnp.pos:ToString()

        .. "\n   othTrackNodeIDs: ---- num = " .. #tnp.othTrackNodeIDs 
        .. "\n        "
        for j=1, #tnp.othTrackNodeIDs do 
            oStr = oStr .. tostring(tnp.othTrackNodeIDs[j]) .. ", "
        end
    end

    -- ------------------------------------------------------ 
    -- trackPesists: 
    oStr = oStr .. "\ntrackPesists: ---- num = " .. #self.trackData.trackPesists 
    for i=1, #self.trackData.trackPesists do 
        local e = self.trackData.trackPesists[i] 
        oStr = oStr .. "\n"
        .. "\n   trackKey = "    .. tostring(e.trackKey) -- 废弃的 key
        .. "\n   trackKeyStr = "    .. tostring(e.trackKeyStr)
        .. "\n   totalLength = " .. tostring(e.totalLength)
        .. "\n   startTrackNodeID = " .. tostring(e.startTrackNodeID)
        .. "\n   endTrackNodeID = " .. tostring(e.endTrackNodeID)
        .. "\n   isTeleporting = " .. tostring(e.isTeleporting)

        .. "\n   nodes: ----- num = " .. #e.nodes 
        for j=1, #e.nodes do 
            local node = e.nodes[j]
            oStr = oStr .. "\n         t:" .. tostring(node.t) .. "; pos: " .. node.pos:ToString()
        end
    end
    oStr = oStr .. "\n\n"
    print(oStr)
end



return TrackDataReader

