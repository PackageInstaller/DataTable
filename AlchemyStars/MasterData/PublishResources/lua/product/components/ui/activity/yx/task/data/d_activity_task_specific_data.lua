_class("DActivityTaskSpecificData", Object)

function DActivityTaskSpecificData:Constructor()
  self.shopBtnScriptName = ""
  self.campaignType = 0
  self.progressCmptId = 0
  self.questCmptId = 0
  self.progressNumSpecialColor = 0
  self.progressGotStr = ""
  self.progressCanGetStr = ""
  self.questBgNotFinish = ""
  self.questBgFinish = ""
  self.spriteAtlasName = ""
  self.isProgressImgNeedChange = false
  self.topProgressImg = ""
  self.topProgressBgImg = ""
  self.bottomProgressImg = ""
  self.bottomProgressBgImg = ""
  self.normalProgressImg = ""
  self.normalProgressBgImg = ""
  self.progressFirstCellImgHeight = 0
  self.progressNormalCellImgHeight = 0
  self.isCloseWithAnim = false
  self.closeAnimTb = {}
end

function DActivityTaskSpecificData:GetShopBtnScriptName()
  return self.shopBtnScriptName
end

function DActivityTaskSpecificData:GetCampaignType()
  return self.campaignType
end

function DActivityTaskSpecificData:GetProgressCmptId()
  return self.progressCmptId
end

function DActivityTaskSpecificData:GetQuestCmptId()
  return self.questCmptId
end

function DActivityTaskSpecificData:GetQuestNumSpecialColor()
  return self.progressNumSpecialColor
end

function DActivityTaskSpecificData:GetQuestGotStr()
  return self.progressGotStr
end

function DActivityTaskSpecificData:GetQuestCanGetStr()
  return self.progressCanGetStr
end

function DActivityTaskSpecificData:GetQuestBgNotFinish()
  return self.questBgNotFinish
end

function DActivityTaskSpecificData:GetQuestBgFinish()
  return self.questBgFinish
end

function DActivityTaskSpecificData:GetSpriteAtlasName()
  return self.spriteAtlasName
end

function DActivityTaskSpecificData:IsProgressImgNeedChange()
  return self.isProgressImgNeedChange
end

function DActivityTaskSpecificData:GetTopProgressImg()
  return self.topProgressImg
end

function DActivityTaskSpecificData:GetTopProgressBgImg()
  return self.topProgressBgImg
end

function DActivityTaskSpecificData:GetBottomProgressImg()
  return self.bottomProgressImg
end

function DActivityTaskSpecificData:GetBottomProgressBgImg()
  return self.bottomProgressBgImg
end

function DActivityTaskSpecificData:GetNormalProgressImg()
  return self.normalProgressImg
end

function DActivityTaskSpecificData:GetNormalProgressBgImg()
  return self.normalProgressBgImg
end

function DActivityTaskSpecificData:GetProgressFirstCellImgHeight()
  return self.progressFirstCellImgHeight
end

function DActivityTaskSpecificData:GetProgressNormalCellImgHeight()
  return self.progressNormalCellImgHeight
end

function DActivityTaskSpecificData:IsCloseWithAnim()
  return self.isCloseWithAnim
end

function DActivityTaskSpecificData:GetCloseAnimTb()
  return self.closeAnimTb
end

_class("DActivityTaskSpecificData_EveSinsa", DActivityTaskSpecificData)

function DActivityTaskSpecificData_EveSinsa:Constructor()
  self.shopBtnScriptName = "UIActivityEveSinsaShopBtn"
  self.campaignType = ECampaignType.CAMPAIGN_TYPE_EVERESCUEPLAN
  self.progressCmptId = ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_PERSON_PROGRESS
  self.questCmptId = ECampaignEvaRescuePlanComponentID.ECAMPAIGN_EVARESCUEPLAN_QUEST
  self.progressNumSpecialColor = "FFED00"
  self.progressGotStr = "str_activity_evesinsa_task_received"
  self.progressCanGetStr = "str_activity_evesinsa_task_can_get"
  self.questBgNotFinish = "event_eve_di71"
  self.questBgFinish = "event_eve_di19"
  self.spriteAtlasName = "UIActivityEveSinsa.spriteatlas"
  self.isProgressImgNeedChange = false
  self.topProgressImg = ""
  self.topProgressBgImg = ""
  self.bottomProgressImg = ""
  self.bottomProgressBgImg = ""
  self.normalProgressImg = ""
  self.normalProgressBgImg = ""
  self.progressFirstCellImgHeight = 0
  self.progressNormalCellImgHeight = 0
  self.isCloseWithAnim = true
  self.closeAnimTb = {}
  self.closeAnimTb.uiCloseAnim = "uieff_Activity_Eve_Task_Out"
end

_class("DActivityTaskSpecificData_Sakura", DActivityTaskSpecificData)

function DActivityTaskSpecificData_Sakura:Constructor()
  self.shopBtnScriptName = "UISakuraDrawShopBtn"
  self.campaignType = ECampaignType.CAMPAIGN_TYPE_HIIRO
  self.progressCmptId = ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_PERSON_PROGRESS
  self.questCmptId = ECampaignHiiroComponentID.ECAMPAIGN_HIIRO_QUEST
  self.progressNumSpecialColor = "FF7F00"
  self.progressGotStr = "str_sakura_task_award_got"
  self.progressCanGetStr = "str_sakura_task_award_can_get"
  self.questBgNotFinish = "legend_renwu_di21"
  self.questBgFinish = "legend_renwu_di8"
  self.spriteAtlasName = "UISakura.spriteatlas"
  self.isProgressImgNeedChange = true
  self.topProgressImg = "legend_renwu_di14"
  self.topProgressBgImg = "legend_renwu_di13"
  self.bottomProgressImg = "legend_renwu_di19"
  self.bottomProgressBgImg = "legend_renwu_di20"
  self.normalProgressImg = "legend_renwu_di17"
  self.normalProgressBgImg = "legend_renwu_di18"
  self.progressFirstCellImgHeight = 166.6
  self.progressNormalCellImgHeight = 220
  self.isCloseWithAnim = true
  self.closeAnimTb = {}
  self.closeAnimTb.bgCloseAnim = "uieff_UISakuraTaskController_b_out"
  self.closeAnimTb.uiCloseAnim = "uieff_UISakuraTaskController_u_out"
end
