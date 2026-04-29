_class("DActivityProgressSpecificData", Object)

function DActivityProgressSpecificData:Constructor()
  self.campaignType = 0
  self.progressCmptId = 0
  self.progressNumSpecialColor = 0
  self.progressGotStr = ""
  self.progressCanGetStr = ""
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

function DActivityProgressSpecificData:GetCampaignType()
  return self.campaignType
end

function DActivityProgressSpecificData:GetProgressCmptId()
  return self.progressCmptId
end

function DActivityProgressSpecificData:GetQuestNumSpecialColor()
  return self.progressNumSpecialColor
end

function DActivityProgressSpecificData:GetQuestGotStr()
  return self.progressGotStr
end

function DActivityProgressSpecificData:GetQuestCanGetStr()
  return self.progressCanGetStr
end

function DActivityProgressSpecificData:GetSpriteAtlasName()
  return self.spriteAtlasName
end

function DActivityProgressSpecificData:IsProgressImgNeedChange()
  return self.isProgressImgNeedChange
end

function DActivityProgressSpecificData:GetTopProgressImg()
  return self.topProgressImg
end

function DActivityProgressSpecificData:GetTopProgressBgImg()
  return self.topProgressBgImg
end

function DActivityProgressSpecificData:GetBottomProgressImg()
  return self.bottomProgressImg
end

function DActivityProgressSpecificData:GetBottomProgressBgImg()
  return self.bottomProgressBgImg
end

function DActivityProgressSpecificData:GetNormalProgressImg()
  return self.normalProgressImg
end

function DActivityProgressSpecificData:GetNormalProgressBgImg()
  return self.normalProgressBgImg
end

function DActivityProgressSpecificData:GetProgressFirstCellImgHeight()
  return self.progressFirstCellImgHeight
end

function DActivityProgressSpecificData:GetProgressNormalCellImgHeight()
  return self.progressNormalCellImgHeight
end

function DActivityProgressSpecificData:IsCloseWithAnim()
  return self.isCloseWithAnim
end

function DActivityProgressSpecificData:GetCloseAnimTb()
  return self.closeAnimTb
end

_class("DActivityTaskSpecificData_N5", DActivityProgressSpecificData)

function DActivityTaskSpecificData_N5:Constructor()
  self.campaignType = ECampaignType.CAMPAIGN_TYPE_N5
  self.progressCmptId = ECampaignN5ComponentID.ECAMPAIGN_N5_PERSON_PROGRESS
  self.progressNumSpecialColor = "FFED00"
  self.progressGotStr = "str_quest_base_got"
  self.progressCanGetStr = "str_quest_base_can_get"
  self.spriteAtlasName = "UIN5.spriteatlas"
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
  self.closeAnimTb.uiCloseAnim = ""
end
