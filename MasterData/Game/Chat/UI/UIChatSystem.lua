local UIChatSystem = class("UIChatSystem", UIBaseWindow)
local base = UIBaseWindow
local emptyStr = ""
local HomeChatData = require("Game.Chat.HomeChatData")
local UINChatElement = require("Game.Chat.UI.UINChatElement")
local UINChatElementMyItem = require("Game.Chat.UI.UINChatElementMyItem")
local UINChatElementOtherItem = require("Game.Chat.UI.UINChatElementOtherItem")

function UIChatSystem:OnInit()
  self.firstChatItem = nil
  self.latestChatItem = nil
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.Delete)
  self.myItemPool = UIItemPool.New(UINChatElementMyItem, self.ui.obj_myItem)
  self.otherItemPool = UIItemPool.New(UINChatElementOtherItem, self.ui.obj_guestItem)
  self.ui.loop_scroll.onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  self.ui.loop_scroll.onChangeItem = BindCallback(self, self.m_OnChangeItem)
  self.ui.loop_scroll.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.ui.loop_scroll.onValueChanged:AddListener(BindCallback(self, self.__OnValueChanged))
  self.__RefreshSendCD = BindCallback(self, self.RefreshSendCD)
  self.__OnNewChatDataComes = BindCallback(self, self.OnNewChatDataComes)
  MsgCenter:AddListener(eMsgEventId.OnNewWordChatDataCome, self.__OnNewChatDataComes)
  UIUtil.AddButtonListener(self.ui.btn_HasNewChat, self, self.Roll2NewChart)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.Delete)
  UIUtil.AddButtonListener(self.ui.btn_Send, self, self.__OnClickSend)
  UIUtil.AddValueChangedListener(self.ui.tog_Emoji, self, self.__OnemojiTogValueChange)
  UIUtil.AddValueChangedListener(self.ui.inputField, self, self.__OnInputValueChange)
end

function UIChatSystem:InitChatSystem()
  self.chatItemDic = {}
  self.homeChatDataCenter = PlayerDataCenter.homeChatDataCenter
  self.isNeedRefresh2New = true
  self.homeChatDataCenter:AddOnSendCdChangeCallback(self.__RefreshSendCD)
  self:TryRecorverLastInput()
  self:OnNewChatDataComes(0)
  self:RefreshSendCD(self.homeChatDataCenter:GetSendCd())
end

function UIChatSystem:TryRecorverLastInput()
  local lastInput = self.homeChatDataCenter:GetLastInputMsg()
  if lastInput ~= nil then
    self.ui.inputField.text = lastInput
  end
end

function UIChatSystem:OnNewChatDataComes(removeNum, roll2new)
  self.ui.noMessage:SetActive(self.homeChatDataCenter:GetCurDataCount() <= 0)
  
  local function refillFromeStart()
    self:BeforeRefreshClean()
    self.ui.loop_scroll.totalCount = self.homeChatDataCenter:GetCurDataCount()
    self.ui.loop_scroll:RefillCells()
    self.ui.btn_HasNewChat.gameObject:SetActive(true)
  end
  
  local function refillFromeEnd()
    self:BeforeRefreshClean()
    self.ui.loop_scroll.totalCount = self.homeChatDataCenter:GetCurDataCount()
    self.ui.loop_scroll:RefillCellsFromEnd()
    self.ui.btn_HasNewChat.gameObject:SetActive(false)
  end
  
  if self.ui.loop_scroll.totalCount == 0 then
    refillFromeEnd()
    self.homeChatDataCenter:CleanNewChatNum()
    return
  end
  if roll2new or self:IsChatItemVisiable(self.latestChatItem) then
    refillFromeEnd()
    self.homeChatDataCenter:CleanNewChatNum()
  elseif 0 < removeNum and self:IsChatItemVisiable(self.firstChatItem) then
    refillFromeStart()
  else
    if 0 < removeNum then
      local startindex, endindex = self.ui.loop_scroll:SetOffest2Index(-removeNum)
      if startindex <= 0 then
        refillFromeStart()
      elseif endindex >= self.ui.loop_scroll.totalCount then
        refillFromeEnd()
        self.homeChatDataCenter:CleanNewChatNum()
      else
        self.ui.loop_scroll:RefreshCells()
      end
    else
      self.ui.loop_scroll.totalCount = self.homeChatDataCenter:GetCurDataCount()
      self.ui.loop_scroll:RefreshCells()
    end
    self.ui.btn_HasNewChat.gameObject:SetActive(true)
  end
  if self.ui.btn_HasNewChat.gameObject.activeInHierarchy then
    local chatNum = self.homeChatDataCenter:GetNewChatNum()
    if 99 < chatNum then
      chatNum = "99+"
    end
    self.ui.tex_NewChatCount:SetIndex(0, tostring(chatNum))
  end
  local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWin ~= nil then
    homeWin.homeLeftNode:RefreshWorldChatNewMessage(removeNum, true)
  end
end

function UIChatSystem:m_OnNewItem(go)
  local chatItem = UINChatElement.New()
  chatItem:Init(go)
  chatItem:InitChatElement(self.myItemPool, self.otherItemPool)
  self.chatItemDic[go] = chatItem
end

function UIChatSystem:m_OnChangeItem(go, index)
  local chatItem = self.chatItemDic[go]
  if chatItem == nil then
    error("Can't find chatItem by gameObject")
    return
  end
  local chatData = self.homeChatDataCenter:GetChatDataAtIndex(index + 1)
  if chatData == nil then
    error("Can't find chatData by index, index = " .. tonumber(index))
  end
  chatItem:RefreshChatItem(chatData, index)
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.loop_scroll.transform)
  if index == 0 then
    self.firstChatItem = chatItem
  end
  if index == self.ui.loop_scroll.totalCount - 1 then
    self.latestChatItem = chatItem
  end
end

function UIChatSystem:__OnReturnItem(go)
  local chatItem = self.chatItemDic[go]
  if chatItem == nil then
    error("Can't find chatItem by gameObject")
    return
  end
  chatItem:OnRecycle()
  if chatItem.indexInList == 0 then
    self.firstChatItem = nil
  end
  if chatItem.indexInList == self.ui.loop_scroll.totalCount - 1 then
    self.latestChatItem = nil
  end
end

function UIChatSystem:__OnValueChanged(pos)
  if self.ui.btn_HasNewChat.gameObject.activeInHierarchy and self:IsChatItemVisiable(self.latestChatItem) then
    self.ui.btn_HasNewChat.gameObject:SetActive(false)
  end
end

function UIChatSystem:IsChatItemVisiable(chatItem)
  if chatItem == nil then
    return false
  end
  return self.ui.loop_scroll:IsItemVisiable(chatItem.transform)
end

function UIChatSystem:BeforeRefreshClean()
  self.firstChatItem = nil
  self.latestChatItem = nil
end

function UIChatSystem:Roll2NewChart()
  self:OnNewChatDataComes(0, true)
end

function UIChatSystem:__OnInputValueChange(value)
  local _, str = self.homeChatDataCenter:ValidInputChange(value)
  self.homeChatDataCenter:SetLastInputMsg(str)
  self.ui.inputField.text = str
end

function UIChatSystem:__OnemojiTogValueChange(isOpenSendemoji)
  if isOpenSendemoji then
  else
  end
end

function UIChatSystem:__OnClickSend()
  local sendString = self.ui.inputField.text
  local couldSend = self.homeChatDataCenter:ValidSendChat(sendString) and self.homeChatDataCenter:ValidSendTime()
  if couldSend then
    PlayerDataCenter.homeChatDataCenter:AddNewChatData(HomeChatData.CreateChatData(true, false, sendString, nil))
    self.ui.inputField.text = emptyStr
    self.homeChatDataCenter:SetLastInputMsg(nil)
    self:RefreshSendCD(self.homeChatDataCenter:GetSendCd())
  end
end

function UIChatSystem:RefreshSendCD(cd)
  if 0 < cd then
    self.ui.textInfo_SendBtn:SetIndex(1, tostring(cd))
  else
    self.ui.textInfo_SendBtn:SetIndex(0)
  end
end

function UIChatSystem:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnNewWordChatDataCome, self.__OnNewChatDataComes)
  self.homeChatDataCenter:RemoveOnSendCdChangeCallback(self.__RefreshSendCD)
  base.OnDelete(self)
end

return UIChatSystem
