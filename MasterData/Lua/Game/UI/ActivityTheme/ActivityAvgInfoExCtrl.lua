local ActivityAvgInfoExCtrl = class("ActivityAvgInfoExCtrl", BaseCtrl)
ActivityAvgInfoExCtrl._mapNodeConfig = {
  mainLineAvgLvName = {sComponentName = "TMP_Text"},
  mainLineAvgLvNum = {sComponentName = "TMP_Text"},
  mainLineAvgLvDes = {sComponentName = "TMP_Text"},
  mainLineBattleLvName = {sComponentName = "TMP_Text"},
  mainLineBattleLvNum = {sComponentName = "TMP_Text"},
  txtBattleStoryDesc = {sComponentName = "TMP_Text"},
  mainLineAvgBtnTex = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldMap_MainLine_Avg_Btn"
  },
  mainLineAvgBtn = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_OpenAvg"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  animator = {sNodeName = "rtWindow", sComponentName = "Animator"},
  btnEnemy = {
    sNodeName = "btnEnemy",
    sComponentName = "UIButton",
    callback = "OnBtnClick_MonsterInfo"
  },
  imgBattleIcon = {},
  txtClueNotice = {},
  imgClueNotice = {},
  goBattleRoot = {},
  goAvgRoot = {},
  goRewardInfo = {},
  imgReward = {sComponentName = "Image"},
  txtRewardCount = {sComponentName = "TMP_Text"},
  txtAvgRewardTitle = {sComponentName = "TMP_Text", sLanguageId = "Level_Info"},
  txtCancelBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainLine_Select_Btn_Cancel"
  },
  txtReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "STRanking_Reward_Btn"
  },
  txtBtnEnemy = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Rank_Enemy_Info"
  }
}
ActivityAvgInfoExCtrl._mapEventConfig = {}

function ActivityAvgInfoExCtrl:Awake()
end

function ActivityAvgInfoExCtrl:FadeOut(callback)
  if type(callback) == "function" then
    callback()
  end
end

function ActivityAvgInfoExCtrl:OnEnable()
end

function ActivityAvgInfoExCtrl:OnDisable()
end

function ActivityAvgInfoExCtrl:OnDestroy()
end

function ActivityAvgInfoExCtrl:OnRelease()
end

function ActivityAvgInfoExCtrl:OpenLevelInfo(avgId, actId, bNewestStory, bReview)
  EventManager.Hit("ActivityStoryReceive_SetVisible", false)
  self.avgId = avgId
  self.actId = actId
  self.bNewestStory = bNewestStory
  self.bReview = bReview == true
  self.storyData = self.bReview and PlayerData.StoryReview or PlayerData.ActivityAvg
  local mapActivityAvg = self.storyData:GetStoryCfgData(avgId)
  if mapActivityAvg == nil then
    printError("nil mainlineData" .. avgId)
    return
  end
  self.IsBattle = mapActivityAvg.IsBattle
  if self.IsBattle then
    NovaAPI.SetTMPText(self._mapNode.mainLineBattleLvNum, mapActivityAvg.Index)
    NovaAPI.SetTMPText(self._mapNode.mainLineBattleLvName, mapActivityAvg.Title)
    NovaAPI.SetTMPText(self._mapNode.txtBattleStoryDesc, mapActivityAvg.Desc)
  else
    NovaAPI.SetTMPText(self._mapNode.mainLineAvgLvNum, mapActivityAvg.Index)
    NovaAPI.SetTMPText(self._mapNode.mainLineAvgLvName, mapActivityAvg.Title)
    NovaAPI.SetTMPText(self._mapNode.mainLineAvgLvDes, mapActivityAvg.Desc)
  end
  self._mapNode.goAvgRoot:SetActive(not mapActivityAvg.IsBattle)
  self._mapNode.goBattleRoot:SetActive(mapActivityAvg.IsBattle)
  self._mapNode.txtClueNotice:SetActive(mapActivityAvg.HasEvidence)
  self._mapNode.imgClueNotice:SetActive(mapActivityAvg.HasEvidence)
  self._mapNode.goRewardInfo:SetActive(false)
  if not self.storyData:IsStoryReaded(mapActivityAvg.Id) then
    local tbReward = decodeJson(mapActivityAvg.FirstCompleteReward)
    if tbReward ~= nil then
      self._mapNode.goRewardInfo:SetActive(true)
      for index, value in pairs(tbReward) do
        self:SetPngSprite(self._mapNode.imgReward, ConfigTable.GetData_Item(tonumber(index)).Icon)
        NovaAPI.SetTMPText(self._mapNode.txtRewardCount, "×" .. value)
      end
    end
  end
  self._mapNode.animator:Play("t_window_04_t_in")
end

function ActivityAvgInfoExCtrl:OnBtnClick_Close()
  self.gameObject:SetActive(false)
  EventManager.Hit("ActivityStoryReceive_SetVisible", true)
  EventManager.Hit("SelectMainlineBattle", false)
  EventManager.Hit("CloseActivityAvgInfo", false)
end

function ActivityAvgInfoExCtrl:OnBtnClick_MonsterInfo(btn)
  EventManager.Hit("OpenActivityStoryMonsterInfo", self.avgId)
end

function ActivityAvgInfoExCtrl:OnBtnClick_OpenAvg(btn)
  self.gameObject:SetActive(false)
  EventManager.Hit("ActivityStoryReceive_SetVisible", true)
  if not self.IsBattle then
    EventManager.Hit("SelectMainlineBattle", false)
    self.storyData:SendMsg_STORY_ENTER(self.actId, self.avgId, 0, self.bNewestStory)
  else
    EventManager.Hit("SelectMainlineBattle", true)
  end
end

return ActivityAvgInfoExCtrl
