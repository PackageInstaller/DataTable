local this = class("pageActivityPartySkill", G_UIPageBase)
local CriWareStatus = CS.CriWare.CriMana.Player.Status
local _PartyGameTpl = L_GameTpl:getGameEventsPartygameTpl()
local _PartyGameSkillTpl = L_GameTpl:getPartygameSkillTpl()

local function isStringEmpty(value)
  return type(value) ~= "string" or value == ""
end

local function isVideoFilePath(path)
  if isStringEmpty(path) then
    return false
  end
  local lowerPath = string.lower(path)
  return string.match(lowerPath, "%.usm$") ~= nil or string.match(lowerPath, "%.mp4$") ~= nil or string.match(lowerPath, "%.webm$") ~= nil or string.match(lowerPath, "%.mov$") ~= nil
end

local function tryPlayVideoController(videoController, videoPath)
  if not (videoController and videoController.player) or not isVideoFilePath(videoPath) then
    return false
  end
  local ok = pcall(function()
    videoController:Stop()
    videoController.player:SetFile(nil, videoPath)
    videoController:Play()
  end)
  return ok
end

local function findChildByNameDeep(parent, nodeName)
  if not parent then
    return nil
  end
  for i = 0, parent.childCount - 1 do
    local child = parent:GetChild(i)
    if child.name == nodeName then
      return child
    end
    local result = findChildByNameDeep(child, nodeName)
    if result then
      return result
    end
  end
  return nil
end

local function showEmptyStateInternal(page)
  page.bind.info = false
  page.bind.tutorialName = ""
  page.bind.tutorialDesc = ""
  page.bind.go_videoBlackMask = false
  page.bind.go_replayVideo = false
  page.bind.go_tutorialImage = true
  page.bind.go_tutorialVideo = false
end

local function refreshSelectedSkillInternal(page)
  local skillData = page.skillDataList[page.selectedIndex]
  if not skillData then
    showEmptyStateInternal(page)
    return
  end
  page.bind.info = true
  page.bind.tutorialName = skillData.title or ""
  local desc = skillData.desc or ""
  if not isStringEmpty(desc) then
    desc = string.gsub(desc, "#%w+[^%>]", "#3266b4")
  end
  page.bind.tutorialDesc = desc
  page:refreshCurrentPreview(skillData)
end

function this.bind()
  return {
    bindGrid = {
      moduleName = "pages/gameAct/cellActivityPartySkillItem"
    },
    tutorialName = "",
    tutorialDesc = "",
    info = false,
    go_videoBlackMask = false,
    go_replayVideo = false,
    go_tutorialImage = true,
    go_tutorialVideo = false,
    color_video1 = C_Color(1, 1, 1, 0),
    color_video2 = C_Color(1, 1, 1, 0)
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      self:closeSelf()
    end,
    onClick_back = function(self)
      self:closeSelf()
    end,
    onClick_home = function(self)
      L_UI:backToRoot()
    end,
    onClick_replayVideo = function(self)
      self:replayVideo()
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.actId = options and (options.actId or options.id) or 0
  self.skillDataList = {}
  self.selectedIndex = 1
  self._previewImage = nil
  self.videoComponent = nil
  self.videoComponentArray = nil
  self.curShowVideoIndex = 1
  self.curVideoStateArray = nil
  self.waitPlayVideoPath = ""
  self._inPreheatVideo = false
  self._pendingShowIndex = nil
  self.currentVideoPath = ""
  self:buildSkillData()
  if 0 >= #self.skillDataList then
    self.selectedIndex = 0
  else
    self.selectedIndex = math.min(self.selectedIndex, #self.skillDataList)
  end
end

function this:open()
  this.super.open(self)
  self:initVideo()
  self.bind.go_videoBlackMask = false
  self.bind.go_replayVideo = false
  self.bind.go_tutorialImage = true
  self.bind.go_tutorialVideo = false
  self.bind.info = #self.skillDataList > 0
  self:refreshSkillListDeferred()
  if #self.skillDataList > 0 then
    refreshSelectedSkillInternal(self)
  else
    showEmptyStateInternal(self)
  end
end

function this:close(options)
  self:stopVideo()
  if self.videoComponent and self.videoComponent.player then
    self.videoComponent.player.statusChangeCallback = nil
  end
  if self.videoComponentArray then
    if self.videoComponentArray[1] and self.videoComponentArray[1].player then
      self.videoComponentArray[1].player.statusChangeCallback = nil
    end
    if self.videoComponentArray[2] and self.videoComponentArray[2].player then
      self.videoComponentArray[2].player.statusChangeCallback = nil
    end
  end
  self.videoComponent = nil
  self.videoComponentArray = nil
  this.super.close(self, options)
end

function this:escHandle()
  self:closeSelf()
end

function this:closeSelf()
  L_UI:close(self.pageName)
end

function this:initVideo()
  self.waitPlayVideoPath = ""
  self.curShowVideoIndex = 1
  self._inPreheatVideo = false
  self._pendingShowIndex = nil
  self.currentVideoPath = ""
  self.videoComponent = self.bindComponents and self.bindComponents.movieController or nil
  self.videoComponentArray = {
    self.bindComponents and self.bindComponents.movieController1 or nil,
    self.bindComponents and self.bindComponents.movieController2 or nil
  }
  self.curVideoStateArray = {
    CriWareStatus and CriWareStatus.Stop or nil,
    CriWareStatus and CriWareStatus.Stop or nil
  }
  if self.videoComponent and self.videoComponent.player then
    self.videoComponent.player.statusChangeCallback = handler(self, self.onVideoStatusChanged)
  end
  if self.videoComponentArray[1] and self.videoComponentArray[1].player then
    self.videoComponentArray[1].player.statusChangeCallback = handler(self, self.statusChangeCallback1)
  end
  if self.videoComponentArray[2] and self.videoComponentArray[2].player then
    self.videoComponentArray[2].player.statusChangeCallback = handler(self, self.statusChangeCallback2)
  end
  self.bind.color_video1 = C_Color(1, 1, 1, 0)
  self.bind.color_video2 = C_Color(1, 1, 1, 0)
end

function this:buildSkillData()
  if not self.actId or self.actId <= 0 then
    return
  end
  local partyTpl = _PartyGameTpl:getTplById(self.actId)
  if not partyTpl then
    return
  end
  local skillIdList = _PartyGameTpl:getSkillList(partyTpl) or {}
  for _, skillTplId in ipairs(skillIdList) do
    local skillTpl = _PartyGameSkillTpl:getTplById(tonumber(skillTplId))
    if skillTpl then
      local buttonIcon = _PartyGameSkillTpl:getButtonIcon(skillTpl)
      local figureIcon = _PartyGameSkillTpl:getFigureIcon(skillTpl)
      local title = _PartyGameSkillTpl:getName(skillTpl) or ""
      if not string.isEmpty(title) then
        local title_firstStr = string.match(title, "[%z\001-\127Â-ô][€-¿]*")
        local title_subStr = string.sub(title, #title_firstStr + 1)
        title = string.format("<size=43>%s</size>%s", title_firstStr, title_subStr)
      end
      table.insert(self.skillDataList, {
        id = _PartyGameSkillTpl:getId(skillTpl),
        title = title,
        desc = _PartyGameSkillTpl:getDesc(skillTpl) or "",
        buttonIcon = buttonIcon or "",
        figureIcon = buttonIcon or "" or figureIcon,
        video = _PartyGameSkillTpl:getVideoPath(skillTpl) or "",
        order = _PartyGameSkillTpl:getOrder(skillTpl)
      })
    end
  end
  table.sort(self.skillDataList, function(a, b)
    local orderA = tonumber(a.order) or 0
    local orderB = tonumber(b.order) or 0
    if orderA == orderB then
      return (tonumber(a.id) or 0) < (tonumber(b.id) or 0)
    end
    return orderA < orderB
  end)
  for index, data in ipairs(self.skillDataList) do
    data.index = index
  end
end

function this:refreshSkillListDeferred(retryCount)
  retryCount = retryCount or 0
  local skillListBind = self.bind and self.bind.bindGrid or nil
  if skillListBind and skillListBind.clear and skillListBind.insert_array then
    self:refreshSkillList()
    return
  end
  if 8 <= retryCount then
    self:refreshSkillList()
    return
  end
  Timer.once(0.1, function()
    if L_CommonUtil.isValid(self.gameObject) then
      self:refreshSkillListDeferred(retryCount + 1)
    end
  end, self, self.gameObject)
end

function this:refreshSkillList()
  local skillListBind = self.bind and self.bind.bindGrid or nil
  if not (skillListBind and skillListBind.clear) or not skillListBind.insert_array then
    return
  end
  local list = {}
  for index, _ in ipairs(self.skillDataList) do
    list[index] = {
      guid = 0,
      selectMode = false,
      activeSelect = index == self.selectedIndex,
      callback = function()
        self:onSelectSkill(index)
      end
    }
  end
  skillListBind:clear()
  skillListBind:insert_array(list)
  Timer.once(0.1, function()
    if L_CommonUtil.isValid(self.gameObject) then
      self:refreshSkillCellDisplay()
    end
  end, self, self.gameObject)
end

function this:refreshSkillCellDisplay(retryCount)
  retryCount = retryCount or 0
  local skillModules = self.modules and self.modules.bindGrid or nil
  local hasCell = false
  for index, cellModule in pairs(skillModules or {}) do
    hasCell = true
    self:applySkillCellDisplay(cellModule, self.skillDataList[index], index == self.selectedIndex)
  end
  if hasCell or 8 <= retryCount then
    return
  end
  Timer.once(0.1, function()
    if L_CommonUtil.isValid(self.gameObject) then
      self:refreshSkillCellDisplay(retryCount + 1)
    end
  end, self, self.gameObject)
end

function this:applySkillCellDisplay(cellModule, skillData, isSelected)
  if not (cellModule and cellModule.bind) or not skillData then
    return
  end
  if cellModule.bind.listStar and cellModule.bind.listStar.clear then
    cellModule.bind.listStar:clear()
  end
  cellModule.bind.img_icon = skillData.buttonIcon or ""
  
  function cellModule.bind.callback()
    self:onSelectSkill(skillData.index)
  end
  
  if cellModule.setSelectState then
    cellModule:setSelectState(isSelected == true)
  else
    cellModule.bind.activeSelect = isSelected == true
  end
end

function this:onSelectSkill(index)
  local nextIndex = tonumber(index)
  if not nextIndex or not self.skillDataList[nextIndex] then
    return
  end
  if self.selectedIndex == nextIndex then
    return
  end
  self.selectedIndex = nextIndex
  this.syncSkillCellSelect(self)
  refreshSelectedSkillInternal(self)
end

function this:syncSkillCellSelect()
  local skillModules = self.modules and self.modules.bindGrid or nil
  for idx, cellModule in pairs(skillModules or {}) do
    self:applySkillCellDisplay(cellModule, self.skillDataList[idx], idx == self.selectedIndex)
  end
end

function this:refreshSelectedSkill()
  refreshSelectedSkillInternal(self)
end

function this:showEmptyState()
  showEmptyStateInternal(self)
end

function this:getPlayableVideoPath(skillData)
  if skillData and isVideoFilePath(skillData.video) then
    return skillData.video
  end
  return ""
end

function this:prepareVideoCandidates(skillData)
  self.currentVideoPath = self:getPlayableVideoPath(skillData)
end

function this:getNextShowVideoIndex()
  local index = self.curShowVideoIndex + 1
  if 2 < index then
    index = index - 2
  end
  return index
end

function this:canPlayDualVideo(videoPath)
  return not isStringEmpty(videoPath) and self.videoComponentArray ~= nil and self.videoComponentArray[1] ~= nil and self.videoComponentArray[1].player ~= nil and self.videoComponentArray[2] ~= nil and self.videoComponentArray[2].player ~= nil
end

function this:refreshCurrentPreview(skillData)
  self:prepareVideoCandidates(skillData)
  if self:tryRefreshInfoPanel(self.currentVideoPath) then
    return
  end
  self:showImagePreview(skillData)
end

function this:showImagePreview(skillData)
  self.bind.go_videoBlackMask = false
  self.bind.go_replayVideo = false
  self.bind.go_tutorialImage = true
  self.bind.go_tutorialVideo = false
  self.bind.color_video1 = C_Color(1, 1, 1, 0)
  self.bind.color_video2 = C_Color(1, 1, 1, 0)
  self:stopVideo()
end

function this:tryRefreshInfoPanel(videoPath)
  if not self:canPlayDualVideo(videoPath) then
    return false
  end
  local nextShowIndex = self:getNextShowVideoIndex()
  local ok = self:preheatVideo(nextShowIndex, videoPath)
  if not ok then
    self._inPreheatVideo = false
    self._pendingShowIndex = nil
    self.waitPlayVideoPath = ""
    return false
  end
  return true
end

function this:stopVideo()
  if self.videoComponent then
    pcall(function()
      self.videoComponent:Stop()
    end)
  end
  if self.videoComponentArray then
    if self.videoComponentArray[1] then
      pcall(function()
        self.videoComponentArray[1]:Stop()
      end)
    end
    if self.videoComponentArray[2] then
      pcall(function()
        self.videoComponentArray[2]:Stop()
      end)
    end
  end
end

function this:replayVideo()
  local skillData = self.skillDataList[self.selectedIndex]
  local videoPath = self.currentVideoPath
  if isStringEmpty(videoPath) then
    self:prepareVideoCandidates(skillData)
    videoPath = self.currentVideoPath
  end
  if isStringEmpty(videoPath) then
    return
  end
  local currentVideo = self.videoComponentArray and self.videoComponentArray[self.curShowVideoIndex] or nil
  if currentVideo and currentVideo.player and tryPlayVideoController(currentVideo, videoPath) then
    self.bind.go_videoBlackMask = false
    self.bind.go_replayVideo = false
    self.bind.go_tutorialImage = false
    self.bind.go_tutorialVideo = true
    if self.curShowVideoIndex == 1 then
      self.bind.color_video1 = C_Color(1, 1, 1, 1)
      self.bind.color_video2 = C_Color(1, 1, 1, 0)
    else
      self.bind.color_video1 = C_Color(1, 1, 1, 0)
      self.bind.color_video2 = C_Color(1, 1, 1, 1)
    end
  else
    self:showImagePreview(skillData)
  end
end

function this:onVideoStatusChanged(status)
  if not CriWareStatus then
    return
  end
  if status == CriWareStatus.PlayEnd then
    self.bind.go_videoBlackMask = true
    self.bind.go_replayVideo = true
  elseif status == CriWareStatus.Playing then
    self.bind.go_videoBlackMask = false
    self.bind.go_replayVideo = false
  elseif status == CriWareStatus.Error then
    local skillData = self.skillDataList[self.selectedIndex]
    self:showImagePreview(skillData)
  end
end

function this:preheatVideo(index, videoPath)
  if not (self.videoComponentArray and self.videoComponentArray[index]) or not self.videoComponentArray[index].player then
    return false
  end
  if isStringEmpty(videoPath) then
    return false
  end
  self._inPreheatVideo = true
  self._pendingShowIndex = index
  if self.curVideoStateArray[index] == CriWareStatus.PlayEnd then
    return tryPlayVideoController(self.videoComponentArray[index], videoPath)
  elseif self.curVideoStateArray[index] ~= CriWareStatus.Stop then
    self.videoComponentArray[index]:Stop()
    self.waitPlayVideoPath = videoPath
    return true
  else
    return tryPlayVideoController(self.videoComponentArray[index], videoPath)
  end
end

function this:showReadyVideo(index)
  local oldIndex = self.curShowVideoIndex
  if oldIndex ~= index and self.videoComponentArray and self.videoComponentArray[oldIndex] then
    pcall(function()
      self.videoComponentArray[oldIndex]:Stop()
    end)
  end
  self.curShowVideoIndex = index
  self.bind.go_videoBlackMask = false
  self.bind.go_replayVideo = false
  self.bind.go_tutorialImage = false
  self.bind.go_tutorialVideo = true
  if index == 1 then
    self.bind.color_video1 = C_Color(1, 1, 1, 1)
    self.bind.color_video2 = C_Color(1, 1, 1, 0)
  else
    self.bind.color_video1 = C_Color(1, 1, 1, 0)
    self.bind.color_video2 = C_Color(1, 1, 1, 1)
  end
end

function this:onDualVideoError(index)
  self.curVideoStateArray[index] = CriWareStatus.Stop
  if self._pendingShowIndex == index then
    self._inPreheatVideo = false
    self._pendingShowIndex = nil
    self.waitPlayVideoPath = ""
    local skillData = self.skillDataList[self.selectedIndex]
    self:showImagePreview(skillData)
  end
end

function this:onDualVideoPlaying(index)
  self.curVideoStateArray[index] = CriWareStatus.Playing
  if self._inPreheatVideo and self._pendingShowIndex == index then
    self._inPreheatVideo = false
    self._pendingShowIndex = nil
    self:showReadyVideo(index)
  end
end

function this:onDualVideoPlayEnd(index)
  self.curVideoStateArray[index] = CriWareStatus.PlayEnd
  if self.curShowVideoIndex == index then
    self.bind.go_videoBlackMask = true
    self.bind.go_replayVideo = true
  end
end

function this:onDualVideoStop(index)
  self.curVideoStateArray[index] = CriWareStatus.Stop
  if not isStringEmpty(self.waitPlayVideoPath) and self._pendingShowIndex == index then
    local videoPath = self.waitPlayVideoPath
    self.waitPlayVideoPath = ""
    if not tryPlayVideoController(self.videoComponentArray[index], videoPath) then
      self._inPreheatVideo = false
      self._pendingShowIndex = nil
      local skillData = self.skillDataList[self.selectedIndex]
      self:showImagePreview(skillData)
    end
  end
end

function this:statusChangeCallback1(status)
  if status == CriWareStatus.Error then
    self:onDualVideoError(1)
  elseif status == CriWareStatus.PlayEnd then
    self:onDualVideoPlayEnd(1)
  elseif status == CriWareStatus.Playing then
    self:onDualVideoPlaying(1)
  elseif status == CriWareStatus.Stop then
    self:onDualVideoStop(1)
  end
end

function this:statusChangeCallback2(status)
  if status == CriWareStatus.Error then
    self:onDualVideoError(2)
  elseif status == CriWareStatus.PlayEnd then
    self:onDualVideoPlayEnd(2)
  elseif status == CriWareStatus.Playing then
    self:onDualVideoPlaying(2)
  elseif status == CriWareStatus.Stop then
    self:onDualVideoStop(2)
  end
end

return this
