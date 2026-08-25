local CardRuneTypeComponent, Super = System.NewComponent("CardRuneTypeComponent")

function CardRuneTypeComponent:ctor(uiNode, runeTid, cardUid)
  Super.ctor(self)
  self.ui = Item_Card_RuneResource(uiNode)
  self.runeTid = runeTid
  self.cardUid = cardUid
end

function CardRuneTypeComponent:OnBind(binder)
  binder:BindToImage(self.ui.Image_Rune, function()
    do return BattleSkillUtils.GetCardEnchantSmallIcon, self.runeTid end
    return BattleSkillUtils.GetCardEnchantSmallIcon, self.runeTid, self.cardUid
  end)
  binder:BindToRaw(function(childBinder, isGray)
    local imageComp = self.ui.Image_Rune:GetComponent(typeof(CS.UnityEngine.UI.Image))
    local mat = imageComp.material
    if not isGray then
      if mat and mat.name == "UI_Gray_Image_mat" then
        imageComp.material = nil
      end
    elseif not mat or mat.name ~= "UI_Gray_Image_mat" then
      mat = childBinder:LoadAsset("UI/5_Material/UI_Gray_Image_mat.mat")
      if mat then
        imageComp.material = mat
        mat.name = "UI_Gray_Image_mat"
      end
    end
  end, function()
    local _, isGray = BattleSkillUtils.GetCardEnchantSmallIcon(self.runeTid, self.cardUid)
    return isGray
  end)
end

return CardRuneTypeComponent
