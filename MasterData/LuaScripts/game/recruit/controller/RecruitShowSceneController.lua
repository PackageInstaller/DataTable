module("fight.RecruitShowSceneController", Class.impl(map.MapBaseController))

function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
    self:__init()
    self:clearMap()
end

function __init(self)

end

-- 加载场景完的调用
function enterMap(self)
    super.enterMap(self)

    local ui_main_21 = gs.GameObject.Find("ui_main_21")
    recruit.RecruitTween:onLoadComplete_21(ui_main_21)
end

-- 关闭当前地图
function clearMap(self)

    super.clearMap(self)
end

-- 地图类型
function getMapType(self)
    return MAP_TYPE.RECRUIT_SHOWSCENE
end

-- 地图资源名
function getMapID(self)
    return 5
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
