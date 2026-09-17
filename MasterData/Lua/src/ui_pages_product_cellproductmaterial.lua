local this = class("cellProductMaterial", G_UIModuleBase)
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local ViewIndex2LocalPos = {
  [1] = C_Vector2(-284.6, 203),
  [2] = C_Vector2(-220.2, 71.3),
  [3] = C_Vector2(-42.1, 33.9),
  [4] = C_Vector2(105.9, 49.7),
  accessory = C_Vector2(-246.9, 224.1)
}

function this.bind()
  return {
    anchorPos = nil,
    img_iconFilter = nil,
    emptyActive = true,
    cellActive = false,
    cellIconCircle = L_Const.ModuleInfo.CellIconCircle,
    scale_iconRoot = C_Vector3(0.68, 0.68, 0.68),
    pos_matNum = C_Vector2(39, -35),
    pos_btn_reset = C_Vector2(120.29, 106.28)
  }
end

function this.methods()
  return {
    cellIconCircle = {
      onClick = function(self)
        if self.bind.changeCallback then
          self.bind.changeCallback()
          return
        end
        if self.bind.isEmpty then
          return
        end
        local parentTab = {
          parentId = self.bind.parentId,
          parentPageGuid = self.bind.guid,
          fromBuildId = self.bind.fromBuildId
        }
        L_ItemTplManager:showInfoTip(self.bind.itemType, self.bind.itemId, self.bind.guid, parentTab)
      end,
      onClick_transform = function(self)
        self.bind.changeCallback()
      end
    }
  }
end

function this:refresh()
  if self.bind.itemId == -1 then
    self.bind.itemId = nil
  end
  self.bind.cellActive = self.bind.itemId ~= nil
  self.bind.emptyActive = self.bind.itemId == nil
  self.modules.cellIconCircle:setBtnTransActive(self.bind.itemId ~= nil)
  if self.bind.emptyActive then
    return
  end
  local commonItemTpl = _commonItemTpl:getTplById(self.bind.itemId)
  self.bind.img_iconFilter = commonItemTpl and _commonItemTpl:getFilterIcon(commonItemTpl) or ""
  local hadNum = self.bind.hadNum
  local needNum = self.bind.needNum
  self.modules.cellIconCircle:setGeneralContent(self.bind.itemType, self.bind.itemId, {itemNum = needNum, itemReduceNum = hadNum})
end

function this:refreshChangeCallback(changeCallback)
  if self.bind then
    self.bind.changeCallback = changeCallback
  end
  self.modules.cellIconCircle:setBtnTransCallback(changeCallback)
  self.modules.cellIconCircle:setNoTip(changeCallback ~= nil)
end

function this:refreshCellAnchorPos(viewIndex)
  if viewIndex == "accessory" then
    self.bind.anchorPos = ViewIndex2LocalPos.accessory
    self.bind.scale_iconRoot = C_Vector3(1, 1, 1)
    self.bind.pos_btn_reset = C_Vector2(129.5, 124.1)
    self.bind.pos_matNum = C_Vector2(53.6, -49.3)
  else
    self.bind.anchorPos = ViewIndex2LocalPos[viewIndex]
    self.bind.scale_iconRoot = C_Vector3(0.68, 0.68, 0.68)
    self.bind.pos_btn_reset = C_Vector2(120.29, 106.28)
    self.bind.pos_matNum = C_Vector2(39, -35)
  end
end

function this:isSatisfy()
  if self.bind.itemId and self.bind.hadNum and self.bind.needNum then
    return self.bind.hadNum >= self.bind.needNum
  end
  return true
end

return this
