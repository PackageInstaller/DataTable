_class("Item", Object)
Item = Item

function Item:Constructor(fac, data)
  self.m_data = data
  self.m_template_data = Cfg.cfg_item[data.template_id]
  Log.assert(self.m_template_data ~= nil, "Item:Constructor error template_id", data.template_id)
  self.m_new_max_level = Cfg.cfg_global.ui_backpack_new_max_level.IntValue
  if self.m_template_data == nil then
    Log.error("Item:Constructor cant find tempate ", data.template_id)
  end
  self.m_ext = fac:Alloc(self.m_template_data.ItemSubType)
  if self.m_ext ~= nil and data.custom_data then
    local ret, msg = lua_dc.LoadStream(self.m_ext._className, data.custom_data, self.m_ext)
    if ret == nil then
      Log.error("Item Constructor lua_dc.LoadStream error ", self.m_ext._className, msg)
    end
  end
end

function Item:GetExt()
  return self.m_ext
end

function Item:GetID()
  return self.m_data.item_pstid
end

function Item:GetTemplate()
  return self.m_template_data
end

function Item:GetTemplateID()
  return self.m_data.template_id
end

function Item:GetData()
  return self.m_data
end

function Item:SetData(data)
  self.m_data = data
end

function Item:GetCount()
  return self.m_data.count
end

function Item:GetFlagStatus()
  return self.m_data.flags == 1
end

function Item:GetGainTime()
  return self.m_data.gain_time
end

function Item:IsNew()
  local flag = self.m_data.flags & ItemDataFlags.Item_Flag_Is_New_Obtain > 0
  return flag
end

function Item:IsNewFurniture()
  if self.m_template_data.ItemSubType ~= ItemSubType.ItemSubType_Furniture then
    return false
  end
  return self.m_data.flags & ItemDataFlags.Item_Flag_Is_New_Furniture > 0
end

function Item:IsNewOverlay()
  return self.m_data.flags & ItemDataFlags.Item_Flag_Is_New_Overlay > 0
end

function Item:IsHomelandNew()
  return self.m_data.flags & ItemDataFlags.Item_Flag_Is_New_Obtain > 0
end

function Item:SetOldFurniture()
  if self.m_template_data.ItemSubType ~= ItemSubType.ItemSubType_Furniture then
    return
  end
  local nMask = ~ItemDataFlags.Item_Flag_Is_New_Furniture
  self.m_data.flags = self.m_data.flags & nMask
end

function Item:IsAwakeDirectlyItem()
  return self.m_template_data.UseEffect and string.find(self.m_template_data.UseEffect, "AwakeGift")
end
