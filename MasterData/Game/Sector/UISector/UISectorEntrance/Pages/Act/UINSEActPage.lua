local base = UIBaseNode
local UINSEActPage = class("UINSEActPage", UIBaseNode)
local cs_MessageCommon = CS.MessageCommon
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local JumpManager = require("Game.Jump.JumpManager")
local UINSEActPageTopAct = require("Game.Sector.UISector.UISectorEntrance.Pages.Act.UINSEActPageTopAct")
local UINSEActPageActItem = require("Game.Sector.UISector.UISectorEntrance.Pages.Act.UINSEActPageActItem")

function UINSEActPage:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.topActNode = UINSEActPageTopAct.New()
  self.topActNode:Init(self.ui.obj_topActNode)
  self.actItemPool = UIItemPool.New(UINSEActPageActItem, self.ui.obj_actNode)
  self.ui.obj_actNode:SetActive(false)
  self.couldShowActDic = nil
  self.hugeActFrameId = nil
  self.normalActIdList = nil
  self.normalActDic = nil
  self.__onClickAct = BindCallback(self, self.__OnClickAct)
  self.__refreshAllAct = BindCallback(self, self.__RefreshAllAct)
  MsgCenter:AddListener(eMsgEventId.ActivityShowChange, self.__refreshAllAct)
  if CS.ClientConsts.IsAudit then
    self.ui.cg_emptyNode.gameObject:SetActive(false)
  end
end

function UINSEActPage:InitSEPage(resloader)
  self.__resloader = resloader
  self.sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  self.actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self:__RefreshAllAct()
end

function UINSEActPage:__RefreshAllAct()
  self:RefreshAllActEnreance()
  self:__RefreshTopActInfo()
  self:__RefreshActItems()
  self:__StartRefreshTimer()
end

function UINSEActPage:RefreshAllActEnreance()
  self.hugeActFrameId = nil
  self.couldShowActDic = {}
  self.normalActIdList = {}
  local hugeActFrameIdList = {}
  for id, entranceCfg in pairs(ConfigData.activity_entrance) do
    if entranceCfg.jump_id ~= JumpManager.eJumpTarget.DynActivity then
      error("not act in the act entrace, id: " .. tostring(entranceCfg.jump_id))
    else
      local activityFrameId = entranceCfg.jump_arg[1]
      local actFrameData = self.actFrameCtrl:GetActivityFrameData(activityFrameId)
      if actFrameData ~= nil and not actFrameData:GetIsActivityFinished() and (self.actFrameCtrl:GetActIsLockByActFrameId(activityFrameId) or actFrameData:GetCouldShowActivity()) then
        self.couldShowActDic[activityFrameId] = {activityFrameInfo = actFrameData, entranceCfg = entranceCfg}
        if not string.IsNullOrEmpty(entranceCfg.entrance_banner) then
          table.insert(hugeActFrameIdList, activityFrameId)
        end
        table.insert(self.normalActIdList, {
          priority = entranceCfg.entrance_order,
          activityFrameId = activityFrameId
        })
      end
    end
  end
  table.sort(hugeActFrameIdList, function(a, b)
    local actFramDataA = self.couldShowActDic[a].activityFrameInfo
    local actFramDataB = self.couldShowActDic[b].activityFrameInfo
    local isRunningA = actFramDataA:IsInRuningState()
    local isRunningB = actFramDataB:IsInRuningState()
    if isRunningA ~= isRunningB then
      return isRunningA
    end
    local entranceCfgA = self.couldShowActDic[a].entranceCfg
    local entranceCfgB = self.couldShowActDic[b].entranceCfg
    local priorityA = entranceCfgA.entrance_order
    local priorityB = entranceCfgB.entrance_order
    return priorityA > priorityB
  end)
  self.hugeActFrameId = hugeActFrameIdList[1]
  hugeActFrameIdList = nil
  if self.hugeActFrameId ~= nil then
    for index, actCfg in pairs(self.normalActIdList) do
      if actCfg.activityFrameId == self.hugeActFrameId then
        table.remove(self.normalActIdList, index)
        break
      end
    end
  end
  table.sort(self.normalActIdList, function(a, b)
    if a.priority ~= b.priority then
      return a.priority > b.priority
    end
    return a.activityFrameId > b.activityFrameId
  end)
end

function UINSEActPage:__RefreshTopActInfo()
  local isNotExist = self.hugeActFrameId == nil
  self.ui.empty:SetActive(isNotExist)
  self.ui.notEmpty:SetActive(not isNotExist)
  if isNotExist then
    return
  end
  local actInfo = self.couldShowActDic[self.hugeActFrameId]
  self.topActNode:RefreshTopActNode(actInfo, self.__onClickAct, self.__resloader)
end

function UINSEActPage:__RefreshActItems()
  self.actItemPool:HideAll()
  self.normalActDic = {}
  for index, frameIdData in ipairs(self.normalActIdList) do
    local actInfo = self.couldShowActDic[frameIdData.activityFrameId]
    local actItem = self.actItemPool:GetOne()
    actItem:RefreshActNode(actInfo, self.__onClickAct, self.__resloader)
    actItem.gameObject.name = tostring(frameIdData.activityFrameId)
    self.normalActDic[frameIdData.activityFrameId] = actItem
  end
  self.ui.obj_emptyNode.transform.parent.transform:SetAsLastSibling()
  self:__PlayEnterTween()
end

function UINSEActPage:__OnClickAct(actInfo)
  local entranceCfg = actInfo.entranceCfg
  local couldJump = JumpManager:ValidateJump(entranceCfg.jump_id, entranceCfg.jump_arg)
  if couldJump then
    JumpManager:Jump(entranceCfg.jump_id, self._jumpCallback, nil, entranceCfg.jump_arg)
  else
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(6033))
  end
end

function UINSEActPage:__GetClosetRefreshTime()
  local finalRefreshTime
  for actFrameId, actInfo in pairs(self.couldShowActDic) do
    local endTm = actInfo.activityFrameInfo:GetActivityEndTime()
    local refreshTime = (endTm - PlayerDataCenter.timestamp) % 86400
    if 0 < refreshTime then
      refreshTime = math.ceil(PlayerDataCenter.timestamp + refreshTime)
      if finalRefreshTime == nil then
        finalRefreshTime = refreshTime
      else
        finalRefreshTime = math.min(finalRefreshTime, refreshTime)
      end
    end
  end
  return finalRefreshTime
end

function UINSEActPage:__StartRefreshTimer()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  local refreshTime = self:__GetClosetRefreshTime()
  
  local function RefreFunc()
    if PlayerDataCenter.timestamp >= refreshTime then
      if self._timerId ~= nil then
        TimerManager:StopTimer(self._timerId)
        self._timerId = nil
      end
      self:__RefreshAllAct()
    end
  end
  
  if refreshTime ~= nil then
    self._timerId = TimerManager:StartTimer(1, RefreFunc, self, false, false, false)
  end
end

function UINSEActPage:__PlayEnterTween()
  if self.normalActIdList == nil then
    return
  end
  if self.sequence ~= nil then
    self.sequence:Kill()
    self.sequence = nil
  end
  local sequence = cs_DoTween.Sequence()
  for index, frameIdData in ipairs(self.normalActIdList) do
    local item = self.normalActDic[frameIdData.activityFrameId]
    item.ui.holder.localPosition = Vector3.zero
    item.ui.cg_actNode.alpha = 1
    if index == 1 then
      sequence:Append(item.ui.holder:DOLocalMoveY(-20, 0.5):From():SetEase(cs_Ease.OutQuart))
      sequence:Join(item.ui.cg_actNode:DOFade(0, 0.4):From():SetEase(cs_Ease.OutQuart))
    else
      sequence:Join(item.ui.holder:DOLocalMoveY(-20, 0.5):SetDelay((index - 1) * 0.02):From():SetEase(cs_Ease.OutQuart))
      sequence:Join(item.ui.cg_actNode:DOFade(0, 0.4):SetDelay((index - 1) * 0.02):From():SetEase(cs_Ease.OutQuart))
    end
  end
  self.ui.obj_emptyNode.transform.localPosition = Vector3.zero
  self.ui.cg_emptyNode.alpha = 1
  sequence:Join(self.ui.obj_emptyNode.transform:DOLocalMoveY(-30, 0.5):SetDelay((#self.normalActIdList - 1) * 0.02):From():SetEase(cs_Ease.OutQuart))
  sequence:Join(self.ui.cg_emptyNode:DOFade(0, 0.4):SetDelay((#self.normalActIdList - 1) * 0.02):From():SetEase(cs_Ease.OutQuart))
  sequence:AppendCallback(function()
    self.sequence = nil
  end)
  sequence:SetAutoKill(true)
  sequence.target = self.transform
  self.sequence = sequence
end

function UINSEActPage:OnShow()
  self:__PlayEnterTween()
end

function UINSEActPage:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.ActivityShowChange, self.__refreshAllAct)
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  if self.sequence ~= nil then
    self.sequence:Kill()
    self.sequence = nil
  end
  for _, actItem in pairs(self.actItemPool.listItem) do
    actItem:Delete()
  end
  self.topActNode:Delete()
  base.OnDelete(self)
end

return UINSEActPage
