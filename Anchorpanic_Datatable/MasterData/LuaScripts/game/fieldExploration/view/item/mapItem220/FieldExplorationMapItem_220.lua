-- @FileName:   FieldExplorationMapItem_220.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-08-23 15:14:54
-- @Copyright:   (LY) 2023 雷焰网络

module("game.fieldExploration.view.FieldExplorationMapItem_220", Class.impl(fieldExploration.FieldExplorationMapItem))

function setData(self, cusParent, mapItemPrefab, mapConfig)
    self:setParentTrans(cusParent)
    self.mMapConfigVo = mapConfig
    if mapItemPrefab == nil or gs.GoUtil.IsGoNull(mapItemPrefab) then
        mapItemPrefab = self:getChildGO("mItem")
    end

    local select_id = 0

    self.mDupList = {}
    for i = 1, #self.mMapConfigVo.stage_list do
        local dup_id = self.mMapConfigVo.stage_list[i]
        local lastDup_id = 0

        local parent = self:getChildTrans(string.format("pos (%s)", i))

        local start_anchoredPosition, end_anchoredPosition = nil, nil
        if i > 1 then
            lastDup_id = self.mMapConfigVo.stage_list[i - 1]

            local rect = parent:GetComponent(ty.RectTransform)
            end_anchoredPosition = rect.anchoredPosition

            local last_parent = self:getChildTrans(string.format("pos (%s)", i - 1))
            local last_rect = last_parent:GetComponent(ty.RectTransform)
            start_anchoredPosition = last_rect.anchoredPosition
        end

        local class, poolName = self:getDupItemClass()
        local dupItem = class:create(mapItemPrefab, parent, poolName)
        dupItem:setData(dup_id, lastDup_id, start_anchoredPosition, end_anchoredPosition, self:getChildTrans("mLineGroup"))

        self.mDupList[i] = dupItem

        if select_id == 0 then
            if not dupItem.isLock then
                local score = fieldExploration.FieldExplorationManager:getPlayerDupRecord(dup_id)
                if score <= 0 then
                    select_id = dup_id
                end
            end
        end

        dupItem:unSelect()
    end
end

function onOpenDunPanel(self, dup_id)
    GameDispatcher:dispatchEvent(EventName.OPEN_FIELDEXPLORATIONDUPPANEL, {dup_id = dup_id})
end

return _M
