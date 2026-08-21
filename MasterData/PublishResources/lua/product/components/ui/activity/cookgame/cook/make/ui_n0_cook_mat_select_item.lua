_class("UIN0CookMatSelectItem", UICustomWidget)
UIN0CookMatSelectItem = UIN0CookMatSelectItem

function UIN0CookMatSelectItem:OnShow(uiParams)
  self:InitWidget()
end

function UIN0CookMatSelectItem:InitWidget()
  self.matNameTxt = self:GetUIComponent("UILocalizationText", "matNameTxt")
  self.matNumTxt = self:GetUIComponent("UILocalizationText", "matNumTxt")
  self.iconLoader = self:GetUIComponent("RawImageLoader", "icon")
  self.iconTrans = self:GetUIComponent("RectTransform", "icon")
  self.iconGo = self:GetGameObject("icon")
  self.subNumBtn = self:GetGameObject("subNumBtn")
  self.addNumBtn = self:GetGameObject("addNumBtn")
  self.animation = self:GetUIComponent("Animation", "animation")
end

function UIN0CookMatSelectItem:AddNumBtnOnClick()
  if self.selectMatFun() == self.matLimit then
    ToastManager.ShowToast(StringTable.Get("str_n0_cook_mat_limit"))
    return
  end
  if self.remainMatFun() == 0 then
    ToastManager.ShowToast(StringTable.Get("str_n0_cook_mat_empty"))
    return
  end
  self.curMatCount = self.curMatCount + 1
  self:RefreshSelectText()
  if self.onChangeFun then
    self.onChangeFun(self.curMatCount)
  end
end

function UIN0CookMatSelectItem:SubNumBtnOnClick()
  if self.curMatCount == 0 then
    return
  end
  self.curMatCount = self.curMatCount - 1
  self:RefreshSelectText()
  if self.onChangeFun then
    self.onChangeFun(self.curMatCount)
  end
end

function UIN0CookMatSelectItem:RefreshSelectText()
  if self.curMatCount > 0 then
    self.matNumTxt:SetText("x" .. self.curMatCount)
    self.subNumBtn:SetActive(true)
  else
    self.matNumTxt:SetText("")
    self.subNumBtn:SetActive(false)
  end
end

function UIN0CookMatSelectItem:SetData(data, matLimit, selectMatFun, remainMatFun, onChangeFun)
  self.curMatCount = 0
  self.matLimit = matLimit
  self.selectMatFun = selectMatFun
  self.remainMatFun = remainMatFun
  self.onChangeFun = onChangeFun
  self:RefreshSelectText()
  local cfg = Cfg.cfg_dinner_food_material[data.id]
  if cfg then
    self.iconLoader:LoadImage(cfg.Icon)
  end
end

function UIN0CookMatSelectItem:SetAsEmpty()
  self.iconGo:SetActive(false)
  self.matNumTxt:SetText("")
  self.subNumBtn:SetActive(false)
  self.addNumBtn:SetActive(false)
end

function UIN0CookMatSelectItem:GetIconTrans()
  return self.iconTrans
end

function UIN0CookMatSelectItem:GetMatCount()
  return self.curMatCount or 0
end

function UIN0CookMatSelectItem:PlayEnterAni()
  self:SetVisible(true)
  self.animation:Play()
end

function UIN0CookMatSelectItem:SetVisible(visible)
  self:GetGameObject():SetActive(visible)
end
