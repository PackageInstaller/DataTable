local cls = class("pagePetDuelChapter", G_UIPageBase)
local _kiboDuelChapterTpl = L_GameTpl:getKiBoDuelChapterTpl()
local _kiboDuelGroupTpl = L_GameTpl:getKiBoDuelGroupTpl()

function cls.bind()
  return {
    list_chapterMode = {
      moduleName = "pages/petDuelOutside/cellPetDuelChapterMode"
    },
    active_btnChapterLeft = false,
    active_btnChapterRight = false,
    txt_chapterName = "",
    list_chapterLevel = {
      moduleName = "pages/petDuelOutside/cellPetDuelChapterLevel"
    },
    active_levelDetails = false,
    modulePetDuelLevelInfo = {
      moduleName = "pages/petDuelOutside/modulePetDuelLevelInfo"
    },
    sizeDelta_content = C_Vector2.zero,
    pos_content = C_Vector3.zero
  }
end

function cls.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_chapterLeft = function(self)
      self:onBtnChapterLeft()
    end,
    onClick_chapterRight = function(self)
      self:onBtnChapterRight()
    end,
    onClick_choseDetails = function(self)
      self:onBtnCloseLevelDetail()
    end
  }
end

function cls:check(options, callback)
  local result = C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petDuel)
  callback(result)
end

function cls:preOpen(options)
  cls.super.preOpen(self, options)
  L_PetDuelStore:listenCallFunc(L_PetDuelStore.event.chapterPass_close, self.onCloseChapterPass, self)
  L_PetDuelStore:listenCallFunc(L_PetDuelStore.event.chapterModeUnlock_close, self.onCloseChapterModeUnlock, self)
end

function cls:getChapterIdSaveKey()
end

function cls:onCloseChapterPass()
  local chapterModeInfo = _kiboDuelChapterTpl:getModeInfo(self.selectModeId)
  if self.selectChapterIndex < #chapterModeInfo then
    self.selectChapterIndex = self.selectChapterIndex + 1
    self:refreshChapterInfo(true)
  end
  self:checkChapterModeUnlockProcess()
end

function cls:onCloseChapterModeUnlock(modeId)
  self.selectModeId = modeId
  self.selectChapterIndex = 1
  self:initChapterModeInfo()
  self:refreshChapterInfo(true)
end

function cls:open(options)
  self:initPage()
end

function cls:getLastChapterModeLevelId()
  local keyString = L_PetDuelStore:getLastLevelIdSaveKey()
  local levelId = C_PlayerPrefsUtility.GetInt(keyString)
  if math.isEmpty(levelId) then
    return
  end
  L_PetDuelStore:setLastChapterModeLevelId(levelId)
end

function cls:initPage()
  self:getLastChapterModeLevelId()
  local needCheck = self:checkInitChapterSelect()
  self:initChapterModeInfo()
  self:refreshChapterInfo(true)
  if needCheck then
    self:checkChapterModeUnlockProcess()
  end
end

function cls:initChapterModeInfo()
  local function onClick_select(cell)
    self.selectModeId = cell.bind.modeId
    
    for i = 1, #self.bind.list_chapterMode do
      self.bind.list_chapterMode:change(i, {
        selectModeId = self.selectModeId
      })
    end
    self:refreshChapterInfo(false)
  end
  
  local chapterModeInfo = {}
  for i = 1, _kiboDuelChapterTpl:getModeNum() do
    table.insert(chapterModeInfo, {
      modeId = i,
      selectModeId = self.selectModeId,
      callback = onClick_select
    })
  end
  self.bind.list_chapterMode:clear()
  self.bind.list_chapterMode:insert_array(chapterModeInfo)
end

function cls:checkChapterModeUnlockProcess()
  local modeNum = _kiboDuelChapterTpl:getModeNum()
  for i = 2, modeNum do
    if L_PetDuelStore:checkChapterModeUnlock(i, false) then
      local keyString = L_PetDuelStore:getModeChallengeSuccessSaveKey(i)
      local hasShowed = C_PlayerPrefsUtility.GetBool(keyString)
      if not hasShowed then
        L_UI:open("pagePetDuelChapterModeUnlock", {modeId = i})
        return
      end
    end
  end
end

function cls:checkInitChapterSelect()
  local levelId = L_PetDuelStore:getLastChapterModeLevelId()
  local kiBoDuelGroupCfg = _kiboDuelGroupTpl:getTplById(levelId)
  if not kiBoDuelGroupCfg then
    L_PetDuelStore:setLastChapterModeLevelId(nil)
    levelId = L_PetDuelStore:getLastChapterModeLevelId()
    kiBoDuelGroupCfg = _kiboDuelGroupTpl:getTplById(levelId)
  end
  if not kiBoDuelGroupCfg then
    errorf("没有找到对应的关卡配置,levelId:%s", levelId)
  end
  local chapterId = _kiboDuelGroupTpl:getChapterId(kiBoDuelGroupCfg)
  local kiBoDuelChapterCfg = _kiboDuelChapterTpl:getTplById(chapterId)
  self.selectModeId = _kiboDuelChapterTpl:getModeId(kiBoDuelChapterCfg)
  self.selectChapterIndex = _kiboDuelChapterTpl:getIndex(kiBoDuelChapterCfg)
  local hasAllPassed = true
  for _, id in pairs(_kiboDuelChapterTpl:getKiBoDuelGroupId(kiBoDuelChapterCfg)) do
    if not L_PetDuelStore:getIsSuccess(id) then
      hasAllPassed = false
      break
    end
  end
  if not hasAllPassed then
    return true
  end
  local keyString = L_PetDuelStore:getChapterChallengeSuccessSaveKey(chapterId)
  local hasShowed = C_PlayerPrefsUtility.GetBool(keyString)
  if hasShowed then
    return true
  end
  L_UI:open("pagePetDuelChapterPass", {chapterId = chapterId})
  return false
end

function cls:refreshChapterInfo(bInit)
  if not bInit then
    local keyString = L_PetDuelStore:getLastLevelIdSaveKey(self.selectModeId)
    local levelId = C_PlayerPrefsUtility.GetInt(keyString)
    if math.isEmpty(levelId) then
      self.selectChapterIndex = 1
    else
      local kiBoDuelGroupCfg = _kiboDuelGroupTpl:getTplById(levelId)
      local chapterId = _kiboDuelGroupTpl:getChapterId(kiBoDuelGroupCfg)
      local kiBoDuelChapterCfg = _kiboDuelChapterTpl:getTplById(chapterId)
      self.selectChapterIndex = _kiboDuelChapterTpl:getIndex(kiBoDuelChapterCfg)
    end
  end
  self.chapterModeInfo = _kiboDuelChapterTpl:getModeInfo(self.selectModeId)
  self.chapterNum = table.count(self.chapterModeInfo)
  self:refreshChapterChoose()
end

function cls:refreshChapterLevelInfo()
  local curSelectChapterId = _kiboDuelChapterTpl:getChapterId(self.chapterModeInfo[self.selectChapterIndex])
  local sizeDelta = self.bind.sizeDelta_content
  self.bind.sizeDelta_content = C_Vector2(L_PetDuelStore:getChapterContentWidth(curSelectChapterId), sizeDelta.y)
  local levelList = {}
  local chapterLevelInfo = _kiboDuelGroupTpl:getChapterLevelInfo(curSelectChapterId)
  self.selectLevelId = 0
  
  local function onClick_select(cell)
    self.selectLevelId = cell.bind.levelId
    for i = 1, #self.bind.list_chapterLevel do
      self.bind.list_chapterLevel:change(i, {
        selectLevelId = self.selectLevelId
      })
    end
    self:adjustChapterPos()
    self:showSelectLevelDetail()
  end
  
  for i = 1, #chapterLevelInfo do
    table.insert(levelList, {
      levelId = _kiboDuelGroupTpl:getLevelId(chapterLevelInfo[i]),
      selectLevelId = self.selectLevelId,
      callback = onClick_select
    })
  end
  self.bind.list_chapterLevel:clear()
  self.bind.list_chapterLevel:insert_array(levelList)
end

function cls:adjustChapterPos()
end

function cls:showSelectLevelDetail()
  self.bind.active_levelDetails = true
  self.modules.modulePetDuelLevelInfo:initModulePetDuelLevelInfo(self.selectLevelId)
end

function cls:refreshChapterChoose()
  self.bind.active_btnChapterLeft = self.selectChapterIndex > 1
  self.bind.active_btnChapterRight = self.selectChapterIndex < self.chapterNum
  self.chapterInfo = self.chapterModeInfo[self.selectChapterIndex]
  self.bind.txt_chapterName = _kiboDuelChapterTpl:getChapterName(self.chapterInfo)
  self:refreshChapterLevelInfo()
end

function cls:onBtnChapterLeft()
  if self.selectChapterIndex <= 1 then
    return
  end
  local lastChapterIndex = self.selectChapterIndex - 1
  local lastChapterInfo = self.chapterModeInfo[lastChapterIndex]
  if not L_PetDuelStore:checkChapterUnlock(_kiboDuelChapterTpl:getChapterId(lastChapterInfo), true) then
    return
  end
  self.selectChapterIndex = self.selectChapterIndex - 1
  self:refreshChapterChoose()
end

function cls:onBtnChapterRight()
  if self.selectChapterIndex >= self.chapterNum then
    return
  end
  local nextChapterIndex = self.selectChapterIndex + 1
  local nextChapterInfo = self.chapterModeInfo[nextChapterIndex]
  if not L_PetDuelStore:checkChapterUnlock(_kiboDuelChapterTpl:getChapterId(nextChapterInfo), true) then
    return
  end
  self.selectChapterIndex = self.selectChapterIndex + 1
  self:refreshChapterChoose()
end

function cls:onBtnCloseLevelDetail()
  self.bind.active_levelDetails = false
  self.selectLevelId = 0
  for i = 1, #self.bind.list_chapterLevel do
    self.bind.list_chapterLevel:change(i, {
      selectLevelId = self.selectLevelId
    })
  end
end

function cls:onEvent_petDuelPrepareSceneLoaded(bLoad)
  L_CommonUtil.setObjActive(self.gameObject, not bLoad)
end

function cls:close(options)
  cls.super.close(self, options)
  L_PetDuelStore:unListenCallFunc(L_PetDuelStore.event.chapterPass_close, self.onCloseChapterPass, self)
  L_PetDuelStore:unListenCallFunc(L_PetDuelStore.event.chapterModeUnlock_close, self.onCloseChapterModeUnlock, self)
end

return cls
