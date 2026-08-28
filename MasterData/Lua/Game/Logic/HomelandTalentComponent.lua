
--region global define
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
local HomelandTalentDojo = import("Game.Dojo.HomelandTalentDojo")
local ECSComponent       = import("Frame.ECS.ECSComponent")

---@type HomelandTalentConfMgr
local HomelandTalentConfMgr = import("Game.Homeland.Talent.HomelandTalentConfMgr")
--endregion

--region define


--endregion


---@class HomelandTalentComponent
---@field _talentDojo HomelandTalentDojo
local HomelandTalentComponent = Class("HomelandTalentComponent", ECSComponent)

function HomelandTalentComponent:__init()
    self._talentDojo = HomelandTalentDojo.New()

end

function HomelandTalentComponent:__delete()
    self._talentDojo = nil
end

function HomelandTalentComponent:InitTalentData(talentData)
    -- print("InitTalentData ", table.dump(talentData, nil, 5))
    ---@type HomelandTalentDojo
    local dojo = self._talentDojo:Fill(talentData)

    local talentDataList = dojo:GetTalentDataList()
    ---@type HomelandTalentUtils
    local HomelandTalentUtils = import("Game.Homeland.Talent.HomelandTalentUtils")
    HomelandTalentUtils.GenerateGlobalTalentDataList(talentDataList)

    self:UpdateHomelandTalentEntryRedPoint()
end

--- 重置天赋
---@param talentIds any
---@param realConsume any
function HomelandTalentComponent:RequestResetTalent(labelId, realConsume)
    return self:RequestInterface(Interfaces.TalentReset, {lineId = labelId}, function(responseData)
        -- 返还的战略点
        local rewards = responseData.rewards
        if isNotNull(rewards) then
            GoodsUtils.DrawRewards(rewards, true)
        end

        -- 重置天赋
        local talentIds = HomelandTalentConfMgr:GetTalentIdsByDisplayLabel(labelId)

        self._talentDojo:ResetTalentData(talentIds)

        ---@type HomelandTalentUtils
        local HomelandTalentUtils = import("Game.Homeland.Talent.HomelandTalentUtils")
        for i, talentId in ipairs(talentIds) do
            HomelandTalentUtils.ResetGlobaleTalent(talentId)
        end

        return talentIds
    end, realConsume)
end

function HomelandTalentComponent:RequestTalentUnlock(talentId, realConsume)
    return self:RequestInterface(Interfaces.TalentUnlock, {talentId = talentId}, function(request, response)
        local talentData = self._talentDojo:UpdateTalentData(talentId, 1)

        ---@type HomelandTalentUtils
        local HomelandTalentUtils = import("Game.Homeland.Talent.HomelandTalentUtils")
        HomelandTalentUtils.UpdateGlobalTalent(talentData, true)

        return talentData
    end, realConsume)
end

function HomelandTalentComponent:RequestTalentUpgrade(talentId, realConsume)
    return self:RequestInterface(Interfaces.TalentUpgrade, {talentId = talentId}, function(request, response)
        local talentData = self._talentDojo:UpdateTalentData(talentId)
        ---@type HomelandTalentUtils
        local HomelandTalentUtils = import("Game.Homeland.Talent.HomelandTalentUtils")
        HomelandTalentUtils.UpdateGlobalTalent(talentData)
        return talentData

    end, realConsume)
end

--- RequestInterface
--- 请求养成相关接口
---@param interface Interfaces 必传
---@param requestData table 必传
---@param callback function(table) 必传
function HomelandTalentComponent:RequestInterface(interface, requestData, callback, realConsume)

    -- if true then
    --     ---------------------------------------
    --     ---更新全局数据
    --     local resultData
    --     if callback then
    --         resultData = callback()
    --     end

    --     if realConsume then
    --         GoodsUtils.DrawRewards(realConsume)
    --     end

    --     ---------------------------------------
    --     --- 更新本地数据
    --     ---@type HomelandTalentConstants
    --     local HomelandTalentConstants = import("Game.Homeland.Talent.HomelandTalentConstants")
    --     Events.Broadcast(HomelandTalentConstants.EventNames.RequestSuccess, interface, resultData, requestData)
    --     return 
    -- end    

    return GameUtils.Request(interface, requestData, function(request, response)
        if checkNumber(response.errCode) ~= 0 then return end

        ---------------------------------------
        ---更新全局数据
        local resultData
        if callback then
            resultData = callback(response.data)
        end

        if realConsume then
            GoodsUtils.DrawRewards(realConsume, true)
        end

        ---------------------------------------
        --- 更新本地数据
        ---@type HomelandTalentConstants
        local HomelandTalentConstants = import("Game.Homeland.Talent.HomelandTalentConstants")
        Events.Broadcast(HomelandTalentConstants.EventNames.RequestSuccess, interface, resultData, requestData)
    end)
end

---GetHomelandTalentDojo
---@return HomelandTalentDojo
function HomelandTalentComponent:GetHomelandTalentDojo()
    return self._talentDojo
end

function HomelandTalentComponent:UpdateHomelandTalentEntryRedPoint()
    ---@type HomelandTalentDojo
    local dojo = self:GetHomelandTalentDojo()
    ---@type HomelandTalentUtils
    local HomelandTalentUtils = import("Game.Homeland.Talent.HomelandTalentUtils")
    local res = HomelandTalentUtils.CheckTalentEntryRedPoint(dojo:GetTalentId2Data())
    GameUtils.SetRedPointNum(Constants.RedPointConst.HomelandTalent, res and 1 or 0)
    
end

return HomelandTalentComponent
