local GoldenSpyLevelSelectCtrl = class("GoldenSpyLevelSelectCtrl", BaseCtrl)
local UIAssetPath = "UI_Activity/_%s/SpriteAtlas/"
local PanelTab = {Group = 1, Level = 2}
local GroupState = {
  Normal = 1,
  LockByTime = 2,
  LockByPreGroup = 3
}
GoldenSpyLevelSelectCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  GroupSelectRoot = {},
  btn_task = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Task"
  },
  txt_task = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpy_QuestTitle"
  },
  reddot_task = {},
  btn_Group = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Group"
  },
  LevelDetalRoot = {},
  reward = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btn_go = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txt_go = {
    sComponentName = "TMP_Text",
    sLanguageId = "GoldenSpy_Go"
  },
  img_Pass = {},
  go_lockTips = {},
  txt_lockTips = {sComponentName = "TMP_Text"},
  btnRight = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Right"
  },
  btnLeft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Left"
  },
  btn_level = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Level"
  },
  img_select = {nCount = 2}
}
GoldenSpyLevelSelectCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnEvent_BackHome",
  [EventId.UIHomeConfirm] = "OnEvent_Home"
}
GoldenSpyLevelSelectCtrl._mapRedDotConfig = {}

function GoldenSpyLevelSelectCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActivityId = param[1]
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 1.5)
end

function GoldenSpyLevelSelectCtrl:OnEnable()
  self.animator = self.gameObject:GetComponent("Animator")
  local mapActivityData = ConfigTable.GetData("Activity", self.nActivityId)
  if mapActivityData ~= nil then
    local nGroupId = mapActivityData.MidGroupId
    local mapGroupData = PlayerData.Activity:GetActivityGroupDataById(nGroupId)
    if mapGroupData ~= nil then
      local actData = mapGroupData:GetActivityDataByIndex(AllEnum.ActivityThemeFuncIndex.Task)
      if actData ~= nil then
        RedDotManager.RegisterNode(RedDotDefine.Activity_Group_Task_Group, {
          nGroupId,
          actData.ActivityId,
          mapActivityData.MiniGameRedDot
        }, self._mapNode.reddot_task)
      else
        self._mapNode.reddot_task:SetActive(false)
      end
    else
      self._mapNode.reddot_task:SetActive(false)
    end
  else
    self._mapNode.reddot_task:SetActive(false)
  end
  if self._panel.nPanelTab == PanelTab.Level then
    local lastGroupId, lastLevelId = self.GoldenSpyActData:GetLastLevelData()
    if lastGroupId ~= 0 then
      self._panel.nSelectGroupId = lastGroupId
    end
    if lastLevelId ~= 0 then
      self._panel.nSelectLevelId = lastLevelId
    else
      local groupCfg = ConfigTable.GetData("GoldenSpyLevelGroup", self._panel.nSelectGroupId)
      for _, v in ipairs(groupCfg.LevelList) do
        local levelData = self.GoldenSpyActData:GetLevelDataById(v)
        if levelData ~= nil and not levelData.bFirstComplete then
          self._panel.nSelectLevelId = v
          break
        end
      end
    end
  end
  self:SwitchPanelTab(self._panel.nPanelTab)
end

function GoldenSpyLevelSelectCtrl:SwitchPanelTab(nTab)
  local oldTab = self._panel.nPanelTab
  self._panel.nPanelTab = nTab
  if nTab == PanelTab.Group then
    if oldTab == PanelTab.Level then
      self.animator:Play("GoldenSpyLevelSelectPanel_idle")
    end
    self:InitGroupData()
    self._mapNode.GroupSelectRoot.gameObject:SetActive(true)
    self._mapNode.LevelDetalRoot.gameObject:SetActive(false)
  elseif nTab == PanelTab.Level then
    self.animator:Play("GoldenSpyLevelSelectPanel_switch")
    EventManager.Hit(EventId.TemporaryBlockInput, 1.2)
    for i = 1, 2 do
      local levelCount = #ConfigTable.GetData("GoldenSpyLevelGroup", self._panel.nSelectGroupId).LevelList
      self._mapNode.btn_level[i].gameObject:SetActive(i <= levelCount)
      self._mapNode.img_select[i].gameObject:SetActive(self._panel.nSelectLevelId == ConfigTable.GetData("GoldenSpyLevelGroup", self._panel.nSelectGroupId).LevelList[i])
    end
    self:InitLevelData()
    self._mapNode.GroupSelectRoot.gameObject:SetActive(false)
    self._mapNode.LevelDetalRoot.gameObject:SetActive(true)
  end
end

function GoldenSpyLevelSelectCtrl:InitGroupData()
  self.tbGroupStateList = {}
  self.GoldenSpyActData = PlayerData.Activity:GetActivityDataById(self.nActivityId)
  if self.GoldenSpyActData == nil then
    return
  end
  self.tbGroupIdList = ConfigTable.GetData("GoldenSpyControl", self.nActivityId).LevelGroupList
  for i, v in ipairs(self.tbGroupIdList) do
    local groupData = self.GoldenSpyActData:GetLevelGroupDataById(v)
    if groupData ~= nil then
      local groupCfg = ConfigTable.GetData("GoldenSpyLevelGroup", v)
      if groupCfg ~= nil then
        local btn = self._mapNode.btn_Group[i]
        local normalRoot = btn.transform:Find("AnimRoot/normalRoot")
        local lockByTimeRoot = btn.transform:Find("AnimRoot/lockByTimeRoot")
        local lockByPreGroupRoot = btn.transform:Find("AnimRoot/lockByPreGroupRoot")
        normalRoot.gameObject:SetActive(false)
        lockByTimeRoot.gameObject:SetActive(false)
        lockByPreGroupRoot.gameObject:SetActive(false)
        if CS.ClientManager.Instance.serverTimeStamp < groupData.nStartTime and groupData.nStartTime ~= 0 then
          lockByTimeRoot.gameObject:SetActive(true)
          table.insert(self.tbGroupStateList, GroupState.LockByTime)
        elseif not self.GoldenSpyActData:CheckPreGroupPassByGroupId(v) then
          lockByPreGroupRoot.gameObject:SetActive(true)
          table.insert(self.tbGroupStateList, GroupState.LockByPreGroup)
        else
          normalRoot.gameObject:SetActive(true)
          table.insert(self.tbGroupStateList, GroupState.Normal)
        end
        local reddot = normalRoot.transform:Find("bg_GroupName/go_new")
        local actGroupId = ConfigTable.GetData("Activity", self.nActivityId).MidGroupId
        RedDotManager.RegisterNode(RedDotDefine.Activity_GoldenSpy_Group, {actGroupId, v}, reddot.gameObject)
        local bg = normalRoot.transform:Find("bg"):GetComponent("Image")
        local txt_GroupName = normalRoot.transform:Find("bg_GroupName/txt_GroupName"):GetComponent("TMP_Text")
        local tbPointList = {}
        for i = 1, 3 do
          local point = normalRoot.transform:Find("GameObject/point" .. i)
          point.gameObject:SetActive(false)
          local img_pass = point.transform:Find("img_pass")
          img_pass.gameObject:SetActive(false)
          table.insert(tbPointList, point)
        end
        self:SetPngSprite(bg, string.format(UIAssetPath, self.nActivityId) .. groupCfg.IconPath)
        NovaAPI.SetTMPText(txt_GroupName, groupCfg.GroupName)
        for m, n in ipairs(groupCfg.LevelList) do
          local levelData = self.GoldenSpyActData:GetLevelDataById(n)
          if levelData ~= nil then
            tbPointList[m].gameObject:SetActive(true)
            local levelCfg = ConfigTable.GetData("GoldenSpyLevel", n)
            if not (levelData.nMaxScore < levelCfg.Score) then
              local img_pass = tbPointList[m].transform:Find("img_pass")
              img_pass.gameObject:SetActive(true)
            end
          end
        end
        local bg_lock = lockByPreGroupRoot.transform:Find("bg"):GetComponent("Image")
        local txt_GroupName_Lock = lockByPreGroupRoot.transform:Find("bg_GroupName/txt_GroupName"):GetComponent("TMP_Text")
        local txt_lock = lockByPreGroupRoot.transform:Find("txt_lock"):GetComponent("TMP_Text")
        self:SetPngSprite(bg_lock, string.format(UIAssetPath, self.nActivityId) .. groupCfg.IconPath)
        NovaAPI.SetTMPText(txt_GroupName_Lock, groupCfg.GroupName)
        local nIndex = table.indexof(self.tbGroupIdList, v)
        if 1 < nIndex then
          local preGroupId = self.tbGroupIdList[nIndex - 1]
          local preGroupCfg = ConfigTable.GetData("GoldenSpyLevelGroup", preGroupId)
          NovaAPI.SetTMPText(txt_lock, orderedFormat(ConfigTable.GetUIText("GoldenSpy_LevelGroup_Lock_PreGroup"), preGroupCfg.GroupName))
        end
        local txt_time = lockByTimeRoot.transform:Find("txt_time"):GetComponent("TMP_Text")
        local nStartTime = self.GoldenSpyActData:GetGroupStartTime(v)
        local curTime = CS.ClientManager.Instance.serverTimeStamp
        if 0 < nStartTime then
          local remainTime = nStartTime - CS.ClientManager.Instance.serverTimeStamp
          local sTimeStr = self:GetTimeText(remainTime)
          NovaAPI.SetTMPText(txt_time, orderedFormat(ConfigTable.GetUIText("GoldenSpy_TimeTips") or "", sTimeStr))
        end
      end
    end
  end
end

function GoldenSpyLevelSelectCtrl:InitLevelData()
  local groupCfg = ConfigTable.GetData("GoldenSpyLevelGroup", self._panel.nSelectGroupId)
  if groupCfg == nil then
    return
  end
  local levelCfg = ConfigTable.GetData("GoldenSpyLevel", self._panel.nSelectLevelId)
  if levelCfg == nil then
    return
  end
  local levelData = self.GoldenSpyActData:GetLevelDataById(self._panel.nSelectLevelId)
  local levelRoot = self._mapNode.LevelDetalRoot
  local txt_GroupName = levelRoot.transform:Find("bg_GroupName/txt_GroupName"):GetComponent("TMP_Text")
  local img_level = levelRoot.transform:Find("img_level"):GetComponent("Image")
  local txt_levelName = levelRoot.transform:Find("AnimRoot/GameObject/txt_levelName"):GetComponent("TMP_Text")
  local txt_floorCount = levelRoot.transform:Find("AnimRoot/GameObject/db_floor/txt_floorCount"):GetComponent("TMP_Text")
  local txt_levelDes = levelRoot.transform:Find("AnimRoot/txt_levelDes"):GetComponent("TMP_Text")
  local title_score = levelRoot.transform:Find("AnimRoot/Image/title_score"):GetComponent("TMP_Text")
  local txt_score = levelRoot.transform:Find("AnimRoot/Image/txt_score"):GetComponent("TMP_Text")
  local txt_target = levelRoot.transform:Find("AnimRoot/db_reward/txt_target"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txt_GroupName, groupCfg.GroupName)
  self:SetPngSprite(img_level, string.format(UIAssetPath, self.nActivityId) .. levelCfg.IconPath)
  NovaAPI.SetTMPText(txt_levelName, levelCfg.LevelName)
  local nTotalFloor = #levelCfg.FloorList
  NovaAPI.SetTMPText(txt_floorCount, orderedFormat(ConfigTable.GetUIText("GoldenSpy_TotalFloor"), nTotalFloor))
  NovaAPI.SetTMPText(txt_levelDes, levelCfg.LevelDesc)
  NovaAPI.SetTMPText(title_score, ConfigTable.GetUIText("GoldenSpy_HighestScoreTitle"))
  NovaAPI.SetTMPText(txt_score, orderedFormat(ConfigTable.GetUIText("GoldenSpy_HighestScore"), levelData.nMaxScore))
  NovaAPI.SetTMPText(txt_target, levelCfg.WinCondDesc)
  for i = 1, 2 do
    self._mapNode.reward[i]:SetItem(levelCfg["Item" .. i .. "Id"], nil, levelCfg["Item" .. i .. "Count"], nil, levelData.bFirstComplete, nil, nil, false)
    local btn_reward = self._mapNode.reward[i].gameObject:GetComponent("UIButton")
    btn_reward.onClick:RemoveAllListeners()
    
    local function clickCb()
      UTILS.ClickItemGridWithTips(levelCfg["Item" .. i .. "Id"], btn_reward.transform, true, false, false)
    end
    
    btn_reward.onClick:AddListener(clickCb)
  end
  local bPreLevelPass = self.GoldenSpyActData:CheckPreLevelPassById(self._panel.nSelectLevelId)
  if bPreLevelPass then
    self._mapNode.btn_go.gameObject:SetActive(true)
    self._mapNode.go_lockTips.gameObject:SetActive(false)
  else
    self._mapNode.btn_go.gameObject:SetActive(false)
    local preLevelData = self.GoldenSpyActData:GetLevelDataById(levelCfg.PreLevelId)
    if preLevelData ~= nil then
      local preLevelCfg = ConfigTable.GetData("GoldenSpyLevel", levelCfg.PreLevelId)
      NovaAPI.SetTMPText(self._mapNode.txt_lockTips, orderedFormat(ConfigTable.GetUIText("GoldenSpy_LockTips"), preLevelCfg.LevelName))
      self._mapNode.go_lockTips.gameObject:SetActive(true)
    end
  end
  self._mapNode.img_Pass.gameObject:SetActive(levelData.bFirstComplete)
  local preGroupId = self.GoldenSpyActData:GetPreGroup(self._panel.nSelectGroupId)
  local nextGroupId = self.GoldenSpyActData:GetNextGroup(self._panel.nSelectGroupId)
  local bCanGoNextGroup = false
  if nextGroupId ~= nil then
    local groupData = self.GoldenSpyActData:GetLevelGroupDataById(nextGroupId)
    if groupData ~= nil then
      local time = CS.ClientManager.Instance.serverTimeStamp
      if time >= groupData.nStartTime and self.GoldenSpyActData:CheckPreGroupPassByGroupId(nextGroupId) then
        bCanGoNextGroup = true
      end
    end
  end
  self._mapNode.btnRight.gameObject:SetActive(nextGroupId ~= nil and bCanGoNextGroup)
  self._mapNode.btnLeft.gameObject:SetActive(preGroupId ~= nil)
end

function GoldenSpyLevelSelectCtrl:GetTimeText(remainTime)
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  return sTimeStr
end

function GoldenSpyLevelSelectCtrl:OnBtnClick_Task()
  local mapActivityData = ConfigTable.GetData("Activity", self.nActivityId)
  if mapActivityData ~= nil then
    local nGroupId = mapActivityData.MidGroupId
    local mapGroupData = PlayerData.Activity:GetActivityGroupDataById(nGroupId)
    if mapGroupData ~= nil then
      local actData = mapGroupData:GetActivityDataByIndex(AllEnum.ActivityThemeFuncIndex.Task)
      if actData ~= nil then
        EventManager.Hit(EventId.OpenPanel, PanelId.Task_10112, actData.ActivityId, 4)
      end
    end
  end
end

function GoldenSpyLevelSelectCtrl:OnBtnClick_Group(btn, nIndex)
  local groupState = self.tbGroupStateList[nIndex]
  if groupState ~= GroupState.Normal then
    return
  end
  self._panel.nSelectGroupId = self.tbGroupIdList[nIndex]
  local groupCfg = ConfigTable.GetData("GoldenSpyLevelGroup", self._panel.nSelectGroupId)
  local tempLevelId = groupCfg.LevelList[1]
  for _, v in ipairs(groupCfg.LevelList) do
    local levelData = self.GoldenSpyActData:GetLevelDataById(v)
    if levelData ~= nil then
      tempLevelId = v
      if not levelData.bFirstComplete then
        break
      end
    end
  end
  self._panel.nSelectLevelId = tempLevelId
  self:SwitchPanelTab(PanelTab.Level)
  self.GoldenSpyActData:EnterGroupSelect(self._panel.nSelectGroupId)
end

function GoldenSpyLevelSelectCtrl:OnBtnClick_Level(btn, nIndex)
  for i = 1, 2 do
    self._mapNode.img_select[i].gameObject:SetActive(i == nIndex)
  end
  local groupCfg = ConfigTable.GetData("GoldenSpyLevelGroup", self._panel.nSelectGroupId)
  self._panel.nSelectLevelId = groupCfg.LevelList[nIndex]
  self:InitLevelData()
end

function GoldenSpyLevelSelectCtrl:OnBtnClick_Go()
  self.GoldenSpyActData:StartLevel(self._panel.nSelectGroupId, self._panel.nSelectLevelId)
end

function GoldenSpyLevelSelectCtrl:OnBtnClick_Right()
  local nextGroupId = self.GoldenSpyActData:GetNextGroup(self._panel.nSelectGroupId)
  if nextGroupId ~= nil then
    self._panel.nSelectGroupId = nextGroupId
    local groupCfg = ConfigTable.GetData("GoldenSpyLevelGroup", self._panel.nSelectGroupId)
    local tempLevelId = groupCfg.LevelList[1]
    for _, v in ipairs(groupCfg.LevelList) do
      local levelData = self.GoldenSpyActData:GetLevelDataById(v)
      if levelData ~= nil then
        tempLevelId = v
        if not levelData.bFirstComplete then
          break
        end
      end
    end
    self._panel.nSelectLevelId = tempLevelId
    for i = 1, 2 do
      local levelCount = #groupCfg.LevelList
      self._mapNode.btn_level[i].gameObject:SetActive(i <= levelCount)
      self._mapNode.img_select[i].gameObject:SetActive(self._panel.nSelectLevelId == groupCfg.LevelList[i])
    end
    self:InitLevelData()
    self.GoldenSpyActData:EnterGroupSelect(self._panel.nSelectGroupId)
  end
end

function GoldenSpyLevelSelectCtrl:OnBtnClick_Left()
  local preGroupId = self.GoldenSpyActData:GetPreGroup(self._panel.nSelectGroupId)
  if preGroupId ~= nil then
    self._panel.nSelectGroupId = preGroupId
    local groupCfg = ConfigTable.GetData("GoldenSpyLevelGroup", self._panel.nSelectGroupId)
    local tempLevelId = groupCfg.LevelList[1]
    for _, v in ipairs(groupCfg.LevelList) do
      local levelData = self.GoldenSpyActData:GetLevelDataById(v)
      if levelData ~= nil then
        tempLevelId = v
        if not levelData.bFirstComplete then
          break
        end
      end
    end
    self._panel.nSelectLevelId = tempLevelId
    for i = 1, 2 do
      local levelCount = #groupCfg.LevelList
      self._mapNode.btn_level[i].gameObject:SetActive(i <= levelCount)
      self._mapNode.img_select[i].gameObject:SetActive(self._panel.nSelectLevelId == groupCfg.LevelList[i])
    end
    self:InitLevelData()
    self.GoldenSpyActData:EnterGroupSelect(self._panel.nSelectGroupId)
  end
end

function GoldenSpyLevelSelectCtrl:OnEvent_BackHome(nPanelId)
  if nPanelId == self._panel._nPanelId then
    if self._panel.nPanelTab == PanelTab.Group then
      EventManager.Hit(EventId.ClosePanel, self._panel._nPanelId)
    elseif self._panel.nPanelTab == PanelTab.Level then
      self:SwitchPanelTab(PanelTab.Group)
    end
  end
end

function GoldenSpyLevelSelectCtrl:OnEvent_Home(nPanelId)
  if nPanelId == self._panel._nPanelId then
    PanelManager.Home()
  end
end

return GoldenSpyLevelSelectCtrl
