local UINFmtHeroHpBarItem = class("UINFmtHeroHpBarItem", UIBaseNode)
local base = UIBaseNode

function UINFmtHeroHpBarItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.block:SetActive(false)
  self.blockGoList = {}
end

function UINFmtHeroHpBarItem:InitFmtHeroHpBarItem(hpPer, maxHp)
  self.ui.bar.fillAmount = hpPer / 10000
  self:_UpdHpBlockSpliter(maxHp)
end

function UINFmtHeroHpBarItem:_UpdHpBlockSpliter(maxHp)
  local ok, unitBlood, bossUnitBlood, gridMax = BattleUtil.TryGetCurBattleBloodGridCfg()
  if not ok then
    return
  end
  local splitCount = maxHp / unitBlood
  splitCount = math.min(gridMax, splitCount)
  for k, go in ipairs(self.blockGoList) do
    go:SetActive(false)
  end
  local width = self.ui.block.transform.parent.rect.width
  local unitDis = width / splitCount
  local oriX = width / 2
  for i = 1, splitCount do
    local go = self.blockGoList[i]
    if go == nil then
      go = self.ui.block:Instantiate()
      self.blockGoList[i] = go
    end
    go:SetActive(true)
    local pos = go.transform.localPosition
    pos.x = unitDis * i - oriX
    go.transform.localPosition = pos
  end
end

function UINFmtHeroHpBarItem:OnDelete()
  base.OnDelete(self)
end

return UINFmtHeroHpBarItem
