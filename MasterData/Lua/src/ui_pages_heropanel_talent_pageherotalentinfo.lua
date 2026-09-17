local this = class("pageHeroTalentInfo", G_UIPageBase)
local talentRuneTpl = L_GameTpl:getTalentRuneTpl()

function this.bind()
  return {
    runeTypeText = "",
    runeIcon = "",
    bg_runeTypeText = "",
    txt_hold_num = "",
    moduleTalentContentActive = true,
    moduleTalentContentSkillActive = false,
    moduleCurrency = {
      moduleName = "modulePages/moduleCurrency"
    },
    moduleTalentContent = {
      moduleName = "pages/heroPanel/talent/moduleTalentContent"
    },
    moduleTalentContentSkill = {
      moduleName = "pages/heroPanel/talent/moduleTalentContent"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      if not L_UI:checkPageOpen("pageHeroTalentInfo") then
        return
      end
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.onEvent_composeSuccessHandle = handler(self, self.onEvent_composeSuccess)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.onEvent_composeSuccessHandle)
  self.options = options
  self:initPage()
end

function this:close(options)
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.onEvent_composeSuccessHandle)
end

function this:onEvent_composeSuccess()
  self:initPage(true)
end

function this:initPage(isCompose)
  local runeTpl = talentRuneTpl:getTplById(self.options.runeId)
  local itemId = talentRuneTpl:getRuneItem(runeTpl)
  local item = L_ItemTplManager:getCommonItem(itemId)
  self.bind.runeIcon = item.icon
  self.isLackRune = C_BagMgr:getItemNumByItemId(itemId) <= 0
  self.bind.txt_hold_num = L_WordsTpl:getValue("ui_hero_rune_stock", {
    [0] = C_BagMgr:getItemNumByItemId(itemId)
  })
  local runeSkills = talentRuneTpl:getRuneSkill(runeTpl)
  local hasSkill = 0 < #runeSkills
  self.bind.moduleTalentContentActive = not hasSkill
  self.bind.moduleTalentContentSkillActive = hasSkill
  if self.bind.moduleTalentContentActive then
    self.modules.moduleTalentContent:initPage(table.clone(self.options))
  end
  if self.bind.moduleTalentContentSkillActive and not isCompose then
    self.modules.moduleTalentContentSkill:initPage(table.clone(self.options))
  end
  self.bind.runeTypeText = talentRuneTpl:getRuneTypeName(runeTpl)
  self.bind.bg_runeTypeText = talentRuneTpl:getRuneTypeEngName(runeTpl)
  local tpl_sys = L_GameTpl:getSystemUnlockTpl():getTplById(L_SystemConst.enum.heroTalent)
  self.modules.moduleCurrency:refreshRes(tpl_sys)
end

return this
