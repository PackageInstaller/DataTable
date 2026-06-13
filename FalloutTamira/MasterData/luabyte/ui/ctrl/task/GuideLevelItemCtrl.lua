local GuideLevelItemCtrl = BaseClass("GuideLevelItemCtrl")
local M = GuideLevelItemCtrl

function M:__init(view)
    self._view = view
    self._view.rectLevelItem:onClick(Bind(self, self.OnLevelClick))
end

function M:OnDispose()
    self._data = nil
    if self._view then self._view:OnDispose() end
    self._view = nil
end

function M:OnLevelClick()
    if self._data.uiState == TaskConst.TaskUIState.Lock_PreTaskNotComplete then
        GameHelper.TipsById(825)
        return
    elseif self._data.uiState == TaskConst.TaskUIState.Lock_Level then
        local tipsFormat = ConfigHelper.GetLocalString(826)
        GameHelper.Tips(string.format(tipsFormat, self._data.level))
        return
    end

    EventMgr:Broadcast(UIMessageNames.TASK_TYPE_LEVEL_CHANGE, self._data)
end

function M:UpdateItem(data)
    if data == nil then
        return
    end
    self._data = data
    self._view.rectLevelItem.localEulerAngles = Vector3.zero

    self._view.txtLevelValue:SetText(tostring(data.level))
    self._view.rectLock:SetActive(data.uiState == TaskConst.TaskUIState.Lock_PreTaskNotComplete or
        data.uiState == TaskConst.TaskUIState.Lock_Level)
    self._view.rectUnlocked:SetActive(data.uiState == TaskConst.TaskUIState.Unlock)
    self._view.rectComplete:SetActive(data.uiState == TaskConst.TaskUIState.Complete)
    self._view.rectSelect:SetActive(data.select)

    if data.select then
        --self._view.txtLevel:SetColorNew(TaskConst.TaskColor.Blue)
        --self._view.txtLevelValue:SetColorNew(TaskConst.TaskColor.Blue)
    else
        --self._view.txtLevel:SetColorNew(TaskConst.TaskColor.White)
        --self._view.txtLevelValue:SetColorNew(TaskConst.TaskColor.White)
    end

end

return GuideLevelItemCtrl
