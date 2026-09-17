local page = class("pageWorldLevel", G_UIPageBase)
local _worldDifficultyTpl = L_GameTpl:getWorldDifficultyTpl()
local levelImg = {
  [1] = "UI/Atlas/WorldLevel/tex_difficultyswitch_word_03.png",
  [2] = "UI/Atlas/WorldLevel/tex_difficultyswitch_word_02.png",
  [3] = "UI/Atlas/WorldLevel/tex_difficultyswitch_word_01.png",
  [4] = "UI/Atlas/WorldLevel/tex_difficultyswitch_word_04.png",
  [5] = "UI/Atlas/WorldLevel/tex_difficultyswitch_word_05.png",
  [6] = "UI/Atlas/WorldLevel/tex_difficultyswitch_word_06.png",
  [7] = "UI/Atlas/WorldLevel/tex_difficultyswitch_word_07.png",
  [8] = "UI/Atlas/WorldLevel/tex_difficultyswitch_word_08.png"
}
local levelText = {
  [1] = "I",
  [2] = "II",
  [3] = "III",
  [4] = "IV",
  [5] = "V",
  [6] = "VI",
  [7] = "VII",
  [8] = "VIII"
}

function page.bind()
  return {
    scrollLevel = {
      moduleName = "pages/WorldLevel/cellWorldLevel"
    },
    selectIndex = 0,
    initIndex = 0,
    needUpdateScrollListData = false,
    img_level = "",
    txt_title = "",
    txt_enemyDes = "",
    btn_active_change = true,
    btn_active_cancel = false,
    go_curLevel = false,
    txt_free_count = "",
    txt_count_down = "",
    moduleButtonGrey = L_Const.ModuleInfo.ModuleBtn,
    moduleButtonConfirm = L_Const.ModuleInfo.ModuleBtn,
    text_using = L_WordsTpl:getValue("world_difficulty_use")
  }
end

function page.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    scrollLevel = {
      onClick = function(self, bind)
        self.bind.selectIndex = bind.index
      end
    },
    onSelectCallback = function(self, curIndex)
      local curLevel = curIndex + 1
      self.bind.img_level = levelImg[curLevel]
      self.data.curLevel = curLevel
      local conf = _worldDifficultyTpl:getTplById(curLevel)
      local canChange = self:checkIsUnLock(curLevel)
      self.bind.txt_title = _worldDifficultyTpl:getModifierName(conf)
      self.bind.txt_enemyDes = _worldDifficultyTpl:getNote(conf)
      self.bindComponents.img_level:SetNativeSize()
      local nowLevel = L_WorldLevelStore:getServerLevelInfo().cur_level
      local isCurLevel = curLevel == nowLevel
      if canChange and isCurLevel then
        canChange = false
      end
      if canChange then
        local freeTime = L_WorldLevelStore:getFreeTime()
        local changeTimeOver = L_WorldLevelStore:getChangeTimeIsOver()
        if 0 < freeTime or changeTimeOver then
        else
          canChange = false
        end
      end
      self.bind.btn_active_change = canChange and not isCurLevel
      self.bind.btn_active_cancel = not canChange and not isCurLevel
      self.bind.go_curLevel = isCurLevel
      L_AudioUtil.playSound("Play_SFX_System_UI_StarDifficult_Switch")
    end
  }
end

function page:checkLevelUnlock(curLevel)
  local isUnLock = self:checkIsUnLock(curLevel)
  if isUnLock then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("world_difficulty_cd"))
  else
    local str = L_WordsTpl:getValue("world_difficulty_locked")
    local conf = _worldDifficultyTpl:getTplById(curLevel)
    if conf then
      local taskId = _worldDifficultyTpl:getTaskId(conf)
      local tpl = _taskTpl:getTplById(taskId)
      local name = tpl and _taskTpl:getName(tpl) or ""
      local taskName = name
      str = L_WordsTpl:getValue("world_difficulty_locked", {
        [0] = taskName
      })
    end
    L_FlyMsgManager:showNormalMsg(str)
  end
end

function page:created(...)
  page.super.created(self, ...)
  self.data = {curLevel = nil, selectLevel = 1}
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  if options and options.notPlayInAnim then
    self.data.notPlayInAnim = options.notPlayInAnim
  end
  self.indexToIdMap = {}
  self:initPointList()
  local moduleBtnCancel = self.modules.moduleButtonGrey
  moduleBtnCancel:setData({
    txtName = L_WordsTpl:getValue("world_difficulty_change"),
    callback = function()
      self:checkLevelUnlock(self.data.curLevel)
    end
  })
  local moduleBtnConfirm = self.modules.moduleButtonConfirm
  moduleBtnConfirm:setData({
    txtName = L_WordsTpl:getValue("world_difficulty_change"),
    callback = function()
      if L_BattleDataManager:checkPlayerBattle() then
        L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.ChangeWorldLevel))
        return
      end
      if AzurWorld.playerMgr.myPlayerData.IsKiBoTransformMainControl then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("monster_mode_block_difficulty"))
        return
      end
      local callback = self:safeWrap(function(a, errCode, c)
        if errCode == L_Const.errorCode.ErrCodeSucc then
          self.animation = self.gameObject:GetComponent(typeof(C_Animation))
          self.animation:Play("anim_worldlevel_out_1")
          L_UI:open("pageWorldLevelChange", {
            id = self.data.curLevel,
            txtLevel = levelText[self.data.curLevel]
          })
        end
      end)
      L_WorldLevelStore:req_worldLevel(self.data.curLevel, callback)
    end
  })
  self.updateTimer = Timer.repeated(0.1, self.updateHander, self)
end

function page:updateHander()
  local loopListViewRoot = self.bindComponents.LoopListViewRoot
  if loopListViewRoot == nil then
    return
  end
  local index = loopListViewRoot.CurSnapNearestItemIndex
  if index == nil then
    return
  end
  if self.indexToIdMap[index] == nil then
    return
  end
  if self.data.curLevel == self.indexToIdMap[index] then
    return
  end
  if self.indexToIdMap[index] < 0 then
    return
  end
  self.data.curLevel = self.indexToIdMap[index]
  self:refreshPointList()
  self.bind.needUpdateScrollListData = true
end

function page:open()
end

function page:show()
  self:refreshTimer()
end

function page:close()
  page.super.close(self)
  self:resetTimer()
  if self.updateTimer then
    Timer.remove(self.updateTimer)
  end
  self.updateTimer = nil
end

function page:OnEvent_SyncPointData(data)
end

function page:getPointList()
  local list = _worldDifficultyTpl:getTplList()
  local showList = {}
  local nowLevel = L_WorldLevelStore:getServerLevelInfo().cur_level
  for i, v in ipairs(list) do
    local item = {}
    item.id = _worldDifficultyTpl:getId(v)
    item.text_level = levelText[item.id]
    item.level = item.id
    item.go_content = true
    local isLock = not self:checkIsUnLock(item.id)
    local isCurrent = nowLevel == item.id
    item.go_NormalLock = isLock and not isCurrent
    item.go_focusLock = isLock
    item.colorFocusSizeBackBg = isLock and C_LuaUtility.ParseHtmlStringColor("#A0A0A0FF") or C_LuaUtility.ParseHtmlStringColor("#FFFFFFFF")
    item.colorFocusSizeFrontBg = isLock and C_LuaUtility.ParseHtmlStringColor("#A0A0A0FF") or C_LuaUtility.ParseHtmlStringColor("#FFFFFFFF")
    item.showMaskActive = true
    item.go_normal = not isLock and not isCurrent
    item.go_currentBg = isCurrent and not isLock
    item.go_titleNormal = not isCurrent and not isLock
    item.go_titleCurlevel = isCurrent and not isLock
    item.textTitleActive = not isLock
    item.backBg = _worldDifficultyTpl:getImgBackground(v)
    item.frontBg = _worldDifficultyTpl:getImgForeground(v)
    item.text_title = _worldDifficultyTpl:getName(v)
    table.insert(showList, item)
  end
  self.indexToIdMap = {}
  for i, v in pairs(showList) do
    v.index = i - 1
    self.indexToIdMap[v.index] = v.id
  end
  return showList
end

function page:refreshTimer()
  self:resetTimer()
  local freeTime = L_WorldLevelStore:getFreeTime()
  self:refreshChangeState()
  self.bind.txt_free_count = ""
  self.bind.txt_count_down = ""
  if 0 < freeTime then
    self.bind.txt_free_count = ""
    return
  end
  local serverInfo = L_WorldLevelStore:getServerLevelInfo()
  local setTime = serverInfo.set_time
  if math.isEmpty(setTime) then
    self.bind.txt_free_count = ""
    return
  end
  local cdTime = tonumber(L_GameConstTpl:getData("WORLD_DIFFICULT_CD", L_Const.GameTplType.int)) * 60
  
  local function refreshTxtTimeFunc()
    local nowTime = L_TimeUtil:getServerTime()
    local leftTime = nowTime - setTime
    self.bind.txt_free_count = ""
    if leftTime > cdTime then
      self:resetTimer()
      self:refreshChangeState()
      self.bind.txt_count_down = ""
    else
      self.bind.txt_count_down = L_WordsTpl:getValue("residual_code_pageworldlevel_01") .. L_TimeUtil.secondToLangString(cdTime - leftTime)
    end
  end
  
  refreshTxtTimeFunc()
  self.timer = Timer.repeated(1, function()
    refreshTxtTimeFunc()
  end, self, self.gameObject)
end

function page:initPointList()
  self.bind.scrollLevel:clear()
  local list = self:getPointList()
  self.bind.scrollLevel:insert_array(list)
  self.bind.needUpdateScrollListData = true
  self:firstSelect()
end

function page:firstSelect()
  local list = self:getPointList()
  local nowLevel = L_WorldLevelStore:getNowLevel()
  if self.data.curLevel == nil then
    self.data.curLevel = nowLevel
  end
  local index, firstIndex
  for i, v in ipairs(list) do
    if v.id > 0 and firstIndex == nil then
      firstIndex = v.index
    end
    if v.id == self.data.curLevel and index == nil then
      index = v.index
    end
  end
  if index ~= nil then
    self.bind.initIndex = index
  elseif firstIndex ~= nil then
    self.bind.initIndex = firstIndex
  end
  self:refreshPointList()
end

function page:refreshPointList()
  local list = self:getPointList()
  for i, v in ipairs(list) do
    self.bind.scrollLevel:change(i, v)
  end
  self:refreshChangeState()
end

function page:checkIsUnLock(id)
  local conf = _worldDifficultyTpl:getTplById(id)
  local canChange = false
  if conf then
    local taskId = _worldDifficultyTpl:getTaskId(conf)
    if taskId == 0 or taskId == nil then
      canChange = true
    else
      canChange = AzurWorld.TaskMgr:IsFinishTask(taskId)
    end
  end
  return canChange
end

function page:refreshChangeState()
  self.bind.img_level = levelImg[self.data.curLevel]
  local conf = _worldDifficultyTpl:getTplById(self.data.curLevel)
  local canChange = self:checkIsUnLock(self.data.curLevel)
  self.bind.txt_title = _worldDifficultyTpl:getModifierName(conf)
  self.bind.txt_enemyDes = _worldDifficultyTpl:getNote(conf)
  self.bindComponents.img_level:SetNativeSize()
  local nowLevel = L_WorldLevelStore:getServerLevelInfo().cur_level
  local isCurLevel = self.data.curLevel == nowLevel
  if canChange and isCurLevel then
    canChange = false
  end
  if canChange then
    local freeTime = L_WorldLevelStore:getFreeTime()
    local changeTimeOver = L_WorldLevelStore:getChangeTimeIsOver()
    if 0 < freeTime or changeTimeOver then
    else
      canChange = false
    end
  end
  self.bind.btn_active_change = canChange and not isCurLevel
  self.bind.btn_active_cancel = not canChange and not isCurLevel
  self.bind.go_curLevel = isCurLevel
end

function page:resetTimer()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

return page
