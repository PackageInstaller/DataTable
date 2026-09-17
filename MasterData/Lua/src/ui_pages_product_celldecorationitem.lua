local this = class("cellDecorationItem", G_UIModuleBase)

function this.bind()
  return {
    grid = {
      moduleName = "pages/product/cellProduceTarget"
    },
    active_lock = false,
    txt_lock = "",
    bannerIcon = "",
    gridActive = false,
    emptyNodeAcitve = false,
    bannerActive = true,
    lineActive = true,
    selectInteractable = true
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      if self.bind.active_lock then
        return
      end
      self:emit("onClick_select", self.bind.isOpen and 0 or self.bind.seriesId)
      self:refresh()
      if self._callback then
        self._callback()
      end
    end,
    grid = {
      onClick_select = function(self, bind)
        self:emit("onClick_selectTarget", bind)
        for i = 1, #self.bind.grid do
          self.bind.grid:change(i, {
            selectIconActive = self.bind.grid:getValue(i, "id") == bind.id
          })
        end
      end
    }
  }
end

function this:refresh()
  self.bind.emptyNodeAcitve = self.bind.isEmpty
  self.bind.bannerActive = not self.bind.isEmpty
  self.bind.lineActive = not self.bind.isEmpty
  if self.bind.isEmpty then
    self.bind.selectInteractable = false
    return
  end
  local homeDecorationSeriesTpl = L_GameTpl:getHomeDecorationSeriesTpl()
  local tpl = homeDecorationSeriesTpl:getTplById(self.bind.seriesId)
  if L_DeviceTpl:getIsPc() then
    self.bind.bannerIcon = homeDecorationSeriesTpl:getBannerPc(tpl)
  else
    self.bind.bannerIcon = homeDecorationSeriesTpl:getBannerPortable(tpl)
  end
  local condition = homeDecorationSeriesTpl:getUnlockCondition(tpl)
  local unlock, _, lockIndex = L_ConditionManager:isComplete(condition)
  self.bind.active_lock = not unlock
  self.bind.selectInteractable = unlock
  if not unlock then
    local lockDes = L_ConditionManager:getDescs(condition)
    self.bind.txt_lock = lockDes[lockIndex]
  end
  self:refreshItems()
end

function this:refreshItems()
  self.bind.grid:clear()
  self.bind.gridActive = self.bind.isOpen
  if self.bind.isOpen then
    local colNum = L_DeviceTpl:getIsPc() and 6 or 5
    self.bindComponents.gridLayout.constraintCount = colNum
    local boxNum = math.ceil(#self.bind.products / colNum) * colNum
    local diff = boxNum - #self.bind.products
    if 0 < diff then
      for _ = 1, diff do
        table.insert(self.bind.products, {})
      end
    end
    self.bind.grid:insert_array(self.bind.products)
  end
  Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
end

return this
