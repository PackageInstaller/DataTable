local UICharDunVer2 = class("UICharDunVer2", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local SectorEnum = require("Game.Sector.SectorEnum")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local HeroCubismInteration = require("Game.Hero.Live2D.HeroCubismInteration")
local ActivityCharDunConfig = require("Game.ActivityHeroGrow.ActivityCharDunConfig")
local emptyString = ""

function UICharDunVer2:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseSelf)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self.OnClickInfo)
  UIUtil.AddButtonListener(self.ui.btn_Task, self, self.OnClickTask)
  UIUtil.AddButtonListener(self.ui.btn_Exchange, self, self.OnClickExpLv)
  UIUtil.AddButtonListener(self.ui.btn_NormalBattle, self, self.OnClickMain)
  UIUtil.AddButtonListener(self.ui.btn_EXBattle, self, self.OnClickEx)
  self._resloader = cs_ResLoader.Create()
  self.__RefreshChallengeBtnStateEvent = BindCallback(self, self.__RefreshChallengeBtnState)
  MsgCenter:AddListener(eMsgEventId.HeroGrowActivityUpdate, self.__RefreshChallengeBtnStateEvent)
  MsgCenter:AddListener(eMsgEventId.HeroGrowActivityTimePass, self.__RefreshChallengeBtnStateEvent)
  MsgCenter:AddListener(eMsgEventId.HeroGrowActivityRunEnd, self.__RefreshChallengeBtnStateEvent)
  self.__RefreshLvBtnStateCallback = BindCallback(self, self.__RefreshLvBtnState)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RefreshLvBtnStateCallback)
  self.__RefreshTaskBtnStateCallback = BindCallback(self, self.__RefreshTaskBtnState)
  MsgCenter:AddListener(eMsgEventId.HeroGrowActivityUpdate, self.__RefreshTaskBtnStateCallback)
  self.__OnShowCharacterDungeonUI = BindCallback(self, self.OnShowCharacterDungeonUI)
end

function UICharDunVer2:InitCharacterDungeon(heroGrowAct, enterSecotrFunc, closeCallback)
  self._heroGrowAct = heroGrowAct
  self._enterSecotrFunc = enterSecotrFunc
  self._closeCallback = closeCallback
  self._cfg = self._heroGrowAct:GetHeroGrowCfg()
  self:__ReplaceByUICfg()
  self:__RefreshFix()
  self:__RefreshAllUI()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self._timerId = TimerManager:StartTimer(1, self.__TimerCountdown, self)
  self:__TimerCountdown()
  self._reddot = self._heroGrowAct:GetActivityReddot()
  if self._reddot ~= nil then
    self._reddotFunc = BindCallback(self, self.__RefreshReddot)
    RedDotController:AddListener(self._reddot.nodePath, self._reddotFunc)
    self:__RefreshReddot(self._reddot)
  end
end

function UICharDunVer2:OnEnterCharDunSector(sectorId)
  local isOpen = self._heroGrowAct:IsActivityOpen()
  if not isOpen then
    return
  end
  if self._enterSecotrFunc == nil then
    return
  end
  if not SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
    return
  end
  self:OnHideCharacterDungeonUI()
  self._enterSecotrFunc(sectorId, 1, nil, self.__OnShowCharacterDungeonUI, function()
    if self.charDunSectorCallback then
      self.charDunSectorCallback()
      self.charDunSectorCallback = nil
    end
    local sectorLevelWin = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
    if sectorLevelWin ~= nil then
      sectorLevelWin:SetCustomEnterFmtCallback(function(enterFmtData)
        if enterFmtData ~= nil then
          enterFmtData:SetFmtForbidSupport(true)
          enterFmtData:SetIsShowSupportHolder(true)
        end
      end)
    end
  end)
end

function UICharDunVer2:SetCharDunSectorCallback(callback)
  self.charDunSectorCallback = callback
end

function UICharDunVer2:OnHideCharacterDungeonUI()
  if self._timerId ~= nil then
    TimerManager:PauseTimer(self._timerId)
  end
  self:Hide()
end

function UICharDunVer2:OnShowCharacterDungeonUI()
  self:Show()
  if self._timerId ~= nil then
    TimerManager:ResumeTimer(self._timerId)
  end
end

function UICharDunVer2:__ReplaceByUICfg()
  local uiCfg = ConfigData.activity_hero_ui_config[self._heroGrowAct:GetActId()]
  local atlasPath = PathConsts:GetSpriteAtlasPath("CharDunVer2Icon")
  self._resloader:LoadABAssetAsync(atlasPath, function(altas)
    if altas == nil or IsNull(self.transform) then
      return
    end
    local imgBattle = altas:GetSprite(uiCfg.main_stage_icon)
    local imgEX = altas:GetSprite(uiCfg.challenge_icon)
    self.ui.imgBattle.sprite = imgBattle
    self.ui.imgEX.sprite = imgEX
  end)
  local itemId = self._heroGrowAct:GetHeroGrowCostId()
  self.ui.img_TokenIcon.sprite = CRH:GetSpriteByItemId(itemId)
  local bgPath = PathConsts:GetCharDunVer2Bg(uiCfg.background_res)
  self.ui.background.gameObject:SetActive(false)
  self._resloader:LoadABAssetAsync(bgPath, function(texture)
    if texture == nil or IsNull(self.transform) then
      return
    end
    self.ui.background.gameObject:SetActive(true)
    self.ui.background.texture = texture
  end)
  local nameResPath = PathConsts:GetCharDunVer2Bg(uiCfg.background_text)
  self.ui.img_Name.gameObject:SetActive(false)
  self._resloader:LoadABAssetAsync(nameResPath, function(texture)
    if texture == nil or IsNull(self.transform) then
      return
    end
    self.ui.img_Name.gameObject:SetActive(true)
    self.ui.img_Name.texture = texture
  end)
  self.ui.tex_LvName.text = LanguageUtil.GetLocaleText(uiCfg.reward_panel_name)
  self.ui.tex_TaskName.text = LanguageUtil.GetLocaleText(uiCfg.mission_panel_name)
  self.ui.tex_TokenName.text = ConfigData:GetItemName(itemId)
  local frameColors = uiCfg.frame_color
  local color = Color.New(frameColors[1] / 255, frameColors[2] / 255, frameColors[3] / 255)
  for i, v in ipairs(self.ui.array_colorRep) do
    v.color = color
  end
  local heroId = self._heroGrowAct:GetHeroGrowCfg().hero_id
  local heroCfg = ConfigData.hero_data[heroId]
  local companyCfg = ConfigData.camp[heroCfg.camp]
  self.ui.imgLogo.sprite = CRH:GetSprite(companyCfg.icon, CommonAtlasType.CareerCamp)
  local skinId = uiCfg.background_skin
  if uiCfg.skin_type == 1 then
    self:__LoadPic(heroId, skinId)
  else
    self:__LoadL2D(heroId, skinId)
  end
  if #uiCfg.background_text_point > 0 then
    local vec = Vector2.New(uiCfg.background_text_point[1], uiCfg.background_text_point[2])
    self.ui.img_Name.transform.anchoredPosition = vec
  end
  if 0 < #uiCfg.background_text_size then
    local vec = Vector2.New(uiCfg.background_text_size[1], uiCfg.background_text_size[2])
    self.ui.img_Name.transform.sizeDelta = vec
  end
  self.ui.tex_Name.color = Color.New(uiCfg.main_title_color[1] / 255, uiCfg.main_title_color[2] / 255, uiCfg.main_title_color[3] / 255)
  self.ui.img_Info.color = Color.New(uiCfg.rule_icon_color[1] / 255, uiCfg.rule_icon_color[2] / 255, uiCfg.rule_icon_color[3] / 255)
  if #uiCfg.main_top_res == 0 then
    self.ui.Img_Up.gameObject:SetActive(false)
  else
    local nameResPath = PathConsts:GetCharDunVer2Bg(uiCfg.main_top_res)
    self._resloader:LoadABAssetAsync(nameResPath, function(texture)
      if texture == nil or IsNull(self.transform) then
        return
      end
      self.ui.Img_Up.gameObject:SetActive(true)
      self.ui.Img_Up.texture = texture
    end)
    self.ui.Img_Up.transform.sizeDelta = Vector2.Temp(uiCfg.main_top_size[1], uiCfg.main_top_size[2])
  end
  if #uiCfg.main_down_res == 0 then
    self.ui.Img_Down.gameObject:SetActive(false)
  else
    local nameResPath = PathConsts:GetCharDunVer2Bg(uiCfg.main_down_res)
    self._resloader:LoadABAssetAsync(nameResPath, function(texture)
      if texture == nil or IsNull(self.transform) then
        return
      end
      self.ui.Img_Down.gameObject:SetActive(true)
      self.ui.Img_Down.texture = texture
    end)
    self.ui.Img_Down.transform.sizeDelta = Vector2.Temp(uiCfg.main_down_size[1], uiCfg.main_down_size[2])
  end
  if uiCfg.animation_prefab ~= nil and uiCfg.animation_prefab ~= emptyString then
    local nameResPath = PathConsts:GetCharDunPrefabPath(uiCfg.animation_prefab)
    self._resloader:LoadABAssetAsync(nameResPath, function(prefab)
      if IsNull(prefab) or IsNull(self.transform) then
        return
      end
      local go = prefab:Instantiate(self.ui.obj_AnimationHolder)
    end)
  end
end

function UICharDunVer2:__LoadL2D(heroId, skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  if not PlayerDataCenter.skinData:IsSkinL2dCouldShow(skinId) then
    self:__LoadPic(heroId, skinId)
    return
  end
  local resName = skinCfg.src_id_pic
  self._resloader:LoadABAssetAsync(PathConsts:GetCharacterLive2DPath(resName), function(l2dModelAsset)
    if IsNull(l2dModelAsset) then
      return
    end
    self.liveGo = l2dModelAsset:Instantiate()
    self.liveGo.transform:SetParent(self.ui.heroHolder.transform)
    self.liveGo.transform:SetLayer(LayerMask.UI)
    local cs_CubismInterationController = self.liveGo.gameObject:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismInterationController))
    if cs_CubismInterationController ~= nil then
      self.heroCubismInteration = HeroCubismInteration.New()
      self.heroCubismInteration:InitHeroCubism(cs_CubismInterationController, heroId, skinId, UIManager:GetUICamera(), false)
      self.heroCubismInteration:OpenLookTarget(UIManager:GetUICamera())
      self.heroCubismInteration:SetRenderControllerSetting(self:GetWindowSortingLayer(), self.ui.heroHolder, nil, true)
      self.heroCubismInteration:SetL2DPosType("CharDun", false)
    end
  end)
end

function UICharDunVer2:__LoadPic(heroId, skinId)
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil then
    error("skinCfg is NIL")
    return
  end
  local resName = skinCfg.src_id_pic
  self._resloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resName), function(prefab)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroHolder.transform)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("CharDun")
  end)
end

function UICharDunVer2:__RefreshFix()
  self.ui.tex_Name.text = self._heroGrowAct:GetActivityName()
  local nameStr = ""
  for i, heroId in ipairs(self._cfg.friendship_heroList) do
    local heroCfg = ConfigData.hero_data[heroId]
    if heroCfg == nil then
      error(" heroCfg is NIL id:" .. tostring(heroId))
    else
      nameStr = nameStr .. "[" .. LanguageUtil.GetLocaleText(heroCfg.name) .. "]"
    end
  end
  local friendship_display = tostring(self._cfg.friendship_display) .. "%"
  self.ui.tex_Up.text = string.format(ConfigData:GetTipContent(6042), nameStr, friendship_display)
  local mainSectorCfg = ConfigData.sector[self._cfg.main_stage]
  local rechallengeSectorCfg = ConfigData.sector[self._cfg.rechallenge_stage]
  self.ui.tex_NName.text = LanguageUtil.GetLocaleText(mainSectorCfg.name)
  self.ui.tex_EXName.text = LanguageUtil.GetLocaleText(rechallengeSectorCfg.name)
  local exTypeNameIndex = self._cfg.rechallenge_type
  if exTypeNameIndex ~= 0 then
    self.ui.tex_ExTypeName:SetIndex(exTypeNameIndex - 1)
  end
end

function UICharDunVer2:__TimerCountdown()
  if (self._nextTime or 0) < PlayerDataCenter.timestamp then
    local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self._heroGrowAct)
    self.ui.title.text = title
    self.ui.tex_Timer.text = timeStr
    self._nextTime = expireTime
  end
  local countdownStr, diff = ActivityFrameUtil.GetCountdownTimeStr(self._nextTime)
  self.ui.tex_Days.text = countdownStr
  if diff < 0 and self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

function UICharDunVer2:__RefreshAllUI()
  self:__RefreshNorMainBtnState()
  self:__RefreshChallengeBtnState()
  self:__RefreshTaskBtnState()
  self:__RefreshLvBtnState()
end

function UICharDunVer2:__RefreshNorMainBtnState()
  local isFinish, stageId = PlayerDataCenter.sectorStage:GetSectorProcess(self._cfg.main_stage)
  local stageCfg = ConfigData.sector_stage[stageId]
  local secotrLevelType = SectorEnum.eSectorLevelItemType.OnlyNumber
  local sectorLevelDes = SectorEnum.SectorLevelItemDesc[secotrLevelType]
  self.ui.tex_Stage.text = string.format(sectorLevelDes, stageCfg.num)
end

function UICharDunVer2:__RefreshChallengeBtnState()
  local inTime = self._heroGrowAct:IsActivityRunning()
  self.ui.obj_Lock_ex:SetActive(not inTime)
  if not inTime then
    self.ui.obj_ActEnd:SetActive(not self._heroGrowAct:IsActivityPreview())
    self.ui.aniTip:DOPause()
  else
    self.ui.aniTip:DOPlay()
  end
end

function UICharDunVer2:__RefreshTaskBtnState()
  local totalCount = 0
  local taskDailyCfg = ConfigData.activity_hero_task_daily[self._heroGrowAct:GetActId()]
  for day, v in ipairs(taskDailyCfg) do
    if not self._heroGrowAct:IsHeroGrowDailyTaskIsUnlock(day) then
      break
    end
    totalCount = totalCount + #v.open_task_list + #v.wait_task_list
  end
  local finishCount = table.count(self._heroGrowAct:GetHeroGrowFinishTask())
  self.ui.tex_Progress.text = tostring(finishCount) .. "/" .. tostring(totalCount)
end

function UICharDunVer2:__RefreshLvBtnState()
  local itemId = self._heroGrowAct:GetHeroGrowCostId()
  local count = PlayerDataCenter:GetItemCount(itemId)
  self.ui.tex_TokenNum.text = tostring(count)
end

function UICharDunVer2:__RefreshReddot(node)
  local dailyTaskComNode = node:GetChild(ActivityCharDunConfig.reddotType.dailyTaskCom)
  local dailyTaskNewNode = node:GetChild(ActivityCharDunConfig.reddotType.dailyTaskNew)
  local lvRewardNode = node:GetChild(ActivityCharDunConfig.reddotType.lvReward)
  local challengeNewNode = node:GetChild(ActivityCharDunConfig.reddotType.challengeNew)
  local dailyTaskComCount = dailyTaskComNode ~= nil and dailyTaskComNode:GetRedDotCount() or 0
  local dailyTaskNewCount = dailyTaskNewNode ~= nil and dailyTaskNewNode:GetRedDotCount() or 0
  local lvRewardCount = lvRewardNode ~= nil and lvRewardNode:GetRedDotCount() or 0
  local challengeNewCount = challengeNewNode ~= nil and challengeNewNode:GetRedDotCount() or 0
  self.ui.tag:SetActive(0 < dailyTaskNewCount and dailyTaskComCount == 0)
  self.ui.redDot_task:SetActive(0 < dailyTaskComCount)
  self.ui.blueDot_lv:SetActive(0 < lvRewardCount)
  self.ui.blueDot_ex:SetActive(0 < challengeNewCount)
end

function UICharDunVer2:OnClickTask()
  UIManager:ShowWindowAsync(UIWindowTypeID.CharDunTaskVer2, function(window)
    if window == nil then
      return
    end
    window:InitCharDunTaskVer2(self._heroGrowAct)
  end)
end

function UICharDunVer2:OnClickExpLv()
  UIManager:ShowWindowAsync(UIWindowTypeID.CharDunShopVer2, function(window)
    if window == nil then
      return
    end
    window:InitCharDunShopVer2(self._heroGrowAct)
  end)
end

function UICharDunVer2:OnClickMain()
  if self._enterSecotrFunc == nil then
    return
  end
  self:OnEnterCharDunSector(self._cfg.main_stage)
end

function UICharDunVer2:OnClickEx()
  if not self._heroGrowAct:IsActivityRunning() then
    return
  end
  self:OnEnterCharDunSector(self._cfg.rechallenge_stage)
  self._heroGrowAct:SetHeroGrowChallengeNew()
end

function UICharDunVer2:OnClickInfo()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(self._cfg.rule_content), ConfigData:GetTipContent(self._cfg.rule_title))
  end)
end

function UICharDunVer2:OnCloseSelf()
  self:Delete()
  if self._closeCallback ~= nil then
    self._closeCallback(false)
  end
end

function UICharDunVer2:OnDelete()
  if self.heroCubismInteration ~= nil then
    self.heroCubismInteration:Delete()
    self.heroCubismInteration = nil
  end
  self.ui.aniTip:DOKill()
  self._resloader:Put2Pool()
  self._resloader = nil
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self._reddot = self._heroGrowAct:GetActivityReddot()
  if self._reddot ~= nil then
    RedDotController:RemoveListener(self._reddot.nodePath, self._reddotFunc)
    self._reddot = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RefreshLvBtnStateCallback)
  MsgCenter:RemoveListener(eMsgEventId.HeroGrowActivityUpdate, self.__RefreshChallengeBtnStateEvent)
  MsgCenter:RemoveListener(eMsgEventId.HeroGrowActivityTimePass, self.__RefreshChallengeBtnStateEvent)
  MsgCenter:RemoveListener(eMsgEventId.HeroGrowActivityUpdate, self.__RefreshTaskBtnStateCallback)
  MsgCenter:RemoveListener(eMsgEventId.HeroGrowActivityRunEnd, self.__RefreshChallengeBtnStateEvent)
  base.OnDelete(self)
end

return UICharDunVer2
