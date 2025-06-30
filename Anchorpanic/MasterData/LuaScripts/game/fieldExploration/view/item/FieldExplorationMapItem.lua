-- @FileName:   FieldExplorationMapItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-08-23 15:14:54
-- @Copyright:   (LY) 2023 雷焰网络

module("game.fieldExploration.view.FieldExplorationMapItem", Class.impl(BaseReuseItem))

UIRes = ""

function setData(self, cusParent, mapItemPrefab, mapConfig)
    self:setParentTrans(cusParent)
    self.mMapConfigVo = mapConfig

    local select_id = 0

    self.mDupList = {}
    for i = 1, #self.mMapConfigVo.stage_list do
        local dup_id = self.mMapConfigVo.stage_list[i]
        local lastDup_id = 0
        if i > 1 then
            lastDup_id = self.mMapConfigVo.stage_list[i - 1]
        end

        local parent = self:getChildTrans(string.format("pos (%s)", i))
        local class, poolName = self:getDupItemClass()
        local dupItem = class:create(mapItemPrefab, parent, poolName)
        dupItem:setData(dup_id, lastDup_id)

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

    -- if select_id == 0 then
    --     select_id = self.mMapConfigVo.stage_list[#self.mMapConfigVo.stage_list]
    -- end
    -- self:onDupItemSelect(select_id)
end

function configUI(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.SELECT_FIELDEXPLORATION_DUP, self.onDupItemSelect, self)
    GameDispatcher:addEventListener(EventName.ONCLOSE_FIELDEXPLORATIONDUPPANEL, self.onCloseDupInfoPanel, self)
end

function getDupItemClass(self)
    return fieldExploration.FieldExplorationDupItem_213, "FieldExplorationDupItem_213"
end

function onDupItemSelect(self, dup_id)
    for i = 1, #self.mMapConfigVo.stage_list do
        local dupItem = self.mDupList[i]
        if dupItem then
            if self.mMapConfigVo.stage_list[i] == dup_id then
                dupItem:select()
            else
                dupItem:unSelect()
            end
        end
    end

    self:onOpenDunPanel(dup_id)
end

function onOpenDunPanel(self, dup_id)
    GameDispatcher:dispatchEvent(EventName.OPEN_FIELDEXPLORATIONDUPPANEL, {dup_id = dup_id, isShowStar = true, isShowRecord = true})
end

function onCloseDupInfoPanel(self)
    for _, item in pairs(self.mDupList) do
        item:unSelect()
    end
end

function deActive(self)
    super.deActive(self)

    for _, dupItem in pairs(self.mDupList) do
        dupItem:poolRecover()
    end
    self.mDupList = {}

    GameDispatcher:removeEventListener(EventName.SELECT_FIELDEXPLORATION_DUP, self.onDupItemSelect, self)
    GameDispatcher:removeEventListener(EventName.ONCLOSE_FIELDEXPLORATIONDUPPANEL, self.onCloseDupInfoPanel, self)
end

return _M
