local base = UIBaseWindow
local UIWarChessEvent = class("UIWarChessEvent", base)
local cs_ResLoader = CS.ResLoader
local UINWarChessEventChoiceItem = require("Game.WarChess.UI.Event.UINWarChessEventChoiceItem")
local UINWarChessEventEventNode = require("Game.WarChess.UI.Event.UINWarChessEventEventNode")
local UINWarChessEventLongNode = require("Game.WarChess.UI.Event.UINWarChessEventLongNode")
local UINWarChessEventFirstChoiceExitNode = require("Game.WarChess.UI.Event.UINWarChessEventFirstChoiceExitNode")
local eEventShowType = {
  normal = 0,
  long = 2,
  firstSelectExit = 4
}

function UIWarChessEvent:OnInit()
  self.resloader = cs_ResLoader.Create()
  self.ui.obj_choiceItem:SetActive(false)
  self.__eventTypeNode = {
    [eEventShowType.normal] = {
      go = self.ui.obj_eventNode,
      class = UINWarChessEventEventNode
    },
    [eEventShowType.long] = {
      go = self.ui.obj_longTextNode,
      class = UINWarChessEventLongNode
    },
    [eEventShowType.firstSelectExit] = {
      go = self.ui.obj_eventNode,
      class = UINWarChessEventFirstChoiceExitNode
    }
  }
  for _, nodeCfg in pairs(self.__eventTypeNode) do
    nodeCfg.go:SetActive(false)
  end
  self.__onClickEventChoice = BindCallback(self, self.__OnClickEventChoice)
  UIUtil.AddButtonListener(self.ui.btn_Map, self, self.OnClickShowMap)
  UIUtil.AddButtonListener(self.ui.btn_Exit, self, self.__OnClickExit)
  self.ui.tex_MapBtnName:SetIndex(0)
  self.__refreshItemNum = BindCallback(self, self.__RefreshItemNum)
  MsgCenter:AddListener(eMsgEventId.WC_ItemNumChange, self.__refreshItemNum)
  MsgCenter:AddListener(eMsgEventId.WC_ItemLimitNumChange, self.__refreshItemNum)
end

function UIWarChessEvent:InitWCEvent(eventCtrl)
  self.eventCtrl = eventCtrl
  local eventCfg = self.eventCtrl:GetWCEventConfig()
  local choiceDatas = self.eventCtrl:GetWCEventChoices()
  self:InitWCEventWithoutCtrl(eventCfg, choiceDatas)
end

function UIWarChessEvent:InitWCEventWithoutCtrl(eventCfg, choiceDatas, OnClickSelectFunc, OnClickExitFunc)
  self._eventCfg = eventCfg
  local nodeCfg = self.__eventTypeNode[eventCfg.event_tag]
  if nodeCfg ~= nil then
    self.__eventNode = nodeCfg.class.New()
    nodeCfg.go:SetActive(true)
    self.__eventNode:Init(nodeCfg.go)
    self.__eventNode:InitWCEventNode(self, eventCfg, choiceDatas, self.__onClickEventChoice)
    self:RefreshWCEventBG(eventCfg.pic)
  end
  if eventCfg.event_tag == eEventShowType.firstSelectExit then
    local firstChoiceData = choiceDatas[1]
    self.__firstChoiceData = firstChoiceData
    self.ui.btn_Exit.gameObject:SetActive(true)
    self.ui.btn_Map.gameObject:SetActive(false)
  else
    self.ui.btn_Exit.gameObject:SetActive(false)
    self.ui.btn_Map.gameObject:SetActive(true)
  end
  self:__RefreshItemNum()
  self._OnClickSelectFunc = OnClickSelectFunc
  self._OnClickExitFunc = OnClickExitFunc
end

function UIWarChessEvent:__RefreshItemNum()
  local itemId = self._eventCfg.ref_item
  if itemId ~= 0 and WarChessSeasonManager:GetIsInWCSeason() then
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    local capacity = wcCtrl.backPackCtrl:GetWCItemCapacity(itemId)
    local curNum = wcCtrl.backPackCtrl:GetWCItemNum(itemId)
    self.ui.obj_countNode:SetActive(true)
    if 0 < capacity then
      self.ui.tex_Count.text = tostring(curNum) .. "/" .. tostring(capacity)
    else
      self.ui.tex_Count.text = tostring(curNum)
    end
  else
    self.ui.obj_countNode:SetActive(false)
  end
end

function UIWarChessEvent:GetWCChoicePool()
  if self.choicePool == nil then
    self.choicePool = UIItemPool.New(UINWarChessEventChoiceItem, self.ui.obj_choiceItem)
  end
  return self.choicePool
end

function UIWarChessEvent:RefreshWCEventBG(picId)
  local cfg = ConfigData.warchess_event_pic[picId]
  if cfg == nil then
    error("warchess_event_pic is null,id:" .. tostring(picId))
    return
  end
  local colCfg = cfg.color
  local color = Color.New(colCfg[1] / 255, colCfg[2] / 255, colCfg[3] / 255)
  self.ui.img_TypeColor.color = color
  self.ui.img_RoomIcon.color = color
  self.ui.img_RoomIcon.sprite = CRH:GetSprite(cfg.icon, CommonAtlasType.ExplorationIcon)
  self.ui.img_RoomIcon.gameObject:SetActive(true)
  self.ui.tex_RoomType.text = LanguageUtil.GetLocaleText(cfg.title)
end

function UIWarChessEvent:OnClickShowMap()
  local isOpen = self.ui.frameNode.activeInHierarchy
  self.ui.tex_MapBtnName:SetIndex(isOpen and 1 or 0)
  self.ui.frameNode:SetActive(not isOpen)
  self.ui.itemHolder:SetActive(not isOpen)
end

function UIWarChessEvent:__OnClickExit()
  if self._OnClickExitFunc ~= nil then
    self._OnClickExitFunc()
    return
  end
  if self.__firstChoiceData ~= nil then
    self:__OnClickEventChoice(self.__firstChoiceData)
  else
    warn("not have exit choice")
  end
end

function UIWarChessEvent:__OnClickEventChoice(choiceData)
  if self._OnClickSelectFunc ~= nil then
    self._OnClickSelectFunc(choiceData)
    return
  end
  self.eventCtrl:WCEventSelect(choiceData)
end

function UIWarChessEvent:OnDelete()
  base.OnDelete(self)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.WC_ItemNumChange, self.__refreshItemNum)
  MsgCenter:RemoveListener(eMsgEventId.WC_ItemLimitNumChange, self.__refreshItemNum)
end

return UIWarChessEvent
