local UINTDBattleNextBtn = class("UINTDBattleNextBtn", UIBaseNode)
local base = UIBaseNode

function UINTDBattleNextBtn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_next, self, self.OnClickNextWave)
end

function UINTDBattleNextBtn:SetNextWaveCallback(callback)
  self.callback = callback
end

function UINTDBattleNextBtn:RefreshNextBtnState(curWave, maxWave, rewardCount)
  local next = maxWave <= curWave + 1 and maxWave or curWave + 1
  self.ui.tex_Count:SetIndex(0, tostring(next), tostring(maxWave))
  self.ui.tex_CCCount.text = tostring(rewardCount)
end

function UINTDBattleNextBtn:RefreshRewardCount(rewardCount)
  self.ui.tex_CCCount.text = tostring(rewardCount)
end

function UINTDBattleNextBtn:OnClickNextWave()
  self:Hide()
  if self.callback ~= nil then
    self.callback()
  end
end

return UINTDBattleNextBtn
