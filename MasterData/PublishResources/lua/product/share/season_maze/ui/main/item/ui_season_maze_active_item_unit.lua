_class("UISeasonMazeActiveItemUnit", UICustomWidget)
UISeasonMazeActiveItemUnit = UISeasonMazeActiveItemUnit

function UISeasonMazeActiveItemUnit:InitWidget()
  self._iconImg = self:GetUIComponent("RawImageLoader", "Icon")
  self._countTex = self:GetUIComponent("UILocalizationText", "Count")
  self._selectGo = self:GetGameObject("Select")
end

function UISeasonMazeActiveItemUnit:OnShow()
  self:InitWidget()
end

function UISeasonMazeActiveItemUnit:SetData(idx, id, count, icon, callback)
  self._idx = idx
  self._id = id
  self._count = count
  self._callback = callback
  self._iconImg:LoadImage(icon)
  self._countTex:SetText(self._count)
end

function UISeasonMazeActiveItemUnit:OnHide()
end

function UISeasonMazeActiveItemUnit:BtnOnClick(go)
  if self._callback then
    self._callback(self._id, self._count, go.transform.position)
  end
end

function UISeasonMazeActiveItemUnit:Select(id)
  self._selectGo:SetActive(id == self._id)
end
