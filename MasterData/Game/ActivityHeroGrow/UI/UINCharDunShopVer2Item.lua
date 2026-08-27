local UINCharDunShopVer2Item = class("UINCharDunShopVer2Item", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINCharDunShopVer2Item:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived)
  self.ui.uINBaseItemWithReceived:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickReward)
end

function UINCharDunShopVer2Item:InitCharDunShopVer2Item(heroGrowData, lv, callback)
  self._heroGrowData = heroGrowData
  self._lv = lv
  self._callback = callback
  self:__InitUI()
  self:RefreshCharDunShopVer2Item()
end

function UINCharDunShopVer2Item:__InitUI()
  local allBpCfg = ConfigData.activity_hero_token_reward[self._heroGrowData:GetActId()]
  local bpCfg = allBpCfg[self._lv]
  self._point = bpCfg.need_token
  self.ui.tex_Lvl.text = tostring(self._lv)
  self.ui.tex_TokenNum.text = tostring(self._point)
  local ids = bpCfg.level_reward_ids
  local nums = bpCfg.level_reward_nums
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

function UINCharDunShopVer2Item:RefreshCharDunShopVer2Item()
  local isUnlock = PlayerDataCenter:GetItemCount(self._heroGrowData:GetHeroGrowCostId()) >= self._point
  local isCanReceive = isUnlock and not self._heroGrowData:IsHeroGrowLvReceived(self._lv)
  local isGet = isUnlock and not isCanReceive
  self.ui.img_Icon:SetIndex(isUnlock and 1 or 0)
  self.ui.img_Bottom:SetIndex(isCanReceive and 1 or 0)
  self.ui.img_Get:SetActive(isGet)
  for i, v in ipairs(self._rewardPool.listItem) do
    v:SetPickedUIActive(isGet)
  end
end

function UINCharDunShopVer2Item:GetCharDunShopVer2Lv()
  return self._lv
end

function UINCharDunShopVer2Item:GetCharDunShopVer2ItemCenterPoint(vec)
  local pos = self.ui.img_Icon.transform.localPosition
  vec.x = pos.x
  vec.y = pos.y
end

function UINCharDunShopVer2Item:OnClickReward()
  if self._callback then
    self._callback(self._lv, self)
  end
end

function UINCharDunShopVer2Item:SetChildHeroVer2HorizePointLine(lineItem, startOffset)
  local vec = Vector2.Temp(0, 0)
  self:GetCharDunShopVer2ItemCenterPoint(vec)
  vec.x = vec.x + startOffset
  lineItem.transform:SetParent(self.transform)
  lineItem.transform.anchoredPosition = vec
  lineItem.transform:SetAsFirstSibling()
end

function UINCharDunShopVer2Item:SetChildHeroVer2NewLinePointLine(lineItems, startOffset)
  local tempVec = Vector2.Temp(0, 0)
  self:GetCharDunShopVer2ItemCenterPoint(tempVec)
  tempVec.x = tempVec.x + startOffset
  for i, lineItem in ipairs(lineItems) do
    lineItem.transform:SetParent(self.transform)
    lineItem.transform.anchoredPosition = tempVec
    if i == 1 then
      tempVec.x = tempVec.x + lineItem.transform.localScale.x * lineItem.transform.sizeDelta.x
    elseif i == 2 then
      tempVec.y = tempVec.y - lineItem.transform.localScale.y * lineItem.transform.sizeDelta.y
    end
    lineItem.transform:SetAsFirstSibling()
  end
end

return UINCharDunShopVer2Item
