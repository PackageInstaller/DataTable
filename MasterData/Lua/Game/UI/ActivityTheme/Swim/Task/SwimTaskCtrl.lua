local SwimTaskCtrl = class("SwimTaskCtrl", BaseCtrl)
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local PlayerActivityData = PlayerData.Activity
local TabType = GameEnum.ActivityTaskTabType
local ItemType = GameEnum.itemType
local tbTabNameUITextId = {
  [TabType.Tab1] = "Quest_Normal",
  [TabType.Tab2] = "Quest_Story",
  [TabType.Tab3] = "Quest_Challenge",
  [TabType.Tab4] = "Quest_Play",
  [TabType.Tab5] = "Quest_Active"
}
SwimTaskCtrl._mapNodeConfig = {
  TopBarPanel = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  svList_Tab = {
    sComponentName = "LoopScrollView"
  },
  svList_Task = {
    sComponentName = "LoopScrollView"
  },
  svList_GroupReward = {
    sComponentName = "LoopScrollView"
  },
  imgGroupDone = {},
  tmpGroupName = {sComponentName = "TMP_Text"},
  tmpGroupProgress = {sComponentName = "TMP_Text"},
  tmpGroupUndone = {
    sComponentName = "TMP_Text",
    sLanguageId = "PerActivity_Quest_UnComplete"
  },
  btnGroupDone = {
    sComponentName = "UIButton",
    callback = "onBtn_GroupDone"
  },
  tb_tmpReceived = {
    nCount = 3,
    sNodeName = "tmpReceived_",
    sComponentName = "TMP_Text",
    sLanguageId = "PerActivity_Quest_Received"
  },
  tmpUndone = {
    sComponentName = "TMP_Text",
    sLanguageId = "PerActivity_Quest_UnComplete"
  },
  tmpDone = {
    sComponentName = "TMP_Text",
    sLanguageId = "PerActivity_Quest_Receive"
  },
  tmpJump = {
    sComponentName = "TMP_Text",
    sLanguageId = "PerActivity_Quest_Jump"
  },
  tmpGroupDone = {
    sComponentName = "TMP_Text",
    sLanguageId = "PerActivity_Quest_Receive"
  }
}
SwimTaskCtrl._mapEventConfig = {
  onClick_RewardItem = "onEvent_ClickRewardItem",
  onClick_TaskDone = "onEvent_ClickTaskDone",
  onClick_TaskJump = "onEvent_ClickTaskJump"
}
SwimTaskCtrl._mapRedDotConfig = {}

function SwimTaskCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  self.nActivityId = type(tbParam) == "table" and tbParam[1] or nil
  self.nCurGroupIndex = tbParam[2]
  if type(self.nActivityId) ~= "number" then
    self.nActivityId = nil
  end
  self:BuildData(self.nActivityId)
  self:refresh_Tab()
  self:refresh_Task()
  self:refresh_Group()
end

function SwimTaskCtrl:BuildData(nActivityId)
  if self.tbData == nil then
    self.tbData = {}
  end
  if self.tbGroupId == nil then
    self.tbGroupId = {}
  end
  if type(nActivityId) ~= "number" then
    return
  end
  self.ins_ActivityTaskData = PlayerActivityData:GetActivityDataById(nActivityId)
  if self.ins_ActivityTaskData == nil then
    return
  end
  
  local function func_Parse_ActivityTaskGroup(mapData)
    if mapData.ActivityId == nActivityId then
      local _nGroupId = mapData.Id
      local nIdx = table.indexof(self.tbGroupId, _nGroupId)
      if nIdx <= 0 then
        local _mapData = {
          nGroupId = _nGroupId,
          nGroupOrder = mapData.Order,
          nTabType = mapData.TaskTabType,
          tbGroupRewardId = {},
          tbGroupRewardNum = {},
          tbTaskId = {},
          tbTaskData = {},
          nTaskDoneNum = 0,
          nTaskOKNum = 0
        }
        for i = 1, 6 do
          local nRewardId = mapData["Reward" .. tostring(i)]
          local nRewardNum = mapData["RewardQty" .. tostring(i)]
          if 0 < nRewardId and 0 < nRewardNum then
            table.insert(_mapData.tbGroupRewardId, nRewardId)
            table.insert(_mapData.tbGroupRewardNum, nRewardNum)
          end
        end
        table.insert(self.tbData, _mapData)
        table.insert(self.tbGroupId, _nGroupId)
      else
        local _mapData = self.tbData[nIdx]
        _mapData.nTaskDoneNum = 0
        _mapData.nTaskOKNum = 0
      end
    end
  end
  
  ForEachTableLine(DataTable.ActivityTaskGroup, func_Parse_ActivityTaskGroup)
  
  local function func_Parse_ActivityTask(mapData)
    local nIdx = table.indexof(self.tbGroupId, mapData.ActivityTaskGroupId)
    if 0 < nIdx then
      local _mapData = self.tbData[nIdx]
      local _tbTaskId = _mapData.tbTaskId
      local _tbTaskData = _mapData.tbTaskData
      local _nTaskId = mapData.Id
      local taskData = self.ins_ActivityTaskData.mapActivityTaskDatas[_nTaskId]
      local nIndex = table.indexof(_tbTaskId, _nTaskId)
      if nIndex <= 0 then
        local _mapTaskData = {
          nTaskId = _nTaskId,
          nStatus = taskData.nStatus,
          sDesc = mapData.Desc,
          nRarity = mapData.Rarity,
          nJumpTo = mapData.JumpTo,
          nCur = taskData.nCur,
          nMax = taskData.nMax,
          tbTaskRewardId = {},
          tbTaskRewardNum = {}
        }
        if taskData.nStatus == AllEnum.ActQuestStatus.Received then
          _mapData.nTaskDoneNum = _mapData.nTaskDoneNum + 1
        end
        if taskData.nStatus ~= AllEnum.ActQuestStatus.UnComplete then
          _mapData.nTaskOKNum = _mapData.nTaskOKNum + 1
        end
        for i = 1, 2 do
          local nRewardId = mapData["Tid" .. tostring(i)]
          local nRewardNum = mapData["Qty" .. tostring(i)]
          if 0 < nRewardId and 0 < nRewardNum then
            table.insert(_mapTaskData.tbTaskRewardId, nRewardId)
            table.insert(_mapTaskData.tbTaskRewardNum, nRewardNum)
          end
        end
        table.insert(_tbTaskId, _nTaskId)
        table.insert(_tbTaskData, _mapTaskData)
      else
        local _mapTaskData = _tbTaskData[nIndex]
        _mapTaskData.nStatus = taskData.nStatus
        _mapTaskData.nCur = taskData.nCur
        _mapTaskData.nMax = taskData.nMax
        if taskData.nStatus == AllEnum.ActQuestStatus.Received then
          _mapData.nTaskDoneNum = _mapData.nTaskDoneNum + 1
        end
        if taskData.nStatus ~= AllEnum.ActQuestStatus.UnComplete then
          _mapData.nTaskOKNum = _mapData.nTaskOKNum + 1
        end
      end
    end
  end
  
  ForEachTableLine(DataTable.ActivityTask, func_Parse_ActivityTask)
  table.sort(self.tbData, function(a, b)
    return a.nGroupOrder < b.nGroupOrder
  end)
  for i, v in ipairs(self.tbData) do
    self.tbGroupId[i] = v.nGroupId
  end
  for i, mapData in ipairs(self.tbData) do
    local tbTaskData = mapData.tbTaskData
    table.sort(tbTaskData, function(a, b)
      if a.nStatus == b.nStatus then
        return a.nTaskId < b.nTaskId
      else
        return a.nStatus < b.nStatus
      end
    end)
    for ii, vv in ipairs(tbTaskData) do
      mapData.tbTaskId[ii] = vv.nTaskId
    end
  end
  if self.nCurGroupIndex == nil then
    local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActivityId)
    local nFirstReddot = 1
    for i, v in ipairs(self.tbData) do
      local bRed = false
      if bInActGroup == false then
        bRed = RedDotManager.GetValid(RedDotDefine.Activity_Group_Task_Group, {
          self.nActivityId,
          v.nGroupId
        })
      else
        bRed = RedDotManager.GetValid(RedDotDefine.Activity_Group_Task_Group, {
          nActGroupId,
          self.nActivityId,
          v.nGroupId
        })
      end
      if bRed then
        nFirstReddot = i
        break
      end
    end
    self.nCurGroupIndex = nFirstReddot
  end
end

function SwimTaskCtrl:refresh_Tab()
  self._mapNode.svList_Tab:Init(#self.tbData, self, self.onGridRefresh_Tab, self.onGridBtnClick_Tab)
end

function SwimTaskCtrl:onGridRefresh_Tab(go)
  local nIndex = tonumber(go.name) + 1
  local mapData = self.tbData[nIndex]
  local mapCfgData_ActivityTaskGroup = ConfigTable.GetData("ActivityTaskGroup", mapData.nGroupId)
  local nDone = mapData.nTaskDoneNum
  local nTotal = #mapData.tbTaskData
  local sProgress = string.format("%s/%s", tostring(nDone), tostring(nTotal))
  local tr = go.transform
  tr:Find("scale_on_click/imgDb_on").localScale = self.nCurGroupIndex == nIndex and Vector3.one or Vector3.zero
  NovaAPI.SetTMPText(tr:Find("scale_on_click/tmpTabName"):GetComponent("TMP_Text"), ConfigTable.GetUIText(tbTabNameUITextId[mapCfgData_ActivityTaskGroup.TaskTabType]))
  NovaAPI.SetTMPText(tr:Find("scale_on_click/imgDb_off/tmpTabProgress_off"):GetComponent("TMP_Text"), sProgress)
  NovaAPI.SetTMPText(tr:Find("scale_on_click/imgDb_on/tmpTabProgress_on"):GetComponent("TMP_Text"), sProgress)
  local goRedDot = tr:Find("scale_on_click/redDotTab")
  local bInActGroup, nActGroupId = PlayerData.Activity:IsActivityInActivityGroup(self.nActivityId)
  RedDotManager.RegisterNode(RedDotDefine.Activity_Group_Task_Group, {
    nActGroupId,
    self.nActivityId,
    mapData.nGroupId
  }, goRedDot, nil, nil, true)
end

function SwimTaskCtrl:onGridBtnClick_Tab(go)
  local nIndex = tonumber(go.name) + 1
  if self.nCurGroupIndex ~= nIndex then
    go.transform.parent:GetChild(self.nCurGroupIndex - 1):Find("scale_on_click/imgDb_on").localScale = Vector3.zero
    self.nCurGroupIndex = nIndex
    self:refresh_Tab()
    self:refresh_Task(true)
    self:refresh_Group()
  end
end

function SwimTaskCtrl:refresh_Task(bPlayAnim)
  local mapData = self.tbData[self.nCurGroupIndex]
  if bPlayAnim == true then
    self._mapNode.svList_Task:SetAnim(0.05)
  end
  self._mapNode.svList_Task:Init(#mapData.tbTaskData, self, self.onGridRefresh_Task, nil)
end

function SwimTaskCtrl:onGridRefresh_Task(go)
  local nIndex = tonumber(go.name) + 1
  local mapData = self.tbData[self.nCurGroupIndex]
  local mapTask = mapData.tbTaskData[nIndex]
  local tr = go.transform:GetChild(0)
  for i = 1, 5 do
    tr:Find("imgRare_" .. tostring(i)).localScale = i == mapTask.nRarity and Vector3.one or Vector3.zero
  end
  local nCur = mapTask.nCur
  local nMax = mapTask.nMax
  if nMax <= 0 then
    nMax = 0 < nCur and nCur or 1
  end
  if nCur > nMax then
    nCur = nMax
  end
  if mapTask.nStatus == AllEnum.ActQuestStatus.Complete or mapTask.nStatus == AllEnum.ActQuestStatus.Received then
    nCur = nMax
  end
  local rt = tr:Find("imgProgessDb"):GetComponent("RectTransform")
  local nWidth = nCur / nMax * rt.rect.width
  if 0 < nWidth and nWidth < 40 then
    nWidth = 40
  end
  tr:Find("imgProgessBar"):GetComponent("RectTransform").sizeDelta = Vector2(nWidth, rt.rect.height)
  NovaAPI.SetTMPText(tr:Find("tmpTaskDesc"):GetComponent("TMP_Text"), mapTask.sDesc)
  NovaAPI.SetTMPText(tr:Find("tmpTaskProgress"):GetComponent("TMP_Text"), string.format("%s/%s", tostring(nCur), tostring(nMax)))
  local nCount = #mapTask.tbTaskRewardId
  for i = 1, 2 do
    local _tr = tr:Find("goTaskReward" .. tostring(i))
    if i <= nCount then
      _tr.localScale = Vector3.one
      local nId = mapTask.tbTaskRewardId[i]
      local mapCfgData_Item = ConfigTable.GetData("Item", nId)
      self:SetSprite_FrameColor(_tr:Find("scale_on_click/imgRare").gameObject:GetComponent("Image"), mapCfgData_Item.Rarity, AllEnum.FrameType_New.Item, false)
      self:SetPngSprite(_tr:Find("scale_on_click/imgIcon").gameObject:GetComponent("Image"), mapCfgData_Item.Icon)
      _tr:Find("scale_on_click/goReceived").localScale = mapTask.nStatus == AllEnum.ActQuestStatus.Received and Vector3.one or Vector3.zero
      local nNum = mapTask.tbTaskRewardNum[i]
      local sNum = mapCfgData_Item.Type ~= ItemType.Char and mapCfgData_Item.Type ~= ItemType.Disc and "×" .. tostring(nNum) or ""
      NovaAPI.SetTMPText(_tr:Find("scale_on_click/tmpCount").gameObject:GetComponent("TMP_Text"), sNum)
      _tr:GetChild(0).name = tostring(nId)
      _tr:Find("scale_on_click/goTimeLimit").localScale = 0 < mapCfgData_Item.ExpireType and Vector3.one or Vector3.zero
    else
      _tr.localScale = Vector3.zero
    end
  end
  tr:Find("tmpUndone").localScale = mapTask.nStatus == AllEnum.ActQuestStatus.UnComplete and 0 >= mapTask.nJumpTo and Vector3.one or Vector3.zero
  tr:Find("btnDone").localScale = mapTask.nStatus == AllEnum.ActQuestStatus.Complete and Vector3.one or Vector3.zero
  tr:Find("btnDone"):GetChild(0).name = tostring(mapTask.nTaskId)
  tr:Find("btnJump").localScale = mapTask.nStatus == AllEnum.ActQuestStatus.UnComplete and 0 < mapTask.nJumpTo and Vector3.one or Vector3.zero
  tr:Find("btnJump"):GetChild(0).name = tostring(mapTask.nJumpTo)
  tr:Find("goDone").localScale = mapTask.nStatus == AllEnum.ActQuestStatus.Received and Vector3.one or Vector3.zero
end

function SwimTaskCtrl:onEvent_ClickRewardItem(goBtn)
  local nItemId = tonumber(goBtn.transform:GetChild(0).name)
  if nItemId ~= nil then
    UTILS.ClickItemGridWithTips(nItemId, goBtn.transform, true, true, true)
  end
end

function SwimTaskCtrl:onEvent_ClickTaskDone(goBtn)
  local nTaskId = tonumber(goBtn.transform:GetChild(0).name)
  if nTaskId ~= nil then
    local function cb()
      self:BuildData(self.nActivityId)
      
      self:refresh_Tab()
      self:refresh_Task(true)
      self:refresh_Group()
    end
    
    local mapData = self.tbData[self.nCurGroupIndex]
    self.ins_ActivityTaskData:SendMsg_ActivityTaskRewardReceiveReq(mapData.nGroupId, 0, mapData.nTabType, cb)
  end
end

function SwimTaskCtrl:onEvent_ClickTaskJump(goBtn)
  local nJumpId = tonumber(goBtn.transform:GetChild(0).name)
  if 0 < nJumpId then
    JumpUtil.JumpTo(nJumpId)
  end
end

function SwimTaskCtrl:refresh_Group()
  local mapData = self.tbData[self.nCurGroupIndex]
  local nGroupId = mapData.nGroupId
  local tbTaskData = mapData.tbTaskData
  self.bGot = table.indexof(self.ins_ActivityTaskData.tbActivityTaskGroupIds, nGroupId) > 0
  local nDone = mapData.nTaskDoneNum
  local nOK = mapData.nTaskOKNum
  local nTotal = #tbTaskData
  local bDone = nOK == nTotal
  local mapCfgData_ActivityTaskGroup = ConfigTable.GetData("ActivityTaskGroup", nGroupId)
  NovaAPI.SetTMPText(self._mapNode.tmpGroupName, ConfigTable.GetUIText(tbTabNameUITextId[mapCfgData_ActivityTaskGroup.TaskTabType]))
  NovaAPI.SetTMPText(self._mapNode.tmpGroupProgress, string.format("%s/%s", tostring(nDone), tostring(nTotal)))
  self._mapNode.tmpGroupUndone.transform.localScale = bDone == true and Vector3.zero or Vector3.one
  self._mapNode.btnGroupDone.transform.localScale = bDone == true and self.bGot == false and Vector3.one or Vector3.zero
  self._mapNode.imgGroupDone.transform.localScale = self.bGot == true and Vector3.one or Vector3.zero
  self.tbCurGroupRewardId = mapData.tbGroupRewardId
  self.tbCurGroupRewardNum = mapData.tbGroupRewardNum
  self._mapNode.svList_GroupReward:Init(#self.tbCurGroupRewardId, self, self.onGridRefresh_GroupRewardItem, self.onGridBtnClick_GroupRewardItem)
end

function SwimTaskCtrl:onGridRefresh_GroupRewardItem(go)
  local nIndex = tonumber(go.name) + 1
  local mapCfgData_Item = ConfigTable.GetData("Item", self.tbCurGroupRewardId[nIndex])
  local tr = go.transform
  self:SetSprite_FrameColor(tr:Find("scale_on_click/imgRare").gameObject:GetComponent("Image"), mapCfgData_Item.Rarity, AllEnum.FrameType_New.Item, false)
  self:SetPngSprite(tr:Find("scale_on_click/imgIcon").gameObject:GetComponent("Image"), mapCfgData_Item.Icon)
  tr:Find("scale_on_click/goReceived").localScale = self.bGot == true and Vector3.one or Vector3.zero
  local nNum = self.tbCurGroupRewardNum[nIndex]
  local sNum = mapCfgData_Item.Type ~= ItemType.Char and mapCfgData_Item.Type ~= ItemType.Disc and "×" .. tostring(nNum) or ""
  NovaAPI.SetTMPText(tr:Find("scale_on_click/tmpCount").gameObject:GetComponent("TMP_Text"), sNum)
  tr:Find("scale_on_click/goTimeLimit").localScale = mapCfgData_Item.ExpireType > 0 and Vector3.one or Vector3.zero
end

function SwimTaskCtrl:onGridBtnClick_GroupRewardItem(go)
  local nIndex = tonumber(go.name) + 1
  UTILS.ClickItemGridWithTips(self.tbCurGroupRewardId[nIndex], go.transform, true, true, true)
end

function SwimTaskCtrl:onBtn_GroupDone()
  local mapData = self.tbData[self.nCurGroupIndex]
  
  local function cb()
    self:BuildData(self.nActivityId)
    self:refresh_Tab()
    self:refresh_Group()
  end
  
  self.ins_ActivityTaskData:SendMsg_ActivityTaskGroupRewardReceiveReq(mapData.nGroupId, cb)
end

return SwimTaskCtrl
