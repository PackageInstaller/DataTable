local CSTData = class("CSTData")
local CSTSkillData = require("Game.CommanderSkill.CSTSkillData")
local MAX_SLOT_NUM = 3

function CSTData:ctor(savingTreeMsg, fairyData)
  self.treeId = savingTreeMsg.id
  self.treeCfg = ConfigData.commander_skill[self.treeId]
  self.baseSkillDic = {}
  self.overloadSkillDic = {}
  self.fairyReplaceSkillDic = {}
  self.curSkillDic = {}
  self.skillDic = {}
  self.savingSkills = savingTreeMsg.skills
  self.fairyData = fairyData
  self.__isHaveFairSkill = false
  if fairyData ~= nil then
    self.fairyReplaceCSTSkillDic = fairyData:GetFairyReplacedCommanderSkill()
  end
  self:InitCSTAllSkillData()
  self:ApplyCSTSavingData()
end

function CSTData:InitCSTAllSkillData()
  for slotId, CSTSkillId in pairs(ConfigData.commander_skill_unlock.slotDefaultSkillIdDic[self.treeId]) do
    local CSTskillData = CSTSkillData.New(CSTSkillId)
    self.baseSkillDic[slotId] = CSTskillData
    self.skillDic[CSTskillData:GetCSTSkillRealSkilllId()] = CSTskillData
    if CSTskillData:IsCmdSkillUnlock() then
      self.curSkillDic[slotId] = CSTskillData
    end
  end
  for slotId, CSTSkillIdList in pairs(ConfigData.commander_skill_unlock.overloadSkillIdDic[self.treeId]) do
    self.overloadSkillDic[slotId] = {}
    for _, CSTSkillId in ipairs(CSTSkillIdList) do
      local CSTskillData = CSTSkillData.New(CSTSkillId)
      table.insert(self.overloadSkillDic[slotId], CSTskillData)
      self.skillDic[CSTskillData:GetCSTSkillRealSkilllId()] = CSTskillData
    end
  end
  if self.fairyReplaceCSTSkillDic ~= nil then
    for sSkillId, tSkillId in pairs(self.fairyReplaceCSTSkillDic) do
      local sCSTSkillData = self.skillDic[sSkillId]
      if sCSTSkillData ~= nil then
        local fCSTSkillLevel = self.fairyData:GetFairySkillLevelBySkillId(tSkillId)
        local CSTSkillId = ConfigData.commander_skill_unlock.realSkillId2CSTSIdDic[tSkillId]
        local CSTskillData = CSTSkillData.New(CSTSkillId, fCSTSkillLevel)
        if CSTskillData ~= nil and CSTskillData:GetCSTSkillRealSkilllId() ~= nil then
          self.fairyReplaceSkillDic[sSkillId] = CSTskillData
          self.skillDic[CSTskillData:GetCSTSkillRealSkilllId()] = CSTskillData
          self.__isHaveFairSkill = true
        end
      end
    end
  end
end

function CSTData:ApplyCSTSavingData(savingData)
  if self.savingSkills == nil and savingData == nil then
    return
  end
  if savingData == nil then
    savingData = {}
    for _, e in pairs(self.savingSkills) do
      local realSkillId = e.skillId
      local CSTskillData = self.skillDic[realSkillId]
      if CSTskillData ~= nil then
        local slotIndex = CSTskillData:GetCSTSkillSlot()
        savingData[slotIndex] = realSkillId
      end
    end
  end
  for slotIndex, realSkillId in pairs(savingData) do
    local CSTskillData = self.skillDic[realSkillId]
    if self.skillDic[realSkillId] ~= nil then
      self.curSkillDic[slotIndex] = CSTskillData
    end
  end
end

function CSTData:GetCSTTreeId()
  return self.treeId
end

function CSTData:GetCSTSavingData()
  local savingTreeMsg = {}
  local skills = {}
  savingTreeMsg.id = self:GetCSTTreeId()
  savingTreeMsg.skills = skills
  for slotIndex = 1, MAX_SLOT_NUM do
    local cstSkillData = self.curSkillDic[slotIndex]
    if cstSkillData ~= nil then
      local realSkillId = cstSkillData:GetCSTSkillRealSkilllId()
      local isReplace = cstSkillData:IsFairyReplaceSKill()
      local level = cstSkillData:GetCSTSkillLevel()
      table.insert(savingTreeMsg.skills, {
        skillId = realSkillId,
        replaced = isReplace,
        lv = level
      })
    end
  end
  return savingTreeMsg
end

function CSTData:GetFairy4CST()
  return self.fairyData
end

function CSTData:GetUsingCmdSkillList()
  local skillIdList = {}
  for slotIndex = 1, MAX_SLOT_NUM do
    local cstSkillData = self.curSkillDic[slotIndex]
    if cstSkillData ~= nil then
      table.insert(skillIdList, cstSkillData:GetCSTSkillRealSkilllId())
    end
  end
  return skillIdList
end

function CSTData:IsCmdTreeUnlock()
  return CheckCondition.CheckLua(self.treeCfg.pre_condition, self.treeCfg.pre_para1, self.treeCfg.pre_para2)
end

function CSTData:GetCmdSkillTreeUnlockInfo()
  return CheckCondition.GetUnlockInfoLua(self.treeCfg.pre_condition, self.treeCfg.pre_para1, self.treeCfg.pre_para2)
end

function CSTData:GetCSTName()
  return LanguageUtil.GetLocaleText(self.treeCfg.name)
end

function CSTData:GetCSTOverloadSkillDic()
  return self.overloadSkillDic
end

function CSTData:GetCSTCurSkillDataBySlot(slotIndex)
  return self.curSkillDic[slotIndex]
end

function CSTData:GetCSTFairyReplaceSkillDataByRealSkillId(realSkillId)
  return self.fairyReplaceSkillDic[realSkillId]
end

function CSTData:GetCSTFairyReplaceSkill()
  return self.__isHaveFairSkill
end

function CSTData:CSTHasOverloadSkill2Install()
  local hasOverloadSkill2Install = false
  for slotIndex = 1, MAX_SLOT_NUM do
    local cstSkillData = self.curSkillDic[slotIndex]
    if cstSkillData ~= nil then
      local defaultSkillId = ConfigData.commander_skill_unlock.slotDefaultSkillIdDic[self.treeId][slotIndex]
      if cstSkillData:GetCSTSId() == defaultSkillId then
        for _, cstSkillData in ipairs(self.overloadSkillDic[slotIndex]) do
          if cstSkillData ~= nil and cstSkillData:IsCmdSkillUnlock() then
            hasOverloadSkill2Install = true
            break
          end
        end
      end
      if hasOverloadSkill2Install then
        break
      end
    end
  end
  return hasOverloadSkill2Install
end

function CSTData:SetCSTSkill(slot, realSkillId)
  local cstSkillData = self.skillDic[realSkillId]
  self.curSkillDic[slot] = cstSkillData
  local isReplace = cstSkillData:IsFairyReplaceSKill()
  if self.savingSkills == nil then
    error("打印之前不好定位的问题:" .. debug.traceback())
    self.savingSkills = {}
  end
  if self.savingSkills[slot] == nil then
    self.savingSkills[slot] = {}
  end
  self.savingSkills[slot].skillId = realSkillId
  self.savingSkills[slot].replaced = isReplace
  self.savingSkills[slot].lv = cstSkillData:GetCSTSkillLevel()
end

function CSTData:GetCSTDafaultSkillDataBySlot(slotId)
  return self.baseSkillDic[slotId]
end

return CSTData
