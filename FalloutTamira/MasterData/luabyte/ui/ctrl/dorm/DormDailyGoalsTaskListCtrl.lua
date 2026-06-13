local ItemCtrl = require("UI.Ctrl.Dorm.DormDailyGoalsTaskItemCtrl")
local DormDailyGoalsTaskListCtrl = BaseClass("DormDailyGoalsTaskListCtrl")
local M = DormDailyGoalsTaskListCtrl



function M:Refresh(data, roleData, isUnLock)
    self:_RecoveryObject()
    self:_SortData(data, roleData)

    if #data > #self._curItemList then
        local count = #data - #self._curItemList
        self:_CreateObject(count)
    end

    for i, v in ipairs(data) do
        local d = self:_GetRoleData(v, roleData)
        self._curItemList[i]:Update(v, d, isUnLock)
    end

    local hegiht = 172 * #data - 12
    self._view.parent:SetRectSizeDeltaY(hegiht)
end

function M:_CreateObject(count)
    for i = 1, count do
        local obj = self._view.item:Instantiate()
        obj:SetParent(self._view.parent)
        local ctrl = ItemCtrl.New(obj)
        table.insert(self._curItemList, ctrl)
    end
end

function M:_RecoveryObject()
    for i, v in ipairs(self._curItemList) do
        v:OnRecovery()
    end
end

function M:_GetRoleData(data, roleData)
    local d = MapUtil.Find(roleData or {}, function(v) return v.SubActivityId == data.id and data.target ~= 1 end)
    return d or { State = 0 }
end

function M:_SortData(data, roleData)
    table.sort(data, function(v1, v2)
        local s1 = self:_GetRoleData(v1, roleData)
        local s2 = self:_GetRoleData(v2, roleData)
        s1 = s1.State
        s2 = s2.State

        if s1 == s2 then
            return v1.id < v2.id
        end

        if s1 ~= 1 and s2 ~= 1 then
            return s1 < s2
        end

        if s1 == 1 or s2 == 1 then
            return s1 == 1
        end

        return s1 < s2
    end)
end

function M:__init(view)
    self._view = view
    self._curItemList = {}
end

function M:OnDispose()
    for _, v in pairs(self._curItemList) do
        v:OnRecovery()
        v:OnDispose()
    end

    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
    self._curItemList = nil
end

return DormDailyGoalsTaskListCtrl
