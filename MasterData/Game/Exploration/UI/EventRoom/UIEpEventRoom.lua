local UIEpEventRoom = class("UIEpEventRoom", UIBaseWindow)
local base = UIBaseWindow
local Enum = require("Game.Exploration.EpEventRoomEnum")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local EventPage = require("Game.Exploration.UI.EventRoom.UINEpEventNode")
local LotteryPage = require("Game.Exploration.UI.EventRoom.UINEpEntLotteryNode")
local LongTextPage = require("Game.Exploration.UI.EventRoom.UINEpEntLongTexNode")
local UINEpEventPartFusion = require("Game.Exploration.UI.EventRoom.UINEpEventPartFusion")
local CursePage = require("Game.Exploration.UI.EventRoom.UINEpCurseNode")
local ShopPage = require("Game.Exploration.UI.EventRoom.UINEpShopNode")
local UIChoiceItem = require("Game.Exploration.UI.EventRoom.UIEpEventChoiceItem")
local GoodsItem = require("Game.Exploration.UI.EventRoom.UIEpChoiceGoodsItem")

function UIEpEventRoom:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Map, self, self.OnMapButtonClick)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.OnRefreshBtnClick)
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.OnSkipBtnClick)
  self.__OnChipDetailActiveChange = BindCallback(self, self.OnChipDetailActiveChange)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  self.__FromMapBackToUI = BindCallback(self, self.FromMapBackToUI)
  MsgCenter:AddListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  self.ui.obj_choiceItem:SetActive(false)
  self.ui.obj_goodsNode:SetActive(false)
  self.eventPageNode = {
    [Enum.eBranch.Event] = {
      go = self.ui.obj_eventNode,
      class = EventPage
    },
    [Enum.eBranch.Lottery] = {
      go = self.ui.obj_lotteryNode,
      class = LotteryPage
    },
    [Enum.eBranch.LongText] = {
      go = self.ui.obj_longTextNode,
      class = LongTextPage
    },
    [Enum.eBranch.PartFusion] = {
      go = self.ui.obj_metalGearNode,
      class = UINEpEventPartFusion
    },
    [Enum.eBranch.Curse] = {
      go = self.ui.obj_eventNode,
      class = CursePage
    },
    [Enum.eBranch.EventShop] = {
      go = self.ui.obj_shopNode,
      class = ShopPage
    }
  }
  self:ActiveUIMask(false)
end

function UIEpEventRoom:InitEpEventRoom(eventData, choiceClickAction)
  self.pageDic = {}
  self:UpdEpEventRoom(eventData, choiceClickAction)
  self:_RefreshWinUI()
end

function UIEpEventRoom:UpdEpEventRoom(eventData, choiceClickAction)
  self:_RefreshData(eventData)
  self:_RefreshPageNode(choiceClickAction)
end

function UIEpEventRoom:_RefreshData(eventData)
  local eventCfg = ConfigData.event[eventData.eventId]
  if eventCfg == nil then
    error("eRoomCfg null,id:" .. tostring(eventData.eventId))
    return
  end
  self.eventCfg = eventCfg
  self.roomData = eventData
  self.onMapClick = false
end

function UIEpEventRoom:_RefreshPageNode(choiceClickAction)
  local branchId = self.eventCfg.event_tag or 0
  if self.lastPage ~= nil then
    self.lastPage:Hide()
  end
  local curPage = self.pageDic[branchId]
  if curPage ~= nil then
    curPage:RefreshBranchPage()
  else
    local ePageData = self.eventPageNode[branchId]
    if ePageData == nil then
      error("ePageData is nil ID:" .. tostring(branchId))
      return
    end
    curPage = ePageData.class.New()
    curPage:Init(ePageData.go)
    curPage:InitBranchPage(self, choiceClickAction)
    self.pageDic[branchId] = curPage
  end
  curPage:Show()
  self.lastPage = curPage
end

function UIEpEventRoom:_RefreshWinUI()
  self.ui.btn_Map.gameObject:SetActive(ExplorationManager:HasRoomSceneInEp())
  self:_SwitchMapBtnState(self.onMapClick)
  self:_RefreshRoomTypeUI()
end

function UIEpEventRoom:_SwitchMapBtnState(isOpen)
  self.ui.obj_Frame:SetActive(not isOpen)
  self.ui.tex_BtnName:SetIndex(not isOpen and 0 or 1)
end

function UIEpEventRoom:_RefreshRoomTypeUI()
  local eRoomType = self.roomData.eRoomType
  local cfg = ConfigData.exploration_roomtype[eRoomType]
  if cfg == nil then
    error("exploration room type is null,id:" .. tostring(eRoomType))
    return
  end
  local colCfg = cfg.color
  local color = Color.New(colCfg[1], colCfg[2], colCfg[3])
  self.ui.img_TypeColor.color = color
  self.ui.img_RoomIcon.color = color
  self.ui.img_RoomIcon.sprite = CRH:GetSprite(cfg.icon, CommonAtlasType.ExplorationIcon)
  self.ui.img_RoomIcon.gameObject:SetActive(true)
  if eRoomType == ExplorationEnum.eRoomType.recovery then
    self.ui.tex_RoomType:SetIndex(1)
  elseif eRoomType == ExplorationEnum.eRoomType.partfusion then
    self.ui.tex_RoomType:SetIndex(2)
    self.ui.img_RoomIcon.gameObject:SetActive(false)
  else
    self.ui.tex_RoomType:SetIndex(0)
  end
end

function UIEpEventRoom:SetSkipBtnActive(bValue)
  self.ui.btn_Skip.gameObject:SetActive(bValue)
end

function UIEpEventRoom:SetRefreshBtn(bValue)
  if bValue then
    self.ui.btn_Refresh.gameObject:SetActive(bValue)
    self:RefreshRefreshBtn()
  else
    self.ui.btn_Refresh.gameObject:SetActive(bValue)
  end
end

function UIEpEventRoom:RefreshRefreshBtn()
  local items = self.eventCfg.init_fresh_price
  if 2 <= #items then
    local itemId = items[1]
    local itemNum = items[2]
    local currMoney = ExplorationManager:GetDynPlayer():GetItemCount(itemId)
    if itemNum <= currMoney then
      self.ui.btn_Refresh.enabled = true
      self.ui.tex_Refresh:SetIndex(0)
      self.ui.img_Pay.sprite = CRH:GetSpriteByItemId(itemId)
      self.ui.tex_RefreshPay.text = tostring(itemNum)
      self.ui.obj_refreshLack:SetActive(false)
      self.ui.obj_pay:SetActive(true)
    else
      self.ui.btn_Refresh.enabled = false
      self.ui.tex_Refresh:SetIndex(1)
      self.ui.obj_pay:SetActive(false)
      self.ui.obj_refreshLack:SetActive(true)
    end
  end
end

function UIEpEventRoom:GetEventChoiceItem(index)
  if self.lastPage.choiceItemDic == nil then
    return nil
  end
  return self.lastPage.choiceItemDic[index]
end

function UIEpEventRoom:ActiveUIMask(flag)
  self.ui.obj_AniMask:SetActive(flag)
end

function UIEpEventRoom:OnMapButtonClick()
  if self.onMapClick == nil then
    self.onMapClick = false
  else
    self.onMapClick = not self.onMapClick
  end
  self:_SwitchMapBtnState(self.onMapClick)
end

function UIEpEventRoom:FromMapBackToUI()
  self.onMapClick = false
  self:_SwitchMapBtnState(self.onMapClick)
end

function UIEpEventRoom:OnChipDetailActiveChange(bool)
  if bool then
    self:Hide()
  else
    self:Show()
  end
end

function UIEpEventRoom:GetAniItemPosAndScale()
  local position = self.transform:InverseTransformPoint(self.ui.obj_ChipAniNode.transform.position)
  local scale = self.ui.obj_ChipAniNode.transform.scale
  return position, scale
end

function UIEpEventRoom:CloseWindow()
  self:Delete()
end

function UIEpEventRoom:GetChoiceItemPool()
  if self.choicePool == nil then
    self.choicePool = UIItemPool.New(UIChoiceItem, self.ui.obj_choiceItem)
  end
  return self.choicePool
end

function UIEpEventRoom:GetExtraItemPool()
  if self.extraPool == nil then
    self.extraPool = UIItemPool.New(GoodsItem, self.ui.obj_goodsNode)
  end
  return self.extraPool
end

function UIEpEventRoom:OnRefreshBtnClick()
  ExplorationManager.epCtrl.eventCtrl:SendMsgShopRefresh(function()
    self:RefreshRefreshBtn()
  end)
end

function UIEpEventRoom:OnSkipBtnClick()
  ExplorationManager.epCtrl.eventCtrl:SendExit()
end

function UIEpEventRoom:OnRareMoneyChange()
  self:RefreshRefreshBtn()
  if self.lastPage ~= nil then
    self.lastPage:RefreshBranchPage()
  end
end

function UIEpEventRoom:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  MsgCenter:RemoveListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  for id, page in pairs(self.pageDic) do
    page:Delete()
  end
  if self.choicePool ~= nil then
    self.choicePool:DeleteAll()
    self.choicePool = nil
  end
  if self.extraPool ~= nil then
    self.extraPool:DeleteAll()
    self.extraPool = nil
  end
  base.OnDelete(self)
end

return UIEpEventRoom
