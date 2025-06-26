--[[ 
-----------------------------------------------------
@filename       : HeroInteractManager
@Description    : 英雄互动管理
@date           : 2020-12-07 20:04:51
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.hero.manager.HeroInteractManager', Class.impl(Manager))

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
    self.mConfigData = nil
end

-- 解析英雄互动配置
function parseConfigData(self)
    self.mConfigData = {}
    local baseData = RefMgr:getData("hero_interact_data")
    for key, data in pairs(baseData) do
        self.mConfigData[key] = data
    end
    self.mDynamicData = {}
    local baseData = RefMgr:getData("mainui_dynamic")
    for key, data in pairs(baseData) do
        self.mDynamicData[key] = data
    end
end

-- 获取英雄互动配置数据
function getConfigData(self, cusId)
    if not self.mConfigData then
        self:parseConfigData()
    end
    return self.mConfigData[cusId]
end

function getConfigData01(self, baseModelId, modelId, actionName)
    local baseData = self:getConfigData(modelId)
    if not baseData then
        baseData = self:getConfigData(baseModelId)
    end
    if baseData then
        for _, data in ipairs(baseData.interact) do
            if actionName == data.action then
                return data
            end
        end
    end
end

-- 取模型是否有动态立绘
function getModelIsDynamic(self, modelId)
    if not self.mDynamicData then
        self:parseConfigData()
    end
    return self.mDynamicData[modelId]
end

-- 取主UI模型是否有动态立绘
function getShowBoardHeroDynamic(self)
    local showId = role.RoleManager:getRoleVo():getShowBoardHeroId()
    local heroVo = hero.HeroManager:getHeroVo(showId)
    if not heroVo then
        return false
    end
    local data = self:getModelIsDynamic(heroVo:getHeroModel())
    return (data and data.dynamic == 1)
end

-- 取主UI模型是否有专属互动
function getShowBoardUnique(self)
    local showId = role.RoleManager:getRoleVo():getShowBoardHeroId()
    local heroVo = hero.HeroManager:getHeroVo(showId)
    if not heroVo then
        return false
    end
    local data = self:getModelIsDynamic(heroVo:getHeroModel())
    return (data and data.isUnique == 1)
end

-- 取主界面展示的模型id
function getShowBoardHeroModelId(self)
    local showId = role.RoleManager:getRoleVo():getShowBoardHeroId()
    local heroVo = hero.HeroManager:getHeroVo(showId)
    if not heroVo then
        return nil
    end
    return heroVo:getHeroModel()
end

-- 获取配置里得cv延迟播放时间
function getCvDataLayBack(self, baseData)
    local data = systemSetting.SystemSettingManager:getCurCvTypeSettingCfg()
    local fieldName = data[3]
    local voice_layback = baseData[fieldName]
    if not voice_layback then
        logError(string.format("hero_interact_data 音效延迟配置错误，当前语音切换字段是%s没有配置: /n/r %s",
        tostring(voice_layback), table.tostring(data)))
    end
    return voice_layback and voice_layback / 1000 or 0
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]