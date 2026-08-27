local base = UIBaseNode
local UISESectorPage = class("UISESectorPage", UIBaseNode)
local UINSESectorListNode = require("Game.Sector.UISector.UISectorEntrance.Pages.Sector.UINSESectorListNode")
local CS_ClientConsts = CS.ClientConsts

function UISESectorPage:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_StrategyOverview, self, self.__OnClickStrategyOverview)
  UIUtil.AddButtonListener(self.ui.btn_SectorRecommend, self, self.__OnClickRecommend)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self.__OnClickBackMap)
  UIUtil.AddButtonListener(self.ui.btn_Next, self, self.__OnClickNextMap)
  self.__refreshStrategyOverviewReddot = BindCallback(self, self.RefreshStrategyOverviewReddot)
  RedDotController:AddListener(RedDotDynPath.StrategyOverviewPath, self.__refreshStrategyOverviewReddot)
  self._onMapChange = BindCallback(self, self.RefreshCurrentSector)
  MsgCenter:AddListener(eMsgEventId.OnSectorMapSwich, self._onMapChange)
  self._RefreshCurrentSectorScale = BindCallback(self, self.RefreshCurrentSectorScale)
  MsgCenter:AddListener(eMsgEventId.OnSectorCamSacle, self._RefreshCurrentSectorScale)
  self.ui.anima_switchNode.gameObject:SetActive(false)
  self.sectorListNode = UINSESectorListNode.New()
  self.sectorListNode:Init(self.ui.sectorListNode)
end

function UISESectorPage:InitSEPage(resloader)
  self.__resloader = resloader
  self.sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  self.addCtrl = self.sectorCtrl.addCtrl
  self.sectorListNode:InitSESectorListNode()
  self:RefreshStrategyOverviewReddot()
  self:RefreshRecommendLevel()
  self:RefreshCurrentSector()
  self:RefreshCurrentSectorScale()
end

function UISESectorPage:RefreshCurrentSector()
  local curMapId = self.sectorCtrl:GetSctCurMapId()
  local sctMapCfg = ConfigData.sector_sector_map[curMapId]
  self.ui.tex_Index.text = sctMapCfg.serial
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(sctMapCfg.name)
  local lastMapCfg = ConfigData.sector_sector_map[curMapId - 1]
  if lastMapCfg then
    self.ui.tex_LastNumber.text = lastMapCfg.serial
  end
  self.ui.btn_Back.gameObject:SetActive(lastMapCfg ~= nil)
  local nextMapId = curMapId + 1
  local nextMapCfg = ConfigData.sector_sector_map[nextMapId]
  if nextMapCfg then
    self.ui.tex_NextNumber.text = nextMapCfg.serial
    local nextMapUnlock, nextMapFirstSectorId = PlayerDataCenter.sectorStage:IsSectorMapUnlock(nextMapId)
    self.ui.Obj_NextLock:SetActive(not nextMapUnlock)
    self.ui.tex_NextNumber.gameObject:SetActive(nextMapUnlock)
    local isRead = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):IsNewSectorMapRead(nextMapId)
    local isOpen = nextMapUnlock and not isRead
    self.ui.obj_NextMapBlueDot:SetActive(isOpen)
    local _, sctMainNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceMain)
    local sctMainChapterNode = sctMainNode:AddChild(RedDotStaticTypeId.SectorEntranceMainChapter)
    if isOpen then
      sctMainChapterNode:SetRedDotCount(1)
    else
      sctMainChapterNode:SetRedDotCount(0)
    end
  end
  local isShowNextMap = nextMapCfg ~= nil
  if CS_ClientConsts.IsAudit then
    isShowNextMap = false
  end
  self.ui.btn_Next.gameObject:SetActive(isShowNextMap)
end

function UISESectorPage:RefreshCurrentSectorScale()
  local rate = self.sectorCtrl.camCtrl:GetSctCamScaleRate()
  self.ui.img_ScaleBar.fillAmount = rate
end

function UISESectorPage:RefreshRecommendLevel()
  self.addCtrl:RefreshRecommeStage()
  local recommeStage = self.addCtrl:GetSectorRecommendStageInfo()
  self.ui.btn_SectorRecommend.gameObject:SetActive(recommeStage ~= nil)
  if recommeStage ~= nil then
    self.ui.tex_SectorRecoInf.text = recommeStage.msg
  end
end

function UISESectorPage:MovieBlackInitSectorNode()
  self.sectorListNode:CloseSectorBtnExpand()
  TimerManager:StartTimer(1.5, function()
    if not IsNull(self.transform) then
      self.sectorListNode:InitSESectorListNode()
    end
  end, nil, true)
end

function UISESectorPage:__OnClickBackMap()
  self.sectorCtrl:SwitchNextSectorMap(false, function()
    if UIManager:GetWindow(UIWindowTypeID.MovieBlack) ~= nil then
      self:MovieBlackInitSectorNode()
      return
    end
    self:RefreshCurrentSectorScale()
    self:__PlaySwitchMapAnimation(false)
  end)
end

function UISESectorPage:__OnClickNextMap()
  self.sectorCtrl:SwitchNextSectorMap(true, function()
    if UIManager:GetWindow(UIWindowTypeID.MovieBlack) ~= nil then
      self:MovieBlackInitSectorNode()
      return
    end
    self:RefreshCurrentSectorScale()
    self:__PlaySwitchMapAnimation(true)
  end)
end

function UISESectorPage:__OnClickStrategyOverview()
  self.addCtrl:OpenSectorSO()
end

function UISESectorPage:__OnClickRecommend()
  self.addCtrl:Jump2RecommendLevel()
end

function UISESectorPage:__PlaySwitchMapAnimation(isNext)
  self.sectorListNode:CloseSectorBtnExpand()
  self.ui.anima_switchNode.gameObject:SetActive(true)
  local newMapId = self.sectorCtrl:GetSctCurMapId()
  local sctMapCfg = ConfigData.sector_sector_map[newMapId]
  if sctMapCfg ~= nil then
    self.ui.tex_SwitchIndex.text = sctMapCfg.serial
    self.ui.tex_SwitchName.text = LanguageUtil.GetLocaleText(sctMapCfg.name)
  end
  self.ui.anima_switchNode:Stop()
  local clipName
  if isNext then
    clipName = "UI_SectorEntranceSwitchNodeToright"
  else
    clipName = "UI_SectorEntranceSwitchNodeToleft"
  end
  self.ui.anima_switchNode:Play(clipName)
  local clip = self.ui.anima_switchNode:GetClip(clipName)
  TimerManager:StartTimer(clip.length, function()
    if not IsNull(self.transform) then
      self.ui.anima_switchNode.gameObject:SetActive(false)
      self.sectorListNode:InitSESectorListNode()
    end
  end, nil, true)
end

function UISESectorPage:RefreshAllSESPReddot()
end

function UISESectorPage:RefreshStrategyOverviewReddot()
  local isBlue, num = self.addCtrl:GetSectorSOReddotNum()
  self.ui.obj_StrRedDot:SetActive(not isBlue and 0 < num)
  self.ui.obj_StrBlueDot:SetActive(isBlue and 0 < num)
  local _, sctMainNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceMain)
  local sctMainStrategyNode = sctMainNode:AddChild(RedDotStaticTypeId.SectorEntranceMainStrategy)
  if 0 < num then
    sctMainStrategyNode:SetRedDotCount(1)
  else
    sctMainStrategyNode:SetRedDotCount(0)
  end
end

function UISESectorPage:OnHide()
  self.ui.anima_switchNode:Stop()
  self.ui.anima_switchNode.gameObject:SetActive(false)
end

function UISESectorPage:OnDelete()
  self.sectorListNode:Delete()
  MsgCenter:RemoveListener(eMsgEventId.OnSectorMapSwich, self._onMapChange)
  MsgCenter:RemoveListener(eMsgEventId.OnSectorCamSacle, self._RefreshCurrentSectorScale)
  RedDotController:RemoveListener(RedDotDynPath.StrategyOverviewPath, self.__refreshStrategyOverviewReddot)
  base.OnDelete(self)
end

return UISESectorPage
