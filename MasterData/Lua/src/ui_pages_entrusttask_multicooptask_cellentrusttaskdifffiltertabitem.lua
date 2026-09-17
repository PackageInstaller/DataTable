local module = class("cellEntrustTaskDiffFilterTabItem", G_UIModuleBase)
local _dungeonCrisisCrusadeTpl = L_GameTpl:getDungeonCrisisCrusadeTpl()
local _dungeonCrisisCrusadeDiffTagTpl = L_GameTpl:getDungeonCrisisCrusadeDiffTagTpl()

function module.bind()
  return {
    active_unselected = true,
    active_locked = false,
    txt_recommendLevel = "",
    img_diffIcon = "",
    img_diffIconSelected = "",
    img_diffIconLocked = "",
    alpha_diffIconLocked = C_Color(1, 1, 1, 0.4),
    enable_tableItem = true,
    diffId = -1,
    moduleRewardUp = {
      moduleName = "pages/gameAct/doubleDrop/moduleRewardUp"
    },
    active_dots = false,
    go_lockButton = false,
    go_redDot = false
  }
end

function module.methods()
  return {
    onClick_lock = function(self)
      if self.isLock then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pageMultiDungeonMatching_26", {
          [0] = self.unlockLevel
        }))
      else
      end
    end
  }
end

function module:open()
  self.bind.diffId = self.bind.id
  self:initSpecialEntrustList()
  local tpl = _dungeonCrisisCrusadeDiffTagTpl:getTplById(self.bind.id)
  local playerInfo = L_PlayerStore:getPlayerBaseInfo()
  local lv, isMaxLv = L_FriendStore:getPlayerLevel(playerInfo)
  local unlockLevel = _dungeonCrisisCrusadeDiffTagTpl:getUnlockLevel(tpl)
  self.bind.active_unselected = lv >= unlockLevel
  self.bind.active_locked = lv < unlockLevel
  self.bind.enable_tableItem = lv >= unlockLevel
  self.bind.go_lockButton = lv < unlockLevel
  self.isLock = lv < unlockLevel
  self.unlockLevel = unlockLevel
  self.bind.txt_recommendLevel = _dungeonCrisisCrusadeDiffTagTpl:getRecLevelText(tpl)
  local imgPath = _dungeonCrisisCrusadeDiffTagTpl:getIconPath(tpl)
  local imgLockPath = _dungeonCrisisCrusadeDiffTagTpl:getLockIconPath(tpl)
  self.bind.img_diffIcon = imgPath
  self.bind.img_diffIconSelected = imgPath
  self.bind.img_diffIconLocked = imgPath
  self.bind.active_dots = self.bind.diffId < 6
  self.modules.moduleRewardUp:setEntrustType(0)
  local need = self:refreshRedDot()
  self.bind.go_redDot = need
end

function module:getId()
  return self.bind.id
end

function module:clearRedPoint()
  local data = _dungeonCrisisCrusadeTpl:getTplListByDiffTag(self.bind.id)
  for _, v in ipairs(data) do
    if self:checkIsSpecial(v.id) and self:checkIsSpecialShow(v.id) then
      L_ReddotManager:clearNew(L_ReddotManager.DotDef.EntrustMultiTaskDifficulty, v.id)
      self.bind.go_redDot = false
      AzurWorld.RedDotMgr:ClearNew(string.format(L_ReddotManager.DotDef.EntrustMultiTaskDifficulty, v.id))
      AzurWorld.RedDotMgr:MarkDirty("DungeonEntrustCrisisCrusade")
    end
  end
end

function module:refreshRedDot()
  local data = _dungeonCrisisCrusadeTpl:getTplListByDiffTag(self.bind.id)
  local need_show_red = false
  for _, v in ipairs(data) do
    if self:checkIsSpecial(v.id) and self:checkIsSpecialShow(v.id) and L_ReddotManager:haveNew(L_ReddotManager.DotDef.EntrustMultiTaskDifficulty, v.id) then
      need_show_red = true
      break
    end
  end
  return need_show_red
end

function module:checkIsSpecial(levelId)
  local dungeonEntrustCfg = _dungeonCrisisCrusadeTpl:getTplById(levelId)
  return _dungeonCrisisCrusadeTpl:getEntrustType(dungeonEntrustCfg) == L_Const.EntrustTypeEnum.SpecialEntrust
end

function module:checkIsSpecialShow(levelId)
  if not self.specialEntrustList then
    return false
  end
  for i, v in ipairs(self.specialEntrustList) do
    if levelId == v then
      return true
    end
  end
  return false
end

function module:initSpecialEntrustList()
  local _specialEntrustList = C_MultiTeam.GetLimiteEntrust()
  self.specialEntrustList = {}
  for i = 0, _specialEntrustList.Count - 1 do
    local specialIevelId = _dungeonCrisisCrusadeTpl:getLevelIdByDungeonId(_specialEntrustList[i])
    if specialIevelId ~= 0 then
      table.insert(self.specialEntrustList, specialIevelId)
    end
  end
end

return module
