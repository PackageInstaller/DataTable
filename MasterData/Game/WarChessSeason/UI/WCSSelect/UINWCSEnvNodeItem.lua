local UINWCSEnvNodeItem = class("UINWCSEnvNodeItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINWCSEnvNodeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Reward, self, self.OnClickScoreTask)
  UIUtil.AddButtonListener(self.ui.btn_Rank, self, self.OnClickRank)
  UIUtil.AddButtonListener(self.ui.btn_Select, self, self.OnClickSelect)
  UIUtil.AddButtonListener(self.ui.btn_Locked, self, self.OnClickLocked)
end

function UINWCSEnvNodeItem:InitChristmas22EnvItem(seasonId, envCfg, selectCallback)
  self._seasonId = seasonId
  self._envCfg = envCfg
  self._selectCallback = selectCallback
  self.ui.tex_EnvironmentName.text = LanguageUtil.GetLocaleText(self._envCfg.general_env_name)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(self._envCfg.general_env_des2)
  self.ui.obj_rank:SetActive(self._envCfg.rank_id ~= 0)
  self:RefreshChristmas22EnvItem()
end

function UINWCSEnvNodeItem:BindChristmas22EnvCallback(secotorTaskCallback, rankCallback)
  self._secotorTaskCallback = secotorTaskCallback
  self._rankCallback = rankCallback
end

function UINWCSEnvNodeItem:RefreshChristmas22EnvItem()
  local maxNum = WarChessSeasonManager:GetWCSPassedEnvMaxNum(self._seasonId, self._envCfg.id)
  self.ui.tex_score:SetIndex(0, tostring(maxNum))
  local isUnlock = WarChessSeasonManager:GetWCSEnvIsUnlock(self._envCfg.id)
  self.ui.btn_Reward.transform.parent.gameObject:SetActive(isUnlock and 0 < #self._envCfg.env_task)
  self.ui.btn_Rank.transform.parent.gameObject:SetActive(isUnlock and 0 < self._envCfg.rank_id)
  self.ui.btn_Select.gameObject:SetActive(isUnlock)
  self.ui.obj_score:SetActive(isUnlock)
  self.ui.btn_Locked.gameObject:SetActive(not isUnlock)
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
end

function UINWCSEnvNodeItem:OnClickRank()
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

function UINWCSEnvNodeItem:OnClickScoreTask()
  if self._secotorTaskCallback ~= nil then
    self._secotorTaskCallback(self._envCfg)
  end
end

function UINWCSEnvNodeItem:OnClickSelect()
  if self._selectCallback ~= nil then
    self._selectCallback(self._envCfg.id, self._envCfg)
  end
end

function UINWCSEnvNodeItem:OnClickLocked()
  cs_MessageCommon.ShowMessageTips(self._unlockStr)
end

function UINWCSEnvNodeItem:GetChristmasEnvCfg()
  return self._envCfg
end

function UINWCSEnvNodeItem:SetWCSEnvNodeItemTaskDot(active)
  self.ui.task_blueDot:SetActive(active)
end

return UINWCSEnvNodeItem
