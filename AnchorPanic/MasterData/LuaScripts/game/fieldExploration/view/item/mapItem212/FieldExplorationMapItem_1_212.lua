-- @FileName:   FieldExplorationMapItem_1_212.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-08-23 15:14:54
-- @Copyright:   (LY) 2023 雷焰网络

module("game.fieldExploration.view.FieldExplorationMapItem_1_212", Class.impl(fieldExploration.FieldExplorationMapItem))

UIRes = UrlManager:getUIPrefabPath("fieldExploration/item/FieldExplorationMap_1_212.prefab")

function getDupItemClass(self)
    return fieldExploration.FieldExplorationDupItem_212, "FieldExplorationDupItem_212"
end

return _M
