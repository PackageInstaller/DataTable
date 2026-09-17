local this = class("heroModeControllerBase")
local uiTopBarTpl = L_GameTpl:getUiTopBarTpl()
local normalShowModuleTypes = {}

function this:ctor()
  self._soulEssenceId = nil
  self._selectHeroConfigId = nil
  self._selectHeroGuid = nil
end

function this:checkCanChangeHero()
  return true
end

function this:checkCanShowDownBG()
  return true
end

function this:getShowModuleTypes()
  return normalShowModuleTypes
end

function this:checkModuleIsShow(moduleType)
  local isShow = self:checkModuleIsShowCustom(moduleType)
  if isShow ~= nil then
    return isShow
  end
  local showTypes = self:getShowModuleTypes()
  return showTypes[moduleType] == true
end

function this:checkModuleIsShowCustom(moduleType)
  return nil
end

function this:getHomeName()
  local tpl_uiTopBar = uiTopBarTpl:getTplByPageName("pageHero")
  local name = uiTopBarTpl:getBackTxt(tpl_uiTopBar)
  return name
end

function this:showTimeline()
  return true
end

function this:showMainBtn()
  return true
end

function this:setCurrentProperty(b)
  self.currentProperty = b
end

function this:showCurrentProperty()
  return self.currentProperty
end

function this:isPreviewMode()
  return false
end

function this:checkShowPreviewLevel(moduleType)
  return false
end

function this:getHero(heroId, showCurrentProperty)
  return nil
end

function this:checkShowUnLook()
  return false
end

function this:checkShowFavorabilityInfo()
  return true
end

function this:setSelectGuid(id, create)
  local souId = self._selectHeroGuid
  self._selectHeroGuid = id
  if not create then
    L_HeroStore:call(L_HeroStore.event.setCurHeroGuid, id, souId)
    local args = CS.Lens.Gameplay.Modules.BigWorld.HeroSelChangeEventArgs()
    args.heroGuid = id
    args.showCurrentProperty = self:showCurrentProperty()
    C_ExternalManager.DispatchEvent(C_EExternalEventType.HeroSelChange, args)
  end
end

function this:getSelectGuid()
  return self._selectHeroGuid
end

function this:getSelectConfigId()
  return self._selectHeroConfigId or self._selectHeroGuid
end

return this
