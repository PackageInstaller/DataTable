local RouletteItemCtrl = BaseClass("RouletteItemCtrl", UIBaseComponent)
local M = RouletteItemCtrl

function M:__init(view)
    self._view = view
    self._view.transform:onClick(Bind(self, self._ClickCommand))
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
end

--指挥官指令
function M:_ClickCommand(go)
    self.dormAction:RoleCommand(self._data.type)
end

function M:UpdateItem(data)
    if data == nil then
        return
    end

    self._data = data
    self._view.Icon:SetPic(data.icon)
    self._view.Text:SetText(data.text)
    self:StateHandle()
end

function M:StateHandle()
    if self:IsReaturn() then
        self._view.Icon:SetColor(115, 97, 255, 255)
        self._view.Text:SetColor(115, 97, 255, 255)
        return
    end

    self._view.Icon:SetColor(51, 51, 51, 255)
    self._view.Text:SetColor(51, 51, 51, 255)
end

function M:IsReaturn()
    if self._data.type == 3 and DormHelper.GetCurrentWatchPointFurnitureName() == "Sofa" then
        return true
    end

    if self._data.type == 4 and DormHelper.GetCurrentWatchPointFurnitureName() == "Bed" then
        return true
    end

    if self._data.type == 5 and DormHelper.GetCurrentWatchPointFurnitureName() == "Console" then
        return true
    end

    return false
end

return RouletteItemCtrl
