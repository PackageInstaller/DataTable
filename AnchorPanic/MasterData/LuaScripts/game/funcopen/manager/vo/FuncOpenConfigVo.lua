--[[ 
-----------------------------------------------------
@filename       : FuncOpenConfigVo
@Description    : 功能开放配置
@date           : 2020-10-21 10:12:36
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.funcopen.manager.vo.FuncOpenConfigVo', Class.impl())

function parseData(self, cusId, cusData)
    -- 功能开放id
    self.id = cusId
    -- 指挥官等级要求
    self.lv = cusData.level
    -- 主线副本通关要求
    self.dupId = cusData.dupId
    -- 入口显示1常显
    self.event = cusData.event
    -- 功能名称
    self.name = cusData.name
    -- 是否常显
    self.event = cusData.event
    -- eventDupId
    self.eventDupId = cusData.event_dupId
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
