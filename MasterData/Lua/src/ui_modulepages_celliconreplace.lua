local this = class("cellIconReplace", G_UIModuleBase)
local _heroTpl = L_GameTpl:getHeroTpl()

function this.bind()
  return {
    imageColor = "",
    activeSelect = false,
    img_texIconHeroM = nil,
    nameText = "",
    impressionText = "",
    checkInActive = false
  }
end

function this.methods()
  return {}
end

function this:open()
  this.super.open(self)
  self._ESyncHeroServerDataHandler = handler(self, self.onEvent_refreshHero)
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
  self:refreshView()
end

function this:refresh()
  self:refreshView()
end

function this:close()
  AzurWorld.heroMgr:UnregisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
end

function this:refreshView()
  if not self.isBind then
    return
  end
  local guid = self.bind.guid
  if self.bind.choice then
    self:updateSelectState()
  end
  self:setHeroDataContent(guid, self.bind)
end

function this:updateSelectState()
  if self.bind.selectMode then
    self._isSelect = not self._isSelect
    self.bind.activeSelect = self._isSelect == true
  end
end

function this:isSelect()
  return self._isSelect
end

function this:setHeroDataContent(guid, params)
  params = params or {}
  local heroData = params.dataSrc or L_HeroStore:getHero(guid)
  self.bind.callback = params.callback
  if heroData then
    local heroConf = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroData))
    self.bind.img_texIconHeroM = heroConf.icon_mid or ""
    self.bind.imageColor = L_RarityTpl:getIconByType(heroConf.quality, L_Const.qualityPathType.cell2_frame)
    self.bind.impressionText = string.format("%2d", tostring(L_HeroStore:getHeroFavorAbilityExp(heroData)))
    self.bind.nameText = heroConf.name or ""
    self.bind.checkInActive = params.checkIn == true
  end
end

return this
