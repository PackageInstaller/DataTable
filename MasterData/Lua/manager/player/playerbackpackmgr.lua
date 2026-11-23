




PlayerBackpackMgr = {}
PlayerBackpackMgr.itemData = nil
PlayerBackpackMgr.equipData = nil
PlayerBackpackMgr.friendData = nil


PlayerBackpackMgr.equipJob = 0
PlayerBackpackMgr.rareOptions = {}
PlayerBackpackMgr.seriesOptions = {}
PlayerBackpackMgr.attrOptions = {}
PlayerBackpackMgr.includeOptions = 1
PlayerBackpackMgr.excludeOptions = 0
PlayerBackpackMgr.equipPositioningId = nil

local TableSort = table.sort
local TableInsert = table.insert

function PlayerBackpackMgr.Init()

    if TableIsNull(PlayerBackpackMgr.itemData) then
        PlayerBackpackMgr.itemData = {}
        PlayerBackpackMgr.InitGoodTypeLabel()
    end
    PlayerBackpackMgr.UpdateGoods()
    

    if TableIsNull(PlayerBackpackMgr.equipData) then
        PlayerBackpackMgr.equipData = {}
    end
    if TableIsNull(PlayerBackpackMgr.rareOptions) and TableIsNull(PlayerBackpackMgr.seriesOptions) and TableIsNull(PlayerBackpackMgr.attrOptions) and 
            PlayerBackpackMgr.equipJob == CharacterJob.All then
        PlayerBackpackMgr.UpdateEquip()
    else
        PlayerBackpackMgr.UpdateSiftEquip(true)
    end
end


function PlayerBackpackMgr.UpdateGoods()
    local config = nil
    local tempData = nil
    for key, value in pairs(DataMgr.Player.items) do
        if value.counts ~= nil or value.count0 > 0 then
            config = ConfigMgr.Config.itemMap[key]
            if not TableIsNull(config) and not IsNullOrEmpty(config.BackPackTab) then
                if PlayerBackpackMgr.itemData[config.BackPackTab] ~= nil then
                    value.rare = config.rare
                    if value.counts == nil then
                        TableInsert(PlayerBackpackMgr.itemData[config.BackPackTab],value)
                    else
                        for i = 1, #value.counts do
                            tempData = {id = value.id,rare = value.rare,counts = {value.counts[i]}}
                            TableInsert(PlayerBackpackMgr.itemData[config.BackPackTab],tempData)
                        end
                    end
                end
            end
        end
    end
    for key, value in pairs(PlayerBackpackMgr.itemData) do
        TableSort(value,PlayerBackpackMgr.ItemDataSort)
    end
end


function PlayerBackpackMgr.UpdateEquip()
    PlayerBackpackMgr.equipData = {}
    local config = nil
    for key, value in pairs(DataMgr.Player.equipments) do
        config = ConfigMgr.Config.equipments[value.equipmentId]
        if not TableIsNull(config) then
            value.rare = config.rare
            value.wearBool = value.characterId ~= ""
            value.choose = false
            TableInsert(PlayerBackpackMgr.equipData,value)
        end
    end
    TableSort(PlayerBackpackMgr.equipData,PlayerBackpackMgr.EquipDataSort)
end


function PlayerBackpackMgr.UpdateSiftEquip(isSort)
    PlayerBackpackMgr.equipData = {}
    local config = nil
    local attrBool = false
    local jobBool = false
local attrNum = 0
    local equipAttrLength = 0
    local attrOptionsLength = ConfigHelper.GetTableLength(PlayerBackpackMgr.attrOptions)
    for key, value in pairs(DataMgr.Player.equipments) do
        config = ConfigMgr.Config.equipments[value.equipmentId]
        if not TableIsNull(config) then
            jobBool = (PlayerBackpackMgr.equipJob == 0) or config.job == PlayerBackpackMgr.equipJob
            if not jobBool then goto continue end
            if TableIsNull(PlayerBackpackMgr.rareOptions) or PlayerBackpackMgr.rareOptions[config.rare] ~= nil then
                if TableIsNull(PlayerBackpackMgr.seriesOptions) or PlayerBackpackMgr.seriesOptions[config.Series] ~= nil then
                    if not TableIsNull(PlayerBackpackMgr.attrOptions) then
                        equipAttrLength = ConfigHelper.GetTableLength(value.additionalAttrs)
                        if equipAttrLength < attrOptionsLength and PlayerBackpackMgr.includeOptions == 1 then
                            goto continue
                        end
                        attrNum = 0
                        for i = 1, equipAttrLength do
                            attrBool = PlayerBackpackMgr.attrOptions[value.additionalAttrs[i].id] ~= nil
                            if attrBool then attrNum = attrNum + 1 end
                        end
                        if attrNum < attrOptionsLength and PlayerBackpackMgr.includeOptions == 1 then
                            goto continue
                        elseif attrNum >= attrOptionsLength and PlayerBackpackMgr.excludeOptions == 1 then
                            goto continue
                        end
                    end
                    value.rare = config.rare
                    value.wearBool = value.characterId ~= ""
                    value.choose = false
                    TableInsert(PlayerBackpackMgr.equipData,value)
                end
            end
        end
        ::continue::
    end
    if isSort ~= nil and isSort then
        TableSort(PlayerBackpackMgr.equipData,PlayerBackpackMgr.EquipDataSort)
    end
end


function PlayerBackpackMgr.RestoreEquip()
    if not TableIsNull(PlayerBackpackMgr.equipData) then
        for i = 1, #PlayerBackpackMgr.equipData do
            PlayerBackpackMgr.equipData[i].choose = false
        end
    end
end


function PlayerBackpackMgr.GetTotalCount()
    local totalCount = 0
    for key,value in pairs(PlayerBackpackMgr.itemData) do
        totalCount = totalCount + #value
    end
    if PlayerBackpackMgr.equipData ~= nil then
        totalCount = totalCount + NumTool.GetLen(DataMgr.Player.equipments)
    end
    return totalCount
end

function PlayerBackpackMgr.Clear()
    PlayerBackpackMgr.ClearGoods()
    PlayerBackpackMgr.ClearEquip()
end

function PlayerBackpackMgr.ClearGoods()
    if not TableIsNull(PlayerBackpackMgr.itemData) then
        for key,value in pairs(PlayerBackpackMgr.itemData) do
            PlayerBackpackMgr.itemData[key] = {}
        end
    end
end

function PlayerBackpackMgr.ClearEquip()
    PlayerBackpackMgr.equipData = nil
end


function PlayerBackpackMgr.ResetSift()
    PlayerBackpackMgr.equipJob = 0
    PlayerBackpackMgr.rareOptions = {}
    PlayerBackpackMgr.seriesOptions = {}
    PlayerBackpackMgr.attrOptions = {}
    PlayerBackpackMgr.includeOptions = 1
    PlayerBackpackMgr.excludeOptions = 0
end

function PlayerBackpackMgr.InitGoodTypeLabel()
    local type = nil
    for i = 1, #ConfigMgr.Config.constants.BackPackTab do
        type = ConfigMgr.Config.constants.BackPackTab[i]
        if PlayerBackpackMgr.itemData[type] == nil then
            PlayerBackpackMgr.itemData[type] = {}
        end
    end
end

function PlayerBackpackMgr.ItemDataSort(item1,item2)
    if item1.rare == item2.rare then
        if item1.id ~= item2.id then
            return item1.id < item2.id
        else
            return false
        end
    else
        return item1.rare > item2.rare
    end
end

function PlayerBackpackMgr.EquipDataSort(item1,item2)
    if item1.wearBool ~= item2.wearBool then
        return item1.wearBool and not item2.wearBool
    else
        if item1.locking ~= item2.locking then
            return item1.locking and not item2.locking
        else
            if item1.level ~= item2.level then
                return item1.level > item2.level
            else
                if item1.rare ~= item2.rare then
                    return item1.rare > item2.rare
                else
                    if item1.star ~= item2.star then
                        return item1.star > item2.star
                    else
                        if item1.grade ~= item2.grade then
                            return item1.grade > item2.grade
                        else
                            return item1.equipmentId < item2.equipmentId
                        end
                    end
                end
            end
        end
    end
end

function PlayerBackpackMgr.EquipDataLitreSort(item1,item2)
    if item1.rare ~= item2.rare then
        return item1.rare < item2.rare
    else
        if item1.level ~= item2.level then
            return item1.level < item2.level
        else
            return item1.equipmentId < item2.equipmentId
        end
    end
end