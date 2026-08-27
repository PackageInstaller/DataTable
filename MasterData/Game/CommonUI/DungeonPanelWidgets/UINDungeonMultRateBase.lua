local UINDungeonMultRateBase = class("UINDungeonMultRateBase", UIBaseNode)
local base = UIBaseNode

function UINDungeonMultRateBase:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_isDoubleOrDropUp, self, self.ShowDropInfoNode)
end

function UINDungeonMultRateBase:InitMultRate(dungeonData)
  self.dungeonData = dungeonData
  local multAddRate = dungeonData:GetActivityMultRewardRate()
  if multAddRate <= 0 then
    self:Hide()
    return
  end
  if multAddRate == 1 then
    self.ui.tex_Type:SetIndex(0)
  else
    self.ui.tex_Type:SetIndex(1)
  end
  self.expiredTm = dungeonData:GetActivityMultRewardExpiredTm()
  if 0 > self.expiredTm then
    self.ui.tex_Timer:SetIndex(1)
  end
  local leftTime, totalTime = dungeonData:GetLeftActivityMultRewardNum()
  if totalTime < 0 then
    self.ui.tex_DoubleCount.gameObject:SetActive(true)
    self.ui.tex_DoubleCount:SetIndex(1)
  elseif 0 < totalTime then
    self.ui.tex_DoubleCount.gameObject:SetActive(true)
    self.ui.tex_DoubleCount:SetIndex(0, tostring(leftTime), tostring(totalTime))
  else
    self.ui.tex_DoubleCount.gameObject:SetActive(false)
  end
  self:UpdateLeftTime()
end

function UINDungeonMultRateBase:UpdateLeftTime()
  if (self.expiredTm or 0) <= 0 then
    return
  end
  local leftTime = self.expiredTm - PlayerDataCenter.timestamp
  if 86400 < leftTime then
    local d, h, m, s = TimeUtil:TimestampToTimeInter(leftTime, false, true)
    local content = string.format("%02d:%02d:%02d", h, m, s)
    self.ui.tex_Timer:SetIndex(2, tostring(d), content)
  else
    self.ui.tex_Timer:SetIndex(0, TimeUtil:TimestampToTime(leftTime))
  end
end

function UINDungeonMultRateBase:ShowDropInfoNode()
  local dungeonCfg = self.dungeonData:GetDungeonCfg()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitDungeonDropInfo(dungeonCfg.ui_type)
  end)
end

function UINDungeonMultRateBase:OnDelete()
  base.OnDelete(self)
end

return UINDungeonMultRateBase
