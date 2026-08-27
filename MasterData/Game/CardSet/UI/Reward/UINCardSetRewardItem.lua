local base = UIBaseNode
local UINCardSetRewardItem = class("UINCardSetRewardItem", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINCardSetRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnClickRoot)
  self._rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived, false)
end

function UINCardSetRewardItem:InitCardSetRewardItem(rewardCfg, curLv, curLvExp, actCardData, clickEvent)
  self._clickEvent = clickEvent
  self.ui.tex_Num.text = tostring(rewardCfg.bp_level)
  if curLv > rewardCfg.bp_level then
    self.ui.Img_ExpProgress.fillAmount = 1
  elseif curLv == rewardCfg.bp_level then
    self.ui.Img_ExpProgress.fillAmount = curLvExp / rewardCfg.need_num
  else
    self.ui.Img_ExpProgress.fillAmount = 0
  end
  if rewardCfg.bp_level == 1 then
    self.ui.main:SetActive(false)
    self.ui.img_Point.color = self.ui.colorList[1]
    return
  end
  self.ui.main:SetActive(true)
  local lastPickLv = actCardData:GetCsBpLevelPicked()
  local canPick = curLv >= rewardCfg.bp_level and lastPickLv < rewardCfg.bp_level
  self.ui.obj_Selected:SetActive(canPick)
  local isUnreached = curLv < rewardCfg.bp_level
  self.ui.Img_Bar.color = isUnreached and self.ui.colorList[2] or self.ui.colorList[1]
  self.ui.Img_Line.color = isUnreached and Color.white or self.ui.colorList[2]
  self.ui.Img_Box.color = isUnreached and Color.white or self.ui.colorList[3]
  self.ui.img_Point.color = isUnreached and self.ui.colorList[4] or self.ui.colorList[1]
  self.ui.img_ArrowBar.color = isUnreached and self.ui.colorList[2] or self.ui.colorList[1]
  local rewardCfgList = actCardData:GetCsRewardBpCfg()
  local isLast = rewardCfg.bp_level == #rewardCfgList
  self.ui.Obj_Exp:SetActive(not isLast)
  self.ui.obj_Mask:SetActive(isUnreached)
  local realRewardCfg = rewardCfgList[rewardCfg.bp_level - 1]
  self._rewardPool:HideAll()
  for i = 1, #realRewardCfg.rewardIds do
    local itemId = realRewardCfg.rewardIds[i]
    local itemNum = realRewardCfg.rewardNums[i]
    local rewardItem = self._rewardPool:GetOne()
    local itemCfg = ConfigData.item[itemId]
    local isPicked = lastPickLv >= rewardCfg.bp_level
    rewardItem:InitItemWithCount(itemCfg, itemNum, nil, isPicked)
  end
  if 2 > #realRewardCfg.rewardIds then
    self.ui.emptyItem.transform:SetAsLastSibling()
    self.ui.emptyItem:SetActive(true)
    self.ui.img_Empty:SetIndex(isUnreached and 0 or 1)
  else
    self.ui.emptyItem:SetActive(false)
  end
end

function UINCardSetRewardItem:_OnClickRoot()
  if self._clickEvent then
    self._clickEvent()
  end
end

function UINCardSetRewardItem:OnDelete()
  self._rewardPool:DeleteAll()
  base.OnDelete(self)
end

return UINCardSetRewardItem
