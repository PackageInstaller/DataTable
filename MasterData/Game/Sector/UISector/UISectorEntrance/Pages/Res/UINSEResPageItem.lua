local base = UIBaseNode
local UINSEResPageItem = class("UINSEResPageItem", UIBaseNode)
local UINSEResPageItemRewardNode = require("Game.Sector.UISector.UISectorEntrance.Pages.Res.UINSEResPageItemRewardNode")
local eSectorEntrance = require("Game.Sector.UISector.UISectorEntrance.eSectorEntrance")

function UINSEResPageItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_dungeonNode, self, self.__OnClickItem)
  UIUtil.AddButtonListener(self.ui.btn_Up, self, self.__OnClickUp)
  self.entranceType = nil
  self.ui.img_Tag:SetActive(false)
  self.rewardNode = UINSEResPageItemRewardNode.New()
  self.rewardNode:Init(self.ui.obj_rewardNode)
end

function UINSEResPageItem:InitResPageItem(dunCfg, playModeCtrl, resloader)
  self.entranceType = dunCfg.system_id
  self.playModeCtrl = playModeCtrl
  self.resloader = resloader
  self._dunCfg = dunCfg
  self.ui.tex_DunNameCN.text = LanguageUtil.GetLocaleText(dunCfg.name_cn)
  self.ui.tex_DunNameEN.text = dunCfg.name_en
  self:__LoadRes(dunCfg)
  self.isUnlock, self.unlockStr = self.playModeCtrl:IsSectorPlayModeUnlock(self.entranceType)
  self.ui.obj_Locked:SetActive(not self.isUnlock)
  if not self.isUnlock then
    self.ui.tex_LockCondition.text = self.unlockStr
    self.rewardNode:Hide()
    return
  end
  self:__RefreshState()
  self:__AddRefrshReddot()
end

function UINSEResPageItem:__RefreshState()
  local modeData = self.playModeCtrl:GetSectorPlayModeShowData(self.entranceType, self._dunCfg)
  self._modeData = modeData
  if modeData == nil then
    return
  end
  local tagIndex = modeData:GetSPMTagInfo()
  local stateType, stateStrArray = modeData:GetSPMStateInfo()
  local getLeftTimeStrFunc = modeData:GetGetLeftTimeFunc()
  self.ui.img_Tag:SetActive(tagIndex ~= nil)
  if tagIndex ~= nil then
    self.ui.tex_tag:SetIndex(tagIndex)
  end
  self.ui.img_stateBk:SetIndex(0)
  self.ui.tex_State.gameObject:SetActive(stateType ~= nil or getLeftTimeStrFunc ~= nil)
  local color = self.ui.col_grayBottom
  if stateType ~= nil then
    if stateStrArray ~= nil then
      self.ui.tex_State:SetIndex(stateType, SafeUnpack(stateStrArray))
      local haveNum = SafeUnpack(stateStrArray)
      if (stateType == eSectorEntrance.stateInfoType.todayLeftTime or stateType == eSectorEntrance.stateInfoType.thisWeekBuffTime) and 0 < tonumber(haveNum) then
        self.ui.img_stateBk:SetIndex(1)
        color = Color.white
      end
    else
      self.ui.tex_State:SetIndex(stateType)
    end
  end
  self.ui.tex_State:SetColor(color)
  if getLeftTimeStrFunc ~= nil then
    local function UpdateTime()
      local remaindTime = getLeftTimeStrFunc()
      
      local d, h, m, s = TimeUtil:TimestampToTimeInter(remaindTime, false, true)
      if 0 < d then
        self.ui.tex_State:SetIndex(eSectorEntrance.stateInfoType.leftTimeWithDay, tostring(d), TimeUtil:HMS2FormatedStr(h, m, s, false, true))
      else
        self.ui.tex_State:SetIndex(eSectorEntrance.stateInfoType.leftTime, TimeUtil:HMS2FormatedStr(h, m, s, false, true))
      end
    end
    
    UpdateTime()
    if self._timerId ~= nil then
      TimerManager:StopTimer(self._timerId)
      self._timerId = nil
    end
    self._timerId = TimerManager:StartTimer(1, function()
      UpdateTime()
    end, self)
  elseif self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  self:__RefreshReward(modeData)
  local isUp = modeData:IsSPMUp()
  self.ui.btn_Up.gameObject:SetActive(isUp)
  self._showUpInfo = nil
  self.ui.upInfo:SetActive(false)
end

function UINSEResPageItem:__LoadRes(dunCfg)
  self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("SectorEntrance"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    self.ui.img_Icon.sprite = AtlasUtil.GetResldSprite(spriteAtlas, dunCfg.icon)
  end)
  local nameResPath = PathConsts:GetSectorEntrancTex(dunCfg.Image)
  self.ui.img_Dungeon.gameObject:SetActive(false)
  self.resloader:LoadABAssetAsync(nameResPath, function(texture)
    if texture == nil or IsNull(self.transform) then
      return
    end
    self.ui.img_Dungeon.gameObject:SetActive(true)
    self.ui.img_Dungeon.texture = texture
  end)
end

function UINSEResPageItem:__RefreshReward(modeData)
  local rewardProgress = modeData:GetSPMRewardProgress()
  if rewardProgress == nil then
    self.rewardNode:Hide()
    return
  end
  self.rewardNode:Show()
  self.rewardNode:RefreshSERPIRewardNode(rewardProgress)
end

function UINSEResPageItem:__AddRefrshReddot()
  if self.removeReddotFunc ~= nil then
    self.removeReddotFunc()
    self.removeReddotFunc = nil
  end
  local actNode = self.playModeCtrl:GetPlayModeReddotNode(self.entranceType)
  
  local function RefrshActivityReddot(node)
    if IsNull(self.gameObject) then
      return
    end
    local isBlue, num = self.playModeCtrl:GetPlayModeReddotTypeAndNum(self.entranceType)
    self.ui.redDot:SetActive(not isBlue and 0 < num)
    self.ui.blueDot:SetActive(isBlue and 0 < num)
    local _, sctSrcNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.SectorEntrance, RedDotStaticTypeId.SectorEntranceSrcDun)
    local sctResNode = sctSrcNode:AddChild(self.entranceType)
    sctResNode:SetRedDotCount(0 < num and 1 or 0)
  end
  
  if actNode == nil then
    RefrshActivityReddot()
    return
  end
  
  function self.removeReddotFunc()
    RedDotController:RemoveListener(actNode.nodePath, RefrshActivityReddot)
  end
  
  RedDotController:AddListener(actNode.nodePath, RefrshActivityReddot)
  RefrshActivityReddot(actNode)
end

function UINSEResPageItem:__OnClickItem()
  if self._showUpInfo then
    self:__OnClickUp()
    return
  end
  if not self.isUnlock then
    return
  end
  self.playModeCtrl:OpenSectorPlayMode(self.entranceType)
end

function UINSEResPageItem:__OnClickUp()
  self._showUpInfo = not self._showUpInfo
  self.ui.upInfo:SetActive(self._showUpInfo)
  if self._showUpInfo then
    self.ui.tex_UpInfo.text = self._modeData:GetSPMUpInfo()
  end
end

function UINSEResPageItem:OnDelete()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  base.OnDelete(self)
end

return UINSEResPageItem
