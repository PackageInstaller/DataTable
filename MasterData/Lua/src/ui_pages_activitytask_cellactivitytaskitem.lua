local item = class("cellActivityTaskItem", G_UIModuleBase)
local _achievementTpl = L_GameTpl:getAchievementTpl()
local qualityList = {
  "BRONZE",
  "SILVER",
  "GOLD",
  "PLATINUM"
}

function item.bind()
  return {
    taskDescribe = "",
    currentCount = "",
    totalCount = "",
    txt_rewardNum = "",
    txt_rewardNum1 = "",
    txt_rewardNum2 = "",
    currentPercent = 0,
    finishBg = false,
    finishIcon = false,
    rewardList = L_Const.ModuleInfo.CellIconBag,
    show_receiveBtn = false,
    show_progressing = false,
    txt_progress = L_WordsTpl:getValue("ui_cellNoviceTaskItem_03"),
    show_goto = false,
    targetBgAlpha = C_Color(0.1568627450980392, 0.17254901960784313, 0.1843137254901961, 1),
    taskNumBg = true,
    taskDescGo = true,
    taskFinishBg = true,
    txt_receive = L_WordsTpl:getValue("ui_cellNoviceTaskItem_06"),
    go_sel = false,
    go_achieveDes = false,
    txt_achieveTitle = "",
    txt_achieveDes = "",
    go_Achievefinish = false,
    txt_finishTime = "",
    go_track = false,
    go_trophy = false,
    img_trophy = "",
    txt_quality = ""
  }
end

function item.methods()
  return {
    onClick_receive = function(self)
      self:emit("onClick_receive", self.bind)
      self:onClick()
    end,
    onClick_goto = function(self)
      L_JumpMgr:jumpTo(self.bind.systemId)
    end,
    onClick = function(self)
      self:emit("onClick", self.bind.index)
    end
  }
end

function item:hide()
end

function item:close()
end

function item:open()
end

function item:refresh()
  if self.bind.bAchieve then
    self.bind.taskDescGo = false
    self.bind.go_achieveDes = true
    self.bind.finishBg = false
    self:resfreshAchieveData()
  else
    self.bind.taskDescGo = true
    self.bind.go_achieveDes = false
    self:updateTaskData()
  end
end

function item:resfreshAchieveData()
  local tpl = _achievementTpl:getTplById(self.bind.id)
  self.bind.txt_achieveTitle = _achievementTpl:getAchiName(tpl)
  local desc = _achievementTpl:getAchiDesc(tpl)
  local progress
  local AchiveInfo = L_AchievementUtil.getAchievementItem(self.bind.id)
  self.bind.txt_rewardNum = tostring(_achievementTpl:getAchiPoint(tpl))
  if self.bind.txt_rewardNum2 then
    self.bind.txt_rewardNum2 = tostring(_achievementTpl:getAchiPoint(tpl))
  end
  if self.bind.txt_rewardNum1 then
    self.bind.txt_rewardNum1 = tostring(_achievementTpl:getAchiPoint(tpl))
  end
  self:refreshSel(self.bind.index == self.bind.selIndex)
  local reward = L_DataUtil.parseRangeRewardConfig(_achievementTpl:getReward(tpl))
  local finish = L_AchievementUtil.getStore():GetIsAchievementCompleted(self.bind.id)
  if finish then
    self.bind.show_progressing = false
    self.bind.go_Achievefinish = true
    local timeStr = L_TimeUtil.getDisplayTime(L_AchievementUtil.getStore():GetFinishTime(self.bind.id), L_TimeUtil.TimeFormat.YMD)
    timeStr = string.gsub(timeStr, "-", ".")
    self.bind.txt_finishTime = timeStr
    for key, value in pairs(reward) do
      value.isReceived = true
    end
  else
    self.bind.go_Achievefinish = false
    self:refreshTrack(self.bind.bTrack)
    for key, value in pairs(reward) do
      value.isReceived = false
    end
  end
  if finish then
    self.bind.currentPercent = tpl.param / tpl.param
    progress = "(" .. tpl.param .. "/" .. tpl.param .. ")"
  elseif AchiveInfo then
    local achieveCount = 0
    local finishCondition = tpl.finishCondition or ""
    if string.find(finishCondition, "&&") then
      for _, v in ipairs(AchiveInfo.count) do
        achieveCount = achieveCount + (v or 0)
      end
    elseif string.find(finishCondition, "||") then
      for _, v in ipairs(AchiveInfo.count) do
        if achieveCount < (v or 0) then
          achieveCount = v
        end
      end
    else
      achieveCount = AchiveInfo.count[1] or 0
    end
    self.bind.currentPercent = achieveCount / tpl.param
    progress = "(" .. achieveCount .. "/" .. tpl.param .. ")"
  else
    self.bind.currentPercent = 0
    progress = "(" .. "0" .. "/" .. tpl.param .. ")"
  end
  self.bind.txt_achieveDes = desc .. progress
  self.bind.rewardList:clear()
  self.bind.rewardList:insert_array(reward)
  self.bind.go_trophy = true
  self.bind.img_trophy = "Page/Achievement/tex_icon_achievement_quality" .. tpl.achiLevel
  if self.bind.txt_quality then
    self.bind.txt_quality = qualityList[tpl.achiLevel]
  end
  if self.bind.bRecentAchieve then
    self.bind.currentPercent = 0
  end
end

function item:refreshSel(bSel)
  self.bind.go_sel = bSel
end

function item:refreshTrack(bTrack)
  self.bind.go_track = bTrack
  if bTrack then
    self.bind.show_progressing = false
  else
    self.bind.show_progressing = true
  end
end

function item:updateTaskData()
  local tpl = L_GameTpl:getActivityTpl():getTplById(self.bind.curActivityId)
  if self.bindComponents.txt_num then
    self.bindComponents.txt_num.text = tostring(L_GameTpl:getActivityTpl():getReward(tpl))
  end
  if self.bind.txt_rewardNum1 then
    self.bind.txt_rewardNum1 = L_GameTpl:getActivityTpl():getReward(tpl)
  end
  if self.bind.txt_rewardNum2 then
    self.bind.txt_rewardNum2 = L_GameTpl:getActivityTpl():getReward(tpl)
  end
  self.bind.rewardList:clear()
  if math.isEmpty(self.bind.curActivityId) then
    self.bind.taskNumBg = false
    self.bind.taskDescGo = true
    self.bind.taskDescribe = L_WordsTpl:getValue("ui_cellNoviceTaskItem_04")
    self.bind.taskFinishBg = false
    self.bind.show_progressing = false
    self.bind.show_goto = false
    self.bind.finishBg = false
    self.bind.txt_receive = L_WordsTpl:getValue("ui_cellNoviceTaskItem_05")
    self.bind.show_receiveBtn = true
  else
    if self.bind.finishState == 2 then
      self.bind.finishBg = true
      self.bind.show_receiveBtn = false
      self.bind.show_progressing = false
      self.bind.show_goto = false
      self.bind.targetBgAlpha = C_Color(1, 1, 1, 0.5)
    elseif self.bind.finishState == 0 then
      self.bind.finishBg = false
      self.bind.show_receiveBtn = false
      self.bind.targetBgAlpha = C_Color(1, 1, 1, 1)
      self:checkSystemJump()
    elseif self.bind.finishState == 1 then
      self.bind.show_receiveBtn = true
      self.bind.finishBg = false
      self.bind.show_progressing = false
      self.bind.show_goto = false
      self.bind.targetBgAlpha = C_Color(1, 1, 1, 1)
    end
    if self.bind.itemReward then
      local base_data = {}
      local rewardData = L_DataUtil.parseRewardConfig(self.bind.itemReward)
      for i, v in ipairs(rewardData) do
        table.insert(base_data, {
          itemId = v.itemId,
          itemType = v.itemType,
          itemNum = v.itemNum,
          isReceived = self.bind.finishState == 2
        })
      end
      self.bind.rewardList:insert_array(base_data)
    end
    local desc = self.bind.describe
    local colorTxt = self.bind.index == 1 and "#24344e" or "#564320"
    if self.bind.finishState == 1 then
      self.bind.count = self.bind.targetCount
    end
    local str = string.format("<color=%s>(%d/%d)</color>", colorTxt, self.bind.count, self.bind.targetCount)
    self.bind.taskDescribe = string.format("%s%s", desc, str)
    self.bind.currentPercent = self.bind.finishState == 2 and 0 or self.bind.count / self.bind.targetCount
  end
  self.bind.finishIcon = self.bind.finishBg
end

function item:checkSystemJump()
  if math.isEmpty(self.bind.systemId) then
    self.bind.show_goto = false
    self.bind.txt_progress = L_WordsTpl:getValue("ui_cellNoviceTaskItem_03")
    self.bind.show_progressing = true
  elseif L_JumpMgr:checkJumpFuncOpen(self.bind.systemId) then
    self.bind.show_progressing = false
    self.bind.show_goto = true
  else
    self.bind.show_goto = false
    self.bind.txt_progress = L_WordsTpl:getValue("ui_cellNoviceTaskItem_02")
    self.bind.show_progressing = true
  end
end

function item:onClick()
  if not self.isBind then
    return
  end
  if self.bindComponents.cellAni then
    self.bindComponents.cellAni:Stop()
    self.bindComponents.cellAni:Play("anim_AT_cell2_finish")
    self.bind.show_receiveBtn = false
    self.bind.show_progressing = false
    self.bind.show_goto = false
  end
end

return item
