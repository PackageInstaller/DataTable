local base = UIBaseNode
local UINWarChessInfoInfoRoot = class("UINWarChessInfoInfoRoot", base)
local eWCInteractType = require("Game.WarChess.Interact.Base.eWCInteractType")
local WarChessHelper = require("Game.WarChess.WarChessHelper")

function UINWarChessInfoInfoRoot:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__showPos = nil
  self.__showOrgPos = nil
  self.__showOffset = Vector3.zero
  self.__preHpRate = nil
end

function UINWarChessInfoInfoRoot:WCIRSetShowPos(showPos)
  self.__showOrgPos = showPos
  self.__showPos = self.__showOrgPos + self.__showOffset
  self:WCIRUpdatPos()
end

function UINWarChessInfoInfoRoot:WCIRSetShowPosOffset(offsetY)
  self.__showOffset = Vector3.New(0, offsetY, 0)
  self.__showPos = self.__showOrgPos + self.__showOffset
  self:WCIRUpdatPos()
end

function UINWarChessInfoInfoRoot:WCIRIsInView(xMin, yMin, xMax, yMax)
  if xMin == nil or yMin == nil or xMax == nil or yMax == nil then
    return true
  end
  local x = self.__showPos.x
  local y = self.__showPos.z
  return xMin <= x and xMax >= x and yMin <= y and yMax >= y
end

function UINWarChessInfoInfoRoot:WCIRUpdatPos()
  local uiPos = UIManager:World2UIPosition(self.__showPos, self.transform.parent)
  self.transform.anchoredPosition = uiPos
end

function UINWarChessInfoInfoRoot:SetResloader(resloader)
  self.resloader = resloader
  self.iconAtlas = resloader:LoadABAsset(PathConsts:GetAtlasAssetPath("WarChess"))
end

function UINWarChessInfoInfoRoot:PopInfoRoot4Entity(entityData, winInfo)
  self.entityData = entityData
  self.winInfo = winInfo
  self.gameObject.transform:SetAsLastSibling()
  local showPos = entityData:GetEntityShowPos()
  self:WCIRSetShowPos(showPos)
  local offsetY = entityData:GetInteractShowOffset()
  self:WCIRSetShowPosOffset(offsetY)
  local isMonster = entityData:GetEntityIsMonster()
  local iconRes = self.entityData:GetWCUnitInterActIcon()
  self.__opIconItem = self.winInfo.opIconPool:GetOne()
  self.__opIconItem:SetWCIIOpIcon(self.iconAtlas, iconRes)
  self.__opIconItem:PlayWCIIIOpIconntoTween()
  self.__opIconItem.transform:SetParent(self.ui.iconHolder)
  self.__opIconItem.transform.localPosition = Vector3.one
  if isMonster then
    local hpRate = entityData:GetWCMonsterHP()
    if hpRate < 1 then
      self.__hpBarItem = self.winInfo.hpBarPool:GetOne()
      self.__hpBarItem:SetWCIIHPBar(true, hpRate)
      self.__hpBarItem.transform:SetParent(self.ui.hpBarHolder)
      self.__hpBarItem.transform.localPosition = Vector3.one
    end
    if self.__enemyMoveItem == nil then
      local isOK, maxPathLength = WarChessHelper.CheckEnemyCanMove(entityData)
      if isOK then
        self.__enemyMoveItem = self.winInfo.enemyMovePool:GetOne()
        self.__enemyMoveItem:SetCouldMoveDistance(maxPathLength)
        self.__enemyMoveItem.transform:SetParent(self.ui.enemyMoveHolder)
        self.__enemyMoveItem.transform.localPosition = Vector3.zero
      end
    end
  end
  self:UpdateAllInfo()
end

function UINWarChessInfoInfoRoot:PopInfoRoot4Grid(gridData, winInfo)
  self.gridData = gridData
  self.winInfo = winInfo
  self.gameObject.transform:SetAsLastSibling()
  local showPos = gridData:GetGridShowPos()
  self:WCIRSetShowPos(showPos)
  local offsetY = gridData:GetInteractShowOffset()
  self:WCIRSetShowPosOffset(offsetY)
  if gridData:GetFirstGridInertactWithCat(eWCInteractType.born) ~= nil then
    if gridData:GetCouldShowBornFX() then
      self.__deployMarkItem = self.winInfo.deployPool:GetOne()
      self.__deployMarkItem.transform:SetParent(self.ui.iconHolder)
      self.__deployMarkItem.transform.localPosition = Vector3.one
    end
    return
  end
  local iconRes = self.gridData:GetWCUnitInterActIcon()
  self.__opIconItem = self.winInfo.opIconPool:GetOne()
  self.__opIconItem:SetWCIIOpIcon(self.iconAtlas, iconRes)
  self.__opIconItem:PlayWCIIIOpIconntoTween()
  self.__opIconItem.transform:SetParent(self.ui.iconHolder)
  self.__opIconItem.transform.localPosition = Vector3.one
  self:UpdateAllInfo()
end

function UINWarChessInfoInfoRoot:PopInfoRoot4Team(teamData, winInfo)
  self.teamData = teamData
  self.winInfo = winInfo
  self.gameObject.transform:SetAsFirstSibling()
  local index = teamData:GetWCTeamIndex()
  local heroEntity = self.winInfo.wcCtrl.teamCtrl:GetWCHeroEntity(index, nil, nil)
  local showPos = heroEntity:WCHeroEntityGetShowPos()
  self:WCIRSetShowPos(showPos)
  self:WCIRSetShowPosOffset(0.5)
  local hpRate = teamData:GetWCTeamHP()
  self.__hpBarItem = self.winInfo.hpBarPool:GetOne()
  if self.__TeamHpLerpTimer then
    TimerManager:StopTimer(self.__TeamHpLerpTimer)
    self.__TeamHpLerpTimer = nil
  end
  self.__hpBarItem:SetWCIIHPBar(false, hpRate)
  self.__preHpRate = hpRate
  self.__hpBarItem.transform:SetParent(self.ui.hpBarHolder)
  self.__hpBarItem.transform.localPosition = Vector3.one
  local ap = teamData:GetTeamActionPoint()
  local maxAp = self.winInfo.wcCtrl.teamCtrl:GetWCAPMaxNum()
  self.__teamInfoItem = self.winInfo.teamInfoPool:GetOne()
  self.__teamInfoItem:SetWCIITeamInfo(teamData, ap, maxAp)
  self.__teamInfoItem.transform:SetParent(self.ui.teamHolder)
  self.__teamInfoItem.transform.localPosition = Vector3.one
  self:UpdateAllInfo()
end

function UINWarChessInfoInfoRoot:UpdateAllInfo()
  if self.teamData ~= nil then
    if self.teamData:GetIsShowHead3DUI() then
      self.__teamInfoItem:Show()
    else
      self.__teamInfoItem:Hide()
    end
    local isSelected = self.winInfo.selectedTeamData == self.teamData
    self.__teamInfoItem:SetWCIITeamInfoIsSelected(isSelected)
    local ap = self.teamData:GetTeamActionPoint()
    local maxAp = self.winInfo.wcCtrl.teamCtrl:GetWCAPMaxNum()
    self.__teamInfoItem:SetWCIITeamInfo(self.teamData, ap, maxAp)
    local teamHeadIconId = self.teamData:GetTeamHeadIcon()
    self.__teamInfoItem:SetWCIITeamInfoOverraHeadIconId(self.iconAtlas, teamHeadIconId)
  elseif self.gridData ~= nil then
    if self.winInfo.curInterActData == self.gridData then
      self.winInfo.OPNode.transform:SetParent(self.ui.opHolder.transform)
      self.winInfo.OPNode.transform.localPosition = Vector3.one
      self.winInfo.OPNode:Show()
    end
    local couldShowDeployFX = self.gridData:GetCouldShowBornFX()
    if couldShowDeployFX and self.__deployMarkItem == nil then
      self.__deployMarkItem = self.winInfo.deployPool:GetOne()
      self.__deployMarkItem.transform:SetParent(self.ui.iconHolder)
      self.__deployMarkItem.transform.localPosition = Vector3.one
    end
    if not couldShowDeployFX and self.__deployMarkItem ~= nil then
      self.__deployMarkItem.transform:SetParent(self.winInfo.ui.infoItems.transform)
      self.winInfo.deployPool:HideOne(self.__deployMarkItem)
      self.__deployMarkItem = nil
    end
    if self.__opIconItem ~= nil then
      local iconRes = self.gridData:GetWCUnitInterActIcon()
      self.__opIconItem:SetWCIIOpIcon(self.iconAtlas, iconRes)
    end
  elseif self.entityData ~= nil then
    if self.winInfo.curInterActData == self.entityData then
      self.winInfo.OPNode.transform:SetParent(self.ui.opHolder.transform)
      self.winInfo.OPNode.transform.localPosition = Vector3.one
      self.winInfo.OPNode:Show()
    end
    if self.__opIconItem ~= nil then
      local iconRes = self.entityData:GetWCUnitInterActIcon()
      self.__opIconItem:SetWCIIOpIcon(self.iconAtlas, iconRes)
    end
    local headIconOverraidId = self.entityData:GetEntityHeadIcon()
    if headIconOverraidId ~= nil then
      if self.__entityHeadIconItem == nil then
        self.__entityHeadIconItem = self.winInfo.entityHeadIconPool:GetOne()
        self.__entityHeadIconItem.transform:SetParent(self.ui.entityHeadIconHolder)
        self.__entityHeadIconItem.transform.localPosition = Vector3.one
      end
      self.__entityHeadIconItem:RefreshEntityHeadIcon(self.iconAtlas, headIconOverraidId)
    elseif self.__entityHeadIconItem ~= nil then
      self.__entityHeadIconItem.transform:SetParent(self.winInfo.ui.infoItems.transform)
      self.winInfo.entityHeadIconPool:HideOne(self.__entityHeadIconItem)
      self.__entityHeadIconItem = nil
    end
  end
  self:WCIRSetInteractInfoActive(self.winInfo.selectedTeamData ~= nil, self.winInfo.selectedTeamData)
end

function UINWarChessInfoInfoRoot:ShowTeamApReduceTip(changeTeam, diffAp)
  self.__teamInfoItem:ShowWCIITeamInfoApReduceTip(changeTeam, diffAp)
end

function UINWarChessInfoInfoRoot:CheckEntityCanMove()
  local entityData = self.entityData
  if entityData ~= nil and entityData:GetEntityIsMonster() and self.__enemyMoveItem == nil then
    local isOK, maxPathLength = WarChessHelper.CheckEnemyCanMove(entityData)
    if isOK then
      self.__enemyMoveItem = self.winInfo.enemyMovePool:GetOne()
      self.__enemyMoveItem:SetCouldMoveDistance(maxPathLength)
      self.__enemyMoveItem.transform:SetParent(self.ui.enemyMoveHolder)
      self.__enemyMoveItem.transform.localPosition = Vector3.zero
    end
  end
end

function UINWarChessInfoInfoRoot:WCInfoGetData()
  if self.entityData ~= nil then
    return self.entityData
  end
  if self.gridData ~= nil then
    return self.gridData
  end
  if self.teamData ~= nil then
    return self.teamData
  end
  if self.winInfo ~= nil then
    return self.winInfo
  end
  return nil
end

function UINWarChessInfoInfoRoot:WCIRSetInteractInfoActive(bool, teamData)
  local isInInteractableRange = false
  if teamData ~= nil then
    local couldInetactDic = teamData:GetWCTeamInteractablePosDic()
    local coordination
    if self.gridData ~= nil then
      coordination = WarChessHelper.Pos2Coordination(self.gridData:GetGridLogicPos())
    elseif self.entityData ~= nil then
      coordination = WarChessHelper.Pos2Coordination(self.entityData:GetEntityLogicPos())
    end
    isInInteractableRange = couldInetactDic[coordination]
  end
  self:SetIsShowselfOpIconItem(bool and isInInteractableRange)
end

function UINWarChessInfoInfoRoot:RefreshWCTeamHpBar()
  if self.teamData == nil or self.__hpBarItem == nil then
    return
  end
  local hpRate = self.teamData:GetWCTeamHP()
  local distance = Mathf.Abs(self.__preHpRate - hpRate)
  if 0.01 <= distance then
    local lerpSeconds = 0.5
    local lerpSpeed = distance / lerpSeconds
    local curRate = self.__preHpRate
    if self.__TeamHpLerpTimer then
      TimerManager:StopTimer(self.__TeamHpLerpTimer)
      self.__TeamHpLerpTimer = nil
    end
    self.__TeamHpLerpTimer = TimerManager:StartTimer(0, function()
      if Mathf.Abs(curRate - hpRate) < 0.05 or not self.__hpBarItem then
        if self.__hpBarItem then
          self.__hpBarItem:SetWCIIHPBar(false, hpRate)
        end
        TimerManager:StopTimer(self.__TeamHpLerpTimer)
        self.__TeamHpLerpTimer = nil
        return
      end
      curRate = Mathf.Lerp(curRate, hpRate, lerpSpeed * Time.unscaledDeltaTime)
      self.__hpBarItem:SetWCIIHPBar(false, curRate)
    end, self, false, true, true)
  else
    self.__hpBarItem:SetWCIIHPBar(false, hpRate)
  end
  self.__preHpRate = hpRate
end

function UINWarChessInfoInfoRoot:RefreshWCMonsterHpBar()
  if self.entityData == nil then
    return
  end
  local isMonster = self.entityData:GetEntityIsMonster()
  if isMonster then
    local hpRate = self.entityData:GetWCMonsterHP()
    if 1 <= hpRate then
      if self.__hpBarItem ~= nil then
        self.winInfo.hpBarPool:HideOne(self.__hpBarItem)
        self.__hpBarItem = nil
      end
      return
    end
    if self.__hpBarItem == nil then
      self.__hpBarItem = self.winInfo.hpBarPool:GetOne()
      self.__hpBarItem.transform:SetParent(self.ui.hpBarHolder)
      self.__hpBarItem.transform.localPosition = Vector3.one
    end
    self.__hpBarItem:SetWCIIHPBar(true, hpRate)
  end
end

function UINWarChessInfoInfoRoot:SetIsShowselfOpIconItem(bool)
  if self.__opIconItem ~= nil then
    if bool then
      self.__opIconItem:Show()
    else
      self.__opIconItem:Hide()
    end
  end
end

function UINWarChessInfoInfoRoot:SetIsShowHeadIcon(bool)
  if self.__entityHeadIconItem ~= nil then
    if bool then
      self.__entityHeadIconItem:Show()
    else
      self.__entityHeadIconItem:Hide()
    end
  end
end

function UINWarChessInfoInfoRoot:OnHide()
  if self.__opIconItem ~= nil then
    self.__opIconItem.transform:SetParent(self.winInfo.ui.infoItems.transform)
    self.winInfo.opIconPool:HideOne(self.__opIconItem)
    self.__opIconItem = nil
  end
  if self.__hpBarItem ~= nil then
    self.__hpBarItem.transform:SetParent(self.winInfo.ui.infoItems.transform)
    self.winInfo.hpBarPool:HideOne(self.__hpBarItem)
    self.__hpBarItem = nil
  end
  if self.__teamInfoItem ~= nil then
    self.__teamInfoItem.transform:SetParent(self.winInfo.ui.infoItems.transform)
    self.winInfo.teamInfoPool:HideOne(self.__teamInfoItem)
    self.__teamInfoItem = nil
  end
  if self.__deployMarkItem ~= nil then
    self.__deployMarkItem.transform:SetParent(self.winInfo.ui.infoItems.transform)
    self.winInfo.deployPool:HideOne(self.__deployMarkItem)
    self.__deployMarkItem = nil
  end
  if self.__enemyMoveItem ~= nil then
    self.__enemyMoveItem.transform:SetParent(self.winInfo.ui.infoItems.transform)
    self.winInfo.enemyMovePool:HideOne(self.__enemyMoveItem)
    self.__enemyMoveItem = nil
  end
  if self.__entityHeadIconItem ~= nil then
    self.__entityHeadIconItem.transform:SetParent(self.winInfo.ui.infoItems.transform)
    self.winInfo.entityHeadIconPool:HideOne(self.__entityHeadIconItem)
    self.__entityHeadIconItem = nil
  end
  self.entityData = nil
  self.gridData = nil
  self.teamData = nil
  self.winInfo = nil
  self.__showOrgPos = Vector3.zero
  self.__showOffset = Vector3.zero
end

function UINWarChessInfoInfoRoot:OnDelete()
  self.iconAtlas = nil
  if self.__TeamHpLerpTimer then
    TimerManager:StopTimer(self.__TeamHpLerpTimer)
    self.__TeamHpLerpTimer = nil
  end
  base.OnDelete(self)
end

return UINWarChessInfoInfoRoot
