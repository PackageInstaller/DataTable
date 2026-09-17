local cls = class("pagePetDuelSelectSkill", G_UIPageBase)
local _skillTpl = L_GameTpl:getSkillTpl()
local _skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local _kiboDuelskillTpl = L_GameTpl:getKiboDuelSkillTpl()
local tmpSelectSkills = {}
local isChanged = false

function cls.bind()
  return {
    scrollList_heroSkill = {
      moduleName = "pages/petDuelOutside/cellIconPetDuelSkill"
    },
    scrollList_heroSkill_initItemIndex = 1,
    txt_skillName = nil,
    txt_skillDes = nil,
    active_btn_save_grey = false,
    active_btn_save_black = false
  }
end

function cls.methods()
  return {
    onClick_save = function(self)
      self:OnBtnSave()
    end,
    onClick_save_grey = function(self)
      self:OnBtnSaveRefuse()
    end,
    onClick_back = function(self)
      self:OnBtnClose()
    end
  }
end

function cls:preOpen(options)
  cls.super.preOpen(self, options)
  self.levelId = options.levelId
  self.selectSkillId = options.selectSkillId
  self.callback = options.callback
  self.closecallback = options.closecallback
  self.curFormationHeroSkillData = options.curFormationHeroSkillData
  for _, v in ipairs(self.curFormationHeroSkillData) do
    table.insert(tmpSelectSkills, {
      skillId = v.skill_id,
      slotId = self:getSkillSlot(v.skill_id)
    })
  end
  self.bind.scrollList_heroSkill_initItemIndex = self:getSkillSlot(self.selectSkillId)
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

function cls:getTmpSkillSlot(skillId)
  for idx = 1, #tmpSelectSkills do
    if tmpSelectSkills[idx].skillId == skillId then
      return tmpSelectSkills[idx].slotId
    end
  end
  return -1
end

function cls:refreshHeroSkillGridView()
  local function onClickHeroSkillCell(cell)
    if self.selectSkillId ~= cell.bind.skillId then
      L_AudioUtil.playSound("Play_SFX_System_QiboChallenge_Skill_Select")
    end
    if #tmpSelectSkills == 0 then
      table.insert(tmpSelectSkills, {
        skillId = cell.bind.skillId,
        slotId = 1
      })
    elseif #tmpSelectSkills == 1 then
      if tmpSelectSkills[1].skillId == cell.bind.skillId then
        table.remove(tmpSelectSkills, 1)
      else
        table.insert(tmpSelectSkills, {
          skillId = cell.bind.skillId,
          slotId = 2
        })
      end
    elseif tmpSelectSkills[1].skillId == cell.bind.skillId then
      table.remove(tmpSelectSkills, 1)
      tmpSelectSkills[1].slotId = 1
    elseif tmpSelectSkills[2].skillId == cell.bind.skillId then
      table.remove(tmpSelectSkills, 2)
    else
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_duel_ui_01"))
    end
    self.selectSkillId = cell.bind.skillId
    self:refreshSkillInfo()
    self:setHeroSkillListActive()
    self:refreshSkillListSlots()
    L_ReddotManager:clearNew(L_ReddotManager.DotDef.kiBoDuel_Skill_New, self.selectSkillId)
  end
  
  local petDuelStore = L_PetDuelStore
  local skillPool = petDuelStore:getCanUseSkillPool()
  local skillInfos = {}
  for _, v in ipairs(skillPool) do
    if petDuelStore:isUnlockSkill(v) or _kiboDuelskillTpl:isDefaultSkill(v) then
      table.insert(skillInfos, {
        skillId = v,
        levelId = self.levelId,
        cellMode = L_PetConst.PetDuelSkillCellMode.SelectView,
        callback = onClickHeroSkillCell,
        slotId = self:getTmpSkillSlot(v),
        reddotKey = string.format(L_ReddotManager.DotDef.kiBoDuel_Skill_New, v)
      })
    end
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
  self.bind.active_btn_save_grey = #tmpSelectSkills ~= 2
  self.bind.active_btn_save_black = #tmpSelectSkills == 2 and self:checkIfSkillsChanged()
end

function cls:setHeroSkillListActive()
  for i, v in pairs(self.modules.scrollList_heroSkill) do
    v:setSelectState(v.bind.skillId == self.selectSkillId)
  end
end

function cls:checkIfSkillsChanged()
  for index, v in ipairs(self.curFormationHeroSkillData) do
    if tmpSelectSkills[index].skillId ~= v.skill_id then
      return true
    end
  end
  return false
end

function cls:refreshSkillListSlots()
  for _, v in pairs(self.modules.scrollList_heroSkill) do
    v:setSlot(self:getTmpSkillSlot(v.skillId))
  end
end

function cls:OnBtnSave()
  self.callback(tmpSelectSkills)
  L_UI:close(self.pageName)
end

function cls:OnBtnSaveRefuse()
  L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_duel_ui_02"))
end

function cls:OnBtnClose()
  if #tmpSelectSkills == 2 and self:checkIfSkillsChanged() then
    L_GameUtil.showCommonTip({
      txtContent = L_WordsTpl:getValue("notice_kibo_duel_ui_03"),
      confirmCallback = function()
        L_UI:close(self.pageName)
      end
    })
  else
    L_UI:close(self.pageName)
  end
end

function cls:close(options)
  cls.super.close(self, options)
  self.closecallback()
  tmpSelectSkills = {}
end

return cls
