_class("UIActivityN4CCAffixSelectColumn", UICustomWidget)
UIActivityN4CCAffixSelectColumn = UIActivityN4CCAffixSelectColumn

function UIActivityN4CCAffixSelectColumn:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityN4CCAffixSelectColumn:InitWidget()
  self.affixItems = {}
  for i = 1, 3 do
    local rowPool = self:GetUIComponent("UISelectObjectPath", "row" .. i)
    local item = rowPool:SpawnObject("UIActivityN4CCAffixSelectItem")
    table.insert(self.affixItems, item)
  end
  self.animation = self:GetUIComponent("Animation", "animation")
  self.rootGo = self:GetGameObject("root")
  self.rootGo:SetActive(true)
end

function UIActivityN4CCAffixSelectColumn:SetData(itemCollector, data, clickCb)
  if #data ~= #self.affixItems then
    Log.error("UIActivityN4CCAffixSelectColumn data num err ", #data)
    return
  end
  for i, item in ipairs(self.affixItems) do
    table.insert(itemCollector, item)
    item:SetData(data[i], clickCb)
  end
end

function UIActivityN4CCAffixSelectColumn:PlayEnterAni()
  self.rootGo:SetActive(true)
  self.animation:Play("uianim_UIActivityN4CCAffixSelectColumn_in")
end
