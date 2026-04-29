_class("UISeasonMazeTopIconItem", UICustomWidget)
UISeasonMazeTopIconItem = UISeasonMazeTopIconItem

function UISeasonMazeTopIconItem:InitWidget()
  self._lvTex = self:GetUIComponent("UILocalizationText", "LvTex")
  self._rateVal = self:GetUIComponent("Image", "RateVal")
  self._rateTex = self:GetUIComponent("UILocalizationText", "rateTex")
  self._lvGo = self:GetGameObject("Lv")
  self._moneyGo = self:GetGameObject("Money")
  self._moneyIconImg = self:GetUIComponent("Image", "MoneyIcon")
  self._moneyNumberTex = self:GetUIComponent("UILocalizationText", "MoneyNumber")
  self._msGo = self:GetGameObject("Ms")
  self._msIconImg = self:GetUIComponent("Image", "MsIcon")
  self._msNumberTex = self:GetUIComponent("UILocalizationText", "MsNumber")
  self._addMoneyTex = self:GetUIComponent("UILocalizationText", "AddMoneyTex")
  self._moneyAddGo = self:GetGameObject("MoneyAddGo")
end

function UISeasonMazeTopIconItem:OnShow()
  self:InitWidget()
end

function UISeasonMazeTopIconItem:OnSeasonMazeExpChange(attType)
  if attType == SeasonMazeAttrType.SMAT_Exp or attType == SeasonMazeAttrType.SMAT_Lv then
    if self._type == SeasonMazeTopIconType.Lv then
      self:SetLv()
    end
  elseif attType == SeasonMazeAttrType.SMAT_Gold or attType == SeasonMazeAttrType.SMAT_Gold_Round_Add then
    if self._type == SeasonMazeTopIconType.Money or self._type == SeasonMazeTopIconType.MoneyAdd then
      self:SetMoney()
    end
  elseif attType == SeasonMazeAttrType.SMAT_Ms and self._type == SeasonMazeTopIconType.Ms then
    self:SetMs()
  end
end

function UISeasonMazeTopIconItem:SetData(type, sp, callback, seasonObj)
  self._type = type
  self._callback = callback
  self._sp = sp
  self._seasonObj = seasonObj
  self._com = self._seasonObj:GetMazeComponent()
  self._comCfgID = self._com:GetComponentCfgId()
  self._comInfo = self._com:GetComponentInfo()
  self:SetLv()
  self:SetMoney()
  self:SetMs()
end

function UISeasonMazeTopIconItem:GetLvCfg(lv)
  local cfgs = Cfg.cfg_component_season_maze_lv({
    ComponentID = self._comCfgID,
    Lv = lv
  })
  if cfgs and next(cfgs) then
    return cfgs[1]
  end
end

function UISeasonMazeTopIconItem:GetMaxLv()
  local cfgs = Cfg.cfg_component_season_maze_lv({
    ComponentID = self._comCfgID
  })
  return table.count(cfgs)
end

function UISeasonMazeTopIconItem:SetLv()
  self._lvGo:SetActive(self._type == SeasonMazeTopIconType.Lv)
  if self._type == SeasonMazeTopIconType.Lv then
    local lvMax = false
    self._currentLv = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Lv)
    local currentExp = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Exp)
    local maxLv = self:GetMaxLv()
    if maxLv <= self._currentLv then
      lvMax = true
    end
    local cfg = self:GetLvCfg(self._currentLv)
    local nextExp = cfg.Exp
    local rate, rateTex
    if lvMax then
      rate = 1
      rateTex = "MAX"
    else
      rate = currentExp / nextExp
      local rateInt = math.floor(rate * 100)
      rateTex = currentExp .. "/" .. nextExp
    end
    self._lvTex:SetText("LV." .. self._currentLv)
    self._rateVal.fillAmount = rate
    self._rateTex:SetText(rateTex)
  end
end

function UISeasonMazeTopIconItem:SetMoney()
  self._moneyGo:SetActive(self._type == SeasonMazeTopIconType.Money or self._type == SeasonMazeTopIconType.MoneyAdd)
  if self._type == SeasonMazeTopIconType.Money or self._type == SeasonMazeTopIconType.MoneyAdd then
    local num = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold)
    self._moneyNumberTex:SetText(num)
  end
  self._moneyAddGo:SetActive(self._type == SeasonMazeTopIconType.MoneyAdd)
  if self._type == SeasonMazeTopIconType.MoneyAdd then
    local addTex
    local add = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Gold_Round_Add)
    if add < 0 then
      addTex = "<color=#f15454>" .. add .. "</color>"
    elseif add == 0 then
      addTex = "<color=#ffffff>+" .. add .. "</color>"
    else
      addTex = "<color=#45c97f>+" .. add .. "</color>"
    end
    self._addMoneyTex:SetText(addTex)
  end
end

function UISeasonMazeTopIconItem:SetMs()
  self._msGo:SetActive(self._type == SeasonMazeTopIconType.Ms)
  if self._type == SeasonMazeTopIconType.Ms then
    local ms = self._com:GetAttrValue(SeasonMazeAttrType.SMAT_Ms)
    self._msNumberTex:SetText(ms)
  end
end

function UISeasonMazeTopIconItem:OnHide()
end

function UISeasonMazeTopIconItem:MoneyIconOnClick(go)
  if self._callback then
    self._callback(SeasonMazeTopIconType.Money, go)
  end
end

function UISeasonMazeTopIconItem:MsIconOnClick(go)
  if self._callback then
    self._callback(SeasonMazeTopIconType.Ms, go)
  end
end

function UISeasonMazeTopIconItem:AddMoneyIconOnClick(go)
  if self._callback then
    self._callback(SeasonMazeTopIconType.MoneyAdd, go)
  end
end

function UISeasonMazeTopIconItem:LvOnClick(go)
  if self._callback then
    self._callback(self._type, go)
  end
end
