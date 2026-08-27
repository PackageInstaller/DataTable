local UINActSummerLvLeftInfo = class("UINActSummerLvLeftInfo", UIBaseNode)
local base = UIBaseNode
local UINActSummerLvSwitchBtn = require("Game.ActivitySummer.UI.UINActSummerLvSwitchBtn")

function UINActSummerLvLeftInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self.OnClickSummerIntro)
  self.lvBtnPool = UIItemPool.New(UINActSummerLvSwitchBtn, self.ui.btn_DiffSwitch)
  self.ui.btn_DiffSwitch:SetActive(false)
  self.__OnSelectLv = BindCallback(self, self.OnSelectSummerLv)
end

function UINActSummerLvLeftInfo:InittSummerLvLeftInfo(summerData, curSectorId, selectFunc, outDataFunc)
  self.summerData = summerData
  local summerCfg = summerData:GetSectorICfg()
  self.selectFunc = selectFunc
  self.outDataFunc = outDataFunc
  self.curSectorId = curSectorId
  self._outDataTime = self.summerData:GetActivityEndTime()
  self.sectorList = {
    summerCfg.easy_stage,
    summerCfg.hard_stage
  }
  self.lvBtnPool:HideAll()
  for i, sectorId in ipairs(self.sectorList) do
    local item = self.lvBtnPool:GetOne()
    item:InitSummerLvBtn(i, self.__OnSelectLv)
  end
  self:RefreshSelectBtnState()
  if self._outDataTime > PlayerDataCenter.timestamp and self.timerId == nil then
    self.timerId = TimerManager:StartTimer(1, self.OnTimerSummerCutDown, self)
  end
  self:OnTimerSummerCutDown()
end

function UINActSummerLvLeftInfo:RefreshSectorId(sectorId)
  self.curSectorId = sectorId
  self:RefreshSelectBtnState()
end

function UINActSummerLvLeftInfo:OnSelectSummerLv(index)
  local selectSectorId = self.sectorList[index]
  if self.selectFunc == nil or selectSectorId == nil or selectSectorId == self.curSectorId then
    return
  end
  self.selectFunc(selectSectorId)
  PlayerDataCenter.sectorStage:SetSelectSectorId(selectSectorId)
end

function UINActSummerLvLeftInfo:OnClickSummerIntro()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(7005), ConfigData:GetTipContent(7010))
  end)
end

function UINActSummerLvLeftInfo:RefreshSelectBtnState()
  for i, item in ipairs(self.lvBtnPool.listItem) do
    item:SetSummerLvState(self.curSectorId == self.sectorList[i])
  end
end

function UINActSummerLvLeftInfo:OnTimerSummerCutDown()
  if self._outDataTime <= PlayerDataCenter.timestamp then
    if self.timerId ~= nil then
      TimerManager:StopTimer(self.timerId)
      self.timerId = nil
    end
    if self.outDataFunc ~= nil then
      self.outDataFunc()
    end
    return
  end
  local remainTime = self._outDataTime - PlayerDataCenter.timestamp
  local d, h, m, s = TimeUtil:TimestampToTimeInter(remainTime, false, true)
  if 0 < d then
    self.ui.tex_Timer:SetIndex(0, tostring(d), string.format("%02d", h), string.format("%02d", m))
  elseif 0 < h then
    self.ui.tex_Timer:SetIndex(1, string.format("%02d", h), string.format("%02d", m))
  else
    m = 0 < m and m or 1
    self.ui.tex_Timer:SetIndex(2, string.format("%02d", m))
  end
end

function UINActSummerLvLeftInfo:OnDelete()
  self.lvBtnPool:DeleteAll()
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  base.OnDelete(self)
end

return UINActSummerLvLeftInfo
