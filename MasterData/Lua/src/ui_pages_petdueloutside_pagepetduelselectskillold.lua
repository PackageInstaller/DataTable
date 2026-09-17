local cls = class("pagePetDuelSelectSkillOld", G_UIPageBase)
local _skillTpl = L_GameTpl:getSkillTpl()
local _skillLevelTpl = L_GameTpl:getSkillLevelTpl()

function cls.bind()
  return {
    scrollList_heroSkill = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelSkill"
    },
    scrollList_heroSkill_initItemIndex = 1,
    txt_skillName = nil,
    txt_skillDes = nil,
    active_btn_choose = false,
    active_btn_used = false,
    txt_btn_tips = nil
  }
end

function cls.methods()
  return {
    onClick_choose = function(self)
      self:onBtnChoose()
    end,
    onClick_back = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function cls:preOpen(options)
  cls.super.preOpen(self, options)
  self.levelId = options.levelId
  self.defaultSkillId = options.selectSkillId
  self.selectSkillId = options.selectSkillId
  self.callback = options.callback
  self.curFormationHeroSkillData = options.curFormationHeroSkillData
  self.bind.scrollList_heroSkill_initItemIndex = self:getSkillSlot(self.defaultSkillId)
  self:refreshHeroSkillGridView()
end

function cls:getSkillSlot(skillId)
  for slot, v in ipairs(self.curFormationHeroSkillData) do
    if v.skill_id == skillId then
      return slot
    end
  end
  return -1
end

function cls:refreshHeroSkillGridView()
  local function onClickHeroSkillCell(cell)
    print("testest")
    
    if self.selectSkillId ~= cell.bind.skillId then
      L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Skill_Select")
    end
    self.selectSkillId = cell.bind.skillId
    self:refreshSkillInfo()
    self:setHeroSkillListActive()
  end
  
  local skillPool = L_PetDuelStore:getCanUseSkillPool()
  local skillInfos = {}
  for _, v in ipairs(skillPool) do
    table.insert(skillInfos, {
      skillId = v,
      levelId = self.levelId,
      cellMode = L_PetConst.PetDuelSkillCellMode.SelectView,
      callback = onClickHeroSkillCell,
      slotId = self:getSkillSlot(v)
    })
  end
  if #skillPool % 2 == 1 then
    table.insert(skillInfos, 1, {skillId = 0})
    table.insert(skillInfos, {skillId = 0})
  end
  self.bind.scrollList_heroSkill:clear()
  self.bind.scrollList_heroSkill:insert_array(skillInfos)
  self:setHeroSkillListActive()
  self:refreshSkillInfo()
end

function cls:refreshSkillInfo()
  local skillCfg = _skillTpl:getTplById(self.selectSkillId)
  self.bind.txt_skillName = _skillTpl:getName(skillCfg)
  local skillLevelCfg = _skillLevelTpl:getTplByIdAndLevel(self.selectSkillId, 1)
  self.bind.txt_skillDes = _skillLevelTpl:getSkillDescribe(skillLevelCfg)
  self.bind.active_btn_choose = self.selectSkillId ~= self.defaultSkillId
  self.bind.active_btn_used = self.selectSkillId == self.defaultSkillId
  if self.selectSkillId ~= self.defaultSkillId then
    if self:getSkillSlot(self.selectSkillId) > 0 then
      self.bind.txt_btn_tips = L_WordsTpl:getValue("ui_pagePetDuelSelectSkill")
    else
      self.bind.txt_btn_tips = L_WordsTpl:getValue("ui_pagePetBoxSelect_04")
    end
  end
end

function cls:setHeroSkillListActive()
  for i, v in pairs(self.modules.scrollList_heroSkill) do
    v:setSelectState(v.bind.skillId == self.selectSkillId)
  end
end

function cls:onBtnChoose()
  self.callback(self.defaultSkillId, self.selectSkillId)
  L_UI:close(self.pageName)
end

function cls:close(options)
  cls.super.close(self, options)
end

return cls
