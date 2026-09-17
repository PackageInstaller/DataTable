local this = class("cellPlayerDressItem", G_UIModuleBase)

function this.bind()
  return {
    img_show = nil,
    isActive_cur = false,
    isActive_img = false,
    isActive_imgCustom = false,
    isActive_lock = false,
    isActive_lockHover = true,
    isActive_reddot = false,
    isActive_photo = false,
    txt_name = "",
    isActive_towSelect = false,
    isActive_showSelect = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      if self.bind.isActive_select == true then
        return
      end
      L_ReddotManager:clearNew(L_ReddotManager.DotDef.PlayerDressItem, self.bind.id, true)
      AzurWorld.RedDotMgr:RefreshRedDot("playerDisplay_item_" .. tostring(self.bind.id))
      if self.bind.isActive_photo then
        self:emit("onClick_shot", self.bind.id)
      else
        self:emit("onClick", self.bind)
      end
    end
  }
end

function this:open()
end

function this:close()
  L_PhotoManager:clearPhotoEntity(self.bindComponents.img_hero)
  if self.texCache then
    CS.Lens.Gameplay.Managers.PhotoManager.ReleaseTexture(self.texCache)
    self.texCache = nil
  end
end

function this:refresh()
  local reddotId = "playerDisplay_item_" .. tostring(self.bind.id)
  AzurWorld.RedDotMgr:BindRedDotRenderer(reddotId, self.bindComponents.reddot.gameObject)
  AzurWorld.RedDotMgr:MarkDirty(reddotId)
  self:refreshView()
end

function this:refreshView()
  local item = L_PlayerDisplayStore:getItem(self.bind.id)
  if item ~= nil then
    self.url = item.url
  else
    self.url = ""
  end
  self:refreshCurDress()
  local tpl = L_PlayerDisplayStore._playerCardDressTpl:getTplById(self.bind.id)
  self.bind.txt_name = L_PlayerDisplayStore._playerCardDressTpl:getName(tpl)
  self.bind.isActive_img = true
  self.bind.isActive_imgCustom = false
  self.bind.isActive_photo = false
  if tpl.defaultComponent == 1 and tpl.type == L_Const.playerDressType.hero then
    self.bind.img_show = ""
    local baseInfo = L_PlayerStore:getPlayerBaseInfo()
    local url, isDefault = L_FriendStore:getPlayerAvatars(baseInfo, L_Const.avatarTextureIndex.body)
    if not isDefault then
      self.bind.isActive_img = false
      self.bind.isActive_imgCustom = true
      L_PhotoManager:newOrBindPhotoEntity(self.bindComponents.img_hero, self.bindComponents.img_hero, url)
    else
      L_PhotoManager:clearPhotoEntity(self.bindComponents.img_hero)
      self.bind.isActive_imgCustom = false
      L_PhotoManager:loadDefaultTextureByType(url, function(tex)
        if tex == nil then
          return
        end
        if self.texCache then
          CS.Lens.Gameplay.Managers.PhotoManager.ReleaseTexture(self.texCache)
          self.texCache = nil
        end
        self.texCache = tex
        if not self.isBind then
          CS.Lens.Gameplay.Managers.PhotoManager.ReleaseTexture(self.texCache)
          self.texCache = nil
          return
        end
        local rect = C_Rect(0, 0, tex.width, tex.height)
        local pivot = C_Vector2.one * 0.5
        local sprite = Unity.Sprite.Create(tex, rect, pivot)
        self.bindComponents.img_show.sprite = sprite
      end, baseInfo)
    end
  else
    L_PhotoManager:clearPhotoEntity(self.bindComponents.img_hero)
    if string.isEmpty(self.url) then
      self.bind.img_show = L_PlayerDisplayStore._playerCardDressTpl:getPic(tpl)
      if tpl.type == L_Const.playerDressType.hero and tpl.customize == 1 then
        self.bind.isActive_photo = true
      end
    else
      self.bind.img_show = ""
      self.bind.isActive_img = false
      self.bind.isActive_imgCustom = false
      L_PlayerDisplayStore:getHeroStandeeCapture(self.url, true, function(tex, url)
        if not self.isBind or url ~= self.url then
          if tex ~= nil then
            CS.Lens.Gameplay.Managers.PhotoManager.ReleaseTexture(tex)
          end
          return
        end
        local rect = C_Rect(0, 0, tex.width, tex.height)
        local pivot = C_Vector2.one * 0.5
        local sprite = Unity.Sprite.Create(tex, rect, pivot)
        self.bindComponents.img_hero.sprite = sprite
        self.bind.isActive_imgCustom = true
        if self.texCache then
          CS.Lens.Gameplay.Managers.PhotoManager.ReleaseTexture(self.texCache)
          self.texCache = nil
        end
        self.texCache = tex
      end)
    end
  end
  local has = L_PlayerDisplayStore:hasItem(self.bind.id)
  has = has or tpl.customize == 1
  self.bind.isActive_lock = not has
  self.bind.isActive_lockHover = has
end

function this:refreshCurDress()
  local isCur = L_PlayerDisplayStore:isCurDress(self.bind.id)
  if isCur and self.bind.isActive_select then
    self.bind.isActive_towSelect = true
    self.bind.isActive_cur = false
    self.bind.isActive_showSelect = false
  else
    self.bind.isActive_towSelect = false
    self.bind.isActive_showSelect = self.bind.isActive_select
    self.bind.isActive_cur = isCur
  end
end

return this
