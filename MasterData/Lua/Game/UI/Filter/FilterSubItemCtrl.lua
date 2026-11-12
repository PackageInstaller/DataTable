local FilterSubItemCtrl = class("FilterSubItemCtrl", BaseCtrl)
FilterSubItemCtrl._mapNodeConfig = {
  img_choose = {},
  img_choose2 = {},
  root_normal = {},
  root_rarity = {},
  root_normal_icon = {},
  cg_normal = {
    sNodeName = "root_normal",
    sComponentName = "CanvasGroup"
  },
  cg_rarity = {
    sNodeName = "root_rarity",
    sComponentName = "CanvasGroup"
  },
  cg_normal_icon = {
    sNodeName = "root_normal_icon",
    sComponentName = "CanvasGroup"
  },
  img_bg = {},
  lab_item_all = {sComponentName = "TMP_Text"}
}
FilterSubItemCtrl._mapEventConfig = {}

function FilterSubItemCtrl:Awake()
  self.btnRoot = self.gameObject.transform:GetComponent("UIButton")
end

function FilterSubItemCtrl:OnEnable()
  self.handler = ui_handler(self, self.OnBtnClick, self.btnRoot)
  self.btnRoot.onClick:AddListener(self.handler)
  self.choose = true
end

function FilterSubItemCtrl:OnDisable()
  self.btnRoot.onClick:RemoveListener(self.handler)
end

function FilterSubItemCtrl:Refresh(optionType, optionItemType, parentCtrl)
  self.fKey = optionType
  self.sKey = optionItemType
  self.parentCtrl = parentCtrl
  local choose, bCache = PlayerData.Filter:GetCacheFilterByKey(self.fKey, self.sKey)
  self.choose = choose
  if not bCache then
    PlayerData.Filter:SetCacheFilterByKey(self.fKey, self.sKey, self.choose)
  end
  if optionItemType == "All" then
    self._mapNode.root_normal:SetActive(true)
    self._mapNode.root_rarity:SetActive(false)
    self._mapNode.root_normal_icon:SetActive(false)
    self._mapNode.img_bg:SetActive(false)
    local labTiTle = self._mapNode.root_normal.transform:Find("lab_item")
    labTiTle.gameObject:SetActive(false)
    self._mapNode.lab_item_all.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.lab_item_all, ConfigTable.GetUIText("Filter_All"))
    return
  end
  local content = AllEnum.ChooseOptionCfg[optionType]
  local tbItem = content.items
  local curItem = tbItem[optionItemType]
  local isNormal = content.layout == AllEnum.OptionLayout.Normal
  local isNormalWithIcon = content.layout == AllEnum.OptionLayout.NormalWithIcon
  local isImage = content.layout == AllEnum.OptionLayout.Image
  self._mapNode.root_normal:SetActive(isNormal)
  self._mapNode.root_rarity:SetActive(isImage)
  self._mapNode.root_normal_icon:SetActive(isNormalWithIcon)
  self._mapNode.img_choose:SetActive(self.choose)
  self._mapNode.img_choose2:SetActive(self.choose)
  if isNormal or isNormalWithIcon then
    local labTiTle1 = self._mapNode.root_normal.transform:Find("lab_item"):GetComponent("TMP_Text")
    local labTiTle2 = self._mapNode.root_normal_icon.transform:Find("img_icon/lab_item"):GetComponent("TMP_Text")
    local labTiTle = isNormalWithIcon and labTiTle2 or labTiTle1
    if optionType == AllEnum.ChooseOption.Char_AffiliatedForces or optionType == AllEnum.ChooseOption.Char_PowerStyle or optionType == AllEnum.ChooseOption.Char_TacticalStyle or optionType == AllEnum.ChooseOption.Equip_AffiliatedForces or optionType == AllEnum.ChooseOption.Equip_PowerStyle or optionType == AllEnum.ChooseOption.Equip_TacticalStyle then
      NovaAPI.SetTMPText(labTiTle, ConfigTable.GetData("CharacterTag", curItem.sLanguage).Title)
    elseif optionType == AllEnum.ChooseOption.Equip_Theme_Square or optionType == AllEnum.ChooseOption.Equip_Theme_Circle or optionType == AllEnum.ChooseOption.Equip_Theme_Pentagon then
      NovaAPI.SetTMPText(labTiTle, ConfigTable.GetData("EffectDesc", curItem.sLanguage).Desc)
    elseif optionType == AllEnum.ChooseOption.Star_Tag then
      NovaAPI.SetTMPText(labTiTle, ConfigTable.GetData("DiscTag", curItem.sLanguage).Title)
    elseif optionType == AllEnum.ChooseOption.Star_Note then
      NovaAPI.SetTMPText(labTiTle, ConfigTable.GetData("SubNoteSkill", optionItemType).Name)
    else
      NovaAPI.SetTMPText(labTiTle, ConfigTable.GetUIText(curItem.sLanguage))
    end
  end
  if isNormalWithIcon then
    local imgTitle = self._mapNode.root_normal_icon.transform:Find("img_icon"):GetComponent("Image")
    local rtTiltie = self._mapNode.root_normal_icon.transform:Find("img_icon"):GetComponent("RectTransform")
    local rtLab = self._mapNode.root_normal_icon.transform:Find("img_icon/lab_item"):GetComponent("RectTransform")
    if optionType == AllEnum.ChooseOption.Char_Element or optionType == AllEnum.ChooseOption.Star_Element then
      self:SetAtlasSprite(imgTitle, "12_rare", curItem.icon, true)
      rtTiltie.sizeDelta = Vector2(62, 62)
      rtLab.sizeDelta = Vector2(93, 40)
    elseif optionType == AllEnum.ChooseOption.Star_Note then
      local mapCfg = ConfigTable.GetData("SubNoteSkill", optionItemType)
      if mapCfg then
        self:SetPngSprite(imgTitle, mapCfg.Icon .. AllEnum.DiscSkillIconSurfix.Small)
      end
      rtTiltie.sizeDelta = Vector2(76, 76)
      rtLab.sizeDelta = Vector2(130, 40)
    elseif optionType == AllEnum.ChooseOption.Equip_Type then
      self:SetPngSprite(imgTitle, curItem.icon)
      rtTiltie.sizeDelta = Vector2(50, 50)
      rtLab.sizeDelta = Vector2(183, 40)
    end
  end
  if isImage then
    if optionType == AllEnum.ChooseOption.Star_Rarity then
      local rarity = 6 - optionItemType
      local imgRarity = self._mapNode.root_rarity.transform:GetChild(0):GetComponent("Image")
      self:SetSprite_FrameColor(imgRarity, optionItemType, AllEnum.FrameType_New.Text)
      NovaAPI.SetImageNativeSize(imgRarity)
    elseif optionType == AllEnum.ChooseOption.Char_Rarity then
      local rarity = 6 - optionItemType
      local imgRarity = self._mapNode.root_rarity.transform:GetChild(0):GetComponent("Image")
      self:SetSprite_FrameColor(imgRarity, optionItemType, AllEnum.FrameType_New.Text)
      NovaAPI.SetImageNativeSize(imgRarity)
    elseif optionType == AllEnum.ChooseOption.Equip_Rarity then
      local rarity = 6 - optionItemType
      local imgRarity = self._mapNode.root_rarity.transform:GetChild(0):GetComponent("Image")
      self:SetSprite_FrameColor(imgRarity, optionItemType, AllEnum.FrameType_New.Text)
      NovaAPI.SetImageNativeSize(imgRarity)
    end
  end
end

function FilterSubItemCtrl:SetBtnState(bActive)
  self.choose = bActive
  self._mapNode.img_choose:SetActive(self.choose)
  self._mapNode.img_choose2:SetActive(self.choose)
  if self.sKey ~= "All" then
    PlayerData.Filter:SetCacheFilterByKey(self.fKey, self.sKey, self.choose)
  end
end

function FilterSubItemCtrl:OnBtnClick()
  if self.sKey ~= "All" then
    self.choose = not self.choose
    self._mapNode.img_choose:SetActive(self.choose)
    self._mapNode.img_choose2:SetActive(self.choose)
    PlayerData.Filter:SetCacheFilterByKey(self.fKey, self.sKey, self.choose)
    self.parentCtrl:CheckSelectionState()
  else
    self.parentCtrl:OnBtnClick_All()
  end
end

return FilterSubItemCtrl
