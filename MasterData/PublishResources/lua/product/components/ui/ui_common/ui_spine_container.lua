_class("UISpineContainer", UICustomWidget)
UISpineContainer = UISpineContainer

function UISpineContainer:Constructor()
end

function UISpineContainer:OnShow()
  self._img = self:GetUIComponent("RawImageLoader", "pic")
end

function UISpineContainer:OnHide()
end

function UISpineContainer:SetData(pet)
  if not pet then
    return
  end
  local staticBody = pet:GetPetStaticBody(PetSkinEffectPath.NO_EFFECT)
  self._img:LoadImage(staticBody)
  UICG.SetTransform(self._img.transform, self:GetName(), staticBody)
end
