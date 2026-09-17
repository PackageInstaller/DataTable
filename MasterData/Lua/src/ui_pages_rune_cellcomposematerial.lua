local this = class("cellComposeMaterial", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function this.bind()
  return {
    img_iconFilter = nil,
    emptyActive = false,
    cellActive = false,
    cellIconCircle = L_Const.ModuleInfo.CellIconCircle
  }
end

function this.methods()
  return {
    cellIconCircle = {
      onClick = function(self)
        local targetNum = self.bind.needNum
        if targetNum < 1 then
          targetNum = 1
        end
        self:emit("onClick_item", {
          index = self.bind.index,
          itemId = self.itemId,
          targetNum = targetNum,
          hadNum = self.bind.hadNum
        })
      end
    }
  }
end

function this:refresh()
  self.bind.cellActive = self.bind.itemId ~= nil
  self.bind.emptyActive = self.bind.itemId == nil
  if self.bind.emptyActive then
    return
  end
  local commonItemTpl = _commonItemTpl:getTplById(self.bind.itemId)
  self.bind.img_iconFilter = commonItemTpl and _commonItemTpl:getFilterIcon(commonItemTpl) or ""
  local hadNum = self.bind.hadNum
  local needNum = self.bind.needNum
  self.targetNum = self.bind.needNum
  self.hadNum = self.bind.hadNum
  self.itemId = self.bind.itemId
  self.modules.cellIconCircle:setGeneralContent(self.bind.itemType, self.bind.itemId, {
    itemNum = needNum,
    itemReduceNum = hadNum,
    isGoldFrame = hadNum >= needNum,
    noTip = true
  })
end

function this:isSatisfy()
  if self.bind.hadNum and self.bind.needNum then
    return self.bind.hadNum >= self.bind.needNum
  end
  return true
end

return this
