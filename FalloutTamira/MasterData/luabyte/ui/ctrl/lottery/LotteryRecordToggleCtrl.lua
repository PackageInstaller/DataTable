local LotteryRecordToggleCtrl = BaseClass("LotteryRecordToggleCtrl")
local M = LotteryRecordToggleCtrl


function M:__init(view)
    self._view = view
    self._view.btn:onClick (Bind(self,self._OnBtnClick))
end

function M:UpdateItem(data)
    self._selectIndex = data.selectIndex
    self._view.check:SetActive(data.select)
    self._view.checkText:SetText(tostring(data.selectIndex))
    self._view.toggleText:SetText(tostring(data.selectIndex))
end

function M:_OnBtnClick()
    EventMgr:Broadcast(UIMessageNames.LOTTERY_RECORD_CHANGEPAGE, self._selectIndex)
end

function M:SetActive(b)
    self._view:SetActive(b)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return LotteryRecordToggleCtrl
