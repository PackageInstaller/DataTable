local SummonController = NewClass("SummonController", BaseController)

function SummonController:OnInit()
end

function SummonController:OnReset()
end

function SummonController:OnOpenSummonPriorityNotEnoughView(data)
  local tipsTid = "SummonPriorityNotEnoughTips"
  local tipsTypeCfg = DT.TipsType[tipsTid]
  if tipsTypeCfg and tipsTypeCfg.DonotRemind and UIPopTipsDataUtils.ShallTipRemind(tipsTid) then
    local record = UIPopTipsDataUtils.GetDontRemindSetting(tipsTid)
    if record and record.funcType then
      if 2 == record.funcType and data and data.confirmFunc then
        data.confirmFunc()
      end
      return
    end
  end
  UIManager.Instance:Reopen(Urls.SummonPriorityNotEnoughView, data)
end

return SummonController
