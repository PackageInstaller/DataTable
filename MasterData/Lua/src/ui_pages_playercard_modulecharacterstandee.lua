local this = class("moduleCharacterStandee", G_UIModuleBase)
local _playerDressTpl = L_GameTpl:getPlayercardDressTpl()

function this.bind()
  return {
    img_displayBg = "",
    img_displayCharacter = "",
    img_displayPet = "",
    img_displayBase = "",
    isActive_Character = true,
    isActive_Pet = true,
    isActive_Base = true,
    isActive_Bg = true,
    isActive_outLine = false
  }
end

function this.methods()
  return {}
end

function this:showByPlayerId()
end

function this:setStandeeByBaseInfo(baseInfo)
  self.baseInfo = baseInfo
  local stand_plates = baseInfo.stand_plates
  if stand_plates == nil or stand_plates.role == nil then
    return
  end
  local stamp = string.format("%s|%s|%s|%s|%s", tostring(stand_plates.role.config), tostring(stand_plates.role.url), tostring(stand_plates.pet_accessory), tostring(stand_plates.baseboard), tostring(stand_plates.backboard))
  if self.curAvatarBodyUrl ~= L_FriendStore:getPlayerAvatars(self.baseInfo, L_Const.avatarTextureIndex.body) then
    self:setCharacter({
      id = stand_plates.role.config,
      url = stand_plates.role.url
    })
    self.curAvatarBodyUrl = L_FriendStore:getPlayerAvatars(self.baseInfo, L_Const.avatarTextureIndex.body)
  end
  if self._standeeStamp == stamp then
    return
  end
  self._standeeStamp = stamp
  self:setPet({
    id = stand_plates.pet_accessory
  })
  self:setBase({
    id = stand_plates.baseboard
  })
  self:setBg({
    id = stand_plates.backboard
  })
  self:setCharacter({
    id = stand_plates.role.config,
    url = stand_plates.role.url
  })
end

function this:setCharacter(data)
  local id = data.id
  self.url = data.url
  local tpl = _playerDressTpl:getTplById(id)
  if tpl == nil then
    self.bind.isActive_Character = false
    self.bind.isActive_outLine = false
    return false
  end
  local isCustom = tpl.customize == 1
  if isCustom then
    self.bind.isActive_Character = false
    if not string.isEmpty(data.url) then
      local isSelf = L_PlayerStore:getPlayerId() == self.baseInfo.id
      L_PlayerDisplayStore:getHeroStandeeCapture(data.url, isSelf, function(tex, url)
        if url == self.url then
          self:setOutlineImg(tex)
        elseif tex ~= nil then
          C_PhotoManager.ReleaseTexture(tex)
        end
      end)
    else
      self.bind.isActive_outLine = false
    end
  else
    self.bind.isActive_Character = true
    if tpl.defaultComponent == 1 then
      self.bind.isActive_Character = false
      L_PhotoManager:loadHeadTex(L_FriendStore:getPlayerAvatars(self.baseInfo, L_Const.avatarTextureIndex.body), function(tex)
        self:setOutlineImg(tex)
      end, nil, nil, self.baseInfo)
    else
      self.bind.isActive_outLine = false
      self.bind.img_displayCharacter = _playerDressTpl:getPic(tpl)
      local rect = self.bindComponents.img_displayCharacter.transform
      self.bindComponents.img_displayCharacter:SetNativeSize()
    end
  end
  if data.isGray == true then
    self.bindComponents.img_displayCharacter.color = C_Color.gray
  else
    self.bindComponents.img_displayCharacter.color = C_Color.white
  end
end

function this:setOutlineImg(tex)
  if not self.isBind or self.bindComponents.heroimg == nil then
    if tex ~= nil then
      C_PhotoManager.ReleaseTexture(tex)
    end
    return
  end
  if tex == nil then
    return
  end
  self.bind.isActive_outLine = true
  self.bindComponents.heroimg.texture = tex
  self.bindComponents.outline.texture = tex
  self.bindComponents.shadow.texture = tex
  local SDFGenorateToShader = self.bindComponents.SDFGenorateToShader
  SDFGenorateToShader.inputTexture = tex
  if self.texCache then
    C_PhotoManager.ReleaseTexture(self.texCache)
    self.texCache = nil
  end
  if self.sdf then
    self.bindComponents.SDFGenorateToShader:DestoryAssets()
    self.sdf = nil
  end
  self.texCache = tex
  local rt = SDFGenorateToShader:GenerateSDFWithJFA()
  self.sdf = rt
  if self.mat1 == nil then
    self.mat1 = C_UnityObject.Instantiate(self.bindComponents.outline.material)
    self.bindComponents.outline.material = self.mat1
  end
  if self.mat2 == nil then
    self.mat2 = C_UnityObject.Instantiate(self.bindComponents.shadow.material)
    self.bindComponents.shadow.material = self.mat2
  end
  self.mat1:SetTexture("_InputTexture", rt)
  self.mat2:SetTexture("_InputTexture", rt)
  self.bindComponents.outline:SetNativeSize()
  self.bindComponents.heroimg:SetNativeSize()
  self.bindComponents.shadow:SetNativeSize()
end

function this:setPet(data)
  local tpl = _playerDressTpl:getTplById(data.id)
  if tpl == nil then
    return
  end
  self.bind.img_displayPet = _playerDressTpl:getPic(tpl)
  self.bindComponents.img_displayPet:SetNativeSize()
  if data.isGray == true then
    self.bindComponents.img_displayPet.color = C_Color.gray
  else
    self.bindComponents.img_displayPet.color = C_Color.white
  end
end

function this:setBase(data)
  local tpl = _playerDressTpl:getTplById(data.id)
  if tpl == nil then
    return
  end
  self.bind.img_displayBase = _playerDressTpl:getPic(tpl)
  self.bindComponents.img_displayBase:SetNativeSize()
  if data.isGray == true then
    self.bindComponents.img_displayBase.color = C_Color.gray
  else
    self.bindComponents.img_displayBase.color = C_Color.white
  end
end

function this:setBg(data)
  local tpl = _playerDressTpl:getTplById(data.id)
  if tpl == nil then
    return
  end
  self.bind.img_displayBg = _playerDressTpl:getPic(tpl)
  self.bindComponents.img_displayBg:SetNativeSize()
  if data.isGray == true then
    self.bindComponents.img_displayBg.color = C_Color.gray
  else
    self.bindComponents.img_displayBg.color = C_Color.white
  end
end

function this:close()
end

function this:unBind()
  self._standeeStamp = nil
  if self.sdf then
    self.bindComponents.SDFGenorateToShader:DestoryAssets()
    self.sdf = nil
  end
  self.super.unBind(self)
  if self.mat1 then
    C_UnityObject.Destroy(self.mat1)
    self.mat1 = nil
  end
  if self.mat2 then
    C_UnityObject.Destroy(self.mat2)
    self.mat2 = nil
  end
  if self.texCache then
    C_PhotoManager.ReleaseTexture(self.texCache)
    self.texCache = nil
  end
end

return this
