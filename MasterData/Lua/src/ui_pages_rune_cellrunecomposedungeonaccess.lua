local this = class("cellRuneComposeDungeonAccess", G_UIModuleBase)
local _dungeonEntrustTpl = L_GameTpl:getDungeonEntrustTpl()
local _dungeonMaterialTpl = L_GameTpl:getDungeonMaterialTpl()
local _dungeonEntrustTypeTpl = L_GameTpl:getDungeonEntrustTypeTpl()
local StarIconEnum = {
  [3] = "UI/Page/EntrustTask/tex_dungeonentrust_icon_wz06",
  [2] = "UI/Page/EntrustTask/tex_dungeonentrust_icon_wz05",
  [1] = "UI/Page/EntrustTask/tex_dungeonentrust_icon_wz04",
  [0] = "UI/Page/EntrustTask/tex_dungeonentrust_icon_wz07"
}

function this.bind()
  return {
    txt_name = "",
    txt_lockName = "",
    txt_level = "",
    img_icon = "",
    go_img_icon = false,
    go_lock_icon = false,
    go_lock_name = false,
    go_unlock_name = true
  }
end

function this.methods()
  return {
    onClick = function(self)
      print("========================跳转")
      self:emit("onClick", {
        entrustType = L_Const.EntrustTypeEnum.AreaEntrust,
        dungeonType = self.bind.dungeonType or "entrust",
        runeId = self.bind.runeId,
        itemId = self.bind.itemId,
        selectId = self.bind.dungeonId,
        needTargetNum = self.bind.needTargetNum
      })
    end
  }
end

function this:refresh()
  local dungeonId = self.bind.dungeonId
  local dungeonType = self.bind.dungeonType or "entrust"
  local name = ""
  local recLv = 0
  local strTips = ""
  if dungeonType == "material" then
    local matCfg = _dungeonMaterialTpl:getTplById(dungeonId)
    if matCfg then
      name = _dungeonMaterialTpl:getName(matCfg)
      recLv = _dungeonMaterialTpl:getRecommendLevel(matCfg)
      local unlockCond = _dungeonMaterialTpl:getUnlock(matCfg)
      local isComplete = true
      local failCondId
      for _, cond in ipairs(unlockCond) do
        local csList = CS.System.Collections.Generic.List(CS.System.Int32)()
        for _, v in ipairs(cond) do
          csList:Add(v)
        end
        local condId = AzurWorld.ConditionMgr:CreateCond(csList, nil)
        if not AzurWorld.ConditionMgr:CheckCond(condId) then
          isComplete = false
          failCondId = condId
          break
        end
      end
      if not isComplete then
        local condObj = AzurWorld.ConditionMgr:GetCond(failCondId)
        strTips = condObj and condObj:ShowMsg() or ""
      end
    end
  else
    name = _dungeonEntrustTpl:getName(_dungeonEntrustTpl:getTplById(dungeonId))
    recLv = _dungeonEntrustTpl:getRecommendLevel(_dungeonEntrustTpl:getTplById(dungeonId))
    local isComplete2, tips = L_EntrustStore:checkEntrustLevelUnlock(dungeonId)
    local tpl = _dungeonEntrustTypeTpl:getTplById(L_Const.EntrustTypeEnum.AreaEntrust)
    local unlockId = _dungeonEntrustTypeTpl:getSystemUnLockId(tpl)
    strTips = tips or C_IntegrateMgr.SystemUnlockModule:getSystemUnlockConditionDesc(unlockId)
  end
  self.bind.txt_name = name
  self.bind.txt_lockName = name
  local starNum = L_EntrustStore:getEntrustLevelStar(dungeonId)
  self.bind.img_icon = StarIconEnum[starNum]
  if self.bind.bUnlock then
    self.bind.txt_level = L_WordsTpl:getValue("residual_code_cellrunecomposedungeonaccess_01") .. recLv
  else
    self.bind.txt_level = strTips
  end
  self.bind.go_lock_icon = not self.bind.bUnlock
  self.bind.go_lock_name = not self.bind.bUnlock
  self.bind.go_unlock_icon = self.bind.bUnlock
  self.bind.go_unlock_name = self.bind.bUnlock
  self.bind.go_img_icon = self.bind.bUnlock
  self.bind.go_lock_icon = not self.bind.bUnlock
end

return this
