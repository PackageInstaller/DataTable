local module = class("cellUseFoodHero", G_UIModuleBase)
local _heroTpl = L_GameTpl:getHeroTpl()
local _eleTpl = L_GameTpl:getElementTypeTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {photoEntity = nil}
end

local HP_COLOR = {
  red = CS.UnityEngine.Color(0.8392156862745098, 0.20784313725490197, 0.20784313725490197),
  orange = CS.UnityEngine.Color(0.9686274509803922, 0.6980392156862745, 0.2235294117647059),
  green = C_LuaUtility.ParseHtmlStringColor("#86F68E")
}

function module.bind()
  return {
    img_icon = "",
    hero = true,
    lvText = "",
    heroStatus = false,
    hp = 0,
    addHp = 0,
    starCount = 0,
    nodeProfess = false,
    imgEle = "",
    imgProfession = "",
    imageColor = "",
    imageColor2 = "",
    scrollList_buff = {
      moduleName = "pages/Bag/BagUse/cellUseFoodHeroBuff"
    }
  }
end

function module.methods()
  return {
    onClick_selectHero = function(self)
      self:emit("onClick_selectHero", self.bind, self.bind.heroId)
    end
  }
end

function module:open()
end

function module:destroy()
  if self.data.photoEntity then
    self.data.photoEntity:dispose()
    self.data.photoEntity = nil
  end
end

function module:refresh()
  self.bind.hero = true
  self.bind.charge = false
  local heroData = L_HeroStore:getHero(self.bind.heroGuid)
  if heroData then
    self.bind.lvText = string.format("%2d", tostring(L_HeroStore:getHeroLevel(heroData)))
    local configId = L_HeroStore:getHeroConfigId(heroData)
    local heroConf = L_ItemTplManager:getHeroItem(configId)
    self.bind.starCount = heroConf.quality + 1
    self.bind.imageColor = L_RarityTpl:getIconByType(heroConf.quality, L_Const.qualityPathType.cell2_frame)
    self.bind.imageColor2 = L_RarityTpl:getIconByType(heroConf.quality, L_Const.qualityPathType.cell2_bg)
    self.bind.nodeProfess = true
    local tpl = _heroTpl:getTplById(L_HeroStore:getHeroConfigId(heroData))
    local elementId = _heroTpl:getElement(tpl)
    local eTpl = _eleTpl:getTplById(elementId)
    self.bind.imgEle = _eleTpl:getProfessionColor(eTpl, L_Const.professionColorType.square)
    local position = _heroTpl:getPosition(tpl)
    local professionTpl = L_GameTpl:getProfessionTpl()
    local professionIcon = professionTpl:getIcon(professionTpl:getTplById(position))
    self.bind.imgProfession = professionIcon
  end
  if not string.isEmpty(self.bind.url_defaultHero) then
    if self.data.photoEntity == nil then
      self.data.photoEntity = L_PhotoManager:bindPhotoEntity(self.bindComponents.img_icon.gameObject, self.bind.url_defaultHero)
    else
      self.data.photoEntity:bindGameObject(self.bindComponents.img_icon.gameObject)
    end
  end
end

function module:resetAddhpWhileUnselect()
  self.bind.addHp = 0
end

return module
