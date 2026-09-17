local this = class("cellSelectFishingGear", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _fishRodTpl = L_GameTpl:getFishRodTpl()
local _fishRodBuffTpl = L_GameTpl:getFishRodBuffTpl()

function this.bind()
  return {
    go_select = false,
    go_emptyOffset = false,
    module_bagTip = {
      moduleName = "pages/bag/moduleBagTip"
    }
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      self:emit("onClick_select", self.bind)
    end
  }
end

function this:open()
  this.super.open(self)
  self:initCell()
end

function this:initCell()
  if not self.isBind then
    return
  end
  self:refreshView()
end

function this:setSelect(isSelect)
  self.bind.go_select = isSelect
end

function this:refreshView()
  if not self.isBind then
    return
  end
  local tpl_commonItem = _commonItemTpl:getTplById(self.bind.guid)
  local needShowOffset = true
  if _commonItemTpl:getType(tpl_commonItem) == L_BagConst.bagItemType.fishingRod then
    local subId = _commonItemTpl:getSubId(tpl_commonItem)
    local tpl_rod = _fishRodTpl:getTplById(subId)
    local buffInfo = _fishRodTpl:getBuffInfo(tpl_rod)
    for i, v in pairs(buffInfo) do
      local tpl_buff = _fishRodBuffTpl:getTplById(v)
      local pondIdList = _fishRodBuffTpl:getPondId(tpl_buff)
      local node, index = table.ipairsFind(pondIdList, function(id)
        return id == self.bind.fishPondId
      end)
      if index then
        needShowOffset = false
        break
      end
    end
  end
  self.bind.go_emptyOffset = needShowOffset
  local moduleBagTip = self.modules.module_bagTip
  moduleBagTip:setData(self.bind.type, self.bind.guid, {
    fishPondId = self.bind.fishPondId
  })
end

return this
