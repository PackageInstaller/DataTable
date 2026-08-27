local UINFriendshipChatPageFriendList = class("UINFriendshipChatPageFriendList", UIBaseNode)
local base = UIBaseNode
local UINFriendshipChatPageFriendItem = require("Game.Friendship.pages.ChatPage.UINFriendshipChatPageFriendItem")
local UINFriendshipSortKindItem = require("Game.Friendship.pages.ChatPage.UINFriendshipSortKindItem")
local SortFuncs = {
  defult = function(heroA, heroB)
    return heroA.heroCfg.id < heroB.heroCfg.id
  end
}
local getShiftFuncs = {
  camp = function(campId)
    return function(heroData)
      return heroData.heroCfg.camp == campId
    end
  end
}

function UINFriendshipChatPageFriendList:OnInit()
  self.itemDic = {}
  self.curList = {}
  self.selectedHeroData = nil
  self.clickEvent = nil
  self.isSortPanelOpen = false
  self.shiftFuncList = {}
  self.resloader = nil
  self.selectHeroCallback = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.scrollView_FriendList.onInstantiateItem = BindCallback(self, self.__InitItem)
  self.ui.scrollView_FriendList.onChangeItem = BindCallback(self, self.__OnItemChange)
  UIUtil.AddButtonListener(self.ui.btn_Sort, self, self.OnClikSortBtn)
  self.appTogglePool = UIItemPool.New(UINFriendshipSortKindItem, self.ui.obj_sortKindItem)
  self.ui.obj_sortKindItem:SetActive(false)
  self.__RefreshTotalLevel = BindCallback(self, self.RefreshTotalLevel)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshTotalLevel)
end

function UINFriendshipChatPageFriendList:InitFriendList(resloader, selectHeroCallback)
  self.resloader = resloader
  self.selectHeroCallback = selectHeroCallback
  self:__InitOriginHeroList()
  self:RefrshChatList(nil, SortFuncs.defult, nil)
end

function UINFriendshipChatPageFriendList:__InitOriginHeroList(slotId)
  self.origintChatListItemList = PlayerDataCenter.heroDic
end

function UINFriendshipChatPageFriendList:OnClikSortBtn()
  self.isSortPanelOpen = not self.isSortPanelOpen
  self.ui.obj_sortConditionNode:SetActive(self.isSortPanelOpen)
  self.ui.tex_Type:SetIndex(0)
  self.appTogglePool:HideAll()
  for _, campCfg in pairs(ConfigData.camp) do
    local item = self.appTogglePool:GetOne(true)
    item:InitSortItem(LanguageUtil.GetLocaleText(campCfg.name), function(bool_useThisShift)
      if bool_useThisShift then
        self.shiftFuncList[campCfg.name] = getShiftFuncs.camp(campCfg.id)
      else
        self.shiftFuncList[campCfg.name] = nil
      end
      
      local function theShiftFunc(heroData)
        if table.count(self.shiftFuncList) == 0 then
          return true
        end
        for _, func in pairs(self.shiftFuncList) do
          if func(heroData) then
            return true
          end
        end
        return false
      end
      
      self:RefrshChatList(theShiftFunc, SortFuncs.defult, nil)
    end)
  end
end

function UINFriendshipChatPageFriendList:RefrshChatList(funcSift, funcSort, customList)
  local heroList = customList or self.origintChatListItemList
  local curSelectChatListItem
  self.curList = {}
  for k, heroData in pairs(heroList) do
    if funcSift == nil then
      table.insert(self.curList, heroData)
    elseif funcSift(heroData) then
      table.insert(self.curList, heroData)
    end
    if heroData == self.selectedHeroData then
      curSelectChatListItem = heroData
    end
  end
  if funcSort ~= nil then
    table.sort(self.curList, funcSort)
  end
  self.ui.scrollView_FriendList.totalCount = #self.curList
  self.ui.scrollView_FriendList:RefillCells()
  self:__SetSelect(curSelectChatListItem)
  if curSelectChatListItem == nil then
    self:OnItemClicked(self.curList[1])
  end
end

function UINFriendshipChatPageFriendList:__InitItem(go)
  local chatListItem = UINFriendshipChatPageFriendItem.New()
  chatListItem:Init(go)
  self.itemDic[go] = chatListItem
end

function UINFriendshipChatPageFriendList:__OnItemChange(go, index)
  local Item = self.itemDic[go]
  if Item == nil then
    error("Can't find Item by gameObject")
    return
  end
  local heroData = self.curList[index + 1]
  if heroData == nil then
    error("Can't find heroData by index, index = " .. tonumber(index))
  end
  Item:InitHeroInfo(heroData, BindCallback(self, self.OnItemClicked), self.resloader)
  local isSelect = self.selectedHeroData == heroData
  Item:SelectThis(isSelect)
end

function UINFriendshipChatPageFriendList:OnItemClicked(heroData)
  if self.selectHeroCallback ~= nil then
    self.selectHeroCallback(heroData)
  end
  self:__SetSelect(heroData)
end

function UINFriendshipChatPageFriendList:__SetSelect(heroData)
  if self.selectedHeroData ~= nil then
    local lastItem = self:__GetItemByData(self.selectedHeroData)
    if lastItem ~= nil then
      lastItem:SelectThis(false)
    end
    self.selectedHeroData = nil
  end
  if heroData ~= nil then
    local Item = self:__GetItemByData(heroData)
    if Item ~= nil then
      Item:SelectThis(true)
    end
    self.selectedHeroData = heroData
  end
end

function UINFriendshipChatPageFriendList:__GetItemByData(heroData)
  for k, v in ipairs(self.curList) do
    if v == heroData then
      local index = k - 1
      return self:__GetItemGoByIndex(index)
    end
  end
end

function UINFriendshipChatPageFriendList:__GetItemGoByIndex(index)
  local go = self.ui.scrollView_FriendList:GetCellByIndex(index)
  if go ~= nil then
    local heroChatListItem = self.itemDic[go]
    return heroChatListItem
  end
  return nil
end

function UINFriendshipChatPageFriendList:RefreshTotalLevel()
  local totalLevel = PlayerDataCenter.allFriendshipData:GetTotalLevel() or 0
  self.ui.tex_TotalfavorLevel:SetIndex(0, tostring(totalLevel))
end

function UINFriendshipChatPageFriendList:OnDelete()
  self.appTogglePool:DeleteAll()
  for key, value in pairs(self.itemDic) do
    value:Delete()
  end
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, self.__RefreshTotalLevel)
  base.OnDelete(self)
end

return UINFriendshipChatPageFriendList
