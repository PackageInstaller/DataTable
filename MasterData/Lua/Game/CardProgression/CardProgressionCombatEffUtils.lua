

---@class CardProgressionCombatEffUtils
local CardProgressionCombatEffUtils = {}

--region global define
local import = import
--endregion

--region import
---@type CardConfMgr
local cardConfMgr              = CardConfMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
--endregion

--region define

local ipairs                = ipairs
local pairs                 = pairs
local floor                 = math.floor
local Constants             = Constants
local checkNumber           = checkNumber
local AttributeProviderType = Constants.AttributeProviderType

local function CheckIsCanAddAttr(cardAttr, targetType)
    if targetType == CardProgressionConstants.AdditionTargetType.Team then
        return true
    end
    local CardAttrType2TargetType = CardProgressionCombatEffUtils.CardAttrType2TargetType 
    if CardProgressionCombatEffUtils.CardAttrType2TargetType == nil then
        local CardAttrType = Constants.CardAttrType
        local AdditionTargetType = CardProgressionConstants.AdditionTargetType
        CardAttrType2TargetType = {
            [CardAttrType.Fire]  = AdditionTargetType.Red,
            [CardAttrType.Wood]  = AdditionTargetType.Green,
            [CardAttrType.Water] = AdditionTargetType.Blue,
            [CardAttrType.Light] = AdditionTargetType.White,
            [CardAttrType.Dark]  = AdditionTargetType.Black,
        }
        CardProgressionCombatEffUtils.CardAttrType2TargetType = CardAttrType2TargetType
    end
    return CardAttrType2TargetType[cardAttr] == targetType
end

local function IsBasicCardAttr(providerType)
    local BasicCardAttrType = CardProgressionCombatEffUtils.BasicCardAttrType 
    if BasicCardAttrType == nil then
        BasicCardAttrType = {
            [AttributeProviderType.Base]     = true,
            [AttributeProviderType.Level]    = true,
            [AttributeProviderType.AdvLevel] = true,
            [AttributeProviderType.Star]     = true,
        }
        CardProgressionCombatEffUtils.BasicCardAttrType = BasicCardAttrType
    end
    return BasicCardAttrType[providerType] == true
end

local function ClearT(t)
    for key, value in pairs(t) do
        t[key] = nil
    end
end

--endregion


--region Attribute Provider

function CardProgressionCombatEffUtils.CalcCardCultivateModuleTotalProperty(entity, extParams, attrProvider2AttrAddId2V, attrAddId2V)
    return CardProgressionCombatEffUtils.CalcCardTotalProperty(entity, extParams, true, attrProvider2AttrAddId2V, attrAddId2V)
end

--- CalcCardTotalProperty
---@param entity CardProgressionEntity
---@param extParams table {
---    使用与CardDojo中相同的字段
---    特殊字段
---    equipIdList -> 装备特殊传 extParams.equipIdList{[1]=x, [2]=x }传几个部位装备替换几个  机器人在CardProgressionEntity是中创建好的数据 不应该传入 equipIdList
---    equipPart2Dojo -> 装备特殊传 extParams.equipPart2Dojo{[1]=dojo, [2]=dojo }传几个部位装备替换几个  机器人在CardProgressionEntity是中创建好的数据 不应该传入
---    cardCg      -> 图鉴数据 
---    teamCats -> 猫屋解锁基因
---    cardSkinId2Lv   -> 当前卡牌解锁皮肤列表
---    developAdditionInfo   -> 图鉴附加数据
---    globalTalent   -> 全局天赋依赖数据
---}
---@return table @{[属性定义加成表id] = 数值}
function CardProgressionCombatEffUtils.CalcCardTotalProperty(entity, extParams, isSplit, attrProvider2AttrAddId2V, attrAddId2V)
    extParams = extParams or {}
    --- 卡牌属性计算公式
    --- 所有的常数值属性累加*（1+所有百分比属性累加）
    ---@type CardDojo
    local cardDojo = entity.cardDojo
    local cardId   = cardDojo.cardId
    if isSplit then
        if attrProvider2AttrAddId2V == nil or next(attrProvider2AttrAddId2V) == nil then
            attrProvider2AttrAddId2V = {}
            for index, value in pairs(AttributeProviderType) do
                attrProvider2AttrAddId2V[value] = {}
            end
        end
    else
        attrAddId2V = attrAddId2V or {}
    end

    local GetProviderAttrAddId2V = CardProgressionCombatEffUtils.GetProviderAttrAddId2V

    ---获取初始属性
    CardProgressionCombatEffUtils.CalcCardBornAttr(cardId, GetProviderAttrAddId2V(attrAddId2V, attrProvider2AttrAddId2V, Constants.AttributeProviderType.Base))
    
    ---获取卡牌星级属性
    CardProgressionCombatEffUtils.CalcCardStarProperty(cardId, extParams.star or cardDojo.star, extParams.superStar or cardDojo.superStar, GetProviderAttrAddId2V(attrAddId2V, attrProvider2AttrAddId2V, Constants.AttributeProviderType.Star))
    
    ---计算卡牌升阶属性
    local advanceLevel = extParams.advanceLevel or cardDojo.advanceLevel
    CardProgressionCombatEffUtils.CalcCardAdvanceLevelProperty(cardId, advanceLevel, GetProviderAttrAddId2V(attrAddId2V, attrProvider2AttrAddId2V, Constants.AttributeProviderType.AdvLevel))
    
    ---计算卡牌升级属性
    CardProgressionCombatEffUtils.CalcCardLevelProperty(cardId, advanceLevel, extParams.cardLevel or cardDojo.cardLevel, GetProviderAttrAddId2V(attrAddId2V, attrProvider2AttrAddId2V, Constants.AttributeProviderType.Level))

    ---计算卡牌专武属性
    CardProgressionCombatEffUtils.CalcExclusiveWeaponProperty(cardId, extParams.weaponUnlocked or cardDojo.weaponUnlocked, GetProviderAttrAddId2V(attrAddId2V, attrProvider2AttrAddId2V, Constants.AttributeProviderType.Weapon))

    ---计算卡牌装备属性
    CardProgressionCombatEffUtils.CalcEquipmentProperty(entity.equipPart2Dojo, extParams.equipIdList, extParams.equipPart2Dojo, GetProviderAttrAddId2V(attrAddId2V, attrProvider2AttrAddId2V, Constants.AttributeProviderType.Equipment))

    ---计算卡牌好感度属性 
    ---现在移除了属性配置 暂不计算
    -- CardProgressionCombatEffUtils.CalcCardFavorableProperty(cardId, cardDojo, extParams, GetProviderAttrAddId2V(attrAddId2V, attrProvider2AttrAddId2V, Constants.AttributeProviderType.FavorLevel))

    ---计算卡牌皮肤属性
    local fashionAttrAddId2V = GetProviderAttrAddId2V(attrAddId2V, attrProvider2AttrAddId2V, Constants.AttributeProviderType.Fashion)
    CardProgressionCombatEffUtils.CalcFashionProperty(cardId, entity.cardSkin2Lv, extParams.cardSkinId2Lv, fashionAttrAddId2V)

    ---计算所有的全局属性
    CardProgressionCombatEffUtils.CalcLimitlessGlobalProperty(extParams, entity.isIgnoreGlobal, attrAddId2V, attrProvider2AttrAddId2V)

    ---计算信息录入属性
    CardProgressionCombatEffUtils.CalcGlobalCheckInProperty(extParams.globalTalent, cardId, entity.isIgnoreGlobal, GetProviderAttrAddId2V(attrAddId2V, attrProvider2AttrAddId2V, Constants.AttributeProviderType.CheckIn))

    return attrProvider2AttrAddId2V or attrAddId2V
end

---CalcCardBornAttr
---获取初始属性
---@param cardId number 
function CardProgressionCombatEffUtils.CalcCardBornAttr(cardId, attrAddId2V)
    ---@type CardBornAttrVo
    local vo = cardConfMgr:GetCardBornAttrByRefId(cardId)
    if vo == nil then return end
    CardProgressionCombatEffUtils.InsertAttrAddId2VByAttrs(vo:GetAttributes(), attrAddId2V, 1)

end

--- CalcCardStarProperty
--- 获得星级属性
---@param cardId number
---@param star number
---@param superStar number
---@param attrAddId2V table @{[属性定义加成表id] = 数值}
function CardProgressionCombatEffUtils.CalcCardStarProperty(cardId, star, superStar, attrAddId2V)
    attrAddId2V = attrAddId2V or {}
    star, superStar = checkNumber(star), checkNumber(superStar)
    local totalStar = star + superStar

    local starId = cardConfMgr:GetCardStarId(cardId, totalStar)
    ---@type CardStarVo
    local vo = cardConfMgr:GetCardStarVo(starId)
    if vo then
        CardProgressionCombatEffUtils.InsertAttrAddId2VByAttrs(vo:GetAttributes(), attrAddId2V)
    else
        printError("卡牌id %s 未在 角色星级属性表 中未找到 %s", cardId, starId)
    end

    return attrAddId2V

end

--- CalcCardAdvanceLevelProperty
--- 获取进阶等级属性
---@param cardId number 卡牌id
---@param advanceLevel number 升阶等级
---@param attrAddId2V table @{[属性定义加成表id] = 数值}
function CardProgressionCombatEffUtils.CalcCardAdvanceLevelProperty(cardId, advanceLevel, attrAddId2V)
    attrAddId2V  = attrAddId2V or {}
    advanceLevel = math.max(checkNumber(advanceLevel), 1)
    
    ---@type CardVo
    local cardVo        = cardConfMgr:GetCardByRefId(cardId)
    if cardVo == nil then
        return attrAddId2V
    end

    --- 填充进阶属性
    ---@type RoleAdvanceVo
    local vo       = cardConfMgr:GetRoleAdvanceVo(cardId, advanceLevel)
    CardProgressionCombatEffUtils.InsertAttrAddId2VByAttrs(vo:GetTotalBreakAttributes(), attrAddId2V)
    

    return attrAddId2V
end


--- CalcCardLevelProperty
--- 获取等级属性
---@param cardId number 卡牌id
---@param advanceLevel number 升阶等级
---@param attrAddId2V table @{[属性定义加成表id] = 数值}
function CardProgressionCombatEffUtils.CalcCardLevelProperty(cardId, advanceLevel, cardLevel, attrAddId2V)
    attrAddId2V  = attrAddId2V or {}
    advanceLevel = math.max(checkNumber(advanceLevel), 1)
    cardLevel    = checkNumber(cardLevel)
    
    ---@type CardVo
    local cardVo        = cardConfMgr:GetCardByRefId(cardId)
    if cardVo == nil then
        return attrAddId2V
    end

   --- 填充升级属性
    ---@type RoleAdvanceVo
    local vo       = cardConfMgr:GetRoleAdvanceVo(cardId, advanceLevel)
    
    for advLevel = advanceLevel, 1, -1 do
        local lastMaxLv = 0
        local lastVo
        if advLevel > 1 then
            ---@type RoleAdvanceVo
            lastVo = cardConfMgr:GetRoleAdvanceVo(cardId, advLevel - 1)
            lastMaxLv = lastVo.cardLevel
        end
        
        if cardLevel > lastMaxLv then
            local validLv = cardLevel - lastMaxLv
            cardLevel     = cardLevel - validLv
            CardProgressionCombatEffUtils.InsertAttrAddId2VByAttrs(vo:GetUpAttributes(), attrAddId2V, validLv)
        end
        vo = lastVo
    end

    return attrAddId2V
end

--- CalcExclusiveWeaponProperty
--- 计算卡牌专武属性
---@param cardId number 卡牌id
---@param weaponUnlocked number 专武是否解锁
---@param attrAddId2V table @{[属性定义加成表id] = 数值}
function CardProgressionCombatEffUtils.CalcExclusiveWeaponProperty(cardId, weaponLv, attrAddId2V)
    attrAddId2V    = attrAddId2V or {}
    local isLock = checkNumber(weaponLv) == 0
    if isLock then
        return attrAddId2V
    end
    
    ---@type RoleCardExclusiveWeaponVo
    local vo = cardConfMgr:GetRoleCardExclusiveWeaponVo(cardId, weaponLv)
    if vo then
        CardProgressionCombatEffUtils.InsertAttrAddId2VByAttrs(vo:GetTotalAttributes(), attrAddId2V) 
    end

    return attrAddId2V

end

--- CalcEquipmentProperty
---@param equipPart2Dojo table<number, EquipDojo> 
---@param equipIdList table<number, number> 与equipPart2Dojo 互斥
---@param extEquipPart2Dojo table<number, EquipDojo> 与equipIdList 互斥
---@param attrAddId2V table @{[属性定义加成表id] = 数值}
function CardProgressionCombatEffUtils.CalcEquipmentProperty(equipPart2Dojo, equipIdList, extEquipPart2Dojo, attrAddId2V)
    
    equipPart2Dojo = CardProgressionCombatEffUtils.FixEquipPart2Dojo(equipPart2Dojo, equipIdList, extEquipPart2Dojo)

    local suitId2ActiveCount = {}
    ---处理装备自身的属性
    ---@param dojo EquipDojo
    for part, dojo in pairs(equipPart2Dojo) do
        CardProgressionCombatEffUtils.CalcEquipmentPropertyByDojo(dojo, attrAddId2V)

        if dojo then
            local equipmentId = dojo.equipmentId

            --机器人会配装备0   策划不让报这个error 
            if checkNumber(equipmentId) > 0 then
                ---@type EquipVo
                local equipVo = cardConfMgr:GetEquipVoById(equipmentId)
                if equipVo then
                    local suitId = equipVo.suitId
                    suitId2ActiveCount[suitId] = suitId2ActiveCount[suitId] or 0
                    suitId2ActiveCount[suitId] = suitId2ActiveCount[suitId] + 1
                else
                    printError("装备表 中未找到 %s 数据", equipmentId)
                end
            end
        end
    end

    ---处理装备套装的属性
    for suitId, count in pairs(suitId2ActiveCount) do
        ---@type EquipFilterVo
        local vo = CfUtils.GetCfVo(AutoIds.IdSetting102, "EquipFilterVo", suitId)
        if vo then
            ---装备属性改成叠加
            local attributeCount = floor(count / vo.suitNum)
            if attributeCount > 0 then
                CardProgressionCombatEffUtils.InsertAttrAddId2VByAttrs(vo:GetAttributes(), attrAddId2V, attributeCount) 
            end
        else
            printError("装备套装筛选表 中未找到 %s 数据", suitId)
            -- 
        end
    end
end

function CardProgressionCombatEffUtils.FixEquipPart2Dojo(equipPart2Dojo, equipIdList, extEquipPart2Dojo)
    ---装备特殊传 extParams.equipIdList{[1]=x, [2]=x }传几个部位装备替换几个 
    ---机器人在CardProgressionEntity是中创建好的数据 不应该传入 equipIdList
    equipPart2Dojo = equipPart2Dojo or {}
    if equipIdList then
        ---@type EquipmentComponent
        local equipComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.EquipmentComponent)
        for part, playerEquipId in pairs(equipIdList) do
            equipPart2Dojo[part] = equipComp:GetEquipById(playerEquipId)
        end

    elseif extEquipPart2Dojo then
        for part, dojo in pairs(extEquipPart2Dojo) do
            equipPart2Dojo[part] = dojo
        end
            
    end
    return equipPart2Dojo
end

--- CalcEquipmentPropertyByDojo
---@param dojo EquipDojo
---@param attrAddId2V table {[属性定义加成表id] = 数值}
function CardProgressionCombatEffUtils.CalcEquipmentPropertyByDojo(dojo, attrAddId2V)
    if dojo == nil then
        return nil
    end
    --- 计算主属性
    local attrId = checkNumber(dojo.mainAttrId)
    
    local mainAttrNum = checkNumber(dojo.mainAttrNum)
    -- 刻印加成
    if EquipUtils.IsEngraveActive(dojo) then
        mainAttrNum = mainAttrNum + EquipUtils.CalculateEquipmentEngraveAttr(dojo, false)
    end
    if not attrAddId2V[attrId] then
        attrAddId2V[attrId] = mainAttrNum
    else
        local v = attrAddId2V[attrId]
        attrAddId2V[attrId] = v + mainAttrNum
    end

    dojo:WalkLadderRiseAttrs(function (id, num)
        id = checkNumber(id)
        num = checkNumber(num)
        if not attrAddId2V[id] then
            attrAddId2V[id] = num
        else
            local v = attrAddId2V[id]
            attrAddId2V[id] = v + num
        end
    end)

    --- 计算副属性
    local strFormat = string.format
    local star = checkNumber(dojo.star)
    for i = 1, star do
        ---副属性条数
        local attrKey    = strFormat('attr%sId', i)
        local attrNumKey = strFormat('attr%sNum', i)
        local attrSubId  = checkNumber(dojo[attrKey])
        if attrSubId > 0 then
            local attrNum = checkNumber(dojo[attrNumKey])
            attrSubId = checkNumber(attrSubId)
            if not attrAddId2V[attrSubId] then
                attrAddId2V[attrSubId] = attrNum
            else
                local v = attrAddId2V[attrSubId]
                attrAddId2V[attrSubId] = v + attrNum
            end
        end
    end
    return attrAddId2V
end

---CalcCardFavorableProperty
---计算好感度属性
---@param cardId number 卡牌id
---@param cardDojo CardDojo 好感度奖励是否领取
---@param extParams table {
---    favorRewardsReceived: string  与 favorRewardsReceived 二选一
---    favorLv2ReceivedRes: table    与 favorRewardsReceived 二选一
---}
---@param attrAddId2V table {[属性定义加成表id] = 数值}
function CardProgressionCombatEffUtils.CalcCardFavorableProperty(cardId, cardDojo, extParams, attrAddId2V)
    
    local favorLv2ReceivedRes =  nil
    if extParams.favorLv2ReceivedRes then
        favorLv2ReceivedRes = extParams.favorLv2ReceivedRes
    elseif not string.isEmpty(extParams.favorRewardsReceived) then
        local receivedList = string.split2(extParams.favorRewardsReceived, ",") or {}
        ---有的话 新建 table 空表直接用它
        local t = next(receivedList) ~= nil and {} or receivedList
        for i, v in ipairs(receivedList) do
            t[checkNumber(v)] = true
        end
        favorLv2ReceivedRes = t
    else
        favorLv2ReceivedRes = cardDojo:GetFavorLv2ReceivedRes()
    end
    
    if next(favorLv2ReceivedRes) == nil then
        return attrAddId2V
    end
    
    local ids = cardConfMgr:GetFavorableExpRewardIdGroup(cardId)
    if ids == nil then return end
    for i, id in ipairs(ids) do
        ---@type FavorableExpRewardVo
        local vo = cardConfMgr:GetFavorableExpRewardVo(id)
        if favorLv2ReceivedRes[vo.level] then
            if not string.isEmpty(vo.property) then
                local attr = vo:GetAttributes()
                CardProgressionCombatEffUtils.InsertAttrAddId2VByAttrs(attr, attrAddId2V)
                
            end
        end
    end
    return attrAddId2V
end


---CalcFashionProperty
---计算卡牌皮肤属性
---@param cardId number 卡牌id
---@param cardSkinId2Lv? table<number, number>
---@param customCardSkinId2Lv? table<number, number>
---@param attrAddId2V table<number, number>
---@param walkFunc? fun(skinId:number, level:number, attrAddId:number, attrV:number, index?:number):boolean
---@return table<number, number>
function CardProgressionCombatEffUtils.CalcFashionProperty(cardId, cardSkinId2Lv, customCardSkinId2Lv, attrAddId2V, walkFunc)
    local cardSkinIds = cardConfMgr:GetCardSkinsByCardId(cardId)
    if cardSkinIds == nil then return end

    local skinId2Lv
    if customCardSkinId2Lv then
        skinId2Lv = customCardSkinId2Lv
    elseif cardSkinId2Lv then
        skinId2Lv = cardSkinId2Lv
    else
        ---@type CardSkinComponent
        local cardSkinComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardSkinComponent)
        skinId2Lv = cardSkinComponent:GetSkinId2LvByCardId(cardId)
    end

    if skinId2Lv == nil then return end

    local skinCount = table.count(skinId2Lv)
    if skinCount > CardProgressionConstants.FashionSkinAttrLimit then
        CardProgressionCombatEffUtils.CalcMultiFashionProperty(skinId2Lv, attrAddId2V, walkFunc)

    else
        for skinId, level in pairs(skinId2Lv) do
            ---@type CardSkinVo
            local skinVo = cardConfMgr:GetCardSkinBySkinId(skinId)
            if skinVo and skinVo.isHandbook and skinVo.skinMaxLevel > 0 and level > 0 then
                ---@type SkinAttributeVo
                local vo    = cardConfMgr:GetSkinAttributeVo(skinId, level)
                if vo then
                    local attrs = vo:GetAttributes()
                    if walkFunc then
                        CardProgressionCombatEffUtils.InsertAttrAddId2VByAttrs(attrs, attrAddId2V, 1, function (attrAddId, attrV)
                            walkFunc(skinId, level, attrAddId, attrV)
                        end)
                    else
                        CardProgressionCombatEffUtils.InsertAttrAddId2VByAttrs(attrs, attrAddId2V, 1)
                    end
                end
            end
            
        end
    end
    
    
    return attrAddId2V
end

function CardProgressionCombatEffUtils.CalcMultiFashionProperty(skinId2Lv, attrAddId2V, walkFunc, isOwnMaxLv)
    local tempAddAttrId2AttrInfoList = CardProgressionCombatEffUtils.GetAttrAddId2FashionAttr()
    for skinId, level in pairs(skinId2Lv) do
        ---@type CardSkinVo
        local skinVo = cardConfMgr:GetCardSkinBySkinId(skinId)
        if skinVo and skinVo.isHandbook and skinVo.skinMaxLevel > 0 and level > 0 then
            ---@type SkinAttributeVo
            local vo    = cardConfMgr:GetSkinAttributeVo(skinId, isOwnMaxLv and skinVo.skinMaxLevel or level)
            if vo then
                local attrs = vo:GetAttributes()
                table.walk(attrs, function(attrAddId, attrV)
                    attrAddId  = checkNumber(attrAddId)
                    attrV      = checkNumber(attrV)
                    tempAddAttrId2AttrInfoList[attrAddId] = tempAddAttrId2AttrInfoList[attrAddId] or {}

                    local attr = CardProgressionCombatEffUtils.CreateFashionAttrInfo(skinId, level, attrV)
                    table.insert(tempAddAttrId2AttrInfoList[attrAddId], attr)

                end)
            end

        end
    end

    for attrAddId, attrInfoList in pairs(tempAddAttrId2AttrInfoList) do
        table.sort(attrInfoList, function (a, b)
            if a.attrV ~= b.attrV then
                return a.attrV > b.attrV
            end
            return a.skinId < b.skinId
        end)
        for index, attrInfo in ipairs(attrInfoList) do
            local attrV = attrInfo.attrV
            if walkFunc == nil then
                local newV = (attrAddId2V[attrAddId] or 0) + attrV
                attrAddId2V[attrAddId] = newV
                if index == CardProgressionConstants.FashionSkinAttrLimit then
                    break
                end
            else
                if index <= CardProgressionConstants.FashionSkinAttrLimit then
                    local newV = (attrAddId2V[attrAddId] or 0) + attrV
                    attrAddId2V[attrAddId] = newV
                end
                if walkFunc(attrInfo.skinId, attrInfo.level, attrAddId, attrV, index) then
                    break
                end
            end
        end
    end

    CardProgressionCombatEffUtils.FreeFashionAttrTable()
end

function CardProgressionCombatEffUtils.GetTablePool()
    if CardProgressionCombatEffUtils.tablePool == nil then
        CardProgressionCombatEffUtils.tablePool = {}
    end
    return CardProgressionCombatEffUtils.tablePool
end

function CardProgressionCombatEffUtils.GetTable()
    local tablePool = CardProgressionCombatEffUtils.GetTablePool()
    return table.remove(tablePool) or {}
end

function CardProgressionCombatEffUtils.GetAttrAddId2FashionAttr()
    if CardProgressionCombatEffUtils.attrAddId2FashionAttr == nil then
        CardProgressionCombatEffUtils.attrAddId2FashionAttr = {}
    end
    return CardProgressionCombatEffUtils.attrAddId2FashionAttr
end

function CardProgressionCombatEffUtils.CreateFashionAttrInfo(skinId, level, attrV)
    local t = CardProgressionCombatEffUtils.GetTable()
    t.skinId = skinId
    t.level = level
    t.attrV = attrV
    return t
end

function CardProgressionCombatEffUtils.FreeFashionAttrTable()
    local attrAddId2FashionAttr = CardProgressionCombatEffUtils.GetAttrAddId2FashionAttr()
    local tablePool = CardProgressionCombatEffUtils.GetTablePool()
    
    for attrAddId, list in pairs(attrAddId2FashionAttr) do
        local len = #list
        for i = len, 1, -1 do
            local t = list[i]
            list[i] = nil
            ClearT(t)
            table.insert(tablePool, t)
        end
    end
    
end

---GenerateAllLimitlessGlobalProperty
---生成所有无限制全局属性
function CardProgressionCombatEffUtils.GenerateAllLimitlessGlobalProperty(extParams)
    if extParams and extParams.isIgnoreGlobal then
        return
    end
    local attrProvider2AttrAddId2V = {
        [Constants.AttributeProviderType.Global]       = {},
        [Constants.AttributeProviderType.GlobalTalent] = {},
    }

    CardProgressionCombatEffUtils.CalcLimitlessGlobalProperty(extParams or {}, false, nil, attrProvider2AttrAddId2V)

    return attrProvider2AttrAddId2V
end

---计算无限制条件全局属性加成
function CardProgressionCombatEffUtils.CalcLimitlessGlobalProperty(extParams, isIgnoreGlobal, attrAddId2V, attrProvider2AttrAddId2V)
    local GetProviderAttrAddId2V = CardProgressionCombatEffUtils.GetProviderAttrAddId2V

    ---计算全局属性
    CardProgressionCombatEffUtils.CalcGlobalProperty(extParams.developAdditionInfo or {}, isIgnoreGlobal, GetProviderAttrAddId2V(attrAddId2V, attrProvider2AttrAddId2V, Constants.AttributeProviderType.Global, extParams.specifyAttrProvider2AttrAddId2v))

    ---计算全局天赋属性
    CardProgressionCombatEffUtils.CalcGlobalTalentProperty(extParams.globalTalent, isIgnoreGlobal, GetProviderAttrAddId2V(attrAddId2V, attrProvider2AttrAddId2V, Constants.AttributeProviderType.GlobalTalent, extParams.specifyAttrProvider2AttrAddId2v))

    CardProgressionCombatEffUtils.CalcDailyInvestGlobalProperty(extParams.dailyInvestGlobalInfo or {}, isIgnoreGlobal, GetProviderAttrAddId2V(attrAddId2V, attrProvider2AttrAddId2V, Constants.AttributeProviderType.Global, extParams.specifyAttrProvider2AttrAddId2v))

end

---计算全局属性加成
---@param developAdditionInfo table[] @ 预留用；目前定的是查看三方卡牌信息时，也按照checkin中的数据格式返回
---@param isIgnoreGlobal boolean | nil @ 是否忽略全局属性加成
---@param attrAddId2V table<Constants.AttrAdditionIdType, number> @ 传入的属性map
---@return table<Constants.AttrAdditionIdType, number> @ 更改后的属性map
function CardProgressionCombatEffUtils.CalcGlobalProperty(developAdditionInfo, isIgnoreGlobal, attrAddId2V, isCanSpecify)
    if isIgnoreGlobal == true or isCanSpecify == true then
        return attrAddId2V
    end
    -- 计算卡牌收集全局属性加成
    ---@type table<integer, integer> @ 属性加成map（key：属性id，value：属性值）
    local additionAttrMap = {}
    if next(developAdditionInfo) == nil then
        -- 自己的全局加成
        ---@type CardComponent
        local cardComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
        additionAttrMap = cardComp:GetAdditionAttrMap()
    else
        -- 三方的属性加成
        ---@type IllustratedHandbookComponent
        local illustratedHandbookComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.IllustratedHandbookComponent)
        for _, infoData in ipairs(developAdditionInfo) do
            local activateRewardsVo = illustratedHandbookComp:GetAdditionRewardsVoAt(infoData.type, infoData.unlocked)
            if illustratedHandbookComp:HasCardCollectionType(infoData.type) and next(activateRewardsVo) then
                additionAttrMap[activateRewardsVo.attTypeId] = checkInt(activateRewardsVo.attAddNum)
            end
        end
    end
    
    for attrId, attrValue in pairs(additionAttrMap) do
        if attrValue > 0 then
            local attrSubId = checkNumber(attrId)
            if not attrAddId2V[attrSubId] then
                attrAddId2V[attrSubId] = attrValue
            else
                local v = attrAddId2V[attrSubId]
                attrAddId2V[attrSubId] = v + attrValue
            end
        end
    end
    
    return attrAddId2V
end

function CardProgressionCombatEffUtils.CalcDailyInvestGlobalProperty(developAdditionInfo, isIgnoreGlobal, attrAddId2V, isCanSpecify)
    if isIgnoreGlobal == true or isCanSpecify == true then
        return attrAddId2V
    end
    -- 计算卡牌收集全局属性加成
    ---@type table<integer, integer> @ 属性加成map（key：属性id，value：属性值）
    local additionAttrMap
    if next(developAdditionInfo) == nil then
        local DailyInvestMgr = import('Game.UI.ResidentEvent.DailyInvestMgr')
        additionAttrMap = DailyInvestMgr:GetInstance():GetPropertyData()
    else
        additionAttrMap = developAdditionInfo
    end

    for attrId, attrValue in pairs(additionAttrMap) do
        if attrValue > 0 then
            local attrSubId = checkNumber(attrId)
            if not attrAddId2V[attrSubId] then
                attrAddId2V[attrSubId] = attrValue
            else
                local v = attrAddId2V[attrSubId]
                attrAddId2V[attrSubId] = v + attrValue
            end
        end
    end

    return attrAddId2V
end


---计算全局属性加成
---@param customGlobalTalent table[] @ 预留用；目前定的是查看三方卡牌信息时 自定义需要传入与 GlobalTalentMgr.globalTalent 相同的格式数据
---@param isIgnoreGlobal boolean | nil @ 是否忽略全局属性加成
---@param attrAddId2V table<Constants.AttrAdditionIdType, number> @ 传入的属性map
---@return table<Constants.AttrAdditionIdType, number> @ 更改后的属性map
function CardProgressionCombatEffUtils.CalcGlobalTalentProperty(customGlobalTalent, isIgnoreGlobal, attrAddId2V, isCanSpecify)
    if isIgnoreGlobal == true or isCanSpecify == true then
        return attrAddId2V
    end

    ---@type GlobalTalentMgr
    local instance     = GlobalTalentMgr:GetInstance()
    local globalTalent
    local attributeTalentIdMap 
    if customGlobalTalent ~= nil then
        globalTalent         = customGlobalTalent
        attributeTalentIdMap = {}
        for effectId, value in pairs(globalTalent) do
            if instance:IsAttributeTalent(effectId) then
                attributeTalentIdMap[effectId] = true
            end
        end
    else
        attributeTalentIdMap = instance:GetAttributeTalentIdMap()
        globalTalent = instance:GetGlobalTalent()
    end

    ---@type HomelandTalentConfMgr
    local HomelandTalentConfMgr = import("Game.Homeland.Talent.HomelandTalentConfMgr")
    local t = attributeTalentIdMap
    for effectId, _ in pairs(t) do
        ---@type HomelandTalentEnumVo
        local vo          = HomelandTalentConfMgr:GetHomelandTalentEnumVo(effectId)
        local attrAddId   = vo.attributeId
        local num         = instance:CalcNumByGlobalTalentAndSource(globalTalent, Constants.GlobalTalentSource.Talent, 0, effectId, vo.isPercentage == 1, function ()
            return true
        end)
        attrAddId2V[attrAddId] = (attrAddId2V[attrAddId] or 0) + num
    end

    return attrAddId2V
    
end

--- 计算信息录入带来的加成
---@param cardId integer 卡牌id
---@param isIgnoreGlobal boolean | nil 是否忽略全局属性加成
---@param attrAddId2V table<Constants.AttrAdditionIdType, number> @ 传入的属性map
---@return table<Constants.AttrAdditionIdType, number> @ 更改后的属性map
function CardProgressionCombatEffUtils.CalcGlobalCheckInProperty(customGlobalTalent, cardId, isIgnoreGlobal, attrAddId2V)
    if isIgnoreGlobal == true then
        return attrAddId2V
    end

    ---@type CardVo
    local cardVo = cardConfMgr:GetCardByRefId(cardId)
    if cardVo == nil then
        return attrAddId2V
    end

    ---@type GlobalTalentMgr
    local instance = GlobalTalentMgr:GetInstance()
    local globalTalent
    local attributeTalentIdMap 
    if customGlobalTalent ~= nil then
        globalTalent         = customGlobalTalent
        attributeTalentIdMap = {}
        for effectId, value in pairs(globalTalent) do
            if instance:IsAttributeTalent(effectId) then
                attributeTalentIdMap[effectId] = true
            end
        end
    else
        attributeTalentIdMap = instance:GetAttributeTalentIdMap()
        globalTalent = instance:GetGlobalTalent()
    end

    local color = cardVo.attributeType

    local t = { 101, 201, 301 }

    for i, attrAddId in ipairs(t) do
        local talentEffectId = GameUtils.CalculateBattleAttrTalentEffectId(attrAddId)
        local value = instance:CalcNumByGlobalTalentAndSource(globalTalent, Constants.GlobalTalentSource.CheckIn, 0, talentEffectId, false, function(info)
            local talentEffectId = GameUtils.CalculateBattleAttrTalentEffectId(attrAddId)
                -- print("信息录入", attrAddId, info.talentInfo.color)
                if info == nil then
                    return false
                end
                if info.vo == nil then
                    return false
                end
                local addtionColor = checkNumber(info.vo.param1)
                return addtionColor == 0 or addtionColor == color
            end)
        attrAddId2V[attrAddId] = (attrAddId2V[attrAddId] or 0) + value
    end

    return attrAddId2V
end


---GetProviderAttrAddId2V
---获取提供者属性加成定义表2数值
---@param attrAddId2V table<Constants.AttrAdditionIdType, number>
---@param attrProvider2AttrAddId2V table<Constants.AttributeProviderType, table<Constants.AttrAdditionIdType, number>>
---@param providerType Constants.AttributeProviderType
function CardProgressionCombatEffUtils.GetProviderAttrAddId2V(attrAddId2V, attrProvider2AttrAddId2V, providerType, specifyAttrProvider2AttrAddId2v)
    --- 能知道数据则合并掉
    local isCanSpecify = specifyAttrProvider2AttrAddId2v ~= nil and specifyAttrProvider2AttrAddId2v[providerType] ~= nil
    if isCanSpecify then
        local providerAttrAddId2v = specifyAttrProvider2AttrAddId2v[providerType]
        if attrProvider2AttrAddId2V then
            attrProvider2AttrAddId2V[providerType] = providerAttrAddId2v
        else
            for attrAddId, num in pairs(providerAttrAddId2v) do
                attrAddId2V[attrAddId] = (attrAddId2V[attrAddId] or 0) + num
            end
        end
        -- print("CardProgressionCombatEffUtils", table.toString(specifyAttrProvider2AttrAddId2v))
    end

    return attrProvider2AttrAddId2V and attrProvider2AttrAddId2V[providerType] or attrAddId2V, isCanSpecify
end

--- InsertAttrAddId2VByAttrs
---@param attrs table {[属性定义加成表id] = 数值}
---@param attrAddId2V table {[属性定义加成表id] = 数值}
---@param factor number 系数 默认1
---@param walkFunc? fun(attrAddId:number, attrV:number) 
function CardProgressionCombatEffUtils.InsertAttrAddId2VByAttrs(attrs, attrAddId2V, factor, walkFunc)
    factor = factor or 1
    table.walk(attrs, function(attrAddId, attrV)
        attrV      = checkNumber(attrV)
        attrAddId  = checkNumber(attrAddId)
        if walkFunc then
            walkFunc(attrAddId, attrV)
        end
        local v    = attrAddId2V[attrAddId] or 0
        local newV = v + attrV * factor
        attrAddId2V[attrAddId] = newV

    end)
end

---@class SingleAttrTypeData
---@field attrAddId number
---@field order number
---@field icon string
---@field name string
---@field attrNum string
---@field isConversion number
---@field viewType CardProgressionConstants.AttrNodeType

--- GenerateAttrTypeDataByAttrAddId2V
---@param attrAddId2V table {[属性定义加成表id] = 数值}
---@return SingleAttrTypeData[]
function CardProgressionCombatEffUtils.GenerateSingleAttrTypeDataByAttrAddId2V(attrAddId2V, isAddPlus, isDisableSort)
    local t = {}
    local attribute_format = attribute_format
    for attrAddId, attrV in pairs(attrAddId2V) do
        ---@type AttrDefinesVo
        local vo = cardConfMgr:GetBasicAttrByBasicAttrAdditionId(attrAddId)
        local text = attribute_format(vo.isConversion, checkNumber(attrV))
        table.insert(t, {
            attrAddId = attrAddId,
            isConversion = vo.isConversion,
            order = vo.order,
            icon = vo.icon,
            name = vo.name,
            attrNum = isAddPlus and '+' .. text or text,
            viewType = CardProgressionConstants.AttrNodeType.Single,
        })
    end
    table.sort(t, function(a, b) return a.order < b.order end)
    return t
end

---GeneratedProviderAttrId2AttrAddTypeConfig
---@param entity CardProgressionEntity 
---@param extParams table | nil
---@param providerAttrIdAttrAddTypeConfig table<Constants.AttributeProviderType, table<Constants.AttrTypeId, table<Constants.BasicAttrAddType, number>>> | nil
---@param attrId2TotalConstants table | nil
---@return table providerAttrIdAttrAddTypeConfig 
---@return table attrId2TotalConstants 
function CardProgressionCombatEffUtils.GeneratedProviderAttrId2AttrAddTypeConfig(entity, extParams, providerAttrIdAttrAddTypeConfig, attrId2TotalConstants, attrId2CardBasicTotalConstants, attrProvider2AttrAddId2V)
    ---计算一下每个养成模块的属性
    attrProvider2AttrAddId2V         = CardProgressionCombatEffUtils.CalcCardCultivateModuleTotalProperty(entity, extParams, attrProvider2AttrAddId2V)
    providerAttrIdAttrAddTypeConfig   = providerAttrIdAttrAddTypeConfig or {}
    attrId2TotalConstants            = attrId2TotalConstants or {}
    attrId2CardBasicTotalConstants   = attrId2CardBasicTotalConstants or {}

    local ConstType = Constants.BasicAttrAddType.Const
    for providerType, attrAddId2V in pairs(attrProvider2AttrAddId2V) do
        CardProgressionCombatEffUtils.WalkAttrAddId2AddId(attrAddId2V, function (attrAddType, attrId, addV)
            providerAttrIdAttrAddTypeConfig[providerType] = providerAttrIdAttrAddTypeConfig[providerType] or {}
            providerAttrIdAttrAddTypeConfig[providerType] = CardProgressionCombatEffUtils.FillAttrId2AttrAddTypeConfig(providerAttrIdAttrAddTypeConfig[providerType], attrId, attrAddType, addV)

            if ConstType == attrAddType then
                attrId2TotalConstants[attrId] = (attrId2TotalConstants[attrId] or 0) + addV
                if IsBasicCardAttr(providerType) then
                    attrId2CardBasicTotalConstants[attrId] = (attrId2CardBasicTotalConstants[attrId] or 0) + addV
                    
                end

            end
            
        end)
    end

    return providerAttrIdAttrAddTypeConfig, attrId2TotalConstants, attrId2CardBasicTotalConstants
end


---FillProviderAttrId2AttrAddTypeConfigByAdd2V
---通过加成属性->加成数值填充 属性id->每个提供者对应的属性加成类型配置
function CardProgressionCombatEffUtils.FillProviderAttrId2AttrAddTypeConfigByAdd2V(attrAddId2V, providerType, providerAttrId2AttrAddTypeConfig, attrId2TotalConstants)
    local isExist   = attrId2TotalConstants ~= nil
    local ConstType = Constants.BasicAttrAddType.Const
    for attrAddId, addV in pairs(attrAddId2V) do
        local attrAddType, attrId = CardProgressionCombatEffUtils.FillProviderAttrId2AttrAddTypeConfigByAdd(providerAttrId2AttrAddTypeConfig, providerType, attrAddId, addV)

        if isExist and attrAddType == ConstType then
            attrId2TotalConstants[attrId] = (attrId2TotalConstants[attrId] or 0) + addV
        end

    end
    return providerAttrId2AttrAddTypeConfig
end


---FillProviderAttrId2AttrAddTypeConfigByAdd
---通过加成数据 填充 属性id->每个提供者对应的属性加成类型配置
---@param providerAttrId2AttrAddTypeConfig table<Constants.AttributeProviderType, table<Constants.AttrTypeId, table<Constants.BasicAttrAddType, number>>>
---@param providerType Constants.AttributeProviderType
---@param addAttrId Constants.AttrAdditionIdType
---@param addTypeNum number
function CardProgressionCombatEffUtils.FillProviderAttrId2AttrAddTypeConfigByAdd(providerAttrId2AttrAddTypeConfig, providerType, addAttrId, addTypeNum)
    --机器人会配0   策划不让报这个error 
    if checkNumber(addAttrId) <= 0 then
        return
    end
    local vo = cardConfMgr:GetBasicAttrAdditionById(addAttrId)
    if vo == nil then
       printError("属性加成定义表中未找到 %s", addAttrId)
        return
    end

    addTypeNum        = checkNumber(addTypeNum)
    local attrId      = vo.attrId
    local attrAddType = vo.attAddType
    CardProgressionCombatEffUtils.FillProviderAttrId2AttrAddTypeConfig(providerAttrId2AttrAddTypeConfig, providerType, attrId, attrAddType, addTypeNum)

    return attrAddType, attrId

end


---GeneratedAttrId2AttrAddTypeConfig
---生成 属性id2属性加成类型配置
---@param attrAddId2V table<string, number>
function CardProgressionCombatEffUtils.GeneratedAttrId2AttrAddTypeConfig(attrAddId2V, attributes)
    attributes = attributes or {}
    local vo
    for attrAddId, addV in pairs(attrAddId2V) do
        --机器人会配0   策划不让报这个error 
        if checkNumber(attrAddId) > 0 then
            vo = cardConfMgr:GetBasicAttrAdditionById(attrAddId)
            if vo then
                -- local attrAddType = checkNumber(vo.attAddType)
                -- local attrId = checkNumber(vo.attrId)
                -- attributes[attrId] = attributes[attrId] or {}
                -- addV = checkNumber(addV)
                -- local oldV = attributes[attrId][attrAddType] or 0
                -- attributes[attrId][attrAddType] = oldV + addV
                CardProgressionCombatEffUtils.FillAttrId2AttrAddTypeConfig(attributes, vo.attrId, vo.attAddType, addV)
            else
                printError("属性加成定义表中未找到 %s", attrAddId)
            end
        end
    end
    return attributes
end

function CardProgressionCombatEffUtils.FillAttrId2AttrAddTypeConfig(attrId2AttrAddTypeConfig, attrId, attrAddType, addV)
    attrId      = checkNumber(attrId)
    attrAddType = checkNumber(attrAddType)
    addV        = checkNumber(addV)
    attrId2AttrAddTypeConfig[attrId] = attrId2AttrAddTypeConfig[attrId] or {}
    local oldV = attrId2AttrAddTypeConfig[attrId][attrAddType] or 0
    attrId2AttrAddTypeConfig[attrId][attrAddType] = oldV + addV
    return attrId2AttrAddTypeConfig
end

--- CalcModuleAttributeValue
--- 计算模块属性值
---@param attrAddTypeConfig table<Constants.BasicAttrAddType, number>
---@param attrId number | nil
---@param cardId number | nil
---@param totalAttrAddConstants table<number, number>
---@return number
function CardProgressionCombatEffUtils.CalcModuleAttributeValue(attrAddTypeConfig, attrId, cardId, totalAttrAddConstant)
    if attrId and checkNumber(attrId) == Constants.AttrTypeId.Sp then
        if cardId == nil then
            printError("获取Sp点数 需要传入 卡牌id", cardId)
            return 0
        end
        local cardVo = cardConfMgr:GetCardByRefId(cardId)
        return cardVo.maxSp
    end

    return CardProgressionCombatEffUtils.CalcAttributeValue(attrAddTypeConfig, totalAttrAddConstant)

end

function CardProgressionCombatEffUtils.CheckAttributeValue(attrV, attrId, cardId)
    if attrId and checkNumber(attrId) == Constants.AttrTypeId.Sp then
        if cardId == nil then
            printError("获取Sp点数 需要传入 卡牌id", cardId)
            return 0
        end
        local cardVo = cardConfMgr:GetCardByRefId(cardId)
        return cardVo.maxSp
    end

    return attrV

end

---CalcAttributeValueByTotalConstants
---根据总常量计算属性
function CardProgressionCombatEffUtils.CalcAttributeValueByTotalConstants(attrAddTypeConfig, totalAttrAddConstant)
    local BasicAttrAddType = Constants.BasicAttrAddType
    local attrConstant  = attrAddTypeConfig[BasicAttrAddType.Const] or 0
    local totalConstant = totalAttrAddConstant or 0
    local percent       = (attrAddTypeConfig[BasicAttrAddType.Percent] or 0)
    return attrConstant + totalConstant * percent

end

---CalcAttributeValueBySelfConstants
---根据自身常量计算属性
function CardProgressionCombatEffUtils.CalcAttributeValueBySelfConstants(attrAddTypeConfig)
    local BasicAttrAddType = Constants.BasicAttrAddType
    local attrConstant     = attrAddTypeConfig[BasicAttrAddType.Const] or 0
    local percent          = (attrAddTypeConfig[BasicAttrAddType.Percent] or 0)
    return attrConstant * (1 + percent)

end

-- local num_floor = num_floor
function CardProgressionCombatEffUtils.FloorAttributeValue(attrV, isPercent)
    return isPercent and attrV or floor(attrV) 
end

---CalcExtraAttributeValue
---计算附加属性
function CardProgressionCombatEffUtils.CalcExtraAttributeValue(baseV, addTypeConfig)
    baseV = baseV or 0
    if addTypeConfig == nil then
        return baseV
    end
    local BasicAttrAddType = Constants.BasicAttrAddType
    local constant = addTypeConfig[BasicAttrAddType.Const]   or 0
    local percent  = addTypeConfig[BasicAttrAddType.Percent] or 0
    local num = (baseV + constant) * (percent + 1)
    return num

end

function CardProgressionCombatEffUtils.GeneratedEntityTotalAttrConstant(entity, extParams)
    local attrAddId2V = CardProgressionCombatEffUtils.CalcCardTotalProperty(entity, extParams)
    local ConstType = Constants.BasicAttrAddType.Const
    local attrId2TotalConstants = {}
    CardProgressionCombatEffUtils.WalkAttrAddId2AddId(attrAddId2V, function (attrAddType, attrId, addV)
        if ConstType == attrAddType then
            attrId2TotalConstants[attrId] = (attrId2TotalConstants[attrId] or 0) + addV
        end
    end)
    return attrId2TotalConstants
end

function CardProgressionCombatEffUtils.WalkAttrAddId2AddId(attrAddId2V, cb)
    local vo
    for attrAddId, addV in pairs(attrAddId2V) do
        --机器人会配0   策划不让报这个error 
        if checkNumber(attrAddId) > 0 then
            vo = cardConfMgr:GetBasicAttrAdditionById(attrAddId)
            if vo then
                local attrAddType = checkNumber(vo.attAddType)
                local attrId      = checkNumber(vo.attrId)
                if cb then
                    cb(attrAddType, attrId, addV)
                end
            else
                printError("属性加成定义表中未找到 %s", attrAddId)
            end
        end
    end
end

--endregion

--region Combat Effectiveness Provider


---计算无限制条件全局战力
function CardProgressionCombatEffUtils.CalcAllLimitlessGlobalCombat(extParams, providerCombatEff2AddTypeConfig)
    if extParams and extParams.isIgnoreGlobal then
        return
    end
    ---计算全局天赋属性
    providerCombatEff2AddTypeConfig = CardProgressionCombatEffUtils.GenerateGlobalTalentCombatEffectivenessProvider(extParams or {}, providerCombatEff2AddTypeConfig)

    return providerCombatEff2AddTypeConfig
end


---GenerateExtraCombatEffProvider
---生成附加战力提供者
---@param entity CardProgressionEntity
---@param extParams table
---@param attrId2ProviderAttrAddTypeConfig table<Constants.AttrTypeId, table<Constants.AttributeProviderType, table<Constants.BasicAttrAddType, number>>>
---@param providerCombatEff2AddTypeConfig table
function CardProgressionCombatEffUtils.GenerateExtraCombatEffProvider(entity, extParams, attrId2ProviderAttrAddTypeConfig, providerCombatEff2AddTypeConfig)

    providerCombatEff2AddTypeConfig = CardProgressionCombatEffUtils.GenerateSkillLevelCombatEffectivenessProvider(entity.cardDojo, extParams, providerCombatEff2AddTypeConfig)

    providerCombatEff2AddTypeConfig = CardProgressionCombatEffUtils.GenerateEquipmentCombatEffectivenessProvider(entity.equipPart2Dojo, extParams and extParams.equipIdList or nil, extParams and extParams.equipPart2Dojo or nil, providerCombatEff2AddTypeConfig)
    
    providerCombatEff2AddTypeConfig = CardProgressionCombatEffUtils.GenerateGlobalTalentCombatEffectivenessProvider(extParams or {}, providerCombatEff2AddTypeConfig, entity)

    providerCombatEff2AddTypeConfig = CardProgressionCombatEffUtils.GenerateWeaponCombatEffectivenessProvider(entity.cardId, extParams and extParams.weaponUnlocked or entity.cardDojo.weaponUnlocked, providerCombatEff2AddTypeConfig)

    if extParams == nil then return attrId2ProviderAttrAddTypeConfig, providerCombatEff2AddTypeConfig end

    -----------------------------------------------------
    ---附加属性 依赖上面计算后的属性 
    ---计算 羁绊属性 = 卡牌基础总属性
    if extParams and extParams.synergiesId then
        attrId2ProviderAttrAddTypeConfig, providerCombatEff2AddTypeConfig = CardProgressionCombatEffUtils.GenerateSynergiesCombatEffConf(extParams.synergiesId, extParams.synergiesDojo, attrId2ProviderAttrAddTypeConfig, providerCombatEff2AddTypeConfig, extParams.isIgnoreGlobal)

    end

    ---2023.7.26 废弃 如果猫球有百分比属性的话 是放大 猫球属性 = (卡牌基础总属性 + floor(羁绊属性) + floor(猫球常量属性)) * 猫球百分比属性  
    ---基础属性+猫球固定值加成+基础属性x猫球百分比+羁绊属性常量+羁绊特殊属性
    if extParams and extParams.teamCats then
        attrId2ProviderAttrAddTypeConfig  = CardProgressionCombatEffUtils.GenerateCatBallCombatEffConf(extParams.teamCats, attrId2ProviderAttrAddTypeConfig)
    end

    return attrId2ProviderAttrAddTypeConfig, providerCombatEff2AddTypeConfig

end


---GenerateSkillLevelCombatEffectivenessProvider
---生成技能战力提供者
function CardProgressionCombatEffUtils.GenerateSkillLevelCombatEffectivenessProvider(dojo, extParams, providerCombatEff2AddTypeConfig)
    if dojo == nil then
        return providerCombatEff2AddTypeConfig
    end
    ---计算一下技能等级提供的战力
    local skillLevelCombatEff       = CardProgressionCombatEffUtils.CalcSkillLevelCombatEffectiveness(dojo, extParams)
    providerCombatEff2AddTypeConfig = CardProgressionCombatEffUtils.FillProviderCombatEffAddTypeConf(providerCombatEff2AddTypeConfig, Constants.AttributeProviderType.Skill, Constants.BasicAttrAddType.Const, skillLevelCombatEff)
    return providerCombatEff2AddTypeConfig
end

---GenerateGlobalTalentCombatEffectivenessProvider
---生成技能战力提供者
function CardProgressionCombatEffUtils.GenerateGlobalTalentCombatEffectivenessProvider(extParams, providerCombatEff2AddTypeConfig, entity)
    local isIgnoreGlobal = extParams.isIgnoreGlobal == true or (entity ~= nil and entity.isIgnoreGlobal == true)
    if isIgnoreGlobal == true then
        return providerCombatEff2AddTypeConfig
    end
    
    if extParams.specifyProviderCombatEff2AddTypeConfig and extParams.specifyProviderCombatEff2AddTypeConfig[Constants.AttributeProviderType.GlobalTalent] then
        providerCombatEff2AddTypeConfig[Constants.AttributeProviderType.GlobalTalent] = extParams.specifyProviderCombatEff2AddTypeConfig[Constants.AttributeProviderType.GlobalTalent]
       return providerCombatEff2AddTypeConfig
    end

    local customGlobalTalent = extParams.customGlobalTalent
    ---@type GlobalTalentMgr
    local instance           = GlobalTalentMgr:GetInstance()
    local globalTalent
    if customGlobalTalent ~= nil then
        globalTalent         = customGlobalTalent
    else
        globalTalent         = instance:GetGlobalTalent()
    end

    local combatEff = instance:CalcExtraCombatEffectBySource(Constants.GlobalTalentSource.Talent, globalTalent)
    providerCombatEff2AddTypeConfig = CardProgressionCombatEffUtils.FillProviderCombatEffAddTypeConf(providerCombatEff2AddTypeConfig, Constants.AttributeProviderType.GlobalTalent , Constants.BasicAttrAddType.Const, combatEff)
    
    return providerCombatEff2AddTypeConfig
end

---GenerateEquipmentCombatEffectivenessProvider
---生成装备战力提供者
---@param equipPart2Dojo table<number, EquipDojo>
---@param equipIdList number[]
---@param extEquipPart2Dojo table<number, EquipDojo>
function CardProgressionCombatEffUtils.GenerateEquipmentCombatEffectivenessProvider(equipPart2Dojo, equipIdList, extEquipPart2Dojo, providerCombatEff2AddTypeConfig)
    local equipPart2Dojo = CardProgressionCombatEffUtils.FixEquipPart2Dojo(equipPart2Dojo, equipIdList, extEquipPart2Dojo)
    
    local combatEff = 0
    ---@param dojo EquipDojo
    for key, dojo in pairs(equipPart2Dojo) do
        combatEff = combatEff + CardProgressionCombatEffUtils.CalcEquipmentCombatEffectiveness(dojo)
    end

    providerCombatEff2AddTypeConfig = CardProgressionCombatEffUtils.FillProviderCombatEffAddTypeConf(providerCombatEff2AddTypeConfig, Constants.AttributeProviderType.Equipment, Constants.BasicAttrAddType.Const, combatEff)

    return providerCombatEff2AddTypeConfig

end

---GenerateWeaponCombatEffectivenessProvider
---生成专武战力提供者
---@param cardId number 卡牌id
---@param weaponLv number 卡牌专武等级
---@param providerCombatEff2AddTypeConfig table 
function CardProgressionCombatEffUtils.GenerateWeaponCombatEffectivenessProvider(cardId, weaponLv, providerCombatEff2AddTypeConfig)
    local isLock = checkNumber(weaponLv) == 0
    if isLock then
        return providerCombatEff2AddTypeConfig
    end

    local ids = cardConfMgr:GetRoleCardExclusiveWeaponIds(cardId)
    if ids == nil then return providerCombatEff2AddTypeConfig end

    local combatEff = 0
    for lv = 1, weaponLv do
        local id = ids[lv]
        ---@type RoleCardExclusiveWeaponVo
        local vo = cardConfMgr:GetRoleCardExclusiveWeaponVoById(id)
        if vo then
            combatEff = vo.capabilityValue + combatEff
        end
    end

    if combatEff > 0 then
        providerCombatEff2AddTypeConfig = CardProgressionCombatEffUtils.FillProviderCombatEffAddTypeConf(providerCombatEff2AddTypeConfig, Constants.AttributeProviderType.Weapon, Constants.BasicAttrAddType.Const, combatEff)
    end

    return providerCombatEff2AddTypeConfig
end

---CalcEquipmentCombatEffectiveness
---计算装备星级战力
---@param dojo EquipDojo
function CardProgressionCombatEffUtils.CalcEquipmentCombatEffectiveness(dojo)
    local combatEff = 0
    local equipmentId = dojo.equipmentId
    --机器人会配装备0   策划不让报这个error 
    if checkNumber(equipmentId) > 0 then
        ---@type EquipVo
        local equipVo = cardConfMgr:GetEquipVoById(equipmentId)
        if equipVo then
            local dojoStar       = checkNumber(dojo.star)
            local rare           = equipVo.rare
            ---@type EquipQualityVo
            local equipQualityVo = cardConfMgr:GetEquipQualityVoByRefId(rare)
            local starCombatEffs = equipQualityVo.starCombatEffs
            for star, value in ipairs(starCombatEffs) do
                if dojoStar >= star then
                    combatEff = combatEff + value
                else
                    break
                end
            end
            
        else
            printError("装备表 中未找到 %s 数据", equipmentId)
        end
    end
    return combatEff
end

---CalcSkillLevelCombatEffectiveness
---计算技能等级战力
---@param dojo CardDojo 
---@param extParams table | nil
function CardProgressionCombatEffUtils.CalcSkillLevelCombatEffectiveness(dojo, extParams)
    ---@type CardDojo
    local cardDojo   = dojo
    local cardId     = cardDojo.cardId
    local star       = extParams and extParams.star or checkNumber(cardDojo.star)
    local num = 0
    local starIdList = cardConfMgr:GetCardStarIdList(cardId)
    for star_, starId in pairs(starIdList) do
        if star >= star_ then
            ---@type CardStarVo
            local vo = cardConfMgr:GetCardStarVo(starId)
            num = num + vo.capabilityValue
        end
    end
    
    return num
end

---GenerateSynergiesCombatEffConf
---生成羁绊战力加成配置
---@param synergiesId number 角色羁绊表id
---@param synergiesDojo CardDojo 角色卡牌数据
---@param providerAttrId2AttrAddTypeConfig table<Constants.AttributeProviderType, table<Constants.AttrTypeId, table<Constants.BasicAttrAddType, number>>>
---@param providerCombatEff2AddTypeConfig table<Constants.AttributeProviderType, table<Constants.BasicAttrAddType, number>>
function CardProgressionCombatEffUtils.GenerateSynergiesCombatEffConf(synergiesId, synergiesDojo, providerAttrId2AttrAddTypeConfig, providerCombatEff2AddTypeConfig, isIgnoreGlobal)
    if synergiesDojo == nil then
        return providerAttrId2AttrAddTypeConfig, providerCombatEff2AddTypeConfig
    end
    --- 由于 没算一次 都要 floor 一下 所以不能 做系数累加
    --- 羁绊普通加成属性
    local generalFactor        = cardConfMgr:GetSynergiesAddNum(synergiesDojo, isIgnoreGlobal)

    local AttrTypeId           = Constants.AttrTypeId
    local t                    = {AttrTypeId.Attack, AttrTypeId.Defense, AttrTypeId.Hp}
    local attrId2V = {
        [AttrTypeId.Attack] = 0,
        [AttrTypeId.Defense] = 0,
        [AttrTypeId.Hp] = 0,
    }
    local count = #t
    ---@param vo AttrDefinesVo
    FormulaUtils.HandleBaseAttrs(synergiesDojo, function (vo, attrV)
        local attrId = vo.id
        if attrId2V[attrId] then
            attrId2V[attrId] = attrV
            count = count - 1
        end
        return count == 0
    end)

    local providerType          = Constants.AttributeProviderType.Synergies
    local ConstType             = Constants.BasicAttrAddType.Const
    local FillProviderAttrId2AttrAddTypeConfig = CardProgressionCombatEffUtils.FillProviderAttrId2AttrAddTypeConfig
    for index, attrId in ipairs(t) do
        local baseV    = floor(attrId2V[attrId] or 0)
        local attrV    = floor(generalFactor * baseV)
        FillProviderAttrId2AttrAddTypeConfig(providerAttrId2AttrAddTypeConfig, providerType, attrId, ConstType, attrV)

    end
    
    if synergiesId == nil or synergiesId == 0 then
        return providerAttrId2AttrAddTypeConfig, providerCombatEff2AddTypeConfig
    end
    ---@type RoleCardSynergiesVo
    local vo = cardConfMgr:GetRoleCardSynergiesVo(synergiesId)
    if vo == nil then
        return providerAttrId2AttrAddTypeConfig, providerCombatEff2AddTypeConfig
    end

    providerAttrId2AttrAddTypeConfig, providerCombatEff2AddTypeConfig = CardProgressionCombatEffUtils.FillQuestUpBuff(vo.effectId, providerType, providerAttrId2AttrAddTypeConfig, providerCombatEff2AddTypeConfig)

    return providerAttrId2AttrAddTypeConfig, providerCombatEff2AddTypeConfig
end

function CardProgressionCombatEffUtils.FillProviderAttrId2AttrAddTypeConfig(providerAttrId2AttrAddTypeConfig, providerType, attrId, attrAddType, attrV)
    providerAttrId2AttrAddTypeConfig[providerType] = providerAttrId2AttrAddTypeConfig[providerType] or {}
    providerAttrId2AttrAddTypeConfig[providerType][attrId] = providerAttrId2AttrAddTypeConfig[providerType][attrId] or {}

    local oldV        = providerAttrId2AttrAddTypeConfig[providerType][attrId][attrAddType] or 0
    providerAttrId2AttrAddTypeConfig[providerType][attrId][attrAddType] = oldV + attrV
end

---GenerateCatBallCombatEffConf
---生成猫球战力加成配置
---@param teamCats TeamCatBallDojo[]
---@param providerAttrId2AttrAddTypeConfig table<Constants.AttributeProviderType, table<Constants.AttrTypeId, table<Constants.BasicAttrAddType, number>>>
function CardProgressionCombatEffUtils.GenerateCatBallCombatEffConf(teamCats, providerAttrId2AttrAddTypeConfig, providerCombatEff2AddTypeConfig)
    local attrAddId2V
    ---@param v TeamCatBallDojo
    for k, v in ipairs(teamCats) do
        local catBallId = v.catId
        if catBallId > 0 then
            local catBallStar = v.star or 0
            ---@type CatBallUtils
            local CatBallUtils =  import("Game.CatBall.CatBallUtils")
            attrAddId2V = CatBallUtils.GetCatBallAddAttrId2NumByStar(catBallId, catBallStar, attrAddId2V)
        end
    end

    if attrAddId2V then
        providerAttrId2AttrAddTypeConfig = CardProgressionCombatEffUtils.FillProviderAttrId2AttrAddTypeConfigByAdd2V(attrAddId2V, Constants.AttributeProviderType.CatBall, providerAttrId2AttrAddTypeConfig)
    end

    return providerAttrId2AttrAddTypeConfig, providerCombatEff2AddTypeConfig
end

---FillQuestUpBuff
---填充 关卡增益效果表 提供的属性与战力
---@param questUpBuffId number 关卡增益效果表id
---@param providerType Constants.AttributeProviderType
---@param providerAttrId2AttrAddTypeConfig table<Constants.AttrTypeId, table<Constants.AttributeProviderType, table<Constants.BasicAttrAddType, number>>>
---@param providerCombatEff2AddTypeConfig table<Constants.AttributeProviderType, table<Constants.BasicAttrAddType, number>>
function CardProgressionCombatEffUtils.FillQuestUpBuff(questUpBuffId, providerType, providerAttrId2AttrAddTypeConfig, providerCombatEff2AddTypeConfig, cardAttrType)
    ---@type QuestUpBuffVo
    local questBuffVo = QuestConfMgr:GetInstance():GetQuestUpBuffVo(questUpBuffId)
    if questBuffVo == nil then
        return providerAttrId2AttrAddTypeConfig
    end

    local attributeType = questBuffVo.attributeType
    if attributeType == Constants.QuestUpBufAttributeType.Attribute then
        if cardAttrType == nil or CheckIsCanAddAttr(cardAttrType, questBuffVo.type) then
            local addAttrId        = questBuffVo.attributeId
            local addTypeNum       = questBuffVo.addTypeNum
            CardProgressionCombatEffUtils.FillProviderAttrId2AttrAddTypeConfigByAdd(providerAttrId2AttrAddTypeConfig, providerType, addAttrId, addTypeNum)
        end
        
    elseif attributeType == Constants.QuestUpBufAttributeType.CombatEffectivenessConst then
        local combatValue = questBuffVo.combatValue1
        providerCombatEff2AddTypeConfig = CardProgressionCombatEffUtils.FillProviderCombatEffAddTypeConf(providerCombatEff2AddTypeConfig, providerType, Constants.BasicAttrAddType.Const, combatValue)
        
    elseif attributeType == Constants.QuestUpBufAttributeType.CombatEffectivenessPercent then
        local combatValue = questBuffVo.combatValue2
        providerCombatEff2AddTypeConfig = CardProgressionCombatEffUtils.FillProviderCombatEffAddTypeConf(providerCombatEff2AddTypeConfig, providerType, Constants.BasicAttrAddType.Percent, combatValue)
        
    end

    return providerAttrId2AttrAddTypeConfig, providerCombatEff2AddTypeConfig
end


---FillProviderCombatEffAddTypeConf
---添加提供者战力加成配置
---@param providerCombatEff2AddTypeConfig table<Constants.AttributeProviderType, table<Constants.BasicAttrAddType, number>>
---@param providerType Constants.AttributeProviderType
---@param addType Constants.BasicAttrAddType
---@param combatValue number
function CardProgressionCombatEffUtils.FillProviderCombatEffAddTypeConf(providerCombatEff2AddTypeConfig, providerType, addType, combatValue)
    providerCombatEff2AddTypeConfig = providerCombatEff2AddTypeConfig or {}
    providerCombatEff2AddTypeConfig[providerType] = providerCombatEff2AddTypeConfig[providerType] or {}
    providerCombatEff2AddTypeConfig[providerType][addType] = combatValue

    return providerCombatEff2AddTypeConfig
end


--endregion

return CardProgressionCombatEffUtils