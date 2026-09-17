local cls = class("cellEntrustTask", G_UIModuleBase)
local _dungeonEntrustTpl = L_GameTpl:getDungeonEntrustTpl()
local StarIconEnum = {
  [3] = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_wz06.png",
  [2] = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_wz05.png",
  [1] = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_wz04.png"
}
local TaskTargetIconEnum = {
  [1] = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_2yh01.png",
  [2] = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_2yh02.png",
  [3] = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_2yh03.png",
  [4] = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_2yh04.png",
  [5] = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_2yh04.png",
  [6] = "UI/Atlas/EntrustTask/tex_dungeonentrust_icon_2yh04.png"
}
local TaskTargetEnum = {
  [1] = L_WordsTpl:getValue("residual_code_cellentrusttask_01"),
  [2] = L_WordsTpl:getValue("residual_code_cellentrusttask_02"),
  [3] = L_WordsTpl:getValue("residual_code_cellentrusttask_03"),
  [4] = L_WordsTpl:getValue("residual_code_cellentrusttask_04"),
  [5] = L_WordsTpl:getValue("residual_code_cellentrusttask_05"),
  [6] = L_WordsTpl:getValue("residual_code_cellentrusttask_06")
}

function cls.bind()
  return {
    selectTab = -1,
    img_starNum = "",
    img_mainReward = "",
    img_mainReward2 = "",
    txt_levelName = "",
    txt_level = "",
    toggle_unlock = true,
    list_levelTag = {
      moduleName = "pages/entrustTask/cellEntrustTaskTag"
    },
    moduleRewardUp = {
      moduleName = "pages/gameAct/doubleDrop/moduleRewardUp"
    },
    txt_unlockCondition = "",
    go_select = false,
    active_taskTarget = false,
    img_taskType = "",
    txt_taskType = "",
    active_tag = false,
    active_unlockMask = false,
    active_leveltxt = false,
    active_mainReward = false,
    active_mainReward2 = false
  }
end

function cls.methods()
  return {
    onClick_select = function(self)
      if self.bind.cbk then
        self.bind.cbk(self)
      end
    end
  }
end

function cls:refresh()
  self.dungeonEntrustCfg = _dungeonEntrustTpl:getTplById(self.bind.levelId)
  self.bind.txt_levelName = _dungeonEntrustTpl:getName(self.dungeonEntrustCfg)
  self:refreshUnlockCondition()
  self:refreshFinishStatus()
  self:refreshTagList()
  self:setSelected(self.bind.levelId == self.bind.selectEntrustTaskId)
  if self.bind.isTaskTarget == true then
    self.bind.active_taskTarget = self.bind.selectTab ~= 1
    self.bind.img_taskType = TaskTargetIconEnum[self.bind.taskType]
    self.bind.txt_taskType = TaskTargetEnum[self.bind.taskType]
  end
end

function cls:refreshFinishStatus()
  if not self.unlock then
    return
  end
  local starNum = L_EntrustStore:getEntrustLevelStar(self.bind.levelId)
  self.bind.selectTab = 0 < starNum and 1 or 2
  if 0 < starNum then
    self.bind.img_starNum = StarIconEnum[starNum]
  end
end

function cls:refreshTagList()
  local info = {}
  local tag = _dungeonEntrustTpl:getTag(self.dungeonEntrustCfg)
  if tag then
    for i = #tag, 1, -1 do
      table.insert(info, {
        id = tag[i]
      })
    end
    if self.modules.moduleRewardUp:setEntrustType(tag) then
      self.bind.active_tag = true
    else
      self.bind.active_tag = false
    end
  end
end

function cls:refreshUnlockCondition()
  local isComplete, strTips = L_EntrustStore:checkEntrustLevelUnlock(self.bind.levelId)
  self.unlock = isComplete
  if not isComplete then
    self.bind.selectTab = 3
  end
  self.bind.toggle_unlock = isComplete
  if not isComplete then
    self.bind.txt_unlockCondition = strTips
  end
  if not self.unlock then
    self.bind.active_unlockMask = true
    self.bind.active_leveltxt = false
    self.bind.active_mainReward = false
    self.bind.active_mainReward2 = false
    if self.bind.active_unlockMask and self.bind.lock_bg_length then
      self.bindComponents.unlockMask.sizeDelta = L_Vector3.new(self.bindComponents.unlockMask.sizeDelta.x, 90 * self.bind.lock_bg_length)
    else
      self.bind.active_unlockMask = false
      self.bindComponents.unlockMask.sizeDelta = L_Vector3.new(self.bindComponents.unlockMask.sizeDelta.x, 0)
    end
  else
    self.bind.active_leveltxt = true
    self.bind.txt_level = L_WordsTpl:getValue("residual_code_cellentrusttask_07") .. tostring(_dungeonEntrustTpl:getRecommendLevel(self.dungeonEntrustCfg))
    local mainReward = _dungeonEntrustTpl:getMainRewardShow(self.dungeonEntrustCfg)
    if mainReward then
      local item = L_ItemTplManager:getItemConfig(mainReward[1].itemType, mainReward[1].itemId)
      if item then
        self.bind.active_mainReward = true
        self.bind.img_mainReward = item.icon
      end
      if mainReward[2] then
        local item2 = L_ItemTplManager:getItemConfig(mainReward[2].itemType, mainReward[2].itemId)
        if item2 then
          self.bind.active_mainReward2 = true
          self.bind.img_mainReward2 = item2.icon
        end
      end
    end
  end
end

function cls:setSelected(bSelect)
  self.bind.go_select = bSelect
end

function cls:close(options)
  cls.super.close(self, options)
end

return cls
