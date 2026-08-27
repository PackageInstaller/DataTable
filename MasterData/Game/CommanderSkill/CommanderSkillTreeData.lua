local CommanderSkillTreeData = class("CommanderSkillTreeData")
local CommanderSkillData = require("Game.CommanderSkill.CommanderSkillData")
local CommanderSkillTreeColor = {
  [1] = Color.New(0.8196078431372549, 0.21568627450980393, 0.3058823529411765),
  [2] = Color.New(0.57, 0.82, 0.16, 1),
  [3] = Color.New(0.21568627450980393, 0.5411764705882353, 0.9019607843137255),
  [4] = Color.New(0.49, 0.54, 0.63, 1)
}

function CommanderSkillTreeData.CreateCstData(treeId, skillIdList)
  local cstData = CommanderSkillTreeData.New(treeId)
  cstData:ApplySavingData(skillIdList)
  return cstData
end

function CommanderSkillTreeData:ctor(treeId)
  self.treeId = treeId
  if ConfigData.commander_skill[treeId] == nil then
    error("can't read commander_skill by id:" .. tostring(treeId))
    return
  end
  self.treeCfg = ConfigData.commander_skill[treeId]
  self.commanderSkillDataDic = {}
  self.slotSkillList = {
    [1] = 0,
    [2] = 0,
    [3] = 0
  }
  self.slotSkillOverloadList = {
    [1] = {},
    [2] = {},
    [3] = {}
  }
  local skillDicCfg = ConfigData.commander_skill_unlock[treeId]
  for skillId, skillCfg in pairs(skillDicCfg) do
    local commanderSkillData = CommanderSkillData.New(skillId, skillCfg)
    commanderSkillData:InitCmdSkillData(skillCfg.skill_type, skillCfg.place)
    self.commanderSkillDataDic[skillId] = commanderSkillData
    if skillCfg.skill_type == CommanderSkillData.skillType.active then
      table.insert(self.slotSkillOverloadList[skillCfg.place], skillId)
      local isUnlock = commanderSkillData:IsCmdSkillUnlock()
      if isUnlock and self.slotSkillList[skillCfg.place] == 0 then
        self.slotSkillList[skillCfg.place] = commanderSkillData.dataId
      end
    end
  end
  self:__SortSkill()
end

function CommanderSkillTreeData:IsCmdTreeUnlock()
  return CheckCondition.CheckLua(self.treeCfg.pre_condition, self.treeCfg.pre_para1, self.treeCfg.pre_para2)
end

function CommanderSkillTreeData:GetCmdSkillTreeUnlockInfo()
  return CheckCondition.GetUnlockInfoLua(self.treeCfg.pre_condition, self.treeCfg.pre_para1, self.treeCfg.pre_para2)
end

function CommanderSkillTreeData:SetSlotSkillList(place, skillId)
  self.slotSkillList[place] = skillId
  MsgCenter:Broadcast(eMsgEventId.OnCommanderSkillOverLoad, place, self.commanderSkillDataDic[skillId])
end

function CommanderSkillTreeData:GetName()
  return LanguageUtil.GetLocaleText(self.treeCfg.name)
end

function CommanderSkillTreeData:GetIcon()
  local icon = self.treeCfg.icon
  return icon
end

function CommanderSkillTreeData:GetColor()
  local colorIndex = self.treeCfg.color
  if colorIndex < 1 or 4 < colorIndex then
    return CommanderSkillTreeColor[4]
  end
  return CommanderSkillTreeColor[colorIndex]
end

function CommanderSkillTreeData:GetDescribe()
  return LanguageUtil.GetLocaleText(self.treeCfg.describe)
end

function CommanderSkillTreeData:GetUnlockNum(index)
  local totalNum = #self.slotSkillOverloadList[index]
  local unlockNum = 0
  for _, skillId in ipairs(self.slotSkillOverloadList[index]) do
    if self.commanderSkillDataDic[skillId]:IsCmdSkillUnlock() then
      unlockNum = unlockNum + 1
    end
  end
  return totalNum, unlockNum
end

function CommanderSkillTreeData:__SortSkill()
  for place, list in ipairs(self.slotSkillOverloadList) do
    table.sort(list, sortFunc)
    local skillId = list[1]
    local skillData = self.commanderSkillDataDic[skillId]
    if skillData ~= nil then
      skillData:SetCmdSkillSlotDefault()
    end
  end
end

function CommanderSkillTreeData:GetActiveSlotCurSkill(slotIndex)
  if self.slotSkillList[slotIndex] ~= nil then
    return self.slotSkillList[slotIndex]
  else
    return 0
  end
end

function CommanderSkillTreeData:GetActiveSlotOverloadSkill(slotIndex)
  if self.slotSkillOverloadList[slotIndex] ~= nil then
    return self.slotSkillOverloadList[slotIndex]
  else
    return {}
  end
end

function CommanderSkillTreeData:ApplySavingData(cstSkillList)
  local skillDicCfg = ConfigData.commander_skill_unlock[self.treeId]
  for _, skillId in ipairs(cstSkillList) do
    local cmdSkillData = self.commanderSkillDataDic[skillId]
    if cmdSkillData ~= nil then
      self.slotSkillList[cmdSkillData.place] = skillId
    end
  end
end

function CommanderSkillTreeData:GetUsingCmdSkillList()
  local list = {}
  for _, skillId in ipairs(self.slotSkillList) do
    if skillId ~= 0 then
      table.insert(list, skillId)
    end
  end
  return list
end

function CommanderSkillTreeData:CSTHasOverloadSkill2Install()
  local hasOverloadSkill2Install = false
  for index, skillId in ipairs(self.slotSkillList) do
    local skillData = self.commanderSkillDataDic[skillId]
    if skillData ~= nil and skillData:CmdSkillIsSlotDefault() then
      for _, overloadeSkillId in ipairs(self.slotSkillOverloadList[index]) do
        if overloadeSkillId ~= skillId and self.commanderSkillDataDic[overloadeSkillId]:IsCmdSkillUnlock() then
          hasOverloadSkill2Install = true
          break
        end
      end
    end
  end
  return hasOverloadSkill2Install
end

return CommanderSkillTreeData
