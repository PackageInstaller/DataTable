_class("SeasonMazeCollageData", UICustomWidget)
SeasonMazeCollageData = SeasonMazeCollageData

function SeasonMazeCollageData:Constructor()
  self._cfgId = 0
  self._cfg = nil
  self._unLockLv = 0
  self._bNew = false
  self._bUnlock = false
  self._bPreConditionUnlock = true
end

function SeasonMazeCollageData:SetData(cfgId, type, cfg, unLockLv)
  self._cfgId = cfgId
  self._type = type
  self._cfg = cfg
  self._unLockLv = unLockLv
  self._hasReadNew = false
end

function SeasonMazeCollageData:GetCfgId()
  return self._cfgId
end

function SeasonMazeCollageData:GetCfg()
  return self._cfg
end

function SeasonMazeCollageData:GetShowOrder()
  return self._cfg.ShowOrder
end

function SeasonMazeCollageData:GetUnLockLv()
  return self._unLockLv
end

function SeasonMazeCollageData:GetNew()
  return self._bNew
end

function SeasonMazeCollageData:GetPreConditionUnlock()
  return self._bPreConditionUnlock, self._unlockLevel
end

function SeasonMazeCollageData:GetUnlock()
  return self._bUnlock
end

function SeasonMazeCollageData:CheckState(moneyLv, preConditionTable)
  self._bNew = false
  self._bPreConditionUnlock = preConditionTable.OK
  self._unlockLevel = preConditionTable.UnlockLevel
  if not self._bPreConditionUnlock then
    self._bUnlock = false
    return
  end
  self._bUnlock = moneyLv >= self._unLockLv
  if not self._bUnlock then
    return
  end
  if not self:_HasReadNew() then
    self._bNew = true
  end
end

function SeasonMazeCollageData:SetNewAsRead()
  self._bNew = false
  local key = self:_GetPrefKey()
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end

function SeasonMazeCollageData:_GetPrefKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local playerPrefsKey = pstId .. "collageNew_" .. self._type .. "_" .. self._cfgId
  return playerPrefsKey
end

function SeasonMazeCollageData:_HasReadNew()
  local key = self:_GetPrefKey()
  if self._hasReadNew then
    return self._hasReadNew
  end
  self._hasReadNew = UnityEngine.PlayerPrefs.HasKey(key)
  return self._hasReadNew
end
