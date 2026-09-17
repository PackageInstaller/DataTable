local this = class("cellReputationRewards", G_UIModuleBase)
local _reputationLevelTpl = L_GameTpl:getReputationLevelTpl()

function this:open()
  self:refreshView()
end

function this.bind()
  return {
    listTab = {
      moduleName = "pages/pageReputation/cellReputationItem"
    },
    tfmCheck = false,
    txtlv = "",
    selectBg = false,
    img_pen = false,
    img_lock = false
  }
end

function this.methods()
  return {
    listTab = {
      onClick_select = function(self, bind, pos)
        self._selectIndex = bind.index
        self:emit("onClick_select", bind, pos)
      end
    }
  }
end

function this:refreshView()
  local reputationTpl = self.bind.reputationTpl
  local reputationItem = L_ReputationStore:getDataById(reputationTpl.reputationId)
  local lv = reputationItem and reputationItem.level or 1
  self.bind.txtlv = tostring(reputationTpl.reputationlevel)
  local isLvSatisfy = lv >= reputationTpl.reputationlevel
  self.bind.tfmCheck = isLvSatisfy
  if isLvSatisfy and lv == reputationTpl.reputationlevel then
    self.bind.img_pen = true
    self.bind.selectBg = true
    self.bind.img_lock = false
  elseif isLvSatisfy then
    self.bind.img_pen = false
    self.bind.selectBg = false
    self.bind.img_lock = false
  else
    self.bind.img_pen = false
    self.bind.selectBg = false
    self.bind.img_lock = true
  end
  local unlockContent = _reputationLevelTpl:getAllUnlockContent(reputationTpl)
  if self.bind.listTab then
    self.bind.listTab:clear()
  end
  for k, v in ipairs(unlockContent) do
    function v.callback(cell)
      self.bind.cellClickCb(reputationTpl.reputationlevel, cell.bind.id)
    end
  end
  self.bind.listTab:insert_array(unlockContent)
end

function this:clearSelect()
  if not self.isBind then
    return
  end
  for i, v in pairs(self.modules.listTab) do
    v:setSelected(false)
  end
end

function this:setSelected(lv, rewardId)
  if self.modules.listTab == nil then
    return
  end
  for k, v in pairs(self.modules.listTab) do
    local cell = v
    cell:setSelected(self.bind.reputationTpl.reputationlevel == lv and rewardId == v.bind.id)
  end
end

return this
