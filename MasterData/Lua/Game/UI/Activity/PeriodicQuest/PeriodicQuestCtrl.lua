local PeriodicQuestCtrl = class("PeriodicQuestCtrl", BaseCtrl)
PeriodicQuestCtrl._mapNodeConfig = {
  loopSv = {
    sNodeName = "srGuideQuest",
    sComponentName = "LoopScrollView"
  },
  rtDays = {},
  PerActGroupItem = {
    nCount = 7,
    sCtrlName = "Game.UI.Activity.PeriodicQuest.PeriodicQuestGroupCtrl"
  },
  btnGroup = {
    sNodeName = "PerActGroupItem",
    nCount = 7,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Group"
  },
  btnGroupLock = {
    sNodeName = "btnGroupLock",
    nCount = 7,
    sComponentName = "UIButton",
    callback = "OnBtnClick_GroupLock"
  },
  btnQuickRec = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_QuickRec"
  },
  btnCanNotQuickRec = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CannotQuickRec"
  },
  txtBtnQuickRec = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Btn_Quick_Receive"
  },
  txtBtnCannotQuickRec = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_Btn_Quick_Receive"
  },
  btnShop = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Shop"
  },
  btnGuideMission = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GuideMission"
  },
  txtBtnGuideMission = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_AvgReview"
  }
}
PeriodicQuestCtrl._mapEventConfig = {}

function PeriodicQuestCtrl:RefreshQuestList()
  self.tbAllQuestList = self.actData:GetQuestListByGroup()
  if nil == self.tbAllQuestList[self._panel.nSelectGroup] then
    printLog(string.format("任务列表为空！！！actId = %s, group = %s", self.nActId, self._panel.nSelectGroup))
    return
  end
  self.tbQuestList = self.tbAllQuestList[self._panel.nSelectGroup]
  table.sort(self.tbQuestList, function(a, b)
    if a.nStatus == b.nStatus then
      return a.Id < b.Id
    end
    return a.nStatus < b.nStatus
  end)
  for k, v in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(v)
    self.tbGridCtrl[k] = nil
  end
  if nil ~= self.tbQuestList then
    self.nPageCount = 0
    self._mapNode.loopSv:SetAnim(0.06)
    self._mapNode.loopSv:Init(#self.tbQuestList, self, self.OnGridRefresh, nil, false, self.GetGridPageCount)
    EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  end
  local _, _, canReceive = self.actData:GetQuestProgress()
  self._mapNode.btnQuickRec.gameObject:SetActive(0 < canReceive)
  self._mapNode.btnCanNotQuickRec.gameObject:SetActive(canReceive <= 0)
  for k, v in ipairs(self._mapNode.PerActGroupItem) do
    local nAllQuest, nReceivedQuest = self.actData:GetDayQuestStatus(k)
    v:RefreshStatus(nAllQuest <= nReceivedQuest and 0 < nReceivedQuest)
  end
end

function PeriodicQuestCtrl:GetGridPageCount(pageCount)
  self.nPageCount = pageCount > #self.tbQuestList and #self.tbQuestList or pageCount
end

function PeriodicQuestCtrl:InitGroupList()
  local nCurDay = self.actData:GetCurOpenDay()
  self.nMaxOpenGroup = 0
  local tbNextOpenGroupList = {}
  if nil ~= CacheTable.GetData("_PeriodicQuestGroup", self.nActId) then
    local tbGroup = CacheTable.GetData("_PeriodicQuestGroup", self.nActId)[nCurDay]
    if nil ~= tbGroup then
      for _, v in ipairs(tbGroup) do
        if v > self.nMaxOpenGroup then
          self.nMaxOpenGroup = v
        end
      end
    end
    if nil ~= CacheTable.GetData("_PeriodicQuestGroup", self.nActId)[nCurDay + 1] then
      for _, v in ipairs(CacheTable.GetData("_PeriodicQuestGroup", self.nActId)[nCurDay + 1]) do
        tbNextOpenGroupList[v] = 1
      end
    end
  end
  local nSelectGroup = self.actData:GetCanReceiveRewardGroup()
  if 0 == nSelectGroup then
    nSelectGroup = self.nMaxOpenGroup
  end
  for k, v in ipairs(self._mapNode.PerActGroupItem) do
    v:Init(self.nActId, k, self.nMaxOpenGroup)
    if nil ~= tbNextOpenGroupList[k] then
      local nHour = self.actData:GetNextDayOpenTime()
      if nHour < 1 then
        v:SetTime(orderedFormat(ConfigTable.GetUIText("PerActivity_Quest_Open_Time_2") or "", 1))
      else
        v:SetTime(orderedFormat(ConfigTable.GetUIText("PerActivity_Quest_Open_Time_1") or "", nHour))
      end
    end
  end
  if nil == self._panel.nSelectGroup then
    self._panel.nSelectGroup = nSelectGroup
  end
  self._mapNode.PerActGroupItem[self._panel.nSelectGroup]:SetSelect(true)
end

function PeriodicQuestCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Activity.PeriodicQuest.PeriodicQuestItemCtrl")
  end
  self.tbGridCtrl[nInstanceId]:SetData(self.nActId, self.tbQuestList[nIndex])
end

function PeriodicQuestCtrl:InitActData(actData, bResetGroup)
  self.actData = actData
  if bResetGroup then
    self._panel.nSelectGroup = nil
  end
  self.nActId = actData:GetActId()
  self.bQuestAnim = false
  self:InitGroupList()
  local tbAllQuestList = self.actData:GetQuestListByGroup()
  if nil == tbAllQuestList[self._panel.nSelectGroup] then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_1")
    })
    EventManager.Hit(EventId.ClosePanel, PanelId.ActivityList)
    return
  end
end

function PeriodicQuestCtrl:Awake()
  self.tbGridCtrl = {}
  self.tbSequences = {}
end

function PeriodicQuestCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function PeriodicQuestCtrl:OnBtnClick_Group(_, nIndex)
  if self._panel.nSelectGroup == nIndex then
    return
  end
  if nIndex > self.nMaxOpenGroup then
    return
  end
  if nil == self.tbAllQuestList[nIndex] or nil == next(self.tbAllQuestList[nIndex]) then
    printError(string.format("当前任务组下没有任务!!! 活动id = %d, 任务组 = %s", self.nActId, nIndex))
    return
  end
  self._mapNode.PerActGroupItem[self._panel.nSelectGroup]:SetSelect(false)
  if nil ~= self._mapNode.PerActGroupItem[nIndex] then
    self._mapNode.PerActGroupItem[nIndex]:SetSelect(true)
  end
  self._panel.nSelectGroup = nIndex
  self.bQuestAnim = true
  self:RefreshQuestList()
end

function PeriodicQuestCtrl:OnBtnClick_GroupLock()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("PerActivity_Not_Open"))
end

function PeriodicQuestCtrl:OnBtnClick_QuickRec()
  local function callback()
    EventManager.Hit("RefreshPeriodicAct", self.nActId)
    
    PlayerData.Base:TryOpenWorldClassUpgrade()
  end
  
  PlayerData.Activity:SendReceivePerQuest(self.nActId, 0, callback)
end

function PeriodicQuestCtrl:OnBtnClick_CannotQuickRec()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("InfinityTower_Reward_Tips"))
end

function PeriodicQuestCtrl:OnBtnClick_Shop()
  EventManager.Hit(EventId.OpenPanel, PanelId.GuideMission, 3)
end

function PeriodicQuestCtrl:OnBtnClick_GuideMission()
  local nActivityId = tonumber(self.actData:GetSpecialParam())
  if type(nActivityId) == "number" then
    local data = ConfigTable.GetData("ActivityStoryChapter", nActivityId)
    if data ~= nil then
      PlayerData.StoryReview:TryOpenStoryChapter(data.ChapterId)
    end
  end
end

return PeriodicQuestCtrl
