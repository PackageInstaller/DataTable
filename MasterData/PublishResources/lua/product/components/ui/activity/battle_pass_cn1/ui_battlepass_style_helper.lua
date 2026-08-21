_class("UIBattlePassStyleHelper", Object)
UIBattlePassStyleHelper = UIBattlePassStyleHelper

function UIBattlePassStyleHelper.GetStyleInfo(campaign, uiView, extra)
  local uiName = uiView and uiView:GetName() or ""
  extra = extra or ""
  local name = uiName .. extra
  if campaign == nil or name == nil then
    return
  end
  
  local function getCfg(tb, cfgName, uiName)
    local cfgs = Cfg[cfgName]({uiName = uiName}) or {}
    for _, v in ipairs(cfgs) do
      tb[v.ID] = v
    end
  end
  
  local tb = {}
  getCfg(tb, "cfg_battle_pass_style_default", name)
  getCfg(tb, "cfg_battle_pass_style_" .. campaign._id, name)
  local cfgs = {}
  for _, v in pairs(tb) do
    table.insert(cfgs, v)
  end
  table.sort(cfgs, function(a, b)
    return a.ID < b.ID
  end)
  if cfgs == nil then
    Log.info("UIBattlePassStyleHelper.GetStyleInfo() cfgs == nil! campaignId=", campaign._id, " uiName=", name)
  end
  return cfgs
end

function UIBattlePassStyleHelper.GetStyleInfo_KeyWidgetName(campaign, uiView, extra)
  local cfgs = UIBattlePassStyleHelper.GetStyleInfo(campaign, uiView, extra)
  local tb = {}
  for _, v in ipairs(cfgs) do
    tb[v.widgetName] = v
  end
  return tb
end

function UIBattlePassStyleHelper.FitStyle_Widget(campaign, uiView)
  local styleInfos = UIBattlePassStyleHelper.GetStyleInfo(campaign, uiView) or {}
  for _, v in ipairs(styleInfos) do
    UIStyleHelper.FitStyle_Widget(v, uiView, v.widgetName)
  end
end
