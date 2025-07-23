--[[ 
-----------------------------------------------------
@filename       : LinkManager
@Description    : ui跳转链接
@date           : ***
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.link.manager.LinkManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

--初始化
function __init(self)
    self.uiCodeData = nil
end

function parseConfigData(self)
    self.uiCodeData = {}
    local baseData = RefMgr:getData("ui_code_data")
    for key, data in pairs(baseData) do
        local configVo = link.LinkConfigVo.new()
        configVo:parseData(key, data)
        self.uiCodeData[key] = configVo
    end

    self.navigationList = {}
    local baseData = RefMgr:getData("navi_data")
    for key, data in pairs(baseData) do
        local configVo = link.NavigationConfigVo.new()
        configVo:parseData(key, data)
        table.insert(self.navigationList, configVo)
    end
end

-- uicode配置
function getLinkData(self, cusId)
    if not self.uiCodeData then
        self:parseConfigData()
    end
    return self.uiCodeData[cusId]
end

-- 导航栏配置
function getNavigationList(self)
    if not self.navigationList then
        self:parseConfigData()
    end
    return self.navigationList
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]