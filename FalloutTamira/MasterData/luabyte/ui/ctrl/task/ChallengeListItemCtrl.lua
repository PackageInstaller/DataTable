local ChallengeListItemCtrl = BaseClass("ChallengeListItemCtrl")
local M = ChallengeListItemCtrl

function M:__init(view)
    self._view = view

    self._data = nil
    self._view.rectClickArea:onClick(Bind(self, self.OnChallengeClick))
end

function M:OnDispose()
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
    self._view.rectDoing:SetActive(data.state == TaskConst.TaskState.Doing)
    self._view.rectMissionComplete:SetActive(data.state == TaskConst.TaskState.MissionComplete)
    self._view.rectTaskComplete:SetActive(data.state == TaskConst.TaskState.TaskComplete)

    local itemGroupCfg = ConfigHelper.GetCfg("itemGroup", data.reward)
    self._view.item:SetInfo(itemGroupCfg.items[1], ItemNumberType.TOTLE, itemGroupCfg.cnts[1])
    self._view.item:EnablePopItem(true)
end

function M:OnChallengeClick()
    if self._data.state == TaskConst.TaskState.Doing then
        GameHelper.Jump(self._data.jumpId)
    elseif self._data.state == TaskConst.TaskState.MissionComplete then
        TaskDataMgr:RequestCompleteTask(self._data.id)
    end
end

return ChallengeListItemCtrl
