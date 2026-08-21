_class("UIN25IdolActItem", UICustomWidget)
UIN25IdolActItem = UIN25IdolActItem

function UIN25IdolActItem:Constructor()
  self.type2sprite = {
    [1] = "n25_oxyc_oxhd_di01",
    [2] = "n25_oxyc_oxhd_di05",
    [3] = "n25_oxyc_oxhd_di03",
    [4] = "n25_oxyc_oxhd_di06",
    [5] = "n25_oxyc_oxhd_di02",
    [6] = "n25_oxyc_oxhd_di04"
  }
end

function UIN25IdolActItem:OnShow(uiParams)
  self:GetComponents()
end

function UIN25IdolActItem:SetData(component, cfg, status, callback)
  self._component = component
  self.cfg = cfg
  self.status = status
  self.callback = callback
  self:OnValue()
end

function UIN25IdolActItem:OnHide()
end

function UIN25IdolActItem:GetComponents()
  self.nameTex = self:GetUIComponent("UILocalizationText", "txtName")
  self.fansValue = self:GetUIComponent("UILocalizationText", "fansValue")
  self.gotoGo = self:GetGameObject("go")
  self.notGo = self:GetGameObject("not")
  self.grayGo = self:GetGameObject("gray")
  self.limitPool = self:GetUIComponent("UISelectObjectPath", "layout")
  self.icon = self:GetUIComponent("Image", "imgIcon")
  self.atlas = self:GetAsset("UIN25Idol.spriteatlas", LoadType.SpriteAtlas)
end

function UIN25IdolActItem:OnValue()
  local nameStr = StringTable.Get(self.cfg.Title) or ""
  self.nameTex:SetText(nameStr)
  local fans = self.cfg.Fans or 0
  self.fansValue:SetText(fans)
  local sprite = self.type2sprite[self.cfg.ActType]
  self.icon.sprite = self.atlas:GetSprite(sprite)
  self:Limit()
  self:BtnState()
end

function UIN25IdolActItem:BtnState()
  self.gotoGo:SetActive(self.status == UIIdolStatus.GoTo)
  self.notGo:SetActive(self.status == UIIdolStatus.Not)
  self.grayGo:SetActive(self.status == UIIdolStatus.Finish)
end

function UIN25IdolActItem:Limit()
  local len = 3
  self.limitPool:SpawnObjects("UIN25IdolCommonTrainPoint", len)
  local pools = self.limitPool:GetAllSpawnList()
  for trainType = IdolTrainType.IdolTrainType_Music, IdolTrainType.IdolTrainType_Perform do
    local limitValue = self._component:UI_GetActLimit(self.cfg, trainType)
    local limitEnable = self._component:UI_CheckActLimit(self.cfg, trainType)
    local uiType = limitEnable and 1 or 0
    pools[trainType]:SetData(uiType, trainType, limitValue)
  end
end

function UIN25IdolActItem:GoToOnClick(go)
  if self.callback then
    self.callback(self.cfg.ActId, self.status)
  end
end

function UIN25IdolActItem:NotOnClick(go)
  local tips = StringTable.Get("str_n25_idol_y_act_not_toast")
  ToastManager.ShowToast(tips)
end
