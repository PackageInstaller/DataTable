_class("UIDrawCardAwardDetailItemNew", UICustomWidget)
UIDrawCardAwardDetailItemNew = UIDrawCardAwardDetailItemNew

function UIDrawCardAwardDetailItemNew:OnShow()
  self.title = self:GetUIComponent("UILocalizationText", "title")
  self.detail = self:GetUIComponent("UILocalizationText", "detail")
  self.content = self:GetGameObject("content")
  self.detailItem = self:GetUIComponent("UISelectObjectPath", "DetailItem")
  self.allPetTitle = self:GetGameObject("AllpetTitle")
  self.upTitle = self:GetGameObject("upTitle")
  self.upSix = self:GetGameObject("UpSix")
  self.upPetSix = self:GetGameObject("UpPetSix")
  self.upFive = self:GetGameObject("UpFive")
  self.upPetFive = self:GetGameObject("UpPetFive")
  self.mustTitle = self:GetGameObject("mustTitle")
  self.must = self:GetGameObject("must")
  self.sixup = self:GetUIComponent("UISelectObjectPath", "Sixup")
  self.fiveup = self:GetUIComponent("UISelectObjectPath", "Fiveup")
  self.mustPet = self:GetUIComponent("UISelectObjectPath", "mustPet")
  self.sixrateText = self:GetUIComponent("UILocalizationText", "sixrate")
  self.fiverateText = self:GetUIComponent("UILocalizationText", "fiverate")
  self.mustText = self:GetUIComponent("UILocalizationText", "mustText")
  self.upTitleText = self:GetUIComponent("UILocalizationText", "upTitleText")
  self.wishUnopen = self:GetUIComponent("RectTransform", "wishUnopen")
  self.wishOpen = self:GetUIComponent("RectTransform", "wishOpen")
  self.uiLayout = self:GetUIComponent("RectTransform", "uiLayout")
end

function UIDrawCardAwardDetailItemNew:SetWishPool(isOpen, wishPool)
  self._wishPoolOpen = isOpen
  if wishPool ~= nil then
    self._wishPool = {1000}
    for k, v in pairs(wishPool) do
      self._wishPool[k + 1] = v
    end
  end
end

function UIDrawCardAwardDetailItemNew:SetData(title, content, id)
  self.poolId = id
  local cfg = Cfg.cfg_recruit_pool_view[id]
  self.title.text = StringTable.Get(title)
  if content then
    self.detail.text = StringTable.Get(content)
  else
    self.content:SetActive(false)
  end
  if not id then
    self.allPetTitle:SetActive(false)
    self.upTitle:SetActive(false)
    self.upSix:SetActive(false)
    self.upPetSix:SetActive(false)
    self.upFive:SetActive(false)
    self.upPetFive:SetActive(false)
    self.mustTitle:SetActive(false)
    self.must:SetActive(false)
  end
  if id then
    self.allPetTitle:SetActive(true)
    self.detailItem:SpawnObjects("UIDrawCardAwardPet", 4)
    local item = self.detailItem:GetAllSpawnList()
    for k, value in ipairs(item) do
      value:SetWishPool(self._wishPool)
      value:SetData(k, id)
    end
    UnityEngine.Canvas.ForceUpdateCanvases()
  end
  if id then
    local fivepet = cfg.fiveup
    local sixpet = cfg.sixup
    local fivetitle = cfg.fivetitle
    local sixtitle = cfg.sixtitle
    if sixpet and sixpet[1] and sixpet[1][2] then
      self.upTitle:SetActive(true)
      self.upSix:SetActive(true)
      self.upPetSix:SetActive(true)
      self.upTitleText:SetText(StringTable.Get(sixtitle[1]))
      self.sixrateText:SetText(StringTable.Get(sixtitle[2]))
      self.sixup:SpawnObjects("UIDrawCardAwardPetItem", #sixpet)
      self.sixitems = self.sixup:GetAllSpawnList()
      for idx, value in ipairs(self.sixitems) do
        value:SetData(6, sixpet[idx][1], sixpet[idx][2] / 1000)
      end
    end
    if sixpet and sixpet[1] and sixpet[1][2] == nil then
      self.mustTitle:SetActive(true)
      self.must:SetActive(true)
      self.mustText:SetText(StringTable.Get(sixtitle[1]))
      self.mustPet:SpawnObjects("UIDrawCardAwardPetItem", #sixpet)
      self.mustPetItems = self.mustPet:GetAllSpawnList()
      for idx, value in ipairs(self.mustPetItems) do
        value:SetData(6, sixpet[idx][1])
      end
    end
    if fivepet and fivepet[1] and fivepet[1][2] then
      self.upTitle:SetActive(true)
      self.upFive:SetActive(true)
      self.upPetFive:SetActive(true)
      self.upTitleText:SetText(StringTable.Get(fivetitle[1]))
      self.fiverateText:SetText(StringTable.Get(fivetitle[2]))
      self.fiveup:SpawnObjects("UIDrawCardAwardPetItem", #fivepet)
      self.fiveitems = self.fiveup:GetAllSpawnList()
      for idx, value in ipairs(self.fiveitems) do
        value:SetData(5, fivepet[idx][1], fivepet[idx][2] / 1000)
      end
    end
  end
  self.wishUnopen.gameObject:SetActive(self._wishPoolOpen and self._wishPool == nil)
  self.wishOpen.gameObject:SetActive(self._wishPoolOpen and self._wishPool ~= nil)
  UnityEngine.UI.LayoutRebuilder.MarkLayoutForRebuild(self.uiLayout)
end

function UIDrawCardAwardDetailItemNew:OnHide()
end
