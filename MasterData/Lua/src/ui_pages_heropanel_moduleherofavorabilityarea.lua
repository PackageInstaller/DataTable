local this = class("moduleHeroFavorabilityArea", require("ui.pages.HeroPanel.moduleHeroBase"))
local _heroFavorabilityExpTpl = L_GameTpl:getHeroFavorabilityExpTpl()

function this.bind()
  return {
    favorabilityLevel = "",
    favorabilityExp = "",
    favorabilityArea = true,
    favorabilityLevelArea = true,
    favorabilityLevelAreaAcive = true
  }
end

function this.methods()
  return {
    onClick_favorabilityDetail = function(self)
      if self.clickCallback then
        self.clickCallback()
      else
        if not self:getSystemIsOpen(L_SystemConst.enum.heroFavorability) then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_systemMessage_16"))
          return
        end
        L_UI:open("pageHeroFavorabilityDetail", {
          heroId = self.heroGuid,
          preCallback = function()
            self.bind.favorabilityLevelAreaAcive = false
          end,
          favorabilityDetailCloseCallback = function()
            self.bind.favorabilityLevelAreaAcive = true
          end
        })
      end
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
end

function this:setData(heroGuid, heroConfigId, modeController, clickCallback)
  self.heroGuid = heroGuid
  self.heroConfigId = heroConfigId
  self.modeController = modeController
  self.clickCallback = clickCallback
  self:registerReddot(self.bindComponents.reddotFavor, string.format(L_ReddotManager.DotDef.HeroInfo, self.heroGuid .. "_favor"))
end

function this:getModeController()
  return self.modeController
end

function this:getHeroId()
  local heroConfigId = self.heroConfigId
  local heroTpl = L_GameTpl:getHeroTpl():getTplById(heroConfigId)
  if not heroTpl then
    local hero = AzurWorld.heroMgr:GetHero(heroConfigId)
    heroConfigId = hero.configId
  end
  return heroConfigId
end

function this:getOnlySystemUnlock(enumNumber)
  return C_IntegrateMgr.SystemUnlockModule:getOnlySystemUnlock(enumNumber)
end

function this:getSystemIsOpen(enumNumber)
  return C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(enumNumber)
end

function this:refreshHeroFavorabilityInfo()
  local heroTpl = L_GameTpl.getHeroTpl()
  local tpl = heroTpl:getTplById(self:getHeroId())
  local haveFavor = heroTpl:getFavor(tpl) == 1
  local isSystemOpen = self:getSystemIsOpen(L_SystemConst.enum.heroFavorability)
  local showFavorabilityInfo = self:getModeController():checkShowFavorabilityInfo() and haveFavor and isSystemOpen
  self.bind.favorabilityArea = showFavorabilityInfo
  if not showFavorabilityInfo then
    return
  end
  local hero = self:getHero(self.heroGuid)
  local favorabilityLevel = L_HeroStore:getHeroFavorAbilityLevel(hero)
  local isMaxLevel = favorabilityLevel >= _heroFavorabilityExpTpl:getMaxFavorabilityLevel()
  self.bind.favorabilityLevel = string.format("%02d", favorabilityLevel)
  if favorabilityLevel == 0 then
    self.bind.favorabilityLevel = "0"
  end
  if isMaxLevel then
    self.bind.favorabilityExp = L_WordsTpl:getValue("menu_common_lvMax")
  else
    local maxExp = _heroFavorabilityExpTpl:getFavorabilityTotalExp(favorabilityLevel)
    local favorabilityExp = L_HeroStore:getHeroFavorAbilityExp(hero)
    local curExp = _heroFavorabilityExpTpl:getFavorabilityTotalExp(favorabilityLevel - 1) + favorabilityExp
    self.bind.favorabilityExp = curExp .. "/" .. maxExp
  end
  self.bind.favorabilityLevelArea = true
end

return this
