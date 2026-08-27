local UINUserInfoNodeNewNode = class("UINUserInfoNodeNewNode", UIBaseNode)
local base = UIBaseNode
local MilestoneEnum = require("Game.MileStone.MilestoneEnum")
local MilestoneData = require("Game.MileStone.Data.MilestoneData")
local MilestoneUtil = require("Game.MileStone.MilestoneUtil")
local UINMilestoneStar = require("Game.MileStone.UI.Common.UINMilestoneStar")
local UINUserInfoSupportHeroNode = require("Game.User.UINUserInfoSupportHeroNode")
local length = 146
local starCfg = {
  starAixLengt = length,
  starEdgeAixLengt = length / math.sqrt(3),
  firstProcessLength = length * 0.28,
  processLength = length - length * 0.28
}

function UINUserInfoNodeNewNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.starNode = UINMilestoneStar.New()
  self.starNode:Init(self.ui.obj_sixStar)
  self.supportPool = UIItemPool.New(UINUserInfoSupportHeroNode, self.ui.obj_supportHeroItem, false)
  self.__onClickStarNode = BindCallback(self, self.__OnClickStarNode)
  self.__onMsDataUpdate = BindCallback(self, self.__OnMsDataUpdate)
  MsgCenter:AddListener(eMsgEventId.milestoneDataUpdate, self.__onMsDataUpdate)
end

function UINUserInfoNodeNewNode:InitUserInfoNewNode(userInfoData)
  self.userInfoData = userInfoData
  self.msData = userInfoData:GetMilestoneData()
  self.starNode:InitSixPointStar(self.__onClickStarNode, starCfg)
  for index, go in pairs(self.ui.objList_msTitle) do
    local goUI = {}
    UIUtil.LuaUIBindingTable(go.transform, goUI)
    local msModuleId = index
    local MSDData = self.msData:GetMilestoneDimensionData(msModuleId)
    local curStage = MSDData:GetMlstDimensionStage()
    goUI.ms_NameNode.text = MSDData:GetMlstDimensionName()
    goUI.img_StageBg.color = MilestoneUtil.GetSPClassSColor4Stage(curStage)
    goUI.tex_Stage.text = MilestoneUtil.GetSPSStageId2EngChar(curStage)
  end
end

function UINUserInfoNodeNewNode:RrefreshAllSupporHero(userInfoData, resLoader, couldEditSelf)
  self.supportPool:HideAll()
  for index, supportHeroInfo in ipairs(userInfoData:GetSupportHoreInfoList()) do
    local item = self.supportPool:GetOne()
    item:InitSupportHero(index, userInfoData, resLoader, couldEditSelf)
  end
end

function UINUserInfoNodeNewNode:OnUserInfoNewNodeHeroUpdate()
  for _, nodeItem in pairs(self.supportPool.listItem) do
    nodeItem:RefreshSupportHero()
  end
end

function UINUserInfoNodeNewNode:RrefreshSixPointStar(userInfoData)
  local stageDic, processDic = self.msData:GetDataForStar2Show()
  self.starNode:RefreshSPSMultPoint(stageDic, processDic)
end

function UINUserInfoNodeNewNode:__OnClickStarNode()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_MileStones)
  if not isUnlock then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MailStoneMian, function(win)
    if win == nil then
      return
    end
    UIManager:HideWindow(UIWindowTypeID.CommonUserInfo)
    win:InitMilestoneMain(self.msData, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.CommonUserInfo)
    end)
  end)
end

function UINUserInfoNodeNewNode:__OnMsDataUpdate()
  local userInfoData = self.msData:GetMSUserInfoData()
  if not userInfoData:GetIsSelfUserInfo() then
    return
  end
  local stageDic, processDic = self.msData:GetDataForStar2Show()
  self.starNode:RefreshSPSMultPoint(stageDic, processDic, true)
end

function UINUserInfoNodeNewNode:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.milestoneDataUpdate, self.__onMsDataUpdate)
  if self.supportPool ~= nil then
    self.supportPool:DeleteAll()
  end
  self.starNode:Delete()
  base.OnDelete(self)
end

return UINUserInfoNodeNewNode
