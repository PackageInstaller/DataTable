local UINSpring23ModeSelectEnvNode = class("UINSpring23ModeSelectEnvNode", UIBaseNode)
local base = UIBaseNode
local UINSpring23ModeSelectEnvItem = require("Game.ActivitySpring.UI.SelectLevel.UINSpring23ModeSelectEnvItem")
local ActivityHallowmasEnum = require("Game.ActivityHallowmas.ActivityHallowmasEnum")

function UINSpring23ModeSelectEnvNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._itemPool = UIItemPool.New(UINSpring23ModeSelectEnvItem, self.ui.environmentSelectNode)
  self.ui.environmentSelectNode:SetActive(false)
end

function UINSpring23ModeSelectEnvNode:InitSpring23EnvNode(actSpringData, selectCallback)
  self._data = actSpringData
  self._selectCallback = selectCallback
  self._itemPool:HideAll()
  local list = self._data:GetSpringLevelEnvs()
  for _, env_id in ipairs(list) do
    local item = self._itemPool:GetOne()
    local envCfg = ConfigData.activity_spring_advanced_env[env_id]
    item:InitSpring23EnvItem(self._data, envCfg, self._selectCallback)
  end
end

function UINSpring23ModeSelectEnvNode:RefreshSpring23EnvNode()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for i, envItem in ipairs(self._itemPool.listItem) do
    envItem:RefreshChristmas22EnvItem()
    local actId = self._data:GetActId()
    local envId = envItem:GetSpring23EnvId()
    local isHaveNotEnteredNewEnv = userDataCache:GetSpring23IsNotEnteredNewEnv(actId, envId)
    envItem:SetSpring23EnvBlueDot(isHaveNotEnteredNewEnv)
  end
end

function UINSpring23ModeSelectEnvNode:OnDelete()
  base.OnDelete(self)
end

return UINSpring23ModeSelectEnvNode
