--[[
    加载过渡配置
]]

local LoadingDataRo = require('rodata/LoadingDataRo')
module('LoadOnManager', Class.impl("lib.event.EventDispatcher"))

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 析构函数
function dtor(self)
end

-- 初始化配置表
function parseConfigData(self)
    self.m_loadOnConfigList = {}
    local baseData = nil
    local channelId, channelName = sdk.SdkManager:getChannelData()
    if(GameManager:getIsInCommiting() and (channelId == sdk.AndroidChannelId.QIANYOU or channelId == sdk.AndroidChannelId.QUICK or channelId == sdk.AndroidChannelId.QUICK2 or channelId == sdk.AndroidChannelId.QUICK3))then
        baseData = RefMgr:getData("loading_data_channel")
    else
        baseData = RefMgr:getData("loading_data")
    end
    for refID, data in pairs(baseData) do
        local ro = LuaPoolMgr:poolGet(LoadingDataRo)
        ro:parseData(refID, data)
        table.insert(self.m_loadOnConfigList, ro)
        self.m_loadOnConfigList[refID] = ro
    end
end

function getListByCondition(self)
    if(not self.m_loadOnConfigList)then
        self:parseConfigData()
    end
    if(self.m_loadOnConfigList)then
        local list = {}
        local roleLvl = role.RoleManager:getRoleVo():getPlayerLvl()
        local mainStageId = battleMap.MainMapManager:getMainMapCurStage()
        if(roleLvl and mainStageId)then
            for k, data in pairs(self.m_loadOnConfigList)do
                if(roleLvl >= data:getLevel() and mainStageId >= data:getDupId()) then
                    local battleType, dupId = self:getNowBattleSign()
                    if(battleType == nil and dupId == nil)then
                        table.insert(list, data)
                    else
                        if(battleType == PreFightBattleType.MainMapStage)then
                            if(table.indexof(data:getBgDupList(), dupId) ~= false)then
                                table.insert(list, data)
                            end
                        else
                            table.insert(list, data)
                        end
                    end
                end
            end
            return list
        end
    end
    return {}
end

function getRandomRo(self, loadingDataRo)
    local list = self:getListByCondition()
    if(#list > 0)then
        if(not loadingDataRo)then
            local idx = math.random(1, #list)
            return list[idx]
        else
            local ro = nil
            for i = 1, #list do
                if(list[i]:getRefID() > loadingDataRo:getRefID())then
                    ro = list[i]
                    break
                end
            end
            return ro or list[1]
        end
    else
        if role.RoleManager.isRoleDataInit and battleMap.MainMapManager.isDataInit then
            Debug:log_error("LoadOnManager", "请检查loading_data的关卡加载背景是不是漏配")
        end
    end
    return nil
end

function getLoadingDataRo(self, refID)
    if(not self.m_loadOnConfigList)then
        self:parseConfigData()
    end

    return self.m_loadOnConfigList[refID]
end

function setNowBattleSign(self, battleType, dupId)
    self.mLoadBattleType = battleType
    self.mLoadDupId = dupId
end

function getNowBattleSign(self)
    return self.mLoadBattleType, self.mLoadDupId
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
