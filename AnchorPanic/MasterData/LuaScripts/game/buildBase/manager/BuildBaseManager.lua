module('game.buildBase.manager.BuildBaseManager', Class.impl(Manager))

SHOW_POWER_TIPS = "SHOW_POWER_TIPS"
------------------------------------------------------------
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:__initData()
end

-- 析构函数
function dtor(self)

end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__initData()
end

function __initData(self)
    self.mBuildBaseFacInfo = {}
    self.mBuildBaseInfo = {}
    self.mBuildBaseHeroInfo = {}
    self.mNowBuildId = 0
    -- 无人机货币
    self.mAllDroneNum = 0
    -- 战舰总电力
    self.mAllPower = 0
    -- 战舰剩余电力
    self.mRemainPower = 0
    self.mNowSelectFacOrderType = 1
end

---------------------------------------------------------------- 服务器数据 ----------------------------------------------------------------
function parseShipMsg(self, buildingList)
    if next(buildingList) then
        for k, v in pairs(buildingList) do
            local vo = LuaPoolMgr:poolGet(buildBase.BuildBaseMsgVo)
            vo:parseData(v)
            self.mBuildBaseInfo[vo.id] = vo
        end
        self:updateDroneNum()
        self:updatePower()
    end
    GameDispatcher:dispatchEvent(EventName.UPDATE_BUILDBASE_VIEW)
end

function updateMultShipInfo(self, msg)
    for k, v in pairs(msg.building_list) do
        self:updateShipInfo(v)
        if self.mNowBuildId == v.building_id then
            self:setNowBuildId(v.building_id)
        end
    end
    self:updateDroneNum()
    self:updatePower()
    GameDispatcher:dispatchEvent(EventName.UPDATE_BUILDBASE_VIEW)
end

function updateShipInfo(self, msg)
    if (self.mBuildBaseInfo[msg.building_id]) then
        self.mBuildBaseInfo[msg.building_id]:parseData(msg)
    else
        local vo = LuaPoolMgr:poolGet(buildBase.BuildBaseMsgVo)
        vo:parseData(msg)
        self.mBuildBaseInfo[vo.id] = vo
    end
end

-- 获取除了总控中心外达到等级的数量
function getBuildBaseCanLvCount(self, needLv)
    local count = 0
    for k, v in pairs(self.mBuildBaseInfo) do
        local buildType = buildBase.BuildBaseManager:getBuildBasePosDataByPos(k).buildType
        if buildType ~= buildBase.BuildBaseType.ControllerCenter and v.lv >= needLv then
            count = count + 1
        end
    end
    return count
end

-- 更新战舰总电力和剩余电力
function updatePower(self)
    local needPower, providePower = 0, 0
    for k, v in pairs(self.mBuildBaseInfo) do
        local buildType = buildBase.BuildBaseManager:getBuildBasePosDataByPos(k).buildType
        local levelsData = buildBase.BuildBaseManager:getBuildBaseLevelNeedData(buildType)

        local curLevelData = levelsData:getLevelDataVo(v.lv)
        if buildType == buildBase.BuildBaseType.PowerStation then
            providePower = providePower + curLevelData.needPower
        else
            needPower = needPower + curLevelData.needPower
        end
    end
    self.mAllPower = providePower
    self.mRemainPower = needPower
    self.currentPower = providePower - needPower

end

-- 获得当前剩余电力(发电站-其他建筑)
function getCurrentPower(self)
    if (self.currentPower ~= nil) then
        return self.currentPower
    else
        return 0
    end
end

-- 获得当前发电站时间 
function getPlantTime(self)
    local fullTime, startTime = 0, 0
    local mTimeList = {}
    for k, buildBaseMsgVo in pairs(self.mBuildBaseInfo) do
        local buildType = buildBase.BuildBaseManager:getBuildBasePosDataByPos(k).buildType
        if buildType == buildBase.BuildBaseType.PowerStation then
            table.insert(mTimeList, { fullTime = buildBaseMsgVo.fullTime, startTime = buildBaseMsgVo.startTime })
        end
    end
    if next(mTimeList) then
        table.sort(mTimeList, function(a, b)
            return a.fullTime < b.fullTime
        end)
    end
    if mTimeList[1] then
        fullTime, startTime = mTimeList[1].fullTime, mTimeList[1].startTime
    end
    return fullTime, startTime
end

-- 获取当前的电力跟所提供的电力
function getCurrentAndConsumePower(self)
    if (self.currentPower ~= nil and self.mAllPower ~= nil) then
        return self.currentPower, self.mAllPower
    else
        return 0, 0
    end
end

-- 获取消耗的电力跟所提供的电力
function getNeedAndConsumePower(self)
    if (self.mRemainPower ~= nil and self.mAllPower ~= nil) then
        return self.mRemainPower, self.mAllPower
    else
        return 0, 0
    end
end

-- 更新无人机数量
function updateDroneNum(self)
    local value = 0
    for k, buildBaseMsgVo in pairs(self.mBuildBaseInfo) do
        local buildType = buildBase.BuildBaseManager:getBuildBasePosDataByPos(k).buildType
        if buildType == buildBase.BuildBaseType.PowerStation then
            value = buildBaseMsgVo.produce
        end
    end
    self.mAllDroneNum = value
    buildBase.BuildBaseManager:dispatchEvent(buildBaseEvent.ON_CONVERT_UAV)
end

-- 获取当前可领取的资源数量
function getAllProduceNum(self)
    local value = 0
    for k, buildBaseMsgVo in pairs(self.mBuildBaseInfo) do
        local buildType = buildBase.BuildBaseManager:getBuildBasePosDataByPos(k).buildType
        if buildType ~= buildBase.BuildBaseType.PowerStation and buildType ~= buildBase.BuildBaseType.DispatchRoom then
            value = value + buildBaseMsgVo.produce
        end
    end
    return value
end

-- 获取当前无人机数量
function getAllDrone(self)
    if (self.mAllDroneNum ~= nil) then
        return self.mAllDroneNum
    else
        return 0
    end
end

function getShipLv(self, id)
    if self.mBuildBaseInfo[id] then
        return self.mBuildBaseInfo[id].lv
    else
        return 0
    end
end

function parseFacMsg(self, msg)
    if (not self.mBuildBaseFacInfo[msg.building_id]) then
        self.mBuildBaseFacInfo[msg.building_id] = {}
    end
    self.mBuildBaseFacInfo[msg.building_id].orderType = msg.order_type
    self.mBuildBaseFacInfo[msg.building_id].orderId = msg.order_id
    self.mBuildBaseFacInfo[msg.building_id].count = msg.count
    GameDispatcher:dispatchEvent(EventName.UPDATE_BUILDBASE_VIEW)
end

function getFacInfo(self, id)
    if (self.mBuildBaseFacInfo[id] == nil) then
        self.mBuildBaseFacInfo[id] = {}
        self.mBuildBaseFacInfo[id].orderType = 0
        self.mBuildBaseFacInfo[id].orderId = 0
        self.mBuildBaseFacInfo[id].count = 0
    end
    return self.mBuildBaseFacInfo[id]
end

-- 获取(服务器)建筑信息
function getBuildBaseData(self, id)
    return self.mBuildBaseInfo[id]
end

function getAllBuildBaseDataList(self)
    local res = {}
    for k, v in pairs(self.mBuildBaseInfo) do
        table.insert(res, v)
    end
    return res
end

-- 获得当前建筑入住战员疲劳是否有0
function getSumStaminaHasZeroByBuildId(self, buildId)
    local mDataHelper = self:getBuildBaseData(buildId)
    local hasZero = false
    if (mDataHelper and self:getBuildType(mDataHelper.id) ~= buildBase.BuildBaseType.Dormitory) then
        if next(mDataHelper.heroList) then
            for _, heroTid in pairs(mDataHelper.heroList) do
                local buildBaseHeroVo = buildBase.BuildBaseHeroManager:getBuildHeroInfo(heroTid)
                if buildBaseHeroVo then
                    hasZero = buildBaseHeroVo.stamina == 0 and true or false
                end
            end
        end
    end
    return hasZero
end

-- 获得当前建筑技能加成列表 
function getSkillInfosByBuildId(self, buildId)
    local mDataHelper = self.mBuildBaseInfo[buildId]
    if (mDataHelper == nil) then
        return
    end
    return mDataHelper.skillList
end

--实验室 冶金室是否有战员
function checkCertainBuildingsEmpty(self)
    if next(self.mBuildBaseInfo) then
        for buildId, msgVo in pairs(self.mBuildBaseInfo) do
            local buildType = self:getBuildType(buildId)
            if buildType == buildBase.BuildBaseType.Laboratory or
            buildType == buildBase.BuildBaseType.Smelters
            then
                if next(msgVo.heroList) == nil then
                    return true
                end
            end
        end
    end
    return false
end

-- 除所有宿舍外，所有房间的战员是否有疲劳
function checkAllBuildingsHeroStamina(self)
    if next(self.mBuildBaseInfo) then
        for buildId, msgVo in pairs(self.mBuildBaseInfo) do
            if self:getBuildType(buildId) ~= buildBase.BuildBaseType.Dormitory then
                if next(msgVo.heroList) then
                    for _, heroTid in pairs(msgVo.heroList) do
                        local buildBaseHeroVo = buildBase.BuildBaseHeroManager:getBuildHeroInfo(heroTid)
                        if buildBaseHeroVo then
                            if buildBaseHeroVo.stamina == 0 and buildBaseHeroVo.staminaTime <= 0 then
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end

-- 根据buildId判断是否基建房间又战员
function checkBuildingsHeroIsEmpty(self, buildId)
    if next(self.mBuildBaseInfo) then
        local Vo = self.mBuildBaseInfo[buildId]
        if Vo then
            if next(Vo.heroList) == nil then
                return true
            end
        end
    end
    return false
end

-- ------------------------------------获得当前建筑物总技能加成
function getSumSkillInfoByBuildId(self, buildId)
    local mDataHelper = self:getSkillInfosByBuildId(buildId)
    local mSum = 0
    if (#mDataHelper > 0) then
        for _, v in pairs(mDataHelper) do
            mSum = mSum + buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(v.skill_id).effectPara[1]
        end
    end
    return mSum
end

-- 获得当发电站总技能加成
function getPlantSkillInfo(self)
    local sum = 0
    local mSkillDic = {}
    for Id, msgVo in pairs(self.mBuildBaseInfo) do
        if self:getBuildBasePosDataByPos(Id).buildType == buildBase.BuildBaseType.PowerStation then
            if next(msgVo.skillList) then
                for skillId, lv in pairs(msgVo.skillList) do
                    if not mSkillDic[skillId] then
                        mSkillDic[skillId] = lv
                    end
                end
            end
        end
    end
    for skillId, lv in pairs(mSkillDic) do
        local skillVo = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(skillId)
        sum = sum + skillVo:getCurLvAttr(lv).value[1]
    end
    return sum
end

-- 获得当建筑技能加成
function getBuildSkillInfo(self, buildId)
    local sum = 0
    local skillList = self.mBuildBaseInfo[buildId].skillList
    if next(skillList) then
        for skillId, lv in pairs(skillList) do
            local skillVo = buildBase.BuildBaseHeroManager:getSkillConfigBySkillId(skillId)
            sum = sum + skillVo:getCurLvAttr(lv).value[1]
        end
    end
    return sum
end

-- 获取当前建筑入住战员列表
function getHeroListByBuildId(self, buildId)
    local list = self.mBuildBaseInfo[buildId].heroList
    return list
end

-- 获取当前建筑入住战员数量
function getSumStaminaHeroNum(self, buildId)
    local mDataHelper = self:getBuildBaseData(buildId)
    local length = 0
    if (mDataHelper) then
        length = #mDataHelper.heroList
    end
    return length
end

--仅判断控制中心等级是否到达
function canBuildBaseCreate(self, buildId)
    local serverLv = buildBase.BuildBaseManager:getShipLv(buildId)
    local posVo = buildBase.BuildBaseManager:getBuildBasePosDataByPos(buildId)
    local buildType = posVo.buildType
    local levelsData = buildBase.BuildBaseManager:getBuildBaseLevelNeedData(buildType)
    local preLevelData = levelsData:getLevelDataVo(serverLv + 1)
    local centerLv = buildBase.BuildBaseManager:getShipLv(buildBase.BuildBaseType.ControllerCenter)

    if serverLv == 0 then
        return centerLv >= posVo.level
    end

    if preLevelData == nil then
        return false
    else
        return centerLv >= preLevelData.costLevel
    end
end

-- 是否可以升级建筑 位置id 显示提示信息
function canBuildBaseLvUpdate(self, buildId, showTips, onlyGetString)
    local mAllPower = buildBase.BuildBaseManager:getCurrentPower()
    local serverLv = buildBase.BuildBaseManager:getShipLv(buildId)
    local posVo = buildBase.BuildBaseManager:getBuildBasePosDataByPos(buildId)
    local buildType = posVo.buildType
    --local buildType = buildBase.BuildBaseManager:getBuildBasePosDataByPos(buildId).buildType

    local levelsData = buildBase.BuildBaseManager:getBuildBaseLevelNeedData(buildType)
    -- if serverLv == 0 then
    --     serverLv = 1
    -- end
    local levelData = levelsData:getLevelDataVo(serverLv)
    local preLevelData = levelsData:getLevelDataVo(serverLv + 1)
    local centerLv = buildBase.BuildBaseManager:getShipLv(buildBase.BuildBaseType.ControllerCenter)

    -- 已经满级
    if preLevelData == nil then
        return false
    end

    if onlyGetString then
        if serverLv == 0 then
            if centerLv < posVo.level then
                return _TT(76017, posVo.level)
            else
                return ""
            end
        else
            if centerLv < preLevelData.costLevel then
                return _TT(76017, preLevelData.costLevel)
            else
                return ""
            end
        end


    end

    if serverLv == 0 then
        if centerLv < posVo.level then
            if showTips then
                gs.Message.Show(_TT(76017, posVo.level))
            end
            return false
        end
    else
        if centerLv < preLevelData.costLevel then
            if showTips then
                gs.Message.Show(_TT(76017, preLevelData.costLevel))
            end
            return false
        end
    end



    --有前置条件
    if #preLevelData.numLevel > 0 then
        local needCount = preLevelData.numLevel[1]
        local needLevel = preLevelData.numLevel[2]

        local hasCount = self:getBuildBaseCanLvCount(needLevel)

        if hasCount < needCount then
            if showTips then
                gs.Message.Show(_TT(76025, needCount, needLevel))
            end
            return false
        end
    end

    local hasCost = true
    for i = 1, #preLevelData.cost do
        hasCost = hasCost and
        MoneyUtil.judgeNeedMoneyCountByTid(preLevelData.cost[i][1], preLevelData.cost[i][2], false, false) ==
        true
    end

    if hasCost then
        if buildType == buildBase.BuildBaseType.PowerStation then
            return true
        else
            local oldPower = levelData == nil and 0 or levelData.needPower
            if mAllPower >= (preLevelData.needPower - oldPower) then
                return true
            else
                if showTips then
                    gs.Message.Show(_TT(76018))
                end
                return false
            end
        end
    else
        if showTips then
            gs.Message.Show(_TT(76019))
        end
        return false
    end
end

--基建红点 1.没有战员入住 2.加工厂 实验室 冶炼中心 有产物
function updateBuildBaseRedPoint(self)
    local flag = false
    if next(self.mBuildBaseInfo) then
        for buildId, msgVo in pairs(self.mBuildBaseInfo) do
            local buildType = self:getBuildType(buildId)
            if buildType == buildBase.BuildBaseType.Laboratory or
            buildType == buildBase.BuildBaseType.Smelters or
            buildType == buildBase.BuildBaseType.Factory then
                if msgVo.maxNum ~= 0 then
                    if msgVo.produce >= msgVo.maxNum / 2 then
                        cusLog(msgVo.produce)
                        flag = true
                        return flag
                    end
                end
            end
        end
    end

    return flag or self:checkAllBuildingsHeroStamina()
end


function checkIsEmpty(self, buildId)
    if next(self.mBuildBaseInfo) then
        local buildMsgVo = self.mBuildBaseInfo[buildId]
        if buildMsgVo then
            return next(buildMsgVo.heroList) == nil
        end
    end
    return false
end
---------------------------------------------------------------- 配置表数据 ----------------------------------------------------------------
-- 解析基建位置信息
function parseBuildBasePosData(self)
    self.mBuildBasePosData = {}
    local baseData = RefMgr:getData("warship_pos_data")
    for k, v in pairs(baseData) do
        local vo = buildBase.BuildBasePosVo.new()
        vo:parseConfigData(k, v)
        self.mBuildBasePosData[k] = vo
    end
end

-- 解析建筑升级需要的数据
function parseBuildBaseLevelNeedData(self)
    self.mBuildBaseLevelNeedData = {}
    local baseData = RefMgr:getData("warship_data")
    for k, v in pairs(baseData) do
        local vo = buildBase.BuildBaseLevelsVo.new()
        vo:parseConfigData(k, v)
        self.mBuildBaseLevelNeedData[k] = vo
    end
end

function parseBuildBaseFactoryData(self)
    self.mBuildBaseFactoryInfo = {}
    local baseData = RefMgr:getData("warship_factory_data")
    for k, v in pairs(baseData) do
        local vo = buildBase.BuildBaseFacVo.new()
        vo:parseData(k, v)
        self.mBuildBaseFactoryInfo[k] = vo
    end
end

---------------------------------------------------------------属性----------------------------------------------------------------
-- 加工厂生成类型
function setOrderType(self, type)
    self.mNowSelectFacOrderType = type
end

-- 加工厂生成类型
function getOrderType(self)
    return self.mNowSelectFacOrderType
end

-- 设置当前选择建筑BuildId
function setNowBuildId(self, buildId)
    self.mNowBuildId = buildId
    self.mNowBuildType = self:getBuildType(buildId)
    buildBase.BuildBaseHeroManager:onSelectedBuildChanged()
end

-- 获取基建位置信息
function getBuildBasePosData(self)
    if self.mBuildBasePosData == nil then
        self:parseBuildBasePosData()
    end
    return self.mBuildBasePosData
end

-- 获取（配置）基建位置信息 位置
function getBuildBasePosDataByPos(self, pos)
    if self.mBuildBasePosData == nil then
        self:parseBuildBasePosData()
    end
    return self.mBuildBasePosData[pos]
end

-- 获取基建类型   buildId
function getBuildType(self, buildId)
    if buildId == nil then
        return self:getBuildBasePosDataByPos(self.mNowBuildId).buildType
    else
        return self:getBuildBasePosDataByPos(buildId).buildType
    end
end

-- 获取选中建筑类型 
function getNowBuildType(self)
    return self:getBuildBasePosDataByPos(self.mNowBuildId).buildType
end

-- 获取对应建筑升级需要的数据 !是建筑类型 不是位置（配置）
function getBuildBaseLevelNeedData(self, buildType)
    if self.mBuildBaseLevelNeedData == nil then
        self:parseBuildBaseLevelNeedData()
    end
    return self.mBuildBaseLevelNeedData[buildType]
end

-- 获取对应建筑当前等级ConfigVo by BuildId 传参空默认为当前建筑buildId
function getCurLvBuildConfigd(self, buildId)
    if self.mBuildBaseLevelNeedData == nil then
        self:parseBuildBaseLevelNeedData()
    end
    local id = 0
    if buildId == nil then
        id = self.mNowBuildId
    else
        id = buildId
    end
    local buildVo = self:getBuildBasePosDataByPos(id)
    local curLvBuildConfig = self:getBuildBaseLevelNeedData(buildVo.buildType):getLevelDataVo(self:getShipLv(id))
    return curLvBuildConfig
end

-- 返回当前进入建筑buildId
function getNowBuildId(self)
    return self.mNowBuildId
end

function getFacConfigData(self)
    if self.mBuildBaseFactoryInfo == nil then
        self:parseBuildBaseFactoryData()
    end
    return self.mBuildBaseFactoryInfo
end

function getFacItemsConfigData(self, type)
    return self:getFacConfigData()[type]
end

function setLvUpPosId(self, pos)
    self.lastlvUpId = pos
end

function getLvUpPosId(self)
    return self.lastlvUpId
end

function getFacMsgVo(self)
    -- for k,v in pairs(self.mBuildBaseInfo) do
    --     if v.buildType == buildBase.BuildBaseType.Factory then 
    --         return v 
    --     end
    -- end
    self:setNowBuildId(12)
    return self.mBuildBaseInfo[12]
end

-- 1.可以生产
-- 2.材料不足
-- 3.建筑等级不足
-- 0.没有该生产物
function getCanProduce(self, propsTid)
    local facMsg = self:getFacMsgVo()
    -- if not facMsg then
    --     return 3
    -- end
    for k, v in pairs(self:getFacConfigData()) do
        for i, j in pairs(v.items) do
            if j.propProps[1] == propsTid then
                if not facMsg or k > facMsg.lv or j.needLevel > facMsg.lv then
                    return 3, j.needLevel
                end

                local canProduce = false
                for m, n in pairs(j.requiredProps) do
                    if MoneyUtil.judgeNeedMoneyCountByTid(n[1], n[2], false, false) then
                        self:setOrderType(k)
                        canProduce = true
                    else
                        canProduce = false
                        break
                    end
                end
                if canProduce then
                    return 1, j
                else
                    return 2
                end
            end
        end
    end
    return 0
end
return _M