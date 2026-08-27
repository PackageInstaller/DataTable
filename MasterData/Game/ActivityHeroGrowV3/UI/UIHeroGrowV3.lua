local base = UIBaseWindow
local UIHeroGrowV3 = class("UIHeroGrowV3", base)
local cs_ResLoader = CS.ResLoader
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local SkinEnum = require("Game.Skin.SkinEnum")
local HandBookActReviewOpenFunc = require("Game.HandBook.UI.Activity.HandBookActReviewOpenFunc")
local HandBookActReviewFunc = require("Game.HandBook.UI.Activity.HandBookActReviewFunc")
local ActHGV3Enum = require("Game.ActivityHeroGrowV3.Data.ActHGV3Enum")
local HeroGrowV3Enum = require("Game.ActivityHeroGrowV3.Data.HeroGrowV3Enum")

function UIHeroGrowV3:OnInit()
  UIUtil.SetTopStatus(self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.Btn_Info, self, self.__OnClickInfo)
  UIUtil.AddButtonListener(self.ui.Btn_StoryReview, self, self.__OnClickStoryReview)
  UIUtil.AddButtonListener(self.ui.Btn_Reward, self, self.__OnClickReward)
  UIUtil.AddButtonListener(self.ui.Btn_Task, self, self.__OnClickTask)
  UIUtil.AddButtonListener(self.ui.Btn_Normal, self, self.__OnClickNormalLevel)
  UIUtil.AddButtonListener(self.ui.Btn_Challenge, self, self.__OnClickChallenge)
  UIUtil.AddButtonListener(self.ui.Btn_Repeat, self, self.OnClickRepeat)
  UIUtil.AddButtonListener(self.ui.Btn_HeroDetails, self, self.__OnClickHeroDetails)
  self._resloader = cs_ResLoader.Create()
  self.RefreshHGV3RedDot = BindCallback(self, self.__RefreshHGV3RedDot)
end

function UIHeroGrowV3:InitHeroGrowV3(heroGrowV3Data, enterFunc, backCallback)
  self.heroGrowV3Data = heroGrowV3Data
  self.backCallback = backCallback
  self:__RefreshDeco()
  self:__RefreshHGV3RedDot()
  self:__TimeCountdown()
  self:__RefreshCRPData()
  self:__ShowStartAvg()
  self._timerId = TimerManager:StartTimer(1, self.__TimeCountdown, self)
  local mainRedDot = self.heroGrowV3Data:GetActivityReddot()
  self.nodePath = mainRedDot and mainRedDot.nodePath or nil
  if self.nodePath then
    RedDotController:AddListener(self.nodePath, self.RefreshHGV3RedDot)
  end
end

function UIHeroGrowV3:CharDunV3JumpTarget(actSpecialJumpId)
  if actSpecialJumpId == 1 or actSpecialJumpId == 2 then
    local lastNormalType
    if actSpecialJumpId == 1 then
      lastNormalType = HeroGrowV3Enum.HGV3NormalQuestType.officialTeam
    else
      lastNormalType = HeroGrowV3Enum.HGV3NormalQuestType.freeTeam
    end
    self:__OnClickNormalLevel(lastNormalType)
  elseif actSpecialJumpId == 3 then
    self:__OnClickChallenge()
  elseif actSpecialJumpId == 4 then
    self:OnClickRepeat()
  end
end

function UIHeroGrowV3:__RefreshHGV3RedDot()
  local taskNew = self.heroGrowV3Data:GetIsHaveRedDotByType(ActHGV3Enum.reddotType.DailyTaskNew)
  local taskCom = self.heroGrowV3Data:GetIsHaveRedDotByType(ActHGV3Enum.reddotType.DailyTaskCom)
  self.ui.tex_taskDot.transform.parent.gameObject:SetActive(taskCom or taskNew)
  self.ui.tex_taskDot:SetIndex(taskCom and 1 or 0)
  local bpRewardCom = self.heroGrowV3Data:GetIsHaveRedDotByType(ActHGV3Enum.reddotType.BPRewardCom)
  self.ui.tex_rewardDot.transform.parent.gameObject:SetActive(bpRewardCom)
  self.ui.tex_rewardDot:SetIndex(1)
  self:RefreshRewardLv()
  local normalNew = self.heroGrowV3Data:GetIsHaveRedDotByType(ActHGV3Enum.reddotType.NormalNew)
  self.ui.obj_NormalBlueDot:SetActive(normalNew)
  local challengeNew = self.heroGrowV3Data:GetIsHaveRedDotByType(ActHGV3Enum.reddotType.ChallengeNew)
  local challengeReward = self.heroGrowV3Data:GetIsHaveRedDotByType(ActHGV3Enum.reddotType.ChallengeReward)
  self.ui.obj_ChallengeBlueDot:SetActive(challengeNew and not challengeReward)
  self.ui.obj_ChallengeRedDot:SetActive(challengeReward)
  local repeatTick = self.heroGrowV3Data:GetIsHaveRedDotByType(ActHGV3Enum.reddotType.RepeatHaveTicket)
  self.ui.obj_RepeatBlueDot:SetActive(repeatTick)
end

function UIHeroGrowV3:__RefreshDeco()
  local heroName_EN, heroName = self.heroGrowV3Data:GetHGV3HeroName()
  local friendShipUpPercent = self.heroGrowV3Data:GetHGV3FriendShipUpPercent()
  self.ui.Tex_Name.text = self.heroGrowV3Data:GetActivityName()
  self.ui.Tex_Up:SetIndex(0, heroName, friendShipUpPercent)
  self.ui.Tex_ENName.text = string.upper(heroName_EN)
  self.ui.Tex_CNName.text = heroName
  self:RefreshRewardLv()
  local decoColor = self.heroGrowV3Data:GetHGV3DecoColor()
  for _, colorComp in pairs(self.ui.color_array) do
    colorComp.color = decoColor
  end
  self.ui.Tex_TitleNameNormal.text = self.heroGrowV3Data:GetHGV3NormalName()
  self.ui.Tex_TitleNameChallenge.text = self.heroGrowV3Data:GetHGV3ChallengeName()
  self.ui.Tex_TitleNameRepeat.text = self.heroGrowV3Data:GetHGV3RepeatName()
  self:__LoadHeroDeco()
end

function UIHeroGrowV3:__LoadHeroDeco()
  local heroId = self.heroGrowV3Data:GetHGV3HeroId()
  local frontSkinId, frontType = self.heroGrowV3Data:GetHGV3ResFrontName()
  if frontType == 1 then
    self:__LoadFrontPic(frontSkinId, heroId)
  else
    self:__LoadFrontLive2D(frontSkinId, heroId)
  end
  local backSkinId, backPos = self.heroGrowV3Data:GetHGV3ResBackName()
  self:__LoadBackPic(backSkinId, heroId, backPos)
end

function UIHeroGrowV3:__LoadFrontPic(skinId, heroId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("charDunV3: skinCfg is NIL")
    return
  end
  local resName = skinCfg.src_id_pic
  self._resloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName), function(prefab)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("CharDun")
  end)
end

function UIHeroGrowV3:__LoadFrontLive2D(skinId, heroId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("charDunV3: skinCfg is NIL")
    return
  end
  if not PlayerDataCenter.skinData:IsSkinL2dCouldShow(skinId) then
    self:__LoadFrontPic(skinId, heroId)
    return
  end
  local resName = skinCfg.src_id_pic
  self._resloader:LoadABAssetAsync(PathConsts:GetCharacterLive2DPath(resName), function(l2dModelAsset)
    if IsNull(l2dModelAsset) then
      return
    end
    self.liveGo = l2dModelAsset:Instantiate()
    self.liveGo.transform:SetParent(self.ui.heroHolder)
    self.liveGo.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.liveGo.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), nil, nil, true)
      self.heroCubismInteration:SetL2DPosType("CharDun", false)
    end
  end)
end

function UIHeroGrowV3:__LoadBackPic(skinId, heroId, backPos)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("charDunV3: skinCfg is NIL")
    return
  end
  self._resloader:LoadABAssetAsync(PathConsts:GetCharacterBigPicPath(skinCfg.src_id_pic), function(texture)
    if IsNull(texture) then
      return
    end
    self.ui.Img_Hero.texture = texture
    local uvRect = self.ui.Img_Hero.uvRect
    uvRect.x = backPos[1]
    uvRect.y = backPos[2]
    self.ui.Img_Hero.uvRect = uvRect
  end)
end

function UIHeroGrowV3:RefreshRewardLv()
  local currentLv = self.heroGrowV3Data:GetShopCurrentLv()
  if self.heroGrowV3Data:IsRewardMax() then
    self.ui.Tex_Lvl:SetIndex(0, "Max")
  else
    self.ui.Tex_Lvl:SetIndex(0, tostring(currentLv))
  end
end

function UIHeroGrowV3:__TimeCountdown()
  if self._expireTime == nil or self._expireTime > PlayerDataCenter.timestamp then
    local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self.heroGrowV3Data)
    self.ui.tex_EndTimeTitle.text = title
    self.ui.Tex_EndTime.text = timeStr
    self._expireTime = expireTime
  end
  local diffStr, diff = ActivityFrameUtil.GetCountdownTimeStr(self._expireTime)
  self.ui.Tex_LeftDays.text = diffStr
  if diff <= 0 then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

function UIHeroGrowV3:__RefreshCRPData()
  if self.heroGrowV3Data == nil then
    return
  end
  local actFrameData = self.heroGrowV3Data.actInfo
  if actFrameData ~= nil then
    self._CPRData = HandBookActReviewFunc[actFrameData:GetActivityFrameCat()](actFrameData:GetActId())
  end
end

function UIHeroGrowV3:__ShowStartAvg(isOnlyFirst)
  if self.heroGrowV3Data == nil then
    return
  end
  local avgId = self.heroGrowV3Data:GetStartAvgId()
  local heroGrowV3Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrowV3)
  if heroGrowV3Ctrl ~= nil then
    heroGrowV3Ctrl:PlayHeroGrowAvg(avgId, function()
      self:__RefreshCRPData()
    end)
  end
end

function UIHeroGrowV3:__OnClickInfo()
  local task_rule_title, task_rule_id = self.heroGrowV3Data:GetHGV3RuleDes()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(task_rule_id), ConfigData:GetTipContent(task_rule_title), nil, true)
  end)
end

function UIHeroGrowV3:__OnClickStoryReview()
  if self._CPRData == nil then
    return
  end
  HandBookActReviewOpenFunc:OpenHandbookActReview(self._CPRData, function()
    UIManager:ShowWindowOnly(UIWindowTypeID.HandBookActBookFes)
  end, true)
end

function UIHeroGrowV3:__OnClickReward()
  UIManager:ShowWindowAsync(UIWindowTypeID.CharDunShopVer3, function(window)
    if window == nil then
      return
    end
    window:InitCharDunShopVer3(self.heroGrowV3Data)
  end)
end

function UIHeroGrowV3:__OnClickTask()
  UIManager:ShowWindowAsync(UIWindowTypeID.CharDunTaskVer3, function(window)
    if window == nil then
      return
    end
    window:InitCharDunTaskVer2(self.heroGrowV3Data)
  end)
end

function UIHeroGrowV3:__OnClickNormalLevel(lastNormalType)
  self.heroGrowV3Data:LookedHGV3NormalNewReddot()
  UIManager:ShowWindowAsync(UIWindowTypeID.CahrDunVer3Normal, function(win)
    if win == nil then
      return
    end
    UIManager:HideWindow(UIWindowTypeID.CharDunVer3)
    win:InitHGV3NormalQuest(self.heroGrowV3Data, lastNormalType, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.CharDunVer3, true)
    end)
  end)
end

function UIHeroGrowV3:__OnClickChallenge()
  self.heroGrowV3Data:LookedHGV3ChallengeNewReddot()
  UIManager:ShowWindowAsync(UIWindowTypeID.CahrDunChallengV3, function(win)
    if win == nil then
      return
    end
    UIManager:HideWindow(UIWindowTypeID.CharDunVer3)
    win:InitCahrDunV3(self.heroGrowV3Data, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.CharDunVer3, true)
    end)
  end)
end

function UIHeroGrowV3:OnClickRepeat()
  UIManager:ShowWindowAsync(UIWindowTypeID.CharDunVer3Repeat, function(win)
    if win == nil then
      return
    end
    UIManager:HideWindow(UIWindowTypeID.CharDunVer3)
    win:InitHeroGrowV3Repeat(self.heroGrowV3Data, function()
      UIManager:ShowWindowOnly(UIWindowTypeID.CharDunVer3, true)
    end)
  end)
end

function UIHeroGrowV3:__OnClickHeroDetails()
  local heroId = self.heroGrowV3Data:GetHGV3HeroId()
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroInfoState, function(win)
    if win == nil then
      return
    end
    win:InitHeroInfoState(heroId)
  end)
end

function UIHeroGrowV3:__OnClickClose()
  if self.backCallback ~= nil then
    self.backCallback(false)
  end
  self:Delete()
end

function UIHeroGrowV3:OnDelete()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  if self.nodePath then
    RedDotController:RemoveListener(self.nodePath, self.RefreshHGV3RedDot)
    self.nodePath = nil
  end
  UIManager:DeleteWindow(UIWindowTypeID.DungeonLevelDetail)
  base.OnDelete(self)
end

return UIHeroGrowV3
