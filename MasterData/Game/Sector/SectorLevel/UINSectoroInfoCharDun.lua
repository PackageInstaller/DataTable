local UINSectoroInfoCharDun = class("UINSectoroInfoCharDun", UIBaseNode)
local base = UIBaseNode
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")

function UINSectoroInfoCharDun:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Difficult, self, self.OnClickChangeSector)
  UIUtil.AddButtonListener(self.ui.btn_Info, self, self.OnClickIntro)
  UIUtil.AddButtonListener(self.ui.btn_PlotReview, self, self.OnClickPlotReview)
  UIUtil.AddButtonListener(self.ui.btn_Guide, self, self.__OnClickWarChessGuide)
  self._mainStageColor = self.ui.img_btn_Difficult.color
  self._challengeColor = Color.New(1, 1, 1, 1)
  self.__UpdateBtnStateEvent = BindCallback(self, self.__UpdateBtnState)
  MsgCenter:AddListener(eMsgEventId.HeroGrowActivityRunEnd, self.__UpdateBtnStateEvent)
  self.__UpdateChallengeStateEvent = BindCallback(self, self.__UpdateChallengeState)
  MsgCenter:AddListener(eMsgEventId.HeroGrowActivityUpdate, self.__UpdateChallengeStateEvent)
  MsgCenter:AddListener(eMsgEventId.HeroGrowActivityTimePass, self.__UpdateChallengeStateEvent)
  self.__isInWCGuide = false
  self.ui.tex_GuideDes:SetIndex(0)
end

function UINSectoroInfoCharDun:UpdateSectoroInfoCharDun(sectorCfg, actInfo, selectSectorCallback)
  self._sectorCfg = sectorCfg
  self._sectorId = self._sectorCfg.id
  self._heroGrowInfo = actInfo
  self._heroGrowCfg = nil
  if actInfo ~= nil then
    self._heroGrowCfg = self._heroGrowInfo:GetHeroGrowCfg()
  else
    local actId = ConfigData.activity_hero.sectorMapping[self._sectorId]
    self._heroGrowCfg = actId ~= nil and ConfigData.activity_hero[actId] or nil
  end
  self._selectSectorCallback = selectSectorCallback
  self:__UpdateSectoroInfo()
end

function UINSectoroInfoCharDun:__UpdateSectoroInfo()
  self.ui.tex_CharDunName.text = LanguageUtil.GetLocaleText(self._sectorCfg.name)
  if self._heroGrowCfg == nil then
    return
  end
  if self._heroGrowCfg.main_stage == self._sectorId then
    self._changeSectorId = self._heroGrowCfg.rechallenge_stage
    self.ui.img_btn_Difficult.color = self._mainStageColor
    self.ui.tex_Difficult:SetIndex(0, LanguageUtil.GetLocaleText(ConfigData.sector[self._changeSectorId].name))
  else
    self._changeSectorId = self._heroGrowCfg.main_stage
    self.ui.img_btn_Difficult.color = self._challengeColor
    self.ui.tex_Difficult:SetIndex(1, LanguageUtil.GetLocaleText(ConfigData.sector[self._changeSectorId].name))
  end
  self:__UpdateBtnState()
  self:__UpdateChallengeState()
end

function UINSectoroInfoCharDun:__UpdateBtnState()
  local active = self._heroGrowInfo ~= nil and self._heroGrowInfo:IsActivityRunning()
  local guide_sector = self._heroGrowCfg.guide_sector
  local isWarChess = SectorStageDetailHelper.GetIsSectorHaveWarChessStage(self._sectorId)
  local isHaveWCGuide = guide_sector ~= nil and 0 < guide_sector and isWarChess
  self.ui.btn_Info.gameObject:SetActive(active and not self.__isInWCGuide)
  self.ui.btn_Difficult.gameObject:SetActive(active and not self.__isInWCGuide)
  self.ui.btn_PlotReview.gameObject:SetActive(self._sectorId == self._heroGrowCfg.main_stage)
  self.ui.btn_Guide.gameObject:SetActive(active and (isHaveWCGuide or self.__isInWCGuide))
  self.ui.obj_img_Guide:SetActive(self.__isInWCGuide)
end

function UINSectoroInfoCharDun:__UpdateChallengeState()
  if self._heroGrowInfo == nil then
    return
  end
  if self._sectorId ~= self._heroGrowCfg.rechallenge_stage or not self._heroGrowInfo:IsHeroGrowLimiTimes() then
    self.ui.times:SetActive(false)
    return
  end
  self.ui.times:SetActive(true)
  self.ui.remainTimes:SetIndex(0, tostring(self._heroGrowInfo:GetHeroGrowChallengeCount()), tostring(self._heroGrowCfg.max_time))
  self._targetTime = self._heroGrowInfo:GetHeroGrowChallengeRefrehTime()
  if self.timerId == nil then
    self.timerId = TimerManager:StartTimer(1, self.__TimeCountdown, self)
  end
  self:__TimeCountdown()
end

function UINSectoroInfoCharDun:__TimeCountdown()
  if PlayerDataCenter.timestamp > self._targetTime then
    return
  end
  local coutdown = self._targetTime - PlayerDataCenter.timestamp
  self.ui.tex_RefreshTime:SetIndex(0, TimeUtil:TimestampToTime(coutdown), tostring(self._heroGrowCfg.free_times))
end

function UINSectoroInfoCharDun:OnClickIntro()
  if self._heroGrowCfg == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(self._heroGrowCfg.add_content), ConfigData:GetTipContent(self._heroGrowCfg.add_title))
  end)
end

function UINSectoroInfoCharDun:OnClickChangeSector()
  if self._selectSectorCallback == nil then
    return false
  end
  if not SectorStageDetailHelper.IsSectorNoCollide(self._changeSectorId, true) then
    return false
  end
  self._selectSectorCallback(1, self._changeSectorId)
  self._sectorId = self._changeSectorId
  self._sectorCfg = ConfigData.sector[self._sectorId]
  self:__UpdateSectoroInfo()
  return true
end

function UINSectoroInfoCharDun:OnClickPlotReview()
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroPlotReview, function(window)
    if window == nil then
      return
    end
    local CommonPoltReviewData = require("Game.CommonUI.PlotReview.CommonPoltReviewData")
    local CPRData = CommonPoltReviewData.Create4CharAct(self._heroGrowCfg)
    window:InitCommonPlotReview(CPRData)
  end)
end

function UINSectoroInfoCharDun:__OnClickWarChessGuide()
  if self.__isInWCGuide then
    self._changeSectorId = self.__oldSectorId
    if self:OnClickChangeSector() then
      self.ui.tex_GuideDes:SetIndex(0)
      self.__isInWCGuide = false
    end
  else
    self.__oldSectorId = self._sectorId
    self._changeSectorId = self._heroGrowCfg.guide_sector
    if self:OnClickChangeSector() then
      self.ui.tex_GuideDes:SetIndex(1)
      self.__isInWCGuide = true
    end
  end
  self:__UpdateBtnState()
end

function UINSectoroInfoCharDun:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.HeroGrowActivityRunEnd, self.__UpdateBtnStateEvent)
  MsgCenter:RemoveListener(eMsgEventId.HeroGrowActivityUpdate, self.__UpdateChallengeStateEvent)
  MsgCenter:RemoveListener(eMsgEventId.HeroGrowActivityTimePass, self.__UpdateChallengeStateEvent)
  if self.timerId ~= nil then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  base.OnDelete(self)
end

return UINSectoroInfoCharDun
