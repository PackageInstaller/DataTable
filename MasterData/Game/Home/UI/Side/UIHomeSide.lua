local UIHomeSide = class("UIHomeSide", UIBaseWindow)
local base = UIBaseWindow
local UINHomeGeneralBtn = require("Game.Home.UI.UINHomeGeneralBtn")
local UINHomeSideResItem = require("Game.Home.UI.Side.UINHomeSideResItem")
local UINHomeSideBuildingItem = require("Game.Home.UI.Side.UINHomeSideBuildingItem")
local cs_MessageCommon = CS.MessageCommon
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local UINHomeSideNoticeItem = require("Game.Home.UI.Side.UINHomeSideNoticeItem")

function UIHomeSide:OnInit()
  self.homeController = ControllerManager:GetController(ControllerTypeId.HomeController, true)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.CloseSide)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.CloseSide)
  self.ui.tween_side.onRewind:AddListener(BindCallback(self, self.OnClose))
  UIUtil.AddButtonListener(self.ui.btn_CleanNotice, self, self.OnClickCleanNotice)
  UIUtil.AddButtonListener(self.ui.btn_GameNotice, self, self.OnClickGameNotice)
  self.__RefreshBuildingList = BindCallback(self, self.RefreshBuildingList)
  self.__RefreshResourceProduction = BindCallback(self, self.RefreshResourceProduction)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.OnClickCollectResource)
  self.__CollectResourceCallback = BindCallback(self, self.CollectResourceCallback)
  self.produceItemPool = UIItemPool.New(UINHomeSideResItem, self.ui.obj_produceItem)
  self.ui.obj_produceItem:SetActive(false)
  self.buildingItemPool = UIItemPool.New(UINHomeSideBuildingItem, self.ui.obj_buildingItem)
  self.ui.obj_buildingItem:SetActive(false)
  self.__CloseSide = BindCallback(self, self.CloseSide)
  
  function self.__RefeshNotices()
    self.ui.loop_messageList:RefreshCells()
  end
  
  self.ui.loop_messageList.onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  self.ui.loop_messageList.onChangeItem = BindCallback(self, self.m_OnChangeItem)
  self.noticeItemDic = {}
  self.sideNoticeList = nil
end

function UIHomeSide:InitSide(homeUI)
  self.homeUI = homeUI
  self.resloader = homeUI.resloader
end

function UIHomeSide:OpenSide()
  self:Show()
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.layout.transform)
  self:RefeshNotices()
  self.homeController:SetNeedUpdateProduction(true, self.__RefreshResourceProduction)
  self.homeController:SetNeedUpdateConstruct(true, self.__RefreshBuildingList)
  self.ui.tween_side:DOPlayForward()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Notice)
  self.ui.btn_GameNotice.gameObject:SetActive(isUnlock and not CS.ClientConsts.IsAudit)
  AudioManager:PlayAudioById(1088)
end

function UIHomeSide:CloseSide()
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
  self.homeController:SetNeedUpdateProduction(false, nil)
  self.homeController:SetNeedUpdateConstruct(false, nil)
  self.ui.tween_side:DOPlayBackwards()
  AudioManager:PlayAudioById(1089)
end

function UIHomeSide:OnClose()
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  self:Hide()
end

function UIHomeSide:RefeshNotices(playTween)
  local sideNoticeList = NoticeManager:GetSideNoticeList()
  self.sideNoticeList = sideNoticeList
  local noMessage = #sideNoticeList <= 0
  self.ui.obj_messageEmpty:SetActive(noMessage)
  self.ui.obj_cleanMessage:SetActive(not noMessage)
  self.ui.loop_messageList.gameObject:SetActive(not noMessage)
  if playTween and noMessage then
    self.ui.canvasGroup_emptyNode:DOFade(0, 0.6):From():SetLink(self.ui.canvasGroup_emptyNode.gameObject)
  end
  local num = #sideNoticeList
  self.ui.loop_messageList.totalCount = num
  self.ui.loop_messageList:RefillCells()
end

function UIHomeSide:m_OnNewItem(go)
  local noticeItem = UINHomeSideNoticeItem.New()
  noticeItem:Init(go)
  noticeItem:InitSideResItem(self.__CloseSide, self.resloader, self.__RefeshNotices)
  self.noticeItemDic[go] = noticeItem
end

function UIHomeSide:m_OnChangeItem(go, index)
  local noticeItem = self.noticeItemDic[go]
  if noticeItem == nil then
    error("Can't find noticeItem by gameObject")
    return
  end
  local noticeData = self.sideNoticeList[index + 1]
  if noticeData == nil then
    error("Can't find noticeData by index, index = " .. tonumber(index))
  end
  noticeItem:RefreshSideResItem(noticeData)
end

function UIHomeSide:m_GetItemGoByIndex(dataIndex)
  local go = self.ui.loop_messageList:GetCellByIndex(dataIndex - 1)
  if go ~= nil then
    local noticeItem = self.noticeItemDic[go]
    return noticeItem
  end
  return nil
end

function UIHomeSide:OnClickCleanNotice()
  local playTweenNum = 0
  local HideOver = BindCallback(self, function()
    playTweenNum = playTweenNum - 1
    if playTweenNum <= 0 then
      self.sideNoticeList = nil
      NoticeManager:CleanAllNotice()
      self:RefeshNotices(true)
    end
  end)
  for dataIndex, noticeData in ipairs(self.sideNoticeList) do
    local noticeItem = self:m_GetItemGoByIndex(dataIndex)
    if noticeItem ~= nil then
      playTweenNum = playTweenNum + 1
      noticeItem:PlayHideTween(HideOver)
    end
  end
end

function UIHomeSide:OnClickGameNotice()
  UIManager:CreateWindowAsync(UIWindowTypeID.GameNotice, function(win)
    if win == nil then
      return
    end
    local homeSide = UIManager:GetWindow(UIWindowTypeID.HomeSide)
    if homeSide ~= nil then
      homeSide:CloseSide()
    end
    win:InitUIGameNotice(true)
  end)
end

function UIHomeSide:RefreshBuildingList(constructingBuildingLists)
  local oasisBuildingLists = constructingBuildingLists[BuildingBelong.Oasis]
  local sectorBuildingLists = constructingBuildingLists[BuildingBelong.Sector]
  local noBuild = #oasisBuildingLists <= 0 and #sectorBuildingLists <= 0
  self.ui.obj_constructionEmpty:SetActive(noBuild)
  self.ui.obj_constructionScroll:SetActive(not noBuild)
  self.buildingItemPool:HideAll()
  for _, buildData in ipairs(oasisBuildingLists) do
    local item = self.buildingItemPool:GetOne()
    item:RefreshBuildingItem(buildData)
  end
  for _, buildData in ipairs(sectorBuildingLists) do
    local item = self.buildingItemPool:GetOne()
    item:RefreshBuildingItem(buildData, true)
  end
end

function UIHomeSide:RefreshResourceProduction(allResDic, allBuildDic)
  self.allBuildDic = allBuildDic
  local count = 0
  for itemId, data in pairs(allResDic) do
    count = count + 1
  end
  local noProdece = count == 0
  self.ui.obj_prodeceNode:SetActive(not noProdece)
  self.ui.obj_produceEmpty:SetActive(noProdece)
  self.produceItemPool:HideAll()
  for itemId, data in pairs(allResDic) do
    local item = self.produceItemPool:GetOne()
    item:Updatenfo(data)
  end
end

function UIHomeSide:OnClickCollectResource()
  if self.allBuildDic ~= nil then
    local legalBuildingIdDic = {}
    for buildId, _ in pairs(self.allBuildDic) do
      local builtData = PlayerDataCenter.AllBuildingData.built[buildId]
      if builtData ~= nil and builtData:CanGetBuildRes(true) then
        legalBuildingIdDic[buildId] = true
      end
    end
    if table.count(legalBuildingIdDic) <= 0 then
      return
    end
    self.homeController:SetNeedUpdateProduction(false, nil)
    local BuildingNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Building):SendBuildingCollectGroup(legalBuildingIdDic, self.__CollectResourceCallback)
    for _, item in ipairs(self.produceItemPool.listItem) do
      item:PlayCollect()
    end
  end
end

function UIHomeSide:CollectResourceCallback(objList)
  self.allBuildDic = nil
  self.homeController:SetNeedUpdateProduction(true, self.__RefreshResourceProduction)
  if objList.Count == 0 then
    return
  end
  local resDic = objList[0]
  for itemId, count in pairs(resDic) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg ~= nil then
      local msg = ConfigData:GetTipContent(TipContent.Building_GainReward, LanguageUtil.GetLocaleText(itemCfg.name), count)
      cs_MessageCommon.ShowMessageTips(msg, true)
    end
  end
end

function UIHomeSide:OnDelete()
  self.homeController:SetNeedUpdateProduction(false, nil)
  self.homeController:SetNeedUpdateConstruct(false, nil)
  base.OnDelete(self)
end

return UIHomeSide
