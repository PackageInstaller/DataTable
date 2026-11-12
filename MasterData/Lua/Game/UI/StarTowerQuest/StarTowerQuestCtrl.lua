local StarTowerQuestCtrl = class("StarTowerQuestCtrl", BaseCtrl)
local totalLength = 641.449
local totalHeight = 37
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local WwiseManger = CS.WwiseAudioManager.Instance
StarTowerQuestCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  Light = {},
  txtNormalEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "STQuest_NormalClear"
  },
  txtCoreEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "STQuest_CoreClear"
  },
  btnReceiveAll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReceiveAll"
  },
  txtBtnReceiveAll = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_ReceiveAll"
  },
  btnGrowth = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Growth"
  },
  txtBtnGrowth = {
    sComponentName = "TMP_Text",
    sLanguageId = "STQuest_Btn_GotoGrowth"
  },
  btnNone = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_None"
  },
  svQuest = {
    sComponentName = "LoopScrollView"
  },
  CoreQuest = {},
  Cube = {sComponentName = "Animator"},
  TMPTitleCore = {sComponentName = "TMP_Text"},
  TMPProcessCore = {sComponentName = "TMP_Text"},
  rtBarFillCore = {
    sComponentName = "RectTransform"
  },
  btnReceiveCore = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  btnJumpCore = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_JumpTo"
  },
  txtBtnReceiveCore = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive"
  },
  txtBtnJumpCore = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  TMPUncompleteCore = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_undone"
  },
  btnRewardCore = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  goItemCore = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  }
}
StarTowerQuestCtrl._mapEventConfig = {
  StarTowerQuestReceived = "OnEvent_Received",
  StarTowerQuestClickGrid = "OnEvent_ClickGrid"
}

function StarTowerQuestCtrl:Refresh()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbCore, self.tbNormal = PlayerData.Quest:GetStarTowerQuestData()
  local nNormalCount = #self.tbNormal
  self._mapNode.svQuest.gameObject:SetActive(0 < nNormalCount)
  self._mapNode.txtNormalEmpty.gameObject:SetActive(nNormalCount == 0)
  if 0 < nNormalCount then
    self._mapNode.svQuest:SetAnim(0.08)
    self._mapNode.svQuest:Init(nNormalCount, self, self.OnGridRefresh, nil, self.bPos)
  end
  local nCoreCount = #self.tbCore
  self._mapNode.CoreQuest.gameObject:SetActive(0 < nCoreCount)
  self._mapNode.txtCoreEmpty.gameObject:SetActive(nCoreCount == 0)
  if 0 < nCoreCount then
    local mapQuest = self.tbCore[1]
    self:RefreshCore(mapQuest.nTid, mapQuest.nStatus, mapQuest.nCurProgress, mapQuest.nGoal)
    self._mapNode.Light.gameObject:SetActive(mapQuest.nStatus == 1)
  else
    self._mapNode.Light.gameObject:SetActive(false)
  end
  local bClear = true
  for _, v in pairs(self.tbNormal) do
    if v.nStatus == 1 then
      bClear = false
      break
    end
  end
  for _, v in pairs(self.tbCore) do
    if v.nStatus == 1 then
      bClear = false
      break
    end
  end
  self._mapNode.btnReceiveAll.gameObject:SetActive(not bClear)
  self._mapNode.btnReceiveAll.interactable = true
  self._mapNode.btnNone.gameObject:SetActive(bClear and 0 < nNormalCount + nCoreCount)
  if nCoreCount == 0 and not self.bFirstIn then
    self._mapNode.Cube:Play("StarTowerQuest_Cube_finishin")
  elseif not self.bFirstIn then
    self._mapNode.Cube:Play("StarTowerQuest_Cube_in", 0, 1)
  end
end

function StarTowerQuestCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapQuest = self.tbNormal[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.StarTowerQuest.StarTowerQuestGridCtrl")
  end
  self.tbGridCtrl[nInstanceID]:Refresh(mapQuest.nTid, mapQuest.nStatus, mapQuest.nCurProgress, mapQuest.nGoal, gridIndex)
end

function StarTowerQuestCtrl:RefreshCore(nQuestId, nState, nCur, nTotal)
  self.nCoreQusetId = nQuestId
  local mapQuest = ConfigTable.GetData("StarTowerQuest", nQuestId)
  if mapQuest == nil then
    printError("QuestData missing：" .. nQuestId)
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPTitleCore, mapQuest.Title)
  if nState ~= 2 then
    NovaAPI.SetTMPText(self._mapNode.TMPProcessCore, string.format("%d/%d", nCur, nTotal))
  else
    NovaAPI.SetTMPText(self._mapNode.TMPProcessCore, ConfigTable.GetUIText("Quest_Complete"))
  end
  self.mapCoreQuset = mapQuest
  self._mapNode.rtBarFillCore.sizeDelta = Vector2(nCur / nTotal * totalLength, totalHeight)
  self._mapNode.btnReceiveCore.gameObject:SetActive(nState == 1)
  self._mapNode.btnReceiveCore.interactable = true
  self._mapNode.btnJumpCore.gameObject:SetActive(nState == 0 and 0 < mapQuest.JumpTo)
  self._mapNode.TMPUncompleteCore.gameObject:SetActive(nState == 0 and mapQuest.JumpTo == 0)
  for i = 1, 3 do
    self._mapNode.btnRewardCore[i].gameObject:SetActive(0 < mapQuest["Reward" .. i])
    if 0 < mapQuest["Reward" .. i] then
      self._mapNode.goItemCore[i]:SetItem(mapQuest["Reward" .. i], nil, mapQuest["RewardQty" .. i], nil, nil, nil, nil, true)
    end
  end
end

function StarTowerQuestCtrl:FadeIn()
  if #self.tbCore == 0 then
    self._mapNode.Cube:Play("StarTowerQuest_Cube_finishin")
  else
    self._mapNode.Cube:Play("StarTowerQuest_Cube_in")
  end
  self.bFirstIn = false
end

function StarTowerQuestCtrl:Awake()
  self.tbGridCtrl = {}
  self.bPos = false
  self.bFirstIn = true
end

function StarTowerQuestCtrl:OnEnable()
  self:Refresh()
end

function StarTowerQuestCtrl:OnDisable()
  self.bPos = true
  for k, v in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(v)
    self.tbGridCtrl[k] = nil
  end
  self.tbGridCtrl = {}
end

function StarTowerQuestCtrl:OnDestroy()
end

function StarTowerQuestCtrl:OnBtnClick_ReceiveAll(btn)
  self._mapNode.btnReceiveAll.interactable = false
  local bHasCore = false
  if #self.tbCore > 0 and self.nCoreQusetId then
    for _, v in pairs(self.tbCore) do
      if v.nTid == self.nCoreQusetId and v.nStatus == 1 then
        bHasCore = true
        break
      end
    end
  end
  if bHasCore then
    WwiseManger:PlaySound("ui_rogue_research_ani")
    self._mapNode.Cube:Play("StarTowerQuest_Cube_open")
    local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.Cube, {
      "StarTowerQuest_Cube_open"
    })
    EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
    self:AddTimer(1, nAnimLen, function()
      PlayerData.Quest:ReceiveStarTowerReward(0)
    end, true, true, true)
  else
    PlayerData.Quest:ReceiveStarTowerReward(0)
  end
end

function StarTowerQuestCtrl:OnBtnClick_Growth(btn)
  EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerGrowth)
end

function StarTowerQuestCtrl:OnBtnClick_Receive()
  self._mapNode.btnReceiveCore.interactable = false
  WwiseManger:PlaySound("ui_rogue_research_ani")
  self._mapNode.Cube:Play("StarTowerQuest_Cube_open")
  local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.Cube, {
    "StarTowerQuest_Cube_open"
  })
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
  self:AddTimer(1, nAnimLen, function()
    PlayerData.Quest:ReceiveStarTowerReward(self.nCoreQusetId)
  end, true, true, true)
end

function StarTowerQuestCtrl:OnBtnClick_JumpTo()
  local nJumptoId = self.mapCoreQuset.JumpTo
  JumpUtil.JumpTo(nJumptoId)
end

function StarTowerQuestCtrl:OnBtnClick_Reward(btn, nIndex)
  local mapData = {
    nTid = self.mapCoreQuset["Reward" .. nIndex],
    bShowDepot = true,
    bShowJumpto = true
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
end

function StarTowerQuestCtrl:OnBtnClick_None()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Quest_ReceiveNone"))
end

function StarTowerQuestCtrl:OnEvent_Received()
  self:Refresh()
end

function StarTowerQuestCtrl:OnEvent_ClickGrid(gridIndex, callback)
  self._mapNode.svQuest:SetScrollGridPos(gridIndex, 0.1, 1)
  EventManager.Hit(EventId.BlockInput, true)
  self:AddTimer(1, 0.1, function()
    EventManager.Hit(EventId.BlockInput, false)
    callback()
  end, true, true, true)
end

return StarTowerQuestCtrl
