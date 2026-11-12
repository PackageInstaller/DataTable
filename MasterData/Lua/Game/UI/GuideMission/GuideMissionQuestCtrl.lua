local GuideMissionQuestCtrl = class("GuideMissionQuestCtrl", BaseCtrl)
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local TimerManager = require("GameCore.Timer.TimerManager")
local GuideMissionData = PlayerData.GuideMission
GuideMissionQuestCtrl._mapNodeConfig = {
  PerActGroupItem = {
    nCount = 7,
    sComponentName = "UIButton",
    callback = "OnGroupBtnClick"
  },
  btnGroupLock = {
    sNodeName = "btnGroupLock",
    nCount = 7,
    sComponentName = "UIButton",
    callback = "OnBtnClick_GroupLock"
  },
  imgChapterPicture = {sComponentName = "Image"},
  imgChapterStar = {sComponentName = "Image"},
  txtChapterIndex = {sComponentName = "TMP_Text"},
  txtTitle = {sComponentName = "TMP_Text"},
  srGuideQuest = {
    sComponentName = "LoopScrollView"
  },
  btnQuickRec = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_QuickRec"
  },
  txtBtnQuickRec = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Fast_Receive_Btn_Text"
  },
  btnGoBack = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GoBack"
  },
  txtBtnGoBack = {sComponentName = "TMP_Text", sLanguageId = "Go_Back"},
  btnQuickRecGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_QuickRecGray"
  },
  txtBtnQuickRecGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Fast_Receive_Btn_Text"
  }
}
GuideMissionQuestCtrl._mapEventConfig = {}

function GuideMissionQuestCtrl:RefreshPanel(nChapterId, nGroupIndex)
  self.nChapterId = nChapterId
  local mapChapter = ConfigTable.GetData("GuideMissionChapter", nChapterId)
  self:SetPngSprite(self._mapNode.imgChapterPicture, mapChapter.IconPath)
  self:SetPngSprite(self._mapNode.imgChapterStar, mapChapter.IconPath)
  NovaAPI.SetTMPText(self._mapNode.txtChapterIndex, mapChapter.Index)
  NovaAPI.SetTMPText(self._mapNode.txtTitle, mapChapter.Title)
  local tbGroupListRef = PlayerData.Quest:GetGuideMissionQuestGroupByChapter(nChapterId)
  self.tbGroupList = {}
  if tbGroupListRef ~= nil then
    for _, mapGroup in pairs(tbGroupListRef) do
      table.insert(self.tbGroupList, mapGroup)
    end
  end
  table.sort(self.tbGroupList, function(a, b)
    return a.Id < b.Id
  end)
  local mapJumpGroup = nGroupIndex ~= nil and self.tbGroupList[nGroupIndex] or nil
  local bJumpGroupUnlock = mapJumpGroup ~= nil and GuideMissionData:IsGroupUnlock(self.nChapterId, mapJumpGroup.Id)
  self:RefreshQuestList(bJumpGroupUnlock and nGroupIndex or self:GetDefaultGroupIndex())
end

function GuideMissionQuestCtrl:GetDefaultGroupIndex()
  local nDefaultIndex = 1
  local nMaxGroupId
  for nIndex, mapGroup in ipairs(self.tbGroupList) do
    local bUnlock = GuideMissionData:IsGroupUnlock(self.nChapterId, mapGroup.Id)
    if bUnlock and self:HasReceivableQuest(mapGroup.Id) and (nMaxGroupId == nil or nMaxGroupId < mapGroup.Id) then
      nMaxGroupId = mapGroup.Id
      nDefaultIndex = nIndex
    end
  end
  return nDefaultIndex
end

function GuideMissionQuestCtrl:HasReceivableQuest(nGroupId)
  local tbQuestList = PlayerData.Quest:GetGuideMissionQuestListByGroup(nGroupId)
  if tbQuestList == nil then
    return false
  end
  for _, mapQuest in pairs(tbQuestList) do
    local mapQuestData = PlayerData.Quest:GetGuideMissionQuestDataById(mapQuest.Id)
    if mapQuestData ~= nil and mapQuestData.nStatus == 1 then
      return true
    end
  end
  return false
end

function GuideMissionQuestCtrl:RefreshQuestList(nIndex)
  local mapGroup = self.tbGroupList[nIndex]
  if mapGroup == nil then
    return
  end
  local bUnlock = GuideMissionData:IsGroupUnlock(self.nChapterId, mapGroup.Id)
  if not bUnlock then
    return
  end
  self:RefreshGroupItemSelect(nIndex)
  self.nCurGroupIndex = nIndex
  EventManager.Hit("GuideMissionQuestGroupChange", self.nChapterId, nIndex)
  local tbQuestListRef = PlayerData.Quest:GetGuideMissionQuestListByGroup(mapGroup.Id)
  self.tbQuestList = {}
  if tbQuestListRef ~= nil then
    for _, mapQuest in pairs(tbQuestListRef) do
      table.insert(self.tbQuestList, mapQuest)
    end
  end
  local tbStatusOrder = {
    [1] = 0,
    [0] = 1,
    [2] = 2
  }
  table.sort(self.tbQuestList, function(a, b)
    local mapQuestDataA = PlayerData.Quest:GetGuideMissionQuestDataById(a.Id)
    local mapQuestDataB = PlayerData.Quest:GetGuideMissionQuestDataById(b.Id)
    local nStatusA = mapQuestDataA ~= nil and mapQuestDataA.nStatus or 0
    local nStatusB = mapQuestDataB ~= nil and mapQuestDataB.nStatus or 0
    if nStatusA ~= nStatusB then
      return tbStatusOrder[nStatusA] < tbStatusOrder[nStatusB]
    end
    return a.Id < b.Id
  end)
  self._mapNode.srGuideQuest:Init(#self.tbQuestList, self, self.OnGridRefresh)
  local bCanReceive = false
  local mapFirstQuestData = self.tbQuestList[1] ~= nil and PlayerData.Quest:GetGuideMissionQuestDataById(self.tbQuestList[1].Id) or nil
  if mapFirstQuestData ~= nil and mapFirstQuestData.nStatus == 1 then
    bCanReceive = true
  end
  self._mapNode.btnQuickRec.gameObject:SetActive(bCanReceive)
  self._mapNode.btnQuickRecGray.gameObject:SetActive(not bCanReceive)
end

function GuideMissionQuestCtrl:IsGroupQuestComplete(nGroupId)
  local tbQuestList = PlayerData.Quest:GetGuideMissionQuestListByGroup(nGroupId)
  if tbQuestList == nil or next(tbQuestList) == nil then
    return false
  end
  for _, mapQuest in pairs(tbQuestList) do
    local mapQuestData = PlayerData.Quest:GetGuideMissionQuestDataById(mapQuest.Id)
    local nStatus = mapQuestData ~= nil and mapQuestData.nStatus or 0
    if nStatus ~= 2 then
      return false
    end
  end
  return true
end

function GuideMissionQuestCtrl:RefreshGroupItemSelect(nIndex)
  local nNextUnlockGroupIndex, nNextUnlockTime
  for k, v in ipairs(self._mapNode.PerActGroupItem) do
    local mapGroup = self.tbGroupList[k]
    local bUnlock, nGroupUnlockTime = false, 0
    if mapGroup ~= nil then
      bUnlock, nGroupUnlockTime = GuideMissionData:IsGroupUnlock(self.nChapterId, mapGroup.Id)
    end
    local goNormal = v.gameObject.transform:Find("AnimRoot/goNormal")
    local goSelect = v.gameObject.transform:Find("AnimRoot/goSelect")
    local goLock = v.gameObject.transform:Find("AnimRoot/goLock")
    local imgComplete = v.gameObject.transform:Find("AnimRoot/imgComplete")
    NovaAPI.SetTMPText(goNormal:Find("txt_Group1"):GetComponent("TMP_Text"), k)
    NovaAPI.SetTMPText(goSelect:Find("txt_Group2"):GetComponent("TMP_Text"), k)
    NovaAPI.SetTMPText(goLock:Find("txt_Group3"):GetComponent("TMP_Text"), k)
    goLock.gameObject:SetActive(not bUnlock)
    goNormal.gameObject:SetActive(bUnlock and k ~= nIndex)
    goSelect.gameObject:SetActive(bUnlock and k == nIndex)
    local bGroupComplete = bUnlock and mapGroup ~= nil and self:IsGroupQuestComplete(mapGroup.Id)
    imgComplete.gameObject:SetActive(bGroupComplete)
    if not bUnlock and mapGroup ~= nil and nNextUnlockGroupIndex == nil then
      nNextUnlockGroupIndex = k
      nNextUnlockTime = nGroupUnlockTime
    end
    v.gameObject.transform:Find("AnimRoot/goTime").gameObject:SetActive(false)
    local redDotGroup = v.gameObject.transform:Find("AnimRoot/redDotGroup")
    if mapGroup ~= nil then
      RedDotManager.RegisterNode(RedDotDefine.GuideMission_Group, {
        self.nChapterId,
        mapGroup.Id
      }, redDotGroup.gameObject)
    end
  end
  if self.groupTimeTimer ~= nil then
    TimerManager.Remove(self.groupTimeTimer)
    self.groupTimeTimer = nil
  end
  if nNextUnlockGroupIndex ~= nil then
    self.nNextUnlockGroupIndex = nNextUnlockGroupIndex
    self.nNextUnlockTime = nNextUnlockTime
    self._mapNode.PerActGroupItem[nNextUnlockGroupIndex].gameObject.transform:Find("AnimRoot/goTime").gameObject:SetActive(true)
    self:RefreshGroupOpenTime()
    self.groupTimeTimer = self:AddTimer(0, 1, "RefreshGroupOpenTime", true, true, false)
  end
end

function GuideMissionQuestCtrl:RefreshGroupOpenTime()
  if self.nNextUnlockGroupIndex == nil then
    return
  end
  local v = self._mapNode.PerActGroupItem[self.nNextUnlockGroupIndex]
  local goTime = v.gameObject.transform:Find("AnimRoot/goTime")
  local txtOpenTime = goTime:Find("txtOpenTime"):GetComponent("TMP_Text")
  local nServerTimeStamp = CS.ClientManager.Instance.serverTimeStamp
  local remainTime = self.nNextUnlockTime - nServerTimeStamp
  if remainTime <= 0 then
    TimerManager.Remove(self.groupTimeTimer)
    self.groupTimeTimer = nil
    self:RefreshGroupItemSelect(self.nCurGroupIndex)
    return
  end
  local sTimeStr = ""
  if remainTime < 3600 then
    sTimeStr = orderedFormat(ConfigTable.GetUIText("PerActivity_Quest_Open_Time_2") or "", 1)
  else
    local hour = math.floor(remainTime / 3600)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("PerActivity_Quest_Open_Time_1") or "", hour)
  end
  NovaAPI.SetTMPText(txtOpenTime, sTimeStr)
end

function GuideMissionQuestCtrl:OnGridRefresh(goGrid, gridIndex)
  local index = gridIndex + 1
  local mapQuest = self.tbQuestList[index]
  local rootTrans = goGrid.transform:Find("AnimRoot/imgBg")
  local TMPTitle = rootTrans:Find("rtTitle/TMPTitle"):GetComponent("TMP_Text")
  local rtBarFill = rootTrans:Find("rtTitle/imgBarBg/rtBarFill"):GetComponent("RectTransform")
  local TMPProcess = rootTrans:Find("rtTitle/imgBarBg/TMPProcess"):GetComponent("TMP_Text")
  local btnReward1 = rootTrans:Find("btnReward1"):GetComponent("UIButton")
  local btnReward2 = rootTrans:Find("btnReward2"):GetComponent("UIButton")
  local itemReward1 = rootTrans:Find("btnReward1/AnimRoot/rtReward")
  local itemReward2 = rootTrans:Find("btnReward2/AnimRoot/rtReward")
  local btnReceive = rootTrans:Find("btnReceive"):GetComponent("UIButton")
  local txtBtnReceive = rootTrans:Find("btnReceive/AnimRoot/txtBtnReceive"):GetComponent("TMP_Text")
  local btnJump = rootTrans:Find("btnJump"):GetComponent("UIButton")
  local txtBtnJump = rootTrans:Find("btnJump/AnimRoot/txtBtnJump"):GetComponent("TMP_Text")
  local imgComplete = rootTrans:Find("imgComplete")
  local imgCompleteMask = rootTrans:Find("imgCompleteMask")
  NovaAPI.SetTMPText(TMPTitle, mapQuest.Title)
  NovaAPI.SetTMPText(txtBtnReceive, ConfigTable.GetUIText("Quest_Receive"))
  NovaAPI.SetTMPText(txtBtnJump, ConfigTable.GetUIText("Quest_JumpTo"))
  local mapQuestData = PlayerData.Quest:GetGuideMissionQuestDataById(mapQuest.Id)
  local nStatus = mapQuestData ~= nil and mapQuestData.nStatus or 0
  local nCurProgress = mapQuestData ~= nil and mapQuestData.nCurProgress or 0
  local nGoal = mapQuestData ~= nil and mapQuestData.nGoal or mapQuest.Goal or 0
  if nStatus ~= 2 then
    NovaAPI.SetTMPText(TMPProcess, string.format("%d/%d", nCurProgress, nGoal))
  else
    NovaAPI.SetTMPText(TMPProcess, ConfigTable.GetUIText("Quest_Complete"))
  end
  rtBarFill.sizeDelta = Vector2(0 < nGoal and nCurProgress / nGoal * rtBarFill.parent:GetComponent("RectTransform").rect.width or 0, rtBarFill.sizeDelta.y)
  btnReceive.gameObject:SetActive(nStatus == 1)
  btnReceive.onClick:RemoveAllListeners()
  btnReceive.onClick:AddListener(function()
    self:OnBtnClick_Receive(mapQuest)
  end)
  imgComplete.gameObject:SetActive(nStatus == 2)
  imgCompleteMask.gameObject:SetActive(nStatus == 2)
  btnJump.gameObject:SetActive(nStatus == 0 and mapQuest.JumpTo ~= nil and 0 < mapQuest.JumpTo)
  btnJump.onClick:RemoveAllListeners()
  btnJump.onClick:AddListener(function()
    self:OnBtnClick_JumpTo(mapQuest)
  end)
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = {
      itemReward1 = self:BindCtrlByNode(itemReward1, "Game.UI.TemplateEx.TemplateItemCtrl"),
      itemReward2 = self:BindCtrlByNode(itemReward2, "Game.UI.TemplateEx.TemplateItemCtrl")
    }
  end
  self.tbGridCtrl[nInstanceID].itemReward1:SetItem(mapQuest.Reward1Tid, nil, mapQuest.Reward1Qty)
  self.tbGridCtrl[nInstanceID].itemReward2:SetItem(mapQuest.Reward2Tid, nil, mapQuest.Reward2Qqty)
  btnReward1.onClick:RemoveAllListeners()
  btnReward1.onClick:AddListener(function()
    self:OnBtnClick_Reward(btnReward1, mapQuest.Reward1Tid)
  end)
  btnReward2.onClick:RemoveAllListeners()
  btnReward2.onClick:AddListener(function()
    self:OnBtnClick_Reward(btnReward2, mapQuest.Reward2Tid)
  end)
end

function GuideMissionQuestCtrl:OnBtnClick_JumpTo(mapQuest)
  JumpUtil.JumpTo(mapQuest.JumpTo)
end

function GuideMissionQuestCtrl:OnBtnClick_Reward(btn, nTid)
  local mapData = {
    nTid = nTid,
    bShowDepot = true,
    bShowJumpto = true
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
end

function GuideMissionQuestCtrl:OnBtnClick_Receive(mapQuest)
  PlayerData.Quest:ReceiveGuideMissionQuestReward(mapQuest.Id, false, function()
    self:RefreshQuestList(self.nCurGroupIndex)
  end)
end

function GuideMissionQuestCtrl:Awake()
end

function GuideMissionQuestCtrl:OnEnable()
  self.tbGridCtrl = {}
end

function GuideMissionQuestCtrl:OnDisable()
  for _, mapCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(mapCtrl.itemReward1)
    self:UnbindCtrlByNode(mapCtrl.itemReward2)
  end
  self.tbGridCtrl = {}
  if self.groupTimeTimer ~= nil then
    TimerManager.Remove(self.groupTimeTimer)
    self.groupTimeTimer = nil
  end
end

function GuideMissionQuestCtrl:OnDestroy()
end

function GuideMissionQuestCtrl:OnGroupBtnClick(btn, nIndex)
  self:RefreshQuestList(nIndex)
end

function GuideMissionQuestCtrl:OnBtnClick_GroupLock()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Guide_Mission_NotOpen"))
end

function GuideMissionQuestCtrl:OnBtnClick_QuickRec()
  local mapGroup = self.tbGroupList[self.nCurGroupIndex]
  if mapGroup == nil then
    return
  end
  local tbQuestList = PlayerData.Quest:GetGuideMissionQuestListByGroup(mapGroup.Id)
  if tbQuestList == nil then
    return
  end
  local nReceivableTid
  for _, mapQuest in pairs(tbQuestList) do
    local mapQuestData = PlayerData.Quest:GetGuideMissionQuestDataById(mapQuest.Id)
    if mapQuestData ~= nil and mapQuestData.nStatus == 1 then
      nReceivableTid = mapQuest.Id
      break
    end
  end
  if nReceivableTid == nil then
    return
  end
  PlayerData.Quest:ReceiveGuideMissionQuestReward(nReceivableTid, true, function()
    self:RefreshQuestList(self.nCurGroupIndex)
  end)
end

function GuideMissionQuestCtrl:OnBtnClick_QuickRecGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DoubleDrop_Reward_Receive_Tip"))
end

function GuideMissionQuestCtrl:OnBtnClick_GoBack()
  EventManager.Hit("GuideMissionQuestGoBack")
end

return GuideMissionQuestCtrl
