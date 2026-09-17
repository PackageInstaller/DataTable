local module = class("cellHeroDramaItem", G_UIModuleBase)

function module.bind()
  return {
    plotImgAlpha = C_Color.white,
    unlockPlotName = "",
    unlockPlotChapter = "",
    lockedPlotName = "",
    lockedPlotChapter = "",
    plotImg = "",
    unlockTips = "",
    unlockNodeActive = false,
    taskBtnActive = false
  }
end

function module.methods()
  return {
    onClick_taskBtn = function(self)
      self.bind.new = false
      self.bindComponents.reddotNormal.gameObject:SetActive(false)
      if self:GetSourceLuaPageOptions("failure_jump") then
        L_FlyMsgManager:showNormalMsgByKey("common_jump_ban_tips")
        return
      end
      L_UI:open("pageTask", {
        taskId = self.bind.taskId
      })
    end
  }
end

function module:refresh()
  if not self.isBind then
    return
  end
  local charPlotTpl = L_GameTpl:getCharPlotTpl()
  local heroConfigId = self.bind.heroConfigId
  local index = self.bind.id
  self.bindComponents.reddotNormal.gameObject:SetActive(self.bind.new)
  local charTpl = charPlotTpl:getTplById(index)
  self.bind.taskId = charPlotTpl:getTaskId(charTpl)
  self.bind.plotId = charPlotTpl:getPlotId(charTpl)
  self.bind.unlockPlotName = charPlotTpl:getTitle(charTpl)
  self.bind.unlockPlotChapter = charPlotTpl:getEnglishNum(charTpl)
  self.bind.lockedPlotName = charPlotTpl:getTitle(charTpl)
  self.bind.lockedPlotChapter = charPlotTpl:getEnglishNum(charTpl)
  self.bind.plotImg = charPlotTpl:getPic(charTpl)
  local taskFinished = self:checkTaskFinished()
  self.bind.taskBtnActive = not taskFinished and self.bind.isUnlock
  self.bind.unlockNodeActive = not self.bind.isUnlock
  self.bind.taskId = charPlotTpl:getTaskId(charTpl)
  if self.bind.isUnlock then
    self.bind.plotImgAlpha = C_Color.white
  else
    self.bind.plotImgAlpha = C_Color(1, 1, 1, 0.5)
  end
end

function module:checkTaskFinished()
  local taskFinish = true
  if self.bind.taskId and self.bind.taskId ~= 0 then
    taskFinish = AzurWorld.TaskMgr:IsFinishTask(self.bind.taskId)
  end
  return taskFinish
end

return module
