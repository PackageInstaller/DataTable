local WeeklyListItemCtrl = BaseClass("WeeklyListItemCtrl")
local M = WeeklyListItemCtrl

function M:__init(view)
    self._view = view
    self._data = nil
    local ctrl = require("UI.Ctrl.Task.TaskAwardItemCtrl")
    local view = require("UI.View.Task.TaskAwardItemView")
    self._view.awardScrollView:Init(ctrl, view)
    self._view.rectClickArea:onClick(Bind(self, self.OnStateClick))
end

function M:OnDispose()
    self._view.rectClickArea:onClick(nil)
    self._view.awardScrollView:Dispose()
    self._view.awardScrollView = nil
    self._data = nil
    if self._view then self._view:OnDispose() end
    self._view = nil
end

function M:UpdateItem(data)
    if data == nil then
        return
    end

    self._data = data
    self._view.rectTask.localEulerAngles = Vector3.zero
    self._view.txtDes:SetText(data.des)
    local value1 = data.value0 > data.limitValue1 and data.limitValue1 or data.value0
    self._view.txtPropertion:SetText(value1 .. "/" .. data.limitValue1)
    self._view.imgProgress:SetFillAmount(TaskHelper.GetProgress(data)) -- data.value0/data.value1;

    self._view.rectGoto:SetActive(data.state == TaskConst.TaskState.Doing)
    self._view.rectReceive:SetActive(data.state == TaskConst.TaskState.MissionComplete)
    self._view.rectComplete:SetActive(data.state == TaskConst.TaskState.TaskComplete)

    self:_RefreshAwardItems(data)
end

function M:OnStateClick()
    if self._data.state == TaskConst.TaskState.Doing then
        GameHelper.Jump(self._data.jumpId)
        --UIContextMgr:GetInstance():Close("TaskUI")
    elseif self._data.state == TaskConst.TaskState.MissionComplete then
        TaskDataMgr:RequestCompleteTask(self._data.id)
    end
end

function M:_RefreshAwardItems(data)
    local list = {}
    local itemCfg = ConfigHelper.GetCfgByLua("itemGroup", data.reward)
    if itemCfg == nil then
        Logger.LogError(string.format("[策划同学请查表]itemGroup is null and awardId is %s", data.reward))
        return
    end
    for i = 1, #itemCfg.items do
        local Id = itemCfg.items[i]
        local Num = itemCfg.cnts[i]
        table.insert(list, { Id = Id, Num = Num })
    end
    self._view.awardScrollView:SetDataList(list)
end

return WeeklyListItemCtrl
