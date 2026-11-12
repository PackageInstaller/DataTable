local FriendTitleCtrl = class("FriendTitleCtrl", BaseCtrl)
FriendTitleCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_ChangeTitle"
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
  txtSelect = {nCount = 2, sComponentName = "TMP_Text"},
  sv = {
    nCount = 2,
    sComponentName = "LoopScrollView"
  }
}
FriendTitleCtrl._mapEventConfig = {}

function FriendTitleCtrl:Open()
  self:Refresh()
  self:PlayInAni()
end

function FriendTitleCtrl:Refresh()
  local nPre, nSuf = PlayerData.Base:GetPlayerTitle()
  NovaAPI.SetTMPText(self._mapNode.txtSelect[1], nPre == 0 and "" or ConfigTable.GetData("Title", nPre).Desc)
  NovaAPI.SetTMPText(self._mapNode.txtSelect[2], nSuf == 0 and "" or ConfigTable.GetData("Title", nSuf).Desc)
  self.tbPrefix, self.tbSuffix = PlayerData.Base:GetPlayerAllTitle()
  local nNumPre = #self.tbPrefix
  self._mapNode.sv[1].gameObject:SetActive(0 < nNumPre)
  if 0 < nNumPre then
    self.nPrefixIndex = 1
    for k, v in pairs(self.tbPrefix) do
      if v.nId == nPre then
        self.nPrefixIndex = k
      end
    end
    self._mapNode.sv[1]:Init(nNumPre, self, self.OnPrefixGridRefresh, self.OnPrefixGridClick)
  end
  local nNumSuf = #self.tbSuffix
  self._mapNode.sv[2].gameObject:SetActive(0 < nNumSuf)
  if 0 < nNumSuf then
    self.nSuffixIndex = 1
    for k, v in pairs(self.tbSuffix) do
      if v.nId == nSuf then
        self.nSuffixIndex = k
      end
    end
    self._mapNode.sv[2]:Init(nNumSuf, self, self.OnSuffixGridRefresh, self.OnSuffixGridClick)
  end
end

function FriendTitleCtrl:OnPrefixGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbPrefix[nIndex]
  local imgSelect = goGrid.transform:Find("btnGrid/AnimRoot/imgSelect").gameObject
  local txtPlayerTitle = goGrid.transform:Find("btnGrid/AnimRoot/txtPlayerTitle"):GetComponent("TMP_Text")
  local redDot = goGrid.transform:Find("btnGrid/AnimRoot/redDot").gameObject
  RedDotManager.RegisterNode(RedDotDefine.Friend_Title_Item, mapData.nId, redDot, nil, nil, true)
  imgSelect:SetActive(self.nPrefixIndex == nIndex)
  NovaAPI.SetTMPText(txtPlayerTitle, mapData.sDesc)
end

function FriendTitleCtrl:OnPrefixGridClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  if self.nPrefixIndex == nIndex then
    return
  end
  local mapData = self.tbPrefix[nIndex]
  if self.nPrefixIndex then
    local goSelect = self._mapNode.sv[1].transform:Find("Viewport/Content/" .. self.nPrefixIndex - 1)
    if goSelect then
      local imgSelect = goSelect.transform:Find("btnGrid/AnimRoot/imgSelect").gameObject
      imgSelect:SetActive(false)
    end
  end
  local imgSelect = goGrid.transform:Find("btnGrid/AnimRoot/imgSelect").gameObject
  imgSelect:SetActive(true)
  self.nPrefixIndex = nIndex
  NovaAPI.SetTMPText(self._mapNode.txtSelect[1], mapData.sDesc)
  RedDotManager.SetValid(RedDotDefine.Friend_Title_Item, mapData.nId, false)
end

function FriendTitleCtrl:OnSuffixGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbSuffix[nIndex]
  local imgSelect = goGrid.transform:Find("btnGrid/AnimRoot/imgSelect").gameObject
  local txtPlayerTitle = goGrid.transform:Find("btnGrid/AnimRoot/txtPlayerTitle"):GetComponent("TMP_Text")
  local redDot = goGrid.transform:Find("btnGrid/AnimRoot/redDot").gameObject
  RedDotManager.RegisterNode(RedDotDefine.Friend_Title_Item, mapData.nId, redDot, nil, nil, true)
  imgSelect:SetActive(self.nSuffixIndex == nIndex)
  NovaAPI.SetTMPText(txtPlayerTitle, mapData.sDesc)
end

function FriendTitleCtrl:OnSuffixGridClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  if self.nSuffixIndex == nIndex then
    return
  end
  local mapData = self.tbSuffix[nIndex]
  if self.nSuffixIndex then
    local goSelect = self._mapNode.sv[2].transform:Find("Viewport/Content/" .. self.nSuffixIndex - 1)
    if goSelect then
      local imgSelect = goSelect.transform:Find("btnGrid/AnimRoot/imgSelect").gameObject
      imgSelect:SetActive(false)
    end
  end
  local imgSelect = goGrid.transform:Find("btnGrid/AnimRoot/imgSelect").gameObject
  imgSelect:SetActive(true)
  self.nSuffixIndex = nIndex
  NovaAPI.SetTMPText(self._mapNode.txtSelect[2], mapData.sDesc)
  RedDotManager.SetValid(RedDotDefine.Friend_Title_Item, mapData.nId, false)
end

function FriendTitleCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function FriendTitleCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function FriendTitleCtrl:Close()
  for _, v in ipairs(self.tbPrefix) do
    RedDotManager.SetValid(RedDotDefine.Friend_Title_Item, v.nId, false)
  end
  for _, v in ipairs(self.tbSuffix) do
    RedDotManager.SetValid(RedDotDefine.Friend_Title_Item, v.nId, false)
  end
  self.gameObject:SetActive(false)
end

function FriendTitleCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
end

function FriendTitleCtrl:OnEnable()
end

function FriendTitleCtrl:OnDisable()
end

function FriendTitleCtrl:OnDestroy()
end

function FriendTitleCtrl:OnBtnClick_Cancel(btn)
  EventManager.Hit("FriendClosePop")
end

function FriendTitleCtrl:OnBtnClick_Confirm(btn)
  local function callback()
    EventManager.Hit("FriendClosePop")
    
    EventManager.Hit("FriendRefreshTitle")
  end
  
  PlayerData.Base:SendPlayerTitleEditReq(self.tbPrefix[self.nPrefixIndex].nId, self.tbSuffix[self.nSuffixIndex].nId, callback)
end

return FriendTitleCtrl
