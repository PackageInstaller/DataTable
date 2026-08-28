--------------------------------
--- 地图解密活动(春节活动)配表数据管理类
--- 提供配表数据获取之类的方法

------------ define ------------
local BaseArgVo            = "BaseArgVo"
local MapDecryptionPlanVo = "MapDecryptionPlanVo"
local MapDecryptionTaskVo = "MapDecryptionTaskVo"
local MapDecryptionDecryptedMapsVo = "MapDecryptionDecryptedMapsVo"
local MapDecryption2DTipsVo = "MapDecryption2DTipsVo"
local MapDecryptionQuestVo = "MapDecryptionQuestVo"
local QuestRewardVo = "QuestRewardVo"
local MapDecryptionMainSceneInteractionVo = "MapDecryptionMainSceneInteractionVo"
local MapDecryptionFunctionEnterVo = "MapDecryptionFunctionEnterVo"
local MapDecryptionAntiqueRestorationVo = "MapDecryptionAntiqueRestorationVo"
local MapDecryptionInteractiveLinesVo = "MapDecryptionInteractiveLinesVo"
local MapDecryptionGossipPlotVo = "MapDecryptionGossipPlotVo"

local CfUtils              = CfUtils
local AutoIds              = AutoIds
local checkNumber          = checkNumber



------------ define ------------

---@class MapDecryptionConfMgr
local MapDecryptionConfMgr = Class("MapDecryptionConfMgr")

function MapDecryptionConfMgr:__init()
    self._activityContentId = nil
end

function MapDecryptionConfMgr:__delete()
    self._activityContentId = nil
end

function MapDecryptionConfMgr:InitActivityContentId(activityContentId)
    self._activityContentId = activityContentId
end

function MapDecryptionConfMgr:GetActivityContentId()
    return self._activityContentId
end


function MapDecryptionConfMgr:InitActivityPrefabId(prefabId)
    self._prefabId = checkNumber(prefabId)
end

--- GetParamById
--- 获取地图解密参数表对应id 参数
---@param id number 任务id
function MapDecryptionConfMgr:GetParamById(id)
    return checkNumber(CfUtils.GetCfVo(AutoIds.IdSetting2800, BaseArgVo, id).num)
end

--- GetPlanVoById
--- 根据id 获取 解密活动排期表 中数据
---@param id number 排期id
---@return MapDecryptionPlanVo
function MapDecryptionConfMgr:GetPlanVoById(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting2801, MapDecryptionPlanVo, id)
end

--- GetTaskVoById
--- 根据id 获取 地图解密任务表 中数据
---@param id number 任务id
---@return MapDecryptionTaskVo
function MapDecryptionConfMgr:GetTaskVoById(id)
    ---多活动 后端也会给 唯一id 直接取就行
    return CfUtils.GetCfVo(AutoIds.IdSetting2802, MapDecryptionTaskVo, id)
end


--- GetTaskVoById
--- 根据id 获取 地图解密任务表 中数据
---@return MapDecryptionTaskVo[]
function MapDecryptionConfMgr:GetAllTaskVo()
    ---多活动 后端也会给 唯一id 直接取就行
    return CfUtils.GetCf(AutoIds.IdSetting2802, MapDecryptionTaskVo, true)
end


--- GetDecryptedMapsById
--- 根据id 获取 解密地图表 中数据
---@param id number 任务id
---@return MapDecryptionDecryptedMapsVo
function MapDecryptionConfMgr:GetDecryptedMapsById(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting2807, MapDecryptionDecryptedMapsVo, id)
end

--- GetAllDecryptedMaps
--- 获取 所有 解密地图表 中数据
---@return MapDecryptionDecryptedMapsVo[]
function MapDecryptionConfMgr:GetAllDecryptedMaps()
    return CfUtils.GetCf(AutoIds.IdSetting2807, MapDecryptionDecryptedMapsVo, true)
end



--- GetDecryptedMapsById
--- 根据 groupId 获取 解密提示文本表 中对应行的数据
---@param groupId number 迷宫章节的 id
---@return MapDecryption2DTipsVo
function MapDecryptionConfMgr:GetTipsById( groupId )
    return CfUtils.GetCfVo(AutoIds.IdSetting3006, MapDecryption2DTipsVo, groupId )
end



--- GetAllDecryptedMaps
--- 获取 所有 追踪关卡表 中数据
---@return MapDecryptionQuestVo[]
function MapDecryptionConfMgr:GetAllQuestVos()
    local t = {}
    ---@type MapDecryptionQuestVo[]
    local vos = CfUtils.GetCf(AutoIds.IdSetting2809, MapDecryptionQuestVo, true)
    for i, vo in ipairs(vos) do
        if vo.activityId == self._activityContentId then
            table.insert(t, vo)
        end
    end
    
    return t
end

--- GetQuestVoById
--- 根据关卡id 获取 追踪关卡表 中数据
---@return MapDecryptionQuestVo
function MapDecryptionConfMgr:GetQuestVoById(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting2809, MapDecryptionQuestVo, id)
end

--- GetQuestRewardsVoById
--- 获取 所有 追踪关卡奖励表 中数据
---@return MapDecryptionQuestVo
function MapDecryptionConfMgr:GetQuestRewardsVoById(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting2810, QuestRewardVo, id)
end

--- GetFunctionEnterVoById
--- 获取 功能入口表 中数据
---@return MapDecryptionFunctionEnterVo
function MapDecryptionConfMgr:GetFunctionEnterVoById(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting2803, MapDecryptionFunctionEnterVo, id)
end

--- GetGossipPlotVoById
--- 获取 闲聊剧情表 中数据
---@return MapDecryptionGossipPlotVo
function MapDecryptionConfMgr:GetGossipPlotVoById(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting2811, MapDecryptionGossipPlotVo, id)
end

--- GetGossipPlotVosById
--- 根据剧情id 获取 闲聊剧情表 中数据
---@return MapDecryptionGossipPlotVo[]
function MapDecryptionConfMgr:GetGossipPlotVosById(id)
    local t = {}
    ---@type MapDecryptionGossipPlotVo[]
    local plotVos = CfUtils.GetCf(AutoIds.IdSetting2811, MapDecryptionGossipPlotVo, true)
    for i, v in ipairs(plotVos) do
        if v.storyId == id then
            table.insert(t, v)
        end
    end
    return t
end

--- GetRotaryTableRewardVoById
--- 获取 转盘奖励表 中数据
---@return MapDecryptionRotaryTableRewardVo
function MapDecryptionConfMgr:GetRotaryTableRewardVoById(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting2812, "MapDecryptionRotaryTableRewardVo", id)
end

--- GetRotaryTableRewardVoById
--- 获取 转盘配置表 中数据
---@return MapDecryptionRotaryTableConfigVo
function MapDecryptionConfMgr:GetRotaryTableConfigVoById(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting2813, "MapDecryptionRotaryTableConfigVo", id)
end

--- GetAllMainSceneInteractions
--- 获取 所有 场景互动表 中数据
---@return MapDecryptionMainSceneInteractionVo[]
function MapDecryptionConfMgr:GetAllMainSceneInteractions()
    local t = {}
    ---@type MapDecryptionMainSceneInteractionVo[]
    local vos = CfUtils.GetCf(AutoIds.IdSetting2808, MapDecryptionMainSceneInteractionVo, true)
    for i, vo in ipairs(vos) do
        if vo.activityId == self._activityContentId then
            table.insert(t, vo)
        end
    end

    return t
end

--- GetAllAntiqueRestorations
--- 获取 所有 古物修复表 中数据
function MapDecryptionConfMgr:GetAllAntiqueRestorations()
    local t = {}
    ---@type MapDecryptionAntiqueRestorationVo[]
    local vos = CfUtils.GetCf(AutoIds.IdSetting2804, MapDecryptionAntiqueRestorationVo, true)
    for i, vo in ipairs(vos) do
        if vo.activityId == self._activityContentId then
            table.insert(t, vo)
        end
    end

    return t
end

--- GetAntiqueRestorationsById
---@param id number 古物修复表id
---@return MapDecryptionAntiqueRestorationVo
function MapDecryptionConfMgr:GetAntiqueRestorationsById(id)
    return CfUtils.GetCfVo(AutoIds.IdSetting2804, MapDecryptionAntiqueRestorationVo, id)
end

--- GetAllInteractiveLinesVo
---@param interactId number 交互Id 即: NPCId
---@param interactType number MapDecryptionConstants.TalkSceneType 互动台词场景表 id
---@return MapDecryptionInteractiveLinesVo[]
function MapDecryptionConfMgr:GetAllInteractiveLinesVo(interactId, interactType)
    local t = {}
    ---@type MapDecryptionInteractiveLinesVo[]
    local vos = CfUtils.GetCf(AutoIds.IdSetting2805, MapDecryptionInteractiveLinesVo, true)
    for i, vo in ipairs(vos) do
        if vo.interactId == interactId and vo.scene == interactType then
            table.insert(t, vo)
        end
    end

    return t
    
end

function MapDecryptionConfMgr:GetPrefabId()
    return self._prefabId
end

return MapDecryptionConfMgr