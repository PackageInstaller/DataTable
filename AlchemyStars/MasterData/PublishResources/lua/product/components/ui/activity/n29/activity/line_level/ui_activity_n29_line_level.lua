_class("UIActivityN29LineLevel", UIActivityLineLevelBase)
UIActivityN29LineLevel = UIActivityN29LineLevel

function UIActivityN29LineLevel:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N29
end

function UIActivityN29LineLevel:GetLineComponentType()
  return ECampaignN29ComponentID.ECAMPAIGN_N29_LINE_MISSION
end

function UIActivityN29LineLevel:GetFirstMeetComponentType()
  return ECampaignN29ComponentID.ECAMPAIGN_N29_FIRST_MEET
end

function UIActivityN29LineLevel:GetLevelNodeName()
  return "UIActivityN29LineLevelNode"
end

function UIActivityN29LineLevel:GetLevelLineName()
  return "UIActivityLineLevelLineBase"
end

function UIActivityN29LineLevel:GetBgList()
  return {
    "n29_xxg_bg01",
    "n29_xxg_bg02",
    "n29_xxg_bg01"
  }
end

function UIActivityN29LineLevel:GetLineLevelState()
  return UIStateType.UIActivityN29LineLevel
end

function UIActivityN29LineLevel:GetCustomTimeStr()
  return "str_n29_line_leve_day", "str_n29_line_leve_hour", "str_n29_line_leve_minus", "str_n29_line_leve_less_one_minus"
end

function UIActivityN29LineLevel:GetCustomTimeTipsStr()
  return "str_n29_activity_remain_time"
end

function UIActivityN29LineLevel:CloseWindow()
  self:CloseDialog()
end

function UIActivityN29LineLevel:SwitchMainUI()
  self:SwitchState(UIStateType.UIActivityN29MainController)
end

function UIActivityN29LineLevel:OnInit()
end
