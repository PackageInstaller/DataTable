--[[ 
-----------------------------------------------------
@filename       : WaterpipeGameManager
@Description    : 剧情游戏——接水管
@date           : 2020-12-24 16:31:09
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.storyGame.manager.WaterpipeGameManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end

--初始化
function init(self)
end

-- 解析配置
function parseBaseConfigData(self)
    self.waterpipBaseData = {}
    local baseData = RefMgr:getData("waterpipe_data")
    for key, data in pairs(baseData) do
        local vo = storyGame.WaterpipeBaseVo.new()
        vo:parseData(key, data)
        self.waterpipBaseData[key] = vo
    end
end

-- 解析配置
function parseGameConfigData(self)
    self.waterpipGameData = {}
    local baseData = RefMgr:getData("waterpipe_game_data")
    for key, data in pairs(baseData) do
        local vo = storyGame.WaterpipeGameVo.new()
        vo:parseData(key, data)
        self.waterpipGameData[key] = vo
    end
end

-- 获取指定水管格子数据
function getWaterpipeBaseData(self, cusId)
    if not self.waterpipBaseData then
        self:parseBaseConfigData()
    end
    return self.waterpipBaseData[cusId]
end

-- 获取接水管游戏类型配置
function getWaterpipeGameData(self, cusId)
    if not self.waterpipGameData then
        self:parseGameConfigData()
    end
    return self.waterpipGameData[cusId]
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
