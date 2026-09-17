local this = class("cellHomeDormitory", G_UIModuleBase)

function this.bind()
  return {
    active_rect_hero = false,
    img_texIconHero = nil,
    active_btn_addHero = false,
    active_img_lock = false,
    txt_id = "",
    txt_name = "",
    img_outside = false,
    img_doom = false,
    lock = false
  }
end

function this.methods()
  return {
    onClick_addHero = function(self)
      self:emit("onClick_addHero", self.index)
    end,
    onClick_switch = function(self)
      self:emit("onClick_switch", self.cellData.heroGuid, self.index)
    end,
    onClick_visit = function(self)
      self:emit("onClick_visit", self.cellData.heroGuid)
    end,
    onClick_Hero = function(self)
    end
  }
end

function this:open()
  this.super.open(self)
end

function this:preBind()
  self.cellData = {}
end

function this:close()
end

function this:setHeroGuid(heroGuid)
  self.cellData.heroGuid = heroGuid
end

function this:setIndex(index)
  self.index = index
  self.bind.txt_id = tostring(index)
end

function this:refreshView()
  if self.bind.lock then
    self.bind.lock = true
    self.bind.txt_name = L_WordsTpl:getValue("ui_moduleCanteenFree_03", {
      [0] = tostring(self.bind.unLockLv)
    })
    return
  end
  self.bind.active_rect_hero = self.cellData.heroGuid ~= nil
  if self.cellData.heroGuid ~= nil then
    local heroItemInfo = L_HeroStore:getHero(self.cellData.heroGuid)
    local heroConf = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroItemInfo))
    self.bind.img_texIconHero = heroConf.icon_mid or ""
    self.bind.txt_name = heroConf.name or ""
    local isStrolling = AzurWorld.HomeMgr:CheckHeroIsStrollingInHome(self.cellData.heroGuid)
    self.bind.img_outside = isStrolling
    self.bind.img_doom = not isStrolling
  else
    self.bind.img_texIconHero = ""
    self.bind.txt_name = ""
  end
  self.bind.active_btn_addHero = self.cellData.heroGuid == nil
end

return this
