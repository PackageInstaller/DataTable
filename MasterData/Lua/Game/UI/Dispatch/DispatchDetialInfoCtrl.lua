local BaseCtrl = require("GameCore.UI.BaseCtrl")
local DispatchDetialInfoCtrl = class("DispatchDetialInfoCtrl", BaseCtrl)
local SatisifiedColor = Color(0.23137254901960785, 0.3843137254901961, 0.6823529411764706, 1)
local UnSatisifiedColor = Color(0.65, 0.65, 0.65, 1)
local DispatchData = PlayerData.Dispatch
DispatchDetialInfoCtrl._mapNodeConfig = {
  btnAcceptDispatch = {
    sNodeName = "btnAcceptDispatch",
    sComponentName = "UIButton",
    callback = "OnBtnClick_AcceptDispatch"
  },
  goInfo = {sNodeName = "goInfo", sComponentName = "GameObject"},
  goRequireInfo = {
    sNodeName = "goRequireInfo",
    sComponentName = "GameObject"
  },
  txtDispathchIntoTitle = {
    sNodeName = "txtDispatchTitle",
    sComponentName = "TMP_Text"
  },
  txtDispatchInfo = {
    sNodeName = "txtDispatchInfo",
    sComponentName = "TMP_Text"
  },
  goRequireList = {
    sNodeName = "goRequireList",
    sComponentName = "GameObject"
  },
  goExtraRequireList = {
    sNodeName = "goExtraRequireList",
    sComponentName = "GameObject"
  },
  goCharList = {sNodeName = "goCharList", sComponentName = "GameObject"},
  btnChar = {
    sNodeName = "btnChar",
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChoseChars"
  },
  charHead = {nCount = 3, sNodeName = "char"},
  togTime = {
    sNodeName = "togTime",
    nCount = 4,
    sComponentName = "Toggle",
    callback = "OnTog_ChoseTime"
  },
  goRequire = {nCount = 3},
  animRequire = {
    nCount = 3,
    sNodeName = "goRequire",
    sComponentName = "Animator"
  },
  txtRequire = {nCount = 3, sComponentName = "TMP_Text"},
  goExtraRequire = {nCount = 3},
  animExtraRequire = {
    nCount = 3,
    sNodeName = "goExtraRequire",
    sComponentName = "Animator"
  },
  txtExtraRequire = {nCount = 3, sComponentName = "TMP_Text"},
  txtLevel = {sNodeName = "txtLevel", sComponentName = "TMP_Text"},
  imgScoreLimit = {
    sNodeName = "imgScoreLimit",
    sComponentName = "Image"
  },
  btnRecallDispatch = {
    sNodeName = "btnRecallDispatch",
    sComponentName = "UIButton",
    callback = "OnBtnClick_RecallDispatch"
  },
  goDispatchTimeGroup = {},
  TogLabel = {nCount = 4, sComponentName = "TMP_Text"},
  txtCurRequireTime = {sComponentName = "TMP_Text"},
  btnReceive = {
    sNodeName = "btnReceive",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  t_common_03 = {},
  goReward = {nCount = 3, sComponentName = "Transform"},
  goExtraReward = {sComponentName = "Transform"},
  goCurRequireTime = {},
  goRequireDone = {},
  imgRequireBg = {nCount = 3},
  imgRequire = {nCount = 3},
  imgExtraRequireBg = {nCount = 3},
  imgExtraRequire = {nCount = 3},
  txtConsignor = {sComponentName = "TMP_Text"},
  imgListMask = {
    sComponentName = "DOTweenAnimation"
  },
  txtRequireCharTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Agent_Character"
  },
  txtTitleLevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Agent_Limit_Level"
  },
  txtTitleRewardInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Level_Award"
  },
  txtRequireTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Agent_Require"
  },
  txtExtraRequireTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Agent_Extra_Require"
  },
  txtBtnAcceptDispatch = {
    sComponentName = "TMP_Text",
    sLanguageId = "Agent_Accpect"
  },
  txtbtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Agent_Receive_Reward"
  },
  txtBtnRecallDispatch = {
    sComponentName = "TMP_Text",
    sLanguageId = "Agent_Recall"
  },
  txtRequireDone = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Complete"
  },
  btnOneClick = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OneClickSelection"
  },
  txtBtnOneClickDispatch = {
    sComponentName = "TMP_Text",
    sLanguageId = "Agent_OneClick_Selection"
  },
  txtFullAgent = {sComponentName = "TMP_Text", sLanguageId = "Agent_Full"},
  goCantAgentRoot = {},
  txtLockInfo = {sComponentName = "TMP_Text"},
  goBtnRoot = {},
  imgGroupBG = {},
  imgBg_3 = {sNodeName = "imgBg_3", sComponentName = "Image"},
  imgBg_3_dot = {
    sNodeName = "imgBg_3_dot",
    sComponentName = "Image"
  }
}
DispatchDetialInfoCtrl._mapEventConfig = {}
local QualityColor = {
  [1] = Color(0.8117647058823529, 0.8352941176470589, 0.8588235294117647),
  [2] = Color(0.803921568627451, 0.8549019607843137, 0.788235294117647),
  [3] = Color(0.7450980392156863, 0.8549019607843137, 0.9137254901960784),
  [4] = Color(0.4117647058823529, 0.5294117647058824, 0.6470588235294118),
  [5] = Color(0.4235294117647059, 0.6235294117647059, 0.3607843137254902),
  [6] = Color(0.4588235294117647, 0.5529411764705883, 0.596078431372549)
}

function DispatchDetialInfoCtrl:Awake()
  self.tbRewardItemGrid = {}
  self.tbItemCtrl = {}
  self.selectTogIndex = 1
end

function DispatchDetialInfoCtrl:OnEnable()
end

function DispatchDetialInfoCtrl:OnDisable()
  if self.tbRewardItemGrid then
    for k, v in pairs(self.tbRewardItemGrid) do
      self:UnbindCtrlByNode(v)
    end
  end
  self.tbRewardItemGrid = {}
  for k, v in pairs(self.tbItemCtrl) do
    self:UnbindCtrlByNode(v)
  end
  self.tbItemCtrl = {}
  if self.bounsItemCtrl ~= nil then
    self:UnbindCtrlByNode(self.bounsItemCtrl)
  end
  self.bounsItemCtrl = nil
end

function DispatchDetialInfoCtrl:Refresh(dispatchId)
  self.TempChars = {}
  self.curDisptachTime = 0
  self.curDispatchData = ConfigTable.GetData("Agent", dispatchId)
  if 0 >= self.curDispatchData["Time" .. self.selectTogIndex] then
    self.selectTogIndex = 1
  end
  NovaAPI.SetTMPText(self._mapNode.txtDispathchIntoTitle, self.curDispatchData.Name)
  NovaAPI.SetTMPText(self._mapNode.txtDispatchInfo, self.curDispatchData.Desc)
  self._mapNode.t_common_03:SetActive(self.curDispatchData.MemberType == GameEnum.AgentMemberType.CharType and 0 < self.curDispatchData.Level)
  self._mapNode.imgScoreLimit.gameObject:SetActive(self.curDispatchData.MemberType ~= GameEnum.AgentMemberType.CharType and 0 < self.curDispatchData.BuildScore)
  if self.curDispatchData.MemberType == GameEnum.AgentMemberType.CharType then
    NovaAPI.SetTMPText(self._mapNode.txtLevel, self.curDispatchData.Level)
  else
    local rank = PlayerData.Build:CalBuildRank(self.curDispatchData.BuildScore)
    local imagePath = "Icon/BuildRank/BuildRank_" .. rank.Id
    self:SetPngSprite(self._mapNode.imgScoreLimit, imagePath)
  end
  for i = 1, 4 do
    local dispatchTime = self.curDispatchData["Time" .. i]
    self._mapNode.togTime[i].gameObject:SetActive(0 < dispatchTime)
    if 0 < dispatchTime then
      local txtStr = ""
      if dispatchTime % 60 == 0 then
        txtStr = math.floor(dispatchTime / 60) .. ConfigTable.GetUIText("Depot_LeftTime_Hour")
      else
        txtStr = dispatchTime .. ConfigTable.GetUIText("Depot_LeftTime_Min")
      end
      NovaAPI.SetTMPText(self._mapNode.TogLabel[i], txtStr)
    end
  end
  local AllData = DispatchData.GetAllDispatchingData()
  local dispatchingData = AllData[dispatchId] ~= nil and AllData[dispatchId] or nil
  local data
  if self.curDispatchData.MemberType == GameEnum.AgentMemberType.CharType then
    data = DispatchData.GetDispatchCharList(self.curDispatchData.Id)
    self:RefreshCharList(data, dispatchingData ~= nil and dispatchingData.State >= AllEnum.DispatchState.CanAccept)
  else
    local function Callback(buildDatas)
      data = buildDatas
      
      self:RefreshCharList(data)
    end
    
    DispatchData.GetDispatchBuildData(self.curDispatchData.Id, Callback)
  end
  local state = DispatchData.GetDispatchState(dispatchId)
  self:RefreshDispatchState(state)
  self:OnRefreshReward()
  NovaAPI.SetToggleIsOn(self._mapNode.togTime[self.selectTogIndex], true)
  if self.lastSelectTogIndex ~= nil then
    NovaAPI.SetToggleIsOn(self._mapNode.togTime[self.selectTogIndex], false)
  end
  if dispatchingData ~= nil and dispatchingData.State == AllEnum.DispatchState.Accepting then
    self.curDisptachTime = dispatchingData.Data.StartTime + dispatchingData.Data.ProcessTime * 60 - CS.ClientManager.Instance.serverTimeStamp
    self.curDisptachingData = dispatchingData
  end
  if self._refreshTimeCountDown ~= nil then
    self._refreshTimeCountDown:Cancel()
    self._refreshTimeCountDown = nil
  end
  if self.curDisptachTime > 0 then
    local time = timeFormat_HMS(self.curDisptachTime)
    NovaAPI.SetTMPText(self._mapNode.txtCurRequireTime, orderedFormat(ConfigTable.GetUIText("Agent_Delegate_Now") or "", time))
    self._refreshTimeCountDown = self:AddTimer(0, 1, "RefreshCountDown", true, true, true)
  else
    NovaAPI.SetTMPText(self._mapNode.txtCurRequireTime, ConfigTable.GetUIText("Quest_Complete"))
  end
  NovaAPI.SetTMPText(self._mapNode.txtConsignor, ConfigTable.GetUIText("Agent_Consignor_Title") .. self.curDispatchData.Consignor)
  self._mapNode.imgBg_3.color = QualityColor[self.curDispatchData.Quality]
  self._mapNode.imgBg_3_dot.color = QualityColor[self.curDispatchData.Quality + 3]
end

function DispatchDetialInfoCtrl:RefreshCharList(Data, bAccepting)
  self.TagList = {}
  self._mapNode.goCharList:SetActive(self.curDispatchData.MemberType == GameEnum.AgentMemberType.CharType)
  self._mapNode.txtRequireCharTitle.gameObject:SetActive(self.curDispatchData.MemberType == GameEnum.AgentMemberType.CharType)
  if self.curDispatchData.MemberType == GameEnum.AgentMemberType.CharType then
    local charList = Data
    self.TempChars = charList
    for i = 1, self.curDispatchData.MemberLimit do
      if charList[i] ~= nil then
        local bNew = self._mapNode.charHead[i].gameObject.activeInHierarchy == false
        self._mapNode.charHead[i].gameObject:SetActive(true)
        local mapChar = ConfigTable.GetData_Character(charList[i])
        local mapCharData = PlayerData.Char:GetCharDataByTid(charList[i])
        local nCharSkinId = mapCharData.nSkinId
        local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
        local imgHeadIcon = self._mapNode.charHead[i].transform:Find("imgIconBg/imgItemIcon"):GetComponent("Image")
        self:SetPngSprite(imgHeadIcon, mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
        local imgItemRare = self._mapNode.charHead[i].transform:Find("imgItemRare"):GetComponent("Image")
        local nRarity = mapChar.Grade
        local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[nRarity == GameEnum.characterGrade.R and GameEnum.characterGrade.SR or nRarity]
        self:SetAtlasSprite(imgItemRare, "12_rare", sFrame, true)
        local mapCharDescCfg = ConfigTable.GetData("CharacterDes", charList[i])
        for i = 1, #mapCharDescCfg.Tag do
          table.insert(self.TagList, mapCharDescCfg.Tag[i])
        end
        if self.bChoosing and bNew then
          NovaAPI.CtrlDotweenAnimation(self._mapNode.btnChar[i].gameObject, 2)
          NovaAPI.CtrlDotweenAnimation(self._mapNode.btnChar[i].gameObject, 1)
        end
      else
        self._mapNode.charHead[i].gameObject:SetActive(false)
      end
    end
    for i = 1, 3 do
      if bAccepting then
        self._mapNode.btnChar[i].gameObject:SetActive(charList[i] ~= nil)
      else
        self._mapNode.btnChar[i].gameObject:SetActive(i <= self.curDispatchData.MemberLimit)
      end
    end
    self.TempBuildId = 0
  else
    local buildData = Data
    if Data ~= nil then
      self.TempBuildId = Data.nBuildId
    else
      self.TempBuildId = -1
    end
    self.TempChars = {}
  end
  self:RefreshRequire(true)
  self:OnRefreshReward()
end

function DispatchDetialInfoCtrl:RefreshBuildInfo(buildData)
  if buildData == nil then
    self._mapNode.goBuildInfoGrid:SetActive(false)
    return
  end
  self._mapNode.goBuildInfoGrid:SetActive(true)
  if self.bChoosing then
    NovaAPI.CtrlDotweenAnimation(self._mapNode.goBuildInfoGrid, 2)
    NovaAPI.CtrlDotweenAnimation(self._mapNode.goBuildInfoGrid, 1)
  end
  local btnGrid = self._mapNode.goBuildInfoGrid.transform:Find("btn_grid"):GetComponent("UIButton")
  btnGrid.onClick:RemoveAllListeners()
  btnGrid.onClick:AddListener(function()
    self:OnBtnClick_AddBuild()
  end)
  local transRoot = btnGrid.transform:Find("AnimRoot")
  local imgRareScore = transRoot:Find("imgRareScore"):GetComponent("Image")
  local sScore = "Icon/BuildRank/BuildRank_" .. buildData.mapRank.Id
  self:SetPngSprite(imgRareScore, sScore)
  local txtBuildName = transRoot:Find("txtBuildName"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtBuildName, buildData.sName)
  local tcChar1 = transRoot:Find("imgLeaderBg/tc_char_03")
  local tcChar2 = transRoot:Find("imgSubBg1/tc_char_03")
  local tcChar3 = transRoot:Find("imgSubBg2/tc_char_03")
  local tbChar = {
    tcChar1,
    tcChar2,
    tcChar3
  }
  for i = 1, 3 do
    local charTrans = tbChar[i]
    local nCharTid = buildData.tbChar[i].nTid
    local imgCharIcon = charTrans:Find("imgIconBg/imgCharIcon"):GetComponent("Image")
    local imgCharFrame = charTrans:Find("imgCharFrame"):GetComponent("Image")
    local nCharSkinId = PlayerData.Char:GetCharSkinId(nCharTid)
    local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
    local mapCharCfg = ConfigTable.GetData_Character(nCharTid)
    local sFrame = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
    self:SetPngSprite(imgCharIcon, mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XXL)
    self:SetAtlasSprite(imgCharFrame, "12_rare", sFrame)
    local mapCharDescCfg = ConfigTable.GetData("CharacterDes", nCharTid)
    for i = 1, #mapCharDescCfg.Tag do
      table.insert(self.TagList, mapCharDescCfg.Tag[i])
    end
  end
end

function DispatchDetialInfoCtrl:RefreshRequire(bPlayAnim)
  local requireList = self.curDispatchData.Tags
  self.hasSatisifiedRequire = true
  for i = 1, 3 do
    if i <= #requireList then
      local requireInfo = ConfigTable.GetData("CharacterTag", requireList[i])
      if requireInfo then
        NovaAPI.SetTMPText(self._mapNode.txtRequire[i], requireInfo.Title)
        local bSatisified = false
        if table.indexof(self.TagList, requireList[i]) > 0 then
          NovaAPI.SetTMPColor(self._mapNode.txtRequire[i], SatisifiedColor)
          bSatisified = true
          local bNew = self._mapNode.imgRequire[i].activeInHierarchy == false
          if bPlayAnim and self.bChoosing and bNew then
            self._mapNode.animRequire[i]:Play("DispatchRequire")
          end
          table.removebyvalue(self.TagList, requireList[i])
        else
          NovaAPI.SetTMPColor(self._mapNode.txtRequire[i], UnSatisifiedColor)
          self.hasSatisifiedRequire = false
        end
        local delayTime = bSatisified and 0.2 or 0
        if bSatisified then
          self:AddTimer(1, delayTime, function()
            self._mapNode.imgRequire[i]:SetActive(bSatisified)
            self._mapNode.imgRequireBg[i]:SetActive(not bSatisified)
          end, true, true, true)
        else
          self._mapNode.imgRequire[i]:SetActive(bSatisified)
          self._mapNode.imgRequireBg[i]:SetActive(not bSatisified)
        end
      end
    end
    self._mapNode.goRequire[i]:SetActive(i <= #requireList)
  end
  local ExtraRequireList = self.curDispatchData.ExtraTags
  self.hasSatisifiedExtraRequire = true
  for i = 1, 3 do
    if i <= #ExtraRequireList then
      local requireInfo = ConfigTable.GetData("CharacterTag", ExtraRequireList[i])
      if requireInfo then
        local bSatisified = false
        NovaAPI.SetTMPText(self._mapNode.txtExtraRequire[i], requireInfo.Title)
        if table.indexof(self.TagList, ExtraRequireList[i]) > 0 then
          NovaAPI.SetTMPColor(self._mapNode.txtExtraRequire[i], SatisifiedColor)
          bSatisified = true
          local bNew = self._mapNode.imgExtraRequire[i].activeInHierarchy == false
          if bPlayAnim and self.bChoosing and bNew then
            self._mapNode.animExtraRequire[i]:Play("DispatchRequire")
          end
          table.removebyvalue(self.TagList, ExtraRequireList[i])
        else
          NovaAPI.SetTMPColor(self._mapNode.txtExtraRequire[i], UnSatisifiedColor)
          self.hasSatisifiedExtraRequire = false
        end
        local delayTime = bSatisified and 0.2 or 0
        if bSatisified then
          self:AddTimer(1, delayTime, function()
            self._mapNode.imgExtraRequire[i]:SetActive(bSatisified)
            self._mapNode.imgExtraRequireBg[i]:SetActive(not bSatisified)
          end, true, true, true)
        else
          self._mapNode.imgExtraRequire[i]:SetActive(bSatisified)
          self._mapNode.imgExtraRequireBg[i]:SetActive(not bSatisified)
        end
      end
    end
    self._mapNode.goExtraRequire[i]:SetActive(i <= #ExtraRequireList)
  end
  self.hasExtraReuqire = 0 < #ExtraRequireList
  self._mapNode.goExtraRequireList:SetActive(self.hasExtraReuqire)
  self._mapNode.goExtraReward.gameObject:SetActive(self.hasExtraReuqire)
end

function DispatchDetialInfoCtrl:OnRefreshReward()
  local state = DispatchData.GetDispatchState(self.curDispatchData.Id)
  if state > AllEnum.DispatchState.CanAccept then
    local allData = PlayerData.Dispatch.GetAllDispatchingData()
    local agentData = allData[self.curDispatchData.Id]
    if agentData ~= nil then
      for i = 1, 4 do
        if agentData.Data.ProcessTime == self.curDispatchData["Time" .. i] then
          if self.selectTogIndex ~= i then
            self.lastSelectTogIndex = self.selectTogIndex
          end
          self.selectTogIndex = i
          break
        end
      end
    end
  end
  local rewardData = self.curDispatchData["RewardPreview" .. self.selectTogIndex]
  local bounsRewardData = self.curDispatchData["BonusPreview" .. self.selectTogIndex]
  local tbReward = decodeJson(rewardData)
  local bounsData = decodeJson(bounsRewardData)
  for i = 1, 3 do
    local item = self._mapNode.goReward[i]:Find("btnGrid")
    if tbReward[i] ~= nil then
      local btnItem = item:GetComponent("UIButton")
      local goItem = item:Find("AnimRoot/goItem")
      if self.tbItemCtrl[i] == nil then
        self.tbItemCtrl[i] = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplateItemCtrl")
      end
      self.tbItemCtrl[i]:SetItem(tbReward[i][1])
      local txtPreviewCount = goItem:Find("txtPreviewCount"):GetComponent("TMP_Text")
      local countTxt = ""
      if tonumber(tbReward[i][2]) >= 1000 or tonumber(tbReward[i][3]) >= 1000 then
        countTxt = tbReward[i][2] .. "+"
      elseif tbReward[i][2] == tbReward[i][3] then
        countTxt = tbReward[i][2]
      else
        countTxt = tbReward[i][2] .. "~" .. tbReward[i][3]
      end
      NovaAPI.SetTMPText(txtPreviewCount, countTxt)
      btnItem.onClick:RemoveAllListeners()
      btnItem.onClick:AddListener(function()
        local mapData = {
          nTid = tbReward[i][1],
          bShowDepot = true
        }
        EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, item, mapData)
      end)
    end
    item.gameObject:SetActive(tbReward[i] ~= nil)
  end
  local bounsItem = self._mapNode.goExtraReward:Find("btnGrid")
  if bounsData[1] ~= nil then
    local btnItem = bounsItem:GetComponent("UIButton")
    local goItem = bounsItem:Find("AnimRoot/goItem")
    if self.bounsItemCtrl == nil then
      self.bounsItemCtrl = self:BindCtrlByNode(goItem, "Game.UI.TemplateEx.TemplateItemCtrl")
    end
    self.bounsItemCtrl:SetItem(bounsData[1][1])
    local txtPreviewCount = goItem:Find("txtPreviewCount"):GetComponent("TMP_Text")
    local countTxt = ""
    if 1000 <= tonumber(bounsData[1][2]) or 1000 <= tonumber(bounsData[1][3]) then
      countTxt = bounsData[1][2] .. "+"
    elseif bounsData[1][2] == bounsData[1][3] then
      countTxt = bounsData[1][2]
    else
      countTxt = bounsData[1][2] .. "~" .. bounsData[1][3]
    end
    NovaAPI.SetTMPText(txtPreviewCount, countTxt)
    local goUnExtraReward = goItem:Find("goExtra/goUnsatisfied")
    local goExtraReward = goItem:Find("goExtra/imgSatisfied")
    goExtraReward.gameObject:SetActive(self.hasSatisifiedExtraRequire)
    goUnExtraReward.gameObject:SetActive(not self.hasSatisifiedExtraRequire)
    btnItem.onClick:RemoveAllListeners()
    btnItem.onClick:AddListener(function()
      local mapData = {
        nTid = bounsData[1][1],
        bShowDepot = true
      }
      EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, bounsItem, mapData)
    end)
  end
  bounsItem.gameObject:SetActive(bounsData[1] ~= nil)
end

function DispatchDetialInfoCtrl:RefreshDispatchState(state)
  self.curState = state
  local bUnlock, sLockInfo = DispatchData.CheckDispatchItemUnlock(self.curDispatchData.Id)
  local bMaxAccept = DispatchData.GetAccpectingDispatchCount() >= tonumber(ConfigTable.GetConfigValue("AgentMaximumQuantity"))
  local bShowCantAccpet = (not bUnlock or bMaxAccept) and self.curState == AllEnum.DispatchState.CanAccept
  self._mapNode.goBtnRoot:SetActive(not bShowCantAccpet)
  self._mapNode.goCantAgentRoot:SetActive(bShowCantAccpet)
  self._mapNode.imgGroupBG:SetActive(not bShowCantAccpet)
  self._mapNode.btnAcceptDispatch.gameObject:SetActive(self.curState == AllEnum.DispatchState.CanAccept)
  self._mapNode.btnOneClick.gameObject:SetActive(self.curState == AllEnum.DispatchState.CanAccept)
  self._mapNode.btnRecallDispatch.gameObject:SetActive(self.curState == AllEnum.DispatchState.Accepting)
  self._mapNode.btnReceive.gameObject:SetActive(self.curState == AllEnum.DispatchState.Complete)
  self.bIgnoreTog = true
  self._mapNode.goDispatchTimeGroup:SetActive(self.curState == AllEnum.DispatchState.CanAccept and not bShowCantAccpet)
  self.bIgnoreTog = false
  self._mapNode.goCurRequireTime.gameObject:SetActive(self.curState == AllEnum.DispatchState.Accepting and not bShowCantAccpet)
  self._mapNode.goRequireDone.gameObject:SetActive(self.curState == AllEnum.DispatchState.Complete and not bShowCantAccpet)
  if bShowCantAccpet then
    if not bUnlock then
      NovaAPI.SetTMPText(self._mapNode.txtLockInfo, sLockInfo)
    end
    self._mapNode.txtLockInfo.gameObject:SetActive(not bUnlock)
    self._mapNode.txtFullAgent.gameObject:SetActive(bUnlock and bMaxAccept)
  end
end

function DispatchDetialInfoCtrl:RefreshCountDown()
  if self.curDisptachingData == nil then
    return
  end
  self.curDisptachTime = self.curDisptachingData.Data.StartTime + self.curDisptachingData.Data.ProcessTime * 60 - CS.ClientManager.Instance.serverTimeStamp
  local time = timeFormat_HMS(self.curDisptachTime)
  NovaAPI.SetTMPText(self._mapNode.txtCurRequireTime, orderedFormat(ConfigTable.GetUIText("Agent_Delegate_Now") or "", time))
  if self.curDisptachTime <= 0 then
    if self._refreshTimeCountDown ~= nil then
      self._refreshTimeCountDown:Cancel()
      self._refreshTimeCountDown = nil
    end
    self:RefreshDispatchState(AllEnum.DispatchState.Complete)
  end
  self.curDisptachTime = self.curDisptachTime - 1
end

function DispatchDetialInfoCtrl:OnCloseSelectPanel()
  self._mapNode.imgListMask:DORewind()
  self._mapNode.imgListMask.gameObject:SetActive(false)
  self.bChoosing = false
end

function DispatchDetialInfoCtrl:OnBtnClick_AcceptDispatch()
  if self.hasSatisifiedRequire and (self.TempBuildId ~= nil and self.TempBuildId > 0 or self.TempChars ~= nil and 0 < #self.TempChars) then
    local function callback(...)
      self.curDisptachTime = self.curDispatchData["Time" .. self.selectTogIndex] * 60
      
      if self._refreshTimeCountDown ~= nil then
        self._refreshTimeCountDown:Cancel()
        self._refreshTimeCountDown = nil
      end
      self.TempChars = {}
      self.TempBuildId = 0
      self:RefreshDispatchState(AllEnum.DispatchState.Accepting)
      self._refreshTimeCountDown = self:AddTimer(0, 1, "RefreshCountDown", true, true, true)
    end
    
    local mapData = {
      Id = self.curDispatchData.Id,
      ProcessTime = self.curDispatchData["Time" .. self.selectTogIndex],
      CharIds = self.TempChars,
      BuildId = self.TempBuildId
    }
    local AgentData = {}
    AgentData[self.curDispatchData.Id] = mapData
    if not self.hasSatisifiedExtraRequire then
      local function confirmCallback()
        CS.WwiseAudioManager.Instance:PlaySound("ui_dispatch_accept_successful")
        
        DispatchData.ReqApplyAgent({mapData}, AgentData, callback)
      end
      
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = ConfigTable.GetUIText("Agent_Extra_Comfirm"),
        callbackConfirm = confirmCallback
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    else
      CS.WwiseAudioManager.Instance:PlaySound("ui_dispatch_accept_successful")
      DispatchData.ReqApplyAgent({mapData}, AgentData, callback)
    end
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Agent_Insufficient_Condition"))
  end
end

function DispatchDetialInfoCtrl:OnBtnClick_RecallDispatch()
  local function confirmCallback()
    if self.curDisptachTime <= 0 then
      return
    end
    local AllData = DispatchData.GetAllDispatchingData()
    local dispatchingData = AllData[self.curDispatchData.Id] ~= nil and AllData[self.curDispatchData.Id] or nil
    local nTime = CS.ClientManager.Instance.serverTimeStamp
    
    local function callback()
      if self.curDispatchData.RefreshType == GameEnum.AgentRefreshType.Daily and DispatchData.IsSameDay(dispatchingData.Data.StartTime, nTime, 5) then
        self:RefreshDispatchState(AllEnum.DispatchState.CanAccept)
      end
      if self.curDispatchData.RefreshType == GameEnum.AgentRefreshType.NonRefresh and DispatchData.IsSameWeek(dispatchingData.Data.StartTime, nTime, 5) then
        self:RefreshDispatchState(AllEnum.DispatchState.CanAccept)
      end
    end
    
    DispatchData.ReqGiveUpAgent(self.curDispatchData.Id, callback)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Agent_GiveUp_Confirm"),
    callbackConfirm = confirmCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function DispatchDetialInfoCtrl:OnBtnClick_AddBuild()
  if self.curState == AllEnum.DispatchState.CanAccept then
    self._mapNode.imgListMask.gameObject:SetActive(true)
    self._mapNode.imgListMask:DOPlay()
    EventManager.Hit(EventId.DispatchOpenBuildList, self.curDispatchData.Id)
    self.bChoosing = true
  end
end

function DispatchDetialInfoCtrl:OnBtnClick_ChoseChars()
  if self.curState == AllEnum.DispatchState.CanAccept then
    self._mapNode.imgListMask.gameObject:SetActive(true)
    self._mapNode.imgListMask:DOPlay()
    EventManager.Hit(EventId.DispatchOpenCharList, self.curDispatchData.Id)
    self.bChoosing = true
  end
end

function DispatchDetialInfoCtrl:OnBtnClick_Receive()
  local function callback()
    self:RefreshDispatchState(AllEnum.DispatchState.CanAccept)
  end
  
  DispatchData.ReqReceiveReward(self.curDispatchData.Id, callback)
end

function DispatchDetialInfoCtrl:OnBtnClick_OneClickSelection()
  EventManager.Hit("Dispatch_OneClickSelection", self.curDispatchData.MemberType == GameEnum.AgentMemberType.BuildType)
end

function DispatchDetialInfoCtrl:OnTog_ChoseTime(tog, nIndex, bIsOn)
  if self.bIgnoreTog then
    return
  end
  if bIsOn then
    if self.selectTogIndex ~= nIndex then
      self.lastSelectTogIndex = self.selectTogIndex
    end
    self.selectTogIndex = nIndex
    self:OnRefreshReward()
  end
end

return DispatchDetialInfoCtrl
