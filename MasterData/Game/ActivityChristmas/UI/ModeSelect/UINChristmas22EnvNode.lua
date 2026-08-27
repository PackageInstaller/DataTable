local UINChristmas22EnvNode = class("UINChristmas22EnvNode", UIBaseNode)
local base = UIBaseNode
local UINChristmas22EnvItem = require("Game.ActivityChristmas.UI.ModeSelect.UINChristmas22EnvItem")
local ActivityHallowmasEnum = require("Game.ActivityHallowmas.ActivityHallowmasEnum")

function UINChristmas22EnvNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._itemPool = UIItemPool.New(UINChristmas22EnvItem, self.ui.environmentSelectNode)
  self.ui.environmentSelectNode:SetActive(false)
end

function UINChristmas22EnvNode:InitChristmas22EnvNode(hallowmasData, selectCallback, taskCallback, rankCallback)
  self._data = hallowmasData
  self._selectCallback = selectCallback
  self._taskCallback = taskCallback
  self._rankCallback = rankCallback
  self._itemPool:HideAll()
  local list = self._data:GetHallowmasMainCfg().env_id
  for i, v in ipairs(list) do
    local item = self._itemPool:GetOne()
    local envCfg = ConfigData.activity_hallowmas_general_env[v]
    item:InitChristmas22EnvItem(self._data, envCfg, self._selectCallback)
    item:BindChristmas22EnvCallback(self._taskCallback, self._rankCallback)
  end
  self._reddot = self._data:GetActivityReddot()
  if self._reddot ~= nil then
    self._reddot = self._reddot:GetChild(ActivityHallowmasEnum.reddotType.EnvTask)
  end
  if self._reddot ~= nil then
    self._reddotFunc = BindCallback(self, self.__RefreshReddot)
    RedDotController:AddListener(self._reddot.nodePath, self._reddotFunc)
    self:__RefreshReddot(self._reddot)
  end
end

function UINChristmas22EnvNode:RefreshChristmas22EnvNode()
  for i, v in ipairs(self._itemPool.listItem) do
    v:RefreshChristmas22EnvItem()
  end
  if self._reddot ~= nil then
    self:__RefreshReddot(self._reddot)
  end
end

function UINChristmas22EnvNode:__RefreshReddot(reddot)
  for i, v in ipairs(self._itemPool.listItem) do
    local envId = v:GetChristmasEnvCfg().general_env_id
    local red = reddot:GetChild(envId)
    local redActive = red ~= nil and red:GetRedDotCount() > 0
    v:SetChristmasEnvTaskRed(redActive)
  end
end

function UINChristmas22EnvNode:OnDelete()
  if self._reddot ~= nil then
    RedDotController:RemoveListener(self._reddot.nodePath, self._reddotFunc)
    self._reddot = nil
  end
  base.OnDelete(self)
end

return UINChristmas22EnvNode
