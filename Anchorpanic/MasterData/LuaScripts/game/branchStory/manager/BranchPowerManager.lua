module("branchStory.BranchPowerManager", Class.impl(Manager))

--构造函数
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构函数
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

function __init(self)

    self.mPowerStageList = nil
    self.mPowerStageDic = nil

    --已经通过的副本id
    self.mPassList = nil
end

function parsePowerInfo(self, msg)
    self.mPassList = msg.pass_list

    GameDispatcher:dispatchEvent(EventName.UPDATE_BRANCH_POWER_PANEL)
end

--是否已经通过
function isPass(self, id)
    if self.mPassList == nil then
        return false
    end
    return table.indexof01(self.mPassList, id) > 0
end

-- 初始化关卡配置表
function parsePowerStageConfig(self)
    self.mPowerStageList = {}
    self.mPowerStageDic = {}
    local baseData = RefMgr:getData("power_train_data")
    for stageId, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(branchStory.BranchPowerChapterVo)
        vo:parseData(stageId, data)
        self.mPowerStageDic[stageId] = vo
        table.insert(self.mPowerStageList, vo)
    end
end

function getPowerChapterConfig(self)
    if (not self.mPowerStageList) then
        self:parsePowerStageConfig()
    end
    return self.mPowerStageList
end

function getPowerVo(self, stageId)
    if (not self.mPowerStageDic) then
        self:parsePowerStageConfig()
    end
    return self.mPowerStageDic[stageId]
end

function setLastId(self, stageId)
    self.lastId = stageId
end

function getLastVo(self)
    if (not self.mPowerStageDic) then
        self:parsePowerStageConfig()
    end
    return self.mPowerStageDic[self.lastId]
end

-- 战斗结算界面用
function getDupName(self, stageId)
    local stageVo = self:getPowerVo(stageId)
    return _TT(stageVo.mName)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]