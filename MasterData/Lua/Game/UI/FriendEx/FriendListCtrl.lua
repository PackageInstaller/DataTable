local FriendListCtrl = class("FriendListCtrl", BaseCtrl)
FriendListCtrl._mapNodeConfig = {
  imgEmptyBg = {},
  txtEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_ListNone"
  },
  srFriendList = {
    sComponentName = "LoopScrollView"
  },
  txtFriendCount = {sComponentName = "TMP_Text"},
  btnGetAll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GetAll"
  },
  btnSendAll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SendAll"
  },
  txtGetAll = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Get"
  },
  txtSendAll = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Send"
  },
  txtToday = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Today"
  },
  txtEnergyCount = {sComponentName = "TMP_Text"},
  imgTodayEnergy = {sComponentName = "Image"},
  btnSwitch = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Switch"
  },
  SwitchOn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Open"
  },
  SwitchOff = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Close"
  },
  goSwitch = {},
  redDotGetAll = {}
}
FriendListCtrl._mapEventConfig = {
  FriendRefreshList = "RefreshList",
  FriendRefreshEnergy = "RefreshEnergy"
}
FriendListCtrl._mapRedDotConfig = {
  [RedDotDefine.Friend_Energy] = {
    sNodeName = "redDotGetAll"
  }
}

function FriendListCtrl:Refresh()
  self.bOperating = false
  self:RefreshSwitch()
  self:ChangeShow(false)
  
  local function callback()
    self:ChangeShow(true)
    self:RefreshList()
    self:RefreshEnergy()
  end
  
  PlayerData.Friend:SendFriendListGetReq(callback)
end

function FriendListCtrl:ChangeShow(bShow)
  self._mapNode.btnGetAll.gameObject:SetActive(bShow)
  self._mapNode.btnSendAll.gameObject:SetActive(bShow)
  self._mapNode.goSwitch.gameObject:SetActive(bShow)
end

function FriendListCtrl:RefreshSwitch()
  self._mapNode.btnSwitch[1].gameObject:SetActive(not self.bOperating)
  self._mapNode.btnSwitch[2].gameObject:SetActive(self.bOperating)
end

function FriendListCtrl:RefreshEnergy()
  NovaAPI.SetTMPText(self._mapNode.txtEnergyCount, PlayerData.Friend:GetEnergyCount() .. "/" .. self.nMaxEnergy)
  local itemInfo = ConfigTable.GetData_Item(AllEnum.CoinItemId.Energy)
  if itemInfo then
    self:SetPngSprite(self._mapNode.imgTodayEnergy, itemInfo.Icon)
  end
end

function FriendListCtrl:RefreshList()
  local nFriendNum = PlayerData.Friend:GetFriendListNum()
  self._mapNode.srFriendList.gameObject:SetActive(0 < nFriendNum)
  self._mapNode.imgEmptyBg:SetActive(nFriendNum == 0)
  if 0 < nFriendNum then
    for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[nInstanceId] = nil
    end
    self.tbFriendList = PlayerData.Friend:GetFriendListData()
    self._mapNode.srFriendList:Init(nFriendNum, self, self.OnGridRefresh, nil, true)
  end
  NovaAPI.SetTMPText(self._mapNode.txtFriendCount, nFriendNum .. "/" .. ConfigTable.GetConfigNumber("FriendMax"))
end

function FriendListCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapFriend = self.tbFriendList[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.FriendEx.FriendGridCtrl")
  end
  self.tbGridCtrl[nInstanceID]:SetType(self.bOperating and 1 or 4)
  self.tbGridCtrl[nInstanceID]:Refresh(mapFriend)
end

function FriendListCtrl:Awake()
  self.tbGridCtrl = {}
  self.nMaxEnergy = ConfigTable.GetConfigNumber("FriendReceiveEnergyMax")
end

function FriendListCtrl:OnEnable()
end

function FriendListCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function FriendListCtrl:OnDestroy()
end

function FriendListCtrl:OnBtnClick_GetAll()
  local nCount = PlayerData.Friend:GetEnergyCount()
  if nCount >= self.nMaxEnergy then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_MaxGet"))
    return
  end
  if not PlayerData.Friend:JudgeEnergyGetAble() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_GetFail"))
    return
  end
  
  local function callback(UIds)
    if #UIds == 0 then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_GetFail"))
    else
      self:RefreshEnergy()
      if not self.bOperating then
        self:RefreshList()
      end
    end
  end
  
  PlayerData.Friend:SendFriendReceiveEnergyReq({}, callback)
end

function FriendListCtrl:OnBtnClick_SendAll()
  if not PlayerData.Friend:JudgeEnergySendAble() then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_SendFail"))
    return
  end
  
  local function callback(UIds)
    if #UIds == 0 then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_SendFail"))
    else
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Tips,
        bPositive = true,
        sContent = ConfigTable.GetUIText("Friend_SendAllSuc")
      })
      if not self.bOperating then
        self:RefreshList()
      end
    end
  end
  
  PlayerData.Friend:SendFriendSendEnergyReq({}, callback)
end

function FriendListCtrl:OnBtnClick_Switch(btn, nIndex)
  self.bOperating = nIndex == 1
  self:RefreshSwitch()
  self:RefreshList()
end

return FriendListCtrl
