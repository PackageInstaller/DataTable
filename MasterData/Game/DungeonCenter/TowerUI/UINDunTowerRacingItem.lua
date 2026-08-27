local UINDunTowerRacingItem = class("UINDunTowerRacingItem", UIBaseNode)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINDunTowerRacingItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Receive, self, self._BtnPickClicked)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItem, false)
end

function UINDunTowerRacingItem:InitRacintTaskItem(racingCfg, isPicked, achieve, pickAction)
  self._racingCfg = racingCfg
  self._enablePick = not isPicked and achieve
  self._pickAction = pickAction
  self.ui.btn_Receive.enabled = self._enablePick
  local tindex, color
  if isPicked then
    tindex = 2
    color = self.ui.col_piacked
  elseif achieve then
    tindex = 0
    color = self.ui.col_enablePick
  else
    tindex = 1
    color = self.ui.col_incomplete
  end
  self.ui.tex_Receive:SetIndex(tindex)
  self.ui.img_Bottom.color = color
  self.ui.tex_Des:SetIndex(0, TimeUtil:TimestampToTime(racingCfg.time_limit))
  self.rewardItemPool:HideAll()
  for index, itemId in pairs(self._racingCfg.reward_ids) do
    local count = self._racingCfg.reward_nums[index]
    local rewardItem = self.rewardItemPool:GetOne()
    local itemCfg = ConfigData.item[itemId]
    rewardItem:InitItemWithCount(itemCfg, count)
    rewardItem:SetPickedUIActive(isPicked)
  end
end

function UINDunTowerRacingItem:_BtnPickClicked()
  if not self._enablePick then
    return
  end
  if self._pickAction ~= nil then
    self._pickAction(self._racingCfg, self)
  end
end

return UINDunTowerRacingItem
