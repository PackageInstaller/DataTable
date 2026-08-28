---@type HomelandTalentConfMgr
local HomelandTalentConfMgr = import("Game.Homeland.Talent.HomelandTalentConfMgr")
---@type HomelandTalentConstants
local HomelandTalentConstants = import("Game.Homeland.Talent.HomelandTalentConstants")

---@class HomelandTalentUtils
local HomelandTalentUtils = {}


function HomelandTalentUtils.CheckTalentEntryRedPoint(talentId2Data)
    local currencyCount = GoodsUtils.GetThingNo(HomelandTalentConstants.CurrencyId)
    if currencyCount == 0 then
        return false
    end
    local isUnlockSystem = GameUtils.IsUnlockedBySystemTogId(Constants.SystemToggleIds.Id6002)
    if not isUnlockSystem then
        return false
    end
    if HomelandTalentUtils.CheckIsClickTalent() then
        return false
    end

    ---@type HomelandTalentLabelVo[]
    local labelVos      = HomelandTalentConfMgr:GetAllHomelandTalentLabelVo()
    local displayLabels = HomelandTalentConfMgr:GetDisplayLabels()

    ---@param vo HomelandTalentLabelVo
    for _, vo in pairs(labelVos) do
        local labelType = vo.id
        ---检查下今天显示没显示过
        local isUnlock          = HomelandTalentUtils.CheckLabelIsUnlock(vo)
        if isUnlock then
            local talentConfData = displayLabels[labelType]
            if HomelandTalentUtils.CheckLabelRedPoint(talentConfData, talentId2Data, currencyCount) then
                return true
            end
        end
        
    end

    return false
end


---CheckIsClickTalent
---@param labelType integer @ 战略强化切页表id
function HomelandTalentUtils.CheckIsClickTalent()
    local date        = AppService:GetInstance():GetCurDate()
    local spanSeconds = date:spanseconds()
    return checkNumber(CfUtils.GetLocalData(HomelandTalentConstants.RedPointName, 0)) == spanSeconds
end

---SetIsClickTalent
---@param labelType integer @ 战略强化切页表id
function HomelandTalentUtils.SetIsClickTalent()
    local date        = AppService:GetInstance():GetCurDate()
    local spanSeconds = date:spanseconds()
    CfUtils.WriteLocalData(HomelandTalentConstants.RedPointName, spanSeconds)
end

---CheckLabelIsUnlock
---@param vo HomelandTalentLabelVo
function HomelandTalentUtils.CheckLabelIsUnlock(vo)
    return GameUtils.IsUnlockedSingle(vo.unlockId, vo.unlockNum, vo.unlockType)
end

function HomelandTalentUtils.CheckLabelRedPoint(talentConfData, talentId2Data, currencyCount)
    if talentConfData == nil then
        return false
    end
    
    for index, talentList in ipairs(talentConfData) do
        local lockCount = 0
        ---@param vo HomelandTalentVo
        for index, vo in ipairs(talentList) do
            local isCanUnlock, isUnlockPreTalent = HomelandTalentUtils.CheckIsCanUnlockTalent(vo, talentId2Data, currencyCount)
            
            if isUnlockPreTalent == false then
                lockCount = lockCount + 1
            end
            if isCanUnlock then
                return true
            end
        end
        --- 一列都不满足前置条件则
        if lockCount == #talentList then
            break
        end
    end
    return false
end

---CheckIsCanUnlockTalent
---@param vo HomelandTalentVo
---@param talentId2Data table
function HomelandTalentUtils.CheckIsCanUnlockTalent(vo, talentId2Data, currencyCount)
    if currencyCount <= 0 then
        return false
    end
    local ids   = HomelandTalentConfMgr:GetHomelandTalentUpLvVoIds(vo.talentId)
    if ids == nil then
        return false
    end 
    local data = talentId2Data[vo.talentId]
    local talentLv = data ~= nil and checkNumber(data.level) or 0
    local maxLv = #ids
    if talentLv >= maxLv then
        return false
    end

    local isUnlockPreId = HomelandTalentUtils.CheckIsUnlockPreId(vo, talentId2Data)
    if isUnlockPreId and GameUtils.IsUnlockedBySystemTogId(vo.systemId) then
        local nextLv  = talentLv + 1
        local id      = ids[nextLv]
        ---@type HomelandTalentUpLvVo
        local vo      = HomelandTalentConfMgr:GetHomelandTalentUpLvVoByRefId(id)
        local costNum = vo.costNum
        return currencyCount >= costNum, isUnlockPreId, costNum

    end
    return false, isUnlockPreId
end

---GenerateTalentTreeDataList
---生成天赋数据列表
---@param talentConfData table
---@param talentId2Data table
function HomelandTalentUtils.GenerateTalentTreeDataList(talentConfData, talentId2Data)
    local t = {}
    for index, talentList in ipairs(talentConfData) do
        local list = {}
        ---@param vo HomelandTalentVo
        for index, vo in ipairs(talentList) do
            local isUnlockPreId = HomelandTalentUtils.CheckIsUnlockPreId(vo, talentId2Data)
            local talentData = {}
            talentData = HomelandTalentUtils.GenerateTalentData(vo, talentId2Data, isUnlockPreId, talentData)

            table.insert(list, talentData)

        end
        table.insert(t, list)
    end
    return t
end

---CheckIsUnlockPreId
---检查是否解锁前置天赋
---@param vo HomelandTalentVo   战略强化总表 数据
---@param talentId2Data table   玩家身上的天赋数据
function HomelandTalentUtils.CheckIsUnlockPreId(vo, talentId2Data)
    local preIdList  = vo:GetPreTalent()
    local isUnlockPreId = true
    for _, t in pairs(preIdList) do
        local preId, lv = SafeUnpack(t)
        if preId > 0 then
            local talentData = talentId2Data[preId]
            isUnlockPreId = talentData ~= nil and talentData.level >= lv
            if not isUnlockPreId then
                break
            end
        end
    end
    return isUnlockPreId
end

---GenerateTalentData
---生成天赋数据
---@param vo HomelandTalentVo   战略强化总表 数据
---@param talentId2Data table   玩家身上的天赋数据
---@param isUnlockPreId boolean 是否解锁前置天赋
---@param talentData table      需要填充的天赋数据
function HomelandTalentUtils.GenerateTalentData(vo, talentId2Data, isUnlockPreId, talentData)
    local ids   = HomelandTalentConfMgr:GetHomelandTalentUpLvVoIds(vo.talentId)
    local maxLv = ids == nil and 0 or #ids
    local systemId = vo.systemId
    local isUnlock = GameUtils.IsUnlockedBySystemTogId(systemId)
    local status = HomelandTalentConstants.TalentNodeStatus.Lock
    local talentLv = 0
    if not isUnlock then
        status = HomelandTalentConstants.TalentNodeStatus.SystemLock
    else
        local data = talentId2Data[vo.talentId]
        if data then
            talentLv = data.level
            
            local isMaxLv = talentLv >= maxLv
            status = isMaxLv and HomelandTalentConstants.TalentNodeStatus.Max or HomelandTalentConstants.TalentNodeStatus.Active

        elseif isUnlockPreId then
            status = HomelandTalentConstants.TalentNodeStatus.ActiveUnmet

        end
    end

    talentData.vo = vo
    talentData.status = status
    talentData.talentLv = talentLv
    talentData.maxLv = maxLv

    return talentData
    
end

---GeneratePreTalentDataList
---生成前置天赋数据列表
---@param vo HomelandTalentVo
function HomelandTalentUtils.GeneratePreTalentDataList(vo, talentId2Data)
    local list = {}
    local preIdList  = vo:GetPreTalent()
    local isUnlockPreId = true
    for _, t in pairs(preIdList) do
        local preId, needLv = SafeUnpack(t)
        local talentData = talentId2Data[preId]
        -- local talentLv = talentData == nil and 0 or talentData.level
        if talentData then
            isUnlockPreId = talentData ~= nil and talentData.level >= needLv
        end

        local preTalentVo = HomelandTalentConfMgr:GetHomelandTalentVoById(preId)
        local talentData  = {}
        talentData  = HomelandTalentUtils.GenerateTalentData(preTalentVo, talentId2Data, isUnlockPreId, talentData)
        table.insert(list, talentData)
    end
    
    return list
end

---UpdateTalentTreeDataStatus
---@param talentTreeData table
---@param talentData table
function HomelandTalentUtils.UpdateTalentDataStatus(talentData, resultData)
    talentData.talentLv = resultData.level
    if talentData.status == HomelandTalentConstants.TalentNodeStatus.ActiveUnmet then
        talentData.status = HomelandTalentConstants.TalentNodeStatus.Active
    elseif talentData.status == HomelandTalentConstants.TalentNodeStatus.Active then
        if talentData.talentLv >= talentData.maxLv then
            talentData.status = HomelandTalentConstants.TalentNodeStatus.Max
        end
    end
    return talentData

end

function HomelandTalentUtils.UpdateTalentTreeData(talentTreeData, talentId2Data)
    for key, talentData in pairs(talentTreeData) do
        ---@type HomelandTalentVo
        local vo = talentData.vo
        local isUnlockPreId = HomelandTalentUtils.CheckIsUnlockPreId(vo, talentId2Data)
        talentData = HomelandTalentUtils.GenerateTalentData(vo, talentId2Data, isUnlockPreId, talentData)
        talentTreeData[key] = talentData
    end
    return talentTreeData
end

---GetTalentAttrText
---@param talentId number
---@param level number
function HomelandTalentUtils.GetTalentAttrText(talentId, level, isLock)
    ---@type HomelandTalentUpLvVo
    local vo = HomelandTalentConfMgr:GetHomelandTalentUpLvVo(talentId, level)
    -- local numText, desc, consumes = HomelandTalentUtils.GetTalentAttrTextByVo(vo)
    -- return numText, desc, consumes
    return HomelandTalentUtils.GetTalentAttrTextByVo(vo, isLock)
end

---GetTalentAttrTextByVo
---通过 战略强化升级表 数据 获取天赋属性文本
---@param vo HomelandTalentUpLvVo
function HomelandTalentUtils.GetTalentAttrTextByVo(vo, isLock)
    local attAddTypeId = vo.attAddTypeId
    local attAddNum = isLock == true and 0 or vo.attAddNum
    
    ---@type HomelandTalentEnumVo
    local enumVo = HomelandTalentConfMgr:GetHomelandTalentEnumVo(attAddTypeId)
    local isPercentage = enumVo.showNumType == 2 and 1 or 0
    return attribute_format(isPercentage, attAddNum), vo.desc, vo:GetConsumes()
end

---GetTalentNexLvAttrText
---@param talentId number
---@param level number
function HomelandTalentUtils.GetTalentNexLvAttrText(talentId, level, maxLv)
    local attAddNum = 0
    if level > 0 then
        ---@type HomelandTalentUpLvVo
        local vo     = HomelandTalentConfMgr:GetHomelandTalentUpLvVo(talentId, level)
        ---策划说：类型3的数值只会相同不会出现等级变化
        attAddNum = vo.attAddTypeId == Constants.GlobalTalentEffectId.Id_3 and 0 or vo.attAddNum
        
    end

    ---@type HomelandTalentUpLvVo
    local nextVo = HomelandTalentConfMgr:GetHomelandTalentUpLvVo(talentId, math.min(level + 1, maxLv))
    local attAddTypeId = nextVo.attAddTypeId
    local nextAttAddNum = nextVo.attAddNum
    
    ---@type HomelandTalentEnumVo
    local enumVo = HomelandTalentConfMgr:GetHomelandTalentEnumVo(attAddTypeId)
    local isPercentage = enumVo.showNumType == 2 and 1 or 0
    local curAttrText = attribute_format(isPercentage, attAddNum)
    local nextAttrText = attribute_format(isPercentage, nextAttAddNum)
    
    return curAttrText, nextAttrText, nextVo:GetConsumes()

end

---GetAllLvNumText
---@param vo HomelandTalentVo
function HomelandTalentUtils.GetAllLvNumText(vo)
    local talentId = vo.talentId
    local ids      = HomelandTalentConfMgr:GetHomelandTalentUpLvVoIds(talentId)

    local descList = {}
    for index, id in ipairs(ids) do
        ---@type HomelandTalentUpLvVo
        local upLvVo = HomelandTalentConfMgr:GetHomelandTalentUpLvVoByRefId(id)
        local numText, descText = HomelandTalentUtils.GetTalentAttrTextByVo(upLvVo)
        descText = HomelandTalentUtils.ParseLvAddDesc(descText, numText, upLvVo)

        table.insert(descList, descText)

    end

    return {isCustom = true, iconPath = vo.icon, name = vo.name, desc = table.concat(descList, "\n")}

end

---GetAllLvNumText
---@param vo HomelandTalentVo
function HomelandTalentUtils.GetLvNumText(vo, level, isLock)
    ---@type HomelandTalentUpLvVo
    local upLvVo = HomelandTalentConfMgr:GetHomelandTalentUpLvVo(vo.talentId, level)
    local numText, descText = HomelandTalentUtils.GetTalentAttrTextByVo(upLvVo, isLock)
    descText = HomelandTalentUtils.ParseLvAddDesc(descText, numText, upLvVo)
    return descText
end

---GenerateGlobalTalentDataList
---生成全局天赋数据列表
function HomelandTalentUtils.GenerateGlobalTalentDataList(talentDataList)
    for index, talentData in ipairs(talentDataList) do
        HomelandTalentUtils.GenerateGlobalTalentAddData(talentData, true)
    end

end

---GenerateGlobalTalentAddData
---生成全局天赋数据
---@param talentData table 天赋数据
function HomelandTalentUtils.GenerateGlobalTalentAddData(talentData, isUnlock)
    local talentId, level = talentData.talentId, talentData.level

    ---获取配表
    ---@type HomelandTalentUpLvVo
    local vo, maxLv       = HomelandTalentConfMgr:GetHomelandTalentUpLvVo(talentId, level)
    if vo == nil then return end
    
    HomelandTalentUtils.RegisterTalentByUpLvVo(vo, {talentId = talentId, level = level, isMaxLv = level >= maxLv, isUnlock = isUnlock})

end

--- 重置天赋
--- !!!!! 因为现在的重置是一次删一页，会把同一个effectId的加成全给删了。所以目前的实现方式是简单粗暴的直接按source删除
---@param talentId any
function HomelandTalentUtils.ResetGlobaleTalent(talentId)
    print("重置天赋 ", talentId)
    ---@type HomelandTalentUpLvVo
    local vo, maxLv = HomelandTalentConfMgr:GetHomelandTalentUpLvVo(talentId, 1)
    if vo == nil then return end

    local attAddTypeId = vo.attAddTypeId

    ---@type Constants.GlobalTalentEffectId
    local effectId = attAddTypeId
    
    -- 这里直接按source删除
    GlobalTalentMgr:GetInstance():RemoveTalentBySource(Constants.GlobalTalentSource.Talent, effectId)
end

---UpdateGlobalTalent
---更新全局天赋数据
---@param talentData table 天赋数据
---@param isUnlock boolean 是否是解锁天赋
function HomelandTalentUtils.UpdateGlobalTalent(talentData, isUnlock)
    if isUnlock then
        HomelandTalentUtils.GenerateGlobalTalentAddData(talentData, isUnlock)
    else
        local talentId, level = talentData.talentId, talentData.level
        ---@type HomelandTalentUpLvVo
        local vo, maxLv       = HomelandTalentConfMgr:GetHomelandTalentUpLvVo(talentId, level)
        HomelandTalentUtils.RegisterTalentByUpLvVo(vo, {talentId = talentId, level = level, isMaxLv = level >= maxLv, isUnlock = isUnlock})
    end

end

---RegisterTalentByUpLvVo
---通过 战略强化升级表数据 注册全局天赋
---@param vo HomelandTalentUpLvVo
---@param talentInfo table 更新对应的天赋数据的标识
function HomelandTalentUtils.RegisterTalentByUpLvVo(vo, talentInfo)
    local attAddTypeId    = vo.attAddTypeId
    local attAddNum       = vo.attAddNum
    local Constants       = Constants
    local globalTalentMgr = GlobalTalentMgr:GetInstance()
    
    ---@type HomelandTalentEnumVo
    local enumVo           = HomelandTalentConfMgr:GetHomelandTalentEnumVo(attAddTypeId)
    talentInfo.isAttributeTalent = globalTalentMgr:IsAttributeTalent(attAddTypeId)

    local isPercentage     = enumVo.attAddType == Constants.BasicAttrAddType.Percent
    ---客户端计算正负值（1，正，2，负）
    local isPlus           = enumVo.showNumType2 == 1
    attAddNum              = isPlus and attAddNum or attAddNum * -1

    ---@type Constants.GlobalTalentEffectId
    local effectId = attAddTypeId
    --- 暂时无 最终加成 默认放基础加成
    local addType = isPercentage and Constants.GlobalTalentAddType.Percent or Constants.GlobalTalentAddType.BaseAdd
    globalTalentMgr:RegisterTalent(effectId, Constants.GlobalTalentSource.Talent, addType, attAddNum, talentInfo, vo)
end

---ParseLvAddDesc
---解析等级加成描述
function HomelandTalentUtils.ParseLvAddDesc(descText, numText, upLvVo)
    local list = {}
    local descList = string.split2(descText, "_")
    for i, desc in ipairs(descList) do
        local text
        if desc == "regionId" then
            local regionId = upLvVo.regionId
            ---@type ActionUtils
            local ActionUtils       = import('Game.UI.FightReady.UIMainChapter.ActionUtils')
            ---@type RegionPrimaryMapVo
            local regionEquipTypeVo = ActionUtils.GetRegionPrimaryMapVo(regionId)
            text = regionEquipTypeVo.name
        elseif desc == "num" then
            text = numText
        else
            text = desc
        end
        table.insert(list, text)
    end
    return table.concat(list)
end

return HomelandTalentUtils