local this = class("moduleProductQuick", G_UIModuleBase)

function this.bind()
  return {active_PC = true, active_Mobile = false}
end

function this.methods()
  return {
    onClick = function(self)
      L_UI:open("pageProduct_Quick")
    end,
    onClickMobile = function(self)
      L_AudioUtil.playSound("Play_SFX_System_UI_FunctionPanel_Click_Mobile")
      L_UI:open("pageProduct_Quick")
    end
  }
end

function this:open()
  self:handleMultiPlatform()
  self:bindPcKey()
end

function this:show(options)
end

function this:close()
  L_ShortCutManager:clearShortKeyFlag(self)
end

function this:bindPcKey()
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openProductQuick, L_Const.AnchorType.Bottom, self.bindComponents.transProductQuick, L_Vector3.new(-1.34, 32.1))
end

function this:handleMultiPlatform()
  local isPC = L_DeviceTpl:getIsPc()
  self.bind.active_PC = isPC
  self.bind.active_Mobile = not isPC
end

return this
