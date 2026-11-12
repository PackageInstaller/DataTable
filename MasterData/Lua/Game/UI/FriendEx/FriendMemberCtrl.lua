local FriendMemberCtrl = class("FriendMemberCtrl", BaseCtrl)
FriendMemberCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_CoreMemberTitle"
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
  }
}
FriendMemberCtrl._mapEventConfig = {}

function FriendMemberCtrl:Open()
  self:Refresh()
  self:PlayInAni()
end

function FriendMemberCtrl:Refresh()
  self.tbTeam = PlayerData.Base:GetPlayerCoreTeam()
  local tbCur = {}
  for i = 1, 3 do
    if self.tbTeam[i] ~= 0 then
      tbCur[self.tbTeam[i]] = true
    end
  end
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  local tbAllChar = PlayerData.Char:GetDataForCharList()
  self.tbChar = {}
  for _, v in pairs(tbAllChar) do
    if not tbCur[v.nId] then
      table.insert(self.tbChar, v)
    end
  end
  table.sort(self.tbChar, function(a, b)
    return a.Rare < b.Rare or a.Rare == b.Rare and a.nId < b.nId
  end)
  for i = 3, 1, -1 do
    if self.tbTeam[i] ~= 0 then
      table.insert(self.tbChar, 1, tbAllChar[self.tbTeam[i]])
    end
  end
  local nAllCount = #self.tbChar
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._mapNode.svChar:Init(nAllCount, self, self.OnGridRefresh, self.OnGridBtnClick)
end

function FriendMemberCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbChar[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateCharCtrl")
  end
  self.tbGridCtrl[nInstanceID]:SetChar(mapData.nId)
  local imgCur1 = goGrid.transform:Find("btnGrid/AnimRoot/imgChose").gameObject
  local imgCur2 = goGrid.transform:Find("btnGrid/AnimRoot/imgChoseMask").gameObject
  local imgCur3 = goGrid.transform:Find("btnGrid/AnimRoot/imgChoseBg").gameObject
  local imgCur = goGrid.transform:Find("btnGrid/AnimRoot/imgChoseBg/txtSelected/imgSelectIndex"):GetComponent("Image")
  local txtSelect = goGrid.transform:Find("btnGrid/AnimRoot/imgChoseBg/txtSelected"):GetComponent("TMP_Text")
  for i = 1, 3 do
    if self.tbTeam[i] ~= 0 and self.tbTeam[i] == mapData.nId then
      imgCur1:SetActive(true)
      imgCur2:SetActive(true)
      imgCur3:SetActive(true)
      self:SetAtlasSprite(imgCur, "11_ico", "zs_team_select_" .. i)
      NovaAPI.SetTMPText(txtSelect, ConfigTable.GetUIText("HomePage_Selected"))
      break
    else
      imgCur1:SetActive(false)
      imgCur2:SetActive(false)
      imgCur3:SetActive(false)
    end
  end
end

function FriendMemberCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbChar[nIndex]
  local imgCur1 = goGrid.transform:Find("btnGrid/AnimRoot/imgChose").gameObject
  local imgCur2 = goGrid.transform:Find("btnGrid/AnimRoot/imgChoseMask").gameObject
  local imgCur3 = goGrid.transform:Find("btnGrid/AnimRoot/imgChoseBg").gameObject
  local imgCur = goGrid.transform:Find("btnGrid/AnimRoot/imgChoseBg/txtSelected/imgSelectIndex"):GetComponent("Image")
  local txtSelect = goGrid.transform:Find("btnGrid/AnimRoot/imgChoseBg/txtSelected"):GetComponent("TMP_Text")
  local nSelectIndex = 0
  for i = 1, 3 do
    if self.tbTeam[i] ~= 0 and self.tbTeam[i] == mapData.nId then
      nSelectIndex = i
      break
    end
  end
  if nSelectIndex == 0 then
    for i = 1, 3 do
      if self.tbTeam[i] == 0 then
        self.tbTeam[i] = mapData.nId
        imgCur1:SetActive(true)
        imgCur2:SetActive(true)
        imgCur3:SetActive(true)
        self:SetAtlasSprite(imgCur, "11_ico", "zs_team_select_" .. i)
        NovaAPI.SetTMPText(txtSelect, ConfigTable.GetUIText("HomePage_Selected"))
        break
      end
    end
  elseif nSelectIndex ~= 0 then
    self.tbTeam[nSelectIndex] = 0
    imgCur1:SetActive(false)
    imgCur2:SetActive(false)
    imgCur3:SetActive(false)
  end
end

function FriendMemberCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function FriendMemberCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function FriendMemberCtrl:Close()
  self.gameObject:SetActive(false)
end

function FriendMemberCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
  self.tbGridCtrl = {}
end

function FriendMemberCtrl:OnEnable()
end

function FriendMemberCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function FriendMemberCtrl:OnDestroy()
end

function FriendMemberCtrl:OnBtnClick_Cancel(btn)
  EventManager.Hit("FriendClosePop")
end

function FriendMemberCtrl:OnBtnClick_Confirm(btn)
  local function callback()
    EventManager.Hit("FriendClosePop")
    
    EventManager.Hit("FriendRefreshMember")
  end
  
  PlayerData.Base:SendPlayerCharsShowReq(self.tbTeam, callback)
end

return FriendMemberCtrl
