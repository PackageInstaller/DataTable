local cls = class("cellIconPetDuelSkill", G_UIModuleBase)
local _skillTpl = L_GameTpl:getSkillTpl()
local _skillLevelTpl = L_GameTpl:getSkillLevelTpl()

function cls.bind()
  return {
    active_root_banned = false,
    active_root_tag = false,
    txt_slot = nil,
    img_skillIcon = nil,
    active_selectImg = false
  }
end

function cls.methods()
  return {
    onClick_select = function(self)
      if self.bind.callback then
        self.bind.callback(self)
      end
    end
  }
end

function cls:refresh()
  self.cellMode = self.bind.cellMode
  self.skillId = self.bind.skillId
  self.levelId = self.bind.levelId
  self.slotId = self.bind.slotId
  self.callback = self.bind.callback
  self.alwaysShow = self.bind.alwaysShow
  if math.isEmpty(self.skillId) then
    L_CommonUtil.setObjActive(self.gameObject, false)
    return
  end
  L_CommonUtil.setObjActive(self.gameObject, true)
  self:refreshView()
  if self.bind.reddotKey and self.bindComponents.reddotNew then
    L_ReddotManager:registerReddot(self.bindComponents.reddotNew, self.bind.reddotKey)
  end
end

function cls:refreshView()
  local skillCfg = _skillTpl:getTplById(self.skillId)
  self.bind.img_skillIcon = _skillTpl:getBattleSkillIcon(skillCfg)
  local showTag = self.cellMode == L_PetConst.PetDuelSkillCellMode.SelectView and self.slotId > 0
  if showTag then
    self.bind.txt_slot = tostring(self.slotId)
  end
  self.bind.active_root_tag = showTag
  if not self.alwaysShow then
    self.bind.active_root_banned = not L_PetDuelStore:checkSkillCanUse(self.levelId, self.skillId)
  else
    self.bindComponents.reddotNew.gameObject:SetActive(false)
  end
end

function cls:getSkillName()
  local skillCfg = _skillTpl:getTplById(self.skillId)
  return _skillTpl:getName(skillCfg)
end

function cls:getSkillDes()
  local skillLevelCfg = _skillLevelTpl:getTplByIdAndLevel(self.skillId, 1)
  return _skillLevelTpl:getSkillDescribe(skillLevelCfg)
end

function cls:setSelectState(bSelect)
  self.bind.active_selectImg = bSelect
end

function cls:setSlot(tmpSlotId)
  local showTag = 0 < tmpSlotId
  if showTag then
    self.bind.txt_slot = tostring(tmpSlotId)
  end
  self.bind.active_root_tag = showTag
end

return cls
