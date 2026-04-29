_class("UIActivityCommonTips", UICustomWidget)
UIActivityCommonTips = UIActivityCommonTips

function UIActivityCommonTips:OnShow()
  self._hideBtn = self:GetGameObject("_hideBtn")
end

function UIActivityCommonTips:SetData(className, prefabName, pos, argsTable)
  self._hideBtn:SetActive(true)
  local tipsPool = self:GetGameObject("_tipsPool").transform
  tipsPool.anchoredPosition = Vector2(10000, 0)
  tipsPool.localScale = Vector3(1, 1, 1)
  tipsPool.position = pos
  self._tips = UIWidgetHelper.SpawnObject(self, "_tipsPool", className, prefabName)
  self._tips:SetData(table.unpack(argsTable))
  self._tips:GetGameObject():SetActive(true)
end

function UIActivityCommonTips:HideBtnOnClick(go)
  self._hideBtn:SetActive(false)
  self._tips:GetGameObject():SetActive(false)
  if self._tips.HideBtnOnClick then
    self._tips:HideBtnOnClick(go)
  end
end
