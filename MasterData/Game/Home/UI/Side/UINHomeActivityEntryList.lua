local UINHomeActivityEntryList = class("UINHomeActivityEntryList", UIBaseNode)
local base = UIBaseNode
local UINSectorActivityEntry = require("Game.ActivityFrame.UI.UINSectorActivityEntry")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local JumpManager = require("Game.Jump.JumpManager")
local CS_ClientConsts = CS.ClientConsts
local cs_MessageCommon = CS.MessageCommon

function UINHomeActivityEntryList:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.entryPool = UIItemPool.New(UINSectorActivityEntry, self.ui.btn_Activity)
  self.ui.btn_Activity:SetActive(false)
  self.__LoopActivityEntryCallback = BindCallback(self, self.__LoopActivityEntry)
  self.ui.pageView_root:onPageIndexChanged("+", self.__LoopActivityEntryCallback)
  self.__ActivityChangeListenerEvent = BindCallback(self, self.__ActivityChangeListener)
  MsgCenter:AddListener(eMsgEventId.ActivityShowChange, self.__ActivityChangeListenerEvent)
  self.__OnActivityPreviewEvent = BindCallback(self, self.__ActivityPreviewListen)
  MsgCenter:AddListener(eMsgEventId.ActivityPreview, self.__OnActivityPreviewEvent)
  self.__OnSectorIActivityUnlockEvent = BindCallback(self, self.__OnSectorIActivityUnlock)
  MsgCenter:AddListener(eMsgEventId.SectorActivityUnlock, self.__OnSectorIActivityUnlockEvent)
  self.__OnHeroGrowActivityUnlockEvent = BindCallback(self, self.__OnHeroGrowActivityUnlock)
  MsgCenter:AddListener(eMsgEventId.HeroGrowActivityUnlock, self.__OnHeroGrowActivityUnlockEvent)
  UIUtil.AddButtonListener(self.ui.btn_OpenList, self, self.__OnClickOpen)
  self.resloader = CS.ResLoader.Create()
  self.countSizeX = self.ui.count.sizeDelta.x
  self.countDefaultPos = self.ui.rect_CurrNum.anchoredPosition
  self.__OnClickEntryCallback = BindCallback(self, self.OnClickEntry)
  if not Consts.GameChannelType.IsInland() and CS_ClientConsts.IsAudit then
    self:Hide()
  end
end

function UINHomeActivityEntryList:BindingEntryCountChange(callback)
  self._countChangeCallback = callback
end

function UINHomeActivityEntryList:BingEntryJumpCallback(callback)
  if callback == nil then
    self._jumpCallback = nil
    return
  end
  
  function self._jumpCallback(jumpFunc)
    callback()
    jumpFunc()
  end
end

function UINHomeActivityEntryList:InitHomeActivityEntryList(enterWay)
  self._waitShowDic = {}
  self._waitOpenDic = {}
  self._activityItemDic = {}
  self._activityInfoList = {}
  self.enterWay = enterWay
  self.entryPool:HideAll()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  for id, cfg in pairs(ConfigData.activity_entrance) do
    if cfg.jump_id ~= JumpManager.eJumpTarget.DynActivity then
      do
        local item = self.entryPool:GetOne()
        item:RefreshNoActivityBanner(cfg, self.resloader, self.__OnClickEntryCallback)
      end
    else
      local activityFrameId = cfg.jump_arg[1]
      local activityFrameInfo = actFrameCtrl:GetActivityFrameData(activityFrameId)
      if activityFrameInfo ~= nil and not activityFrameInfo:GetIsActivityFinished() then
        if not actFrameCtrl:GetActIsLockByActFrameId(activityFrameId) and not activityFrameInfo:GetCouldShowActivity() then
          self._waitOpenDic[activityFrameId] = activityFrameInfo
        else
          table.insert(self._activityInfoList, {
            activityFrameId = activityFrameId,
            cfg = cfg,
            activityFrameInfo = activityFrameInfo
          })
        end
      end
    end
  end
  self:__SortList()
  for _, data in ipairs(self._activityInfoList) do
    local cfg = data.cfg
    local activityFrameInfo = data.activityFrameInfo
    local activityFrameId = data.activityFrameId
    local item = self.entryPool:GetOne()
    item:RefreshSectorActivity(cfg, activityFrameInfo, self.resloader, self.__OnClickEntryCallback)
    self._activityItemDic[activityFrameId] = item
  end
  self:__RefreshPage()
  self:__RefreshBtnOpen()
end

function UINHomeActivityEntryList:__RefreshExistActItem(activityFrameId)
  for i, item in pairs(self.entryPool.listItem) do
    if item:GetEntryActFrameData():GetActivityFrameId() == activityFrameId then
      item:RefreshLockState()
      return true
    end
  end
  return false
end

function UINHomeActivityEntryList:__TryShowActItem(activityFrameId)
  local actInfo
  local isShow = self:__RefreshExistActItem(activityFrameId)
  if isShow then
    return
  end
  actInfo = self._waitOpenDic[activityFrameId]
  if actInfo == nil then
    actInfo = self._waitShowDic[activityFrameId]
    self._waitShowDic[activityFrameId] = nil
  else
    self._waitOpenDic[activityFrameId] = nil
  end
  if actInfo == nil then
    return
  end
  local item = self.entryPool:GetOne()
  local cfgId = ConfigData.activity_entrance.activityIdDic[activityFrameId]
  local cfg = ConfigData.activity_entrance[cfgId]
  item:RefreshSectorActivity(cfg, actInfo, self.resloader, self.__OnClickEntryCallback)
  table.insert(self._activityInfoList, {
    activityFrameId = activityFrameId,
    cfg = cfg,
    activityFrameInfo = actInfo
  })
  self._activityItemDic[activityFrameId] = item
  self:__RefreshBtnOpen()
end

function UINHomeActivityEntryList:__SortList()
  table.sort(self._activityInfoList, function(a, b)
    local aPriority = a.cfg.entrance_order
    local bPriority = b.cfg.entrance_order
    if bPriority ~= aPriority then
      return aPriority > bPriority
    else
      return a.activityFrameId > b.activityFrameId
    end
  end)
end

function UINHomeActivityEntryList:__TryHideActItem(activityFrameId)
  self._waitOpenDic[activityFrameId] = nil
  self._waitShowDic[activityFrameId] = nil
  if self._activityItemDic[activityFrameId] == nil then
    return
  end
  local item = self._activityItemDic[activityFrameId]
  self._activityItemDic[activityFrameId] = nil
  for i, v in ipairs(self._activityInfoList) do
    if v.activityFrameId == activityFrameId then
      table.remove(self._activityInfoList, i)
      break
    end
  end
  self.entryPool:HideOne(item)
  self:__RefreshBtnOpen()
end

function UINHomeActivityEntryList:__OnClickOpen()
  local win = UIManager:ShowWindowAsync(UIWindowTypeID.ActEntrySpread, function(win)
    win:SetActEntrySpreadProperty(self._activityInfoList, self.resloader, self.__OnClickEntryCallback, self.enterWay, self.ui.pageView_root)
  end)
end

function UINHomeActivityEntryList:__RefreshBtnOpen()
  if #self._activityInfoList >= 2 then
    self.ui.btn_OpenList.gameObject:SetActive(true)
  else
    self.ui.btn_OpenList.gameObject:SetActive(false)
  end
end

function UINHomeActivityEntryList:__CheckEntryOpen(activityFrameInfo)
  local actCat = activityFrameInfo:GetActivityFrameCat()
  if actCat == ActivityFrameEnum.eActivityType.SectorI and not PlayerDataCenter.allActivitySectorIData:IsOpenSectorIEntrance() then
    return false
  elseif actCat == ActivityFrameEnum.eActivityType.HeroGrow and not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroActivity) then
    return false
  elseif actCat == ActivityFrameEnum.eActivityType.ShortTheatre and not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_PreciousCompany) then
    return false
  end
  return true
end

function UINHomeActivityEntryList:__LoopActivityEntry(index)
  if #self.entryPool.listItem > 0 then
    self.ui.rect_CurrNum.anchoredPosition = Vector2.Temp(self.countDefaultPos.x + self.countSizeX * index, self.countDefaultPos.y)
  end
end

function UINHomeActivityEntryList:__RefreshPage()
  local totalCount = #self.entryPool.listItem
  local canScroll = 1 < totalCount
  self.ui.count.gameObject:SetActive(canScroll)
  self.ui.pageView_root:InitPosList(totalCount)
  self.ui.pageView_root:SetPageIndexImmediate(0)
  self.ui.count.sizeDelta = Vector2.New(self.countSizeX * totalCount, self.ui.count.sizeDelta.y)
  self.ui.rect_CurrNum.anchoredPosition = self.countDefaultPos
  if self._countChangeCallback ~= nil then
    self._countChangeCallback(totalCount)
  end
end

function UINHomeActivityEntryList:__ActivityChangeListener(list, isopen)
  if isopen then
    for i, frameId in ipairs(list) do
      self:__TryShowActItem(frameId)
    end
  else
    for i, frameId in ipairs(list) do
      self:__TryHideActItem(frameId)
    end
  end
  self:__RefreshPage()
end

function UINHomeActivityEntryList:__ActivityPreviewListen(list)
  for i, frameId in ipairs(list) do
    self:__TryShowActItem(frameId)
  end
end

function UINHomeActivityEntryList:__OnSectorIActivityUnlock()
  for k, actInfo in pairs(self._waitShowDic) do
    if actInfo:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.SectorI then
      self:__TryShowActItem(k)
    end
  end
  self:__RefreshPage()
end

function UINHomeActivityEntryList:__OnHeroGrowActivityUnlock()
  for k, actInfo in pairs(self._waitShowDic) do
    if actInfo:GetActivityFrameCat() == ActivityFrameEnum.eActivityType.HeroGrow then
      self:__TryShowActItem(k)
    end
  end
  self:__RefreshPage()
end

function UINHomeActivityEntryList:OnClickEntry(entryCfg)
  if entryCfg == nil then
    return
  end
  local couldJump = JumpManager:ValidateJump(entryCfg.jump_id, entryCfg.jump_arg)
  if couldJump then
    JumpManager:Jump(entryCfg.jump_id, self._jumpCallback, nil, entryCfg.jump_arg)
  else
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(6033))
  end
end

function UINHomeActivityEntryList:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.ActivityShowChange, self.__ActivityChangeListenerEvent)
  MsgCenter:RemoveListener(eMsgEventId.ActivityPreview, self.__OnActivityPreviewEvent)
  MsgCenter:RemoveListener(eMsgEventId.SectorActivityUnlock, self.__OnSectorIActivityUnlockEvent)
  MsgCenter:RemoveListener(eMsgEventId.HeroGrowActivityUnlock, self.__OnHeroGrowActivityUnlockEvent)
  self._countChangeCallback = nil
  self._jumpCallback = nil
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.entryPool:DeleteAll()
  base.OnDelete(self)
end

return UINHomeActivityEntryList
