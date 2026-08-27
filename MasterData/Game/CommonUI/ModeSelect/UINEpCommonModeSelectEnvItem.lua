local UINEpCommonModeSelectEnvItem = class("UINEpCommonModeSelectEnvItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local EpCommonModeSelectUtil = require("Game.CommonUI.ModeSelect.EpCommonModeSelectUtil")

function UINEpCommonModeSelectEnvItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Select, self, self.OnClickSelect)
  UIUtil.AddButtonListener(self.ui.btn_Locked, self, self.OnClickLocked)
end

function UINEpCommonModeSelectEnvItem:InitEpCommonEnvItem(modeData, mainCfg, envCfg, selectCallback)
  self._modeData = modeData
  self._mainCfg = mainCfg
  self._envCfg = envCfg
  self._selectCallback = selectCallback
  self.ui.tex_EnvironmentName.text = LanguageUtil.GetLocaleText(self._envCfg.env_name)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(self._envCfg.env_des)
  self:RefreshChristmas22EnvItem()
  self:InitRedDot()
end

function UINEpCommonModeSelectEnvItem:RefreshChristmas22EnvItem()
  self.ui.tex_Additon:SetIndex(0, self._envCfg.env_des_extra)
  local isUnlock, unlockDes = EpCommonModeSelectUtil.IsEpCommonEnvUnlock(self._envCfg.env_id)
  self.ui.btn_Select.gameObject:SetActive(isUnlock)
  self.ui.btn_Locked.gameObject:SetActive(not isUnlock)
  if not isUnlock then
    self._unlockStr = unlockDes
    self.ui.tex_unlock.text = self._unlockStr
  end
  self.ui.obj_Buff:SetActive(false)
  self.ui.Img_InfiniteBottom:SetActive(self._envCfg.is_background == 1)
end

function UINEpCommonModeSelectEnvItem:OnClickSelect()
  if self.__isShowingBlueDot then
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    local actFrameId = self._mainCfg.activity_id
    local envId = self._envCfg.env_id
    userDataCache:SetCommonActEnvIsLooked(actFrameId, envId)
  end
  if self._selectCallback ~= nil then
    self._selectCallback(self._envCfg.env_id)
  end
end

function UINEpCommonModeSelectEnvItem:OnClickLocked()
  cs_MessageCommon.ShowMessageTips(self._unlockStr)
end

function UINEpCommonModeSelectEnvItem:GetEpCommonEnvId()
  return self._envCfg.env_id
end

function UINEpCommonModeSelectEnvItem:InitRedDot()
  local envRedNode = self._modeData:GetEnvRedDotNode(self:GetEpCommonEnvId())
  if envRedNode == nil then
    self.ui.obj_blueDot:SetActive(false)
    self.ui.obj_redDot:SetActive(false)
    return
  end
  self._envRedNode = envRedNode
  
  function self.__refreshReward(node)
    if node == nil then
      return
    end
    local isOn = node:GetRedDotCount() > 0
    self.ui.obj_redDot:SetActive(isOn)
    if isOn then
      self.ui.obj_blueDot:SetActive(false)
    end
  end
  
  self.__refreshReward(envRedNode)
  RedDotController:AddListener(envRedNode.nodePath, self.__refreshReward)
end

function UINEpCommonModeSelectEnvItem:SetEpCommonEnvBlueDot(active)
  self.__isShowingBlueDot = active
  self.ui.obj_blueDot:SetActive(active)
end

function UINEpCommonModeSelectEnvItem:OnDelete()
  if self._envRedNode then
    RedDotController:RemoveListener(self._envRedNode.nodePath, self.__refreshReward)
  end
  base.OnDelete(self)
end

return UINEpCommonModeSelectEnvItem
