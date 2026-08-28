local import = import
local checkNumber = checkNumber

local CatBallEntity = import("Game.CatBall.CatBallEntity")
local CatEggDojo    = import("Game.Dojo.CatEggDojo")
---@type CardProgressionSkillUtils
local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
---@type CardProgressionConstants
local CardProgressionConstants  = import("Game.CardProgression.CardProgressionConstants")

---@class CatBallUtils
local CatBallUtils = {}

local DescKey2ParamConfig = {--- 参数个数         猫球经营技能表字段名             控制百分比显示（1：是百分比 0：不是）
    ["#skillTime"]              = {1,           "skillTime",                    0},
    ["#skillProbability"]       = {1,           "skillProbability",             1},
    ["#skillNum"]               = {1,           "skillNum",                     0},
    ["#goodsSkillTime"]         = {1,           "goodsSkillTime",               0},
    ["#goodsSkillProbability"]  = {1,           "goodsSkillProbability",        1},
    ["#goodsSkillNum"]          = {1,           "goodsSkillNum",                0},
}

local FieldTypes = {
    Quality = 1,
    Star    = 2,
    Type    = 3,
    SubType = 4,
    Area    = 5,
}
local FieldTypeFunc = {
    ---@param v CatBallEntity
    ---@param vo CatBallVo
    [FieldTypes.Quality] = function(v, vo, conditionDict)
        return conditionDict[vo.rare] ~= nil
    end,
    [FieldTypes.Star] = function(v, vo, conditionDict)
        return v.dojo ~= nil and conditionDict[checkNumber(v.dojo.star)] ~= nil
    end,
    [FieldTypes.Type] = function(v, vo, conditionDict)
        return conditionDict[vo.types] ~= nil
    end,
    [FieldTypes.SubType] = function(v, vo, conditionDict)
        return conditionDict[vo.subtype] ~= nil
    end,
    [FieldTypes.Area] = function(v, vo, conditionDict)
        local skillVo = CatBallUtils.GetCatBallOperatesSkillVo(vo.roleId)
        return conditionDict[skillVo.area] ~= nil
    end,
}

local ScreenType = Constants.ScreenType
local FilterType2FieldType = {
    [ScreenType.CatBallCultivateQuality] = FieldTypes.Quality,
    [ScreenType.CatBallCultivateStar]    = FieldTypes.Star,
    [ScreenType.CatBallCultivateType]    = FieldTypes.Type,
    [ScreenType.CatBallCultivateSubType] = FieldTypes.SubType,
    [ScreenType.CatBallFightQuality]     = FieldTypes.Quality,
    [ScreenType.CatBallFightStar]        = FieldTypes.Star,
    [ScreenType.CatBallFightType]        = FieldTypes.Type,
    [ScreenType.CatBallFightSubType]     = FieldTypes.SubType,
    [ScreenType.CatBallOperatesQuality]  = FieldTypes.Quality,
    [ScreenType.CatBallOperatesStar]     = FieldTypes.Star,
    [ScreenType.CatBallFoodShow]         = FieldTypes.Area,
}

local CommonSmallCatBallNodeEnvPath = "Game.CatBall.CommonSmallCatBallNode"

---GetCatBallVo
---@param refId number 配表主键
---@return CatBallVo
function CatBallUtils.GetCatBallVo(refId)
    ---@type CatBallVo
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6033, "CatBallVo", refId)
    return vo
end

---GetCatBallUpStarVo
---@param catId number 猫球id
---@param star number 猫球星级
---@return CatBallUpStarVo
function CatBallUtils.GetCatBallUpStarVo(catId, star)
    local refId = string.format("%s%02d", catId, star)
    ---@type CatBallUpStarVo
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6031, "CatBallUpStarVo", refId)
    return vo
end


---GetCatBallSkillVo
---@param catId number 猫球id
---@param star number 猫球星级
---@return CatBallSkillVo
function CatBallUtils.GetCatBallSkillVo(refId)
    ---@type CatBallSkillVo
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6034, "CatBallSkillVo", refId)
    return vo
end

---CatBallOperatesSkillVo
---@param catId number 猫球id
---@return CatBallOperatesSkillVo
function CatBallUtils.GetCatBallOperatesSkillVo(refId)
    ---@type CatBallOperatesSkillVo
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6038, "CatBallOperatesSkillVo", refId)
    return vo
end

---GetCatBallParams
function CatBallUtils.GetCatBallParams(id)
    ---@type BaseArgVo
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6035, "BaseArgVo", id)
    return vo.num
end

---GetCatBallDrawVo
---@return CatBallDrawVo
function CatBallUtils.GetCatBallDrawVo(id)
    ---@type CatBallDrawVo
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6037, "CatBallDrawVo", id)
    return vo
end

---GetAllCatBallGoodsVo
---获取所有的猫球道具
function CatBallUtils.GetAllCatBallGoodsVo()
    ---@type CatBallGoodsVo[]
    local vos = CfUtils.GetCf(AutoIds.IdSetting1920, "CatBallGoodsVo", true)
    return vos
end

---GetAllCatBallAttributeFlagData
---获取 所有 猫球标识描述表 数据
function CatBallUtils.GetAllCatBallAttributeFlagData()
    local setting = CfUtils.GetCfTable(AutoIds.IdSetting6039)
    local allRow = setting:GetAll()
    local t = {}
    for i, row in pairs(allRow) do
        table.insert(t, {
            types   = parse_number(row, "types"),
            subtype = parse_number(row, "subtype"),
            title   = parse_localizeText(row, "title"),
            expound = parse_localizeText(row, "expound", true),
        })
    end
    return t
end

---GetCatBallAttrDefineInfoByStar
---@param catId number 猫球id
---@param targetStar number 猫球星级
function CatBallUtils.GetCatBallAttrDefineInfoByStar(catId, targetStar)
    local addAttrId2Num = CatBallUtils.GetCatBallAddAttrId2NumByStar(catId, targetStar)
    local t = {}
    ---@type CardConfMgr
    local cardConfMgr = CardConfMgr:GetInstance()
    for addAttrId, addAttrNum in pairs(addAttrId2Num) do
        ---@type AttrDefinesVo
        local vo = cardConfMgr:GetBasicAttrByBasicAttrAdditionId(addAttrId)
        table.insert(t, {vo = vo, num = addAttrNum})
    end
    table.sort(t, function(a, b) 
        return a.vo.order < b.vo.order
    end)

    return t

end

---CompareCatBallStarAttrDefineInfo
---@param catId number 猫球id
---@param star number 当前猫球星级
---@param nextStar number 下一猫球星级
function CatBallUtils.CompareCatBallStarAttrDefineInfo(catId, star, nextStar)
    local addAttrId2Num     = CatBallUtils.GetCatBallAddAttrId2NumByStar(catId, star)
    local nextAddAttrId2Num = CatBallUtils.GetCatBallAddAttrId2NumByStar(catId, nextStar)

    local t = {}
    ---@type CardConfMgr
    local cardConfMgr = CardConfMgr:GetInstance()
    for nextAddAttrId, addAttrNum in pairs(nextAddAttrId2Num) do
        local num = addAttrId2Num[nextAddAttrId]
        ---@type AttrDefinesVo
        local vo = cardConfMgr:GetBasicAttrByBasicAttrAdditionId(nextAddAttrId)
        table.insert(t, {vo = vo, num = num or 0, nextAttrNum = addAttrNum})
    end
    table.sort(t, function(a, b) 
        return a.vo.order < b.vo.order
    end)

    return t
end

---CatList2TeamCatBallList
---@param catList table
function CatBallUtils.CatList2TeamCatBallList(catList, catType, maxCount)
    local t = {}
    ---@type CatEggComponent
    local eggComponent     = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
    for index, playerCardId in ipairs(catList) do
        ---@type CatEggDojo
        local catEggDojo
        if checkNumber(playerCardId) > 0 then
            ---@type CatEggDojo
            catEggDojo = eggComponent:GetCatById(playerCardId)
        end
        ---@type TeamCatBallDojo
        local teamCatDojo = CfUtils.GetTeamCatDojo(catEggDojo)
        teamCatDojo:SetCatType(catType)
        table.insert(t, teamCatDojo)
        if index >= maxCount then
            break
        end
    end
    return t
end

---GetCatBallAddAttrId2NumByStar
---@param catId number 猫球id
---@param targetStar number 猫球星级
function CatBallUtils.GetCatBallAddAttrId2NumByStar(catId, targetStar, attrAddId2Num)
    ---@type CatBallVo
    local catBallVo = CatBallUtils.GetCatBallVo(catId)
    targetStar = math.min(targetStar, catBallVo.starMax)
    attrAddId2Num = attrAddId2Num or {}
    for star = catBallVo.starMin, targetStar do
        ---@type CatBallUpStarVo
        local starVo        = CatBallUtils.GetCatBallUpStarVo(catId, star)
        local attrAdditions = starVo.attrAdditions
        for index, value in ipairs(attrAdditions) do
            local addAttrId = value.addAttrId
            attrAddId2Num[addAttrId] = (attrAddId2Num[addAttrId] or 0) + value.addAttrNum
        end
    end

    return attrAddId2Num
end

function CatBallUtils.GetAttributeIcon(catBallType, subType)
    return string.format("UIAtlas/OverseaManage/CatSkillIcon/catball_attribute_icon_%s_%s.png", catBallType or 1, subType or 1)
end

---FreshCommonSmallCatBallNode
---@param go UnityEngine.GameObject
function CatBallUtils.FreshCommonSmallCatBallNode(go, ...)
    ---@type CommonSmallCatBallNode
    local env = CfUtils.GetLuaScr(go, CommonSmallCatBallNodeEnvPath)
    if isNull(env) then
        return
    end
    env:FreshUI(...)
    return env
end

function CatBallUtils.SortCatBallInAutoFormation(walkFunc,questId,teamIndex,levelType)
    --- 战前编队一键上阵猫球规则；优先上阵排序-猫球品质＞猫球星级＞猫球属性偏向（属性偏向为攻击＞辅助＞防御）
    ---@type CatEggComponent
    local eggComponent     = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
    ---@type table<number, CatEggDojo>
    local playerCatId2Dojo = eggComponent:GetCats()
    local catSortInfoList = {}
    for playerCatId, dojo in pairs(playerCatId2Dojo) do
        local catId = dojo.catId
        ---@type CatBallVo
        local vo    = CatBallUtils.GetCatBallVo(catId)
        local isLimitCat = GameUtils.IsLimitCat(questId,dojo.id,teamIndex)
        if vo and vo.subtype <= Constants.CatBallSubType.Support and not isLimitCat then
            local isLimitTypeCat = CatBallUtils.IsLimitCatByType(levelType,vo.types)
            if not isLimitTypeCat then
                table.insert(catSortInfoList, {id = dojo.id, star = dojo.star, rare = vo.rare, catBallType = vo.types, subType = vo.subtype})
            end
        end
    end

    if next(catSortInfoList) then
        local fieldNames = {"rare", "star", "subType"}
        local customAscConfig = {["subType"] = false}
        local CommonChecker = CommonChecker
        table.sort(catSortInfoList,    function(a, b) 
            return CommonChecker(a, b, fieldNames, true, customAscConfig)
        end)
    end

    for catId, info in ipairs(catSortInfoList) do
        ---@type CatEggDojo
        local dojo = playerCatId2Dojo[info.id]
        if walkFunc(dojo, info.catBallType) then
            break
        end
    end
end

function CatBallUtils.IsLimitCatByType(levelType,catType)
    if levelType == Constants.IDType.ActivityCrisis then
        local ActivityCrisisUtils = import('Game.Activity.CrisisContract.ActivityCrisisUtils')
        local entryData = ActivityCrisisUtils.GetActivityCrisisMgr():GetEntryData()
        local isLimitCat = ActivityCrisisUtils.IsEntryLimitCat(entryData,catType)
        return isLimitCat
    end
    return false
end

---GeneratedCatBallEntityList
---@param catEggDojos CatEggDojo[]
---@return CatBallEntity[]
function CatBallUtils.GeneratedCatBallEntityList(catEggDojos)
    local entityList = {}
    for index, catEggDojo in pairs(catEggDojos) do
        ---@type CatBallEntity
        local entity = CatBallEntity.New()
        entity:Fill(catEggDojo)
        table.insert(entityList, entity)
    end
    return entityList
end

---GeneratedCatBallEntity
---@param catEggDojo CatEggDojo
---@return CatBallEntity
function CatBallUtils.GeneratedCatBallEntity(catEggDojo)
    ---@type CatBallEntity
    local entity = CatBallEntity.New()
    entity:Fill(catEggDojo)
    return entity
end

---GeneratedCatBallGoodsEntity
---@param goodsId number
---@return CatBallEntity
function CatBallUtils.GeneratedCatBallGoodsEntity(goodsId, num, goodsVo)
    ---@type CatBallEntity
    local entity = CatBallEntity.New()
    entity:FillFragment(goodsId, num, goodsVo)
    return entity
end

function CatBallUtils.GeneratedVirtualCatEggDojo(goodsId)
    ---@type CatEggDojo
    local catEggDojo = CatEggDojo.New()
    catEggDojo:SetGoodsId(goodsId)
    return catEggDojo
end


function CatBallUtils.GeneratedCatEggDojo(jsonData)
    ---@type CatEggDojo
    local catEggDojo = CatEggDojo.New()
    catEggDojo:FillData(jsonData)
    return catEggDojo
end


---SortCatBallChoose
---@param catList CatBallEntity[]
---@param sortType Constants.SortType
---@param asc boolean 升序
function CatBallUtils.SortCatBallChoose(catList, sortType, asc)
    local fieldNames
    if sortType == Constants.SortType.Rare then
        fieldNames = {"merge", "fragment", "rare", "star", "subType", "catId"}
    elseif sortType == Constants.SortType.Star then
        fieldNames = {"merge", "fragment", "star", "rare", "subType", "catId"}
    end
    if fieldNames == nil then
        return catList
    end

    local customGetFieldFunc = {
        ---@param catBallEntity CatBallEntity 
        ["merge"] = function(catBallEntity)
            local isCanMerge = catBallEntity.isCanMerge
            local isFragment = catBallEntity.isFragment
            return (isFragment and isCanMerge) and 1 or 0
        end,
        ---@param catBallEntity CatBallEntity 
        ["fragment"] = function(catBallEntity)
            local isFragment = catBallEntity.isFragment
            return isFragment and 0 or 1
        end,
        ---@param catBallEntity CatBallEntity 
        ["rare"] = function(catBallEntity)
            return catBallEntity.vo and catBallEntity.vo.rare or 0
        end,
        ["star"] = function(catBallEntity)
            ---@type CatEggDojo
            local dojo = catBallEntity.dojo
            return dojo and dojo.star or 0
        end,
        ["subType"] = function(catBallEntity)
            return catBallEntity.vo and catBallEntity.vo.subType or 0
        end,
        ["catId"] = function(catBallEntity)
            return catBallEntity.vo and catBallEntity.vo.roleId or 0
        end,
    }

    local customAscConfig = {
        ["merge"]    = true,
        ["fragment"] = true,
    }

    local CommonChecker = CommonChecker
    table.sort(catList, function(a,b) 
        return CommonChecker(a, b, fieldNames, asc, customAscConfig, customGetFieldFunc)
    end)

    return catList

end

function CatBallUtils.ScreenCatBall(originData, screenDic)
    if screenDic == nil or next(screenDic) == nil then
        return originData
    end

    local screenType2ConditionDict = CatBallUtils.InitScreenType2ConditionDict(screenDic)
    local t = {}
    ---@param v CatBallEntity
    for i, v in ipairs(originData) do
        ---@type CatBallVo
        local vo = v.vo
        local checkRes   = CatBallUtils.CheckScreenRes(screenType2ConditionDict, v, vo)
        if checkRes then
            table.insert(t, v)
        end
    end

    return t
end

---InitScreenType2ConditionDict
---初始化筛选类型2条件字典
function CatBallUtils.InitScreenType2ConditionDict(screenDic)
    local screenType2ConditionDict = {}
    for type, screenClassDic in pairs(screenDic) do
        local conditionDict
        for i, v in pairs(screenClassDic) do
            conditionDict = conditionDict or {}
            conditionDict[v] = v
        end
        screenType2ConditionDict[checkNumber(type)] = conditionDict
        
    end
    return screenType2ConditionDict
end

---CheckScreenRes
---检查筛选结果
function CatBallUtils.CheckScreenRes(screenType2ConditionDict, v, vo)
    local checkRes   = true
    for screenType, conditionDict in pairs(screenType2ConditionDict) do
        local fieldType = FilterType2FieldType[screenType]
        local func      = FieldTypeFunc[fieldType]
        checkRes = checkRes and func(v, vo, conditionDict)
    end
    return checkRes
end

--- GetCatBallSkillDesc
---获取猫球技能描述
---@param catBallId number 猫球id
---@param star number 猫球星级
---@param catType Constants.CatBallType 猫球类型
---@param isStarUp boolean 是否是升星
---@return string, string, CatBallOperatesSkillVo | CatBallSkillVo
function CatBallUtils.GetCatBallSkillDesc(catBallId, star, catType, isStarUp)
    if catType == Constants.CatBallType.Operates then
        return CatBallUtils.GetOperatesSkillDesc(catBallId, star, isStarUp)
    else
        return CatBallUtils.GetBattleSkillDesc(catBallId, star, isStarUp)
    end
end

---GetBattleSkillDesc
---获取猫球战斗技能描述
---@param catBallId number 猫球id
---@param star number 猫球星级
---@param isStarUp boolean 是否是升星
---@return string, string, CatBallSkillVo
function CatBallUtils.GetBattleSkillDesc(catBallId, star, isStarUp)
    ---@type CatBallUpStarVo 
    local catBallUpStarVo = CatBallUtils.GetCatBallUpStarVo(catBallId, star)
    local skillId = catBallUpStarVo.SkillId
    ---@type CatBallSkillVo
    local skillVo = CatBallUtils.GetCatBallSkillVo(skillId)
    local desc, name
    
    if isStarUp then
        desc, name = CatBallUtils.GetBattleSkillDescByStarVo(catBallUpStarVo, skillVo, catBallId, star)
    else
        desc, name = CatBallUtils.GetBattleSkillDescBySkillVo(skillVo)
    end
    return desc, name, skillVo
end

---GetBattleSkillDescByStarVo
---@param catBallUpStarVo CatBallUpStarVo 猫球升星表 数据
---@param skillVo CatBallSkillVo 猫球技能表 数据
---@param star number 这里传入的直接是下一星级
---@return string, string
function CatBallUtils.GetBattleSkillDescByStarVo(catBallUpStarVo, skillVo, catBallId, star)
    local lastStar = star - 1
    ---@type CatBallUpStarVo 
    local lastCatBallUpStarVo = CatBallUtils.GetCatBallUpStarVo(catBallId, lastStar)
    local isChangeSkillId = lastCatBallUpStarVo.SkillId ~= skillVo.id
    local skillType      = skillVo.skillType
    local isSkill        = skillType == 1
    local skillId        = isSkill and skillVo.addSkillId or skillVo.addBuffId
    local lastSkillId
    local realStar       = star     
    if isChangeSkillId then
        local lastSkillVo = CatBallUtils.GetCatBallSkillVo(lastCatBallUpStarVo.SkillId)
        lastSkillId = isSkill and lastSkillVo.addSkillId or lastSkillVo.addBuffId
    end

    local desc, name
    if isSkill then
        desc, name = CardProgressionSkillUtils.GetStarDescBySkillId(skillId, catBallUpStarVo.skillDesc, 1, false, nil, nil, lastSkillId)
    else
        desc, name = CardProgressionSkillUtils.GetCardTalentDescById(skillId, 1, lastSkillId, catBallUpStarVo.skillDesc) 
    end

    return desc, name
end


---GetBattleSkillDescBySkillVo
---@param skillVo CatBallSkillVo
---@return string, string
function CatBallUtils.GetBattleSkillDescBySkillVo(skillVo)
    local skillType      = skillVo.skillType
    local isSkill        = skillType == 1
    local skillGroupType = isSkill and CardProgressionConstants.SkillGroupType.Normal or CardProgressionConstants.SkillGroupType.Buff

    local id = isSkill and skillVo.addSkillId or skillVo.addBuffId
    local skillData = {id, 1, skillGroupType}
    
    local desc, name = CardProgressionSkillUtils.GetSkillDescBySkillData(skillData, false)
    return desc, name
end

---GetOperatesSkillDesc
---获取经营技能描述
---@param skillVo MaidCoffeeSkillVo
---@param star number 猫球星级
---@param isStarUp boolean 是否是升星
function CatBallUtils.GetOperatesSkillDesc(catBallId, star, isStarUp)
    ---@type CatBallOperatesSkillVo
    local vo               = CatBallUtils.GetCatBallOperatesSkillVo(catBallId)
    local curStar = star
    local skillDesc 
    if isStarUp then
        ---@type CatBallUpStarVo 
        local catBallUpStarVo = CatBallUtils.GetCatBallUpStarVo(catBallId, star)
        skillDesc = catBallUpStarVo.skillDesc
        curStar = curStar - 1
    end
    
    return CatBallUtils.GetSkillDescBySkillVo(vo, curStar, star, skillDesc)

end

---GetSkillDescBySkillVo
---通过 猫球经营技能表 获取经营技能描述
---@param vo CatBallOperatesSkillVo
---@param star number 猫球星级
---@return string
function CatBallUtils.GetSkillDescBySkillVo(vo, star, nextStar, skillDesc)
    local attribute_format = attribute_format
    local parse_strings    = parse_strings
    local SafeUnpack = SafeUnpack
    ---@type MaidCoffeeUtils
    local MaidCoffeeUtils  = import("Game.MaidCoffee.MaidCoffeeUtils")
    ---@type MaidCoffeeSkillVo
    local skillVo          = MaidCoffeeUtils.GetMaidCoffeeSkillInfoVo(vo.skillId)
    if skillDesc == nil then
        skillDesc        = skillVo.decr
    end
    local descList         = string.split2(skillDesc, "_")
    local realDescList = {}

    local paramsCount = 0
    for i, desc in ipairs(descList) do
        if paramsCount > 0 then
            paramsCount = paramsCount - 1
        else
            local paramsConfig = DescKey2ParamConfig[desc]
            if paramsConfig == nil then
                table.insert(realDescList, desc)
            else
                local count, fieldName, percentageFlag = SafeUnpack(paramsConfig)
                paramsCount = count

                local isCurrent = checkNumber(descList[i + 1]) == 0
                ---星级从0开始  luaIndex 从1开始
                local realStar  = isCurrent and star or nextStar

                local fieldStr = vo[fieldName]
                if not string.isEmpty(fieldStr) then
                    ---星级从0开始  luaIndex 从1开始
                    local numList = parse_strings(fieldStr)
                    local num = numList[realStar + 1]
                    table.insert(realDescList, attribute_format(percentageFlag, num))    
                end

            end

        end

    end

    return string.gsub(table.concat(realDescList), "\\n", "\n"), skillVo.name, skillVo
end

---PreviewCatBall
---@param catBallId number 猫球卡牌表id
function CatBallUtils.PreviewCatBall(catBallId, exclusiveIds)
    exclusiveIds = exclusiveIds or UICommonUtils.GetShowDialogArguments()
    return CfUtils.DialogOpen(Constants.UITypeIds.CatBallCultivateDialog, {catBallId = catBallId, previewMode = 1}, exclusiveIds, true)
end

---GetRedPointShowState
---@param entity CatBallEntity
function CatBallUtils.GetRedPointShowState(entity)
    if entity == nil then return false end
    return CatBallUtils.GetRedPointShowStateByDojo(entity.dojo, entity.vo)
end

---GetRedPointShowStateByDojo
---@param dojo CatEggDojo
---@param vo CatBallVo
function CatBallUtils.GetRedPointShowStateByDojo(dojo, vo)
    if dojo == nil then return false end
    if vo == nil then
        vo = CatBallUtils.GetCatBallVo(dojo.catId)
    end
    local nextStar = checkNumber(dojo.star) + 1
    if vo == nil or nextStar > vo.starMax then
        return false
    end
    ---@type CatBallUpStarVo
    local starVo = CatBallUtils.GetCatBallUpStarVo(dojo.catId, nextStar)
    local totalConsumes = {}
    table.link(totalConsumes, starVo.consumeKinds)
    table.link(totalConsumes, starVo.consumes)
    return GoodsUtils.CheckGoodConsumeCondition(totalConsumes)
end

function CatBallUtils.GetHomeRedPointNum()
    ---@type CatEggComponent
    local eggComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CatEggComponent)
    local playerCatId2Dojo = eggComponent:GetCats()
    for key, dojo in pairs(playerCatId2Dojo) do
        if CatBallUtils.GetRedPointShowStateByDojo(dojo) then
            return 1
        end
    end

    if CatBallUtils.GetGoodsTipsRedPointNum() then
        return 1
    end

    return 0
end

function CatBallUtils.GetGoodsTipsRedPointNum()
    ---@type CatBallDrawVo
    local vo = CatBallUtils.GetCatBallDrawVo(10001)
    return GoodsUtils.CheckGoodConsumeCondition(vo.fiveConsumes)
end

return CatBallUtils
