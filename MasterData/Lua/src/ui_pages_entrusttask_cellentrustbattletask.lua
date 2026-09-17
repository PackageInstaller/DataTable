local this = class("cellEntrustBattleTask", G_UIModuleBase)

function this.bind()
  return {
    active_on = false,
    active_off = false,
    active_lock = false,
    img_finishStar = "",
    active_unlockMask = false,
    txt_taskName = "",
    txt_name = "",
    go_task_lock = nil,
    go_task = nil,
    img_select = nil
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      self:buttonClick()
    end
  }
end

function this:open()
  self.isClose = false
  self:initData()
  self:registerRedDot()
  self:refreshName()
  self:refreshLockState()
  self:refreshFinishStar()
  self:refreshRedDot()
end

function this:close()
  self.isClose = true
  if self.parent ~= nil then
    self.bind.active_unlockMask = false
    self.parent:refreshUnlockMaskItem()
  end
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

function this:initData()
  self.c_starLevel1 = "UI/Atlas/Page/EntrustTask/tex_dungeonentrust_icon_wz04.png"
  self.c_starLevel2 = "UI/Atlas/Page/EntrustTask/tex_dungeonentrust_icon_wz05.png"
  self.c_starLevel3 = "UI/Atlas/Page/EntrustTask/tex_dungeonentrust_icon_wz06.png"
end

function this:registerRedDot()
  self:registerReddot(self.bindComponents.reddotNew, string.format(L_ReddotManager.DotDef.EntrustBattleTask, self.bind.id), self.bind.reddotDesc, self.bind.reddotClickEvent)
end

function this:refreshName()
  self.bind.txt_taskName = self.bind.level_name
end

function this:IsLocked()
  return not self.bind.is_unlock or not self.bind.is_unlock_pre_level
end

function this:updateUnlockMask(showUnlockMask, itemCount, isLast)
  self.bind.active_unlockMask = showUnlockMask
  if showUnlockMask then
    local height = 103 * itemCount
    if isLast then
      height = height + 25
    end
    self.bindComponents.unlockMask.sizeDelta = L_Vector3.new(self.bindComponents.unlockMask.sizeDelta.x, height)
  end
end

function this:refreshLockState()
  if not self.bind.is_unlock or not self.bind.is_unlock_pre_level then
    self.bind.active_on = false
    self.bind.active_off = false
    self.bind.active_lock = not self.bind.active_on
  else
    self.bind.active_on = true
    self.bind.active_off = false
    self.bind.active_lock = not self.bind.active_on
    if self.bind.complete_star == 0 then
      self.bind.active_on = false
      self.bind.active_off = true
    elseif self.bind.complete_star == 1 then
      self.bind.img_finishStar = self.c_starLevel1
    elseif self.bind.complete_star == 2 then
      self.bind.img_finishStar = self.c_starLevel2
    elseif self.bind.complete_star == 3 then
      self.bind.img_finishStar = self.c_starLevel3
    end
  end
  if self.parent ~= nil then
    self.parent:refreshUnlockMaskItem()
  end
end

function this:getLevelId()
  return self.bind.id
end

function this:refreshRedDot()
  local ret = string.empty
  local state = self.bind.is_unlock and self.bind.is_unlock_pre_level
  if not L_ReddotManager:haveNew(L_ReddotManager.DotDef.EntrustBattleTask, self.bind.id) and self.bind.is_unlock_pre_level and self.bind.is_unlock then
    L_ReddotManager:markNew(L_ReddotManager.DotDef.EntrustBattleTask, self.bind.id)
    if self.bindComponents.reddotNew then
      self.bindComponents.reddotNew.gameObject:SetActive(false)
    end
  end
  if not L_ReddotManager:haveNew(L_ReddotManager.DotDef.EntrustBattleTask, self.bind.id) and state then
    self.bindComponents.reddotNew.gameObject:SetActive(true)
  else
    self.bindComponents.reddotNew.gameObject:SetActive(false)
  end
end

function this:refreshFinishStar()
  if not self.bind.is_unlock_pre_level then
    self.bind.go_task_lock = true
    self.bind.go_task = false
    self.bind.txt_name = L_WordsTpl:getValue("residual_code_cellentrustbattletask_01")
    return
  elseif not self.bind.is_unlock then
    self.bind.go_task_lock = true
    self.bind.go_task = false
    self.bind.txt_name = self.bind.lock_desc
    return
  end
  if self.bind.is_complete then
    self.bind.go_task_lock = false
    self.bind.go_task = true
  else
    self.bind.go_task_lock = false
    self.bind.go_task = false
  end
end

function this:refreshSelect(isSelect)
  self.bind.img_select = isSelect
end

function this:buttonClick()
  self.bind.onClickEvent(self.bind.id)
  if not L_ReddotManager:haveNew(L_ReddotManager.DotDef.EntrustBattleTask, self.bind.id) and self.bind.is_unlock_pre_level and self.bind.is_unlock then
    L_ReddotManager:markNew(L_ReddotManager.DotDef.EntrustBattleTask, self.bind.id)
    if self.bindComponents.reddotNew then
      self.bindComponents.reddotNew.gameObject:SetActive(false)
    end
  end
end

return this
