local this = class("cellMapFilterItem", G_UIModuleBase)

function this.bind()
  return {
    img_icon = "",
    img_iconOff = "",
    txt_Name = "",
    isOn = false,
    color_imgLine = nil
  }
end

function this:open()
  self:setCheckState(self.bind.isOn)
end

function this.methods()
  return {
    onCheck = function(self, isOn)
      self:onCheck(isOn)
      if self.bind.clickCb then
        self.bind.clickCb(self, isOn)
      end
    end
  }
end

function this:setCheckState(isOn)
  self.bind.isOn = isOn
  self:onCheck(isOn)
end

function this:onCheck(isOn)
  local txtColorKey = isOn and "#4d4939ff" or "#4d4939cc"
  local lineColorKey = isOn and "#ea901e" or "#8f8470"
  self.bind.txt_Name = L_GameUtil.fillColor(self.bind.txtName, txtColorKey)
  local _, lineColor = C_ColorUtility.TryParseHtmlString(lineColorKey)
  self.bind.color_imgLine = lineColor
end

return this
