_class("UIGMHelper", Object)
UIGMHelper = UIGMHelper

function UIGMHelper.Start_SendCmdTask(cmd, callback)
  TaskManager:GetInstance():StartTask(function(TT)
    local gmproxy = GameGlobal.GetModule(GMProxyModule)
    local res = gmproxy:SendCmdTask(TT, cmd)
    if res.m_call_err ~= CallResultType.Normal then
      ToastManager.ShowToast("UIGMHelper.Start_SendCmdTask Failed, cmd = ", cmd)
    else
      ToastManager.ShowToast("UIGMHelper.Start_SendCmdTask() Succ")
    end
    if callback then
      callback()
    end
  end)
end

function UIGMHelper.AddAsset(itemId, count, callback)
  local cmd = string.format("add_asset %s %d %d", LocalDB.GetString("OpenIdTest"), itemId, count)
  UIGMHelper.Start_SendCmdTask(cmd, callback)
end

function UIGMHelper.ChangeQuestStatus(questId, status, b, callback)
  local cmd = string.format("ChangeQuestStatus %s %d %d %d", LocalDB.GetString("OpenIdTest"), questId, status, b)
  UIGMHelper.Start_SendCmdTask(cmd, callback)
end

function UIGMHelper.CompleteOneQuest(questId, callback)
  local cmd = string.format("CompleteOneQuest %s %d", LocalDB.GetString("OpenIdTest"), questId)
  UIGMHelper.Start_SendCmdTask(cmd, callback)
end

function UIGMHelper.GotoTime(target, callback)
  local curTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() / 1000
  local step = math.floor(math.max(target - curTime, 0))
  local cmd = string.format("modify_allsvc_time_bias 513 1 %d", step)
  UIGMHelper.Start_SendCmdTask(cmd, callback)
end

function UIGMHelper.PassLineCampMission(cmptCfgId, missionId, callback)
  local cmd = string.format("PassLineCampMission %s %d %d", LocalDB.GetString("OpenIdTest"), cmptCfgId, missionId)
  UIGMHelper.Start_SendCmdTask(cmd, callback)
end
