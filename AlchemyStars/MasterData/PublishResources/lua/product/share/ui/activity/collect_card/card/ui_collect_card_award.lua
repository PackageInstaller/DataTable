_class("UICollectCardAward", UICustomWidget)
UICollectCardAward = UICollectCardAward

function UICollectCardAward:OnShow(uiParam)
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._number = self:GetUIComponent("UILocalizationText", "Number")
end

function UICollectCardAward:SetData(id, count, callback)
  self._id = id
  self._callback = callback
  self._count = count
  local cfg = Cfg.cfg_item[self._id]
  local icon = cfg.Icon
  self._icon:LoadImage(icon)
  self._number:SetText("X " .. self._count)
end

function UICollectCardAward:IconOnClick(go)
  if self._callback then
    self._callback(self._id, go.transform.position)
  end
end
