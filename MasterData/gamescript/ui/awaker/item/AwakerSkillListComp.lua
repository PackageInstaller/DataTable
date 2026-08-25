local AwakerPage = CommonDefine.AwakerPage
local AwakerSkillListComp, Super = System.NewComponent("AwakerSkillListComp")

function AwakerSkillListComp:ctor(uiNode, model, skillModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Skill_ListResource(uiNode)
  self.model = model
  self.skillModel = skillModel
end

function AwakerSkillListComp:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_Awaker_Name, function()
    local tid = self.model.selectAwakerId
    local name = self.model:GetAwakerTitle(tid)
    return name
  end)
  binder:BindToImage(self.ui.Image_Awaker_Career_Icon, function()
    local tid = self.model.selectAwakerId
    local config = self.model:GetAwakerConfig(tid)
    if not config then
      return ""
    end
    local iconPath = self.model:GetSchoolIcon(config.School)
    return iconPath
  end)
  binder:BindToText(self.ui.Text_Career_Name, function()
    local tid = self.model.selectAwakerId
    local config = self.model:GetAwakerConfig(tid)
    if not config then
      return ""
    end
    do return self.model.GetSchoolName, self.model end
    return self.model.GetSchoolName, self.model, config.School
  end)
  binder:BindToRaw(function(cb, n, _)
    if not n then
      return
    end
    local skills = self.skillModel.skillList
    if not skills then
      return
    end
    for i = 1, self.skillModel.MAX_SKILL_SHOW_NUM do
      local obj = self.ui["Group_Skill" .. i]
      if not obj then
      else
        local skill = skills[i]
        if not skill then
        else
          binder:SetActive(obj, nil ~= skill)
          local data = {
            skill = skill,
            model = self.skillModel,
            callback = function(slot)
              local page = self.model.page
              if page ~= AwakerPage.Skill and page ~= AwakerPage.SkillDetail then
                return
              end
              if not slot then
                return
              end
              local curSlot = self.skillModel:GetSelectSlot()
              if curSlot ~= slot then
                AudioManager.Instance:PostSoundEvent("UI_AWAKER_SKILL_TESTCHANGE")
              end
              self.skillModel:SetSelectSlot(slot)
              self.model:SetAwakerPage(AwakerPage.SkillDetail)
            end
          }
          cb:BindComponent(AwakerSkillListItem(obj, data))
        end
      end
    end
  end, function()
    return self.model.selectAwakerId
  end)
end

function AwakerSkillListComp:OnUnbind()
  Super.OnUnbind(self)
end

function AwakerSkillListComp:RepositionContent()
  if self.binder then
    self.binder:CircularScrollTo(self.ui.ScrollView_Skill, 1)
  end
end

return AwakerSkillListComp
