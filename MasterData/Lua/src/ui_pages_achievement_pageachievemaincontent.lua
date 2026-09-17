local this = class("pageAchieveMainContent", G_UIPageBase)
local _achievementGroupTpl = L_GameTpl:getAchievementGroupTpl()
local _achievementTpl = L_GameTpl:getAchievementTpl()
local tabIconList = {
  "UI/Page/Achievement/tex_achievement_icon_inside_02",
  "UI/Page/Achievement/tex_achievement_icon_inside_03",
  "UI/Page/Achievement/tex_achievement_icon_inside_04",
  "UI/Page/Achievement/tex_achievement_icon_inside_05",
  "UI/Page/Achievement/tex_achievement_icon_inside_06"
}
local tabTitleBgList = {
  "UI/Texture/Achievement/tex_achievement_dec_inside_01.png",
  "UI/Texture/Achievement/tex_achievement_dec_inside_02.png",
  "UI/Texture/Achievement/tex_achievement_dec_inside_03.png",
  "UI/Texture/Achievement/tex_achievement_dec_inside_04.png",
  "UI/Texture/Achievement/tex_achievement_dec_inside_05.png"
}

function this.bind()
  return {
    module_input = {
      moduleName = "modulePages/input/moduleInput"
    },
    module_tabList = {
      moduleName = "pages/achievement/moduleAchieveTabList"
    },
    list_secDir = {
      moduleName = "pages/achievement/CellAchieveSecDir"
    },
    list_thirdDir = {
      moduleName = "pages/ActivityTask/cellActivityTaskItem"
    },
    txt_selTabName = "",
    img_selTab = "",
    img_title_bg = "",
    go_tab = true,
    go_titleInfo = true,
    go_content = true,
    go_empty = false,
    go_track = false,
    go_cancelTrack = false,
    go_bgSearch = false,
    go_secTab = false
  }
end

function this.methods()
  return {
    list_secDir = {
      onClick = function(self, index)
        if self.selSecIndex ~= index then
          self.modules.list_secDir[self.selSecIndex]:setSelected(false)
          self.modules.list_secDir[index]:setSelected(true)
          self.selSecIndex = index
          self.selSecID = self.secIDList[self.selSecIndex].id
          self.selThirdIndex = 1
          self:refreshThirdDir()
        end
      end
    },
    list_thirdDir = {
      onClick = function(self, index)
        if self.selThirdIndex ~= index then
          self.modules.list_thirdDir[self.selThirdIndex]:refreshSel(false)
          self.modules.list_thirdDir[index]:refreshSel(true)
          for i = 1, #self.thridList do
            self.thridList[i].selIndex = index
          end
          self.selThirdIndex = index
          self:refreshTrackUI()
        end
      end
    },
    onclick_track = function(self)
      local item = self.thridList and self.thridList[self.selThirdIndex]
      if not item then
        return
      end
      local selID = item.id
      if selID ~= L_AchievementUtil.getStore():GetAchieveTrackID() then
        L_AchievementUtil.getStore():SetAchieveTrackId(selID)
        self.selThirdIndex = 1
        self:refreshThirdDir()
      end
    end,
    onclick_cancelTrack = function(self)
      L_AchievementUtil.getStore():ClearAchieveTrack()
      self.selThirdIndex = 1
      self:refreshThirdDir()
    end,
    onValueChange_ScrollList = function(self)
      self.bScrolled = true
    end
  }
end

function this:preOpen(options)
  self.firstInit = true
  self.bScrolled = false
  self.bSearchMode = false
  self.selFirstIndex = 1
  self.selSecIndex = 1
  self.selThirdIndex = 1
  self.selAchieveId = -1
  if options and options.firstIndex then
    self.selFirstIndex = options.firstIndex
  end
  if options and options.achieveId then
    self.selAchieveId = options.achieveId
    self.selFirstIndex, self.selSecIndex = L_AchievementUtil.getAchieveIndexbyId(self.selAchieveId)
  end
  self:initNormalStateData()
  self:refreshFristDir()
  self:on_firstIndexChange()
  self:refreshEmptyState()
  self:refreshTrackUI()
  self.delHandler = handler(self, self.del_callBack)
  self.searchHandler = handler(self, self.search_callBack)
  self.modules.module_input:setData({
    limit = 40,
    del_callBack = self.delHandler,
    search_callBack = self.searchHandler
  })
  self:refreshSearchMode()
end

function this:show()
end

function this:initNormalStateData()
  self.firstIDList = {}
  for key, value in pairs(_achievementGroupTpl:getfirstLvDir()) do
    table.insert(self.firstIDList, value.id)
  end
  self.selFirstID = self.firstIDList[self.selFirstIndex]
  self.secThirdDataMap = {}
  for key, value in pairs(_achievementTpl:getAlldata()) do
    local tpl = _achievementTpl:getTplById(value.id)
    if self.secThirdDataMap[_achievementTpl:getGroupId(tpl)] == nil then
      self.secThirdDataMap[_achievementTpl:getGroupId(tpl)] = {}
    end
    table.insert(self.secThirdDataMap[_achievementTpl:getGroupId(tpl)], {
      id = value.id
    })
  end
end

function this:initSearchStateData(curtext)
  self.secIDList = {}
  self.ThirdList = {}
  self.selSecIndex = 1
  self.selThirdIndex = 1
  self.secThirdDataMap = {}
  for key, value in pairs(_achievementTpl:getAlldata()) do
    local tpl = _achievementTpl:getTplById(value.id)
    if string.find(_achievementTpl:getAchiName(tpl), curtext) then
      if self.secThirdDataMap[_achievementTpl:getGroupId(tpl)] == nil then
        self.secThirdDataMap[_achievementTpl:getGroupId(tpl)] = {}
      end
      table.insert(self.secThirdDataMap[_achievementTpl:getGroupId(tpl)], {
        id = value.id
      })
    end
  end
  for key, value in pairs(self.secThirdDataMap) do
    table.insert(self.secIDList, {
      index = #self.secIDList + 1,
      id = key
    })
  end
end

function this:refreshEmptyState()
  if #self.secIDList == 0 then
    self.bind.go_content = false
    self.bind.go_empty = true
  else
    self.bind.go_content = true
    self.bind.go_empty = false
  end
end

function this:refreshSearchMode()
  self.bind.go_tab = not self.bSearchMode
  self.bind.go_titleInfo = not self.bSearchMode
end

function this:refreshFristDir()
  self.modules.module_tabList:setData(self.firstIDList, function(tabId)
    if self.firstInit == false then
      self.selFirstIndex = tabId
      self.selFirstID = self.firstIDList[tabId]
      self.selSecIndex = 1
      self.selThirdIndex = 1
      self:on_firstIndexChange()
    end
  end, self.selFirstIndex)
end

function this:on_firstIndexChange()
  self:refreshSecDir()
  self:refreshThirdDir()
  local tpl = _achievementGroupTpl:getTplById(self.selFirstID)
  self.bind.txt_selTabName = _achievementGroupTpl:getAchiName(tpl)
  self.bind.img_selTab = tabIconList[self.selFirstIndex]
  self.bind.img_title_bg = tabTitleBgList[self.selFirstIndex]
end

function this:refreshSecDir()
  if self.bSearchMode == false then
    self.secIDList = {}
    for key, value in pairs(_achievementGroupTpl:getfirstLvDir()[self.selFirstIndex].data) do
      table.insert(self.secIDList, {
        index = #self.secIDList + 1,
        id = value.id
      })
    end
  end
  if #self.secIDList > 0 then
    self.bind.go_secTab = true
    self.selSecID = self.secIDList[self.selSecIndex].id
    self.bind.list_secDir:clear()
    self.bind.list_secDir:insert_array(self.secIDList)
    if self.bSearchMode == true then
      self.bind.go_bgSearch = true
    else
      self.bind.go_bgSearch = false
    end
  else
    self.bind.go_secTab = false
    self.bind.go_bgSearch = false
  end
end

function this:refreshThirdDir()
  self.thridList = {}
  local secItem = self.secIDList and self.secIDList[self.selSecIndex]
  if not secItem then
    self.bind.list_thirdDir:clear()
    self:refreshTrackUI()
    return
  end
  local thirdData = self.secThirdDataMap[secItem.id] or {}
  for key, value in pairs(thirdData) do
    table.insert(self.thridList, {
      id = value.id,
      selIndex = self.selThirdIndex,
      bAchieve = true,
      bTrack = value.id == L_AchievementUtil.getStore():GetAchieveTrackID(),
      bFinish = L_AchievementUtil.getStore():GetIsAchievementCompleted(value.id)
    })
  end
  table.sort(self.thridList, function(a, b)
    if a.bTrack ~= b.bTrack then
      return a.bTrack == true
    elseif a.bFinish ~= b.bFinish then
      return a.bFinish == false
    elseif a.id ~= b.id then
      return a.id < b.id
    end
  end)
  for key, value in ipairs(self.thridList) do
    value.index = key
    value.selIndex = self.selThirdIndex
  end
  self.bindComponents.viewContent.IsRefreshType = not self.firstInit
  self.firstInit = false
  self.bind.list_thirdDir:clear()
  self.bind.list_thirdDir:insert_array(self.thridList)
  self:refreshTrackUI()
end

function this:refreshTrackUI()
  local item = self.thridList and self.thridList[self.selThirdIndex]
  if not item then
    self.bind.go_track = false
    self.bind.go_cancelTrack = false
    return
  end
  if item.bFinish then
    self.bind.go_track = false
    self.bind.go_cancelTrack = false
  elseif L_AchievementUtil.getStore():GetAchieveTrackID() == item.id then
    self.bind.go_track = false
    self.bind.go_cancelTrack = true
  else
    self.bind.go_track = true
    self.bind.go_cancelTrack = false
  end
end

function this:del_callBack()
  if self.bSearchMode == false then
    return
  end
  self.bSearchMode = false
  self:refreshSearchMode()
  self.selFirstIndex = self.rollBackData.selFirstIndex
  self.selSecIndex = self.rollBackData.selSecIndex
  self.selThirdIndex = self.rollBackData.selThirdIndex
  table.clear(self.rollBackData)
  self:initNormalStateData()
  self:refreshSecDir()
  self:refreshThirdDir()
  self:refreshEmptyState()
end

function this:search_callBack(curtext)
  if curtext == "" then
    if self.bSearchMode then
      self:del_callBack()
    end
    return
  end
  self.bSearchMode = true
  self.rollBackData = {
    selFirstIndex = self.selFirstIndex,
    selSecIndex = self.selSecIndex,
    selThirdIndex = self.selThirdIndex
  }
  self:refreshSearchMode()
  self:initSearchStateData(curtext)
  self:refreshEmptyState()
  self:refreshSecDir()
  if #self.secIDList > 0 then
    self:refreshThirdDir()
  end
end

return this
