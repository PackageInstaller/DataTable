local DormQuestCtrl = class("DormQuestCtrl", BaseCtrl)
local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
DormQuestCtrl._mapNodeConfig = {
  imgChapter = {sComponentName = "Image"},
  txtChapter = {sComponentName = "TMP_Text"},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Dorm_Quest_GroupTitle"
  },
  txtNum = {sComponentName = "TMP_Text"},
  txtActComplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_undone"
  },
  txtBtnReceiveChapter = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive_Btn_Text"
  },
  txtBtnFastReceiveGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Fast_Receive_Btn_Text"
  },
  txtBtnFastReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Fast_Receive_Btn_Text"
  },
  imgComplete = {},
  rewardItem = {
    nCount = 5,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnRewardItem = {
    sComponentName = "UIButton",
    nCount = 5,
    callback = "OnBtnClick_GroupReward"
  },
  imgEmpty = {nCount = 5},
  btnReceiveChapter = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GroupReceive"
  },
  guideQuestLSV = {
    sComponentName = "LoopScrollView"
  },
  btnFastReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FastReceive"
  },
  btnFastReceiveGray = {sComponentName = "UIButton"},
  btnCloseQuest = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  snapshot = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  rtQuest = {sComponentName = "Animator"}
}
DormQuestCtrl._mapEventConfig = {
  DormQuestGridReceive = "OnEvent_GridRecieveClick"
}
DormQuestCtrl._mapRedDotConfig = {}

function DormQuestCtrl:Awake()
  self._mapCtrl = {}
end

function DormQuestCtrl:FadeIn()
end

function DormQuestCtrl:FadeOut()
end

function DormQuestCtrl:OnEnable()
  self.bNeedBlockOperate = false
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.bNeedBlockOperate = tbParam[1] == true
  end
  if self.bNeedBlockOperate then
    NovaAPI.DispatchEventWithData("DORM_LUA_SET_UI_HIDDEN", nil, {61})
  end
  
  local function wait()
    self._mapNode.rtQuest.gameObject:SetActive(false)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.UIEffectSnapShotCapture(self._mapNode.snapshot.gameObject)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.rtQuest.gameObject:SetActive(true)
    self._mapNode.rtQuest:Play("rtQuest_in")
    DormGuideUI.BindOverlay("quest", self)
    self:RefreshPanel()
    if DormGuideUI._bQuestLock then
      self:SetGuideOperateLock(true)
    end
  end
  
  cs_coroutine.start(wait)
end

function DormQuestCtrl:RefreshPanel()
  self.tbGroupRewardId = {}
  local nCurGroup, nGroupState, tbQuest = PlayerData.PlayerDormData:GetDormQuestDataWithGroup()
  self.nCurGroup = nCurGroup
  self.nGroupState = nGroupState
  local bFastReceive = false
  if self.nCurGroup ~= 0 then
    if tbQuest == nil then
      tbQuest = {}
    end
  else
    tbQuest = {}
    local nCurGroup = 0
    
    local function forEachGroup(mapData)
      nCurGroup = math.max(nCurGroup, mapData.Id)
    end
    
    ForEachTableLine(DataTable.DormQuestGroup, forEachGroup)
    if nCurGroup ~= 0 then
      self.nCurGroup = nCurGroup
      self.nGroupState = 1
      do
        local function forEachQuest(mapData)
          if mapData.DormQuestGroup == nCurGroup then
            table.insert(tbQuest, {
              nTid = mapData.Id,
              
              nGoal = 0,
              nCurProgress = 0,
              nStatus = 2,
              nExpire = -1
            })
          end
        end
        
        ForEachTableLine(DataTable.DormQuest, forEachQuest)
      end
    end
  end
  local statusOrder = {
    [0] = 1,
    [1] = 2,
    [2] = 0
  }
  
  local function sort(a, b)
    if a.nStatus ~= b.nStatus then
      return statusOrder[a.nStatus] > statusOrder[b.nStatus]
    end
    return a.nTid < b.nTid
  end
  
  table.sort(tbQuest, sort)
  self.tbQuest = tbQuest
  local DormGuideUI = require("Game.UI.Dorm.DormGuideUI")
  if DormGuideUI.IsLeaveLocked() then
    self._mapNode.guideQuestLSV:SetAnim(0)
  else
    self._mapNode.guideQuestLSV:SetAnim(0.08)
  end
  self._mapNode.guideQuestLSV:Init(#tbQuest, self, self.OnGridRefresh)
  self:RefreshGroup()
end

function DormQuestCtrl:RefreshGroup()
  local bFastReceive = false
  local mapGroupCfgData = ConfigTable.GetData("DormQuestGroup", self.nCurGroup)
  if mapGroupCfgData == nil then
    return
  end
  self.tbGroupRewardId = {
    mapGroupCfgData.Item1,
    mapGroupCfgData.Item2,
    mapGroupCfgData.Item3
  }
  for i = 1, 3 do
    self._mapNode.rewardItem[i].gameObject:SetActive(mapGroupCfgData["Item" .. i] ~= 0)
    self._mapNode.imgEmpty[i].gameObject:SetActive(mapGroupCfgData["Item" .. i] == 0)
    if mapGroupCfgData["Item" .. i] ~= 0 then
      self._mapNode.rewardItem[i]:SetItem(mapGroupCfgData["Item" .. i], nil, mapGroupCfgData["Qty" .. i], nil, self.nGroupState == 1, nil, nil, true)
    end
  end
  local nTotalCount = 0
  local nCurCount = 0
  if self.tbQuest ~= nil then
    for _, v in ipairs(self.tbQuest) do
      nTotalCount = nTotalCount + 1
      if v.nStatus == 2 then
        nCurCount = nCurCount + 1
      end
      if v.nStatus == 1 then
        bFastReceive = true
      end
    end
  end
  if nTotalCount <= nCurCount and self.nGroupState == 0 then
    bFastReceive = true
  end
  NovaAPI.SetTMPText(self._mapNode.txtChapter, mapGroupCfgData.Title)
  NovaAPI.SetTMPText(self._mapNode.txtNum, string.format("%d/%d", nCurCount, nTotalCount))
  self._mapNode.imgComplete:SetActive(self.nGroupState == 1)
  self._mapNode.txtActComplete.gameObject:SetActive(nTotalCount > nCurCount and self.nGroupState == 0)
  self._mapNode.btnReceiveChapter.gameObject:SetActive(nTotalCount <= nCurCount and self.nGroupState == 0)
  self._mapNode.btnFastReceiveGray.gameObject:SetActive(not bFastReceive)
  self._mapNode.btnFastReceive.gameObject:SetActive(bFastReceive)
end

function DormQuestCtrl:OnGridRefresh(goGrid, gridIndex)
  if self._mapCtrl[goGrid] == nil then
    self._mapCtrl[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.Dorm.DormQuest.DormQuestGridCtrl")
  end
  local nIdx = gridIndex + 1
  self._mapCtrl[goGrid]:Refresh(self.tbQuest[nIdx])
  if DormGuideUI._bQuestLock then
    self:SetGuideOperateLock(true)
  end
end

function DormQuestCtrl:OnDisable()
  if self.bNeedBlockOperate then
    NovaAPI.DispatchEventWithData("DORM_LUA_SET_UI_HIDDEN", nil, {0})
  end
  DormGuideUI.UnbindOverlay("quest", self)
  for nInstanceId, objCtrl in pairs(self._mapCtrl) do
    self:UnbindCtrlByNode(objCtrl)
  end
  self._mapCtrl = nil
end

function DormQuestCtrl:OnDestroy()
end

function DormQuestCtrl:OnRelease()
end

function DormQuestCtrl:OnBtnClick_Close()
  self._mapNode.rtQuest:Play("rtQuest_out")
  self:AddTimer(1, 0.25, function()
    EventManager.Hit(EventId.ClosePanel, PanelId.DormQuestPanel)
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.25)
end

function DormQuestCtrl:OnBtnClick_FastReceive()
  local function callback()
    self:RefreshPanel()
  end
  
  PlayerData.Quest:ReceiveDormQuest(0, 0, callback)
end

function DormQuestCtrl:OnBtnClick_GroupReceive()
  local function callback()
    self:RefreshPanel()
  end
  
  PlayerData.Quest:ReceiveDormQuest(1, self.nCurGroup, callback)
end

function DormQuestCtrl:OnBtnClick_GroupReward(btn, nIdx)
  local nItemId = self.tbGroupRewardId[nIdx]
  if nItemId ~= nil then
    UTILS.ClickItemGridWithTips(nItemId, btn.transform, true, true, false)
  end
end

function DormQuestCtrl:SetGuideOperateLock(bLock)
  local function SetBtn(btn, bOn)
    if btn ~= nil then
      btn.interactable = bOn
    end
  end
  
  SetBtn(self._mapNode.btnCloseQuest, not bLock)
  SetBtn(self._mapNode.snapshot, not bLock)
  SetBtn(self._mapNode.btnFastReceive, not bLock)
  if self._mapCtrl == nil then
    return
  end
  for _, objGrid in pairs(self._mapCtrl) do
    if objGrid._mapNode ~= nil and objGrid._mapNode.btnReceive ~= nil then
      local bCan = objGrid.mapDormQuest ~= nil and objGrid.mapDormQuest.nStatus == 1
      objGrid._mapNode.btnReceive.interactable = not bLock and bCan
    end
  end
end

function DormQuestCtrl:IsGuideEnterDone()
  local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
  return DormGuideAdapter.AnimatorSettled(self._mapNode.rtQuest, "rtQuest_in")
end

function DormQuestCtrl:OnEvent_GridRecieveClick(nId)
  local DormGuideAdapter = require("Game.UI.Dorm.DormGuideAdapter")
  
  local function callback()
    self:RefreshPanel()
    DormGuideAdapter.NoteQuest(nId, true)
    if DormGuideUI._bQuestLock then
      self:SetGuideOperateLock(true)
    end
  end
  
  PlayerData.Quest:ReceiveDormQuest(0, nId, callback)
end

return DormQuestCtrl
