local this = class("cellFurnitureHead", G_UIModuleBase)

function this.bind()
  return {
    go_favour = false,
    txt_favorValue = "",
    txt_own = "",
    go_soldOut = false,
    headItem = {
      moduleName = "modulePages/cellHeroHeadItemCircle"
    }
  }
end

function this.methods()
  return {
    headItem = {
      onClick = function(self)
        self:emit("onClick", self.bind.index)
      end
    }
  }
end

function this:open()
  this.super.open(self)
  self:refreshView()
end

function this:refresh()
  this.super.open(self)
  self:refreshView()
end

function this:refreshView()
  this.super.open(self)
  self.bind.txt_favorValue = tostring(self.bind.heroFavorLv)
  self.modules.headItem.bind.selected = self.bind.selIndex == self.bind.index
  if L_HeroStore:getHasHero(self.bind.id) then
    self.bind.go_favour = true
    local heroGuid = L_HeroStore:getGuidByConfigId(self.bind.id)
    self.modules.headItem.bind.isPhotoHead = true
    self.modules.headItem:setHeroGUID(heroGuid)
  else
    self.bind.go_favour = false
    self.modules.headItem:setHeroConfigID(self.bind.id)
  end
  local csHomeStore = AzurWorld.HomeMgr:GetHomeStore()
  local bInDorm = csHomeStore:OnCheckPlayerIsInDormById(self.bind.id)
  if bInDorm then
    self.bind.txt_own = self.bind.ownNum .. "/" .. self.bind.allNum
    self.bind.go_soldOut = self.bind.ownNum == self.bind.allNum
  else
    self.bind.txt_own = L_WordsTpl:getValue("residual_code_cellfurniturehead_01")
    self.bind.go_soldOut = false
  end
end

return this
