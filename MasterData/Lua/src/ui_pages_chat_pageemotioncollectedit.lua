local this = class("pageEmotionCollectEdit", G_UIPageBase)
local _gameConstTpl = L_GameTpl:getGameConstTpl()
local _emojiTpl = L_GameTpl:getChatEmojiTpl()
local emojiGroupTpl = L_GameTpl:getChatEmojiGroupTpl()
local CHAT_EMOJI_COLLECT_NUM_MAX = _gameConstTpl:getData("CHAT_EMOJI_COLLECT_NUM_MAX", L_Const.GameTplType.int)
local allImgNormal = "UI/Atlas/EmojiGroup/tex_chat_icon_social_all_02.png"
local allImgSelect = "UI/Atlas/EmojiGroup/tex_chat_icon_social_all_01.png"
local recentlyImgNormal = "UI/Atlas/EmojiGroup/tex_chat_icon_social_time_03.png"
local recentlyImgSelect = "UI/Atlas/EmojiGroup/tex_chat_icon_social_time_04.png"
local emotionTypeGroup = {inAllEmotion = 101, inRecentlyEmotion = 102}

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this.bind()
  return {
    scrollList_emotion = {
      moduleName = "pages/chat/cellEmotion"
    },
    txt_myCollect = "",
    txt_maxNum = tostring(CHAT_EMOJI_COLLECT_NUM_MAX),
    moduleCommonTipLarge = L_Const.ModuleInfo.ModuleCommonTip,
    curChatEmotionTabId = -1,
    scrollList_emotionGroup = {
      moduleName = "pages/chat/cellChatEmotionTab"
    },
    go_empty = false,
    go_gridEmotion = true
  }
end

function this.methods()
  return {
    moduleCommonTipLarge = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_bg = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        local emojiIdList = {}
        for _, showIndex in pairs(self.data.selectOrder2ShowIndexDic) do
          if showIndex ~= -1 then
            local emojiId = self.data.emojiIdList[showIndex]
            table.insert(emojiIdList, emojiId)
          end
        end
        L_ChatStore:req_collectChatEmojiChange(emojiIdList)
        L_UI:close(self.pageName)
      end
    },
    onClick_reset = function(self)
      for i = 1, CHAT_EMOJI_COLLECT_NUM_MAX do
        self.data.selectOrder2ShowIndexDic[i] = -1
      end
      self:selectEmotionTabId(self.data.tabId)
    end,
    scrollList_emotion = {
      onClick_select = function(self, bind)
        if bind.id == 0 then
          return
        end
        local showIndex = bind.showIndex
        local ifActive = not bind.go_selectFrame
        local insertLocation = self:getInsertLocationOfSelectDic()
        local selectOrder = insertLocation
        if ifActive then
          if selectOrder == false then
            L_FlyMsgManager:showNormalMsgByKey("ui_chat_emoji_full")
            return
          else
            self.data.selectOrder2ShowIndexDic[selectOrder] = showIndex
          end
        else
          for selectOrder, emojiShowIndex in pairs(self.data.selectOrder2ShowIndexDic) do
            if emojiShowIndex == showIndex then
              self.data.selectOrder2ShowIndexDic[selectOrder] = -1
            end
          end
        end
        bind.go_selectFrame = ifActive
        bind.go_selectBg = ifActive
        bind.go_numBg = ifActive
        bind.txt_selectId = tostring(selectOrder)
        self.bind.txt_myCollect = tostring(self:getSelectEmotionNum())
      end
    },
    onSelect_chatEmotionTab = function(self, tabId)
      if self.data.tabId == tabId then
        return
      end
      self:selectEmotionTabId(tabId)
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:initData()
end

function this:initData()
  self.data = {
    tabId = -1,
    emojiIdList = {},
    selectOrder2ShowIndexDic = {},
    emojiTypeGroupLst = {
      emotionTypeGroup.inAllEmotion,
      emotionTypeGroup.inRecentlyEmotion
    }
  }
  for i = 1, CHAT_EMOJI_COLLECT_NUM_MAX do
    self.data.selectOrder2ShowIndexDic[i] = -1
  end
  for index, emojiId in ipairs(L_ChatStore:getEmojiCollectedList()) do
    table.insert(self.data.emojiIdList, emojiId)
    self.data.selectOrder2ShowIndexDic[index] = index
  end
  for _, EmojiIdOwnedList in pairs(L_ChatStore:getEmojiOwnedDic()) do
    for _, emojiId in ipairs(EmojiIdOwnedList) do
      if table.indexOf(self.data.emojiIdList, emojiId) == false then
        table.insert(self.data.emojiIdList, emojiId)
      end
    end
  end
  self:initTypeEmotionGroup()
  self.modules.moduleCommonTipLarge:initModule({
    txtTitle = L_WordsTpl:getValue("ui_chat_emoji_box_top")
  })
end

function this:getInsertLocationOfSelectDic()
  for location, selectEmojiIndex in pairs(self.data.selectOrder2ShowIndexDic) do
    if selectEmojiIndex == -1 then
      return location
    end
  end
  return false
end

function this:getSelectOrderOfTargetShowIndex(targetShowIndex)
  for selectOrder, showIndex in pairs(self.data.selectOrder2ShowIndexDic) do
    if showIndex == targetShowIndex then
      return selectOrder
    end
  end
  return false
end

function this:getSelectEmotionNum()
  local selectEmotionNum = 0
  for _, showIndex in pairs(self.data.selectOrder2ShowIndexDic) do
    if showIndex ~= -1 then
      selectEmotionNum = selectEmotionNum + 1
    end
  end
  return selectEmotionNum
end

function this:initTypeEmotionGroup()
  local tmp = {}
  for groupId, _ in pairs(L_ChatStore.data.emojiOwnedDic) do
    table.insert(tmp, {groupId = groupId})
  end
  table.sort(tmp, function(a, b)
    return a.groupId < b.groupId
  end)
  for _, value in pairs(tmp) do
    if table.indexOf(self.data.emojiTypeGroupLst, value.groupId) == false then
      table.insert(self.data.emojiTypeGroupLst, value.groupId)
    end
  end
  local emotionGroupTmp = {}
  for _, groupId in pairs(self.data.emojiTypeGroupLst) do
    local normal, select
    if groupId == emotionTypeGroup.inAllEmotion then
      normal = allImgNormal
      select = allImgSelect
    elseif groupId == emotionTypeGroup.inRecentlyEmotion then
      normal = recentlyImgNormal
      select = recentlyImgSelect
    else
      local tpl = emojiGroupTpl:getTplById(groupId)
      if tpl ~= nil then
        normal = emojiGroupTpl:getIcon(tpl)
        select = emojiGroupTpl:getIcon(tpl)
      end
    end
    if normal ~= nil and select ~= nil then
      table.insert(emotionGroupTmp, {
        img_normalIcon = normal,
        img_selectIcon = select,
        item_id = groupId
      })
    end
  end
  self.bind.scrollList_emotionGroup:clear()
  self.bind.scrollList_emotionGroup:insert_array(emotionGroupTmp)
  self.bind.curChatEmotionTabId = emotionTypeGroup.inAllEmotion
end

function this:selectEmotionTabId(tabId)
  self.data.tabId = tabId
  local options = {}
  if tabId == emotionTypeGroup.inAllEmotion then
    options.inAllEmotion = true
  elseif tabId == emotionTypeGroup.inRecentlyEmotion then
    options.inRecentlyEmotion = true
  else
    options.tabId = tabId
  end
  self:initEmotion(options)
end

function this:initEmotion(options)
  local tmp = {}
  local tmpRecentlyList = {}
  for index, emojiId in ipairs(L_ChatStore:getEmojiRecentlyList()) do
    table.insert(tmpRecentlyList, emojiId)
  end
  local emotionCollectNum = self:getInsertLocationOfSelectDic() == false and CHAT_EMOJI_COLLECT_NUM_MAX or self:getInsertLocationOfSelectDic()
  for showIndex, emojiId in pairs(self.data.emojiIdList) do
    local tpl = _emojiTpl:getTplById(emojiId)
    local selectOrder = self:getSelectOrderOfTargetShowIndex(showIndex)
    local isAdd = false
    local recentlyIndex = -1
    if options.inAllEmotion then
      isAdd = true
    elseif options.inRecentlyEmotion then
      isAdd = table.indexOf(tmpRecentlyList, emojiId)
      if isAdd ~= false then
        recentlyIndex = isAdd
      end
    elseif options.tabId then
      isAdd = _emojiTpl:getGroupId(tpl) ~= nil and _emojiTpl:getGroupId(tpl) == options.tabId
    end
    if isAdd then
      table.insert(tmp, {
        isInPageEdit = true,
        id = emojiId,
        go_selectFrame = selectOrder ~= false,
        go_selectBg = selectOrder ~= false,
        go_numBg = selectOrder ~= false,
        txt_selectId = tostring(selectOrder),
        showIndex = showIndex,
        selectOrder = selectOrder ~= false and selectOrder or emojiId + emotionCollectNum,
        recentlyIndex = recentlyIndex
      })
    end
  end
  if not options.inRecentlyEmotion then
    table.sort(tmp, function(a, b)
      return a.selectOrder < b.selectOrder
    end)
  else
    table.sort(tmp, function(a, b)
      return a.recentlyIndex < b.recentlyIndex
    end)
  end
  self:insertEmptyCell(tmp)
  if table.count(tmp) <= 0 then
    self.bind.go_empty = true
    self.bind.go_gridEmotion = false
  else
    self.bind.go_empty = false
    self.bind.go_gridEmotion = true
  end
  self.bind.scrollList_emotion:clear()
  self.bind.scrollList_emotion:insert_array(tmp)
  self.bind.txt_myCollect = tostring(self:getSelectEmotionNum())
end

function this:insertEmptyCell(tmp, groupId)
  local colCount = 7
  if 0 < #tmp and #tmp < colCount * 2 then
    for i = #tmp + 1, colCount * 2 do
      table.insert(tmp, {
        isInPageEdit = true,
        id = 0,
        go_selectFrame = false,
        go_selectBg = false,
        go_numBg = false,
        txt_selectId = ""
      })
    end
  end
end

return this
