local UINChristmas22EnvItem = class("UINChristmas22EnvItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINChristmas22EnvItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Reward, self, self.OnClickScoreTask)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.OnClickRank)
  UIUtil.AddButtonListener(self.ui.btn_Select, self, self.OnClickSelect)
  UIUtil.AddButtonListener(self.ui.obj_Locked, self, self.OnClickLocked)
end

function UINChristmas22EnvItem:InitChristmas22EnvItem(hallowmasData, envCfg, selectCallback)
  self._data = hallowmasData
  self._envCfg = envCfg
  self._selectCallback = selectCallback
  self.ui.tex_EnvironmentName.text = LanguageUtil.GetLocaleText(self._envCfg.general_env_name)
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(self._envCfg.general_env_des)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(self._envCfg.general_env_des2)
  self.ui.img_BuffIcon.sprite = CRH:GetSprite(self._envCfg.general_env_icon, CommonAtlasType.ExplorationIcon)
  self:RefreshChristmas22EnvItem()
end

function UINChristmas22EnvItem:BindChristmas22EnvCallback(secotorTaskCallback, rankCallback)
  self._secotorTaskCallback = secotorTaskCallback
  self._rankCallback = rankCallback
end

function UINChristmas22EnvItem:RefreshChristmas22EnvItem()
  self.ui.tex_score:SetIndex(0, tostring(self._data:GetHallowmasEnvScore(self._envCfg.general_env_id)))
  local isUnlock = self._data:IsHallowmasEnvUnlock(self._envCfg.general_env_id)
  self.ui.btn_Reward.gameObject:SetActive(isUnlock and 0 < #self._envCfg.env_task)
  self.ui.btn_Rank.gameObject:SetActive(isUnlock and 0 < self._envCfg.rank_id)
  self.ui.btn_Select.gameObject:SetActive(isUnlock)
  self.ui.score:SetActive(isUnlock)
  self.ui.obj_Locked.gameObject:SetActive(not isUnlock)
  if not isUnlock then
    local conditionList = self._envCfg.preConditions
    if self._envCfg.preConditionsNum > 1 then
      local unlockInfo = LanguageUtil.GetLocaleText(self._envCfg.pre_desc)
      if not string.IsNullOrEmpty(unlockInfo) then
        self._unlockStr = unlockInfo
      else
        self._unlockStr = CheckCondition.GetUnlockInfoLuaByManyList(conditionList)
        self._unlockStr = ConfigData:GetTipContent(8708, self._unlockStr)
      end
    elseif self._envCfg.preConditionsNum == 1 then
      local firstCond = conditionList[1]
      self._unlockStr = CheckCondition.GetUnlockInfoLua(firstCond[1], firstCond[2], firstCond[3])
      self._unlockStr = ConfigData:GetTipContent(8708, self._unlockStr)
    else
      self._unlockStr = ""
    end
    self.ui.tex_unlock.text = self._unlockStr
  end
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  self._isLookedTask = userDataCache:GetHallowmasEnvTaskLooked(self._data:GetActId(), self._envCfg.general_env_id)
  self.ui.task_blueDot:SetActive(not self._isLookedTask)
end

function UINChristmas22EnvItem:OnClickRank()
  if self._envCfg.rank_id <= 0 then
    return
  end
  if self._rankCallback ~= nil then
    self._rankCallback(self._envCfg.rank_id)
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonRank, function(rankWindow)
    if rankWindow == nil then
      return
    end
    rankWindow:InitCommonRank(self._envCfg.rank_id)
  end)
end

function UINChristmas22EnvItem:OnClickScoreTask()
  if self._secotorTaskCallback ~= nil then
    self._secotorTaskCallback(self._envCfg)
  end
  if not self._isLookedTask then
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    userDataCache:SetHallowmasEnvTaskLooked(self._data:GetActId(), self._envCfg.general_env_id)
    self.ui.task_blueDot:SetActive(false)
    self._isLookedTask = true
  end
end

function UINChristmas22EnvItem:OnClickSelect()
  if self._selectCallback ~= nil then
    self._selectCallback(self._envCfg.general_env_id)
  end
end

function UINChristmas22EnvItem:OnClickLocked()
  cs_MessageCommon.ShowMessageTips(self._unlockStr)
end

function UINChristmas22EnvItem:GetChristmasEnvCfg()
  return self._envCfg
end

function UINChristmas22EnvItem:SetChristmasEnvTaskRed(active)
  self.ui.task_redDot:SetActive(active)
  if not self._isLookedTask then
    self.ui.task_blueDot:SetActive(not active)
  end
end

return UINChristmas22EnvItem
