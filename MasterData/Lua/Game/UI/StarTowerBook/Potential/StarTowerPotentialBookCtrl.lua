local StarTowerPotentialBookCtrl = class("StarTowerPotentialBookCtrl", BaseCtrl)
StarTowerPotentialBookCtrl._mapNodeConfig = {
  goCharList = {},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Potential_Title_01"
  },
  charLSV = {
    sComponentName = "LoopScrollView"
  },
  tab = {
    nCount = 7,
    sCtrlName = "Game.UI.TemplateEx.TemplateTabCtrl"
  },
  btnTab = {
    nCount = 7,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tab"
  },
  goPotentialList = {},
  txtCollectCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Collect"
  },
  txtCollectCount = {sComponentName = "TMP_Text"},
  btnReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  btnReceiveReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  txtCharName = {sComponentName = "TMP_Text"},
  imgChar = {sComponentName = "Image"},
  goAssist = {},
  goMain = {},
  goMainSelect = {},
  goAssistSelect = {},
  txtAssist = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Char_Assist"
  },
  txtMain = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Char_Main"
  },
  btnSwitch = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Switch"
  },
  txtBtnSwitch = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Potential_Switch"
  },
  animPage = {sNodeName = "imgBook", sComponentName = "Animator"},
  imgNormalTitle = {nCount = 2},
  imgSpecialTitle = {},
  txtNormalTitle = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Potential_Normal"
  },
  txtSpecialTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Potential_Special"
  },
  imgEmpty = {},
  btnLeft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Left"
  },
  btnRight = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Right"
  },
  goPotentialBookItem = {
    nCount = 8,
    sNodeName = "PotentialBookItem",
    sCtrlName = "Game.UI.StarTowerBook.Potential.PotentialBookItemCtrl"
  },
  btnItem = {
    nCount = 8,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  imgDotBg = {nCount = 8},
  imgDot = {nCount = 8},
  goLeftPotentialList = {},
  goRightPotentialList = {},
  goPotentialDetail = {},
  animDetail = {sNodeName = "goDetail", sComponentName = "Animator"},
  goBlur = {},
  goDetail = {},
  btnBg = {
    sComponentName = "Button",
    callback = "OnBtnClick_Bg"
  },
  potentialDetail = {
    sCtrlName = "Game.UI.StarTower.Potential.PotentialCardItemCtrl"
  },
  txtTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Close_Tip"
  },
  btnChangeDesc = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeDesc"
  },
  txtDescChange = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Change_Desc"
  },
  imgSwitchOn = {},
  imgSwitchOff = {},
  redDotReward = {},
  btnReceiveAllPotential = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReceiveAllPotential"
  },
  TMPReceiveAllPotentialTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Btn_ReceiveAll"
  }
}
StarTowerPotentialBookCtrl._mapEventConfig = {
  PotentialBookDataChange = "OnEvent_PotentialBookDataChange",
  ReceivePotentialBookReward = "OnEvent_ReceivePotentialBookReward"
}
StarTowerPotentialBookCtrl._mapRedDotConfig = {}
local char_sv_min_item_count = 8
local elementSort = {
  [1] = GameEnum.elementType.SE,
  [2] = GameEnum.elementType.FE,
  [3] = GameEnum.elementType.AE,
  [4] = GameEnum.elementType.WE,
  [5] = GameEnum.elementType.LE,
  [6] = GameEnum.elementType.DE
}

function StarTowerPotentialBookCtrl:ResetNewRedDot()
  if self.mapCurPotentialList ~= nil then
    for _, v in ipairs(self.mapCurPotentialList) do
      RedDotManager.SetValid(RedDotDefine.StarTowerBook_Potential_New, v.nId, false)
    end
  end
end

function StarTowerPotentialBookCtrl:Init()
  self.animRoot:Play("StarTowerBookPotential_in", 0, 0)
  CS.WwiseAudioManager.Instance:PlaySound("ui_rogueBook_page_drag")
  self.bPotentialList = false
  self._mapNode.goCharList.gameObject:SetActive(true)
  self._mapNode.goPotentialList.gameObject:SetActive(false)
  self._mapNode.goPotentialDetail.gameObject:SetActive(false)
  self._mapNode.goBlur.gameObject:SetActive(false)
  self:RefreshReceiveAllBtn()
  self.mapPotentialBrief = PlayerData.StarTowerBook:GetCharPotentialBriefBook()
  self:RefreshTab()
  for k, v in ipairs(self._mapNode.tab) do
    local imgLock = v.gameObject.transform:Find(string.format("btnTab%s/AnimRoot/imgLock", k))
    if self.tbTabs[k] ~= nil and self.tbTabs[k].Type ~= 0 then
      local nType = self.tbTabs[k].Type
      local nCount = 0
      for _, data in ipairs(self.mapPotentialBrief) do
        local mapCharCfg = ConfigTable.GetData_Character(data.nCharId)
        if mapCharCfg ~= nil and mapCharCfg.EET == nType then
          nCount = nCount + 1
          break
        end
      end
      self.tbTabs[k].Lock = nCount == 0
      imgLock.gameObject:SetActive(nCount == 0)
    else
      imgLock.gameObject:SetActive(false)
    end
  end
  self:RefreshCharList()
end

function StarTowerPotentialBookCtrl:Back()
  if self.bPotentialList then
    self:ResetNewRedDot()
    self._mapNode.goCharList.gameObject:SetActive(true)
    self._mapNode.goPotentialList.gameObject:SetActive(false)
    self._mapNode.goPotentialDetail.gameObject:SetActive(false)
    self._mapNode.goBlur.gameObject:SetActive(false)
    self.bPotentialList = false
    self:RefreshReceiveAllBtn()
  else
    EventManager.Hit("ChangeStarTowerBookPanel", AllEnum.StarTowerBookPanelType.Main)
  end
end

function StarTowerPotentialBookCtrl:InitTab()
  self.tbTabs = {}
  table.insert(self.tbTabs, {
    Sort = 0,
    Name = "StarTower_Book_Char_Tab_All",
    Type = 0,
    Lock = false
  })
  for k, v in ipairs(elementSort) do
    table.insert(self.tbTabs, {
      Sort = k,
      Name = "T_Element_Attr_" .. v,
      Type = v,
      Lock = false
    })
  end
  table.sort(self.tbTabs, function(a, b)
    return a.Sort < b.Sort
  end)
  for k, v in ipairs(self._mapNode.tab) do
    if self.tbTabs[k] ~= nil then
      v:SetText(ConfigTable.GetUIText(self.tbTabs[k].Name))
      if self.tbTabs[k].Type ~= 0 then
        local imgTab = v.gameObject.transform:Find(string.format("btnTab%s/AnimRoot/imgTab", k)):GetComponent("Image")
        local sName = AllEnum.ElementIconType.Icon .. self.tbTabs[k].Type
        self:SetAtlasSprite(imgTab, "12_rare", sName)
      end
      local redDot = v.gameObject.transform:Find(string.format("btnTab%s/AnimRoot/redDotTab", k))
      RedDotManager.RegisterNode(RedDotDefine.StarTowerBook_Potential_Element, self.tbTabs[k].Type, redDot.gameObject)
    end
  end
end

function StarTowerPotentialBookCtrl:RefreshCharList()
  self.mapCurChar = {}
  if self.nCurTab == 1 then
    self.mapCurChar = clone(self.mapPotentialBrief)
  else
    for _, v in ipairs(self.mapPotentialBrief) do
      local mapCharCfg = ConfigTable.GetData_Character(v.nCharId)
      if mapCharCfg ~= nil and mapCharCfg.EET == self.tbTabs[self.nCurTab].Type then
        table.insert(self.mapCurChar, v)
      end
    end
  end
  if #self.mapCurChar < char_sv_min_item_count then
    for i = #self.mapCurChar + 1, char_sv_min_item_count do
      table.insert(self.mapCurChar, {nCharId = 0})
    end
  end
  for nInstanceId, objCtrl in pairs(self.mapCharGrids) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapCharGrids[nInstanceId] = nil
  end
  self._mapNode.charLSV:Init(#self.mapCurChar, self, self.OnCharRefreshGrid, self.OnCharGridBtnClick, false, self.GetGridPageCount)
end

function StarTowerPotentialBookCtrl:OnCharRefreshGrid(goGrid, gridIndex)
  local nInstanceID = goGrid:GetInstanceID()
  if self.mapCharGrids[nInstanceID] == nil then
    self.mapCharGrids[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.StarTowerBook.Potential.PotentialBookCharItemCtrl")
  end
  local nIdx = gridIndex + 1
  local mapCharData = self.mapCurChar[nIdx]
  self.mapCharGrids[nInstanceID]:InitItem(mapCharData.nCharId, mapCharData.nCount, mapCharData.nAllCount)
end

function StarTowerPotentialBookCtrl:OnCharGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapCharData = self.mapCurChar[nIndex]
  if mapCharData.nCharId ~= 0 then
    if mapCharData.nUnlock == 0 then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_Book_Char_Lock_Tip"))
      return
    else
      self.nCharId = mapCharData.nCharId
      
      local function callback()
        self:InitPotentialList()
      end
      
      PlayerData.StarTowerBook:TryGetCharPotentialBook(mapCharData.nCharId, callback)
    end
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_Book_Char_Empty"))
  end
end

function StarTowerPotentialBookCtrl:RefreshTab()
  for k, v in ipairs(self._mapNode.tab) do
    local nState = self:GetTabState(k)
    v:SetSelect(k == self.nCurTab, nState)
    if k == self.nCurTab and 1 < k then
      self._mapNode.tab[k - 1]:SetLine(false)
    end
  end
end

function StarTowerPotentialBookCtrl:GetTabState(nCurTab)
  local nState = 2
  if nCurTab == 1 then
    nState = 1
  elseif nCurTab == #self.tbTabs then
    nState = 3
  end
  return nState
end

function StarTowerPotentialBookCtrl:InitPotentialList()
  self.animRoot:Play("StarTowerBookPotential_in1", 0, 0)
  CS.WwiseAudioManager.Instance:PlaySound("ui_rogueBook_char_menu")
  self.bPotentialList = true
  self._mapNode.goCharList.gameObject:SetActive(false)
  self._mapNode.goPotentialList.gameObject:SetActive(true)
  self._mapNode.goPotentialDetail.gameObject:SetActive(false)
  self._mapNode.goBlur.gameObject:SetActive(false)
  self._mapNode.btnReceiveAllPotential.gameObject:SetActive(false)
  local mapCharCfg = ConfigTable.GetData_Character(self.nCharId)
  if mapCharCfg ~= nil then
    RedDotManager.RegisterNode(RedDotDefine.StarTowerBook_Potential_Reward, {
      mapCharCfg.EET,
      self.nCharId
    }, self._mapNode.redDotReward)
    NovaAPI.SetTMPText(self._mapNode.txtCharName, mapCharCfg.Name)
    local nSkinId = mapCharCfg.DefaultSkinId
    local mapSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
    if mapSkin ~= nil then
      self:SetPngSprite(self._mapNode.imgChar, mapSkin.Icon .. AllEnum.CharHeadIconSurfix.XL)
    end
  end
  self.mapPotentialList = PlayerData.StarTowerBook:GetAllCharPotential(self.nCharId)
  local nCount, nAllCount = PlayerData.StarTowerBook:GetCharPotentialCount(self.nCharId)
  NovaAPI.SetTMPText(self._mapNode.txtCollectCount, string.format("%s/%s", nCount, nAllCount))
  self.bMasterPotential = true
  self.nCurPage = 0
  self:SwitchPotentialType()
  local bCanReceive = RedDotManager.GetValid(RedDotDefine.StarTowerBook_Potential_Reward, {
    mapCharCfg.EET,
    self.nCharId
  })
  self._mapNode.btnReward.gameObject:SetActive(not bCanReceive)
  self._mapNode.btnReceiveReward.gameObject:SetActive(bCanReceive)
end

function StarTowerPotentialBookCtrl:SwitchPotentialType()
  self._mapNode.goAssist.gameObject:SetActive(self.bMasterPotential)
  self._mapNode.goAssistSelect.gameObject:SetActive(not self.bMasterPotential)
  self._mapNode.goMain.gameObject:SetActive(not self.bMasterPotential)
  self._mapNode.goMainSelect.gameObject:SetActive(self.bMasterPotential)
  self.mapCurPotentialList = {}
  if self.bMasterPotential then
    for _, v in ipairs(self.mapPotentialList.MasterSpecificIds) do
      table.insert(self.mapCurPotentialList, v)
    end
    for _, v in ipairs(self.mapPotentialList.MasterNormalIds) do
      table.insert(self.mapCurPotentialList, v)
    end
  else
    for _, v in ipairs(self.mapPotentialList.AssistSpecificIds) do
      table.insert(self.mapCurPotentialList, v)
    end
    for _, v in ipairs(self.mapPotentialList.AssistNormalIds) do
      table.insert(self.mapCurPotentialList, v)
    end
  end
  self.nAllPage = math.floor(#self.mapCurPotentialList % 8 == 0 and #self.mapCurPotentialList / 8 or #self.mapCurPotentialList / 8 + 1)
  for k, v in ipairs(self._mapNode.imgDotBg) do
    v.gameObject:SetActive(k <= self.nAllPage and self.nAllPage > 1)
  end
  if self.nCurPage == 0 then
    self.nCurPage = 1
  end
  self:RefreshPageList()
  self:RefreshLeftPage()
  self:RefreshRightPage()
end

function StarTowerPotentialBookCtrl:RefreshPageList()
  self._mapNode.btnLeft.gameObject:SetActive(self.nCurPage > 1)
  self._mapNode.btnRight.gameObject:SetActive(self.nCurPage < self.nAllPage)
  self._mapNode.imgNormalTitle[1].gameObject:SetActive(self.nCurPage > 1)
  self._mapNode.imgSpecialTitle.gameObject:SetActive(self.nCurPage == 1)
  for k, v in ipairs(self._mapNode.imgDot) do
    v.gameObject:SetActive(k == self.nCurPage)
  end
end

function StarTowerPotentialBookCtrl:RefreshLeftPage()
  local nStartIndex = (self.nCurPage - 1) * 8
  for i = 1, 4 do
    local nIndex = nStartIndex + i
    local item = self._mapNode.goPotentialBookItem[i]
    item.gameObject:SetActive(self.mapCurPotentialList[nIndex] ~= nil)
    if self.mapCurPotentialList[nIndex] ~= nil then
      item:InitItem(self.mapCurPotentialList[nIndex].nId, self.mapCurPotentialList[nIndex].nLevel)
      item:RegisterRedDot()
    end
  end
end

function StarTowerPotentialBookCtrl:RefreshRightPage()
  local bEmpty = true
  local nStartIndex = (self.nCurPage - 1) * 8
  for i = 5, 8 do
    local nIndex = nStartIndex + i
    local item = self._mapNode.goPotentialBookItem[i]
    item.gameObject:SetActive(self.mapCurPotentialList[nIndex] ~= nil)
    if self.mapCurPotentialList[nIndex] ~= nil then
      bEmpty = false
      item:InitItem(self.mapCurPotentialList[nIndex].nId, self.mapCurPotentialList[nIndex].nLevel)
      item:RegisterRedDot()
    end
  end
  self._mapNode.imgEmpty.gameObject:SetActive(bEmpty)
end

function StarTowerPotentialBookCtrl:SetSimpleState()
  self._mapNode.imgSwitchOff.gameObject:SetActive(not self.bSimple)
  self._mapNode.imgSwitchOn.gameObject:SetActive(self.bSimple)
end

function StarTowerPotentialBookCtrl:RefreshReceiveAllBtn()
  self._mapNode.btnReceiveAllPotential.gameObject:SetActive(false)
  local tbCharHave = PlayerData.Char:GetCharIdList()
  for _, v in ipairs(tbCharHave) do
    local nCharID = v.nId
    local mapCharCfg = ConfigTable.GetData_Character(nCharID)
    if mapCharCfg ~= nil then
      local bCanReceive = RedDotManager.GetValid(RedDotDefine.StarTowerBook_Potential_Reward, {
        mapCharCfg.EET,
        nCharID
      })
      if bCanReceive and not self.bPotentialList then
        self._mapNode.btnReceiveAllPotential.gameObject:SetActive(true)
        break
      end
    end
  end
end

function StarTowerPotentialBookCtrl:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
  self.nCharId = 0
  self.mapCharGrids = {}
  self.nCurTab = 1
  self.bMasterPotential = true
  self.nCurPage = 0
  self:InitTab()
end

function StarTowerPotentialBookCtrl:OnEnable()
  self.bSimple = PlayerData.StarTower:GetPotentialDescSimple()
  self:SetSimpleState()
end

function StarTowerPotentialBookCtrl:OnDisable()
  if self.bPotentialList then
    self:ResetNewRedDot()
  end
  for nInstanceId, objCtrl in pairs(self.mapCharGrids) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapCharGrids[nInstanceId] = nil
  end
  self.mapCharGrids = {}
end

function StarTowerPotentialBookCtrl:OnDestroy()
end

function StarTowerPotentialBookCtrl:OnBtnClick_Reward()
  EventManager.Hit("OpenStarTowerBookQuest", self.nCharId)
end

function StarTowerPotentialBookCtrl:OnBtnClick_Switch()
  self.bMasterPotential = not self.bMasterPotential
  if self.bMasterPotential then
    self._mapNode.animPage:Play("FlipBook_Right1", 0, 0)
  else
    self._mapNode.animPage:Play("FlipBook_Left1", 0, 0)
  end
  self._mapNode.goLeftPotentialList.gameObject:SetActive(false)
  self._mapNode.goRightPotentialList.gameObject:SetActive(false)
  self:AddTimer(1, 0.5, function()
    self._mapNode.goLeftPotentialList.gameObject:SetActive(true)
    self._mapNode.goRightPotentialList.gameObject:SetActive(true)
  end, true, true, true, nil)
  self.nCurPage = 0
  self:SwitchPotentialType()
end

function StarTowerPotentialBookCtrl:OnBtnClick_Left()
  if self.nCurPage <= 1 then
    return
  end
  self.nCurPage = self.nCurPage - 1
  self._mapNode.animPage:Play("FlipBook_Right", 0, 0)
  self:AddTimer(1, 0.3, function()
    self:RefreshRightPage()
  end, true, true, true, nil)
  self:RefreshPageList()
  self:RefreshLeftPage()
end

function StarTowerPotentialBookCtrl:OnBtnClick_Right()
  if self.nCurPage >= self.nAllPage then
    return
  end
  self.nCurPage = self.nCurPage + 1
  self._mapNode.animPage:Play("FlipBook_Left", 0, 0)
  self:AddTimer(1, 0.3, function()
    self:RefreshLeftPage()
  end, true, true, true, nil)
  self:RefreshPageList()
  self:RefreshRightPage()
end

function StarTowerPotentialBookCtrl:OnBtnClick_Bg()
  self._mapNode.animDetail:Play("goCardDetail_out")
  local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animDetail, {
    "goCardDetail_out"
  })
  self:AddTimer(1, nAnimLen, function()
    self._mapNode.goPotentialDetail.gameObject:SetActive(false)
    self._mapNode.goBlur.gameObject:SetActive(false)
    if self._mapNode.goPotentialBookItem[self.nClickIndex] ~= nil then
    end
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
end

function StarTowerPotentialBookCtrl:OnBtnClick_Tab(btn, nIndex)
  if nil ~= self.tbTabs[nIndex] and self.tbTabs[nIndex].Lock then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("StarTower_Book_Char_Element_Lock"))
    return
  end
  self.nCurTab = nIndex
  self:RefreshTab()
  self:RefreshCharList()
end

function StarTowerPotentialBookCtrl:OnBtnClick_Item(btn, nIdx)
  local function animFinishFunc()
    local nIndex = (self.nCurPage - 1) * 8 + nIdx
    
    if self.mapCurPotentialList[nIndex] ~= nil then
      RedDotManager.SetValid(RedDotDefine.StarTowerBook_Potential_New, self.mapCurPotentialList[nIndex].nId, false)
      self._mapNode.goDetail.gameObject:SetActive(false)
      self._mapNode.goPotentialDetail.gameObject:SetActive(true)
      self._mapNode.goBlur.gameObject:SetActive(true)
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self._mapNode.goDetail.gameObject:SetActive(true)
      end
      
      cs_coroutine.start(wait)
      EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
      local nLevel = self.mapCurPotentialList[nIndex].nLevel == 0 and 1 or self.mapCurPotentialList[nIndex].nLevel
      self._mapNode.potentialDetail:SetPotentialItem(self.mapCurPotentialList[nIndex].nId, nLevel, nil, self.bSimple, nil, nil, AllEnum.PotentialCardType.Book)
      self._mapNode.potentialDetail:ChangeWordRaycast(true)
    end
  end
  
  self.nClickIndex = nIdx
  if self._mapNode.goPotentialBookItem[nIdx] ~= nil then
    self:AddTimer(1, 0.15, animFinishFunc, true, true, true)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.15)
  end
end

function StarTowerPotentialBookCtrl:OnBtnClick_ChangeDesc()
  self.bSimple = not self.bSimple
  PlayerData.StarTower:SetPotentialDescSimple(self.bSimple)
  self:SetSimpleState()
  self._mapNode.potentialDetail:ChangeDesc(self.bSimple)
end

function StarTowerPotentialBookCtrl:OnBtnClick_ReceiveAllPotential()
  PlayerData.StarTowerBook:SendReceiveAllPotentialRewardMsg()
end

function StarTowerPotentialBookCtrl:OnEvent_PotentialBookDataChange()
  for _, v in pairs(self.mapCharGrids) do
    v:RefreshCount()
  end
  if self.bPotentialList then
    local nCount, nAllCount = PlayerData.StarTowerBook:GetCharPotentialCount(self.nCharId)
    NovaAPI.SetTMPText(self._mapNode.txtCollectCount, string.format("%s/%s", nCount, nAllCount))
  end
end

function StarTowerPotentialBookCtrl:OnEvent_ReceivePotentialBookReward()
  local mapCharCfg = ConfigTable.GetData_Character(self.nCharId)
  if mapCharCfg ~= nil then
    local bCanReceive = RedDotManager.GetValid(RedDotDefine.StarTowerBook_Potential_Reward, {
      mapCharCfg.EET,
      self.nCharId
    })
    self._mapNode.btnReward.gameObject:SetActive(not bCanReceive)
    self._mapNode.btnReceiveReward.gameObject:SetActive(bCanReceive)
  end
  self:RefreshReceiveAllBtn()
end

return StarTowerPotentialBookCtrl
