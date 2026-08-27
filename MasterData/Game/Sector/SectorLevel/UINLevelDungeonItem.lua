local UINLevelDungeonItem = class("UINLevelDungeonItem", UIBaseNode)
local base = UIBaseNode

function UINLevelDungeonItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickDungeonLevel)
end

function UINLevelDungeonItem:InitLevelDungeon(dungeonLevelData, index, callback)
  self._dungeonLevelData = dungeonLevelData
  self._callback = callback
  self.ui.tex_LevelNumber:SetIndex(0, tostring(index))
  self.ui.tex_Tile.text = dungeonLevelData:GetDungeonLevelName()
  self:RefreshLevelDungeonState()
end

function UINLevelDungeonItem:SetLevelDungeonBlueReddotFunc(reddotfunc)
  self._reddotfunc = reddotfunc
  self:RefreshLevelDungeonReddot()
end

function UINLevelDungeonItem:SetLevelDungonSelect(flag)
end

function UINLevelDungeonItem:RefreshLevelDungeonState()
  local locked = not self._dungeonLevelData:GetIsLevelUnlock()
  self.ui.obj_Locked:SetActive(locked)
  local battleCount = PlayerDataCenter:GetTotalBattleTimes(self._dungeonLevelData:GetDungeonLevelStageId())
  self.ui.img_Complete:SetActive(0 < battleCount)
  if locked then
    local cond, pre1, pre2 = self._dungeonLevelData:GetLevelUnlockConditionCfg()
    local des = CheckCondition.GetUnlockInfoLua(cond, pre1, pre2)
    self.ui.tex_Condition.text = des
  end
end

function UINLevelDungeonItem:RefreshLevelDungeonReddot()
  if self._reddotfunc ~= nil then
    self.ui.blueDot:SetActive(self._reddotfunc ~= nil and self._reddotfunc(self._dungeonLevelData:GetDungeonLevelStageId()))
  end
end

function UINLevelDungeonItem:GetSectorLevelDungeon()
  return self._dungeonLevelData
end

function UINLevelDungeonItem:OnClickDungeonLevel()
  if self._callback ~= nil then
    self._callback(self)
  end
end

return UINLevelDungeonItem
