local FriendHeadCtrl = class("FriendHeadCtrl", BaseCtrl)
FriendHeadCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_SelectHead"
  },
  imgReviewHead = {sComponentName = "Image"},
  srHeadList = {
    sComponentName = "LoopScrollView"
  },
  txtReview = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_HeadReview"
  },
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txtSource = {
    sComponentName = "TMP_Text",
    sLanguageId = "ItemTips_GetWay"
  },
  imgSourceTip = {},
  txtSourceCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "ItemTips_GetWay"
  },
  txtSourceTip = {sComponentName = "TMP_Text"},
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
  }
}
FriendHeadCtrl._mapEventConfig = {}

function FriendHeadCtrl:Open()
  self:Refresh()
  self:PlayInAni()
end

function FriendHeadCtrl:Refresh()
  self.bTipsOpen = false
  self._mapNode.imgSourceTip:SetActive(self.bTipsOpen)
  self.tbHead = PlayerData.HeadData:GetPlayerHeadList()
  self.nSelectIndex = 1
  self.nCurHead = PlayerData.Base:GetPlayerHeadId()
  local nHeadNum = #self.tbHead
  if 0 < nHeadNum then
    self:SetPngSprite(self._mapNode.imgReviewHead, self.tbHead[1].mapCfg.Icon)
    self._mapNode.btnDetail.gameObject:SetActive(self.tbHead[1].mapCfg.Desc ~= "")
    NovaAPI.SetTMPText(self._mapNode.txtSourceTip, self.tbHead[1].mapCfg.Desc)
  end
  self._mapNode.srHeadList:Init(nHeadNum, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function FriendHeadCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbHead[nIndex]
  local imgHeadIcon = goGrid.transform:Find("btnGrid/AnimRoot/imgCharIcon"):GetComponent("Image")
  local imgCur1 = goGrid.transform:Find("btnGrid/AnimRoot/imgCur1").gameObject
  local imgCur2 = goGrid.transform:Find("btnGrid/AnimRoot/imgCur2").gameObject
  local txtCur = goGrid.transform:Find("btnGrid/AnimRoot/imgCur2/txtCur"):GetComponent("TMP_Text")
  local imgSelect = goGrid.transform:Find("btnGrid/AnimRoot/imgSelect").gameObject
  local imgLockMask = goGrid.transform:Find("btnGrid/AnimRoot/imgLockMask").gameObject
  local mapCfg = mapData.mapCfg
  self:SetPngSprite(imgHeadIcon, mapCfg.Icon)
  NovaAPI.SetTMPText(txtCur, ConfigTable.GetUIText("Friend_CurSelect"))
  imgSelect:SetActive(nIndex == self.nSelectIndex)
  imgCur1:SetActive(mapData.nId == self.nCurHead)
  imgCur2:SetActive(mapData.nId == self.nCurHead)
  imgLockMask:SetActive(mapData.nUnlock == 0)
  local redDot = goGrid.transform:Find("btnGrid/AnimRoot/redDot").gameObject
  RedDotManager.RegisterNode(RedDotDefine.Friend_Head_Item, mapData.nId, redDot, nil, nil, true)
end

function FriendHeadCtrl:OnGridBtnClick(goGrid, gridIndex)
  self.bTipsOpen = false
  self._mapNode.imgSourceTip:SetActive(self.bTipsOpen)
  local nIndex = gridIndex + 1
  local mapData = self.tbHead[nIndex]
  if self.nSelectIndex == nIndex then
    return
  end
  local imgSelected = goGrid.transform:Find("btnGrid/AnimRoot/imgSelect").gameObject
  imgSelected:SetActive(true)
  self:SetPngSprite(self._mapNode.imgReviewHead, mapData.mapCfg.Icon)
  self._mapNode.btnDetail.gameObject:SetActive(mapData.mapCfg.Desc ~= "")
  NovaAPI.SetTMPText(self._mapNode.txtSourceTip, mapData.mapCfg.Desc)
  local sPath = "Viewport/Content/" .. tostring(self.nSelectIndex - 1) .. "/btnGrid/AnimRoot/imgSelect"
  local goSelectHead = self._mapNode.srHeadList.transform:Find(sPath)
  if goSelectHead then
    goSelectHead.gameObject:SetActive(false)
  end
  self.nSelectIndex = nIndex
  RedDotManager.SetValid(RedDotDefine.Friend_Head_Item, mapData.nId, false)
end

function FriendHeadCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function FriendHeadCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function FriendHeadCtrl:Close()
  for _, v in ipairs(self.tbHead) do
    RedDotManager.SetValid(RedDotDefine.Friend_Head_Item, v.nId, false)
  end
  self.gameObject:SetActive(false)
end

function FriendHeadCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
  self.nSelectIndex = 1
  self.nEquipIndex = nil
  self.tbGridRedDot = {}
end

function FriendHeadCtrl:OnEnable()
end

function FriendHeadCtrl:OnDisable()
end

function FriendHeadCtrl:OnDestroy()
end

function FriendHeadCtrl:OnBtnClick_Cancel(btn)
  EventManager.Hit("FriendClosePop")
end

function FriendHeadCtrl:OnBtnClick_Confirm(btn)
  if self.tbHead[self.nSelectIndex].nId == self.nCurHead then
    EventManager.Hit("FriendClosePop")
    return
  end
  local mapData = self.tbHead[self.nSelectIndex]
  if mapData.nUnlock == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PlayerHead_Lock_Tip"))
    return
  end
  local nHeadIconId = mapData.nId
  
  local function callback()
    EventManager.Hit("FriendClosePop")
    EventManager.Hit("FriendRefreshHead")
  end
  
  PlayerData.HeadData:SendPlayerHeadIconSetReq(nHeadIconId, callback)
end

function FriendHeadCtrl:OnBtnClick_Detail()
  self.bTipsOpen = not self.bTipsOpen
  self._mapNode.imgSourceTip.gameObject:SetActive(self.bTipsOpen)
end

return FriendHeadCtrl
