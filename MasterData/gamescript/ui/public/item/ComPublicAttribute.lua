local ComPublicAttribute, Super = System.NewComponent("ComPublicAttribute")

function ComPublicAttribute:ctor(res, datas, clickCB)
  Super.ctor(self)
  self.ui = Com_Public_AttributeResource(res)
  self.datas = datas
  self.clickCB = clickCB
  self.items = {}
  self.notUseItems = {}
end

local function GetPercent(data)
  local num = data.val
  if not data.isPercent then
    return num
  end
  return math.floor(num * 100) .. "%"
end

function ComPublicAttribute:OnBind(binder)
  self.binder = binder
  for i = 1, 5 do
    local obj = self.ui["Item_Public_Attribute_" .. i]
    local active = true
    local data = self.datas and self.datas[i] or {}
    local val = 0
    if not data then
      active = false
    else
      val = GetPercent(data)
    end
    self.items[i] = binder:BindComponent(ItemPublicAttribute(obj, val, "", data.showText, data.icon, active))
    obj:SetActive(active)
  end
end

function ComPublicAttribute:UpdateDates(datas)
  for index, attrData in ipairs(datas) do
    if attrData then
      local item = self.items[index]
      if item then
        local val = GetPercent(attrData)
        item:UpdateCurrentAttribute(val)
        item:UpdateCurrentAttribute2(val)
        if item.active == false then
          item:UpdateShown(attrData.showText, attrData.icon)
          item:SetVisible(true)
        end
      end
    end
  end
end

function ComPublicAttribute:UpdateDatesInAnim(datas)
  for index, attrData in ipairs(datas) do
    if attrData then
      local item = self.items[index]
      if item then
        local val = GetPercent(attrData)
        item:UpdateCurrentAttributeInAnim(val)
        if item.active == false then
          item:UpdateShown(attrData.showText, attrData.icon)
          item:SetVisible(true)
        end
      end
    end
  end
end

function ComPublicAttribute:UpdateAddDates(datas)
  for index, attrData in ipairs(datas) do
    if attrData then
      local item = self.items[index]
      if item then
        local val = 0
        if attrData.val > 0 then
          val = GetPercent(attrData)
        end
        item:UpdateAddAttribute(val)
        if item.active == false then
          item:UpdateShown(attrData.showText, attrData.icon)
          item:SetVisible(true)
        end
      end
    end
  end
end

function ComPublicAttribute:GetDates()
  local datas = {}
  for _, item in pairs(self.items) do
    if item then
      table.insert(datas, item:GetCurrentAttr())
    end
  end
  return datas[1], datas[2], datas[3], datas[4] or 0, datas[5] or 0
end

return ComPublicAttribute
