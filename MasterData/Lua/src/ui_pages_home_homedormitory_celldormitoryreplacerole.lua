local this = class("cellDormitoryReplaceRole", G_UIModuleBase)
local _heroTpl = L_GameTpl:getHeroTpl()

function this.bind()
  return {
    imageColor = "",
    active_select = false,
    img_texIconHeroM = nil,
    text_name = "",
    text_order = "",
    active_img_inHomeDorm = false,
    active_img_curExchange = false
  }
end

function this.methods()
  return {
    onClick_content = function(self)
      self:emit("onClick_content", self.cellData.heroGuid)
    end
  }
end

function this:open()
  this.super.open(self)
  self._ESyncHeroServerDataHandler = handler(self, self.onEvent_refreshHero)
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
end

function this:close()
  AzurWorld.heroMgr:UnregisterEvent(C_EHeroEvent.ESyncHeroServerData, self._ESyncHeroServerDataHandler)
end

function this:preBind()
  self.cellData = {}
end

function this:setData(heroGuid, isInCurHomeDorm, curExchangeHeroGuid, order)
  self.cellData.heroGuid = heroGuid
  self.cellData.isInCurHomeDorm = isInCurHomeDorm
  self.cellData.curExchangeHeroGuid = curExchangeHeroGuid
  self.cellData.order = order
end

function this:refreshView()
  self.bind.active_img_inHomeDorm = self.cellData.isInCurHomeDorm == true
  local heroItemInfo = L_HeroStore:getHero(self.cellData.heroGuid)
  local favorLevel = L_HeroStore:getHeroFavorAbilityLevel(heroItemInfo)
  self.bind.text_order = tostring(favorLevel)
  local heroConf = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroItemInfo))
  self.bind.img_texIconHeroM = heroConf.icon_mid or ""
  self.bind.text_name = heroConf.name or ""
  self.bind.active_select = self.cellData.selectHeroGuid == self.cellData.heroGuid
  self.bind.active_img_curExchange = self.cellData.curExchangeHeroGuid == self.cellData.heroGuid
end

function this:setSelectHeroGuid(selectHeroGuid)
  self.cellData.selectHeroGuid = selectHeroGuid
  self.bind.active_select = self.cellData.selectHeroGuid == self.cellData.heroGuid
end

function this:old_refreshView()
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
