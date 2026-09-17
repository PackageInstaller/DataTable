local this = class("cellDomainItem", G_UIModuleBase)

function this.bind()
  return {
    txt_name = nil,
    img_icon = nil,
    localPosition_position = Unity.Vector3.zero,
    select = false,
    goNew = false,
    list_collectReward = L_Const.ModuleInfo.CellIcon,
    go_collectReward = false
  }
end

function this.methods()
  return {
    onClick_selectDomain = function(self)
      self:emit("onClick_selectDomain", self.bind.config, self.bind.areaPos)
    end,
    onClick_collectReward = function(self)
      local tmp = {}
      for i, v in pairs(self.modules.list_collectReward) do
        if not v.bind.activeDisable then
          table.insert(tmp, v.bind.collectionId)
        end
      end
      if not table.isEmpty(tmp) then
        L_CollectionManager:reqCollectReward(tmp, nil)
      end
    end
  }
end

function this:open()
  this.super.open(self)
end

function this:close()
  self:closeRefreshTimer()
end

function this:refresh()
end

function this:setSelect(b)
  self.bind.select = b
end

function this:openRefreshTimer()
  local domainTpl = L_GameTpl:getDomainTpl()
  local collections = {}
  if not table.isEmpty(collections) then
    self:closeRefreshTimer()
    
    local function func()
      self:refreshCollectReward()
      self:setParentAutoCollectBtnMask()
    end
    
    self.refreshTimer = Timer.repeated(1, func, self, self.uiBinding)
    func()
  end
end

function this:setParentAutoCollectBtnMask()
  local autoCollectBtnMask = true
  for i, v in pairs(self.modules.list_collectReward) do
    if not v.bind.activeDisable then
      autoCollectBtnMask = false
    end
  end
  self.parent.bind.go_btn_autoCollect_mask = autoCollectBtnMask
end

function this:closeRefreshTimer()
  if not self.refreshTimer then
    return
  end
  self.refreshTimer:destroy()
  self.refreshTimer = nil
end

function this:refreshCollectReward()
end

function this:initCollectRewardList()
end

return this
