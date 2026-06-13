local StageTabCtrl = BaseClass("StageTabCtrl")
local M = StageTabCtrl

function M:__init(view)
    self._view = view
    self._view.transform:onClick(Bind(self, self._ClickItem))
end

function M:_ClickItem(go)
    -- if self._data.stage > self._data.curStage then
    --     GameHelper.Tips(ConfigHelper.GetLocalString(943))
    -- else
    if self._data.isSelect then
        return 
    end
    
    EventMgr:Broadcast(UIMessageNames.FAVOR_SELECT_STAGE, self._data.stage)
    -- end
end

function M:UpdateItem(data)
    if data == nil then
        return 
    end
    
    self._data = data
    self._view.Text1:SetText(string.format("%02d", self._data.stage))
    self._view.Text2:SetText(string.format("%02d", self._data.stage))
    self._view.Text3:SetText(string.format("%02d", self._data.stage))
    --锁定状态
    if self._data.stage > self._data.curStage then
        self._view.uiState:SetState(data.isSelect and 4 or 3)
    else
        self._view.uiState:SetState(data.isSelect and 2 or 1)
    end
end

function M:Enable(value)
    self._view:SetActive(value)
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
    end
    
    self._view = nil
end

return StageTabCtrl
