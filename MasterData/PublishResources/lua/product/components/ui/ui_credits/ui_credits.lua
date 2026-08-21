_class("UICredits", UIController)
UICredits = UICredits

function UICredits:OnShow(uiParam)
  self.tran = self:GetGameObject().transform
  self.txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self.goBtns = self:GetGameObject("btns")
  self.goBtns:SetActive(false)
  local btns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._backBtns = btns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil)
  local credits = Cfg.cfg_credits()
  local len = table.count(credits)
  local pool = self:GetUIComponent("UISelectObjectPath", "vlg")
  pool:SpawnObjects("UICreditsItem", len)
  local items = pool:GetAllSpawnList()
  local txts = {
    self.txtTitle
  }
  for i, cfgv in ipairs(credits) do
    local title = StringTable.Get(cfgv.title)
    local strNames = StringTable.Get(cfgv.names)
    local tName = string.split(strNames, ";")
    local uiCreditsItem = items[i]
    uiCreditsItem.txtTitle:SetText(title)
    local len = table.count(tName)
    if 7 <= len then
      uiCreditsItem.glg.constraintCount = 3
    else
      uiCreditsItem.glg.constraintCount = 1
    end
    uiCreditsItem.pool:SpawnObjects("UICreditsNameItem", len)
    local itemsUICreditsNameItem = uiCreditsItem.pool:GetAllSpawnList()
    for j, uiCreditsNameItem in ipairs(itemsUICreditsNameItem) do
      uiCreditsNameItem.txtName:SetText(tName[j])
      table.insert(txts, uiCreditsNameItem.txtName)
    end
    table.insert(txts, uiCreditsItem.txtTitle)
  end
  self.tranVlg = self:GetUIComponent("RectTransform", "vlg")
  self.tranC = self:GetUIComponent("RectTransform", "c")
  local beginY = -200
  local endY = 28400 + self.tranC.rect.height
  local duration = (endY - beginY) * 0.005
  self.tranVlg.anchoredPosition = Vector2(0, beginY)
  self.tweener = self.tranVlg:DOAnchorPosY(endY, duration):OnComplete(function()
    self:CloseDialog()
  end):SetEase(DG.Tweening.Ease.Linear)
  local poolEffs = self:GetUIComponent("UISelectObjectPath", "effs")
  poolEffs:SpawnObjects("UICreditsEffItem", table.count(txts))
  self.itemsEff = poolEffs:GetAllSpawnList()
  for i, uiitem in ipairs(self.itemsEff) do
    uiitem:Flush(txts[i])
  end
  self._cam = self:GetGameObject("Camera"):GetComponent("Camera")
  local uiCamera = GameGlobal.UIStateManager():GetControllerCamera("UICredits")
  self._cam.transform.parent = uiCamera.transform.parent
  self._cam.transform.localPosition = Vector3(0, 0, -10)
  self._cam.transform.localScale = Vector3.one
  self._cam.targetTexture = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
end

function UICredits:OnHide()
  if self.tweener then
    self.tweener:Kill()
    self.tweener = nil
  end
  self._cam.targetTexture:Release()
  self._cam.targetTexture = nil
  self._cam.transform.parent = self.tran
end

function UICredits:bgOnClick(go)
  self:ShowHideBtns()
end

function UICredits:ShowHideBtns()
  if self.goBtns.activeInHierarchy then
    self.goBtns:SetActive(false)
  else
    self.goBtns:SetActive(true)
  end
end

function UICredits:OnUpdate(dt)
  for i, uiitem in ipairs(self.itemsEff) do
    uiitem:OnUpdate()
    self._cam.targetTexture:SetGlobalShaderProperty("RTUICredits")
  end
end
