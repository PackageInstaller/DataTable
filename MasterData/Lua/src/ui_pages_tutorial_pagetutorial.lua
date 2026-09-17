local this = class("pageTutorial", G_UIPageBase)
local CriWareStatus = CS.CriWare.CriMana.Player.Status
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local _tutorialTypeTpl = L_GameTpl:getTutorialTypeTpl()
local _tutorialTpl = L_GameTpl:getTutorialTpl()
local _guideGroupTpl = L_GameTpl:getGuideGroupTpl()
local _guidePicTpl = L_GameTpl:getGuidePicTpl()

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {}
end

function this.bind()
  return {
    tutorial_list = {
      moduleName = "pages/tutorial/cellTutorialItem"
    },
    tabList = {
      moduleName = "pages/tutorial/cellTutorialTab"
    },
    tutorialIcon = "",
    tutorialType = "",
    tutorialName = "",
    tutorialDesc = "",
    currentTabId = 0,
    info = false,
    empty = false,
    allPage = false,
    last = true,
    lastDisable = false,
    next = true,
    nextDisable = false,
    curIndex = 0,
    maxIndex = 0,
    show_searchMenu = false,
    show_commonMenu = true,
    show_searchButton = true,
    show_cancelButton = false,
    txt_search = "",
    go_newUp = false,
    go_newDown = false,
    go_videoBlackMask = false,
    go_replayVideo = false,
    go_tutorialImage = false,
    go_tutorialVideo = false,
    color_video1 = C_Color(1, 1, 1, 0),
    color_video2 = C_Color(1, 1, 1, 0)
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      if self._inPreheatVideo then
        return
      end
      L_UI:close(self.pageName)
    end,
    tutorial_list = {
      onClick = function(self, bind)
        self:refreshTutorialInfo(bind.id, bind.data)
      end
    },
    onClick_next = function(self)
      if self._inPreheatVideo then
        return
      end
      local nextIndex = self.iconIndex + 1
      self:tryRefreshInfoPanel(nextIndex, function()
        self.iconIndex = nextIndex
        self:refreshIndexStatus(1)
        self:realRefreshInfoPanel(self.iconIndex)
      end)
    end,
    onClick_last = function(self)
      if self._inPreheatVideo then
        return
      end
      local lastIndex = self.iconIndex - 1
      self:tryRefreshInfoPanel(lastIndex, function()
        self.iconIndex = lastIndex
        self:refreshIndexStatus(-1)
        self:realRefreshInfoPanel(self.iconIndex)
      end)
    end,
    onSelectTab = function(self, tabId)
      self.bind.currentTabId = tabId
      self:initTutorialList(tabId)
    end,
    onClick_input = function(self, value)
      self.searchValue = value
      if string.isEmpty(self.searchValue) then
        self:dealWithButtonActive(true)
        self:initTutorialList(self.bind.currentTabId)
        return
      end
      self:dealWithButtonActive(false)
      self:searchTutorial(self.searchValue)
    end,
    onClick_search = function(self)
      if string.isEmpty(self.searchValue) then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_pageTutorial_02"))
        return
      end
      self:dealWithButtonActive(false)
      self:searchTutorial(self.searchValue)
    end,
    onClick_cancel = function(self)
      self.searchValue = ""
      self.bind.txt_search = ""
      self:dealWithButtonActive(true)
      self:initTutorialList(self.bind.currentTabId)
    end,
    onCellValueChange_tableView = function(self)
      self:updateNotReadNew()
    end,
    onClick_replayVideo = function(self)
      self:tryRefreshInfoPanel(self.iconIndex, function()
        self:realRefreshInfoPanel(self.iconIndex)
      end)
    end
  }
end

function this:check(options, callback)
  if AzurWorld.DungeonMgr:CheckIsDungeonScene() then
    callback(false)
    return
  end
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.tutorial)
  callback(result)
end

function this:preOpen(options)
  self:initData()
  self:initMenu()
  self.bind.currentTabId = self.bind.tabList[1].tabId
  L_ReddotManager:setDirty(L_ReddotManager.DotDef.NewTutorialGuide, true)
  self:initVideo()
  self:initTutorialList(self.bind.currentTabId)
  self.searchValue = ""
end

function this:close(options)
  L_TimerManager:clearTimer(self)
  self.searchValue = nil
  self.waitPlayVideoPath = ""
  self.videoComponent.player.statusChangeCallback = nil
  self.videoComponent:Stop()
  self.videoComponent = nil
  self.videoComponentArray[1].player.statusChangeCallback = nil
  self.videoComponentArray[1]:Stop()
  self.videoComponentArray[2].player.statusChangeCallback = nil
  self.videoComponentArray[2]:Stop()
  self.videoComponentArray = nil
end

function this:initData()
  self.tutorialData = {}
  self.initData = {}
  self.unlockData = {}
  self.redDotData = {}
  local guideGroupIds = L_GuideStore:getUnlockGuideDataMapIds()
  for i, id in ipairs(guideGroupIds) do
    local tpl = _guideGroupTpl:getTplById(id)
    if tpl then
      local tutorialIds = _guideGroupTpl:getTutorialId(tpl)
      if not table.isEmpty(tutorialIds) then
        for i, v in pairs(tutorialIds) do
          local tutorialTpl = _tutorialTpl:getTplById(v)
          if L_ReddotManager:haveNew(L_ReddotManager.DotDef.NewTutorialGuide, v) then
            table.insert(self.redDotData, tutorialTpl)
          else
            table.insert(self.unlockData, tutorialTpl)
          end
        end
      end
    end
  end
  for i, v in ipairs(_tutorialTpl:getInitTutorialData()) do
    table.insert(self.initData, v)
  end
  self:_sortTable(self.redDotData)
  self:_sortTable(self.unlockData)
  self:_sortTable(self.initData)
end

function this:initMenu()
  local allTpl = _tutorialTypeTpl:getAllType()
  local datas = {}
  table.insert(datas, {
    tabId = 0,
    order = 0,
    txtNameOn = L_WordsTpl:getValue("ui_pageTutorial_01"),
    txtNameOff = L_WordsTpl:getValue("ui_pageTutorial_01"),
    txtNameSubOn = "ALLTYPE",
    txtNameSubOff = "ALLTYPE",
    txtIconOn = "UI/Atlas/Tutorial/tex_tutorial_icon_quanbu.png",
    txtIconOff = "UI/Atlas/Tutorial/tex_tutorial_icon_quanbu.png",
    activeLine = true
  })
  for i, tpl in pairs(allTpl) do
    table.insert(datas, {
      tabId = _tutorialTypeTpl:getId(tpl),
      order = _tutorialTypeTpl:getId(tpl),
      txtNameOn = _tutorialTypeTpl:getName(tpl),
      txtNameOff = _tutorialTypeTpl:getName(tpl),
      txtNameSubOn = "TUTORIALTYPE",
      txtNameSubOff = "TUTORIALTYPE",
      txtIconOn = _tutorialTypeTpl:getIcon(tpl),
      txtIconOff = _tutorialTypeTpl:getIcon(tpl),
      activeLine = true
    })
  end
  table.sort(datas, function(a, b)
    return a.order < b.order
  end)
  datas[#datas].activeLine = false
  self.bind.tabList:clear()
  self.bind.tabList:insert_array(datas)
end

function this:initVideo()
  self.curVideoState = CriWareStatus.Stop
  self.waitPlayVideoPath = ""
  self.videoComponent = self.bindComponents.movieController
  self.videoComponent.player.statusChangeCallback = handler(self, self.statusChangeCallback)
  self.curShowVideoIndex = 1
  self.curVideoStateArray = {}
  table.insert(self.curVideoStateArray, CriWareStatus.Stop)
  table.insert(self.curVideoStateArray, CriWareStatus.Stop)
  self.videoComponentArray = {}
  table.insert(self.videoComponentArray, self.bindComponents.movieController1)
  table.insert(self.videoComponentArray, self.bindComponents.movieController2)
  self.videoComponentArray[1].player.statusChangeCallback = handler(self, self.statusChangeCallback1)
  self.videoComponentArray[2].player.statusChangeCallback = handler(self, self.statusChangeCallback2)
end

function this:getNextShowVideoIndex()
  local index = self.curShowVideoIndex + 1
  if 2 < index then
    index = index - 2
  end
  return index
end

function this:initTutorialList(tabId)
  local cellList = {}
  for i, tpl in ipairs(self.tutorialData) do
    local reddot = L_ReddotManager:haveNew(L_ReddotManager.DotDef.NewTutorialGuide, _tutorialTpl:getId(tpl)) and true or false
    if not math.isEmpty(tabId) then
      if _tutorialTpl:getTutorialTypeId(tpl) == tabId then
        table.insert(cellList, {
          tutorial_name = _tutorialTpl:getTutorialName(tpl),
          tutorialName_selected = _tutorialTpl:getTutorialName(tpl),
          data = tpl,
          reddotName = reddot and string.format(L_ReddotManager.DotDef.NewTutorialGuide, _tutorialTpl:getId(tpl)) or "",
          id = _tutorialTpl:getId(tpl),
          index = i
        })
      end
    else
      table.insert(cellList, {
        tutorial_name = _tutorialTpl:getTutorialName(tpl),
        tutorialName_selected = _tutorialTpl:getTutorialName(tpl),
        data = tpl,
        reddotName = reddot and string.format(L_ReddotManager.DotDef.NewTutorialGuide, _tutorialTpl:getId(tpl)) or "",
        id = _tutorialTpl:getId(tpl),
        index = i
      })
    end
  end
  self.bind.tutorial_list:clear()
  self.bind.tutorial_list:insert_array(cellList)
  if 0 < #cellList then
    self:refreshTutorialInfo(cellList[1].id, cellList[1].data, true)
    self.bind.info = true
    if self.bind.empty == true then
      self.bindComponents.listAnim:Stop()
      self.bindComponents.listAnim:Play("anim_tutorial_cell_show")
    end
    self.bind.empty = false
  else
    self.bind.info = false
    self.bind.empty = true
  end
end

function this:refreshTutorialInfo(id, data, isInit)
  self:initInfoPanel(data)
  for i = 1, #self.bind.tutorial_list do
    if self.bind.tutorial_list:getValue(i, "id") == id then
      local isSelect = self.bind.tutorial_list:getValue(i, "select_icon")
      self.bind.tutorial_list:change(i, {select_icon = true})
      if not isSelect and not isInit then
        self.bind.tutorial_list:getItemCls(i):playSelectAnim()
      end
    else
      self.bind.tutorial_list:change(i, {select_icon = false})
    end
  end
end

function this:initInfoPanel(data)
  self.iconList = {}
  self.iconIndex = 1
  local picIds = _tutorialTpl:getGuidePicId(data)
  for i, v in ipairs(picIds) do
    local tpl = _guidePicTpl:getTplById(v)
    if tpl then
      local itemInfo = {
        title = _guidePicTpl:getTitle(tpl),
        desc = _guidePicTpl:getDesc(tpl)
      }
      itemInfo.displayType = _guidePicTpl:GetDisplayType(tpl)
      if itemInfo.displayType == 1 then
        itemInfo.icon = _guidePicTpl:getIcon(tpl)
      elseif itemInfo.displayType == 2 then
        itemInfo.video = _guidePicTpl:GetVideoPath(tpl)
      end
      table.insert(self.iconList, itemInfo)
    end
  end
  self:tryRefreshInfoPanel(self.iconIndex, function()
    self:realRefreshInfoPanel(self.iconIndex)
  end)
  self.bind.allPage = #self.iconList > 1 and true or false
  if self.bind.allPage then
    self:refreshIndexStatus()
    self.bind.maxIndex = #self.iconList
  end
end

function this:tryRefreshInfoPanel(index, callback)
  if table.isEmpty(self.iconList) or math.isEmpty(self.iconIndex) or self.iconList[index] == nil then
    return
  end
  if self.curVideoState == nil then
    return
  end
  if self.iconList[index].displayType == 2 then
    local nextShowVideIndex = self:getNextShowVideoIndex()
    self:preheatVideo(nextShowVideIndex, self.iconList[index].video, callback)
  else
    callback()
  end
end

function this:realRefreshInfoPanel(index)
  self._inPreheatVideo = false
  if table.isEmpty(self.iconList) or math.isEmpty(self.iconIndex) or self.iconList[index] == nil then
    return
  end
  if self.iconList[index].displayType == 1 then
    self.bind.tutorialIcon = self.iconList[index].icon
    self.bind.go_videoBlackMask = false
    self.bind.go_replayVideo = false
    self.bind.go_tutorialImage = true
    self.bind.go_tutorialVideo = false
    if self.curVideoState ~= nil then
      self.videoComponentArray[1]:Stop()
      self.videoComponentArray[2]:Stop()
    end
  elseif self.iconList[index].displayType == 2 and self.curVideoState ~= nil then
    self.videoComponentArray[self.curShowVideoIndex]:Stop()
    local nextShowVideoIndex = self:getNextShowVideoIndex()
    self.bind.go_videoBlackMask = false
    self.bind.go_replayVideo = false
    self.bind.go_tutorialImage = false
    self.bind.go_tutorialVideo = true
    self.curShowVideoIndex = nextShowVideoIndex
    if self.curShowVideoIndex == 1 then
      self.bind.color_video1 = C_Color(1, 1, 1, 1)
    else
      self.bind.color_video2 = C_Color(1, 1, 1, 1)
    end
  end
  self.bind.tutorialName = self.iconList[index].title
  local desc = self.iconList[index].desc
  desc = string.gsub(desc, "#%w+[^%>]", "#3266b4")
  self.bind.tutorialDesc = desc
end

function this:preheatVideo(index, videoPath, callback)
  self._inPreheatVideo = true
  self._nextShowIndex = index
  self._preheatVideoCallback = callback
  if self.curVideoStateArray[index] == CriWareStatus.PlayEnd then
    self.videoComponentArray[index].player:SetFile(nil, videoPath)
    self.videoComponentArray[index]:Play()
  elseif self.curVideoStateArray[index] ~= CriWareStatus.Stop then
    self.videoComponentArray[index]:Stop()
    self.waitPlayVideoPath = videoPath
  else
    self.videoComponentArray[index].player:SetFile(nil, videoPath)
    self.videoComponentArray[index]:Play()
  end
end

function this:statusChangeCallback1(status)
  if status == CriWareStatus.Error then
    self.curVideoStateArray[1] = CriWareStatus.Stop
  elseif status == CriWareStatus.PlayEnd then
    self.curVideoStateArray[1] = CriWareStatus.PlayEnd
    self.bind.go_videoBlackMask = true
    self.bind.go_replayVideo = true
  elseif status == CriWareStatus.Playing then
    self.curVideoStateArray[1] = CriWareStatus.Playing
    if self._inPreheatVideo then
      self.bind.color_video1 = C_Color(1, 1, 1, 0)
      self._inPreheatVideo = false
      self._preheatVideoCallback()
    end
  elseif status == CriWareStatus.Stop then
    self.curVideoStateArray[1] = CriWareStatus.Stop
    if not string.isEmpty(self.waitPlayVideoPath) then
      self.videoComponentArray[1].player:SetFile(nil, self.waitPlayVideoPath)
      self.videoComponentArray[1]:Play()
      self.waitPlayVideoPath = ""
    end
  end
end

function this:statusChangeCallback2(status)
  if status == CriWareStatus.Error then
    self.curVideoStateArray[2] = CriWareStatus.Stop
  elseif status == CriWareStatus.PlayEnd then
    self.curVideoStateArray[2] = CriWareStatus.PlayEnd
    self.bind.go_videoBlackMask = true
    self.bind.go_replayVideo = true
  elseif status == CriWareStatus.Playing then
    self.curVideoStateArray[2] = CriWareStatus.Playing
    if self._inPreheatVideo then
      self.bind.color_video2 = C_Color(1, 1, 1, 0)
      self._inPreheatVideo = false
      self._preheatVideoCallback()
    end
  elseif status == CriWareStatus.Stop then
    self.curVideoStateArray[2] = CriWareStatus.Stop
    if not string.isEmpty(self.waitPlayVideoPath) then
      self.videoComponentArray[2].player:SetFile(nil, self.waitPlayVideoPath)
      self.videoComponentArray[2]:Play()
      self.waitPlayVideoPath = ""
    end
  end
end

function this:refreshInfoPanel(index)
  if table.isEmpty(self.iconList) or math.isEmpty(self.iconIndex) or self.iconList[index] == nil then
    return
  end
  if self.iconList[index].displayType == 1 then
    self.bind.tutorialIcon = self.iconList[index].icon
    self.bind.go_videoBlackMask = false
    self.bind.go_replayVideo = false
    self.bind.go_tutorialImage = true
    self.bind.go_tutorialVideo = false
    if self.curVideoState ~= nil then
      self.videoComponent:Stop()
    end
  elseif self.iconList[index].displayType == 2 and self.curVideoState ~= nil then
    self.bind.go_videoBlackMask = false
    self.bind.go_replayVideo = false
    self.bind.go_tutorialImage = false
    self.bind.go_tutorialVideo = true
    if self.curVideoState == CriWareStatus.PlayEnd then
      self.videoComponent.player:SetFile(nil, self.iconList[index].video)
      self.videoComponent:Play()
    elseif self.curVideoState ~= CriWareStatus.Stop then
      self.videoComponent:Stop()
      self.waitPlayVideoPath = self.iconList[index].video
    else
      self.videoComponent.player:SetFile(nil, self.iconList[index].video)
      self.videoComponent:Play()
    end
  end
  self.bind.tutorialName = self.iconList[index].title
  local desc = self.iconList[index].desc
  desc = string.gsub(desc, "#%w+[^%>]", "#3266b4")
  self.bind.tutorialDesc = desc
end

function this:statusChangeCallback(status)
  C_MJLog.LogInfo("监听 Video 播放状态变化 -> " .. tostring(status) .. "当前帧数：" .. C_Time.frameCount, C_ELogModule.Guide)
  if status == CriWareStatus.Error then
    C_SoulEssenceMovieHelper.StopSoulEssenceMovie()
    self.curVideoState = CriWareStatus.Stop
  elseif status == CriWareStatus.PlayEnd then
    self.curVideoState = CriWareStatus.PlayEnd
    self.bind.go_videoBlackMask = true
    self.bind.go_replayVideo = true
  elseif status == CriWareStatus.Playing then
    self.curVideoState = CriWareStatus.Playing
  elseif status == CriWareStatus.Stop then
    self.curVideoState = CriWareStatus.Stop
    if not string.isEmpty(self.waitPlayVideoPath) then
      self.videoComponent.player:SetFile(nil, self.waitPlayVideoPath)
      self.videoComponent:Play()
      self.waitPlayVideoPath = ""
    end
  end
end

function this:replayVideo()
  self.bind.go_videoBlackMask = false
  self.bind.go_replayVideo = false
  self.videoComponent:Play()
end

function this:refreshIndexStatus(aniIndex)
  if self.iconIndex - 1 <= 0 then
    self.iconIndex = 1
    self.bind.lastDisable = true
    self.bind.nextDisable = false
  elseif self.iconIndex >= #self.iconList then
    self.iconIndex = #self.iconList
    self.bind.lastDisable = false
    self.bind.nextDisable = true
  else
    self.bind.lastDisable = false
    self.bind.nextDisable = false
  end
  self.bindComponents.infoAnim:Stop()
  if not math.isEmpty(aniIndex) then
    local ani = aniIndex == 1 and "anim_pageswitch_toNext" or "anim_pageswitch_toPrev"
    self.bindComponents.infoAnim:Play(ani)
    L_TimerManager:newOrResetTimer(self, "infoAnim", function()
      self.bind.curIndex = self.iconIndex
    end, 0.1)
  else
    L_TimerManager:clearTimer(self)
    self.bind.curIndex = self.iconIndex
  end
end

function this:searchTutorial(txt)
  local pattern = txt
  local cellList = {}
  local index = 0
  for i, tpl in ipairs(self.tutorialData) do
    local str = _tutorialTpl:getTutorialName(tpl)
    local start_index, end_index = string.find(str, pattern)
    if not math.isEmpty(start_index) then
      index = index + 1
      local reddot = L_ReddotManager:haveNew(L_ReddotManager.DotDef.NewTutorialGuide, _tutorialTpl:getId(tpl)) and true or false
      table.insert(cellList, {
        tutorial_name = _tutorialTpl:getTutorialName(tpl),
        tutorialName_selected = _tutorialTpl:getTutorialName(tpl),
        data = tpl,
        reddotName = reddot and string.format(L_ReddotManager.DotDef.NewTutorialGuide, _tutorialTpl:getId(tpl)) or "",
        id = _tutorialTpl:getId(tpl),
        index = index
      })
    end
  end
  self.bind.tutorial_list:clear()
  self.bind.tutorial_list:insert_array(cellList)
  if 0 < #cellList then
    self:refreshTutorialInfo(cellList[1].id, cellList[1].data)
    self.bind.info = true
    if self.bind.empty == true then
      self.bindComponents.listAnim:Stop()
      self.bindComponents.listAnim:Play("anim_tutorial_cell_show")
    end
    self.bind.empty = false
    self.bind.show_searchMenu = true
  else
    self.bind.info = false
    self.bind.empty = true
    self.bind.show_searchMenu = false
  end
end

function this:dealWithButtonActive(bool)
  self.bind.show_searchButton = bool
  self.bind.show_cancelButton = not bool
  self.bind.show_searchMenu = not bool
  self.bind.show_commonMenu = bool
end

function this:updateNotReadNew()
  local haveNewBottom, haveNewUp = false, false
  local showMinIndex = math.maxinteger
  local showMaxIndex = math.mininteger
  for i, v in ipairs(self.modules.tutorial_list) do
    if v.isBind then
      showMinIndex = math.min(showMinIndex, v.bind.index)
      showMaxIndex = math.max(showMaxIndex, v.bind.index)
    elseif showMinIndex > v.bind.index then
      if L_ReddotManager:haveNew(L_ReddotManager.DotDef.NewTutorialGuide, v.bind.id) then
        haveNewUp = true
      end
    elseif showMaxIndex < v.bind.index and L_ReddotManager:haveNew(L_ReddotManager.DotDef.NewTutorialGuide, v.bind.id) then
      haveNewBottom = true
    end
  end
  self.bind.go_newUp = haveNewUp
  self.bind.go_newDown = haveNewBottom
end

function this:_sortTable(list)
  if not table.isEmpty(list) then
    if 1 < #list then
      table.sort(list, function(a, b)
        return _tutorialTpl:getId(a) < _tutorialTpl:getId(b)
      end)
    end
    for i, v in ipairs(list) do
      local insert = true
      for _, data in pairs(self.tutorialData) do
        if v.id == data.id then
          insert = false
          break
        end
      end
      if insert then
        table.insert(self.tutorialData, v)
      end
    end
  end
end

return this
