_class("UIGradeDetailItem", UICustomWidget)
UIGradeDetailItem = UIGradeDetailItem

function UIGradeDetailItem:Constructor()
  self._skillInfo = nil
end

function UIGradeDetailItem:OnShow(uiParams)
  self:GetComponents()
end

function UIGradeDetailItem:GetComponents()
  self._lineGo = self:GetGameObject("line")
  self._beforeTips = self:GetUIComponent("UILocalizationText", "beforeTips")
  self._arrow = self:GetGameObject("GradeArrow")
  self._skillToGo = self:GetGameObject("skillTo")
  self._afterTipsGo = self:GetGameObject("GradeAfterTips")
  self._skillFrom = self:GetUIComponent("UISelectObjectPath", "skillFrom")
  self._skillTo = self:GetUIComponent("UISelectObjectPath", "skillTo")
end

function UIGradeDetailItem:OnHide()
end

function UIGradeDetailItem:SetData(petData, skillInfo, idx, allCount, lastGrade, nextGrade, lastBreak, nextBreak)
  local isLast = idx == allCount
  self._lineGo:SetActive(not isLast)
  self._petData = petData
  self._skillInfo = skillInfo
  self._tag = skillInfo.type
  self._lastGrade = lastGrade
  self._nextGrade = nextGrade
  self._lastBreak = lastBreak
  self._nextBreak = nextBreak
  self._isChain = false
  self._isActive = false
  if self._tag == "active" then
    self._isActive = true
  elseif self._tag == "extra" then
  elseif self._tag == "passive" then
  elseif self._tag == "chain" then
    self._isChain = true
  elseif self._tag == "work" then
  end
  self._state = self._skillInfo.changeType
  self:ShowSkill()
end

function UIGradeDetailItem:ShowSkill()
  if self._state == PetSkillChangeState.Improved then
    self._beforeTips:SetText(StringTable.Get("str_pet_config_before_grade_info"))
    self._arrow:SetActive(true)
    self._skillToGo:SetActive(true)
    self._afterTipsGo:SetActive(true)
    local skillInfoFrom = {
      skillList = self._skillInfo.from,
      param = self._skillInfo.fromParam
    }
    local skillInfoTo = {
      skillList = self._skillInfo.to,
      param = self._skillInfo.toParam
    }
    local skillLuaFrom = self._skillFrom:SpawnObject("UIFightSkillItem")
    skillLuaFrom:SetData(skillInfoFrom, self._petData, nil, nil, nil, self._lastGrade, self._lastBreak)
    local skillLuaTo = self._skillTo:SpawnObject("UIFightSkillItem")
    skillLuaTo:SetData(skillInfoTo, self._petData, nil, nil, nil, self._nextGrade, self._nextBreak)
  elseif self._state == PetSkillChangeState.NewGain then
    local showTex = ""
    if self._tag == "passive" then
      showTex = "str_pet_config_unlock_equip_skill"
    elseif self._tag == "work" then
      showTex = "str_pet_config_unlock_work_skill"
    elseif self._tag == "chain" then
      showTex = "str_pet_config_unlock_chain_skill"
    elseif self._tag == "active" then
      showTex = "str_pet_config_unlock_active_skill"
    elseif self._tag == "extra" then
      showTex = "str_pet_config_unlock_active_skill"
    end
    self._beforeTips:SetText(StringTable.Get(showTex))
    self._arrow:SetActive(false)
    self._skillToGo:SetActive(false)
    self._afterTipsGo:SetActive(false)
    local skillInfoTo = {
      skillList = self._skillInfo.to,
      param = self._skillInfo.param
    }
    local skillLua = self._skillFrom:SpawnObject("UIFightSkillItem")
    skillLua:SetData(skillInfoTo, self._petData)
  end
end
