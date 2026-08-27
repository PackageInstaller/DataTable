local UINSpring23ModeSelectEnvItem = class("UINSpring23ModeSelectEnvItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINSpring23ModeSelectEnvItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Select, self, self.OnClickSelect)
  UIUtil.AddButtonListener(self.ui.btn_Locked, self, self.OnClickLocked)
end

function UINSpring23ModeSelectEnvItem:InitSpring23EnvItem(actSpringData, envCfg, selectCallback)
  self._data = actSpringData
  self._envCfg = envCfg
  self._selectCallback = selectCallback
  self.ui.tex_EnvironmentName.text = LanguageUtil.GetLocaleText(self._envCfg.env_name)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(self._envCfg.env_des)
  self:RefreshChristmas22EnvItem()
end

function UINSpring23ModeSelectEnvItem:RefreshChristmas22EnvItem()
  self.ui.tex_Additon:SetIndex(0, self._envCfg.env_des_extra)
  local isUnlock = self._data:IsSpring23EnvUnlock(self._envCfg.env_id)
  self.ui.btn_Select.gameObject:SetActive(isUnlock)
  self.ui.btn_Locked.gameObject:SetActive(not isUnlock)
  if not isUnlock then
    local lockDes = CheckCondition.GetUnlockInfoLua(self._envCfg.pre_condition, self._envCfg.pre_para1, self._envCfg.pre_para2)
    if 0 < self._envCfg.need_interact then
      local lockDes2 = string.format(ConfigData:GetTipContent(9105), tostring(self._envCfg.need_interact))
      lockDes = lockDes .. "\n" .. lockDes2
    end
    self._unlockStr = lockDes
    self.ui.tex_unlock.text = self._unlockStr
  end
  local isHaveExtrAdd = isUnlock and not string.IsNullOrEmpty(self._envCfg.env_des_extra)
  self.ui.obj_Buff:SetActive(isHaveExtrAdd)
  if isHaveExtrAdd then
    self.ui.tex_Additon:SetIndex(0, self._envCfg.env_des_extra)
  end
end

function UINSpring23ModeSelectEnvItem:OnClickSelect()
  if self.__isShowingBlueDot then
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    local actId = self._data:GetActId()
    local envId = self._envCfg.env_id
    userDataCache:SetSpring23IsNotEnteredNewEnv(actId, envId, false)
    self._data:RefreshSpring23LevelUnlockBuleDot()
  end
  if self._selectCallback ~= nil then
    self._selectCallback(self._envCfg.env_id)
  end
end

function UINSpring23ModeSelectEnvItem:OnClickLocked()
  cs_MessageCommon.ShowMessageTips(self._unlockStr)
end

function UINSpring23ModeSelectEnvItem:GetSpring23EnvId()
  return self._envCfg.env_id
end

function UINSpring23ModeSelectEnvItem:SetSpring23EnvBlueDot(active)
  self.__isShowingBlueDot = active
  self.ui.obj_blueDot:SetActive(active)
end

return UINSpring23ModeSelectEnvItem
