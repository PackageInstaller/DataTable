--[[ 
-----------------------------------------------------
@filename       : ManualMusicManager
@Description    : 图鉴-音乐
@date           : 2023-3-6 16:23:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualMusicManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)
    self.mManualMusicConfigDic = nil
    self.mManualMusicConfigList = {}
    self.mManualMusicMsgList = {}
    self.mCurManualMusicID = 1
end

-- 解析图鉴配置
function parseManualMusicConfig(self)
    self.mManualMusicConfigDic = {}
    self.mManualMusicConfigList = {}
    local baseData = RefMgr:getData("manual_music_data")
    for key, data in pairs(baseData) do
        local vo = manual.ManualMusicVo.new()
        vo:parseData(key, data)
        self.mManualMusicConfigDic[vo.musicId] = vo
        table.insert(self.mManualMusicConfigList, vo)
    end
    table.sort(self.mManualMusicConfigList, function(vo1, vo2) return vo1.sort < vo2.sort end)
end

--解析怪物页签配置
function parseManualMusicMsg(self, args)
    if args then
        for _, musicVo in ipairs(args.music_list) do
            if not table.indexof(self.mManualMusicMsgList, musicVo) then
                table.insert(self.mManualMusicMsgList, musicVo)
            end
        end
        table.sort(self.mManualMusicMsgList, function(a, b) return a < b end)
    end
end

function getIsUnlock(self, id)
    return (table.indexof(self.mManualMusicMsgList, id) ~= false)
end

function getManualMusicMsgList(self)
    return self.mManualMusicMsgList or {}
end

function getUnlockNum(self)
    local count = 0
    for _, musicVo in ipairs(self:getManualMusicList()) do
        count = count + 1
    end
    return math.floor(count / #self.mManualMusicConfigList * 100)
end

-- 是否是最新的
function getIsNew(self, musicId)
    if read.ReadManager:isModuleRead(ReadConst.MANUAL_MUSIC, musicId) == false then
        return false
    else
        return true
    end
end

--获取音乐列表
function getManualMusicList(self)
    local list = {}
    if #self.mManualMusicConfigList <= 0 then
        self:parseManualMusicConfig()
    end
    for _, musicVo in ipairs(self.mManualMusicConfigList) do
        if musicVo:getIsUnlock() then
            table.insert(list, musicVo)
        end
    end
    return list
end

function getAllHaveNew(self)
    for _, musicVo in ipairs(self:getManualMusicList()) do
        if self:getIsNew(musicVo.musicId) then
            return true
        end
    end
    return false
end
--通过获取音乐Vo
function getManualMusicVoByMusicId(self, musicId)
    local list = {}
    if not self.mManualMusicConfigDic then
        self:parseManualMusicConfig()
    end
    if self.mManualMusicConfigDic[musicId] then
        return self.mManualMusicConfigDic[musicId]
    end
    return nil
end

--获取当前播放的音乐
function getCurManualMusicMusicId(self)
    return self.mCurManualMusicID or 1
end
--修改当前播放的音乐
function setCurManualMusicMusicId(self, musicId)
    if self.mCurManualMusicID ~= musicId then
        self.mCurManualMusicID = musicId
        GameDispatcher:dispatchEvent(EventName.UPDATE_MUSIC_ITEM, { self.mCurManualMusicID })
    end
end
--下一首歌
function getManualNextMusicId(self)
    local curIndex = table.indexof01(self.mManualMusicMsgList, self.mCurManualMusicID)
    local nextIndex = (curIndex < #self.mManualMusicMsgList) and curIndex + 1 or curIndex - #self.mManualMusicMsgList + 1
    self:setCurManualMusicMusicId(self.mManualMusicMsgList[nextIndex])
end
--上一首歌
function getManualLastMusicId(self)
    local curIndex = table.indexof01(self.mManualMusicMsgList, self.mCurManualMusicID)
    local lastIndex = curIndex > 1 and curIndex - 1 or #self.mManualMusicMsgList - curIndex + 1
    self:setCurManualMusicMusicId(self.mManualMusicMsgList[lastIndex])
end

--下一首歌
function getManualNextMusicVo(self, id)
    local curIndex = table.indexof01(self.mManualMusicMsgList, id)
    local nextIndex = (curIndex < #self.mManualMusicMsgList) and curIndex + 1 or curIndex - #self.mManualMusicMsgList + 1
    return self.mManualMusicMsgList[nextIndex]
end

--上一首歌
function getManualLastMusicVo(self, id)
    local curIndex = table.indexof01(self.mManualMusicMsgList, id)
    local lastIndex = curIndex > 1 and curIndex - 1 or #self.mManualMusicMsgList - curIndex + 1
    return self.mManualMusicMsgList[lastIndex]
end

-- 获取图鉴怪物配置列表
function getCurIndex(self, musicId)
    return table.indexof01(self.mManualMusicMsgList, musicId)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]