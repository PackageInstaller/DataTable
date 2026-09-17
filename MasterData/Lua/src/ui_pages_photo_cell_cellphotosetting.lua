local this = class("cellPhotoMenu", G_UIModuleBase)

function this.bind()
  return {txtName = "", isOn = false}
end

function this.methods()
  return {
    onValueChanged_select = function(self, isOn)
      self:emit("onValueChanged_select", self.bind.id, isOn)
      if isOn then
        local function getter()
          return self.bindComponents.canvasgroup.alpha
        end
        
        local function setter(r)
          self.bindComponents.canvasgroup.alpha = r
        end
        
        self.Tween = DOTween.To(getter, setter, 1, 0.15)
      end
      if isOn == false then
        local function getter()
          return self.bindComponents.canvasgroup.alpha
        end
        
        local function setter(r)
          self.bindComponents.canvasgroup.alpha = r
        end
        
        self.Tween = DOTween.To(getter, setter, 0.3, 0.15)
      end
    end
  }
end

return this
