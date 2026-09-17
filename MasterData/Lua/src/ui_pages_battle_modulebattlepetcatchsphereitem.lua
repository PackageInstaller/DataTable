local this = class("moduleBattlePetCatchSphereItem", G_UIModuleBase)

function this.bind()
  return {
    sphereIcon = "",
    sphereCnt = "0",
    sphereImgColor = C_Color(1, 1, 1, 1),
    sphereImgDesaturate = false,
    sphereCntColor = C_Color(1, 1, 1, 1)
  }
end

function this.methods()
  return {
    onClick_sphere = function(self)
      self:onClick()
    end
  }
end

function this:open()
  self.keyType = C_InputManager_KeyType.EMainPetCatchBall1
  if self.bind.quality == 0 then
    self.keyType = C_InputManager_KeyType.EMainPetCatchBall1
  elseif self.bind.quality == 1 then
    self.keyType = C_InputManager_KeyType.EMainPetCatchBall2
  elseif self.bind.quality == 2 then
    self.keyType = C_InputManager_KeyType.EMainPetCatchBall3
  elseif self.bind.quality == 3 then
    self.keyType = C_InputManager_KeyType.EMainPetCatchBall4
  elseif self.bind.quality == 4 then
    self.keyType = C_InputManager_KeyType.EMainPetCatchBall5
  end
  L_ShortCutManager:registerShortCut(self.parent.parent.pageName, self.keyType, function(value)
    self:onClick()
  end)
  self.bind.sphereCnt = tostring(self.bind.cnt)
  self.bind.sphereIcon = self.bind.icon
  self:setIconByCnt(self.bind.cnt)
end

function this:close()
  L_ShortCutManager:removeShortCut(self.parent.parent.pageName)
end

function this:onClick()
  if self.parent.selectListShow then
    self:emit("onClick_sphere", self.bind.sphereId, self.bind.cnt, self.bind.quality, self.bind.icon)
  end
end

function this:refreshCnt(cnt)
  self.bind.sphereCnt = tostring(cnt)
  self:setIconByCnt(cnt)
end

function this:setIconByCnt(cnt)
  if cnt <= 0 then
    self.bind.sphereImgColor = C_Color(0.6, 0.6, 0.6, 1)
    self.bind.sphereImgDesaturate = true
    self.bind.sphereCntColor = C_Color(1, 1, 1, 0.3)
  else
    self.bind.sphereImgColor = C_Color(1, 1, 1, 1)
    self.bind.sphereImgDesaturate = false
    self.bind.sphereCntColor = C_Color(1, 1, 1, 1)
  end
end

return this
