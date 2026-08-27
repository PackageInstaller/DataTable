local UINChatSystemChatBoardNode = class("UINChatSystemChatBoardNode", UIBaseNode)
local base = UIBaseNode
local CSLayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local UINChatItem = require("Game.ChatSystem.UI.ChatItem.UINChatItem")
local ChatSystemEnum = require("Game.ChatSystem.ChatSystemEnum")
local UINFriendChatItem = require("Game.ChatSystem.UI.ChatItem.UINFriendChatItem")
local UINMyChatItem = require("Game.ChatSystem.UI.ChatItem.UINMyChatItem")
local UINChatEmojiNode = require("Game.ChatSystem.UI.EmojiNode.UINChatEmojiNode")
local RenameHelper = require("Game.CommonUI.Rename.RenameHelper")
local newLine = CS.System.Environment.NewLine
local spaceString = " "
local emptyString = ""

function UINChatSystemChatBoardNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.resloader = CS.ResLoader.Create()
  self.firstChatItem = nil
  self.latestChatItem = nil
  self.chatItemDic = {}
  self.btnColors = {
    noText = self.ui.color_SendBtnNoText,
    withText = self.ui.color_SendBtnWithText
  }
  self.emojiNode = UINChatEmojiNode.New()
  self.emojiNode:Init(self.ui.obj_EmojiList)
  self.emojiNode:SetStateChangeCallback(BindCallback(self, self.OnEmojiPageStateChange))
  self.myItemPool = UIItemPool.New(UINMyChatItem, self.ui.obj_MyItem, false)
  self.friendItemPool = UIItemPool.New(UINFriendChatItem, self.ui.obj_FriendItem, false)
  self.ui.loop_scroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loop_scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.loop_scroll.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.ui.loop_scroll.onValueChanged:AddListener(BindCallback(self, self.__OnValueChanged))
  self.__ClearInputField = BindCallback(self, self.ClearInputField)
  self.ui.btn_BackTouch.gameObject:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Send, self, self.OnClickSend)
  UIUtil.AddButtonListener(self.ui.btn_Icon, self, self.OnClickEmojiBtn)
  UIUtil.AddButtonListener(self.ui.btn_BackTouch, self, self.OnClickEmojiBtn)
  UIUtil.AddButtonListener(self.ui.btn_HasNewChat, self, self.RollToNewChat)
  UIUtil.AddValueChangedListener(self.ui.ipt_Input, self, self.__OnInputValueChange)
end

function UINChatSystemChatBoardNode:InitChatBoardNode(chatBoard, onClickChatEntryImageCallback)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):PushTopStatusDataToBackStack(true)
  self.onClickChatEntryImageCallback = onClickChatEntryImageCallback
  local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  self.characterLimit = userChatCtrl:GetChatSystemMainCfg().speak_word_max
  self.ui.ipt_Input.characterLimit = self.characterLimit
  self.emojiNode:HideChatEmojiNode()
  self:Show()
  self.chatBoard = chatBoard
  self:OnNewChatMsgComes(0, true)
  self:RefreshChatBoardName()
end

function UINChatSystemChatBoardNode:RefreshChatBoardName()
  self.ui.tex_PlayerName.enabled = false
  PlayerDataCenter:GetUserInfoByUID(self.chatBoard.chatId, function(userInfoData)
    if IsNull(self.transform) then
      return
    end
    self.ui.tex_PlayerName.enabled = true
    self.ui.tex_PlayerName.text = userInfoData:GetAlias()
  end)
end

function UINChatSystemChatBoardNode:GetCurrentChatBoard()
  return self.chatBoard, self.active
end

function UINChatSystemChatBoardNode:OnNewChatMsgComes(removeNum, roll2new)
  local function refillFromeStart()
    self:BeforeRefreshClean()
    
    self.ui.loop_scroll.totalCount = self.chatBoard:GetCurMsgCount()
    self.ui.loop_scroll:RefillCells()
    self.ui.btn_HasNewChat.gameObject:SetActive(true)
  end
  
  local function refillFromeEnd()
    self:BeforeRefreshClean()
    self.ui.loop_scroll.totalCount = self.chatBoard:GetCurMsgCount()
    self.ui.loop_scroll:RefillCellsFromEnd()
    if not IsNull(self.ui.loop_scroll.verticalScrollbar) then
      self.ui.loop_scroll.verticalScrollbar.value = 1
    end
    self.ui.btn_HasNewChat.gameObject:SetActive(false)
  end
  
  if self.chatBoard:GetCurMsgCount() == 0 then
    refillFromeEnd()
    self.chatBoard:CleanNewChatNum()
    return
  end
  if roll2new or self:IsChatItemVisiable(self.latestChatItem) then
    refillFromeEnd()
    self.chatBoard:CleanNewChatNum()
  elseif 0 < removeNum and self:IsChatItemVisiable(self.firstChatItem) then
    refillFromeStart()
  else
    if 0 < removeNum then
      local startindex, endindex = self.ui.loop_scroll:SetOffest2Index(-removeNum)
      if startindex <= 0 then
        refillFromeStart()
      elseif endindex >= self.ui.loop_scroll.totalCount then
        refillFromeEnd()
        self.chatBoard:CleanNewChatNum()
      else
        self.ui.loop_scroll:RefreshCells()
      end
    else
      self.ui.loop_scroll.totalCount = self.chatBoard:GetCurMsgCount()
      self.ui.loop_scroll:RefreshCells()
    end
    self.ui.btn_HasNewChat.gameObject:SetActive(true)
  end
  if self.ui.btn_HasNewChat.gameObject.activeInHierarchy then
    local chatNum = self.chatBoard:GetNewChatNum()
    if 99 < chatNum then
      self.ui.tex_NewMessage:SetIndex(0)
    else
      self.ui.tex_NewMessage:SetIndex(1, tostring(chatNum))
    end
  end
end

function UINChatSystemChatBoardNode:__OnNewItem(go)
  local chatItem = UINChatItem.New()
  chatItem:Init(go)
  chatItem:InitChatItem(self.myItemPool, self.friendItemPool, self.resloader, self.onClickChatEntryImageCallback)
  self.chatItemDic[go] = chatItem
end

function UINChatSystemChatBoardNode:__OnChangeItem(go, index)
  local chatItem = self.chatItemDic[go]
  if chatItem == nil then
    error("Can't find chatItem by gameObject")
    return
  end
  local chatMsg = self.chatBoard:GetChatMsgAtIndex(index + 1)
  if chatMsg == nil then
    error("Can't find chatMsg by index, index = " .. tonumber(index))
  end
  local prefChatMsg = self.chatBoard:GetChatMsgAtIndex(index)
  chatItem:RefreshChatItem(chatMsg, index, prefChatMsg)
  CSLayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.loop_scroll.transform)
  if index == 0 then
    self.firstChatItem = chatItem
  end
  if index == self.ui.loop_scroll.totalCount - 1 then
    self.latestChatItem = chatItem
  end
end

function UINChatSystemChatBoardNode:__OnReturnItem(go)
  local chatItem = self.chatItemDic[go]
  if chatItem == nil then
    error("Can't find chatItem by gameObject")
    return
  end
  chatItem:OnRecycleChatItem()
  if chatItem.indexInList == 0 then
    self.firstChatItem = nil
  end
  if chatItem.indexInList == self.ui.loop_scroll.totalCount - 1 then
    self.latestChatItem = nil
  end
end

function UINChatSystemChatBoardNode:__OnValueChanged(pos)
  if self.ui.btn_HasNewChat.gameObject.activeInHierarchy and self:IsChatItemVisiable(self.latestChatItem) then
    self.ui.btn_HasNewChat.gameObject:SetActive(false)
  end
end

function UINChatSystemChatBoardNode:IsChatItemVisiable(chatItem)
  if chatItem == nil then
    return false
  end
  return self.ui.loop_scroll:IsItemVisiable(chatItem.transform)
end

function UINChatSystemChatBoardNode:BeforeRefreshClean()
  self.firstChatItem = nil
  self.latestChatItem = nil
end

function UINChatSystemChatBoardNode:RefreshLoopScroll()
  self.ui.loop_scroll:RefreshCells()
  self:RefreshChatBoardName()
end

function UINChatSystemChatBoardNode:__CheckAndClampInput()
  self.ui.ipt_Input.text = string.gsub(self.ui.ipt_Input.text, newLine, spaceString)
  local content = self.ui.ipt_Input.text
  local inputLength = RenameHelper:GetNameLength(content)
  if inputLength > self.characterLimit then
    content = RenameHelper:ClampNameInLength(content, self.characterLimit)
    self.ui.ipt_Input.text = content
  end
end

function UINChatSystemChatBoardNode:__OnInputValueChange(value)
  self:__CheckAndClampInput()
  self:RefreshSendBtn(not string.IsNullOrEmpty(value))
end

function UINChatSystemChatBoardNode:RefreshSendBtn(isEnable)
  self.ui.btn_Send.interactable = isEnable
  self.ui.img_Send.color = isEnable and self.btnColors.withText or self.btnColors.noText
end

function UINChatSystemChatBoardNode:OnClickSend()
  if string.IsNullOrEmpty(self.ui.ipt_Input.text) then
    return
  end
  self:__CheckAndClampInput()
  local chatSystemCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  chatSystemCtrl:ReqSendChatMsg(self.chatBoard:GetChatBoardType(), self.chatBoard:GetChatBoardId(), ChatSystemEnum.EChatContentType.Text, self.ui.ipt_Input.text, self.__ClearInputField)
end

function UINChatSystemChatBoardNode:ClearInputField()
  self.ui.ipt_Input.text = emptyString
  self.ui.ipt_Text.text = emptyString
end

function UINChatSystemChatBoardNode:OnClickEmojiBtn()
  local emojiActive = self.emojiNode.active
  self:ChangeEmojiNodeState(not emojiActive)
end

function UINChatSystemChatBoardNode:RollToNewChat()
  self:OnNewChatMsgComes(0, true)
end

function UINChatSystemChatBoardNode:ChangeEmojiNodeState(isOpen)
  if isOpen == self.emojiNode.active then
    return
  end
  if isOpen then
    self.emojiNode:InitChatEmojiNode(self.chatBoard, self.resloader)
  else
    self.emojiNode:HideChatEmojiNode()
  end
end

function UINChatSystemChatBoardNode:OnEmojiPageStateChange(isOpen)
  self.ui.img_Icon:SetIndex(isOpen and 1 or 0)
  self.ui.btn_BackTouch.gameObject:SetActive(isOpen)
end

function UINChatSystemChatBoardNode:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UINChatSystemChatBoardNode:_BackAction()
  self.emojiNode:HideChatEmojiNode()
  self:Hide()
end

function UINChatSystemChatBoardNode:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UINChatSystemChatBoardNode
