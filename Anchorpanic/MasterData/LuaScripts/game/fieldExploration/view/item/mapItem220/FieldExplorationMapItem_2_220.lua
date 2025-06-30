-- @FileName:   FieldExplorationMapItem_2_220.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-08-23 15:14:54
-- @Copyright:   (LY) 2023 雷焰网络

module("game.fieldExploration.view.FieldExplorationMapItem_2_220", Class.impl(fieldExploration.FieldExplorationMapItem_220))

UIRes = UrlManager:getUIPrefabPath("fieldExploration/item/FieldExplorationMap_2_220.prefab")

function getDupItemClass(self)
    return fieldExploration.FieldExplorationDupItem_220, "FieldExplorationDupItem_220_2"
end

return _M
