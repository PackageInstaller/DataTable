local base = UIBaseNode
local UINWarChessMain_DNTeamItem = class("UINWarChessMain_DNTeamItem", UIBaseNode)
local UINWarChessMain_DNTeamItemHeroItem = require("Game.WarChess.UI.Main.UINWarChessMain_DNTeamItemHeroItem")

function UINWarChessMain_DNTeamItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_teamItem, self, self.OnClickTeam)
  self.heroHeadPool = UIItemPool.New(UINWarChessMain_DNTeamItemHeroItem, self.ui.heroHeadItem)
  self.ui.heroHeadItem:SetActive(false)
  self.__isHaveHero = false
  self.__couldDeploy = true
  local eventTrigger = CS.EventTriggerListener.Get(self.gameObject)
  eventTrigger:onBeginDrag("+", BindCallback(self, self.__OnBeginDrag))
  eventTrigger:onDrag("+", BindCallback(self, self.__OnDrag))
  eventTrigger:onEndDrag("+", BindCallback(self, self.__OnEndDrag))
end

function UINWarChessMain_DNTeamItem:InitWCDeployTeamItem(deployState, index, onClickCurTeam, resloader)
  self.deployState = deployState
  self.index = index
  self.gameObject.name = tostring(index)
  self.onClickCurTeam = onClickCurTeam
  self.resloader = resloader
  self:RefreshTeamItem()
end

function UINWarChessMain_DNTeamItem:SetWCDeployTeamDragChange(isOpen, onDragChangeFunc)
  self._isOpenDragChange = isOpen
  self._onDragChangeFunc = onDragChangeFunc
end

function UINWarChessMain_DNTeamItem:RefreshTeamItem()
  local firstHeroData, teamPower, heroDataList, isDeployed, teamName
  local teamData = self.deployState:GetTeamDataByIndex(self.index)
  if teamData ~= nil then
    local isDead = teamData:GetWCTeamIsDead()
    local firstHeroId = teamData:GetFirstHeroId()
    firstHeroData = self.deployState.wcCtrl.teamCtrl:GetHeroDynDataById(firstHeroId)
    teamPower = teamData:GetWCTeamPower()
    heroDataList = {}
    for index, dynHeroData in ipairs(teamData:GetWCTeamHeroList()) do
      if not dynHeroData:IsBench() then
        table.insert(heroDataList, dynHeroData.heroData)
      end
    end
    isDeployed = not isDead
    teamName = teamData:GetWCTeamName()
    self.ui.obj_img_Death:SetActive(isDead)
    self.ui.obj_notDeploy:SetActive(isDeployed)
    self.__couldDeploy = isDead
  else
    local dTeamData = self.deployState:GetDTeamDataByIndex(self.index)
    firstHeroData = dTeamData:GetFirstHeroData()
    teamPower = dTeamData:GetDTeamTeamPower()
    heroDataList = dTeamData:GetTeamMemberHeroDataList()
    isDeployed = dTeamData:GetIsDeploied()
    teamName = dTeamData:GetDTeamName()
    self.ui.obj_img_Death:SetActive(false)
    self.ui.obj_notDeploy:SetActive(false)
    self.__couldDeploy = true
  end
  self.__isHaveHero = firstHeroData ~= nil
  self.ui.realTeam:SetActive(self.__isHaveHero)
  self.ui.emptyTeam:SetActive(not self.__isHaveHero)
  if self.__isHaveHero then
    self.ui.img_HeroPic.texture = self.resloader:LoadABAsset(PathConsts:GetCharacterPicPath(firstHeroData:GetResPicName()))
    self.ui.tex_TeamPow.text = tostring(teamPower)
    self.ui.tex_TeamName.text = teamName
    self.heroHeadPool:HideAll()
    for index, heroData in ipairs(heroDataList) do
      local heroHeadItem = self.heroHeadPool:GetOne()
      heroHeadItem:InitWCHeroHeadItem(heroData, index == 1)
    end
    self:RefreshTeamIsDeployed(isDeployed)
  end
end

function UINWarChessMain_DNTeamItem:RefreshTeamIsDeployed(isDeployed)
  self.ui.obj_IsOnGroudTag:SetActive(isDeployed)
end

function UINWarChessMain_DNTeamItem:OnClickTeam()
  if self._isDragCheckFinish then
    return
  end
  if not self.__couldDeploy then
    return
  end
  if not self.deployState:IsWCDeployGuideComplete() then
    return
  end
  if self.onClickCurTeam ~= nil then
    self.onClickCurTeam(self)
  end
end

function UINWarChessMain_DNTeamItem:__OnBeginDrag(go, eventData)
  if not self.__isHaveHero then
    return
  end
  if not self.__couldDeploy then
    return
  end
  self._startDragPos = eventData.position
  self._checkDragCount = 3
  self._isDragCheckFinish = false
end

function UINWarChessMain_DNTeamItem:__OnDrag(go, eventData)
  if not self.__isHaveHero then
    self:__ChangeDrag(eventData)
    return
  end
  if not self.__couldDeploy then
    self:__ChangeDrag(eventData)
    return
  end
  if not self._isDragCheckFinish then
    self._checkDragCount = self._checkDragCount - 1
    if self._checkDragCount > 0 then
      return
    end
    if self._isOpenDragChange then
      local xDiff = math.abs(eventData.position.x - self._startDragPos.x)
      local yDiff = math.abs(eventData.position.y - self._startDragPos.y)
      if xDiff > yDiff * 3 then
        self:__ChangeDrag(eventData)
        return
      end
    end
    self.deployState:BeginDrag2Deploy(self.index)
    self._isDragCheckFinish = true
  end
  self.deployState:OnDrag2Deploy(self.index)
end

function UINWarChessMain_DNTeamItem:__OnEndDrag(go, eventData)
  if not self.__isHaveHero then
    return
  end
  if not self.__couldDeploy then
    return
  end
  self.deployState:FinishDrag2Deploy(self.index)
  self._startDragPos = nil
  self._checkDragCount = nil
  self._isDragCheckFinish = nil
end

function UINWarChessMain_DNTeamItem:__ChangeDrag(eventData)
  if self._onDragChangeFunc ~= nil then
    self._onDragChangeFunc(eventData)
  end
  self._startDragPos = nil
  self._checkDragCount = nil
  self._isDragCheckFinish = nil
end

function UINWarChessMain_DNTeamItem:OnDelete()
  base.OnDelete(self)
end

return UINWarChessMain_DNTeamItem
