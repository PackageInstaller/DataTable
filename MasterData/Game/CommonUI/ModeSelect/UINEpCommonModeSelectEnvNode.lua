local UINEpCommonModeSelectEnvNode = class("UINEpCommonModeSelectEnvNode", UIBaseNode)
local base = UIBaseNode
local UINEpCommonModeSelectEnvItem = require("Game.CommonUI.ModeSelect.UINEpCommonModeSelectEnvItem")
local EpCommonModeSelectUtil = require("Game.CommonUI.ModeSelect.EpCommonModeSelectUtil")

function UINEpCommonModeSelectEnvNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._itemPool = UIItemPool.New(UINEpCommonModeSelectEnvItem, self.ui.environmentSelectNode)
  self.ui.environmentSelectNode:SetActive(false)
end

function UINEpCommonModeSelectEnvNode:InitEpCommonEnvNode(modeData, selectCallback)
  self._modeData = modeData
  self._mainCfg = modeData:getMainCfg()
  self._selectCallback = selectCallback
  self._itemPool:HideAll()
  local list = self._mainCfg.env_list
  for _, env_id in ipairs(list) do
    local envItem = self._itemPool:GetOne()
    local envCfg = ConfigData.act_general_ep_env[env_id]
    envItem:InitEpCommonEnvItem(self._modeData, self._mainCfg, envCfg, self._selectCallback)
  end
end

function UINEpCommonModeSelectEnvNode:RefreshSpring23EnvNode()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for i, envItem in ipairs(self._itemPool.listItem) do
    envItem:RefreshChristmas22EnvItem()
    local actFrameId = self._mainCfg.activity_id
    local envId = envItem:GetEpCommonEnvId()
    local isUnlcok = EpCommonModeSelectUtil.IsEpCommonEnvUnlock(envId)
    local isLooked = userDataCache:GetCommonActEnvIsLooked(actFrameId, envId)
    envItem:SetEpCommonEnvBlueDot(isUnlcok and not isLooked)
  end
end

function UINEpCommonModeSelectEnvNode:OnDelete()
  self._itemPool:DeleteAll()
  base.OnDelete(self)
end

return UINEpCommonModeSelectEnvNode
