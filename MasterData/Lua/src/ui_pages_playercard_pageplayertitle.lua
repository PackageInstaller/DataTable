local this = class("pagePlayerTitle", G_UIPageBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {
    selectType = 1,
    selectId = 0,
    preTitle = {},
    sufTitle = {},
    preTitleId = 0,
    sufTitleId = 0
  }
  self.titleIdList = {}
end

function this.bind()
  return {
    pre_snapToItemIndex = 0,
    pre_moveToItemIndex = 0,
    loopListPreTitle = {
      moduleName = "pages/PlayerCard/cellPlayerTitle"
    },
    suf_snapToItemIndex = 0,
    suf_moveToItemIndex = 0,
    loopListSufTitle = {
      moduleName = "pages/PlayerCard/cellPlayerTitle"
    },
    allCount = "",
    nowTitle = ""
  }
end

function this.methods()
  return {
    loopListPreTitle = {
      onLoopListClickSelect = function(self, realId)
        self.realPreIndex = realId - 1
        self.bind.pre_snapToItemIndex = self.realPreIndex
      end,
      onClickSelect = function(self, titleId)
        self.data.preTitleId = titleId
      end
    },
    onPreSnapItemFinish = function(self, index)
      if self.isTitleListInit then
        self.realPreIndex = index + 1
        self:refreshPreListInfo(self.realPreIndex)
      end
    end,
    loopListSufTitle = {
      onLoopListClickSelect = function(self, realId)
        self.realSufIndex = realId - 1
        self.bind.suf_snapToItemIndex = self.realSufIndex
      end,
      onClickSelect = function(self, titleId)
        self.data.sufTitleId = titleId
      end
    },
    onSufSnapItemFinish = function(self, index)
      if self.isTitleListInit then
        self.realSufIndex = index + 1
        self:refreshSufListInfo(self.realSufIndex)
      end
    end,
    onClick_changeBtn = function(self)
      local isHasPreTitle = false
      local isHasSufTitle = false
      isHasPreTitle = self.data.preTitle[self.data.preTitleId] ~= nil
      isHasSufTitle = self.data.sufTitle[self.data.sufTitleId] ~= nil
      if not isHasPreTitle or not isHasSufTitle then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("msg_palyertitle_nothastitle"))
        return
      end
      L_PlayerStore:req_changePlayerTitle({
        type = 1,
        id = self.data.preTitleId
      }, function()
        self:setNowTitle()
        self:refreshCurChoice(1, self.data.preTitleId)
      end)
      L_PlayerStore:req_changePlayerTitle({
        type = 2,
        id = self.data.sufTitleId
      }, function()
        self:setNowTitle()
        self:refreshCurChoice(2, self.data.sufTitleId)
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("msg_palyertitle_changesuccess"))
      end)
    end,
    onClick_closeBtn = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  self.data.preTitleId = L_PlayerStore:getPreTitle()
  self.data.sufTitleId = L_PlayerStore:getLaterTitle()
  self._readList = {}
  self.realPreIndex = 0
  self.realSufIndex = 0
  L_PlayerStore:req_getPlayerTitle(function(rspData)
    self:setNowTitle()
    self:setPlayerTitle(rspData)
    self:setTitleList()
  end)
  L_ReddotManager:registerReddot(self.bindComponents.reddotPre, L_ReddotManager.DotDef.TitlePre)
  L_ReddotManager:registerReddot(self.bindComponents.reddotSuf, L_ReddotManager.DotDef.TitleSuf)
end

function this:setNowTitle()
  local preTitle = L_PlayerStore:getPreTitle()
  local sufTitle = L_PlayerStore:getLaterTitle()
  local titleA, titleB = self:getAllTitle(preTitle, sufTitle)
  self.bind.nowTitle = table.concat({titleA, titleB})
end

function this:setPlayerTitle(rspData)
  if rspData == nil then
    return
  end
  if rspData.preffix_title then
    for _, v in ipairs(rspData.preffix_title) do
      self.data.preTitle[v] = v
    end
  end
  if rspData.suffix_title then
    for _, v in ipairs(rspData.suffix_title) do
      self.data.sufTitle[v] = v
    end
  end
end

function this:setTitleList()
  local playerTitleTpl = L_GameTpl:getPlayerTitleTpl()
  self.preTitleIdList = {}
  self.preTitleIdList = playerTitleTpl:getAllId(self.preTitleIdList, 1)
  self.sufTitleIdList = {}
  self.sufTitleIdList = playerTitleTpl:getAllId(self.sufTitleIdList, 2)
  table.sort(self.preTitleIdList, function(a, b)
    local unLockA = 0
    local unLockB = 0
    if self.data.preTitle[a] ~= nil then
      unLockA = 1
    end
    if self.data.preTitle[b] ~= nil then
      unLockB = 1
    end
    if unLockA ~= unLockB then
      return unLockA > unLockB
    end
    return a < b
  end)
  table.sort(self.sufTitleIdList, function(a, b)
    local unLockA = 0
    local unLockB = 0
    if self.data.sufTitle[a] ~= nil then
      unLockA = 1
    end
    if self.data.sufTitle[b] ~= nil then
      unLockB = 1
    end
    if unLockA ~= unLockB then
      return unLockA > unLockB
    end
    return a < b
  end)
  local preTitleData = {}
  local sufTitleData = {}
  for i, v in pairs(self.preTitleIdList) do
    local data = L_ItemManager:parsePlayerTitleData(v)
    local dataCell = {}
    dataCell.titleId = v
    dataCell.id = v
    dataCell.realId = i
    local tpl = playerTitleTpl:getTplById(v)
    dataCell.txt_title = playerTitleTpl:getName(tpl)
    dataCell.txt_desc = data.desc
    dataCell.choice = self.data.preTitleId == v
    dataCell.isLock = self.data.preTitle[v] == nil
    table.insert(preTitleData, dataCell)
  end
  self.bind.loopListPreTitle:clear()
  self.bind.loopListPreTitle:insert_array(preTitleData)
  for _, v in pairs(self.modules.loopListPreTitle) do
    if self.data.preTitleId == v.bind.id then
      self.realPreIndex = v.bind.realId
      self.bind.pre_moveToItemIndex = v.bind.realId - 1
    end
  end
  self:refreshPreListInfo(self.realPreIndex)
  for i, v in pairs(self.sufTitleIdList) do
    local data = L_ItemManager:parsePlayerTitleData(v)
    local dataCell = {}
    dataCell.titleId = v
    dataCell.id = v
    dataCell.realId = i
    local tpl = playerTitleTpl:getTplById(v)
    dataCell.txt_title = playerTitleTpl:getName(tpl)
    dataCell.txt_desc = data.desc
    dataCell.choice = self.data.sufTitleId == v
    dataCell.isLock = self.data.sufTitle[v] == nil
    table.insert(sufTitleData, dataCell)
  end
  self.bind.loopListSufTitle:clear()
  self.bind.loopListSufTitle:insert_array(sufTitleData)
  for _, v in pairs(self.modules.loopListSufTitle) do
    if self.data.sufTitleId == v.bind.id then
      self.realSufIndex = v.bind.realId
      self.bind.suf_moveToItemIndex = v.bind.realId - 1
    end
  end
  self:refreshSufListInfo(self.realSufIndex)
  self.isTitleListInit = true
end

function this:refreshPreListInfo(realIndex)
  for _, v in ipairs(self.modules.loopListPreTitle) do
    v:refreshInfo(realIndex)
    if v.bind.realId == realIndex then
      self.data.preTitleId = v.bind.titleId
      v:clearReddot()
    end
  end
end

function this:refreshSufListInfo(realIndex)
  for _, v in ipairs(self.modules.loopListSufTitle) do
    v:refreshInfo(realIndex)
    if v.bind.realId == realIndex then
      self.data.sufTitleId = v.bind.titleId
      v:clearReddot()
    end
  end
end

function this:refreshCurChoice(selectType, id)
  if selectType == 1 then
    for i, v in pairs(self.modules.loopListPreTitle) do
      v:refreshCurChoice(id)
    end
  else
    for i, v in pairs(self.modules.loopListSufTitle) do
      v:refreshCurChoice(id)
    end
  end
end

function this:rightInfoData()
  local titleA, titleB = self:getAllTitle(self.data.preTitleId, self.data.sufTitleId)
  local preText = self.data.preTitle[self.data.preTitleId] ~= nil and titleA or L_GameUtil.fillColor(titleA, "#8B8C8F")
  local suText = self.data.sufTitle[self.data.sufTitleId] ~= nil and titleB or L_GameUtil.fillColor(titleB, "#8B8C8F")
  self.bind.preSelect = self.data.selectType == 1
  self.bind.sufSelect = self.data.selectType == 2
  self.bind.selText = table.concat({
    preText,
    "   ",
    suText
  })
  local preTitle = L_PlayerStore:getPreTitle()
  local sufTitle = L_PlayerStore:getLaterTitle()
  if self.data.selectType == 1 then
    if self.data.preTitleId == preTitle then
      self:showUnlockButton(false, L_WordsTpl:getValue("ui_palyertitle_nowselecttitle"))
      return
    end
    if self.data.preTitle[self.data.preTitleId] == nil then
      self:showUnlockButton(false, L_WordsTpl:getValue("ui_palyertitle_notunlocktitle"))
      return
    end
    self:showUnlockButton(true, L_WordsTpl:getValue("ui_palyertitle_changpretitle"))
  elseif self.data.selectType == 2 then
    if self.data.sufTitleId == sufTitle then
      self:showUnlockButton(false, L_WordsTpl:getValue("ui_palyertitle_nowselecttitle"))
      return
    end
    if self.data.sufTitle[self.data.sufTitleId] == nil then
      self:showUnlockButton(false, L_WordsTpl:getValue("ui_palyertitle_notunlocktitle"))
      return
    end
    self:showUnlockButton(true, L_WordsTpl:getValue("ui_palyertitle_changsuftitle"))
  end
end

function this:getAllTitle(preId, sufId)
  local aTitle, bTitle
  local playerTitleTpl = L_GameTpl:getPlayerTitleTpl()
  local tplA = playerTitleTpl:getTplById(preId)
  local tplB = playerTitleTpl:getTplById(sufId)
  local specialA = playerTitleTpl:getSpecial(tplA)
  local specialB = playerTitleTpl:getSpecial(tplB)
  if specialA == 1 and specialB == 1 then
    aTitle = ""
    bTitle = L_WordsTpl:getValue("ui_palyertitle_titlenotselect")
  elseif specialA == 1 and specialB ~= 1 then
    aTitle = ""
    bTitle = playerTitleTpl:getName(tplB)
  elseif specialA ~= 1 and specialB == 1 then
    aTitle = playerTitleTpl:getName(tplA)
    bTitle = ""
  else
    aTitle = playerTitleTpl:getName(tplA)
    bTitle = playerTitleTpl:getName(tplB)
  end
  return aTitle, bTitle
end

function this:setRead(id)
  self._readList = self._readList or {}
  self._readList[id] = true
end

function this:close(options)
  for id, _ in pairs(self._readList) do
    L_ReddotManager:clearNew(L_ReddotManager.DotDef.Title, id)
  end
  table.clear(self._readList)
end

return this
