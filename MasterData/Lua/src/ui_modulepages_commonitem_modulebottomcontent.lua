local this = class("moduleBottomContent", G_UIModuleBase)

function this.bind()
  return {
    go_limit = false,
    txt_limitTime = "",
    go_using = false,
    go_lock = false,
    active_owner = false,
    img_owner = ""
  }
end

function this.methods()
  return {}
end

function this:open()
end

function this:close()
end

function this:refreshView(data)
  if data.limit then
    self.bind.go_limit = data.limit
  end
  if data.using then
    self.bind.go_using = data.using
  end
  self:refreshLock(data.lock)
  self:refreshOwner(data.wearHero)
end

function this:refreshLock(block)
  if block == nil then
  end
  self.bind.go_lock = block
end

function this:refreshOwner(heroGuid)
  if heroGuid and 0 < heroGuid then
    self.bind.active_owner = true
    local heroData = L_HeroStore:getHero(heroGuid)
    local modName = L_PlayerStore:getPlayerModHeadImgName()
    if heroData then
      if L_HeroStore:getHeroGuid(heroData) == L_HeroStore:getDefaultHeroGuid() and not string.isEmpty(modName) then
        L_PhotoManager:fillMainHead(self, self.bindComponents.rect_img_owner.gameObject, nil, L_Const.avatarTextureIndex.head, function()
          self.bindComponents.rect_img_owner.gameObject:SetActive(true)
        end)
      else
        L_PhotoManager:releaseHead(self)
        self.bind.img_owner = L_GameUtil.getAvatarTexturePath(L_HeroStore:getHeroConfigId(heroData), L_Const.resourceIndexOfAvatarTextureInHeroTpl.small)
      end
    end
  else
    self.bind.active_owner = false
  end
end

function this:refreshUsing(using)
  self.bind.go_using = using
end

return this
