local this = class("pageHeadPic", G_UIPageBase)
local _playerDressTpl = L_GameTpl:getPlayercardDressTpl()

function this.bind()
  return {
    module_commonTipLarge = L_Const.ModuleInfo.ModuleCommonTip,
    txt_itemName = "",
    txt_desc = "",
    tabList = {
      moduleName = "pages/headPic/cellHeadPicTab"
    },
    itemList = {
      moduleName = "pages/headPic/cellHeadPicItem"
    },
    curTabId = 0,
    cellHeadPic = {
      moduleName = "pages/headPic/cellHeadPic"
    }
  }
end

function this.methods()
  return {
    module_commonTipLarge = {
      onClick_close = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_cancel = function(self)
        L_UI:close(self.pageName)
      end,
      onClick_confirm = function(self)
        self:onClickWear()
      end
    },
    itemList = {
      onClick = function(self, bind)
        self:onClickItem(bind)
      end
    },
    onClickTab = function(self, id)
      self.bind.curTabId = id
      self:onClickTab(id)
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  local moduleTip = self.modules.module_commonTipLarge
  moduleTip:initModule({
    txtTitle = L_WordsTpl:getValue("ui_playercard_lipai_change")
  })
  self.remScrollIndex = {}
  self.lastSelectIds = {}
  self.defaultFrame, self.defaultFrameId = L_PlayerDisplayStore:getDefaultFrame()
  self.defaultHeadId = L_PlayerDisplayStore:getDefaultHead()
  self.pendingHeadId = L_PlayerDisplayStore:getCurHead() or self.defaultHeadId or 0
  self.pendingFrameId = L_PlayerDisplayStore:getCurHeadFrame() or self.defaultFrameId or 0
  self:initTab()
end

function this:initTab()
  local ts = {
    L_Const.playerDressType.head,
    L_Const.playerDressType.headFrame
  }
  local list = {}
  for i, v in pairs(ts) do
    local data = {}
    data.tabId = v
    table.insert(list, data)
  end
  self.bind.tabList:clear()
  self.bind.tabList:insert_array(list)
  self.bind.curTabId = L_Const.playerDressType.head
  self.lastTabId = L_Const.playerDressType.head
end

function this:onClickTab(type)
  if self._isSwitching then
    return
  end
  if self.lastTabId and self.lastTabId ~= 0 then
    self:recordTabScroll(self.lastTabId)
    self.lastSelectIds[self.lastTabId] = self.selectID
  end
  self.lastTabId = type
  self:initItems(type)
  self.bindComponents.ani_list:Play("anim_headpic_mainlist_in")
  if not self.initShow then
    self.initShow = true
    return
  end
  self.bindComponents.ani_info:Rewind()
  self.bindComponents.ani_info:Play("anim_headpic_info_avatar_change")
end

function this:recordTabScroll(tabId)
  if not tabId or tabId == 0 then
    return
  end
  local gridView = self.bindComponents.itemList
  if not gridView or 0 >= gridView.totalCount then
    return
  end
  gridView:StopMovement()
  self.remScrollIndex[tabId] = gridView:GetSnapIndex()
end

function this:restoreTabScroll(tabId)
  local gridView = self.bindComponents.itemList
  if not gridView then
    return
  end
  local index = -1
  if self._pendingFocusId then
    index = self:getItemIndexById(self._pendingFocusId)
  end
  if index < 0 then
    index = self.remScrollIndex[tabId] or 0
  end
  gridView:FocusItemIndex(index, true, true)
end

function this:getItemIndexById(id)
  for i = 1, #self.bind.itemList do
    if self.bind.itemList:getValue(i, "id") == id then
      return i - 1
    end
  end
  return -1
end

function this:initItems(type)
  local list = {}
  for i, v in pairs(_playerDressTpl.data) do
    if v.type == type and (L_PlayerDisplayStore:hasItem(v) or _playerDressTpl:getShow(v) == 1) then
      local data = {}
      data.tpl = v
      data.id = _playerDressTpl:getId(v)
      data.itemType = v.type
      table.insert(list, data)
    end
  end
  table.sort(list, function(a, b)
    local weara = L_PlayerDisplayStore:isCurDress(a.id)
    local wearb = L_PlayerDisplayStore:isCurDress(b.id)
    if weara ~= wearb then
      return weara
    end
    local geta = L_PlayerDisplayStore:getItem(a.id) ~= nil
    local getb = L_PlayerDisplayStore:getItem(b.id) ~= nil
    if geta ~= getb then
      return geta
    end
    return a.id < b.id
  end)
  self.bind.itemList:clear()
  self.bind.itemList:insert_array(list)
  self:restoreTabScroll(type)
  local cur = self:getSelectedIdByTab(type)
  self:onClickItem(cur)
end

function this:getSelectedIdByTab(type)
  if type == L_Const.playerDressType.head then
    return self.pendingHeadId or self.defaultHeadId or 0
  elseif type == L_Const.playerDressType.headFrame then
    return self.pendingFrameId or self.defaultFrameId or 0
  end
  return 0
end

function this:refreshPreview()
  local cellHeadPic = self.modules.cellHeadPic
  local headId = self.pendingHeadId or self.defaultHeadId or 0
  local frameId = self.pendingFrameId or self.defaultFrameId or 0
  cellHeadPic:setPreviewByDressIds(headId, frameId, L_PlayerStore:getPlayerBaseInfo(), false)
end

function this:refreshDesc(id)
  self.curSelectItemId = id
  local tpl = _playerDressTpl:getTplById(id)
  if not tpl then
    error("不存在PlayercardDress" .. id)
    return
  end
  self.bind.txt_itemName = _playerDressTpl:getName(tpl)
  self.bind.txt_desc = _playerDressTpl:getDesc(tpl)
  self:refreshPreview()
  self.bindComponents.ani_info:Rewind()
  if self.bind.curTabId == L_Const.playerDressType.head then
    self.bindComponents.ani_info:Play("anim_headpic_info_avatar_in")
  elseif self.bind.curTabId == L_Const.playerDressType.headFrame then
    self.bindComponents.ani_info:Play("anim_headpic_info_avatar_frame_in")
  end
end

function this:onClickItem(id)
  local selId = id
  local tpl = _playerDressTpl:getTplById(id)
  if tpl then
    local type = _playerDressTpl:getType(tpl)
    if type == L_Const.playerDressType.head then
      self.pendingHeadId = id
    elseif type == L_Const.playerDressType.headFrame then
      self.pendingFrameId = id
    end
  end
  self.selectID = id
  self:refreshDesc(selId)
  for i, v in pairs(self.modules.itemList) do
    v:refreshSelect(selId)
  end
end

function this:switchToTab(type)
  self._isSwitching = true
  if self.bind.curTabId ~= type then
    if self.lastTabId and self.lastTabId ~= 0 then
      self:recordTabScroll(self.lastTabId)
      self.lastSelectIds[self.lastTabId] = self.selectID
    end
    self.lastTabId = type
    self.bind.curTabId = type
    self._pendingFocusId = self:getSelectedIdByTab(type)
    self:initItems(type)
    self._pendingFocusId = nil
    self.bindComponents.ani_list:Play("anim_headpic_mainlist_in")
    self.bindComponents.ani_info:Rewind()
    self.bindComponents.ani_info:Play("anim_headpic_info_avatar_change")
  else
    local targetIndex = self:getItemIndexById(self:getSelectedIdByTab(type))
    if 0 <= targetIndex then
      self.bindComponents.itemList:ScrollToShowCell(targetIndex, 3000, 1)
    end
  end
  self._isSwitching = false
end

function this:onClickWear()
  local headId = self.pendingHeadId or self.defaultHeadId or 0
  local frameId = self.pendingFrameId or self.defaultFrameId or 0
  if not L_PlayerDisplayStore:hasItem(headId) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_playercard_save_profile_photo_failed"))
    self:switchToTab(L_Const.playerDressType.head)
    return
  end
  if not L_PlayerDisplayStore:hasItem(frameId) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_playercard_save_profile_photo_failed"))
    self:switchToTab(L_Const.playerDressType.headFrame)
    return
  end
  
  local function onApplySuccess()
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_playercard_save_profile_photo_success"))
    L_UI:close(self.pageName)
  end
  
  local function saveFrame()
    local curFrameId = L_PlayerDisplayStore:getCurHeadFrame() or self.defaultFrameId or 0
    if curFrameId == frameId then
      onApplySuccess()
      return
    end
    L_PlayerDisplayStore:req_setProfileFrame(frameId, function()
      onApplySuccess()
    end)
  end
  
  local curHeadId = L_PlayerDisplayStore:getCurHead() or self.defaultHeadId or 0
  if curHeadId == headId then
    saveFrame()
    return
  end
  L_PlayerDisplayStore:req_setProfile(headId, function()
    saveFrame()
  end)
end

return this
