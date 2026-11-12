local BdConvertBuildItemCtrl = class("BdConvertBuildItemCtrl", BaseCtrl)
local PanelState = {
  Normal = 1,
  Delete = 2,
  Preference = 3
}
BdConvertBuildItemCtrl._mapNodeConfig = {
  img_SelectPreference = {},
  btn_LockIcon = {sComponentName = "Button"},
  btn_grid = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Grid"
  },
  btn_Lock = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Lock"
  },
  imgRareFrame = {sComponentName = "Image"},
  imgRareScore = {sComponentName = "Image"},
  txtBuildName = {sComponentName = "TMP_Text"},
  imgLike = {},
  txtLeaderCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Leader"
  },
  txtSubCn = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Sub"
  },
  imgCharIcon = {nCount = 3, sComponentName = "Image"},
  imgCharFrame = {nCount = 3, sComponentName = "Image"},
  txtPotentialCount = {nCount = 3, sComponentName = "TMP_Text"},
  imgCharElement = {nCount = 3, sComponentName = "Image"},
  txtChar = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_Char_Title"
  },
  txtDisc = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Build_MainDisc_Title"
  },
  goDiscItem = {
    nCount = 3,
    sCtrlName = "Game.UI.StarTower.Build.BuildSimpleDiscItem"
  },
  objUnavailable = {},
  objUnavailableIcon = {sComponentName = "Image"},
  imgRareScoreMask = {sComponentName = "Image"},
  texUnavailable = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Build_NotAvailable"
  },
  imgUnavailable = {},
  imgBuildUsed = {},
  txtBuildUsed = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Build_Used"
  },
  imgCharUsed = {},
  txtCharUsed = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Build_Char_Used"
  },
  selectedIndex = {},
  txt_select_index = {sComponentName = "TMP_Text"},
  txt_select = {
    sComponentName = "TMP_Text",
    sLanguageId = "BdConvert_Selected"
  }
}
BdConvertBuildItemCtrl._mapEventConfig = {
  BdConvert_BuildRefreshIndex = "RefreshIndex",
  BdConvert_BuildCancleSelect = "CancleSelected"
}

function BdConvertBuildItemCtrl:RefreshGrid(mapData)
  self._mapData = mapData
  self:RefreshInfo()
  self:RefreshChar()
  self:RefreshDisc()
  self:CancleSelected()
end

function BdConvertBuildItemCtrl:RefreshInfo()
  local sScore = "Icon/BuildRank/BuildRank_" .. self._mapData.mapRank.Id
  local sFrame = AllEnum.FrameType_New.BuildRankDB .. AllEnum.FrameColor_New[self._mapData.mapRank.Rarity]
  self:SetPngSprite(self._mapNode.imgRareScore, sScore)
  self:SetAtlasSprite(self._mapNode.imgRareFrame, "12_rare", sFrame)
  if self._mapData.sName == "" or self._mapData.sName == nil then
    NovaAPI.SetTMPText(self._mapNode.txtBuildName, ConfigTable.GetUIText("RoguelikeBuild_EmptyBuildName"))
  else
    NovaAPI.SetTMPText(self._mapNode.txtBuildName, self._mapData.sName)
  end
  self._mapNode.imgLike:SetActive(self._mapData.bPreference)
  self._mapNode.btn_LockIcon.interactable = self._mapData.bLock
end

function BdConvertBuildItemCtrl:RefreshChar()
  for i = 1, 3 do
    local nCharTid = self._mapData.tbChar[i].nTid
    local nCharSkinId = PlayerData.Char:GetCharSkinId(nCharTid)
    local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
    local mapCharCfg = ConfigTable.GetData_Character(nCharTid)
    local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
    self:SetPngSprite(self._mapNode.imgCharIcon[i], mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
    self:SetAtlasSprite(self._mapNode.imgCharFrame[i], "12_rare", sFrame)
    NovaAPI.SetTMPText(self._mapNode.txtPotentialCount[i], self._mapData.tbChar[i].nPotentialCount)
    self:SetAtlasSprite(self._mapNode.imgCharElement[i], "12_rare", AllEnum.Char_Element[mapCharCfg.EET].icon)
  end
end

function BdConvertBuildItemCtrl:RefreshDisc()
  local tbDisc = self._mapData.tbDisc
  local nIndex = 1
  for _, nId in ipairs(tbDisc) do
    if nil ~= self._mapNode.goDiscItem[nIndex] and nIndex <= 3 then
      self._mapNode.goDiscItem[nIndex]:Init(nId)
    end
    nIndex = nIndex + 1
  end
end

function BdConvertBuildItemCtrl:RefreshIndex(mapData, nIndex)
  if mapData ~= self._mapData then
    return
  end
  self:Selected(nIndex)
end

function BdConvertBuildItemCtrl:Init(parentCtrl)
  self._parentCtrl = parentCtrl
end

function BdConvertBuildItemCtrl:SetLockState(bLock)
  self._mapNode.btn_LockIcon.interactable = bLock
end

function BdConvertBuildItemCtrl:CancleSelected()
  self._mapNode.img_SelectPreference:SetActive(false)
  self._mapNode.selectedIndex:SetActive(false)
end

function BdConvertBuildItemCtrl:Selected(nIndex)
  self._mapNode.img_SelectPreference:SetActive(true)
  self._mapNode.selectedIndex:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txt_select_index, nIndex)
end

function BdConvertBuildItemCtrl:Awake()
end

function BdConvertBuildItemCtrl:OnEnable()
end

function BdConvertBuildItemCtrl:OnDisable()
end

function BdConvertBuildItemCtrl:OnDestroy()
end

function BdConvertBuildItemCtrl:OnRelease()
end

function BdConvertBuildItemCtrl:OnBtnClick_Grid(btn)
  if btn.Operate_Type == 0 then
    local nIndex = tonumber(self.gameObject.name) + 1
    self._parentCtrl:OnBtnClickGrid(nIndex, self)
  elseif btn.Operate_Type == 2 then
    local nIndex = tonumber(self.gameObject.name) + 1
    self._parentCtrl:OpenBuildDes(nIndex, self)
  end
end

function BdConvertBuildItemCtrl:OnBtnClick_Lock(btn)
  local nIndex = tonumber(self.gameObject.name) + 1
  self._parentCtrl:OnBuildGridLock(nIndex, self)
end

function BdConvertBuildItemCtrl:OnBtnClick_Preference(btn)
end

return BdConvertBuildItemCtrl
