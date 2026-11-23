EquipHelper = {}

local ITEM_ICON_FOLDER_PATH = "Assets/_BundleResources/Images/ItemIcons/"
local DRAWING_FOLDER_PATH = "Assets/_BundleResources/Images/ItemIcons_pic/"

local IconPath = function(id)
    return ITEM_ICON_FOLDER_PATH .. "itemicon_" .. id .. ".png"
end

local DrawingPath = function(id)
    return DRAWING_FOLDER_PATH .. "itemicon_pic_" .. id .. ".png"
end

function EquipHelper.SetData(equipItemData, equipData,equipConfig, isClick, scale)


    if scale == nil then
        scale = 1
    end

    if equipItemData == nil then
        equipItemData = {}
    end
    equipItemData.root = true
    equipItemData.itemId = equipData.id
    equipItemData.isClick = isClick
    equipItemData.level = "lv." .. equipData.level
    equipItemData.usingId = equipData.characterId
    equipItemData.scale = Vector3(scale, scale, 1)
    equipItemData.rare = equipConfig.rare
    equipItemData.rareIcon = LuaMgr.GetSprite("ItemRare", "itemRare" .. equipConfig.rare)
    equipItemData.icon = LuaMgr.GetTexture(IconPath(equipConfig.id))
    for i = 1, 6 do
        equipItemData["star" .. i] = i <= equipData.star
    end
    
    return equipItemData
end 