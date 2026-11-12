local PotentialPreselectionItemCtrl = class("PotentialPreselectionItemCtrl", BaseCtrl)
PotentialPreselectionItemCtrl._mapNodeConfig = {
  img_SelectPreference = {},
  txtBuildName = {sComponentName = "TMP_Text"},
  imgLike = {},
  imgCharIcon = {nCount = 3, sComponentName = "Image"},
  imgCharFrame = {nCount = 3, sComponentName = "Image"},
  txtLeaderCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Leader"
  },
  txtSubCn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Sub"
  },
  txtPotentialCount = {nCount = 3, sComponentName = "TMP_Text"},
  imgCharElement = {nCount = 3, sComponentName = "Image"},
  btnDelete = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Delete"
  },
  imgSelect = {},
  txtSelect = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Preselection_Select"
  },
  goMask = {},
  txtMask = {sComponentName = "TMP_Text"},
  imgSystemRecommend = {},
  txtSystemRecmd = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_System_Preset_Title"
  }
}
PotentialPreselectionItemCtrl._mapEventConfig = {}
PotentialPreselectionItemCtrl._mapRedDotConfig = {}

function PotentialPreselectionItemCtrl:RefreshItem(mapData, bCharDiff, bSelect, bSystemRecommend)
  self.mapData = mapData
  self:ShowDelete(false)
  self:SetSelect(bSelect)
  NovaAPI.SetTMPText(self._mapNode.txtBuildName, mapData.sName)
  self._mapNode.imgLike.gameObject:SetActive(mapData.bPreference)
  self._mapNode.imgSystemRecommend.gameObject:SetActive(bSystemRecommend == true)
  local bCharLock = false
  for k, v in ipairs(mapData.tbCharPotential) do
    local nCharId = v.nCharId
    local mapCharData = PlayerData.Char:GetCharDataById(nCharId)
    if mapCharData == nil or next(mapCharData) == nil then
      bCharLock = true
    end
    local mapCharCfg = ConfigTable.GetData_Character(nCharId)
    if mapCharCfg ~= nil then
      local nSkinId = PlayerData.Char:GetCharSkinId(nCharId)
      local mapCharSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
      local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
      self:SetPngSprite(self._mapNode.imgCharIcon[k], mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
      self:SetAtlasSprite(self._mapNode.imgCharFrame[k], "12_rare", sFrame)
      self:SetAtlasSprite(self._mapNode.imgCharElement[k], "12_rare", AllEnum.Char_Element[mapCharCfg.EET].icon)
    end
    local tbPotential = v.tbPotential
    local nCount = 0
    for _, potential in ipairs(tbPotential) do
      nCount = nCount + potential.nLevel
    end
    NovaAPI.SetTMPText(self._mapNode.txtPotentialCount[k], nCount)
  end
  self._mapNode.goMask.gameObject:SetActive(bCharDiff or bCharLock)
  if bCharLock then
    NovaAPI.SetTMPText(self._mapNode.txtMask, ConfigTable.GetUIText("Potential_Preselection_Item_Char_Lock"))
  elseif bCharDiff then
    NovaAPI.SetTMPText(self._mapNode.txtMask, ConfigTable.GetUIText("Potential_Preselection_Item_Char_Diff"))
  end
end

function PotentialPreselectionItemCtrl:ShowDelete(bShow)
  if self.mapData ~= nil and not self.mapData.bPreference and self.mapData.bSystemRecommend ~= true then
    self._mapNode.btnDelete.gameObject:SetActive(bShow)
  else
    self._mapNode.btnDelete.gameObject:SetActive(false)
  end
end

function PotentialPreselectionItemCtrl:SetSelect(bSelect)
  self._mapNode.img_SelectPreference.gameObject:SetActive(bSelect)
  self._mapNode.imgSelect.gameObject:SetActive(bSelect)
end

function PotentialPreselectionItemCtrl:Awake()
end

function PotentialPreselectionItemCtrl:OnEnable()
end

function PotentialPreselectionItemCtrl:OnDisable()
end

function PotentialPreselectionItemCtrl:OnDestroy()
end

function PotentialPreselectionItemCtrl:OnBtnClick_Delete()
  if self.mapData == nil or self.mapData.bSystemRecommend == true then
    return
  end
  if self.mapData ~= nil then
    local function callback()
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Delete_Suc"))
    end
    
    local tbDelete = {
      self.mapData.nId
    }
    PlayerData.PotentialPreselection:SendDeletePreselection(tbDelete, callback)
  end
end

return PotentialPreselectionItemCtrl
