local FriendPortraitCtrl = class("FriendPortraitCtrl", BaseCtrl)
FriendPortraitCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_CharShowTitle"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Confirm"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Cancel"
  },
  svChar = {
    sComponentName = "LoopScrollView"
  },
  svSkin = {
    sComponentName = "LoopScrollView"
  },
  snapSkin = {
    sNodeName = "svSkin",
    sComponentName = "LoopScrollSnap",
    callback = "OnGridSelect_Skin"
  },
  btnNext = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Next"
  },
  btnPre = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Pre"
  },
  txtSkinName = {sComponentName = "TMP_Text"},
  goPoint = {},
  trPoint = {sComponentName = "Transform"}
}
FriendPortraitCtrl._mapEventConfig = {}

function FriendPortraitCtrl:Open()
  self:Refresh()
  self:PlayInAni()
end

function FriendPortraitCtrl:Refresh()
  self.nCurSkinId = PlayerData.Base:GetPlayerShowSkin()
  self.nCurCharId = ConfigTable.GetData_CharacterSkin(self.nCurSkinId).CharId
  local tbAllChar = PlayerData.Char:GetDataForCharList()
  self.tbChar = {}
  for _, v in pairs(tbAllChar) do
    if self.nCurCharId ~= v.nId then
      table.insert(self.tbChar, v)
    end
  end
  table.sort(self.tbChar, function(a, b)
    return a.Rare < b.Rare or a.Rare == b.Rare and a.nId < b.nId
  end)
  table.insert(self.tbChar, 1, tbAllChar[self.nCurCharId])
  for k, v in pairs(self.tbChar) do
    if v.nId == self.nCurCharId then
      self.nSelectIndex = k
    end
  end
  local nAllCount = #self.tbChar
  self._mapNode.svChar:Init(nAllCount, self, self.OnGridRefresh, self.OnGridBtnClick)
  self:SelectDefaultChar()
end

function FriendPortraitCtrl:SelectDefaultChar()
  local mapData = self.tbChar[self.nSelectIndex]
  self:RefreshSkin(mapData.nId)
end

function FriendPortraitCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbChar[nIndex]
  local imgCur1 = goGrid.transform:Find("btnGrid/AnimRoot/imgCur1").gameObject
  local imgCur2 = goGrid.transform:Find("btnGrid/AnimRoot/imgCur2").gameObject
  local imgSelect = goGrid.transform:Find("btnGrid/AnimRoot/imgSelect").gameObject
  local txtCharName = goGrid.transform:Find("btnGrid/AnimRoot/txtCharName"):GetComponent("TMP_Text")
  local txtCur = goGrid.transform:Find("btnGrid/AnimRoot/imgCur2/txtCur"):GetComponent("TMP_Text")
  local imgCharIcon = goGrid.transform:Find("btnGrid/AnimRoot/tc_char_03/imgIconBg/imgCharIcon"):GetComponent("Image")
  local imgFrame = goGrid.transform:Find("btnGrid/AnimRoot/tc_char_03/imgFrame"):GetComponent("Image")
  local mapCharCfg = ConfigTable.GetData_Character(mapData.nId)
  local nSkinId = mapCharCfg.DefaultSkinId
  local mapSkinCfg = ConfigTable.GetData_CharacterSkin(nSkinId)
  local rareIconName = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapData.Rare]
  NovaAPI.SetTMPText(txtCur, ConfigTable.GetUIText("Friend_CurSelect"))
  NovaAPI.SetTMPText(txtCharName, mapData.Name)
  if mapSkinCfg then
    self:SetPngSprite(imgCharIcon, mapSkinCfg.Icon .. AllEnum.CharHeadIconSurfix.XXL)
  end
  self:SetAtlasSprite(imgFrame, "12_rare", rareIconName)
  imgSelect:SetActive(self.nSelectIndex == nIndex)
  imgCur1:SetActive(mapData.nId == self.nCurCharId)
  imgCur2:SetActive(mapData.nId == self.nCurCharId)
end

function FriendPortraitCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  if self.nSelectIndex == nIndex then
    return
  end
  local mapData = self.tbChar[nIndex]
  if self.nSelectIndex then
    local goSelect = self._mapNode.svChar.transform:Find("Viewport/Content/" .. self.nSelectIndex - 1)
    if goSelect then
      local imgSelect = goSelect.transform:Find("btnGrid/AnimRoot/imgSelect").gameObject
      imgSelect:SetActive(false)
    end
  end
  local imgSelect = goGrid.transform:Find("btnGrid/AnimRoot/imgSelect").gameObject
  imgSelect:SetActive(true)
  self.nSelectIndex = nIndex
  self:RefreshSkin(mapData.nId)
end

function FriendPortraitCtrl:RefreshSkin(nCharId)
  local tbSkinList = PlayerData.CharSkin:GetSkinListByCharacterId(nCharId)
  self.tbSortSkinList = {}
  for _, v in pairs(tbSkinList) do
    if true == v:CheckUnlock() then
      table.insert(self.tbSortSkinList, v)
    end
  end
  table.sort(self.tbSortSkinList, function(a, b)
    return a:GetId() < b:GetId()
  end)
  self.nSkinIndex = 1
  for k, v in pairs(self.tbSortSkinList) do
    if v:GetId() == self.nCurSkinId then
      self.nSkinIndex = k
    end
  end
  self.nSkinCount = #self.tbSortSkinList
  self._mapNode.svSkin:Init(self.nSkinCount, self, self.OnSkinGridRefresh)
  self._mapNode.svSkin:SetScrollGridPos(self.nSkinIndex - 1, 0)
  self.tbPoint = {}
  delChildren(self._mapNode.trPoint)
  for i = 1, self.nSkinCount do
    local obj = instantiate(self._mapNode.goPoint, self._mapNode.trPoint)
    local on = obj.transform:Find("imgPointOn").gameObject
    local off = obj.transform:Find("imgPointOff").gameObject
    on:SetActive(self.nSkinIndex == i)
    off:SetActive(self.nSkinIndex ~= i)
    obj:SetActive(true)
    table.insert(self.tbPoint, obj)
  end
  self:SelectDefaultSkin()
end

function FriendPortraitCtrl:SelectDefaultSkin()
  local mapData = self.tbSortSkinList[self.nSkinIndex]
  local mapCfg = mapData:GetCfgData()
  NovaAPI.SetTMPText(self._mapNode.txtSkinName, mapCfg.Name)
  self._mapNode.btnPre.gameObject:SetActive(self.nSkinIndex > 1)
  self._mapNode.btnNext.gameObject:SetActive(self.nSkinIndex < self.nSkinCount)
end

function FriendPortraitCtrl:OnSkinGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbSortSkinList[nIndex]
  local imgSkin = goGrid.transform:Find("btnGrid/AnimRoot/imgSkin"):GetComponent("Image")
  local mapCfg = mapData:GetCfgData()
  self:SetPngSprite(imgSkin, mapCfg.Icon .. AllEnum.CharHeadIconSurfix.SK)
end

function FriendPortraitCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function FriendPortraitCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function FriendPortraitCtrl:Close()
  self.gameObject:SetActive(false)
end

function FriendPortraitCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
  self.nSelectIndex = 1
  self.nSkinIndex = 1
end

function FriendPortraitCtrl:OnEnable()
end

function FriendPortraitCtrl:OnDisable()
end

function FriendPortraitCtrl:OnDestroy()
end

function FriendPortraitCtrl:OnBtnClick_Cancel(btn)
  EventManager.Hit("FriendClosePop")
end

function FriendPortraitCtrl:OnBtnClick_Confirm(btn)
  local function callback()
    EventManager.Hit("FriendClosePop")
    
    EventManager.Hit("FriendRefreshActor")
  end
  
  PlayerData.Base:SendPlayerSkinShowReq(self.tbSortSkinList[self.nSkinIndex]:GetId(), callback)
end

function FriendPortraitCtrl:OnGridSelect_Skin(_, goGrid)
  local nIndex = tonumber(goGrid.name) + 1
  local goBefore = self.tbPoint[self.nSkinIndex]
  goBefore.transform:Find("imgPointOn").gameObject:SetActive(false)
  goBefore.transform:Find("imgPointOff").gameObject:SetActive(true)
  self.nSkinIndex = nIndex
  local goCur = self.tbPoint[self.nSkinIndex]
  goCur.transform:Find("imgPointOn").gameObject:SetActive(true)
  goCur.transform:Find("imgPointOff").gameObject:SetActive(false)
  local mapData = self.tbSortSkinList[nIndex]
  local mapCfg = mapData:GetCfgData()
  NovaAPI.SetTMPText(self._mapNode.txtSkinName, mapCfg.Name)
  self._mapNode.btnPre.gameObject:SetActive(1 < self.nSkinIndex)
  self._mapNode.btnNext.gameObject:SetActive(self.nSkinIndex < self.nSkinCount)
end

function FriendPortraitCtrl:OnBtnClick_Next(btn)
  if self.nSkinIndex + 1 > self.nSkinCount then
    return
  end
  local nPos = self.nSkinIndex + 1
  self._mapNode.svSkin:SetScrollGridPos(nPos - 1, 0.5)
end

function FriendPortraitCtrl:OnBtnClick_Pre(btn)
  if self.nSkinIndex - 1 < 1 then
    return
  end
  local nPos = self.nSkinIndex - 1
  self._mapNode.svSkin:SetScrollGridPos(nPos - 1, 0.5)
end

return FriendPortraitCtrl
