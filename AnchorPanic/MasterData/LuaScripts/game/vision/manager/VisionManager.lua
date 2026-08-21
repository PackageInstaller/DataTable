module("vision.VisionManager", Class.impl(Manager))

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()
end

function __initData(self)
    self.mViewList = {}
    self.mVisionMirrorData = nil
    self.mVisionMirrorStageData = nil
    self.mVisionMirrorPassDupList = {}
    self.mVisionMirrorDupList = {}
    self.mVisionMirrorRankPanelVo = nil
    self.mIsRedPoint = false  -- 异象残境镜像红点状态
    self.mCurVisionLayer = nil  -- 当前打开镜像阵型对应的层数（点击 item 时写入，供阵型面板取用）
end

-- 记录当前打开镜像阵型对应的层数
function setCurVisionLayer(self, layer)
    self.mCurVisionLayer = layer
end

-- 获取当前打开镜像阵型对应的层数（优先于阵型单例的 m_dataId，避免打开顺序导致取不到）
function getCurVisionLayer(self)
    return self.mCurVisionLayer
end

-- 析构函数
function dtor(self)
end

function parseVisionMirrorData(self)
    self.mVisionMirrorData = {}
    local baseData = RefMgr:getData("vision_mirror_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(vision.VisionMirrorVo)
        vo:parseData(id, data)
        self.mVisionMirrorData[id] = vo
    end
end

function getVisionMirrorData(self)
    if self.mVisionMirrorData == nil then
        self:parseVisionMirrorData()
    end
    return self.mVisionMirrorData
end

function getVisionMirrorDataById(self, id)
    if self.mVisionMirrorData == nil then
        self:parseVisionMirrorData()
    end
    return self.mVisionMirrorData[id]
end

function getVisionRoundData(self, roundId)
    return self:getVisionMirrorDataById(roundId)
end

function parseVisionMirrorStageData(self)
    self.mVisionMirrorStageData = {}
    local baseData = RefMgr:getData("vision_mirror_stage_data")
    for id, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(vision.VisionMirrorStageVo)
        vo:parseData(id, data)
        self.mVisionMirrorStageData[id] = vo
    end
end

function getVisionMirrorStageData(self)
    if self.mVisionMirrorStageData == nil then
        self:parseVisionMirrorStageData()
    end
    return self.mVisionMirrorStageData
end

function getVisionMirrorStageDataById(self, id)
    if self.mVisionMirrorStageData == nil then
        self:parseVisionMirrorStageData()
    end
    return self.mVisionMirrorStageData[id]
end

function getVisionCityStageData(self)
    return self:getVisionMirrorStageData()
end

function getVisionCityStageDataById(self, id)
    return self:getVisionMirrorStageDataById(id)
end

function getDupName(self, cusId)
    local stageVo = self:getVisionCityStageDataById(cusId)
    return "", stageVo and stageVo:getName() or ""
end

function getExtraHeros(self, cusId)
    local stageVo = self:getVisionCityStageDataById(cusId)
    return stageVo and stageVo.extraHeros or {}
end

function getRecommandFight(self, cusId)
    return 0
end

function parseVisionMirrorPassDupPanelMsg(self, msg)
    self.mVisionMirrorPassDupList = {}
    for i, v in ipairs(msg.pass_layer_list or {}) do
        local vo = LuaPoolMgr:poolGet(vision.VisionMirrorPassDupVo)
        vo:parseMsg(v)
        table.insert(self.mVisionMirrorPassDupList, vo)
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_VISION_MIRROR_PASS_DUP_PANEL)
end

function getVisionMirrorPassDupList(self)
    return self.mVisionMirrorPassDupList
end

function getVisionMirrorPassDupVoByLayer(self, layer)
    for i, vo in ipairs(self.mVisionMirrorPassDupList or {}) do
        if vo.layer == layer then
            return vo
        end
    end
    return nil
end

-- 获取服务器下发的指定关卡分数（未通关则默认 0）
function getServerScoreByStageId(self, stageId)
    local vo = self:getVisionMirrorPassDupVoByLayer(stageId)
    return vo and vo.score or 0
end

-- 获取服务器下发的「指定层 + 指定关卡」分数：从 pt_pass_vision_mirror_layer.dup_list 中
-- 按 dup_id 命中当前关卡的 score（最终评分），未通关或匹配不到默认 0
function getServerScoreByLayerAndDupId(self, layer, dupId)
    local vo = self:getVisionMirrorPassDupVoByLayer(layer)
    if not vo or not vo.dupList then
        return 0
    end
    for i, v in ipairs(vo.dupList) do
        if v.dupId == dupId then
            return v.score or 0
        end
    end
    return 0
end

-- 获取服务器下发的指定层真实关卡 id 列表
function getServerDupListByLayer(self, layer)
    local vo = self:getVisionMirrorDupVoByLayer(layer)
    if vo and vo.dupList then
        return vo.dupList
    end
    return {}
end

-- 获取服务器下发的指定层真实关卡 id（来自 ALL_DUP_PANEL 的 dup_list，多个以逗号拼接）
function getServerDupIdByLayer(self, layer)
    local dupList = self:getServerDupListByLayer(layer)
    if dupList and #dupList > 0 then
        return table.concat(dupList, ",")
    end
    return ""
end

-- 获取服务器下发的指定层首个真实关卡 id
function getServerFirstDupIdByLayer(self, layer)
    local dupList = self:getServerDupListByLayer(layer)
    if dupList and #dupList > 0 then
        return dupList[1]
    end
    return nil
end

-- 按层和队伍索引获取真实关卡配置
function getVisionMirrorStageDataByLayerAndIndex(self, layer, index)
    local dupList = self:getServerDupListByLayer(layer)
    local dupId = dupList and dupList[index]
    if dupId then
        return self:getVisionMirrorStageDataById(dupId)
    end
    if index == 1 then
        return self:getVisionMirrorStageDataById(layer)
    end
    return nil
end

-- 按层获取真实关卡配置（优先使用服务器下发的真实关卡 id，兼容直接传关卡 id）
function getVisionMirrorStageDataByLayer(self, layer)
    return self:getVisionMirrorStageDataByLayerAndIndex(layer, 1)
end

function parseVisionMirrorAllDupPanelMsg(self, msg)
    self.mVisionMirrorDupList = {}
    for i, v in ipairs(msg.dup_list or {}) do
        local vo = LuaPoolMgr:poolGet(vision.VisionMirrorDupVo)
        vo:parseMsg(v)
        table.insert(self.mVisionMirrorDupList, vo)
    end

    GameDispatcher:dispatchEvent(EventName.UPDATE_VISION_MIRROR_ALL_DUP_PANEL)
end

function getVisionMirrorDupList(self)
    return self.mVisionMirrorDupList
end

function getVisionMirrorDupVoByLayer(self, layer)
    for i, vo in ipairs(self.mVisionMirrorDupList or {}) do
        if vo.layer == layer then
            return vo
        end
    end
    return nil
end

function parseVisionMirrorRankPanelMsg(self, msg)
    local vo = LuaPoolMgr:poolGet(vision.VisionMirrorRankPanelVo)
    vo:parseMsg(msg)
    self.mVisionMirrorRankPanelVo = vo

    GameDispatcher:dispatchEvent(EventName.UPDATE_VISION_MIRROR_RANK_PANEL)
end

function getVisionMirrorRankPanelVo(self)
    return self.mVisionMirrorRankPanelVo
end

-- 异象残境镜像红点（参考 doundless：SC -> updateRed -> MainUIManager:setRedFlag）
function updateRed(self, msg)
    self.mIsRedPoint = msg.red_point == 1
    mainui.MainUIManager:setRedFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, self.mIsRedPoint, funcopen.FuncOpenConst.FUNC_ID_VISION)
end

function getRedFlag(self)
    return self.mIsRedPoint
end

function getVisionMirrorRankList(self)
    return self.mVisionMirrorRankPanelVo and self.mVisionMirrorRankPanelVo:getRankList() or {}
end

function getVisionMirrorMyRank(self)
    return self.mVisionMirrorRankPanelVo and self.mVisionMirrorRankPanelVo.myRank or 0
end

function getVisionMirrorMyRankVal(self)
    return self.mVisionMirrorRankPanelVo and self.mVisionMirrorRankPanelVo.myRankVal or 0
end

return _M


