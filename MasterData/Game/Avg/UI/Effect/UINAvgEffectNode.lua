local UINAvgEffectNode = class("UINAvgEffectNode", UIBaseNode)
local base = UIBaseNode
local UINAvgEffectItem = require("Game.Avg.UI.Effect.UINAvgEffectItem")
local CS_ResLoader = CS.ResLoader

function UINAvgEffectNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.effectItem:SetActive(false)
  self.effectItemPool = UIItemPool.New(UINAvgEffectItem, self.ui.effectItem)
  self.effectItemDic = {}
  self.resLoader = CS_ResLoader.Create()
  self.avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
end

function UINAvgEffectNode:PlayAvgEffect(effectCfg)
  if effectCfg == nil then
    return
  end
  local layer = effectCfg.layer or 2
  if layer > #self.ui.layerList or layer < 1 then
    self.avgCtrl:AvgLogError("Avg effect layer error, layer = " .. tostring(layer))
    return
  end
  local stopList
  for k, v in pairs(effectCfg) do
    if k == "stopList" then
      stopList = v
    else
      local effectItem = self.effectItemDic[k]
      if effectItem == nil then
        local parent = self.ui.layerList[layer]
        local effectItem = self.effectItemPool:GetOne()
        effectItem:InitAvgEffectItem(k, v.prefabName, self.resLoader, v.pos, parent)
        self.effectItemDic[k] = effectItem
      else
        effectItem:PlayAvgEffect()
      end
    end
  end
  if stopList ~= nil then
    for k, id in pairs(stopList) do
      local effectItem = self.effectItemDic[id]
      if effectItem ~= nil then
        effectItem:StopAvgEffect()
      end
    end
  end
end

function UINAvgEffectNode:OnDelete()
  self.resLoader:Put2Pool()
  self.resLoader = nil
  self.effectItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINAvgEffectNode
