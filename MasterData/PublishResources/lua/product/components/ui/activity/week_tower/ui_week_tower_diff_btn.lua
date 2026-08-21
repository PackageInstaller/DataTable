_class("UIWeekTowerDiffBtn", UICustomWidget)
UIWeekTowerDiffBtn = UIWeekTowerDiffBtn

function UIWeekTowerDiffBtn:OnShow(uiParams)
  self:AttachEvent(GameEventType.OnUIWeekTowerDiffItemClick, self.OnUIWeekTowerDiffItemClick)
end

function UIWeekTowerDiffBtn:OnUIWeekTowerDiffItemClick(idx)
  self:Select(idx)
end

function UIWeekTowerDiffBtn:GetComponents()
  self._select = self:GetGameObject("select")
  self._lock = self:GetGameObject("lock")
  self._name = self:GetUIComponent("UILocalizedTMP", "name")
  self._atlas = self:GetAsset("UIWeekTower.spriteatlas", LoadType.SpriteAtlas)
  self._btnImg = self:GetUIComponent("Image", "btn")
end

function UIWeekTowerDiffBtn:Select(idx)
  local sprite
  if idx == self._index then
    sprite = self._atlas:GetSprite(self._data:Sprites()[1])
  else
    sprite = self._atlas:GetSprite(self._data:Sprites()[2])
  end
  self._btnImg.sprite = sprite
end

function UIWeekTowerDiffBtn:SetTextMat()
  self:SetFontMat(self._name, "uieff_week_tower_diff_btn_tex.mat")
end

function UIWeekTowerDiffBtn:OnHide()
  if self._res then
    self._res:Dispose()
    self._res = nil
  end
end

function UIWeekTowerDiffBtn:SetFontMat(lable, resname)
  self._res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  if not self._res then
    return
  end
  local obj = self._res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIWeekTowerDiffBtn:Lock()
  self._lock:SetActive(self._data:Lock())
  if self._data:Lock() then
    local sprite = self._data:Sprites()[3]
    self._btnImg.sprite = self._atlas:GetSprite(sprite)
  end
end

function UIWeekTowerDiffBtn:SetData(index, data, curridx, callback)
  self:GetComponents()
  self._index = index
  self._data = data
  self._callback = callback
  local name = self._data:Name()
  local upColor = self._data:UpColor()
  self._name:SetText(name)
  local vg = self._name.enableVertexGradient
  self:SetTextMat()
  self:Select(curridx)
  self:Lock()
end

function UIWeekTowerDiffBtn:btnOnClick(go)
  if not self._data:Lock() then
    if self._callback then
      self._callback(self._index)
    end
  else
    ToastManager.ShowToast(StringTable.Get("str_week_tower_diff_lock_tips"))
  end
end
