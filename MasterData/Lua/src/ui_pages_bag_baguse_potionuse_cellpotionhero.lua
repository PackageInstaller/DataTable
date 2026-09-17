local module = class("cellPotionHero", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
  self.data = {
    url_defaultHero = nil,
    index = 1,
    heroData = {
      hp_cur = 0,
      hp_max = 0,
      hp_scale = 0,
      isDie = false
    },
    itemData = {
      useType = nil,
      count = 1,
      hp_add = nil,
      effectIcon = nil
    },
    selection = nil
  }
end

local HP_COLOR = {
  red = CS.UnityEngine.Color(0.8392156862745098, 0.20784313725490197, 0.20784313725490197),
  orange = CS.UnityEngine.Color(0.9686274509803922, 0.6980392156862745, 0.2235294117647059),
  green = C_LuaUtility.ParseHtmlStringColor("#86F68E")
}

function module.bind()
  return {
    charge = false,
    hpText = "",
    heroStatus = false,
    hp = 0,
    hpImgColor = HP_COLOR.green,
    addHp = 0,
    selection = false,
    scrollList_buff = {
      moduleName = "pages/Bag/BagUse/cellHeroBuff"
    }
  }
end

function module.methods()
  return {
    onClick_selectHero = function(self)
      if not math.isEmpty(self.bind.heroId) then
        self:emit("onClick_selectHero", self.bind.heroId, self.data.index)
      end
    end
  }
end

function module:refresh()
  self:initData()
  self:refreshHeroData()
end

function module:initData()
  local hero = L_HeroStore:getHero(self.bind.heroId)
  local heroGuid = self.bind.heroId
  local heroCfgId = L_HeroStore:getHeroConfigId(hero)
  if hero.type == L_Const.HeroType.HT_MAIN then
    self.bindComponents.img_icon_trans.gameObject:SetActive(false)
    L_PhotoManager:fillMainHead(self, self.bindComponents.img_icon_trans.gameObject, nil, L_Const.avatarTextureIndex.head_talk, function()
      self.bindComponents.img_icon_trans.gameObject:SetActive(true)
    end)
  else
    local clothingId = AzurWorld.heroMgr:GetUsingClothingId(heroGuid, heroCfgId)
    local imgHeroIcon = L_GameUtil.getAvatarTexturePath(clothingId, L_Const.resourceIndexOfAvatarTextureInHeroTpl.mid)
    L_PhotoManager:releaseHead(self)
    self.bindComponents.img_icon_trans.gameObject:SetActive(true)
    self.bindComponents.img_icon:LoadSprite(imgHeroIcon)
  end
end

function module:refreshHeroData()
  local isDie = false
  if math.isEmpty(self.bind.heroId) then
    return
  end
  local hero = L_PlayerManager:getAllHeroCsEntity()[self.bind.heroId]
  if not hero then
    if L_BattleStore:getIsInBattle() then
      isDie = true
      self.bind.heroStatus = isDie
    end
    return
  end
  local csEntity = hero
  if not csEntity then
    isDie = true
    self.bind.heroStatus = isDie
    return
  end
  local aliveProperty = csEntity.data.aliveProperty
  local hp = aliveProperty.luaHp
  if hp <= 0 then
    isDie = true
    self.bind.heroStatus = isDie
    return
  end
  local hp_max = aliveProperty.luaMaxHp
  local hp_scale = hp / hp_max
  local color = HP_COLOR.green
  if hp_scale < 0.3 and 0 < hp_scale then
    color = HP_COLOR.red
  elseif hp_scale < 0.6 and 0.3 <= hp_scale then
    color = HP_COLOR.orange
  elseif hp_scale <= 0 then
    color = HP_COLOR.red
  end
  self.bind.hpImgColor = color
  self.bind.hpText = string.format("%d/%d", hp, hp_max)
  self.bind.hp = hp
  self.bind.heroStatus = isDie
  self.data.heroData = {
    hp_cur = hp,
    hp_max = hp_max,
    hp_scale = hp_scale,
    isDie = isDie
  }
end

function module:refreshDataOnSelection()
  if not self.data.selection or self.data.selection == false then
    return
  end
  self.bind.selection = true
end

function module:setIndex(index)
  self.data.index = index
end

function module:setSelection(bool)
  if not bool or bool == false then
    self.bind.addHp = 0
    self.bind.selection = false
    return
  end
  self.data.selection = true
  self:refreshDataOnSelection()
end

function module:unBind()
  self.super.unBind(self)
  L_PhotoManager:releaseHead(self)
end

function module:close()
  L_PhotoManager:releaseHead(self)
end

return module
