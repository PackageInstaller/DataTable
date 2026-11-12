local MainlineAvgInfoExCtrl = class("MainlineAvgInfoExCtrl", BaseCtrl)
local AvgData = PlayerData.Avg
MainlineAvgInfoExCtrl._mapNodeConfig = {
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
  txtClueNotice = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainLine_Clue_Notice"
  },
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
MainlineAvgInfoExCtrl._mapEventConfig = {}

function MainlineAvgInfoExCtrl:Awake()
end

function MainlineAvgInfoExCtrl:FadeOut(callback)
  if type(callback) == "function" then
    callback()
  end
end

function MainlineAvgInfoExCtrl:OnEnable()
end

function MainlineAvgInfoExCtrl:OnDisable()
end

function MainlineAvgInfoExCtrl:OnDestroy()
end

function MainlineAvgInfoExCtrl:OnRelease()
end

function MainlineAvgInfoExCtrl:OpenLevelInfo(avgId, bNewestStory)
  self.avgId = avgId
  self.bNewestStory = bNewestStory
  local mapMainline = AvgData:GetStoryCfgData(avgId)
  if mapMainline == nil then
    printError("nil mainlineData" .. avgId)
    return
  end
  self.IsBattle = mapMainline.IsBattle
  if self.IsBattle then
    NovaAPI.SetTMPText(self._mapNode.mainLineBattleLvNum, mapMainline.Index)
    NovaAPI.SetTMPText(self._mapNode.mainLineBattleLvName, mapMainline.Title)
    NovaAPI.SetTMPText(self._mapNode.txtBattleStoryDesc, mapMainline.Desc)
  else
    NovaAPI.SetTMPText(self._mapNode.mainLineAvgLvNum, mapMainline.Index)
    NovaAPI.SetTMPText(self._mapNode.mainLineAvgLvName, mapMainline.Title)
    NovaAPI.SetTMPText(self._mapNode.mainLineAvgLvDes, mapMainline.Desc)
  end
  self._mapNode.goAvgRoot:SetActive(not mapMainline.IsBattle)
  self._mapNode.goBattleRoot:SetActive(mapMainline.IsBattle)
  self._mapNode.txtClueNotice.gameObject:SetActive(mapMainline.HasEvidence)
  self._mapNode.imgClueNotice:SetActive(mapMainline.HasEvidence)
  self._mapNode.goRewardInfo:SetActive(false)
  if not AvgData:IsStoryReaded(mapMainline.Id) then
    local tbReward = decodeJson(mapMainline.RewardDisplay)
    if 0 < #tbReward then
      self._mapNode.goRewardInfo:SetActive(true)
      self:SetPngSprite(self._mapNode.imgReward, ConfigTable.GetData_Item(tbReward[1].Tid).Icon)
      NovaAPI.SetTMPText(self._mapNode.txtRewardCount, "×" .. tbReward[1].Qty)
    end
  end
  self._mapNode.animator:Play("t_window_04_t_in")
end

function MainlineAvgInfoExCtrl:OnBtnClick_Close()
  self.gameObject:SetActive(false)
  EventManager.Hit("SelectMainlineBattle", false)
end

function MainlineAvgInfoExCtrl:OnBtnClick_MonsterInfo(btn)
  EventManager.Hit("OpenMainlineMonsterInfo", self.avgId)
end

function MainlineAvgInfoExCtrl:OnBtnClick_OpenAvg(btn)
  self.gameObject:SetActive(false)
  if not self.IsBattle then
    EventManager.Hit("SelectMainlineBattle", false)
    AvgData:SendMsg_STORY_ENTER(self.avgId, 0, self.bNewestStory)
  else
    EventManager.Hit("SelectMainlineBattle", true)
  end
end

return MainlineAvgInfoExCtrl
