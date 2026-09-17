local this = class("moduleKiBoSkillDesc", G_UIModuleBase)
local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local skillTpl = L_GameTpl:getSkillTpl()

function this.bind()
  return {
    txt_skillName = "",
    txt_skillLevel = 0,
    txt_skillDesc = "",
    img_skillIcon = "",
    txt_featureName = "",
    active_skill = true,
    active_feature = false,
    list_persetTipImgs = {
      moduleName = "Pages/formation/formationModule/cellTeamPresetTip"
    },
    color_leftDesaturate = C_Color(1, 1, 1, 1),
    color_rightDesaturate = C_Color(1, 1, 1, 1)
  }
end

function this.methods()
  return {
    onClick_left = function(self)
      self:dealSwitch(false)
    end,
    onClick_right = function(self)
      self:dealSwitch(true)
    end,
    onDragBegin = function(self, pos)
      self:onDragBegin(pos)
    end,
    onDragEnd = function(self, pos)
      self:onDragEnd(pos)
    end
  }
end

function this:dealSwitch(isAdd)
  if isAdd then
    if self.curIndex == #self.skillData then
      return
    end
    self.curIndex = self.curIndex + 1
  else
    if self.curIndex == 1 then
      return
    end
    self.curIndex = self.curIndex - 1
  end
  self:refreshSelected()
end

function this:open()
  self.onSkillInfoSwicthHandler = handler(self, self.onSkillInfoSwicth)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.SkillInfoSwicth, self.onSkillInfoSwicthHandler)
end

function this:close()
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.SkillInfoSwicth, self.onSkillInfoSwicthHandler)
end

function this:onSkillInfoSwicth(e, varList)
  local infoType = varList:GetInt(0)
  if infoType == self.nextType then
    self:dealSwitch(true)
  end
  if infoType == self.previousType then
    self:dealSwitch(false)
  end
end

function this:initModule(data)
  self.curIndex = 1
  self.nextType = data.nextType
  self.previousType = data.previousType
  self:initSkillList(data.skills)
end

function this:initSkillList(data)
  self.skillData = {}
  for _, skillInfo in ipairs(data) do
    local skillId = skillInfo.skillId
    local skillLevel = skillInfo.skillLevel
    local isSkill = skillInfo.isSkill
    local isFeature = skillInfo.isFeature
    local levelTpl = skillLevelTpl:getTplByIdAndLevel(skillId, skillLevel)
    local tpl = skillTpl:getTplById(skillId)
    local name = skillTpl:getName(tpl)
    local skillDescribe = skillLevelTpl:getSkillDescribe(levelTpl)
    local skillIcon = skillTpl:getIcon(tpl)
    table.insert(self.skillData, {
      isSkill = isSkill,
      isFeature = isFeature,
      skillId = skillId,
      skillLevel = skillLevel,
      skillName = name,
      skillDescribe = skillDescribe,
      skillIcon = skillIcon
    })
  end
  local tmp = {}
  for i = 1, #data do
    table.insert(tmp, {index = i})
  end
  self.bind.list_persetTipImgs:clear()
  self.bind.list_persetTipImgs:insert_array(tmp)
  self:refreshSelected()
end

function this:refreshSelected()
  if not self.curIndex == nil then
    self.curIndex = 1
  end
  local curSkill = self.skillData[self.curIndex]
  if curSkill.isSkill then
    self.bind.active_feature = false
    self.bind.active_skill = true
    self.bind.txt_skillName = curSkill.skillName
    self.bind.txt_skillLevel = curSkill.skillLevel
    self.bind.img_skillIcon = curSkill.skillIcon
    self.bindComponents.descLayout.padding.left = 105
  end
  if curSkill.isFeature then
    self.bind.active_feature = true
    self.bind.active_skill = false
    self.bind.txt_featureName = curSkill.skillName
    self.bindComponents.descLayout.padding.left = 78
  end
  self.bind.txt_skillDesc = curSkill.skillDescribe
  self.bind.color_leftDesaturate = self.curIndex == 1 and C_Color(1, 1, 1, 0.6) or C_Color(1, 1, 1, 1)
  self.bind.color_rightDesaturate = self.curIndex == #self.skillData and C_Color(1, 1, 1, 0.6) or C_Color(1, 1, 1, 1)
  for _, v in pairs(self.modules.list_persetTipImgs) do
    v:setActive(v.bind.index == self.curIndex)
  end
end

function this:onDragBegin(screenPos)
  if not L_DeviceTpl:getIsMobile() then
    return
  end
  local rect = self.bindComponents.dragRect
  local cam = C_CameraManager.uiCamera
  local _, uiPos = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, screenPos, cam)
  self.beginPos = uiPos
end

function this:onDragEnd(screenPos)
  if not L_DeviceTpl:getIsMobile() then
    return
  end
  if not self.beginPos then
    return
  end
  local rect = self.bindComponents.dragRect
  local cam = C_CameraManager.uiCamera
  local _, uiPos = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, screenPos, cam)
  local delta = uiPos - self.beginPos
  local offset = math.abs(delta.x)
  self.beginPos = nil
  if offset < 100 then
    return
  end
  if delta.x > 0 then
    self:dealSwitch(false)
  else
    self:dealSwitch(true)
  end
end

return this
