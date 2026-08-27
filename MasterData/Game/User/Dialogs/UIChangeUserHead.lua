local UIChangeUserHead = class("UIChangeUserHead", UIBaseNode)
local base = UIBaseNode
local UIToogleItem = require("Game.User.Dialogs.UIToogleItem")
local UIHeadScroll = require("Game.User.Dialogs.UIHeadScroll")
local UIHeadItem = require("Game.User.Dialogs.UIHeadItem")
local UIHeadRight = require("Game.User.Dialogs.UIHeadRight")
local UIHeadSortNode = require("Game.User.Dialogs.UIHeadSortNode")
local eChangeUserHeadDefine = require("Game.User.Dialogs.ChangeUserHeadDefine")

function UIChangeUserHead:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.lastTog = 0
  self:InitChooseInfo()
  self.itemDic = {}
  self.resloader = CS.ResLoader.Create()
  self.tog_Head = UIToogleItem.New()
  self.tog_Head:Init(self.ui.tog_Head)
  self.tog_Head.changeValueFunc = BindCallback(self, self.ClickHead)
  self.tog_HeadFrame = UIToogleItem.New()
  self.tog_HeadFrame:Init(self.ui.tog_HeadFrame)
  self.tog_HeadFrame.changeValueFunc = BindCallback(self, self.ClickHeadFrame)
  self.right_Pannel = UIHeadRight.New()
  self.right_Pannel:Init(self.ui.right_Pannel)
  self.right_Pannel:BindHeadRightResloader(self.resloader)
  self.sortNode = UIHeadSortNode.New()
  self.sortNode:Init(self.ui.sortNode)
  UIUtil.AddButtonListener(self.ui.btn_Sort, self, self.ShowSortNode)
  self.sortNode.changeValueFunc = BindCallback(self, self.ChangeType)
  UIUtil.AddValueChangedListener(self.ui.tog_ShowHas, self, self.OnSwitchValueChange)
  self.__ClickOneHead = BindCallback(self, self.ClickOneHead)
  self.__ClickOneHeadFrame = BindCallback(self, self.ClickOneHeadFrame)
  self.tog_Head:SelectActivityTag()
  self.__frameEffectPool = CommonGroupPool.New(nil, function(go)
    go.transform:SetParent(self.ui.effectPool)
    return true
  end)
end

function UIChangeUserHead:BindCloseFun(onCloseCallback)
  self._onCloseCallback = onCloseCallback
  self.right_Pannel:BindCloseFun(onCloseCallback)
end

function UIChangeUserHead:InitChooseInfo()
  self.showAll = false
  self.showType = 0
  self.lastChoose = 0
  if self.lastChooseItemCfg ~= nil and self.lastChooseItemCfg.count == 1 then
    self.choosedId = self.lastChooseItemCfg.id
  else
    self.lastChooseItemCfg = nil
    self.choosedId = PlayerDataCenter.inforData.avatarId
  end
  if self.lastChooseFrameItemCfg ~= nil and self.lastChooseFrameItemCfg.count == 1 then
    self.choosedFrameId = self.lastChooseFrameItemCfg.id
  else
    self.lastChooseFrameItemCfg = nil
    self.choosedFrameId = PlayerDataCenter.inforData.avatarFrameId
  end
  self.isFirst = true
end

function UIChangeUserHead:ChangeType(type, str)
  self.lastChoose = type + 1
  self.showType = type
  self.showList = self:ShowListFiltetr()
  self.ui.text_Sort.text = str
  self.headList:ReFreshData(#self.showList)
end

function UIChangeUserHead:ShowSortNode()
  self.sortNode:InitSortList(self.allList, self.lastChoose)
  self:ChangeImg_Sort()
  self.sortNode.BackFun = BindCallback(self, self.ChangeImg_Sort)
  self.sortNode:ShowWindow()
end

function UIChangeUserHead:ChangeImg_Sort()
  if self.ui.img_Sort.transform.rotation.z == 0 then
    self.ui.img_Sort.transform.rotation = Vector3.New(0, 0, 180)
  else
    self.ui.img_Sort.transform.rotation = Vector3.New(0, 0, 0)
  end
end

function UIChangeUserHead:UnSelectTag()
  if self.ui.tog_ShowHas.isOn then
    self:OnSwitchValueChange(false)
  else
    self.ui.tog_ShowHas.isOn = false
    self:OnSwitchValueChange(false)
  end
end

function UIChangeUserHead:OnSwitchValueChange(flag)
  if flag then
    self.ui.img_SelectInfo:SetIndex(0)
  else
    self.ui.img_SelectInfo:SetIndex(1)
  end
  self.showAll = flag
  self.showList = self:ShowListFiltetr()
  if self.lastTog == 1 then
    self.headList:ReFreshData(#self.showList)
  else
    self.headFrameList:ReFreshData(#self.showList)
  end
end

function UIChangeUserHead:ShowListFiltetr()
  local showList = {}
  local tempType = 1
  local tempLastChoose = 2
  self.__LimitTimeItems = {}
  for i = 1, #self.allList do
    local listData = self.allList[i]
    if self.lastTog == 1 then
      if listData.id == PlayerDataCenter.inforData.avatarId then
        tempType = listData.cfg.type
        tempLastChoose = tempType + 1
      end
    elseif listData.id == PlayerDataCenter.inforData.avatarFrameId then
      tempType = listData.cfg.type
      tempLastChoose = tempType + 1
    end
    if self.showAll then
      table.insert(showList, listData)
    elseif listData.count > 0 then
      table.insert(showList, listData)
    end
  end
  table.sort(showList, function(a, b)
    if a.count ~= b.count then
      return a.count > b.count
    elseif a.outTime ~= b.outTime then
      if a.outTime == -1 then
        return false
      elseif b.outTime == -1 then
        return true
      else
        return a.outTime < b.outTime
      end
    else
      return a.cfg.id < b.cfg.id
    end
  end)
  self.isFirst = false
  if self.showType ~= 0 then
    local showTypeList = {}
    for i = 1, #showList do
      local listData = showList[i]
      if listData.cfg.type == self.showType then
        table.insert(showTypeList, listData)
      end
    end
    return showTypeList
  end
  return showList
end

function UIChangeUserHead:ClickHead(togItem, value)
  if not value then
    return
  end
  if self.lastTog == 1 then
    return
  end
  self.lastTog = 1
  self.right_Pannel:SaveHeadFrame(self.right_Pannel.savedHeadFrameItem)
  self:InitChooseInfo()
  self:ChangeHeadFrame(self:FindHeadFrameCfgFromCfgId(self.choosedFrameId))
  self:ChangeHead(self:FindHeadCfgFromCfgId(self.choosedId))
  self.allList = self:_GetUserHeadData()
  self.right_Pannel.isHead = true
  self.sortNode.isHead = true
  if self.headFrameList ~= nil then
    self.headFrameList.gameObject:SetActive(false)
  end
  if self.headList == nil then
    self.headList = UIHeadScroll.New()
    self.headList:Init(self.ui.headList)
  end
  self.headList.gameObject:SetActive(true)
  self.headList.ui.scro_List.onInstantiateItem = BindCallback(self, self._OnHeadInstantiateItem)
  self.headList.ui.scro_List.onChangeItem = BindCallback(self, self._OnHeadChangeItem)
  self:Show()
  self.showList = self:ShowListFiltetr()
  self:UnSelectTag()
  self.sortNode:InitSortList(self.allList, self.lastChoose)
end

function UIChangeUserHead:_HasHeadCfg(cfg)
  if cfg == nil then
    return 0
  end
  if PlayerDataCenter.inforData.heroHeadDict[cfg.get_id] == true then
    return 1
  else
    return PlayerDataCenter:GetItemCount(cfg.id)
  end
end

function UIChangeUserHead:_HasHeadFrameCfg(cfg)
  if cfg == nil then
    return 0
  else
    return PlayerDataCenter:GetItemCount(cfg.id)
  end
end

function UIChangeUserHead:_GetUserHeadData()
  local cfgAllList = {}
  for id, cfg in pairs(ConfigData.portrait) do
    if not PlayerDataCenter.inforData.isHeadLockedDict[cfg.get_id] and not cfg.is_hide then
      local count = self:_HasHeadCfg(cfg)
      local outTime = self:GetLimitTimeItemOutTime(id)
      table.insert(cfgAllList, {
        id = id,
        cfg = cfg,
        count = count,
        itype = eItemType.Avatar,
        outTime = outTime
      })
    end
  end
  return cfgAllList
end

function UIChangeUserHead:_OnHeadInstantiateItem(go)
  local item = UIHeadItem.New()
  item:Init(go)
  self.itemDic[go] = item
end

function UIChangeUserHead:_OnHeadChangeItem(go, index)
  local item = self.itemDic[go]
  local itemCfg = self.showList[index + 1]
  item:InitHeadItem(itemCfg, self.__ClickOneHead, self.resloader, self.__frameEffectPool)
  item:InitOutTime(itemCfg.outTime)
  if itemCfg.cfg.id == self.choosedId then
    self.lastChooseItemCfg = itemCfg
    self.lastChooseItem = item
    self.lastChooseItem.ui.img_HeadSel:SetActive(true)
  end
  self.__LimitTimeItems[item] = item
  if self.__LimitTimeUpdateTimerId == nil then
    self.__LimitTimeUpdateTimerId = TimerManager:StartTimer(60, self.__LimitTimeItemUpdate, self, false, false, true)
  end
end

function UIChangeUserHead:_OnHeadFrameInstantiateItem(go)
  local item = UIHeadItem.New()
  item:Init(go)
  self.itemDic[go] = item
end

function UIChangeUserHead:_OnHeadFrameChangeItem(go, index)
  local itemFrame = self.itemDic[go]
  local itemCfg = self.showList[index + 1]
  itemFrame:InitHeadItem(itemCfg, self.__ClickOneHeadFrame, self.resloader, self.__frameEffectPool)
  itemFrame:InitOutTime(itemCfg.outTime)
  if itemCfg.cfg.id == self.choosedFrameId then
    self.lastChooseFrameItemCfg = itemCfg
    self.lastChooseFrameItem = itemFrame
    self.lastChooseFrameItem.ui.img_HeadSel:SetActive(true)
  end
  self.__LimitTimeItems[itemFrame] = itemFrame
  if self.__LimitTimeUpdateTimerId == nil then
    self.__LimitTimeUpdateTimerId = TimerManager:StartTimer(60, self.__LimitTimeItemUpdate, self, false, false, true)
  end
end

function UIChangeUserHead:__LimitTimeItemUpdate()
  if self.__LimitTimeItems == nil then
    TimerManager:StopTimer(self.__LimitTimeUpdateTimerId)
    self.__LimitTimeUpdateTimerId = nil
    return
  end
  for k, v in pairs(self.__LimitTimeItems) do
    v:UpdateLimitTimeDetail()
  end
end

function UIChangeUserHead:ClickHeadFrame(togItem, value)
  if not value then
    return
  end
  if self.lastTog == 2 then
    return
  end
  self.lastTog = 2
  self.right_Pannel:SaveHead(self.right_Pannel.savedHeadItem)
  self:InitChooseInfo()
  self:ChangeHead(self:FindHeadCfgFromCfgId(self.choosedId))
  self:ChangeHeadFrame(self:FindHeadFrameCfgFromCfgId(self.choosedFrameId))
  self.right_Pannel.isHead = false
  self.sortNode.isHead = false
  self.allList = self:_GetUserHeadFrameData()
  if self.headList ~= nil then
    self.headList.gameObject:SetActive(false)
  end
  if self.headFrameList == nil then
    self.headFrameList = UIHeadScroll.New()
    self.headFrameList:Init(self.ui.headList)
  end
  self.headFrameList.gameObject:SetActive(true)
  self.headFrameList.ui.scro_List.onInstantiateItem = BindCallback(self, self._OnHeadFrameInstantiateItem)
  self.headFrameList.ui.scro_List.onChangeItem = BindCallback(self, self._OnHeadFrameChangeItem)
  self:Show()
  self.showList = self:ShowListFiltetr()
  self:UnSelectTag()
  self.sortNode:InitSortList(self.allList, self.lastChoose)
end

function UIChangeUserHead:_GetUserHeadFrameData()
  local cfgAllList = {}
  for id, cfg in pairs(ConfigData.portrait_frame) do
    local count = self:_HasHeadFrameCfg(cfg)
    if not cfg.is_hide then
      local outTime = self:GetLimitTimeItemOutTime(id)
      table.insert(cfgAllList, {
        id = id,
        cfg = cfg,
        count = count,
        itype = eItemType.AvatarFrame,
        outTime = outTime
      })
    end
  end
  return cfgAllList
end

function UIChangeUserHead:FindHeadCfgFromCfgId(cfgId)
  local headCfg = ConfigData.portrait[cfgId]
  local outTime = self:GetLimitTimeItemOutTime(cfgId)
  return {
    id = cfgId,
    cfg = headCfg,
    count = 1,
    itype = eItemType.Avatar,
    outTime = outTime
  }
end

function UIChangeUserHead:FindHeadFrameCfgFromCfgId(cfgId)
  local headFrameCfg = ConfigData.portrait_frame[cfgId]
  local outTime = self:GetLimitTimeItemOutTime(cfgId)
  return {
    id = cfgId,
    cfg = headFrameCfg,
    count = 1,
    itype = eItemType.AvatarFrame,
    outTime = outTime
  }
end

function UIChangeUserHead:GetLimitTimeItemOutTime(cfgId)
  local outTime = -1
  local limitTimeItemCfg = ConfigData.item_time_limit[cfgId]
  if limitTimeItemCfg ~= nil then
    if limitTimeItemCfg.type == eLimitTimeItemType.Dyn then
      local stackInfo = PlayerDataCenter:GetDynLimtTimeItemStackInfo(cfgId, 1)
      if stackInfo ~= nil then
        outTime = stackInfo.time
      end
    elseif limitTimeItemCfg.type == eLimitTimeItemType.Fixed then
      outTime = limitTimeItemCfg.time
    end
  end
  return outTime
end

function UIChangeUserHead:ChangeHead(itemCfg)
  self.right_Pannel.itemHeadCfg = itemCfg
  if self:_HasHeadCfg(itemCfg.cfg) > 0 then
    self.right_Pannel.savedHeadItem = itemCfg
  end
  self.right_Pannel:changeHeadState()
end

function UIChangeUserHead:ChangeHeadFrame(itemCfg)
  self.right_Pannel.itemHeadFrameCfg = itemCfg
  if self:_HasHeadFrameCfg(itemCfg.cfg) > 0 then
    self.right_Pannel.savedHeadFrameItem = itemCfg
  end
  self.right_Pannel:changeHeadFrameState()
end

function UIChangeUserHead:ClickOneHead(itemCfg, nowchoose)
  self:ChangeHead(itemCfg)
  if self.lastChooseItem == nil then
    nowchoose.ui.img_HeadSel:SetActive(true)
    self.lastChooseItem = nowchoose
    self.lastChooseItemCfg = nowchoose.itemCfg
  elseif nowchoose.itemCfg.id == self.lastChooseItem.itemCfg.id then
    nowchoose.ui.img_HeadSel:SetActive(true)
  else
    nowchoose.ui.img_HeadSel:SetActive(true)
    self.lastChooseItem.ui.img_HeadSel:SetActive(false)
    self.lastChooseItem = nowchoose
    self.lastChooseItemCfg = nowchoose.itemCfg
  end
  self.choosedId = itemCfg.id
end

function UIChangeUserHead:ClickOneHeadFrame(itemCfg, nowchoose)
  self:ChangeHeadFrame(itemCfg)
  if self.lastChooseFrameItem == nil then
    nowchoose.ui.img_HeadSel:SetActive(true)
    self.lastChooseFrameItem = nowchoose
    self.lastChooseFrameItemCfg = nowchoose.itemCfg
  elseif nowchoose.itemCfg.id == self.lastChooseFrameItem.itemCfg.id then
    nowchoose.ui.img_HeadSel:SetActive(true)
  else
    nowchoose.ui.img_HeadSel:SetActive(true)
    self.lastChooseFrameItem.ui.img_HeadSel:SetActive(false)
    self.lastChooseFrameItem = nowchoose
    self.lastChooseFrameItemCfg = nowchoose.itemCfg
  end
  self.choosedFrameId = itemCfg.id
end

function UIChangeUserHead:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.tog_Head:OnDelete()
  self.tog_HeadFrame:OnDelete()
  self.right_Pannel:OnDelete()
  self.sortNode:OnDelete()
  TimerManager:StopTimer(self.__LimitTimeUpdateTimerId)
  self.__LimitTimeItems = nil
  base.OnDelete(self)
end

return UIChangeUserHead
