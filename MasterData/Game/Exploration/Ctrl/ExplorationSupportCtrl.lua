local base = ExplorationCtrlBase
local ExplorationSupportCtrl = class("ExplorationSupportCtrl", base)
local DynHero = require("Game.Exploration.Data.DynHero")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function ExplorationSupportCtrl:ctor(epCtrl)
  self.eventNetWork = NetworkManager:GetNetwork(NetworkTypeID.EventRoom)
end

function ExplorationSupportCtrl:EnterSupportRoomEx(careerList)
  local dynPlayer = self.epCtrl.dynPlayer
  local careerDic = {}
  for k, careerId in ipairs(careerList) do
    careerDic[careerId] = true
  end
  local supportHeroList = {}
  local fightPwerDic = {}
  for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
    if careerDic[heroData.career] and not dynPlayer:ExistDynHeroByDataId(heroId) then
      fightPwerDic[heroData] = heroData:GetFightingPower()
      table.insert(supportHeroList, heroData)
    end
  end
  table.sort(supportHeroList, function(a, b)
    if fightPwerDic[a] ~= fightPwerDic[b] then
      return fightPwerDic[a] > fightPwerDic[b]
    end
    return a.dataId < b.dataId
  end)
  UIManager:ShowWindowAsync(UIWindowTypeID.EpSupportRoom, function(window)
    if window == nil then
      return
    end
    window:InitEpSurpportRoomEx(dynPlayer, supportHeroList, self)
    self.epCtrl.autoCtrl:OnEnterEpEventSupportEx(true)
  end)
end

function ExplorationSupportCtrl:EnterSupportRoom(heroStcList)
  local supportHeroList = {}
  local dynPlayer = self.epCtrl.dynPlayer
  for k, stc in ipairs(heroStcList) do
    local dynHeroData = dynPlayer:CreateSupportDynHero(stc)
    if dynHeroData ~= nil then
      table.insert(supportHeroList, dynHeroData)
    end
  end
  dynPlayer:ExecuteAllChip2NewHeroList(supportHeroList)
  UIManager:ShowWindowAsync(UIWindowTypeID.EpSupportRoom, function(window)
    if window == nil then
      return
    end
    window:InitEpSurpportRoom(dynPlayer, supportHeroList, self)
    self.epCtrl.autoCtrl:OnEnterEpEventSupportEx(true)
  end)
end

function ExplorationSupportCtrl:ReqChangeSupportHero(quitHeroUidList, enterIdList)
  local roomData = self.epCtrl:GetCurrentRoomData()
  self._OnReqChangeHeroFunc = self._OnReqChangeHeroFunc or BindCallback(self, self._OnReqChangeSupportHero)
  self.eventNetWork:CS_EXPLORATION_EVENT_Assist(roomData.position, quitHeroUidList, enterIdList, self._OnReqChangeHeroFunc)
end

function ExplorationSupportCtrl:ReqChangeSupportExHero(quitHeroUidDic, enterIdDic)
  local roomData = self.epCtrl:GetCurrentRoomData()
  self._OnReqChangeHeroFunc = self._OnReqChangeHeroFunc or BindCallback(self, self._OnReqChangeSupportHero)
  self.eventNetWork:CS_EXPLORATION_EVENT_AssistEX(roomData.position, quitHeroUidDic, enterIdDic, self._OnReqChangeHeroFunc)
end

function ExplorationSupportCtrl:_OnReqChangeSupportHero(objList)
  if objList.Count == 0 then
    error("objList.Count == 0")
    return
  end
  UIManager:DeleteWindow(UIWindowTypeID.EpSupportRoom)
  local msg = objList[0]
  if msg.roleSync == nil then
    return
  end
  self:ChangeEpHero(msg.roleSync)
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.SupportRoom)
end

function ChangeDynPlayerHero(dynPlayer, enter, quit, battlRoleType)
  local newHeroList = {}
  local heroUidDic = {}
  local mirrorHeroDic = {}
  local addHeroList = {}
  local removeHeroList = {}
  local heroNum = 0
  for k, dynHero in ipairs(dynPlayer.heroList) do
    local mirrorHero = dynPlayer.mirrorHeroList[k]
    if quit[dynHero.uid] ~= nil then
      table.insert(removeHeroList, dynHero)
    else
      table.insert(newHeroList, dynHero)
      mirrorHeroDic[mirrorHero.uid] = mirrorHero
      if not dynHero:IsBench() then
        heroNum = heroNum + 1
      end
    end
  end
  local maxStateNum = dynPlayer:GetEnterFiledNum()
  for k, role in pairs(enter) do
    local dynHero = dynPlayer:CreateDynHero(role.data.stc, role.data.dyc, role.roleType)
    dynHero:SetDynHeroFmtIdx(role.data.dyc.formationIdx)
    dynHero.onBench = heroNum >= maxStateNum
    if not dynHero:IsBench() then
      heroNum = heroNum + 1
    end
    table.insert(newHeroList, dynHero)
    table.insert(addHeroList, dynHero)
    local stc = role.data.stc
    local mirrorHero = DynHero.New(dynHero.heroData, dynHero.uid, battlRoleType)
    mirrorHero:UpdateBaseHeroData(stc.attr, stc.skillGroup, stc.athSkillGroup, stc.additionSkillGroup, stc.rawAttr)
    mirrorHero:SetDynHeroTalentLevel(stc.talent)
    mirrorHero:SetExtraFixedPower(stc.talentEfficiency)
    mirrorHeroDic[mirrorHero.uid] = mirrorHero
  end
  table.sort(newHeroList, function(a, b)
    return a:GetDynHeroFmtIdx() < b:GetDynHeroFmtIdx()
  end)
  local newMirrorHeroList = {}
  for k, dynHero in ipairs(newHeroList) do
    newMirrorHeroList[k] = mirrorHeroDic[dynHero.uid]
    heroUidDic[dynHero.uid] = dynHero
  end
  dynPlayer:SetPlayerNewHeroList(newHeroList, newMirrorHeroList, heroUidDic, mirrorHeroDic, enter)
end

function ExplorationSupportCtrl:ChangeEpHero(roleSync)
  local dynPlayer = self.epCtrl.dynPlayer
  local addHeroList, newHeroList, removeHeroList = dynPlayer:ChangeDynPlayerHeroList(roleSync.enter, roleSync.quit, roleSync.change)
  ExplorationManager:TryUpdataEpMvpHeros(newHeroList, removeHeroList)
  local epWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if epWindow ~= nil then
    epWindow:ReInitDungeonHeroList(dynPlayer)
  end
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
  self.epCtrl.sceneCtrl:RefreshEpSceneHeroPos(newHeroList)
  self.epCtrl.sceneCtrl:ChangeEpHeroModel(removeHeroList, addHeroList, function()
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end, true)
end

function ExplorationSupportCtrl:OnDelete()
end

return ExplorationSupportCtrl
