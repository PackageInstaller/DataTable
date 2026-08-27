local UINCharDunShopVer3Item = class("UINCharDunShopVer3Item", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINCharDunShopVer3Item:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickReward)
end

function UINCharDunShopVer3Item:InitCharDunShopVer3Item(heroGrowData, lv, callback)
  self._heroGrowData = heroGrowData
  self._lv = lv
  self._onClick = callback
  local allBpCfg = self._heroGrowData:GetTokenConfig()
  self.bpCfg = allBpCfg[self._lv]
  self._point = self.bpCfg.need_token
  self:Refresh()
end

function UINCharDunShopVer3Item:Refresh()
  local bpCfg = self.bpCfg
  self:RefreshPoint()
  self:RefreshLv()
  self:RefreshItem(bpCfg.level_reward_ids, bpCfg.level_reward_nums)
  self:RefreshThemeColor()
  self:RefreshReceived()
end

function UINCharDunShopVer3Item:RefreshPoint()
  self.ui.tex_TokenNum.text = tostring(self._point)
end

function UINCharDunShopVer3Item:RefreshLv()
  self.ui.tex_Lvl.text = string.format("%0" .. 2 .. "d", tostring(self._lv))
end

function UINCharDunShopVer3Item:RefreshItem(ids, nums)
  self._rewardPool:HideAll()
  for i, itemId in ipairs(ids) do
    local itemCfg = ConfigData.item[itemId]
    local itemCount = nums[i]
    local item = self._rewardPool:GetOne()
    item:InitItemWithCount(itemCfg, itemCount, nil, false)
  end
  if #ids < 2 then
    self.ui.img_Empty:SetActive(true)
    self.ui.img_Empty.transform:SetAsLastSibling()
  else
    self.ui.img_Empty:SetActive(false)
  end
end

function UINCharDunShopVer3Item:RefreshThemeColor()
  local uiCfg = self._heroGrowData:GetUIConfig()
  local frameColors = uiCfg.main_color
  local color = Color.New(frameColors[1] / 255, frameColors[2] / 255, frameColors[3] / 255)
  for i, v in ipairs(self.ui.array_colorRep) do
    v.color = color
  end
end

function UINCharDunShopVer3Item:RefreshReceived()
  local isUnlock = self._heroGrowData:GetHeroGrowTokenCount() >= self._point
  local isCanReceive = isUnlock and not self._heroGrowData:IsHeroGrowLvReceived(self._lv)
  local isGet = isUnlock and not isCanReceive
  self.ui.img_Get:SetActive(isGet)
  self.ui.img_canGet:SetActive(not isGet and isCanReceive)
end

function UINCharDunShopVer3Item:OnClickReward()
  if self._onClick then
    self._onClick(self._lv, self)
  end
end

return UINCharDunShopVer3Item
