--[[
****************************************************************************
Brief  :TargetManager 用于对目标的获取的快捷管理
Author :James Ou
Date   :2020-03-06
****************************************************************************
]]

module("TargetManager", Class.impl())
-- --析构函数
-- function dtor(self)
-- end

-- 获取所有战斗单位
-- 以单位withID为基准 (即livethingID)
-- isIncludeWith 结果是否包含 withID
-- isSort 返回的结果是否排序(根据 withID 的距离) (为nil时 不排序)
-- centerPos 排序参考的中心坐标 (为nil时 以 withID 所在位置作参考坐标)
-- excludeID 目标中排除 excludeID (即livethingID)
-- includeDead 是否包含死亡的 (默认为不包含)
function getAllPeople(self, withID, isIncludeWith, isSort, centerPos, excludeID, includeDead)
    local all = fight.SceneManager:getAllThing()
    local retList = {}
    if withID==nil or isIncludeWith==true then
        for _,vo in pairs(all) do
            if vo.id~=excludeID then
                if includeDead~=true then 
                    if not vo:isDead() then
                        table.insert(retList, vo)
                    end
                else
                    table.insert(retList, vo)
                end
            end
        end
    else
        for _,vo in pairs(all) do
            if vo.id~=withID and vo.id~=excludeID then
                if includeDead~=true then
                    if not vo:isDead() then
                        table.insert(retList, vo)
                    end
                else
                    table.insert(retList, vo)
                end
            end
        end
    end
    if isSort==true then
        local roleVo = fight.SceneManager:getThing(withID)
        if centerPos==nil then
            centerPos = roleVo:getCurPos()
        end
        local function _sort(a, b)
            return math.v3DistanceNoSqrt(centerPos, a:getCurPos())<math.v3DistanceNoSqrt(centerPos, b:getCurPos())
        end
        table.sort(retList, _sort)
    end
    return retList
end

-- 获取同队的战斗单位
-- 以单位withID为基准 (即livethingID)
-- isIncludeWith 结果是否包含 withID
-- cnt 返回的数量 (nil时 获取所有符合条件的)
-- isSort 返回的结果是否排序(根据 withID 的距离) (为nil时 不排序)
-- centerPos 排序参考的中心坐标 (为nil时 以 withID 所在位置作参考坐标)
-- excludeID 目标中排除 excludeID (即livethingID)
-- includeDead 是否包含死亡的 (默认为不包含)
function getSameTeamPeople(self, withID, isIncludeWith, cnt, isSort, centerPos, excludeID, includeDead)
    local roleVo = fight.SceneManager:getThing(withID)
    if roleVo then
        local all = fight.SceneManager:getAllThing()
        local tmpList = {}
        if isIncludeWith==true then
            for _,vo in pairs(all) do
                if vo.isAtt==roleVo.isAtt and vo.id~=excludeID then
                    if includeDead~=true then 
                        if not vo:isDead() then
                            table.insert(tmpList, vo)
                        end
                    else
                        table.insert(tmpList, vo)
                    end
                end
            end
        else
            for _,vo in pairs(all) do
                if vo.id~=withID then
                    if vo.isAtt==roleVo.isAtt and vo.id~=excludeID then
                        if includeDead~=true then 
                            if not vo:isDead() then
                                table.insert(tmpList, vo)
                            end
                        else
                            table.insert(tmpList, vo)
                        end
                    end
                end
            end
        end
        if isSort==true then
            if centerPos==nil then
                centerPos = roleVo:getCurPos()
            end
            local function _sort(a, b)
                return math.v3DistanceNoSqrt(centerPos, a:getCurPos())<math.v3DistanceNoSqrt(centerPos, b:getCurPos())
            end
            table.sort(tmpList, _sort)
        end
        if cnt and cnt>0 then
            local retList = {} 
            for i=1, cnt do
                local tar = tmpList[i]
                if tar then
                    table.insert(retList, tar)
                else
                    break
                end
            end
            return retList
        end
        return tmpList
    end
    Debug:log_warn("TargetManager", "no liveVo [%d]  !!!", withID)
end


-- 获取敌队的战斗单位
-- 以单位withID为基准 (即livethingID)
-- cnt 返回的数量 (nil时 获取所有符合条件的)
-- isSort 返回的结果是否排序(根据 withID 的距离) (为nil时 不排序)
-- centerPos 排序参考的中心坐标 (为nil时 以 withID 所在位置作参考坐标)
-- excludeID 目标中排除 excludeID (即livethingID)
-- includeDead 是否包含死亡的 (默认为不包含)
function getDiffTeamPeople(self, withID, cnt, isSort, centerPos, excludeID, includeDead)
    local roleVo = fight.SceneManager:getThing(withID)
    if roleVo then
        local all = fight.SceneManager:getAllThing()
        local tmpList = {}
        -- print("getDiffTeamPeople ================== ")
        if excludeID==nil then
            for _,vo in pairs(all) do
                if vo.isAtt~=roleVo.isAtt then
                    if includeDead~=true then 
                        if not vo:isDead() then
                            -- print("getDiffTeamPeople id", vo.id, vo:getHp())
                            table.insert(tmpList, vo)
                        end
                    else
                        table.insert(tmpList, vo)
                    end
                end
            end
        else
            for _,vo in pairs(all) do
                if vo.isAtt~=roleVo.isAtt and vo.id~=excludeID then
                    if includeDead~=true then 
                        if not vo:isDead() then
                            -- print("getDiffTeamPeople2~~ id", vo.id, vo:getHp())
                            table.insert(tmpList, vo)
                        end
                    else
                        table.insert(tmpList, vo)
                    end
                end
            end
        end
        if isSort==true then
            if centerPos==nil then
                centerPos = roleVo:getCurPos()
            end
            local function _sort(a, b)
                return math.v3DistanceNoSqrt(centerPos, a:getCurPos())<math.v3DistanceNoSqrt(centerPos, b:getCurPos())
            end
            table.sort(tmpList, _sort)
        end
        if cnt and cnt>0 then
            local retList = {} 
            for i=1, cnt do
                local tar = tmpList[i]
                if tar then
                    table.insert(retList, tar)
                else
                    break
                end
            end
            return retList
        end
        return tmpList
    end
    Debug:log_warn("TargetManager", "no liveVo [%d]  !!!", withID)
end

-- 随机获取指定数量敌队的战斗单位
-- 以单位withID为基准 (即livethingID)
-- cnt 返回的数量 (>=1)
-- excludeID 目标中排除 excludeID (即livethingID)
-- includeDead 是否包含死亡的 (默认为不包含)
function randomDiffTeamPeople(self, withID, cnt, excludeID, includeDead)
    local roleVo = fight.SceneManager:getThing(withID)
    if roleVo then
        local all = fight.SceneManager:getAllThing()
        local tmpList = {}
        -- print("getDiffTeamPeople ================== ")
        if excludeID==nil then
            for _,vo in pairs(all) do
                if vo.isAtt~=roleVo.isAtt then
                    if includeDead~=true then 
                        if not vo:isDead() then
                            table.insert(tmpList, vo)
                        end
                    else
                        table.insert(tmpList, vo)
                    end
                end
            end
        else
            for _,vo in pairs(all) do
                if vo.isAtt~=roleVo.isAtt and vo.id~=excludeID then
                    if includeDead~=true then 
                        if not vo:isDead() then
                            table.insert(tmpList, vo)
                        end
                    else
                        table.insert(tmpList, vo)
                    end
                end
            end
        end
        cnt = cnt or 1
        if cnt>=#tmpList then
            return tmpList
        end
        local retList = {} 
        while cnt>0 do
            cnt = cnt-1
            local idx = math.random(1, #tmpList)
            table.insert(retList, tmpList[idx])
            table.remove(tmpList, idx)
        end
        return retList
    end
    Debug:log_warn("TargetManager", "no liveVo [%d]  !!!", withID)
end

-- 获取格子范围内的敌队的战斗单位
-- 以单位withID为基准 (即livethingID)
-- cnt 返回的数量 (nil时 获取所有符合条件的)
-- isSort 返回的结果是否排序(根据 withID 的距离) (为nil时 不排序)
-- centerPos 排序参考的中心坐标 (为nil时 以 withID 所在位置作参考坐标)
-- tileDic 格子范围 半径
-- excludeID 目标中排除 excludeID (即livethingID)
function getDiffTeamInRange(self, withID, tileDic, centerPos, cnt, isSort, excludeID)
    local roleVo = fight.SceneManager:getThing(withID)
    if roleVo then
        if centerPos==nil then
            centerPos = roleVo:getCurPos()
        end
        local all = fight.SceneManager:getAllThing()
        local tmpList = {}

        if excludeID==nil then
            for _,vo in pairs(all) do
                if vo.isAtt~=roleVo.isAtt and vo:isDead() == false and fight.SceneUtil.inRangeByPos2Vo(centerPos,vo,tileDic) then
                    table.insert(tmpList, vo)
                end
            end
        else
            for _,vo in pairs(all) do
                if vo.isAtt~=roleVo.isAtt and vo:isDead() == false  and fight.SceneUtil.inRangeByPos2Vo(centerPos,vo,tileDic) and vo.id~=excludeID then
                    table.insert(tmpList, vo)
                end
            end
        end
        if isSort==true then
            local function _sort(a, b)
                return math.v3DistanceNoSqrt(centerPos, a:getCurPos())<math.v3DistanceNoSqrt(centerPos, b:getCurPos())
            end
            table.sort(tmpList, _sort)
        end
        if cnt and cnt>0 then
            local retList = {} 
            for i=1, cnt do
                local tar = tmpList[i]
                if tar then
                    table.insert(retList, tar)
                else
                    break
                end
            end
            return retList
        end
        return tmpList
    end
    Debug:log_warn("TargetManager", "no liveVo [%d]  !!!", withID)
end

-- 获取格子范围内的同队的战斗单位
-- 以单位withID为基准 (即livethingID)
-- cnt 返回的数量 (nil时 获取所有符合条件的)
-- isSort 返回的结果是否排序(根据 withID 的距离) (为nil时 不排序)
-- centerPos 排序参考的中心坐标 (为nil时 以 withID 所在位置作参考坐标)
-- tileDic 格子范围 半径
-- excludeID 目标中排除 excludeID (即livethingID)
function getSameTeamInRange(self, withID, tileDic, centerPos, cnt, isSort, excludeID)
    local roleVo = fight.SceneManager:getThing(withID)
    if roleVo then
        if centerPos==nil then
            centerPos = roleVo:getCurPos()
        end
        local all = fight.SceneManager:getAllThing()
        local tmpList = {}

        if excludeID==nil then
            for _,vo in pairs(all) do
                if vo.isAtt==roleVo.isAtt and vo:isDead() == false and fight.SceneUtil.inRangeByPos2Vo(centerPos,vo,tileDic) then
                    table.insert(tmpList, vo)
                end
            end
        else
            for _,vo in pairs(all) do
                if vo.isAtt==roleVo.isAtt and vo:isDead() == false and fight.SceneUtil.inRangeByPos2Vo(centerPos,vo,tileDic) and vo.id~=excludeID then
                    table.insert(tmpList, vo)
                end
            end
        end
        if isSort==true then
            local function _sort(a, b)
                return math.v3DistanceNoSqrt(centerPos, a:getCurPos())<math.v3DistanceNoSqrt(centerPos, b:getCurPos())
            end
            table.sort(tmpList, _sort)
        end
        if cnt and cnt>0 then
            local retList = {} 
            for i=1, cnt do
                local tar = tmpList[i]
                if tar then
                    table.insert(retList, tar)
                else
                    break
                end
            end
            return retList
        end
        return tmpList
    end
    Debug:log_warn("TargetManager", "no liveVo [%d]  !!!", withID)
end

---扩展方法---------------------------------------------------------------------------------------------------------------------

-- 获取同队中指定属性最大值单位
-- 以单位withID为基准 (即livethingID)
-- isIncludeWith 结果是否包含 withID
-- attrKey 属性KEY
-- cnt 返回的数量 (nil时 获取1个)
-- excludeID 目标中排除 excludeID (即livethingID)
-- includeDead 是否包含死亡的 (默认为不包含)
function getSameTeamMaxAttr(self, withID, isIncludeWith,attrKey,cnt,excludeID, includeDead)
    local function _sort(a, b)
        return b:getAtt(attrKey)>a:getAtt(attrKey)
    end
    return self:_getSameTeamAttr(withID, isIncludeWith, _sort, cnt, excludeID, includeDead)
end

-- 获取同队中指定属性最小值单位
-- 以单位withID为基准 (即livethingID)
-- isIncludeWith 结果是否包含 withID
-- attrKey 属性KEY
-- cnt 返回的数量 (nil时 获取1个)
-- excludeID 目标中排除 excludeID (即livethingID)
-- includeDead 是否包含死亡的 (默认为不包含)
function getSameTeamMinAttr(self, withID, isIncludeWith,attrKey,cnt,excludeID, includeDead)
    local function _sort(a, b)
        return a:getAtt(attrKey)>b:getAtt(attrKey)
    end
    return self:_getSameTeamAttr(withID, isIncludeWith, _sort, cnt, excludeID, includeDead)
end


function _getSameTeamAttr(self, withID, isIncludeWith,sortFunct, cnt,excludeID, includeDead)
    local roleVo = fight.SceneManager:getThing(withID)
    if roleVo then
        local all = fight.SceneManager:getAllThing()
        local tmpList = {}
        if isIncludeWith==true then
            for _,vo in pairs(all) do
                if vo.isAtt==roleVo.isAtt and vo.id~=excludeID then
                    if includeDead~=true then 
                        if not vo:isDead() then
                            table.insert(tmpList, vo)
                        end
                    else
                        table.insert(tmpList, vo)
                    end
                end
            end
        else
            for _,vo in pairs(all) do
                if vo.id~=withID then
                    if vo.isAtt==roleVo.isAtt and vo.id~=excludeID then
                        if includeDead~=true then 
                            if not vo:isDead() then
                                table.insert(tmpList, vo)
                            end
                        else
                            table.insert(tmpList, vo)
                        end
                    end
                end
            end
        end
       
        table.sort(tmpList, sortFunct)
       
        if cnt and cnt>0 then
            local retList = {} 
            for i=1, cnt do
                local tar = tmpList[i]
                if tar then
                    table.insert(retList, tar)
                else
                    break
                end
            end
            return retList
        end
        return tmpList[1]
    end
    Debug:log_warn("TargetManager", "no liveVo [%d]  !!!", withID)
end


-- 获取敌队中指定属性最大值单位
-- 以单位withID为基准 (即livethingID)
-- attrKey 属性KEY
-- cnt 返回的数量 (nil时 获取1个)
-- excludeID 目标中排除 excludeID (即livethingID)
-- includeDead 是否包含死亡的 (默认为不包含)
function getDiffTeamMaxAttr(self, withID, attrKey,cnt,excludeID, includeDead)
    local function _sort(a, b)
        return b:getAtt(attrKey)>a:getAtt(attrKey)
    end
    return self:_getDiffTeamAttr(withID, _sort, cnt, excludeID, includeDead)
end

-- 获取敌队中指定属性最小值单位
-- 以单位withID为基准 (即livethingID)
-- attrKey 属性KEY
-- cnt 返回的数量 (nil时 获取1个)
-- excludeID 目标中排除 excludeID (即livethingID)
-- includeDead 是否包含死亡的 (默认为不包含)
function getDiffTeamMinAttr(self, withID, attrKey,cnt,excludeID, includeDead)
    local function _sort(a, b)
        return a:getAtt(attrKey)>b:getAtt(attrKey)
    end
    return self:_getDiffTeamAttr(withID,  _sort, cnt, excludeID, includeDead)
end


function _getDiffTeamAttr(self, withID, sortFunct, cnt,excludeID, includeDead)
    local roleVo = fight.SceneManager:getThing(withID)
    if roleVo then
        local all = fight.SceneManager:getAllThing()
        local tmpList = {}
        for _,vo in pairs(all) do
            if vo.id~=withID then
                if vo.isAtt~=roleVo.isAtt and vo.id~=excludeID then
                    if includeDead~=true then 
                        if not vo:isDead() then
                            table.insert(tmpList, vo)
                        end
                    else
                        table.insert(tmpList, vo)
                    end
                end
            end
        end
       
        table.sort(tmpList, sortFunct)
       
        if cnt and cnt>0 then
            local retList = {} 
            for i=1, cnt do
                local tar = tmpList[i]
                if tar then
                    table.insert(retList, tar)
                else
                    break
                end
            end
            return retList
        end
        return tmpList[1]
    end
    Debug:log_warn("TargetManager", "no liveVo [%d]  !!!", withID)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
