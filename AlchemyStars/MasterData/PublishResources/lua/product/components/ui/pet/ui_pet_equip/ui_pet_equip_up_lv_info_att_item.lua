_class("UIPetEquipUpLvInfoAttItem", UICustomWidget)
UIPetEquipUpLvInfoAttItem = UIPetEquipUpLvInfoAttItem

function UIPetEquipUpLvInfoAttItem:Constructor()
  self._elem2str = {
    [1] = "str_pet_filter_water_element",
    [2] = "str_pet_filter_fire_element",
    [3] = "str_pet_filter_sen_element",
    [4] = "str_pet_filter_electricity_element",
    [6] = "str_tale_pet_att_none"
  }
end

function UIPetEquipUpLvInfoAttItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIPetEquipUpLvInfoAttItem:OnHide()
end

function UIPetEquipUpLvInfoAttItem:SetData(data, element)
  self._element = element
  self._lv, self._elem, self._atk, self._def, self._hp = data:GetData()
  self:_OnValue()
end

function UIPetEquipUpLvInfoAttItem:_GetComponents()
  self._desc = self:GetUIComponent("UILocalizationText", "desc")
  self._lvTex = self:GetUIComponent("UILocalizationText", "lv")
end

function UIPetEquipUpLvInfoAttItem:_OnValue()
  self._lvTex:SetText("Lv." .. self._lv)
  local desc = ""
  if self._elem ~= 0 then
    local elementTex = self._elem2str[self._element]
    desc = desc .. StringTable.Get("str_pet_equip_property_restraint_value", StringTable.Get(elementTex)) .. "+" .. self._elem * 100 .. "%"
  end
  if self._atk ~= 0 then
    if self._elem ~= 0 then
      desc = desc .. StringTable.Get("str_common_comma")
    end
    desc = desc .. StringTable.Get("str_pet_equip_attack") .. "+" .. self._atk
  end
  if self._def ~= 0 then
    if self._elem ~= 0 or self._atk ~= 0 then
      desc = desc .. StringTable.Get("str_common_comma")
    end
    desc = desc .. StringTable.Get("str_pet_equip_defence") .. "+" .. self._def
  end
  if self._hp ~= 0 then
    if self._elem ~= 0 or self._atk ~= 0 or self._def ~= 0 then
      desc = desc .. StringTable.Get("str_common_comma")
    end
    desc = desc .. StringTable.Get("str_pet_equip_hp") .. "+" .. self._hp
  end
  desc = desc .. StringTable.Get("str_common_full_stop")
  self._desc:SetText(desc)
end
