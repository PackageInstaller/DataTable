local M = BaseClass("OtakuSettleExchangeCtrl", BaseUICtrl)

function M:Init()
    self.heroItems = {}
    self._view.BtnCancel:onClick(Bind(self, self.OnClickCancel))
    self._view.BtnOK:onClick(Bind(self, self.OnClickOK))
    self._view.Mask:onClick(Bind(self, self.OnClickMask))
end

function M:OnDispose()
    for key, value in pairs(self.heroItems) do
        value:OnDispose()
    end
    self.heroItems = nil
    M.super.OnDispose(self)
end

function M:OnClickMask()
    self:Close()
end

function M:OnClickCancel()
    if self.cancelCallback then
        self.cancelCallback()
    end
    self:Close()
end

function M:OnClickOK()
    if self.okCallback then
        self.okCallback()
    end
    self:Close()
end

function M:OnEnter(curRoom, datas, okCallback, cancelCallback)
    local curRoomName = ConfigHelper.GetLocalString(curRoom)
    local des = ConfigHelper.GetLocalString(5787)
    local content = string.format(des, curRoomName)
    self._view.Text:SetText(content)
    self.datas = datas
    self.okCallback = okCallback
    self.cancelCallback = cancelCallback
    self:UpdateDatas()
end

function M:UpdateDatas()
    local ctrlItemCls = require("UI.Ctrl.Otaku.OtakuSettleExchangeItemCtrl")
    for key, value in pairs(self.datas) do
        local heroItem = self._view.Item:Instantiate()
        heroItem:SetParent(self._view.Content)
        heroItem:SetActive(true)
        local ctrlItem = ctrlItemCls.New(heroItem)
        ctrlItem:UpdataData(value)
        table.insert(self.heroItems, ctrlItem)
    end
end

return M
