local WeaponDetailComp, Super = System.NewComponent("WeaponDetailComp")

function WeaponDetailComp:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Weapon_EntranceResource(uiNode)
  self.model = model
end

function WeaponDetailComp:OnBind(binder)
  self.binder = binder
  local model = self.model
  binder:BindToText(self.ui.Text_Weapon_Name, function()
    do return model.GetWeaponName end
    return model.GetWeaponName, model
  end)
  binder:SetActive(self.ui.UI_Common_Btn_Lock, false)
  binder:BindToText(self.ui.Text_Secondary_Attr, function()
    do return model.GetWeaponAttrName end
    return model.GetWeaponAttrName, model
  end)
  binder:BindToText(self.ui.Text_Secondary_Attr_Value, function()
    do return model.GetWeapponAttrValue end
    return model.GetWeapponAttrValue, model
  end)
  binder:BindToRaw(function(cb, value)
    cb:BindTimer(0.01, 0, nil, function()
      CS.Framework.UIUtilTool.RefreshLayout(self.ui.UI_Awaker_Item_Trinket_List)
    end)
    if "" == value then
      self.ui.Text_Weapon_Desc_1:SetActive(false)
      return
    end
    self.ui.Text_Weapon_Desc_1:SetActive(true)
    binder:SetText(self.ui.Text_Weapon_Desc_1, value)
  end, function()
    do return model.GetStateDesc end
    return model.GetStateDesc, model
  end)
  binder:BindToRaw(function(_, value)
    if "" == value then
      self.ui.Text_Weapon_Desc_2:SetActive(false)
      return
    end
    self.ui.Text_Weapon_Desc_2:SetActive(true)
    binder:SetText(self.ui.Text_Weapon_Desc_2, value)
  end, function()
    do return model.GetExclusiveDesc end
    return model.GetExclusiveDesc, model
  end)
  binder:BindToText(self.ui.Text_Weapon_Desc_Sec, function()
    do return model.GetStory end
    return model.GetStory, model
  end)
  binder:BindToVisible(self.ui.Group_Awaker_Equip, function()
    do return model.HasOwner end
    return model.HasOwner, model
  end)
  binder:BindToImage(self.ui.Icon_Awaker, function()
    do return model.GetAwakerIcon end
    return model.GetAwakerIcon, model
  end)
  binder:BindToText(self.ui.Text_Weapon_Equip, function()
    do return LT.Textf, "TipsAwakerEquip", model:GetAwakerName() end
    return LT.Textf, "TipsAwakerEquip", model:GetAwakerName()
  end)
end

function WeaponDetailComp:OnUnbind()
  Super.OnUnbind(self)
end

return WeaponDetailComp
