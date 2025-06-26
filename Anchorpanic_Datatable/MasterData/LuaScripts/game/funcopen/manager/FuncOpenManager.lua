--[[ 
-----------------------------------------------------
@filename       : FuncOpenManager
@Description    : 功能开放数据管理
@date           : 2020-10-19 15:14:14
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.funcopen.manager.FuncOpenManager', Class.impl(Manager))

--构造
function ctor(self)
    super.ctor(self)
    self:__init()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

--析构
function dtor(self)
end

--初始化
function __init(self)
    self.funcOpenBaseData = nil
    self.funcOpenList = {}
end

-- 解析配置
function parseConfigData(self)
    self.funcOpenBaseData = {}
    local baseData = nil
    local channelId, channelName = sdk.SdkManager:getChannelData()
    if(GameManager:getIsInCommiting() and (channelId == sdk.AndroidChannelId.QIANYOU or channelId == sdk.AndroidChannelId.QUICK or channelId == sdk.AndroidChannelId.QUICK2 or channelId == sdk.AndroidChannelId.QUICK3))then
        if(web.WebManager.net_type == web.NET_TYPE.OUTER_TEST)then
            baseData = RefMgr:getData("function_open_channel_test")
        else
            baseData = RefMgr:getData("function_open_channel")
        end
    else
        baseData = RefMgr:getData("function_open")
    end
    for key, data in pairs(baseData) do
        local vo = funcopen.FuncOpenConfigVo.new()
        vo:parseData(key, data)
        self.funcOpenBaseData[key] = vo
    end
end

-- 初始化功能开启
function onFunctionOpenListMsg(self, msg)
    for _, id in ipairs(msg.function_open_list) do
        table.insert(self.funcOpenList, id)
    end
    GameDispatcher:dispatchEvent(EventName.FUNC_OPEN_DATA_INIT)
end

-- 新增功能开放
function onAddFunctionOpenMsg(self, msg)
    table.insert(self.funcOpenList, msg.function_id)

    -- gs.Message.Show("功能开启:::id " .. msg.function_id .. " " .. self:getFuncOpenData(msg.function_id).name)
    GameDispatcher:dispatchEvent(EventName.FUNC_OPEN_UPDATE, { funcId = msg.function_id })
    note.NoteManager:dispatchEvent(note.NoteManager.FUN_OPEN_UPDATE, msg.function_id)
end

-- 获取功能开放配置数据
function getFuncOpenData(self, cusId)
    if not self.funcOpenBaseData then
        self:parseConfigData()
    end
    return self.funcOpenBaseData[cusId]
end

-- 获取已开放的功能开放id列表
function getFuncOpenList(self)
    return self.funcOpenList
end

-- 功能是否开启
function isOpen(self, cusId, cusShowTips)
    if table.indexof(self.funcOpenList, cusId) == false then
        local vo = self:getFuncOpenData(cusId)
        if (not vo) then
            Debug:log_error("FuncOpenManager", string.format("找不到功能开启配置id：%s , 发群里@繁sir", cusId))
        end
        if vo and cusShowTips then
            local str = ""
            local roleLvl = role.RoleManager:getRoleVo():getPlayerLvl()
            if roleLvl < vo.lv then
                if (vo.lv >= 999) then
                    str = _TT(47102)
                else
                    str = _TT(46, vo.lv)
                end
            else
                if vo.dupId > 0 then
                    local stageVo = battleMap.MainMapManager:getStageVo(vo.dupId)
                    str = _TT(47, stageVo.indexName)
                end
            end
            gs.Message.Show(str)
        end
        return false, vo.lv
    end
    return true, 1
end

-- 入口是否显示
function isShow(self, cusId) 
    if not table.indexof(self.funcOpenList, cusId) then
        local vo = self:getFuncOpenData(cusId)
        if (not vo) then
            Debug:log_error("FuncOpenManager", string.format("找不到功能开启配置id：%s , 发群里@繁sir", cusId))
        else
            local stageId = battleMap.MainMapManager:getMainMapCurStage()
            if vo.event == 1 and vo.eventDupId <= stageId then
                return true
            end
        end
        return false
    end
    return true
end

-- 获取功能开启条件
function getIsOpenTip(self, cusId)
    if table.indexof(self.funcOpenList, cusId) == false then
        local vo = self:getFuncOpenData(cusId)
        if (not vo) then
            Debug:log_error("FuncOpenManager", string.format("找不到功能开启配置id：%s , 发群里@繁sir", cusId))
        end
        if vo then
            local str = ""
            local roleLvl = role.RoleManager:getRoleVo():getPlayerLvl()
            if roleLvl < vo.lv then
                if (vo.lv >= 999) then
                    str = _TT(47102)
                else
                    str = _TT(46, vo.lv)
                end
            else
                if vo.dupId > 0 then
                    local stageVo = battleMap.MainMapManager:getStageVo(vo.dupId)
                    str = _TT(47, stageVo.indexName)
                end
            end
            return str
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71316):	"敬请期待"
]]