local this = class("cellRuneComposeAccess", G_UIModuleBase)

function this.bind()
  return {
    txt_access = "",
    go_arrow = false,
    go_lock = false,
    alpha_content = 1,
    rect_go = C_Vector3(0.2, 1, 1),
    rect_location = C_Vector2(32.9, 5),
    color_arrow = C_Color(0.3, 0.32, 0.36, 0),
    color_lock = C_Color(0.3, 0.32, 0.36, 0)
  }
end

function this.methods()
  return {
    onClick = function(self)
      if math.isEmpty(self.bind.systemId) then
        return
      end
      local canJump = L_JumpMgr:jumpTo(self.bind.systemId, {
        itemId = self.bind.itemId
      })
      if canJump and not L_GameUtil.getIsUseUseGiftType(self.bind.systemId) then
        L_UI:close("pageInfoTip")
        L_UI:close("pageReward")
        L_UI:close("pageExplore")
        L_UI:close("pageHeroTalentInfo")
        L_UI:close("pageRuneCompose")
      end
    end
  }
end

function this:initData()
  if not self.colorType then
    self.colorType = {
      light = C_Color(1, 1, 1, 0.7),
      dark = C_Color(0, 0, 0, 0.5)
    }
    self.styleTypeEnum = {Normal = 1, Roulette = 2}
  end
  self.styleType = self.bind.styleType or self.styleTypeEnum.Normal
end

function this:refresh()
  self:initData()
  self.bind.go_lock = false
  self.bind.go_unlock = false
  self.bind.go_arrow = false
  if not math.isEmpty(self.bind.systemId) then
    local isOpen = L_JumpMgr:checkJumpFuncOpen(self.bind.systemId) and C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.itemAccess)
    self.bind.go_lock = not isOpen
    self.bind.go_arrow = isOpen
    if self.styleType == self.styleTypeEnum.Normal then
      self.bind.alpha_content = 0
    elseif self.styleType == self.styleTypeEnum.Roulette then
      if not isOpen then
        local str = self.bind.txt_access or ""
        self.bind.txt_access = L_GameUtil.fillColor(str, "#000000")
      end
      self.bind.alpha_content = 0
    end
  end
end

function this:initFx()
  self.bind.rect_go = C_Vector3(0.2, 1, 1)
  self.bind.alpha_content = 0
  self.bind.rect_location = C_Vector2(32.9, 5)
  self.bind.color_arrow = C_Color(0.3, 0.32, 0.36, 0)
  self.bind.color_lock = C_Color(0.3, 0.32, 0.36, 0)
end

function this:playFx()
  if not self.isBind then
    return
  end
  self:initFx()
  Timer.once(self.bind.playTime, function()
    if not self.isBind then
      return
    end
    self.bind.alpha_content = 0
    self.bindComponents.playComposeAccess:Stop()
    self.bindComponents.playComposeAccess:Play("anim_rune_cell_composeAccess")
  end, self)
end

return this
