local FavorItemCtrl = BaseClass("FavorItemCtrl")
local M = FavorItemCtrl

function M:__init(view)
    self._view = view
    self._view.transform:onClick(Bind(self, self._ClickItem))
end

function M:_ClickItem(go)
    if self._data.isSelect then
        return 
    end
    
    EventMgr:Broadcast(UIMessageNames.FAVOR_SELECT_LEVEL, self._data.feelingLevel)
end

function M:UpdateItem(data)
    if data == nil then
        return 
    end
    
    self._data = data
    self._view.Text1:SetText(self._data.title)
    self._view.Text2:SetText(self._data.title)
    self._view.Text3:SetText(self._data.title)
    self._view.Text4:SetText(self._data.title)
    self._view.ValueBg1.gameObject:SetActive(true)
    self._view.ValueBg2.gameObject:SetActive(true)
    self._view.ValueBg3.gameObject:SetActive(true)
    self._view.ValueBg4.gameObject:SetActive(true)
    self._view.LevelText1:SetText(tostring(self._data.feelingLevel))
    self._view.LevelText2:SetText(tostring(self._data.feelingLevel))
    self._view.LevelText3:SetText(tostring(self._data.feelingLevel))
    self._view.LevelText4:SetText(tostring(self._data.feelingLevel))
    self:SetState(data.isSelect, data.isLock)
end

function M:SetState(isSelect, isLock)
    self._view.Select:SetActive(isSelect and not isLock)
    self._view.Lock:SetActive(not isSelect and isLock)
    self._view.Normal:SetActive(not isSelect and not isLock)
    self._view.SelectLock:SetActive(isSelect and isLock)
end


function M:OnDispose()
    if self._view then
        self._view:OnDispose()
    end
    
    self._view = nil
end

return FavorItemCtrl
