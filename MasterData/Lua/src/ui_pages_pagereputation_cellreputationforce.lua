local this = class("cellReputationForce", G_UIModuleBase)
local _groupsTpl = L_GameTpl:getGroupsTpl()
local _reputationLevelTpl = L_GameTpl:getReputationLevelTpl()
local DarkenSafeHelper = CS.Lens.Framework.UI.UIDarkenSafeHelper

function this:open()
  self:refreshView()
end

function this.bind()
  return {
    fillAmountSatiety = nil,
    txtLevel = "",
    txtName = "",
    txtProcress = "",
    tfmProcress = true,
    imgPhoto = nil,
    imgForce = nil,
    imgSelected = false,
    imgUnSelected = false
  }
end

function this.methods()
  return {
    onClickBg = function(self)
      if self.bind.clickCb ~= nil then
        self.bind.clickCb(self)
      end
    end
  }
end

function this:refreshView()
  local forceId = self.bind.forceId
  local reputationItem = L_ReputationStore:getDataById(forceId)
  local lv = reputationItem and reputationItem.level or 1
  local curReputation = reputationItem and reputationItem.value or 0
  self.bind.txtLevel = tostring(lv)
  local groupsTpl = _groupsTpl:getTplById(forceId)
  if groupsTpl == nil then
    return
  end
  local reputationLevelTpl = _reputationLevelTpl:getTplByForceLv(forceId, lv)
  if reputationLevelTpl == nil then
    return
  end
  self.bind.imgForce = _groupsTpl:getIcon(groupsTpl, L_Const.nationTextureIndex.nationLarge)
  self.bind.imgPhoto = _groupsTpl:getReputationTabIcon(groupsTpl)
  self.bind.txtName = groupsTpl.name
  self.bind.fillAmountSatiety = curReputation / reputationLevelTpl.reputationNeed
  local tempTxtProcress
  if reputationLevelTpl.reputationNeed == nil or reputationLevelTpl.reputationNeed == 0 then
    tempTxtProcress = ""
  else
    tempTxtProcress = tostring(curReputation) .. "/" .. tostring(reputationLevelTpl.reputationNeed)
  end
  self.bind.txtProcress = tempTxtProcress
  self.bind.imgSelected = self._isSelected
  self.bind.imgUnSelected = not self._isSelected
  self.bind.tfmProcress = self._isSelected
end

function this:setSelected(isSelected)
  self._isSelected = isSelected
  self.bind.imgSelected = self._isSelected
  self.bind.imgUnSelected = not self._isSelected
  self.bind.tfmProcress = self._isSelected
end

return this
