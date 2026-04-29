_class("UICrazyLoginV2Helper", Object)
UICrazyLoginV2Helper = UICrazyLoginV2Helper

function UICrazyLoginV2Helper.SafeState(state)
  local tb_check = {
    [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_UNKNOW] = true,
    [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_Expired] = true
  }
  return tb_check[state] and ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK or state
end

function UICrazyLoginV2Helper.IsStateCanRecv(state)
  return state == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV
end

function UICrazyLoginV2Helper.IsStateRecved(state)
  return state == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED
end

function UICrazyLoginV2Helper.IsStateLock(state)
  return state == ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK
end

function UICrazyLoginV2Helper.CheckState(datas, tb_check)
  for i, v in ipairs(datas) do
    if tb_check[v.m_reward_status] then
      return i
    end
  end
end

function UICrazyLoginV2Helper.CheckCanGetIndex(datas)
  local tb_check = {
    [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV] = true,
    [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK] = true
  }
  local idx = UICrazyLoginV2Helper.CheckState(datas, tb_check)
  return idx or 1
end

function UICrazyLoginV2Helper.CheckAllUnlocked(datas)
  local tb_check = {
    [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK] = true
  }
  local idx = UICrazyLoginV2Helper.CheckState(datas, tb_check)
  return idx == nil
end

function UICrazyLoginV2Helper._GetCfg(campaign)
  local id = (campaign or {})._id or 0
  local cfg = Cfg.cfg_crazy_login_v2[id] or {}
  return cfg
end

function UICrazyLoginV2Helper.GetValue(campaign, name, key)
  local cfg = UICrazyLoginV2Helper._GetCfg(campaign)
  name = name or ""
  local value = cfg[name]
  if key then
    value = value[key]
    return value
  end
  return value
end

function UICrazyLoginV2Helper.GetStateValue(campaign, state, key)
  local tb = {
    [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_CAN_RECV] = "StateCanRecv",
    [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_RECVED] = "StateRecved",
    [ECumulativeLoginRewardStatus.E_CUMULATIVE_LOGIN_REWARD_LOCK] = "StateLock"
  }
  return UICrazyLoginV2Helper.GetValue(campaign, tb[state], key)
end

function UICrazyLoginV2Helper.SetTextColorByCfg(uiView, widgetName, value)
  local style = {textColor = value}
  UIStyleHelper.FitStyle_Widget_LocalizationText(style, uiView, widgetName)
end

function UICrazyLoginV2Helper.SetEffByCfg(uiView, widgetName, value, res)
  res = res or ResourceManager:GetInstance():SyncLoadAsset(value, LoadType.GameObject)
  if res then
    local go = res.Obj
    local eff = uiView:GetGameObject(widgetName)
    go.transform:SetParent(eff.transform)
    local rect = go:GetComponent("RectTransform")
    rect.anchoredPosition = Vector2(0, 0)
    rect.localScale = Vector3(1, 1, 1)
    go:SetActive(true)
  else
    Log.error("UICrazyLoginV2Helper.SetEffByCfg() res is nil ! resName = " .. value)
  end
  return res
end
