local base = UIBaseNode
local UINCardSetRewardItemFinal = class("UINCardSetRewardItemFinal", base)

function UINCardSetRewardItemFinal:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCardSetRewardItemFinal:InitCardSetRewardItemFinal(clickEvent, actCsData, curLevel, curLvExp)
  self._clickEvent = clickEvent
  local rewardList = actCsData:GetCsRewardBpCfg()
  local rewardCfg = rewardList[#rewardList]
  local canGetNum = 0
  local curEpx = 0
  local needNum = rewardCfg.need_num
  if curLevel >= #rewardList then
    curEpx = curLvExp
    local lastPickedLv = actCsData:GetCsBpLevelPicked()
    local startLv = math.max(lastPickedLv, #rewardList)
    canGetNum = curLevel - startLv
  end
  self.ui.tex_Num.text = tostring(canGetNum)
  self.ui.img_ExpProgress.fillAmount = curEpx / needNum
  self.ui.tex_ExpProgress:SetIndex(0, tostring(curEpx), tostring(needNum))
end

function UINCardSetRewardItemFinal:_OnClickRoot()
  if self._clickEvent then
    self._clickEvent()
  end
end

function UINCardSetRewardItemFinal:OnDelete()
  base.OnDelete(self)
end

return UINCardSetRewardItemFinal
