local UINWCSEnvNode = class("UINWCSEnvNode", UIBaseNode)
local base = UIBaseNode
local UINWCSEnvNodeItem = require("Game.WarChessSeason.UI.WCSSelect.UINWCSEnvNodeItem")

function UINWCSEnvNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._itemPool = UIItemPool.New(UINWCSEnvNodeItem, self.ui.environmentSelectNode)
  self.ui.environmentSelectNode:SetActive(false)
end

function UINWCSEnvNode:InitWCSEnvNode(seasonId, selectCallback, taskCallback, rankCallback)
  self._selectCallback = selectCallback
  self._taskCallback = taskCallback
  self._rankCallback = rankCallback
  self._itemPool:HideAll()
  local envCfgList = WarChessSeasonManager:GetWCSEnvCfgList(seasonId)
  for _, envCfg in ipairs(envCfgList) do
    local item = self._itemPool:GetOne()
    item:InitChristmas22EnvItem(seasonId, envCfg, self._selectCallback)
    item:BindChristmas22EnvCallback(self._taskCallback, self._rankCallback)
  end
end

function UINWCSEnvNode:InitWCSEnvTaskReddot(reddot)
  self._reddot = reddot
  if self._reddot == nil then
    return
  end
  self:UpdReddotWCSEnv(self._reddot)
end

function UINWCSEnvNode:RefreshChristmas22EnvNode()
  for i, v in ipairs(self._itemPool.listItem) do
    v:RefreshChristmas22EnvItem()
  end
  if self._reddot ~= nil then
    self:UpdReddotWCSEnv(self._reddot)
  end
end

function UINWCSEnvNode:UpdReddotWCSEnv(reddot)
  for i, v in ipairs(self._itemPool.listItem) do
    local envId = v:GetChristmasEnvCfg().id
    local red = reddot:GetChild(envId)
    local redActive = red ~= nil and red:GetRedDotCount() > 0
    v:SetWCSEnvNodeItemTaskDot(redActive)
  end
end

function UINWCSEnvNode:OnDelete()
  base.OnDelete(self)
end

return UINWCSEnvNode
