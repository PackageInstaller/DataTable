local page = class("pageWorldLevelConfirm", G_UIPageBase)
local _worldDifficultyTpl = L_GameTpl:getWorldDifficultyTpl()

function page.bind()
  return {
    module_cellWorldLevel1 = {
      moduleName = "pages/WorldLevel/cellWorldLevel"
    },
    module_cellWorldLevel2 = {
      moduleName = "pages/WorldLevel/cellWorldLevel"
    },
    txt_time = "",
    txt_canUp = "",
    go_tip = false,
    txt_tip = ""
  }
end

function page.methods()
  return {
    onClick_close = function(self)
      self:outBack()
    end,
    onClick_cancel = function(self)
      self:outBack()
    end,
    onClick_confirm = function(self)
      self:onClick_confirm()
    end,
    onClick_tip = function(self)
      self.bind.go_tip = not self.bind.go_tip
    end,
    onClick_tipClose = function(self)
      self.bind.go_tip = false
    end
  }
end

function page:created(...)
  page.super.created(self, ...)
  self.data = {
    targetLevel = nil,
    canUp = false,
    worldLevelAnim = nil
  }
end

function page:preOpen(options)
  page.super.preOpen(self, options)
  self.data.targetLevel = options.targetLevel
  self.data.canUp = options.canUp
  self.data.worldLevelAnim = options.worldLevelAnim
  self:refreshPointList()
  self.bind.txt_tip = L_WordsTpl:getValue("notice_worlddifficulty_explanation")
end

function page:open()
  if self.data.worldLevelAnim then
    self.data.worldLevelAnim:Play("anim_worldlevel_hide")
    self.bindComponents.confirmAnimation:Play("anim_worldlevelconfirm_in")
  else
    self.bindComponents.confirmAnimation:Play("anim_worldlevelconfirm_in1")
  end
end

function page:show()
end

function page:close()
  page.super.close(self)
  self:resetTimer()
end

function page:refreshPointList()
  local targetLevel = self.data.targetLevel
  local targetTpl = _worldDifficultyTpl:getTplById(targetLevel)
  self.modules.module_cellWorldLevel2.bind.txt_name_now = tostring(targetLevel)
  self.modules.module_cellWorldLevel2.bind.txt_desc_now = _worldDifficultyTpl:getNote(targetTpl)
  self.modules.module_cellWorldLevel2.bind.go_choice = false
  self.modules.module_cellWorldLevel2.bind.go_now = true
  self.modules.module_cellWorldLevel2.bind.go_normal = false
  local curLevel = L_WorldLevelStore:getServerLevelInfo().cur_level
  local curTpl = _worldDifficultyTpl:getTplById(curLevel)
  self.modules.module_cellWorldLevel1.bind.txt_name_now = tostring(curLevel)
  self.modules.module_cellWorldLevel1.bind.txt_desc_now = _worldDifficultyTpl:getNote(curTpl)
  self.modules.module_cellWorldLevel1.bind.go_choice = false
  self.modules.module_cellWorldLevel1.bind.go_now = true
  self.modules.module_cellWorldLevel1.bind.go_normal = false
  local freeTime = L_WorldLevelStore:getFreeTime()
  if 0 < freeTime then
    self.bind.txt_canUp = L_WordsTpl:getValue("ui_pageWorldLevelConfirm_02")
  else
    self.bind.txt_canUp = ""
  end
end

function page:refreshTimer()
  self:resetTimer()
  self.bind.txt_time = ""
  self.go_lock = false
  local serverInfo = L_WorldLevelStore:getServerLevelInfo()
  local freeTime = L_WorldLevelStore:getFreeTime()
  if 0 < freeTime then
    self.bind.txt_time = L_WordsTpl:getValue("ui_pageWorldLevelConfirm_01") .. freeTime
    return
  end
  local setTime = serverInfo.set_time
  if math.isEmpty(setTime) then
    return
  end
  local cdTime = tonumber(L_GameConstTpl:getData("WORLD_DIFFICULT_CD", L_Const.GameTplType.int)) * 60
  local nowTime = L_TimeUtil:getServerTime()
  local leftTime = nowTime - setTime
  if cdTime < leftTime then
    return
  end
  self.go_lock = true
  
  local function refreshTxtTimeFunc()
    local nowTime = L_TimeUtil:getServerTime()
    local leftTime = nowTime - setTime
    if leftTime > cdTime then
      self:resetTimer()
      self:refreshPointList()
      return
    end
    self.bind.txt_time = L_WordsTpl:getValue("residual_code_pageworldlevelconfirm_01") .. L_TimeUtil.secondToString(cdTime - leftTime)
  end
  
  refreshTxtTimeFunc()
  self.timer = Timer.repeated(1, function()
    refreshTxtTimeFunc()
  end, self, self.gameObject)
end

function page:resetTimer()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
end

function page:delayPlay(animName, callback, timeScale)
  self.bindComponents.confirmAnimation:Play(animName)
  local clip = self.bindComponents.confirmAnimation:GetClip(animName)
  local delayTime = clip.length
  timeScale = timeScale or 1
  Timer.once(delayTime * timeScale, function()
    if callback then
      callback()
    end
  end, self)
end

function page:onClick_confirm()
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.ChangeWorldLevel))
    return
  end
  if self.go_lock then
  end
  if self.isClick then
    return
  end
  self.isClick = true
  L_WorldLevelStore:req_worldLevel(self.data.targetLevel, function()
    if self.data.worldLevelAnim then
      self.data.worldLevelAnim:Play("anim_worldlevel_Confirm1")
      L_WorldLevelStore:call(L_WorldLevelStore.event.animWorldLevel)
      self:delayPlay("anim_worldlevelconfirm_Confirm1", function()
        L_UI:close(self.pageName)
        L_UI:close("pageWorldLevel")
        self.isClick = false
      end)
    else
      L_WorldLevelStore:call(L_WorldLevelStore.event.animWorldLevel)
      self:delayPlay("anim_worldlevelconfirm_Confirm", function()
        L_UI:close(self.pageName)
        self.isClick = false
      end)
    end
  end)
end

function page:outBack()
  if self.outLock then
    return
  end
  self.outLock = true
  if self.data.worldLevelAnim then
    self:delayPlay("anim_worldlevelconfirm_out", function()
      L_UI:close(self.pageName)
    end)
    self.data.worldLevelAnim:Play("anim_worldlevel_show")
  else
    self:delayPlay("anim_worldlevelconfirm_out1", function()
      L_UI:close(self.pageName)
    end)
  end
end

return page
