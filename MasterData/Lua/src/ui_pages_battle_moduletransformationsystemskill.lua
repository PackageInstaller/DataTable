local this = class("moduleTransformationSystemSkill", G_UIModuleBase)
local HideList = {
  "transMount",
  "transPetHideShow",
  "transPetSkill",
  "transStarHealing",
  "transHero",
  "transSkillControl",
  "trans_moduleMovementBlock",
  "transQuickUse"
}

function this.bind()
  return {
    moduleSkillLeftMouse = {
      moduleName = "pages/battle/moduleTransformationSystemSkillBtn"
    },
    moduleSkillE = {
      moduleName = "pages/battle/moduleTransformationSystemSkillBtn"
    },
    moduleSkillR = {
      moduleName = "pages/battle/moduleTransformationSystemSkillBtn"
    }
  }
end

function this.methods()
  return {
    onclick_leftMouseBtn = function(self)
      L_PlayerManager:fireAttack()
    end,
    onclick_eBtn = function(self)
      L_PlayerManager:fireSkill()
    end,
    onclick_rBtn = function(self)
      L_PlayerManager:fireUltimateSkill()
    end
  }
end

function this:open()
  self.pageMainCity = L_UI:getPage("pageMainCity")
  self.isShowTransformationSkillBtns = false
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.refresh, self)
  self:refresh()
end

function this:deActivate()
end

function this:activate(pageMainCity)
  self.pageMainCity = pageMainCity
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:refresh()
  local entity = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false)
  local entityType
  if entity then
    entityType = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false).data.entityType
  end
  if entityType ~= C_EEntityType.Monster then
    self:showOrHideSelf(false)
    if self.isShowTransformationSkillBtns then
      self:showOrHideModuleInHideList(true)
    end
    return
  end
  self.isShowTransformationSkillBtns = true
  self:showOrHideModuleInHideList(false)
  self:showOrHideSelf(true)
  self:refreshSkillBtn()
end

function this:showOrHideModuleInHideList(isShow)
  local page = self.pageMainCity
  if not page then
    return
  end
  for _, bindComponentName in ipairs(HideList) do
    local bindComponent = page.bindComponents[bindComponentName]
    if L_CommonUtil.isValid(bindComponent) and bindComponent.gameObject then
      bindComponent.gameObject:SetActive(isShow)
    end
  end
end

function this:showOrHideSelf(isShow)
  self.gameObject:SetActive(isShow)
end

function this:refreshSkillBtn()
  self.modules.moduleSkillLeftMouse:initSkillType(L_Const.skillType.attack)
  self.modules.moduleSkillE:initSkillType(L_Const.skillType.skill2)
  self.modules.moduleSkillR:initSkillType(L_Const.skillType.ultraSkill)
end

function this:close()
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.refresh, self)
end

return this
