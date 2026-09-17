local this = class("cellIllustratedCharacterUnit", G_UIModuleBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _eleTpl = L_GameTpl:getElementTypeTpl()

function this.bind()
  return {
    lock = false,
    go_imageIcon = false,
    imageIcon = "",
    go_rect_hero = false,
    img_texIconHeroM = nil,
    imageColor = "",
    imageColor2 = "",
    activeSelect = false,
    listStar = {},
    textLevel = "",
    nodeProfess = false,
    imgEleBg = "",
    imgProfession = "",
    nodeTeam = false,
    textTeamIndex = "",
    activeHead = false,
    imageHead = "",
    module_gameplayStatus = {
      moduleName = "pages/pet/modulePetGameplayStatus"
    },
    nameActive = false,
    nameText = "",
    go_die = false,
    go_putMask = false,
    activeAdd = false,
    try = false,
    reddotNew = true,
    reddotNormal = false,
    go_lock = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.bind.callback then
        self.bind.callback(self)
      end
    end,
    onLongClick = function(self)
    end,
    onLongTab = function(self)
    end
  }
end

function this:open()
  this.super.open(self)
  self:refreshView()
end

function this:refresh()
  self:refreshView()
end

function this:refreshView()
  if not self.isBind then
    return
  end
  self.bind.go_imageIcon = false
  self.bind.go_rect_hero = false
  self:setHeroDataContent(self.bind)
end

function this:setHeroDataContent(params)
  self.bind.callback = params.callback
  local configId = params.configId
  local heroConf = L_ItemTplManager:getHeroItem(configId)
  self.bind.go_rect_hero = true
  self.bind.img_texIconHeroM = heroConf.icon_mid
  self.bind.imageColor = L_RarityTpl:getIconByType(heroConf.quality, L_Const.qualityPathType.cell2_frame)
  self.bind.imageColor2 = L_RarityTpl:getIconByType(heroConf.quality, L_Const.qualityPathType.cell2_bg)
  self:_setStars(heroConf.quality + 1)
  local tpl = _heroTpl:getTplById(configId)
  local position = _heroTpl:getPosition(tpl)
  self.bind.nodeProfess = true
  local elementId = _heroTpl:getElement(tpl)
  local eTpl = _eleTpl:getTplById(elementId)
  self.bind.imgEleBg = _eleTpl:getProfessionColor(eTpl, L_Const.professionColorType.square)
  local professionTpl = L_GameTpl:getProfessionTpl()
  local professionIcon = professionTpl:getIcon(professionTpl:getTplById(position))
  self.bind.imgProfession = professionIcon
  self.bind.go_die = false
  self:setName(_heroTpl:getName(tpl))
  self.configId = params.configId
  local hasHero = L_HeroStore:getHasHero(self.configId)
  self.bind.reddotNew = hasHero
  if hasHero then
    local heroGuid = L_HeroStore:getGuidByConfigId(self.configId)
    L_ReddotManager:registerReddot(self.bindComponents.reddotNew, string.format(L_ReddotManager.DotDef.HandBook_Character_New_Item, heroGuid))
  end
  self.bind.activeSelect = params.selectId == params.configId
  self.bind.go_lock = not hasHero
end

function this:_setStars(num)
  if not self.isBind then
    return
  end
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.listStar:clear()
  self.bind.listStar:insert_array(stars)
end

function this:setName(nameStr, nameColor)
  self.bind.nameActive = not math.isEmpty(nameStr)
  if nameColor ~= nil then
    self.bind.nameText = L_GameUtil.fillColor(nameStr, nameColor)
  else
    self.bind.nameText = nameStr
  end
end

function this:setSelectState(selectId)
  self.bind.activeSelect = self.configId == selectId
end

return this
