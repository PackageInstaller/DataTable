local BaseCtrl = require("GameCore.UI.BaseCtrl")
local CharRecordInfoItemCtrl = class("CharRecordInfoItemCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
CharRecordInfoItemCtrl._mapNodeConfig = {
  goInfoRoot = {
    sNodeName = "InfoRoot",
    sComponentName = "RectTransform"
  },
  txtInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterRelation_Base_Info"
  },
  goNormalRoot = {sNodeName = "NormalRoot", sComponentName = "GameObject"},
  goLockNormal = {sNodeName = "LockNormal", sComponentName = "GameObject"},
  goSpecialRoot = {
    sNodeName = "SpecialRoot",
    sComponentName = "GameObject"
  },
  transInfoContent = {
    nCount = 8,
    sNodeName = "infoContentGrid",
    sComponentName = "RectTransform"
  },
  transInfoContentRoot = {
    sNodeName = "infoContent",
    sComponentName = "RectTransform"
  },
  txtTittle = {sNodeName = "txtTittle", sComponentName = "TMP_Text"},
  txtContent = {sNodeName = "txtContent", sComponentName = "TMP_Text"},
  txtLockTitle = {
    sNodeName = "txtLockTitle",
    sComponentName = "TMP_Text"
  },
  txtLockCondition = {
    sNodeName = "txtLockCondition",
    sComponentName = "TMP_Text"
  },
  goSpecialUnlockRoot = {
    sNodeName = "SpecialUnlockRoot",
    sComponentName = "GameObject"
  },
  goSpecialLockRoot = {
    sNodeName = "SpecialLockRoot",
    sComponentName = "GameObject"
  },
  imgContent = {sNodeName = "imgContent", sComponentName = "Image"},
  imgBgForce = {sNodeName = "imgBgForce", sComponentName = "Image"},
  txtSpecialTittle = {
    sNodeName = "txtSpecialTittle",
    sComponentName = "TMP_Text"
  },
  btnStory = {sNodeName = "btnStory", sComponentName = "UIButton"},
  txtBtnStory = {
    sComponentName = "TMP_Text",
    sLanguageId = "Relation_Story_Detail"
  },
  txtSpecialCondition = {
    sNodeName = "txtSpecialCondition",
    sComponentName = "TMP_Text"
  },
  RedDot = {},
  imgLineVertical = {},
  imgLineHorizontal = {
    sComponentName = "RectTransform"
  }
}
CharRecordInfoItemCtrl._mapEventConfig = {}
local nInfoContentMaxWidth = 860

function CharRecordInfoItemCtrl:Awake()
end

function CharRecordInfoItemCtrl:OnEnable()
end

function CharRecordInfoItemCtrl:RefreshGrid(data, baseData)
  self.curFavourLevel = PlayerData.Char:GetCharAffinityData(data.CharacterId).Level
  self._mapNode.goInfoRoot.gameObject:SetActive(data.ArchType == GameEnum.ArchType.BaseType)
  self._mapNode.goNormalRoot:SetActive(data.ArchType == GameEnum.ArchType.NormalType and self.curFavourLevel >= data.UnlockAffinityLevel)
  self._mapNode.goLockNormal:SetActive(data.ArchType == GameEnum.ArchType.NormalType and self.curFavourLevel < data.UnlockAffinityLevel)
  self._mapNode.goSpecialRoot:SetActive(data.ArchType == GameEnum.ArchType.SpecialType)
  self.bgImage = self.gameObject:GetComponent("Image")
  local color = NovaAPI.GetImageColor(self.bgImage)
  color.a = self.curFavourLevel >= data.UnlockAffinityLevel and 1 or 0.8
  NovaAPI.SetImageColor(self.bgImage, color)
  self._mapNode.imgLineHorizontal.gameObject:SetActive(self.curFavourLevel >= data.UnlockAffinityLevel)
  self._mapNode.imgLineVertical.gameObject:SetActive(self.curFavourLevel >= data.UnlockAffinityLevel)
  if data.ArchType == GameEnum.ArchType.BaseType then
    self:RefreshRecordInfo(baseData)
    local mapCharDes = ConfigTable.GetData("CharacterDes", data.CharacterId)
    if not mapCharDes then
      return
    end
    local mapForceCfg = ConfigTable.GetData("Force", mapCharDes.Force)
    if not mapForceCfg then
      return
    end
    self:SetPngSprite(self._mapNode.imgBgForce, mapForceCfg.Icon1)
  elseif data.ArchType == GameEnum.ArchType.NormalType then
    self:RefreshNormalInfo(data)
  else
    self:RefreshSpecialInfo(data)
  end
  self:AddTimer(1, 0.1, function()
    local sizeDelta = self.gameObject:GetComponent("RectTransform").sizeDelta
    self._mapNode.imgLineHorizontal.sizeDelta = Vector2(sizeDelta.y, sizeDelta.x)
  end, true, true, true)
end

function CharRecordInfoItemCtrl:RefreshRecordInfo(baseData)
  table.sort(baseData, function(a, b)
    return a.Sort < b.Sort
  end)
  for i = 1, #self._mapNode.transInfoContent do
    local content = self._mapNode.transInfoContent[i]
    if baseData[i] ~= nil then
      local title = content:Find("txtInfoTitle"):GetComponent("TMP_Text")
      local rtTitle = content:Find("txtInfoTitle"):GetComponent("RectTransform")
      local titleContent = content:Find("txtInfoContent"):GetComponent("TMP_Text")
      local leContent = content:Find("txtInfoContent"):GetComponent("LayoutElement")
      local forceImgRoot = content:Find("imgForceRoot")
      NovaAPI.SetTMPText(title, baseData[i].Title)
      LayoutRebuilder.ForceRebuildLayoutImmediate(content)
      local nWidth = rtTitle.rect.width
      NovaAPI.SetLayoutElementPreferredWidth(leContent, nInfoContentMaxWidth - nWidth - 10)
      local bUpdate = PlayerData.Char:CheckCharArchiveBaseContentUpdate(baseData[i].CharacterId, baseData[i].Id)
      local sContent = bUpdate and baseData[i].UpdateContent1 or baseData[i].Content
      NovaAPI.SetTMPText(titleContent, sContent, GetLanguageIndex(Settings.sCurrentTxtLanguage))
      forceImgRoot.gameObject:SetActive(false)
    end
    content.gameObject:SetActive(i <= #baseData)
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self.gameObject.transform)
end

function CharRecordInfoItemCtrl:RefreshNormalInfo(data)
  if self.curFavourLevel < data.UnlockAffinityLevel then
    local contentData = ConfigTable.GetData("CharacterArchiveContent", data.RecordId)
    if contentData ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtLockTitle, contentData.Title)
    end
    NovaAPI.SetTMPText(self._mapNode.txtLockCondition, orderedFormat(ConfigTable.GetUIText("Affinity_UnLock_Level"), data.UnlockAffinityLevel))
  else
    local contentData = ConfigTable.GetData("CharacterArchiveContent", data.RecordId)
    if contentData ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtTittle, contentData.Title)
      local bUpdate = PlayerData.Char:CheckCharArchiveContentUpdate(data.CharacterId, data.RecordId)
      local sContent = bUpdate and contentData.UpdateContent1 or contentData.Content
      NovaAPI.SetTMPText(self._mapNode.txtContent, ProcAvgTextContent(sContent, GetLanguageIndex(Settings.sCurrentTxtLanguage)))
    end
    self._mapNode.imgContent.gameObject:SetActive(false)
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.txtContent.transform)
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.goNormalRoot.transform)
end

function CharRecordInfoItemCtrl:RefreshSpecialInfo(data)
  self._mapNode.goSpecialLockRoot:SetActive(data.UnlockAffinityLevel > self.curFavourLevel)
  self._mapNode.goSpecialUnlockRoot:SetActive(data.UnlockAffinityLevel <= self.curFavourLevel)
  if data.UnlockAffinityLevel > self.curFavourLevel then
    NovaAPI.SetTMPText(self._mapNode.txtSpecialCondition, orderedFormat(ConfigTable.GetUIText("Affinity_UnLock_Level"), data.UnlockAffinityLevel))
  else
    local contentData = ConfigTable.GetData("CharacterArchiveContent", data.RecordId)
    if contentData ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtSpecialTittle, contentData.Title)
      self._mapNode.btnStory.onClick:RemoveAllListeners()
      self._mapNode.btnStory.onClick:AddListener(function()
        EventManager.Hit(EventId.LookUpCharStory, contentData.Id)
      end)
    end
  end
end

return CharRecordInfoItemCtrl
