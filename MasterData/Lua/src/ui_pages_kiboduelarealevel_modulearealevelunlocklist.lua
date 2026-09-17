local module = class("moduleAreaLevelUnlockList", G_UIModuleBase)
local _areaLeveTpl = L_GameTpl:getKiboDuelAreaLevelTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.unlockContentDatas = {}
end

function module.bind()
  return {
    listUnlock = {
      moduleName = "pages/kiboDuelAreaLevel/cellAreaLevelUnlockItem"
    }
  }
end

function module.methods()
  return {
    listUnlock = {
      onClick = function(self, cell, skillId)
        if self._clickCallback then
          self._clickCallback(cell, skillId)
        end
      end
    }
  }
end

function module:open()
  self:refreshInfo()
end

function module:refreshInfo()
  self.bind.listUnlock:clear()
  self.bind.listUnlock:insert_array(self.unlockContentDatas)
end

local function _ctorUnlockContentItemData(type, params)
  return {contentType = type, conentParams = params}
end

function module:setAreaLevelData(areaType, level)
  local store = L_PetDuelStore
  local skillIds = store:getLevelUnLockSkill(areaType, level) or {}
  local status = store:getAreaLevelStatus(areaType, level)
  local isUnlock = status ~= L_Const.commonRewardStatus.notComp
  local unLockContentDatas = {}
  local tpl = _areaLeveTpl:getTpl(areaType, level)
  local desc = _areaLeveTpl:getKiboDuelDecs(tpl)
  desc = L_Lang:get(desc)
  local isHasContent = false
  if desc ~= "" then
    table.insert(unLockContentDatas, _ctorUnlockContentItemData(store.unlockContentType.level, {content = desc, isUnlock = isUnlock}))
    isHasContent = true
  end
  for _, skillId in ipairs(skillIds) do
    table.insert(unLockContentDatas, _ctorUnlockContentItemData(store.unlockContentType.skill, {skillId = skillId, isUnlock = isUnlock}))
    isHasContent = true
  end
  self.unlockContentDatas = unLockContentDatas
  self:refreshInfo()
  self:SetActive(isHasContent)
end

function module:setClickCallbackFunc(callback)
  self._clickCallback = callback
end

return module
