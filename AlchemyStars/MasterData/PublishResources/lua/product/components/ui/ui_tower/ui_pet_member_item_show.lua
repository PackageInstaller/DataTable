_class("UIPetMemberItemShow", UICustomWidget)
UIPetMemberItemShow = UIPetMemberItemShow

function UIPetMemberItemShow:Constructor()
end

function UIPetMemberItemShow:OnShow()
  self._rawimage = self:GetUIComponent("RawImageLoader", "drawIcon")
  self._leaderGO = self:GetGameObject("leaderIcon")
  self._lvValueText = self:GetUIComponent("UILocalizationText", "lvValue")
  self._nameText = self:GetUIComponent("UILocalizationText", "name")
  self._imgLogo = self:GetUIComponent("RawImageLoader", "imgLogo")
  self.atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._attrMain = self:GetUIComponent("Image", "attrMain")
  self._attrVice = self:GetUIComponent("Image", "attrVice")
  self._imgGrade = self:GetUIComponent("Image", "imgGrade")
  self._uiAtlas = self:GetAsset("UITeams.spriteatlas", LoadType.SpriteAtlas)
  self._petModule = self:GetModule(PetModule)
  self._elementBg = self:GetUIComponent("RectTransform", "element")
  self:GetGameObject("detailBtnRect"):SetActive(false)
  self:GetGameObject("guidewarn"):SetActive(false)
  self:GetGameObject("power"):SetActive(false)
end

function UIPetMemberItemShow:OnHide()
end

function UIPetMemberItemShow:SetData(slotId, data)
  self._slotId = slotId
  self._pet = data
  if data == nil then
    Log.fatal("星灵数据为空！")
  end
  self:SetDataPet()
end

function UIPetMemberItemShow:SetDataPet()
  self._rawimage:LoadImage(self._pet:GetPetTeamBody())
  self._nameText.text = StringTable.Get(self._pet:Name())
  self._lvValueText:SetText("LV." .. self._pet:Level())
  self._imgLogo:LoadImage(self._pet:Logo())
  local cfg_pet_element = Cfg.cfg_pet_element({})
  local _1stElement = self._pet:Element()
  if _1stElement then
    self._attrMain.gameObject:SetActive(true)
    self._attrMain.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[_1stElement].Icon))
  else
    self._attrMain.gameObject:SetActive(false)
  end
  local _2ndElement = self._pet:ViceElement()
  if _2ndElement then
    self._elementBg.sizeDelta = Vector2(118, 52)
    self._attrVice.gameObject:SetActive(true)
    self._attrVice.sprite = self.atlasProperty:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(cfg_pet_element[_2ndElement].Icon))
  else
    self._elementBg.sizeDelta = Vector2(80, 52)
    self._attrVice.gameObject:SetActive(false)
  end
  local petStar = self._pet:Star()
  for starLevel = 1, 6 do
    local starGo = self:GetGameObject("star" .. starLevel)
    if starLevel <= petStar then
      starGo:SetActive(true)
    else
      starGo:SetActive(false)
    end
  end
  self._leaderGO:SetActive(self._slotId == 1)
  self._imgGrade.sprite = self._uiAtlas:GetSprite("spirit_jie" .. self._pet:Awake() .. "_frame")
end

function UIPetMemberItemShow:detailBtnOnClick()
end
