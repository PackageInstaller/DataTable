local base = UIBaseNode
local UINSEPageBtnItem = class("UINSEPageBtnItem", UIBaseNode)
local cs_MessageCommon = CS.MessageCommon
local SectorEnum = require("Game.Sector.SectorEnum")
local JumpManager = require("Game.Jump.JumpManager")

function UINSEPageBtnItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Page, self, self.ObClickSEPageBtn)
  self.__isAllLocked = nil
  self.__firstUnlockDes = nil
end

function UINSEPageBtnItem:InitSEPageBtn(index, resloader, onCLickCallback)
  self.__index = index
  self.__resloader = resloader
  self.__onCLickCallback = onCLickCallback
  self:RefreshSEPageBtn()
  self:__IsPageButUnlock(index)
  if index == SectorEnum.ePageIndex.act and not self:__IsActNeedShow() then
    self:Hide()
  end
  local _, mainNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main)
  if self._RefreshEPBReddotCallback ~= nil then
    RedDotController:RemoveListener(mainNode.nodePath, self._RefreshEPBReddotCallback)
    self._RefreshEPBReddotCallback = nil
  end
  
  function self._RefreshEPBReddotCallback()
    self:RefreshEPBReddot(index)
  end
  
  RedDotController:AddListener(mainNode.nodePath, self._RefreshEPBReddotCallback)
  self:RefreshEPBReddot(index)
end

function UINSEPageBtnItem:RefreshSEPageBtn()
  local cfg = ConfigData.sector_entrance_page_info[self.__index]
  if cfg == nil then
    error("can't get sector entrance page, page index:" .. tostring(self.__index))
    return
  end
  self.ui.tex_PageName.text = LanguageUtil.GetLocaleText(cfg.name)
  self.__resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorEntrance"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    if self.ui == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, cfg.icon)
  end)
end

function UINSEPageBtnItem:__IsActNeedShow()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  if actFrameCtrl == nil then
    return false
  end
  return actFrameCtrl:IsNeedShowActEntrance()
end

function UINSEPageBtnItem:__IsPageButUnlock(index)
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  local isAllLocked = false
  local firstUnlockDes
  if index == SectorEnum.ePageIndex.res then
    local dungeonCtrl = sectorCtrl.dungeonCtrl
    local weeklyCtrl = sectorCtrl.weeklyCtrl
    local dailyCtrl = sectorCtrl.dailyCtrl
    isAllLocked = true
    for id, _ in ipairs(ConfigData.sector_entrance_dungeon) do
      local dunCfg = ConfigData.sector_entrance_dungeon[id]
      local playModeCtrl
      local entranceType = dunCfg.system_id
      if dungeonCtrl.IsEntrancetypeDungeon(entranceType) then
        playModeCtrl = dungeonCtrl
      elseif dailyCtrl.IsEntrancetypeDaily(entranceType) then
        playModeCtrl = dailyCtrl
      elseif weeklyCtrl.IsEntrancetypeWeekly(entranceType) then
        playModeCtrl = weeklyCtrl
      end
      if playModeCtrl ~= nil and playModeCtrl:IsSectorPlayModeExist() then
        local isUnlock, unlockStr = playModeCtrl:IsSectorPlayModeUnlock(entranceType)
        if isUnlock then
          isAllLocked = false
          break
        elseif firstUnlockDes == nil then
          firstUnlockDes = unlockStr
        end
      end
    end
  elseif index == SectorEnum.ePageIndex.challenge then
    local blackHoleCtrl = sectorCtrl.blackHoleCtrl
    local sixHeroTowerCtrl = sectorCtrl.sixHeroTowerCtrl
    isAllLocked = true
    for id, _ in ipairs(ConfigData.sector_entrance_challenge) do
      local dunCfg = ConfigData.sector_entrance_challenge[id]
      local playModeCtrl
      local entranceType = dunCfg.system_id
      if blackHoleCtrl.IsEntrancetypeBlackHole(entranceType) then
        playModeCtrl = blackHoleCtrl
      end
      if sixHeroTowerCtrl.IsEntrancetypeSixHeroTower(entranceType) then
        playModeCtrl = sixHeroTowerCtrl
      end
      if playModeCtrl ~= nil and playModeCtrl:IsSectorPlayModeExist() then
        local isUnlock, unlockStr = playModeCtrl:IsSectorPlayModeUnlock(entranceType)
        if isUnlock then
          isAllLocked = false
          break
        elseif firstUnlockDes == nil then
          firstUnlockDes = unlockStr
        end
      end
    end
  end
  if isAllLocked then
    self.__isAllLocked = isAllLocked
    self.__firstUnlockDes = firstUnlockDes
  end
end

function UINSEPageBtnItem:GetEPBIndex()
  return self.__index
end

function UINSEPageBtnItem:SetIsSEPBSelected(bool)
  self.ui.obj_DecoImage:SetActive(bool)
  if not bool then
    self.ui.imgInfo_bottom:SetIndex(0)
    self.ui.tex_PageName.color = Color.gray
    self.ui.img_Icon.color = Color.gray
  else
    self.ui.imgInfo_bottom:SetIndex(1)
    self.ui.tex_PageName.color = Color.white
    self.ui.img_Icon.color = Color.white
  end
end

function UINSEPageBtnItem:RefreshEPBReddot(index)
  local isHave, isBlue
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  if actFrameCtrl == nil then
    isHave = false
    self.ui.redDot:SetActive(not isBlue and isHave)
    self.ui.blueDot:SetActive(isBlue and isHave)
    return
  end
  isHave, isBlue = actFrameCtrl:GetSectorPageReddot(index)
  self.ui.redDot:SetActive(not isBlue and isHave)
  self.ui.blueDot:SetActive(isBlue and isHave)
end

function UINSEPageBtnItem:ObClickSEPageBtn()
  if self.__isAllLocked then
    cs_MessageCommon.ShowMessageTips(self.__firstUnlockDes)
    return
  end
  if self.__onCLickCallback ~= nil then
    self.__onCLickCallback(self.__index)
  end
end

function UINSEPageBtnItem:OnDelete()
  local _, mainNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main)
  RedDotController:RemoveListener(mainNode.nodePath, self._RefreshEPBReddotCallback)
  base.OnDelete(self)
end

return UINSEPageBtnItem
