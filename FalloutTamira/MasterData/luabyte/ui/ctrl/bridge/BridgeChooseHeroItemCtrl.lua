local M = BaseClass("BridgeChooseHeroItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:__init()
    self._view.heroHead:onClick(Bind(self, self._OnClickItem))
end

function M:UpdateItem(data)
    if data == nil then return end

    self._data = data
    self._view.heroHead.select = self._data.IsChoose
    self._view.heroHead:SetOn(self._data.IsEquipped)
    self._view.addLvNode:SetActive(self._data.AddLevel > 0)
    self._view.addLevel:SetText("LV+" .. self._data.AddLevel)
    self._view.heroHead:SetHeroId(self._data.HeroData:GetHeroId())
end

function M:Dispose()
    self._selectCallback = nil
    self._view.heroHead:onClick(nil)
    M.super.Dispose(self)
end

function M:SetSelectCallback(callback)
    self._selectCallback = callback
end

function M:_OnClickItem(go)
    self._data.IsChoose = not self._data.IsChoose
    self._view.heroHead.select = self._data.IsChoose

    if self._selectCallback then
        self._selectCallback(self._data)
    end
end

return M
