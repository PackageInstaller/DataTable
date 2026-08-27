local UINCommonPlotReviewAvg = class("UINCommonPlotReviewAvg", UIBaseNode)
local base = UIBaseNode

function UINCommonPlotReviewAvg:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_plotItem, self, self.OnClickPlayAvg)
end

function UINCommonPlotReviewAvg:InitHeroPlotReviewAvg(avgId, AvgGroupData, RefreshBlueDot)
  self.AvgGroupData = AvgGroupData
  self.RefreshBlueDot = RefreshBlueDot
  self._avgCfg = ConfigData.story_avg[avgId]
  if self._avgCfg == nil then
    error("_avgCfg is NIL ")
    return
  end
  self.ui.tex_PlotName.text = LanguageUtil.GetLocaleText(self._avgCfg.name)
  self:RefreshPlotReviewAvgReddot()
  self._isClientPlay = false
end

function UINCommonPlotReviewAvg:SetAvgJustClientPlay()
  self._isClientPlay = true
end

function UINCommonPlotReviewAvg:OnClickPlayAvg()
  local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
  local playOverCallbck = self.AvgGroupData:GetAvgGroupDataPlayCallback()
  if self._isClientPlay then
    avgCtrl:ShowAvg(self._avgCfg.script_id, function()
      if playOverCallbck ~= nil then
        playOverCallbck()
      end
      if self.RefreshBlueDot ~= nil then
        self.RefreshBlueDot()
      end
    end)
  else
    avgCtrl:StartAvg(self._avgCfg.script_id, self._avgCfg.id, function()
      if playOverCallbck ~= nil then
        playOverCallbck()
      end
      if self.RefreshBlueDot ~= nil then
        self.RefreshBlueDot()
      end
    end)
  end
end

function UINCommonPlotReviewAvg:RefreshPlotReviewAvgReddot()
  if not IsNull(self.ui.blueDot) then
    local flag = self.AvgGroupData:IsAvgSingleReddot(self._avgCfg.id)
    self.ui.blueDot:SetActive(flag)
  end
end

return UINCommonPlotReviewAvg
