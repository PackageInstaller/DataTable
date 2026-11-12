local BaseCtrl = require("GameCore.UI.BaseCtrl")
local DispatchCtrl = class("DispatchCtrl", BaseCtrl)
local DispatchData = PlayerData.Dispatch
local ChoseTextColor = Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764)
local UnChoseTextColor = Color(0.7098039215686275, 0.7647058823529411, 0.8156862745098039)
local EmergencyColor = Color(0.7529411764705882, 0.13333333333333333, 0.19215686274509805)
local tabWidth = 271.5
local tabAreaTotalWidth = 1757.5
local nTabWeek = 1
DispatchCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  loopsvArea = {
    sNodeName = "svArea",
    sComponentName = "LoopScrollView"
  },
  loopsvDispatch = {
    sNodeName = "svDispatch",
    sComponentName = "LoopScrollView"
  },
  btnReceiveAll = {
    sNodeName = "btnReceiveAll",
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReceiveAll"
  },
  btnCantReceiveAll = {
    sNodeName = "btnCantReceiveAll"
  },
  dispatchInfoCtrl = {
    sNodeName = "goDispatchInfo",
    sCtrlName = "Game.UI.Dispatch.DispatchDetialInfoCtrl"
  },
  txtDipatchLimit = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dispatch_Count_Limit"
  },
  txtDispatchCurCount = {
    sNodeName = "txtDipatchCurCount",
    sComponentName = "TMP_Text"
  },
  goSelectList = {
    sNodeName = "goSelectList",
    sComponentName = "GameObject"
  },
  goCharList = {sNodeName = "goCharList", sComponentName = "GameObject"},
  loopsvCharList = {
    sNodeName = "svCharList",
    sComponentName = "LoopScrollView"
  },
  btnCloseSelectPanel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SelectPanel"
  },
  btnOneClickSelection = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OneClickSelection"
  },
  goResultCtrl = {
    sNodeName = "goResult",
    sCtrlName = "Game.UI.Dispatch.DispatchResultCtrl"
  },
  t_fullscreen_blur_blue = {},
  goStartDispatch = {
    sNodeName = "goStartDispatch",
    sComponentName = "GameObject"
  },
  rectAreaList = {
    sNodeName = "svArea",
    sComponentName = "RectTransform"
  },
  snapshot = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseResult"
  },
  txtInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Special_Agent_Notice"
  },
  panelAnimator = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  imgiconAnim = {sComponentName = "Animator"},
  animSelectList = {
    sNodeName = "goSelectList",
    sComponentName = "Animator"
  },
  goMask = {},
  t_fullscreen_blur_blue_1 = {},
  txtInfoTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Agent_Tilte_Info"
  },
  txtConsignorTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Agent_Consignor_Title"
  },
  txtBtnOneClickSelection = {
    sComponentName = "TMP_Text",
    sLanguageId = "Agent_OneClick_Selection"
  },
  txtNoticeClick = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Close_Tip"
  },
  txtBtnReceiveAll = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mail_OneKeyReceive"
  },
  txtBtnCantReceiveAll = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mail_OneKeyReceive"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Btn_Back"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "Agent_Again"
  },
  txtAgainGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Agent_Again"
  },
  bg = {sNodeName = "----Bg----", sComponentName = "Image"}
}
DispatchCtrl._mapEventConfig = {
  [EventId.DispatchOpenBuildList] = "OnEvent_OpenBuildList",
  [EventId.DispatchOpenCharList] = "OnEvent_OpenCharList",
  [EventId.DispatchCloseResultPanel] = "OnEvent_CloseResultPanel",
  [EventId.DispatchReceiveReward] = "OnEvent_ReceiveReward",
  [EventId.DispatchRefreshPanel] = "OnEvent_RefreshPanel",
  UpdateDispatchData = "RefreshPanel",
  DispatchAvgEnd = "OnEvent_DispatchAvgEnd",
  Dispatch_OneClickSelection = "OnEvent_OneClickSelect"
}
local QualityColor = {
  [1] = Color(0.8117647058823529, 0.8352941176470589, 0.8588235294117647),
  [2] = Color(0.803921568627451, 0.8549019607843137, 0.788235294117647),
  [3] = Color(0.7450980392156863, 0.8549019607843137, 0.9137254901960784)
}

function DispatchCtrl:Awake()
  self:InitData()
  NovaAPI.SetImageSpriteAsset(self._mapNode.bg, self:GetPngSprite("Image/UIBG/bg_agent"))
end

function DispatchCtrl:OnEnable()
  self.tbTabGrid = {}
  self.tbDispatchGrid = {}
  self.tbGridData = {}
  self.TempCharList = {}
  self.TempBuildId = -1
  self.curDispatchTab = self.tbDispatchTab[1]
  self.curChoseDispatchId = self.tbDispatchList[self.curDispatchTab][1]
  self._refreshTimeCountDown = {}
  self:RefreshPanel()
end

function DispatchCtrl:FadeIn()
  EventManager.Hit(EventId.SetTransition)
  self._mapNode.panelAnimator:Play("Dispatch_in")
  self._mapNode.imgiconAnim:Play("temporarily_logo")
end

function DispatchCtrl:OnDisable()
end

function DispatchCtrl:InitData()
  self.tbDispatchTab = {}
  local tbTabData = DispatchData.GetAllTabData()
  self.tbDispatchList = DispatchData.GetAllDispatchItemList()
  self.tabCount = 0
  for k, v in pairs(tbTabData) do
    if v ~= nTabWeek or self.tbDispatchList[v] ~= nil and #self.tbDispatchList[v] ~= 0 then
      table.insert(self.tbDispatchTab, v)
      self.tabCount = self.tabCount + 1
    end
  end
  self:SortDispatchList()
end

function DispatchCtrl:SortDispatchList()
  for k, v in pairs(self.tbDispatchList) do
    table.sort(v, function(a, b)
      local unLockA, txtA, conditionLevelA = DispatchData.CheckDispatchItemUnlock(a)
      local unLockB, txtB, conditionLevelB = DispatchData.CheckDispatchItemUnlock(b)
      if unLockA ~= unLockB then
        if unLockA == true then
          return true
        else
          return false
        end
      end
      if unLockA == false and unLockA == unLockB then
        return conditionLevelA < conditionLevelB
      end
      local stateA = DispatchData.GetDispatchState(a)
      local stateB = DispatchData.GetDispatchState(b)
      if stateA ~= stateB and (stateA == AllEnum.DispatchState.Complete or stateB == AllEnum.DispatchState.Complete) then
        return stateA == AllEnum.DispatchState.Complete
      end
      local dispatchDataA = ConfigTable.GetData("Agent", a)
      local dispatchDataB = ConfigTable.GetData("Agent", b)
      if dispatchDataA.Sort ~= dispatchDataB.Sort then
        return dispatchDataA.Sort < dispatchDataB.Sort
      end
      return b < a
    end)
  end
end

function DispatchCtrl:RefreshPanel()
  NovaAPI.SetTMPText(self._mapNode.txtDispatchCurCount, DispatchData.GetAccpectingDispatchCount() .. "/" .. ConfigTable.GetConfigValue("AgentMaximumQuantity"))
  self:InitData()
  if table.indexof(self.tbDispatchTab, self.curDispatchTab) <= 0 then
    self.curDispatchTab = self.tbDispatchTab[1]
  end
  self:RefreshTab()
  self:RefreshDispatchList(self.curDispatchTab)
  self:RefreshReceveAllState()
end

function DispatchCtrl:RefreshTab()
  local delayTime = 0.01
  self:AddTimer(1, delayTime, function()
    if self.bInitTab ~= true then
      self._mapNode.loopsvArea:SetAnim(0.01)
    end
    self._mapNode.loopsvArea:Init(self.tabCount, self, self.RefreshAreaTabGrid)
    self.bInitTab = true
  end, true, true, true)
  local data = ConfigTable.GetData("AgentTab", self.curDispatchTab)
  self._mapNode.txtInfo.gameObject:SetActive(data.SpTag)
end

function DispatchCtrl:RefreshAreaTabGrid(grid, index)
  index = index + 1
  local tabData = ConfigTable.GetData("AgentTab", self.tbDispatchTab[index])
  local btnGrid = grid.transform:Find("btnGrid"):GetComponent("UIButton")
  local animTrans = grid.transform:Find("btnGrid/AnimRoot")
  local goSelect = animTrans:Find("goSelect")
  local goUnSelect = animTrans:Find("goUnSelect")
  local goLock = animTrans:Find("goLock")
  local imgAreaIcon = animTrans:Find("imgAreaIcon"):GetComponent("Image")
  local bUnLock, condition = DispatchData.CheckTabUnlock(tabData.Id, self.tbDispatchList[tabData.Id])
  local bLock = not bUnLock
  local redDot = animTrans:Find("tabReddot")
  local nInstanceId = grid:GetInstanceID()
  if self.tbTabGrid[nInstanceId] == nil then
    self.tbTabGrid[nInstanceId] = grid
  end
  RedDotManager.RegisterNode(RedDotDefine.Dispatch_Tab, self.tbDispatchTab[index], redDot, nil, nil, true)
  local bSelected = self.curDispatchTab ~= nil and self.curDispatchTab > 0 and self.curDispatchTab == tabData.Id
  goSelect.gameObject:SetActive(not bLock and bSelected)
  goUnSelect.gameObject:SetActive(not bSelected)
  goLock.gameObject:SetActive(bLock)
  local txtUnSelect = goUnSelect:Find("txtUnSelect"):GetComponent("TMP_Text")
  local txtSelect = goSelect:Find("txtSelect"):GetComponent("TMP_Text")
  self:SetPngSprite(imgAreaIcon, tabData.Bg)
  NovaAPI.SetTMPText(txtUnSelect, tabData.Name)
  NovaAPI.SetTMPText(txtSelect, tabData.Name)
  btnGrid.onClick:RemoveAllListeners()
  btnGrid.onClick:AddListener(function()
    if bLock then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Agent_Tab_Unlock"))
      return
    else
      self:OnClickDispatchTab(grid)
    end
  end)
end

function DispatchCtrl:RefreshDispatchList(tab, lastTabIndex)
  local dispatchList = self.tbDispatchList[tab]
  if dispatchList == nil then
    return
  end
  local count = 0
  local hasCurSelectDispatch = false
  for i = 1, #dispatchList do
    count = count + 1
    if self.curChoseDispatchId == dispatchList[i] then
      hasCurSelectDispatch = true
    end
  end
  if not hasCurSelectDispatch and 1 <= count then
    self.curChoseDispatchId = dispatchList[1]
  end
  self:SortDispatchList()
  lastTabIndex = lastTabIndex or 0
  if 0 < lastTabIndex then
  end
  self.tbDispatchGrid = {}
  self.tbGridData = {}
  if self.bDontSetAnim ~= true then
    self._mapNode.loopsvDispatch:SetAnim(0.07)
  end
  self.bDontSetAnim = false
  self._mapNode.loopsvDispatch:Init(count, self, self.RefreshDispatchGrid)
  self._mapNode.dispatchInfoCtrl:Refresh(self.curChoseDispatchId)
end

function DispatchCtrl:RefreshDispatchGrid(goGrid, index)
  if self._mapNode == nil then
    return
  end
  index = index + 1
  local dispatchData = ConfigTable.GetData("Agent", self.tbDispatchList[self.curDispatchTab][index])
  if dispatchData == nil then
    return
  end
  local btnGrid = goGrid.transform:Find("btnGrid"):GetComponent("UIButton")
  local animRoot = btnGrid.transform:Find("AnimRoot")
  local goImgSelect = animRoot:Find("goSelecet").gameObject
  local txtTitleSelect = animRoot:Find("goGridInfo/txtTitleSelect"):GetComponent("TMP_Text")
  local txtTitleUnSelect = animRoot:Find("goGridInfo/txtTitleUnSelect"):GetComponent("TMP_Text")
  local txtTime = animRoot:Find("goGridInfo/goTime/txtTime"):GetComponent("TMP_Text")
  local goDone = animRoot:Find("goGridInfo/goDone").gameObject
  local goTime = animRoot:Find("goGridInfo/goTime").gameObject
  local goLock = animRoot:Find("goGridInfo/goLock").gameObject
  local goLockUnSelect = animRoot:Find("goGridInfo/goLockUnSelect").gameObject
  local imgBg = animRoot:Find("imgBg").gameObject
  local imgQuality = animRoot:Find("imgQuality"):GetComponent("Image")
  imgQuality.color = QualityColor[dispatchData.Quality]
  imgQuality.gameObject:SetActive(dispatchData.Id ~= self.curChoseDispatchId)
  local goExigency = animRoot:Find("imgExigency")
  local gridRedDot = animRoot:Find("gridRedDot")
  local txtDone = goDone.transform:Find("txtDone"):GetComponent("TMP_Text")
  local nInstanceId = goGrid:GetInstanceID()
  self.tbDispatchGrid[nInstanceId] = goGrid
  self.tbGridData[nInstanceId] = dispatchData.Id
  RedDotManager.RegisterNode(RedDotDefine.Dispatch_Reward, {
    dispatchData.Tab,
    dispatchData.Id
  }, gridRedDot, nil, nil, true)
  local bIsChosen = self.curChoseDispatchId ~= nil and self.curChoseDispatchId == dispatchData.Id
  imgBg:SetActive(not bIsChosen)
  goImgSelect:SetActive(bIsChosen)
  NovaAPI.SetTMPText(txtTitleSelect, dispatchData.Note)
  NovaAPI.SetTMPText(txtTitleUnSelect, dispatchData.Note)
  txtTitleSelect.gameObject:SetActive(bIsChosen)
  txtTitleUnSelect.gameObject:SetActive(not bIsChosen)
  local state = DispatchData.GetDispatchState(dispatchData.Id)
  local txtState = ""
  local AllData = DispatchData.GetAllDispatchingData()
  if self._refreshTimeCountDown[nInstanceId] ~= nil then
    self._refreshTimeCountDown[nInstanceId]:Cancel()
    self._refreshTimeCountDown[nInstanceId] = nil
  end
  if state == AllEnum.DispatchState.Accepting then
    local data = AllData[dispatchData.Id].Data
    if data ~= nil then
      local nRemainTime = data.StartTime + data.ProcessTime * 60 - CS.ClientManager.Instance.serverTimeStamp
      txtState = orderedFormat(ConfigTable.GetUIText("Agent_Delegate_Now") or "", timeFormat_HMS(nRemainTime))
    end
    self._refreshTimeCountDown[nInstanceId] = self:AddTimer(0, 1, function()
      local nRemainTime = data.StartTime + data.ProcessTime * 60 - CS.ClientManager.Instance.serverTimeStamp
      if goGrid ~= nil and txtTime ~= nil then
        if 0 <= nRemainTime then
          txtState = orderedFormat(ConfigTable.GetUIText("Agent_Delegate_Now") or "", timeFormat_HMS(nRemainTime))
          NovaAPI.SetTMPText(txtTime, txtState)
        else
          goTime:SetActive(false)
          goDone:SetActive(true)
          if self._refreshTimeCountDown[nInstanceId] ~= nil then
            self._refreshTimeCountDown[nInstanceId]:Cancel()
            self._refreshTimeCountDown[nInstanceId] = nil
          end
          self._mapNode.btnReceiveAll.gameObject:SetActive(true)
          self._mapNode.btnCantReceiveAll.gameObject:SetActive(false)
          RedDotManager.SetValid(RedDotDefine.Dispatch_Reward, {
            dispatchData.Tab,
            dispatchData.Id
          }, true)
        end
      elseif self._refreshTimeCountDown[nInstanceId] ~= nil then
        self._refreshTimeCountDown[nInstanceId]:Cancel()
        self._refreshTimeCountDown[nInstanceId] = nil
      end
    end, true, true, true)
    NovaAPI.SetTMPText(txtTime, txtState)
  end
  local bUnLock, lockTxt = PlayerData.Dispatch.CheckDispatchItemUnlock(dispatchData.Id)
  goLock:SetActive(not bUnLock and self.curChoseDispatchId == dispatchData.Id)
  goLockUnSelect:SetActive(not bUnLock and self.curChoseDispatchId ~= dispatchData.Id)
  goDone:SetActive(state == AllEnum.DispatchState.Complete and bUnLock)
  goTime:SetActive(state == AllEnum.DispatchState.Accepting and bUnLock)
  if not bUnLock then
    local txtLock = goLock.transform:Find("txtLock"):GetComponent("TMP_Text")
    local txtLockUnSelect = goLockUnSelect.transform:Find("txtLock"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtLock, lockTxt)
    NovaAPI.SetTMPText(txtLockUnSelect, lockTxt)
  end
  NovaAPI.SetTMPText(txtDone, ConfigTable.GetUIText("Quest_Complete"))
  RedDotManager.SetValid(RedDotDefine.Dispatch_Reward, {
    dispatchData.Tab,
    dispatchData.Id
  }, state == AllEnum.DispatchState.Complete)
  local tabData = ConfigTable.GetData("AgentTab", dispatchData.Tab)
  goExigency.gameObject:SetActive(tabData.SpTag)
  btnGrid.onClick:RemoveAllListeners()
  btnGrid.onClick:AddListener(function()
    self:OnClickDispatchItem(goGrid, index)
  end)
end

function DispatchCtrl:RefreshReceveAllState()
  local hasComplete = false
  local minRemainTime = 0
  for k, v in pairs(DispatchData.GetAllDispatchingData()) do
    if v.State == AllEnum.DispatchState.Complete then
      hasComplete = true
      break
    elseif v.State == AllEnum.DispatchState.Accepting then
      local remainTime = v.Data.StartTime + v.Data.ProcessTime * 60 - CS.ClientManager.Instance.serverTimeStamp
      if minRemainTime ~= 0 then
        minRemainTime = math.min(minRemainTime, remainTime)
      else
        minRemainTime = remainTime
      end
    end
  end
  self._mapNode.btnReceiveAll.gameObject:SetActive(hasComplete)
  self._mapNode.btnCantReceiveAll.gameObject:SetActive(not hasComplete)
  if not hasComplete and 0 < minRemainTime then
    self:AddTimer(1, minRemainTime, function()
      self._mapNode.btnReceiveAll.gameObject:SetActive(true)
      self._mapNode.btnCantReceiveAll.gameObject:SetActive(false)
    end, true, true, true)
  end
end

function DispatchCtrl:RefreshSelectListData(bBuild, dispatchId)
  if bBuild then
    local function GetDataCallback(tbBuildData, mapAllBuild)
      self._mapAllBuild = mapAllBuild
      
      self._tbAllBuild = tbBuildData
    end
  else
    local allChar = PlayerData.Char:GetDataForCharList()
    self.tbCharList = {}
    for k, v in pairs(allChar) do
      table.insert(self.tbCharList, {
        Id = v.nId,
        Level = v.Level
      })
    end
    self:SortCharList(dispatchId)
    self.curChoseDispatchId = dispatchId
    self._mapNode.loopsvCharList:Init(#self.tbCharList, self, self.RefreshCharGrid)
  end
end

function DispatchCtrl:RefreshSelectList(bBuild, dispatchId)
  self._mapNode.goSelectList:SetActive(true)
  self._mapNode.btnCloseSelectPanel.gameObject:SetActive(true)
  self._mapNode.goCharList:SetActive(not bBuild)
  self:RefreshSelectListData(bBuild, dispatchId)
end

function DispatchCtrl:RefreshCharGrid(goGrid, gridIndex)
  local index = gridIndex + 1
  local btnGrid = goGrid.transform:Find("btnGrid"):GetComponent("UIButton")
  local transRoot = goGrid.transform:Find("btnGrid/AnimRoot")
  local tcChar = transRoot:Find("charInfo")
  local imgItemIcon = tcChar:Find("imgIconBg/imgItemIcon"):GetComponent("Image")
  local imgItemRare = tcChar:Find("imgItemRare"):GetComponent("Image")
  local imgElement = tcChar:Find("imgElement"):GetComponent("Image")
  local imgClassBg = tcChar:Find("imgClassBg"):GetComponent("Image")
  local txtCharClass = tcChar:Find("imgClassBg/txtCharClass"):GetComponent("TMP_Text")
  local txtCharName = tcChar:Find("txtCharName"):GetComponent("TMP_Text")
  local txtRank = tcChar:Find("txtCharName/imgRankBg/txtRank"):GetComponent("TMP_Text")
  local mapChar = ConfigTable.GetData_Character(self.tbCharList[index].Id)
  local mapCharData = PlayerData.Char:GetCharDataByTid(self.tbCharList[index].Id)
  local nCharSkinId = mapCharData.nSkinId
  local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
  self:SetPngSprite(imgItemIcon, mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
  local nRarity = mapChar.Grade
  local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[nRarity == GameEnum.characterGrade.R and GameEnum.characterGrade.SR or nRarity]
  self:SetAtlasSprite(imgItemRare, "12_rare", sFrame, true)
  local sName = AllEnum.ElementIconType.Icon .. mapChar.EET
  self:SetAtlasSprite(imgElement, "12_rare", sName)
  if mapChar.Class == GameEnum.characterJobClass.Vanguard then
    self:SetAtlasSprite(imgClassBg, "08_db", "db_list_herald")
  elseif mapChar.Class == GameEnum.characterJobClass.Balance then
    self:SetAtlasSprite(imgClassBg, "08_db", "db_list_equal")
  elseif mapChar.Class == GameEnum.characterJobClass.Support then
    self:SetAtlasSprite(imgClassBg, "08_db", "db_list_assist")
  end
  NovaAPI.SetTMPText(txtCharClass, ConfigTable.GetUIText("Char_JobClass_" .. mapChar.Class))
  NovaAPI.SetTMPText(txtCharName, mapChar.Name)
  local nLv = PlayerData.Char:GetCharLv(self.tbCharList[index].Id)
  NovaAPI.SetTMPText(txtRank, nLv)
  local state = DispatchData.GetCharOrBuildState(self.tbCharList[index].Id)
  local data = ConfigTable.GetData("Agent", self.curChoseDispatchId)
  local goSelect = transRoot:Find("goSelect")
  local imgSelectBg = transRoot:Find("imgSelectBg")
  local goCantSelect = transRoot:Find("goCantSelect")
  local txtSelecting = goSelect:Find("imgTitleBg/txtSelecting"):GetComponent("TMP_Text")
  local imgSelectIndex = goSelect:Find("imgTitleBg/txtSelecting/imgSelectIndex"):GetComponent("Image")
  local txtState = goCantSelect:Find("imgTitleBg/txtState"):GetComponent("TMP_Text")
  local canSelect = state < AllEnum.DispatchState.Accepting and data.Level <= self.tbCharList[index].Level
  NovaAPI.SetTMPText(txtSelecting, ConfigTable.GetUIText("HomePage_Selected"))
  local bSelected = false
  local imgIndex = 1
  for k, v in ipairs(self.TempCharList) do
    if self.tbCharList[index].Id == v then
      bSelected = true
      imgIndex = k
    end
  end
  goCantSelect.gameObject:SetActive(not canSelect)
  if not canSelect then
    local condition = ""
    if state >= AllEnum.DispatchState.Accepting then
      condition = orderedFormat(ConfigTable.GetUIText("Agent_Delegate_Now") or "", "")
    end
    if data.Level > self.tbCharList[index].Level then
      condition = ConfigTable.GetUIText("Agent_Level_Limit")
    end
    NovaAPI.SetTMPText(txtState, condition)
  end
  goSelect.gameObject:SetActive(bSelected)
  imgSelectBg.gameObject:SetActive(bSelected)
  self:SetAtlasSprite(imgSelectIndex, "11_ico", "zs_team_select_" .. imgIndex)
  if bSelected then
    local bAdded = false
    for k, v in ipairs(self.tbChosenChars) do
      if self.tbCharList[index].Id == v.Id then
        bAdded = true
        break
      end
    end
    if not bAdded then
      table.insert(self.tbChosenChars, {
        Id = self.tbCharList[index].Id,
        Image = imgSelectIndex
      })
    end
  end
  local mapCharDescCfg = ConfigTable.GetData("CharacterDes", self.tbCharList[index].Id)
  for i = 1, 3 do
    local imgTag = transRoot:Find("imgTag" .. i)
    imgTag.gameObject:SetActive(mapCharDescCfg.Tag[i] ~= nil)
    if mapCharDescCfg.Tag[i] ~= nil then
      local txtTagName = imgTag:Find("txtTagName"):GetComponent("TMP_Text")
      local tagData = ConfigTable.GetData("CharacterTag", mapCharDescCfg.Tag[i])
      local imgMask = imgTag:Find("imgMask" .. i)
      imgMask.gameObject:SetActive(table.indexof(data.Tags, tagData.Id) <= 0 and 0 >= table.indexof(data.ExtraTags, tagData.Id))
      NovaAPI.SetTMPText(txtTagName, tagData.Title)
    end
  end
  btnGrid.onClick:RemoveAllListeners()
  btnGrid.onClick:AddListener(function()
    if canSelect then
      if table.indexof(self.TempCharList, self.tbCharList[index].Id) <= 0 then
        if #self.TempCharList < data.MemberLimit then
          table.insert(self.TempCharList, self.tbCharList[index].Id)
          goSelect.gameObject:SetActive(true)
          imgSelectBg.gameObject:SetActive(true)
          local selectIndex = #self.TempCharList
          self:SetAtlasSprite(imgSelectIndex, "11_ico", "zs_team_select_" .. selectIndex)
          if self.tbChosenChars == nil then
            self.tbChosenChars = {}
          end
          table.insert(self.tbChosenChars, {
            Id = self.tbCharList[index].Id,
            Image = imgSelectIndex
          })
        else
          EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Agent_Max_Char"))
        end
      else
        table.removebyvalue(self.TempCharList, self.tbCharList[index].Id)
        for i = #self.tbChosenChars, 1, -1 do
          if self.tbChosenChars[i].Id == self.tbCharList[index].Id then
            table.remove(self.tbChosenChars, i)
          elseif self.tbChosenChars[i].Image ~= nil then
            for j = 1, 3 do
              if self.TempCharList[j] == self.tbChosenChars[i].Id then
                self:SetAtlasSprite(self.tbChosenChars[i].Image, "11_ico", "zs_team_select_" .. j)
              end
            end
          end
        end
        goSelect.gameObject:SetActive(false)
        imgSelectBg.gameObject:SetActive(false)
      end
      self._mapNode.dispatchInfoCtrl:RefreshCharList(self.TempCharList)
    end
  end)
end

function DispatchCtrl:SortCharList(dispatchId)
  local data = ConfigTable.GetData("Agent", dispatchId)
  local needLevel = data.Level
  table.sort(self.tbCharList, function(a, b)
    local stateA = DispatchData.GetCharOrBuildState(a.Id)
    local stateB = DispatchData.GetCharOrBuildState(b.Id)
    if stateA ~= stateB then
      return stateA < stateB
    else
      if a.Level < needLevel or b.Level < needLevel then
        return a.Level > b.Level
      end
      local sameCountA = DispatchData.GetSameTagCount(dispatchId, false, a.Id, false)
      local sameCountB = DispatchData.GetSameTagCount(dispatchId, false, b.Id, false)
      if sameCountA ~= sameCountB then
        return sameCountA > sameCountB
      end
      sameCountA = DispatchData.GetSameTagCount(dispatchId, false, a.Id, true)
      sameCountB = DispatchData.GetSameTagCount(dispatchId, false, b.Id, true)
      if sameCountA ~= sameCountB then
        return sameCountA > sameCountB
      end
      if a.Level ~= b.Level then
        return a.Level > b.Level
      end
      return a.Id < b.Id
    end
  end)
end

function DispatchCtrl:RefreshBuildGrid(goGrid, gridIndex)
  local index = gridIndex + 1
  local btnGrid = goGrid.transform:Find("btnGrid"):GetComponent("UIButton")
  local transRoot = goGrid.transform:Find("btnGrid/AnimRoot")
  local goSelect = transRoot:Find("goSelectState")
  local goCantSelect = transRoot:Find("goCantSelectState")
  local txtState = goCantSelect:Find("txtState"):GetComponent("TMP_Text")
  local buildData = self._tbAllBuild[index]
  local dispatchData = ConfigTable.GetData("Agent", self.curChoseDispatchId)
  local canSelect = dispatchData.BuildScore <= buildData.nScore and DispatchData.GetCharOrBuildState(buildData.nBuildId) < AllEnum.DispatchState.Accepting
  local isSelect = self.TempBuildId == buildData.nBuildId
  goSelect.gameObject:SetActive(isSelect)
  goCantSelect.gameObject:SetActive(not canSelect)
  if isSelect then
    self.curSelectBuildGrid = goGrid
  end
  if not canSelect then
    local condition = ""
    if DispatchData.GetCharOrBuildState(buildData.nBuildId) >= AllEnum.DispatchState.Accepting then
      condition = orderedFormat(ConfigTable.GetUIText("Agent_Delegate_Now") or "", "")
    end
    if dispatchData.BuildScore > buildData.nScore then
      condition = ConfigTable.GetUIText("Agent_Scroe_Limit")
    end
    NovaAPI.SetTMPText(txtState, condition)
  end
  local imgRareScore = transRoot:Find("imgRareScore"):GetComponent("Image")
  local imgRareScoreBg = goCantSelect:Find("imgRareScoreBg"):GetComponent("Image")
  local imgRareScoreBgMask = goCantSelect:Find("imgRareScoreBgMask"):GetComponent("Image")
  local sScore = "Icon/BuildRank/BuildRank_" .. buildData.mapRank.Id
  self:SetPngSprite(imgRareScore, sScore)
  self:SetPngSprite(imgRareScoreBg, sScore)
  self:SetPngSprite(imgRareScoreBgMask, sScore)
  local txtBuildName = transRoot:Find("txtBuildName"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtBuildName, buildData.sName)
  local tcChar1 = transRoot:Find("imgLeaderBg")
  local tcChar2 = transRoot:Find("imgSubBg1")
  local tcChar3 = transRoot:Find("imgSubBg2")
  local tbChar = {
    tcChar1,
    tcChar2,
    tcChar3
  }
  for i = 1, 3 do
    local charTrans = tbChar[i]:Find("tc_char_03")
    local nCharTid = buildData.tbChar[i].nTid
    local imgCharIcon = charTrans:Find("imgIconBg/imgCharIcon" .. i):GetComponent("Image")
    local imgCharFrame = charTrans:Find("imgCharFrame" .. i):GetComponent("Image")
    local nCharSkinId = PlayerData.Char:GetCharSkinId(nCharTid)
    local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
    local mapCharCfg = ConfigTable.GetData_Character(nCharTid)
    local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
    self:SetPngSprite(imgCharIcon, mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
    self:SetAtlasSprite(imgCharFrame, "12_rare", sFrame)
    local mapCharDescCfg = ConfigTable.GetData("CharacterDes", nCharTid)
    for j = 1, 3 do
      local imgTag = tbChar[i]:Find("imgTag" .. j)
      imgTag.gameObject:SetActive(mapCharDescCfg.Tag[j] ~= nil)
      if mapCharDescCfg.Tag[j] ~= nil then
        local txtTagName = imgTag:Find("txtTagName"):GetComponent("TMP_Text")
        local tagData = ConfigTable.GetData("CharacterTag", mapCharDescCfg.Tag[j])
        NovaAPI.SetTMPText(txtTagName, tagData.Title)
      end
    end
  end
  btnGrid.onClick:RemoveAllListeners()
  btnGrid.onClick:AddListener(function()
    if canSelect then
      if self.TempBuildId ~= buildData.nBuildId then
        self.TempBuildId = buildData.nBuildId
        self._mapNode.dispatchInfoCtrl:RefreshCharList(buildData)
        if self.curSelectBuildGrid ~= nil then
          local transRoot = self.curSelectBuildGrid.transform:Find("btnGrid/AnimRoot")
          local selectObj = transRoot:Find("goSelectState")
          selectObj.gameObject:SetActive(false)
        end
        goSelect.gameObject:SetActive(true)
        self.curSelectBuildGrid = goGrid
      else
        self.TempBuildId = -1
        goSelect.gameObject:SetActive(false)
        self._mapNode.dispatchInfoCtrl:RefreshCharList(nil)
      end
    end
  end)
end

function DispatchCtrl:SortBuildList(dispatchId)
  local data = ConfigTable.GetData("Agent", dispatchId)
  local needRank = data.BuildScore
  table.sort(self._tbAllBuild, function(a, b)
    local stateA = DispatchData.GetCharOrBuildState(a.nBuildId)
    local stateB = DispatchData.GetCharOrBuildState(b.nBuildId)
    if stateA ~= stateB then
      return stateA < stateB
    end
    local sameCountA = DispatchData.GetSameTagCount(dispatchId, true, a.nBuildId, false)
    local sameCountB = DispatchData.GetSameTagCount(dispatchId, true, b.nBuildId, false)
    if sameCountA ~= sameCountB then
      return sameCountA > sameCountB
    end
    sameCountA = DispatchData.GetSameTagCount(dispatchId, true, a.nBuildId, true)
    sameCountB = DispatchData.GetSameTagCount(dispatchId, true, b.nBuildId, true)
    if sameCountA ~= sameCountB then
      return sameCountA > sameCountB
    end
    if a.mapRank.Id < needRank or b.mapRank.Id < needRank then
      return a.mapRank.Id > b.mapRank.Id
    end
    if a.mapRank.Id ~= b.mapRank.Id then
      return a.mapRank.Id > b.mapRank.Id
    end
    return a.nBuildId < b.nBuildId
  end)
end

function DispatchCtrl:OpenResultPanel(rewardData, performanceData)
  self._mapNode.t_fullscreen_blur_blue:SetActive(true)
  self.bDontSetAnim = true
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goMask:SetActive(true)
    self._mapNode.goResultCtrl.gameObject:SetActive(true)
    self:AddTimer(1, 1.99, function()
      if performanceData ~= nil and 0 < #performanceData then
        self._mapNode.t_fullscreen_blur_blue_1:SetActive(true)
      end
    end)
    CS.WwiseAudioManager.Instance:PlaySound("ui_dispatch_accept_successful")
    self:AddTimer(1, 1, function()
      CS.WwiseAudioManager.Instance:PlaySound("ui_roguelike_money_get")
    end, true, true, true)
    self._mapNode.panelAnimator:Play("Dispatch_goresult_in")
    self._mapNode.goResultCtrl:OpenPanel(rewardData, performanceData)
  end
  
  cs_coroutine.start(wait)
end

function DispatchCtrl:OnClickDispatchTab(grid)
  local bLock = false
  if bLock then
    return
  else
    for k, v in pairs(self.tbTabGrid) do
      local index = tonumber(v.name) + 1
      if self.curDispatchTab ~= nil and self.curDispatchTab > 0 and self.curDispatchTab == self.tbDispatchTab[index] then
        local goSelect = v.transform:Find("btnGrid/AnimRoot/goSelect")
        local goUnSelect = v.transform:Find("btnGrid/AnimRoot/goUnSelect")
        goSelect.gameObject:SetActive(false)
        goUnSelect.gameObject:SetActive(true)
      end
    end
    self.TempCharList = {}
    self.TempBuildId = -1
    local index = tonumber(grid.name) + 1
    local tabIndex = self.tbDispatchTab[index]
    local lastTabIndex = self.curDispatchTab
    self.curDispatchTab = tabIndex
    local goSelect = grid.transform:Find("btnGrid/AnimRoot/goSelect")
    local goUnSelect = grid.transform:Find("btnGrid/AnimRoot/goUnSelect")
    goSelect.gameObject:SetActive(true)
    goUnSelect.gameObject:SetActive(false)
    self.curChoseDispatchId = self.tbDispatchList[self.curDispatchTab][1]
    self:AddTimer(1, 0.2, function()
      self:RefreshDispatchList(tabIndex, lastTabIndex)
    end, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
    local data = ConfigTable.GetData("AgentTab", self.curDispatchTab)
    self._mapNode.txtInfo.gameObject:SetActive(data.SpTag)
    self._mapNode.imgiconAnim:Play("temporarily_logo")
    self._mapNode.panelAnimator:Play("Dispatch_switch_in")
  end
end

function DispatchCtrl:OnClickDispatchItem(grid)
  local index = tonumber(grid.name) + 1
  if self.curChoseDispatchId ~= nil and self.curChoseDispatchId > 0 and self.curChoseDispatchId == self.tbDispatchList[self.curDispatchTab][index] then
    return
  end
  self._mapNode.imgiconAnim:Play("temporarily_logo")
  self._mapNode.panelAnimator:Play("Dispatch_switch_in")
  for k, v in pairs(self.tbDispatchGrid) do
    if v ~= nil and type(tonumber(v.name)) == "number" then
      local goIndex = tonumber(v.name) + 1
      if self.curChoseDispatchId ~= nil and self.curChoseDispatchId > 0 and self.curChoseDispatchId == self.tbDispatchList[self.curDispatchTab][goIndex] then
        local goImgSelect = v.transform:Find("btnGrid/AnimRoot/goSelecet")
        local imgBg = v.transform:Find("btnGrid/AnimRoot/imgBg")
        local txtTitleSelect = v.transform:Find("btnGrid/AnimRoot/goGridInfo/txtTitleSelect")
        local txtTitleUnSelect = v.transform:Find("btnGrid/AnimRoot/goGridInfo/txtTitleUnSelect")
        local imgQuality = v.transform:Find("btnGrid/AnimRoot/imgQuality"):GetComponent("Image")
        goImgSelect.gameObject:SetActive(false)
        imgBg.gameObject:SetActive(true)
        txtTitleSelect.gameObject:SetActive(false)
        txtTitleUnSelect.gameObject:SetActive(true)
        imgQuality.gameObject:SetActive(true)
        local bUnlock = PlayerData.Dispatch.CheckDispatchItemUnlock(self.curChoseDispatchId)
        if not bUnlock then
          local goLock = v.transform:Find("btnGrid/AnimRoot/goGridInfo/goLock")
          local goLockUnSelect = v.transform:Find("btnGrid/AnimRoot/goGridInfo/goLockUnSelect")
          goLockUnSelect.gameObject:SetActive(true)
          goLock.gameObject:SetActive(false)
        end
        break
      end
    end
  end
  self.TempCharList = {}
  self.TempBuildId = -1
  self.curChoseDispatchId = self.tbDispatchList[self.curDispatchTab][index]
  local goImgSelect = grid.transform:Find("btnGrid/AnimRoot/goSelecet")
  local imgBg = grid.transform:Find("btnGrid/AnimRoot/imgBg")
  local txtTitleSelect = grid.transform:Find("btnGrid/AnimRoot/goGridInfo/txtTitleSelect")
  local txtTitleUnSelect = grid.transform:Find("btnGrid/AnimRoot/goGridInfo/txtTitleUnSelect")
  local imgQuality = grid.transform:Find("btnGrid/AnimRoot/imgQuality")
  imgQuality.gameObject:SetActive(false)
  goImgSelect.gameObject:SetActive(true)
  imgBg.gameObject:SetActive(false)
  txtTitleSelect.gameObject:SetActive(true)
  txtTitleUnSelect.gameObject:SetActive(false)
  local bUnlock = PlayerData.Dispatch.CheckDispatchItemUnlock(self.curChoseDispatchId)
  if not bUnlock then
    local goLock = grid.transform:Find("btnGrid/AnimRoot/goGridInfo/goLock")
    local goLockUnSelect = grid.transform:Find("btnGrid/AnimRoot/goGridInfo/goLockUnSelect")
    goLockUnSelect.gameObject:SetActive(false)
    goLock.gameObject:SetActive(true)
  end
  self:AddTimer(1, 0.2, function()
    self._mapNode.dispatchInfoCtrl:Refresh(self.tbDispatchList[self.curDispatchTab][index])
  end, true, true, true)
end

function DispatchCtrl:OnBtnClick_ReceiveAll()
  DispatchData.ReqReceiveReward(0)
end

function DispatchCtrl:OnBtnClick_SelectPanel()
  self._mapNode.animSelectList:Play("MatList_out")
  self:AddTimer(1, 0.2, function()
    self._mapNode.goSelectList:SetActive(false)
  end, true, true, true)
  self._mapNode.btnCloseSelectPanel.gameObject:SetActive(false)
  self._mapNode.dispatchInfoCtrl:OnCloseSelectPanel()
end

function DispatchCtrl:OnBtnClick_CloseStartDispatch()
  self._mapNode.goStartDispatch:SetActive(false)
  self._mapNode.goMask:SetActive(false)
  self._mapNode.t_fullscreen_blur_blue:SetActive(false)
  self._mapNode.txtNoticeClick.gameObject:SetActive(false)
end

function DispatchCtrl:OnBtnClick_CloseResult(...)
end

function DispatchCtrl:OnBtnClick_OneClickSelection()
  local data = ConfigTable.GetData("Agent", self.curChoseDispatchId)
  local tbCharTagList = {}
  if not self.bOpenBuild then
    for k, v in ipairs(self.tbCharList) do
      local canSelect = data.Level <= v.Level and DispatchData.GetCharOrBuildState(v.Id) < AllEnum.DispatchState.Accepting
      if canSelect then
        local mapCharDescCfg = ConfigTable.GetData("CharacterDes", v.Id)
        table.insert(tbCharTagList, {
          id = v.Id,
          tags = mapCharDescCfg.Tag
        })
      end
    end
  else
    for k, v in ipairs(self._tbAllBuild) do
      if v.nScore >= data.BuildScore then
        local allTag = {}
        for i = 1, 3 do
          if v.tbChar[i] ~= nil then
            local mapCharDescCfg = ConfigTable.GetData("CharacterDes", v.tbChar[i].nTid)
            for _, v1 in ipairs(mapCharDescCfg.Tag) do
              table.insert(allTag, v1)
            end
          end
        end
        table.insert(tbCharTagList, {
          id = v.nBuildId,
          tags = allTag
        })
      end
    end
  end
  local result = self:find_min_roles_greedy(tbCharTagList, data.Tags, data.ExtraTags)
  if result then
    if self.bOpenBuild then
    else
      self.tbChosenChars = {}
      if #result <= 3 then
        self.TempCharList = {}
        for k, v in pairs(result) do
          table.insert(self.TempCharList, v.id)
        end
        self._mapNode.loopsvCharList:Init(#self.tbCharList, self, self.RefreshCharGrid)
        self._mapNode.dispatchInfoCtrl:RefreshCharList(self.TempCharList)
      end
    end
  elseif self.bOpenBuild then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Agent_Non_Build"))
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Agent_Non_Char"))
  end
end

function DispatchCtrl:can_meet_requirements(role_tags, requirements)
  local tag_count = {}
  for _, tag in ipairs(role_tags) do
    tag_count[tag] = (tag_count[tag] or 0) + 1
  end
  for _, req in ipairs(requirements) do
    if not tag_count[req] or tag_count[req] <= 0 then
      return false
    else
      tag_count[req] = tag_count[req] - 1
    end
  end
  return true
end

function DispatchCtrl:concat_tags(selected_roles)
  local combined_tags = {}
  for _, role in ipairs(selected_roles) do
    for _, tag in ipairs(role.tags) do
      table.insert(combined_tags, tag)
    end
  end
  return combined_tags
end

function DispatchCtrl:enumerate_combinations(roles, count, callback)
  local n = #roles
  if count > n then
    return nil
  end
  local indices = {}
  for i = 1, count do
    indices[i] = i
  end
  while true do
    local combo = {}
    for i = 1, count do
      combo[i] = roles[indices[i]]
    end
    if callback(combo) then
      return combo
    end
    local pos = count
    while 1 <= pos and indices[pos] == n - count + pos do
      pos = pos - 1
    end
    if pos < 1 then
      break
    end
    indices[pos] = indices[pos] + 1
    for i = pos + 1, count do
      indices[i] = indices[i - 1] + 1
    end
  end
  return nil
end

function DispatchCtrl:find_min_roles_greedy(roles, normal_req, extra_req)
  if #roles == 0 then
    return nil
  end
  for count = 1, 3 do
    local result = self:enumerate_combinations(roles, count, function(combo)
      local tags = self:concat_tags(combo)
      return self:can_meet_requirements(tags, normal_req) and self:can_meet_requirements(tags, extra_req)
    end)
    if result then
      return result
    end
  end
  for count = 1, 3 do
    local result = self:enumerate_combinations(roles, count, function(combo)
      local tags = self:concat_tags(combo)
      return self:can_meet_requirements(tags, normal_req)
    end)
    if result then
      return result
    end
  end
  return nil
end

function DispatchCtrl:OnEvent_OpenBuildList(dispatchId)
  self.bOpenBuild = true
  self:RefreshSelectList(true, dispatchId)
end

function DispatchCtrl:OnEvent_OpenCharList(dispatchId)
  self.bOpenBuild = false
  self:RefreshSelectList(false, dispatchId)
end

function DispatchCtrl:OnEvent_CloseResultPanel(bDontNeedHideMask)
  if not bDontNeedHideMask then
    self._mapNode.t_fullscreen_blur_blue:SetActive(false)
    self._mapNode.goMask:SetActive(false)
  end
  self._mapNode.goStartDispatch:SetActive(false)
  self._mapNode.t_fullscreen_blur_blue_1:SetActive(false)
  self._mapNode.panelAnimator:Play("Dispatch_goresult_out")
  self:AddTimer(1, 0.17, function()
    self._mapNode.goResultCtrl.gameObject:SetActive(false)
  end, true, true, true)
end

function DispatchCtrl:OnEvent_DispatchAvgEnd()
  self._mapNode.t_fullscreen_blur_blue_1:SetActive(false)
end

function DispatchCtrl:OnEvent_ReceiveReward(rewardData, specialPerformanceData)
  self:OpenResultPanel(rewardData, specialPerformanceData)
end

function DispatchCtrl:OnEvent_RefreshPanel(changedState)
  if changedState == AllEnum.DispatchState.Accepting then
    self._mapNode.t_fullscreen_blur_blue:SetActive(true)
    self._mapNode.goStartDispatch:SetActive(true)
    self.bDontSetAnim = true
    self._mapNode.panelAnimator:Play("Dispatch_gostar_in")
    self:AddTimer(1, 2, function()
      self._mapNode.goStartDispatch:SetActive(false)
      self._mapNode.t_fullscreen_blur_blue:SetActive(false)
      self._mapNode.goMask:SetActive(false)
    end, true, true, true)
  end
  for k, v in pairs(self._refreshTimeCountDown) do
    v:Cancel()
  end
  self._refreshTimeCountDown = {}
  self.TempCharList = {}
  self.TempBuildId = 0
  self.tbTabGrid = {}
  self.tbDispatchGrid = {}
  self.tbGridData = {}
  self:RefreshPanel()
end

function DispatchCtrl:OnEvent_OneClickSelect(bBuild)
  self:RefreshSelectListData(bBuild, self.curChoseDispatchId)
  self:OnBtnClick_OneClickSelection()
end

return DispatchCtrl
