local WeeklyCopiesCtrl = class("WeeklyCopiesCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
WeeklyCopiesCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  mBg = {sNodeName = "ImgBg", sComponentName = "Image"},
  mImage = {sNodeName = "BossImage", sComponentName = "Image"},
  mImgBgAni = {sNodeName = "----Bg----", sComponentName = "Animator"},
  mInfoAni = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  mGrid = {sNodeName = "mGrid", sComponentName = "GameObject"},
  mListContent = {
    sNodeName = "mListContent",
    sComponentName = "Transform"
  },
  mInfoName = {
    sNodeName = "txtMonsterName",
    sComponentName = "TMP_Text"
  },
  mInfoLv = {
    sNodeName = "txtRecommendLevelChallenge",
    sComponentName = "TMP_Text"
  },
  mInfoBuildRank = {sNodeName = "imgRecord", sComponentName = "Image"},
  mDiffGrid = {sNodeName = "diffGrid", sComponentName = "GameObject"},
  mDiffContent = {
    sNodeName = "diffToggleContent",
    sComponentName = "Transform"
  },
  txtChallenge = {
    sNodeName = "txtChallenge",
    sComponentName = "TMP_Text"
  },
  txtThroughTime = {
    sNodeName = "txtThroughTime",
    sComponentName = "TMP_Text"
  },
  txtRewardCount = {
    sNodeName = "txtRewardCount",
    sComponentName = "TMP_Text"
  },
  txtEnemySkill = {
    sNodeName = "txtEnemySkill",
    sComponentName = "TMP_Text"
  },
  txtDetailInfo = {
    sNodeName = "txtDetailInfo",
    sComponentName = "TMP_Text"
  },
  txtLevelLimit = {
    sNodeName = "txtLevelLimit",
    sComponentName = "TMP_Text"
  },
  txtCancel = {
    sNodeName = "txtBtnCancel",
    sComponentName = "TMP_Text"
  },
  txtConfirm = {
    sNodeName = "txtBtnConfirm",
    sComponentName = "TMP_Text"
  },
  txtTip = {
    sNodeName = "txtWindowTitleMsg",
    sComponentName = "TMP_Text"
  },
  txtTipReward = {
    sNodeName = "txtWindowTitle",
    sComponentName = "TMP_Text"
  },
  txtTipContent = {
    sNodeName = "txtContentMain",
    sComponentName = "TMP_Text"
  },
  txtRewardInfo = {
    sNodeName = "txtRewardInfo",
    sComponentName = "TMP_Text"
  },
  txtLvRenLv = {sNodeName = "txtLvRenLv", sComponentName = "TMP_Text"},
  txtTuiJianJiLu = {
    sNodeName = "txtTuiJianJiLu",
    sComponentName = "TMP_Text"
  },
  mElementNode = {
    sNodeName = "goPropertyList1",
    sComponentName = "Transform"
  },
  TabDuel2 = {},
  mAntiElementNode = {
    sNodeName = "goPropertyList2",
    sComponentName = "Transform"
  },
  Skill = {
    sCtrlName = "Game.UI.TemplateEx.TemplateSkillCtrl",
    nCount = 5
  },
  btnSkill = {
    sNodeName = "Skill",
    sComponentName = "UIButton",
    nCount = 5,
    callback = "OnBtnClick_Skill"
  },
  goNode = {sNodeName = "goNode", sComponentName = "GameObject"},
  emptyNode = {sNodeName = "emptyNode", sComponentName = "GameObject"},
  item = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 5
  },
  btn_item = {
    sComponentName = "UIButton",
    nCount = 5,
    callback = "OnBtnClick_Reward"
  },
  goRewardList = {
    sCtrlName = "Game.UI.MainlineEx.RewardListCtrl"
  },
  btnAllReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AllReward"
  },
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnClickBtnCrusade"
  },
  winTipNode = {sNodeName = "MsgNode", sComponentName = "GameObject"},
  btnConfirm1 = {
    sNodeName = "btnConfirmGo",
    sComponentName = "UIButton",
    callback = "OnClickBtnGo"
  },
  btnCancel1 = {
    sNodeName = "btnCancelGo",
    sComponentName = "UIButton",
    callback = "OnClickBtnCancel"
  },
  btnCancel2 = {
    sNodeName = "btnClose",
    sComponentName = "UIButton",
    callback = "OnClickBtnCancel"
  },
  mMsgAni = {
    sNodeName = "t_windowMsgNode",
    sComponentName = "Animator"
  },
  imgTicketTimeBg = {},
  imgTicketIcon = {sComponentName = "Image"},
  txtTicketCount = {sComponentName = "TMP_Text"},
  TMPTicketTimeHint = {sComponentName = "TMP_Text"},
  imgIconTicketBtn = {sComponentName = "Image"},
  txtCountTicketBtn = {sComponentName = "TMP_Text"},
  btnTicket = {
    sComponentName = "UIButton",
    callback = "OnClickBtnTicket"
  }
}
WeeklyCopiesCtrl._mapEventConfig = {
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  [EventId.UIBackConfirm] = "OnEvent_Back"
}
WeeklyCopiesCtrl._mapRedDotConfig = {}

function WeeklyCopiesCtrl:Awake()
  self.curSelectBossType = nil
  self.curSelectBossLevelData = nil
  self.tbReward = nil
  self.tbAfterReward = nil
  self.initSelTypeId = 0
  self.initSelDiffId = 0
end

function WeeklyCopiesCtrl:FadeIn()
end

function WeeklyCopiesCtrl:FadeOut()
end

function WeeklyCopiesCtrl:OnEnable()
  self.initSelTypeId = 0
  local tbParams = self:GetPanelParam()
  if type(tbParams) == "table" and tbParams[1] ~= nil then
    self.initSelTypeId = tbParams[1]
  elseif self.curSelectBossType ~= nil then
    self.initSelTypeId = self.curSelectBossType.Id
  end
  if self.initSelTypeId == 0 then
    self.initSelTypeId = self._panel.curSelMonster
  end
  self:SetSprite_Coin(self._mapNode.imgTicketIcon, AllEnum.CoinItemId.RogueHardCoreTick)
  self:SetSprite_Coin(self._mapNode.imgIconTicketBtn, AllEnum.CoinItemId.RogueHardCoreTick)
  local nTicketCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.RogueHardCoreTick)
  local nTicketMax = ConfigTable.GetConfigNumber("WeekBossTicketMax")
  NovaAPI.SetTMPText(self._mapNode.txtTicketCount, string.format("%d/%d", nTicketCount, nTicketMax))
  NovaAPI.SetTMPColor(self._mapNode.txtCountTicketBtn, 0 < nTicketCount and Blue_Normal or Red_Unable)
  if nTicketCount < nTicketMax then
    self._mapNode.imgTicketTimeBg:SetActive(true)
    self:SetTimes()
  else
    self._mapNode.imgTicketTimeBg:SetActive(false)
  end
  NovaAPI.SetTMPText(self._mapNode.txtChallenge, ConfigTable.GetUIText("WeeklyBoss_Chanllenge"))
  NovaAPI.SetTMPText(self._mapNode.txtThroughTime, ConfigTable.GetUIText("WeeklyBoss_ThroughTime"))
  NovaAPI.SetTMPText(self._mapNode.txtRewardCount, ConfigTable.GetUIText("WeeklyBoss_RewardCount"))
  NovaAPI.SetTMPText(self._mapNode.txtEnemySkill, ConfigTable.GetUIText("WeeklyBoss_EnemySkill"))
  NovaAPI.SetTMPText(self._mapNode.txtDetailInfo, ConfigTable.GetUIText("WeeklyBoss_DetailInfo"))
  NovaAPI.SetTMPText(self._mapNode.txtLevelLimit, ConfigTable.GetUIText("WeeklyBoss_LevelLimit"))
  NovaAPI.SetTMPText(self._mapNode.txtCancel, ConfigTable.GetUIText("WeeklyBoss_Cancel"))
  NovaAPI.SetTMPText(self._mapNode.txtConfirm, ConfigTable.GetUIText("WeeklyBoss_Confirm"))
  NovaAPI.SetTMPText(self._mapNode.txtTip, ConfigTable.GetUIText("WeeklyBoss_Tip"))
  NovaAPI.SetTMPText(self._mapNode.txtTipContent, ConfigTable.GetUIText("WeeklyBoss_TipContent"))
  NovaAPI.SetTMPText(self._mapNode.txtRewardInfo, ConfigTable.GetUIText("WeeklyBoss_RewardInfo"))
  NovaAPI.SetTMPText(self._mapNode.txtLvRenLv, ConfigTable.GetUIText("WeeklyBoss_LvRenLv"))
  NovaAPI.SetTMPText(self._mapNode.txtTuiJianJiLu, ConfigTable.GetUIText("WeeklyBoss_TuiJianJiLu"))
  NovaAPI.SetTMPText(self._mapNode.txtTipReward, ConfigTable.GetUIText("Level_Award"))
  PlayerData.RogueBoss:SetIsWeeklyCopies(true)
  EventManager.Hit(EventId.SetTransition)
  local mList = {}
  
  local function func_ForEach_BossType(bossTypeData)
    table.insert(mList, bossTypeData)
  end
  
  ForEachTableLine(DataTable.WeekBossType, func_ForEach_BossType)
  
  local function sortMList(a, b)
    return a.Sort < b.Sort
  end
  
  table.sort(mList, sortMList)
  local initSelIndex = 1
  for i = 1, #mList do
    local mNewGrid
    if i > self._mapNode.mListContent.childCount then
      mNewGrid = instantiate(self._mapNode.mGrid, self._mapNode.mListContent)
    else
      mNewGrid = self._mapNode.mListContent:GetChild(i - 1)
    end
    if mNewGrid ~= nil then
      local bossTypeData = mList[i]
      local txtName = mNewGrid.transform:Find("btnGrid/AnimRoot/TMPMonsterName"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txtName, bossTypeData.Name)
      local imgIcon = mNewGrid.transform:Find("btnGrid/AnimRoot/imgLevelImage"):GetComponent("Image")
      self:SetPngSprite(imgIcon, bossTypeData.Icon)
      local txtCount = mNewGrid.transform:Find("btnGrid/AnimRoot/TMPCount"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txtCount, "")
      local btn = mNewGrid.transform:Find("btnGrid"):GetComponent("UIButton")
      btn.onClick:RemoveAllListeners()
      local func_Handler = ui_handler(self, function()
        WwiseAudioMgr:PlaySound("ui_bossRank_button")
        if self.curSelectBossType ~= nil and self.curSelectBossType.Id == bossTypeData.Id then
          return
        end
        self.curSelectBossType = bossTypeData
        self._panel.curSelMonster = bossTypeData.Id
        self:RefreshSelectMonster(i - 1)
      end, btn.gameObject, i)
      btn.onClick:AddListener(func_Handler)
      mNewGrid.gameObject:SetActive(true)
      if self.initSelTypeId > 0 and bossTypeData.Id == self.initSelTypeId then
        initSelIndex = i
      end
    end
  end
  local childGridCount = self._mapNode.mListContent.childCount
  if childGridCount > #mList then
    for i = #mList, childGridCount - 1 do
      if i <= childGridCount then
        local childGrid = self._mapNode.mListContent:GetChild(i)
        childGrid.gameObject:SetActive(false)
      end
    end
  end
  self.curSelectBossType = mList[initSelIndex]
  self:RefreshSelectMonster(initSelIndex - 1)
end

function WeeklyCopiesCtrl:SetTimes()
  if self.timerCountDown then
    self.timerCountDown = nil
  end
  if self.timerCountDown == nil then
    self.timerCountDown = self:AddTimer(0, 1, "RefreshTimes", true, true, false)
  end
  self:RefreshTimes()
end

function WeeklyCopiesCtrl:RefreshTimes()
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local nNextRefreshTime = GetNextWeekRefreshTime()
  local sTimeStr = ""
  local remainTime = nNextRefreshTime - curTime
  if remainTime <= 0 then
    self.timerCountDown:Pause(true)
    self.timerCountDown = nil
    self._mapNode.imgTicketTimeBg:SetActive(false)
  elseif remainTime < 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("StarTower_Reward_Refresh_Remain_Time_Sec"), sec)
  elseif 60 <= remainTime and remainTime < 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("StarTower_Reward_Refresh_Remain_Time_Min"), min, sec)
  elseif 3600 <= remainTime and remainTime < 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("StarTower_Reward_Refresh_Remain_Time_Hour"), hour, min)
  elseif 86400 <= remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("StarTower_Reward_Refresh_Remain_Time_Day"), day, hour)
  end
  NovaAPI.SetTMPText(self._mapNode.TMPTicketTimeHint, orderedFormat(ConfigTable.GetUIText("WeeklyBoss_TicketTime"), sTimeStr))
end

function WeeklyCopiesCtrl:RefreshSelectMonster(index)
  self._mapNode.mImgBgAni:Play("WeeklyCopiesPanelBg_in", 0, 0)
  self._mapNode.mInfoAni:Play("MonsterInfoNode_in", 0, 0)
  for i = 0, self._mapNode.mListContent.transform.childCount - 1 do
    local child = self._mapNode.mListContent.transform:GetChild(i)
    local imgChoose = child.transform:Find("btnGrid/AnimRoot/imgChoose").gameObject
    imgChoose:SetActive(index == i)
  end
  self:RefreshDiffToggleContent()
  local bgName = self.curSelectBossType.BossBg
  if bgName ~= "" then
    self:SetPngSprite(self._mapNode.mBg, bgName)
  end
  local mImgPath = self.curSelectBossType.Episode
  if mImgPath ~= "" then
    self:SetPngSprite(self._mapNode.mImage, mImgPath)
  end
end

function WeeklyCopiesCtrl:RefreshDiffToggleContent()
  self.curSelectDiff = 1
  local diffList = {}
  
  local function sortMList(a, b)
    return a.Difficulty < b.Difficulty
  end
  
  local function func_ForEach_BossLevel(bossLevelData)
    if bossLevelData.Type == self.curSelectBossType.Id then
      table.insert(diffList, bossLevelData)
    end
  end
  
  ForEachTableLine(DataTable.WeekBossLevel, func_ForEach_BossLevel)
  table.sort(diffList, sortMList)
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local initSelIndex = 1
  local highLvIndex = 1
  for i = 1, #diffList do
    local bossLevelData = diffList[i]
    local childGrid
    if i > self._mapNode.mDiffContent.childCount then
      childGrid = instantiate(self._mapNode.mDiffGrid, self._mapNode.mDiffContent)
    else
      childGrid = self._mapNode.mDiffContent:GetChild(i - 1)
    end
    if childGrid ~= nil then
      do
        local diffSelectNode = childGrid.transform:Find("btnGrid/AnimRoot/Select")
        local diffSelectName = diffSelectNode:Find("TMPDiffNameSelect"):GetComponent("TMP_Text")
        local diffUnSelectNode = childGrid.transform:Find("btnGrid/AnimRoot/unSelect")
        local diffUnSelectName = diffUnSelectNode:Find("TMPDiffNameUnSelect"):GetComponent("TMP_Text")
        local diff = orderedFormat(ConfigTable.GetUIText("WeeklyBoss_Diff"), tostring(bossLevelData.Difficulty))
        NovaAPI.SetTMPText(diffSelectName, diff)
        NovaAPI.SetTMPText(diffUnSelectName, diff)
        local lockMask = childGrid.transform:Find("btnGrid/AnimRoot/lockMask")
        local preLevelId = bossLevelData.PreLevelId
        local bLocked = false
        if 0 < preLevelId then
          local preLevelData = PlayerData.RogueBoss:GetCacheWeeklyBossMsg(preLevelId)
          bLocked = preLevelData == nil
          lockMask.gameObject:SetActive(bLocked)
          if bLocked == false then
            if 0 < self.initSelDiffId and self.initSelDiffId == bossLevelData.Id then
              initSelIndex = i
            end
            highLvIndex = i
          end
        else
          lockMask.gameObject:SetActive(false)
        end
        local bUnable = nWorldClass < bossLevelData.NeedWorldClass
        local btn = childGrid.transform:Find("btnGrid"):GetComponent("UIButton")
        btn.onClick:RemoveAllListeners()
        local func_Handler = ui_handler(self, function()
          if bLocked then
            EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("WeeklyBoss_TipDiff"))
          elseif bUnable then
            self.curSelectBossLevelData = bossLevelData
            self:RefreshMonsterInfoShow()
            self:RefreshDiffToggleShow(i, true)
          elseif bossLevelData.Id ~= self.curSelectBossLevelData.Id then
            self.curSelectBossLevelData = bossLevelData
            self:RefreshMonsterInfoShow()
            self:RefreshDiffToggleShow(i, true)
          end
        end, btn.gameObject, i)
        btn.onClick:AddListener(func_Handler)
        childGrid.gameObject:SetActive(true)
      end
    end
  end
  local childGridCount = self._mapNode.mDiffContent.childCount
  if childGridCount > #diffList then
    for i = #diffList, childGridCount - 1 do
      if i <= childGridCount then
        local childGrid = self._mapNode.mDiffContent:GetChild(i)
        childGrid.gameObject:SetActive(false)
      end
    end
  end
  if initSelIndex == 1 then
    initSelIndex = highLvIndex
  end
  self.curSelectBossLevelData = diffList[initSelIndex]
  self:RefreshMonsterInfoShow()
  self:RefreshDiffToggleShow(initSelIndex, false)
end

function WeeklyCopiesCtrl:RefreshDiffToggleShow(selIndex, playAni)
  if playAni then
    self._mapNode.mInfoAni:Play("MonsterInfoNode_in1", 0, 0)
  end
  if self.curSelectBossLevelData == nil then
    return
  end
  local nWorldClass = PlayerData.Base:GetWorldClass()
  local go = nWorldClass >= self.curSelectBossLevelData.NeedWorldClass
  self._mapNode.goNode:SetActive(go)
  self._mapNode.emptyNode:SetActive(not go)
  if go == false then
    NovaAPI.SetTMPText(self._mapNode.txtLevelLimit, orderedFormat(ConfigTable.GetUIText("WeeklyBoss_LevelLimit"), self.curSelectBossLevelData.NeedWorldClass))
  end
  local cacheLevelData = PlayerData.RogueBoss:GetCacheWeeklyBossMsg(self.curSelectBossLevelData.Id)
  if cacheLevelData == nil then
    NovaAPI.SetTMPText(self._mapNode.txtThroughTime, ConfigTable.GetUIText("WeeklyBoss_ThroughTimeNoData"))
  else
    local throughTime = cacheLevelData.Time
    local time = 0
    if throughTime ~= nil then
      time = throughTime
    end
    local m = math.floor(time / 60)
    local s = time % 60
    NovaAPI.SetTMPText(self._mapNode.txtThroughTime, orderedFormat(ConfigTable.GetUIText("WeeklyBoss_ThroughTime"), m, s))
  end
  for i = 0, self._mapNode.mDiffContent.childCount - 1 do
    local childGrid = self._mapNode.mDiffContent:GetChild(i)
    local selNode = childGrid.transform:Find("btnGrid/AnimRoot/Select").gameObject
    local unSelNode = childGrid.transform:Find("btnGrid/AnimRoot/unSelect").gameObject
    selNode:SetActive(i == selIndex - 1)
    unSelNode:SetActive(i ~= selIndex - 1)
  end
end

function WeeklyCopiesCtrl:RefreshMonsterInfoShow()
  if self.curSelectBossLevelData ~= nil then
    NovaAPI.SetTMPText(self._mapNode.mInfoName, self.curSelectBossLevelData.Name)
    NovaAPI.SetTMPText(self._mapNode.mInfoLv, self.curSelectBossLevelData.SuggestedPower)
    local path = "Icon/BuildRank/BuildRank_" .. self.curSelectBossLevelData.SuggestedBuild
    self:SetPngSprite(self._mapNode.mInfoBuildRank, path)
    for i = 1, 5 do
      local sName = "EntryGroupId" .. i
      local nSkillId = self.curSelectBossLevelData[sName]
      self._mapNode.Skill[i]:SetMonsterSkill(nSkillId)
    end
    self:RefreshRewardInfo()
  end
  for i = 0, 2 do
    self._mapNode.mElementNode:GetChild(i).gameObject:SetActive(false)
  end
  local eList = self.curSelectBossType.EET
  for i = 1, #eList do
    local icon = self._mapNode.mElementNode:GetChild(i):GetComponent("Image")
    local sName = AllEnum.ElementIconType.Icon .. eList[i]
    self:SetAtlasSprite(icon, "12_rare", sName)
    icon.gameObject:SetActive(true)
  end
  local antiList = self.curSelectBossType.AntiEET
  if antiList == nil or #antiList == 0 then
    self._mapNode.TabDuel2:SetActive(false)
  else
    for i = 0, 2 do
      self._mapNode.mAntiElementNode:GetChild(i).gameObject:SetActive(false)
    end
    for i = 1, #antiList do
      local icon = self._mapNode.mAntiElementNode:GetChild(i):GetComponent("Image")
      local sName = AllEnum.ElementIconType.Icon .. antiList[i]
      self:SetAtlasSprite(icon, "12_rare", sName)
      icon.gameObject:SetActive(true)
    end
    self._mapNode.TabDuel2:SetActive(true)
  end
end

function WeeklyCopiesCtrl:RefreshRewardInfo()
  local tbReward = decodeJson(self.curSelectBossLevelData.BaseAwardPreview)
  self.tbReward = tbReward
  local mapLevelInfo = PlayerData.RogueBoss:GetCacheWeeklyBossMsg(self.curSelectBossLevelData.Id)
  local isFirstPass = mapLevelInfo ~= nil
  for index = 1, 5 do
    if tbReward[index] ~= nil then
      local nLastIndex = #tbReward[index]
      local bReceived = false
      if tbReward[index][nLastIndex] == 1 and isFirstPass then
        bReceived = true
      elseif tbReward[index][nLastIndex] == 2 then
        bReceived = true
      end
      table.insert(self.tbReward[index], bReceived)
    end
  end
  self.tbAfterReward = {}
  for key, value in pairs(self.tbReward) do
    local nLastIndex = #self.tbReward[key]
    if not self.tbReward[key][nLastIndex] then
      table.remove(value)
      table.insert(self.tbAfterReward, value)
    end
  end
  for index = 1, 5 do
    self._mapNode.btn_item[index].interactable = self.tbAfterReward[index] ~= nil
    if self.tbAfterReward[index] ~= nil then
      local nLastIndex = #self.tbAfterReward[index]
      self._mapNode.item[index]:SetItem(self.tbAfterReward[index][1], nil, UTILS.ParseRewardItemCount(self.tbAfterReward[index]), nil, false, self.tbAfterReward[index][nLastIndex] == 1, self.tbAfterReward[index][nLastIndex] == 2, true)
    else
      self._mapNode.item[index]:SetItem(nil)
    end
  end
end

function WeeklyCopiesCtrl:OnBtnClick_Skill(btn, nidx)
  if self.curSelectBossLevelData ~= nil then
    local sName = "EntryGroupId" .. nidx
    local nSkillId = self.curSelectBossLevelData[sName]
    if nSkillId ~= 0 then
      local mapData = {
        nSkillId = nSkillId,
        bMonster = true,
        bBoss = true
      }
      EventManager.Hit(EventId.OpenPanel, PanelId.SkillTips, btn.transform, mapData)
    end
  end
end

function WeeklyCopiesCtrl:OnBtnClick_Reward(btn, nidx)
  if self.tbAfterReward == nil or self.tbAfterReward[nidx] == nil then
    return
  end
  local nTid = self.tbAfterReward[nidx][1]
  if nTid == nil then
    return
  end
  local rtBtn = self._mapNode.item[nidx].gameObject.transform
  UTILS.ClickItemGridWithTips(nTid, rtBtn, false, true, false)
end

function WeeklyCopiesCtrl:OnBtnClick_AllReward(btn)
  local tbExtraDropReward
  self._mapNode.goRewardList:OpenPanel(self.tbReward, tbExtraDropReward)
end

function WeeklyCopiesCtrl:OnClickBtnCrusade()
  local nTicketCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.RogueHardCoreTick)
  if 0 < nTicketCount then
    self:GoLevel()
  else
    self:ShowMsgNode(ConfigTable.GetUIText("WeeklyBoss_TipContent"))
  end
end

function WeeklyCopiesCtrl:OnClickBtnTicket(btn)
  UTILS.ClickItemGridWithTips(AllEnum.CoinItemId.RogueHardCoreTick, btn.transform, true, true, false)
end

function WeeklyCopiesCtrl:GoLevel()
  PlayerData.RogueBoss:SetSelBuildId(0)
  PlayerData.RogueBoss:SetSelLvId(self.curSelectBossLevelData.Id)
  
  local function OpenPanel()
    EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.WeeklyCopies)
  end
  
  EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
end

function WeeklyCopiesCtrl:OnClickBtnGo()
  self:CloseMsgNode()
  self:GoLevel()
end

function WeeklyCopiesCtrl:OnClickBtnCancel()
  self:CloseMsgNode()
end

function WeeklyCopiesCtrl:ShowMsgNode(msgContent)
  self._mapNode.winTipNode:SetActive(true)
  self._mapNode.mMsgAni:Play("t_window_04_t_in", 0, 0)
  NovaAPI.SetTMPText(self._mapNode.txtTipContent, msgContent)
end

function WeeklyCopiesCtrl:CloseMsgNode()
  local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.mMsgAni, {
    "t_window_04_t_out"
  })
  self:AddTimer(1, nAnimLen, "CloseMsgNodeCallback", true, true, true)
  self._mapNode.mMsgAni:Play("t_window_04_t_out", 0, 0)
end

function WeeklyCopiesCtrl:CloseMsgNodeCallback()
  self._mapNode.winTipNode:SetActive(false)
end

function WeeklyCopiesCtrl:OnDisable()
end

function WeeklyCopiesCtrl:OnDestroy()
end

function WeeklyCopiesCtrl:OnRelease()
end

function WeeklyCopiesCtrl:OnEvent_Back(nPanelId)
  PlayerData.RogueBoss:SetIsWeeklyCopies(false)
  EventManager.Hit(EventId.CloesCurPanel)
end

function WeeklyCopiesCtrl:OnEvent_Home(nPanelId)
  PlayerData.RogueBoss:SetIsWeeklyCopies(false)
  PanelManager.Home()
end

return WeeklyCopiesCtrl
