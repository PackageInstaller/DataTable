local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local SkinConditionFunc = {
  [proto_csmsg_SystemFunctionID.SystemFunctionID_Store] = function(cfg, skinCtrl)
    return skinCtrl:GetGoodsBySkinCfg(cfg) ~= nil
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_Operate_Active] = function(cfg, skinCtrl)
    return skinCtrl:GetActFrameDataBySkinCfg(cfg) ~= nil
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank] = function(cfg, skinCtrl)
    return true
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_Gift] = function(cfg, skinCtrl)
    return skinCtrl:GetGiftBySkinCfg(cfg) ~= nil
  end
}
return SkinConditionFunc
