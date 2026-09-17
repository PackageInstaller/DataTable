local this = class("pagePetDuelRoleInfo", G_UIPageBase)
local kiBoDuelTpl = L_GameTpl:getKiboDuelTpl()
local _areaTypeTpl = L_GameTpl:getKiboDuelAreaTypeTpl()
local _areaLeveTpl = L_GameTpl:getKiboDuelAreaLevelTpl()
local CustomEventSelfInfoTip = "selfInfoTip"
local CustomEventOtherInfoTip = "otherInfoTip"

function this.bind()
  return {
    txtSelfName = "",
    txtSelfRank = "",
    imgSelfRank = "",
    imgPvpSelfRank = "",
    txtOtherName = "",
    txtOtherRank = "",
    imgOtherRank = "",
    imgPvpOtherRank = "",
    selfActive = false,
    otherActive = false,
    pvpSelfActive = false,
    pveSelfActive = false,
    pvpOtherActive = false,
    pveOtherActive = false
  }
end

function this.methods()
  return {}
end

function this:preOpen(options)
  self.duelId = options.duelId
  self.playerName = options.playerName
  self.enemyName = options.enemyName
  self.isPve = C_KiboArenaSystemMgr.isPVE
  self._onEvent_TimeLineCustomEventHandler = handler(self, self.onEvent_TimeLineCustomEventHandler)
  C_StoryEvent.instance:RegisterEvent(C_EStoryEvent.TimelineClipCustomEvent, self._onEvent_TimeLineCustomEventHandler)
end

function this:close()
  if self._onEvent_TimeLineCustomEventHandler ~= nil then
    C_StoryEvent.instance:UnregisterEvent(C_EStoryEvent.TimelineClipCustomEvent, self._onEvent_TimeLineCustomEventHandler)
    self._onEvent_TimeLineCustomEventHandler = nil
  end
end

function this:onEvent_TimeLineCustomEventHandler(evtId, varList)
  local eventName = varList:GetString(0)
  if eventName ~= CustomEventSelfInfoTip and eventName ~= CustomEventOtherInfoTip then
    return
  end
  local isStart = varList:GetBool(2)
  if not isStart then
    self.bind.selfActive = false
    self.bind.otherActive = false
    return
  end
  if eventName == CustomEventSelfInfoTip then
    self:ShowSelfRankInfo()
  else
    self:ShowOtherRankInfo()
  end
end

function this:ShowSelfRankInfo()
  local option = {
    isSelf = true,
    name = self.playerName
  }
  if self.isPve then
    local tpl = kiBoDuelTpl:getTplById(self.duelId)
    local areaType = kiBoDuelTpl:getAreaType(tpl)
    local curRank = L_PetDuelStore:getAreaLevel(areaType)
    local areaLevelTpl = _areaLeveTpl:getTpl(areaType, curRank)
    local areaTypeTpl = _areaTypeTpl:getTplById(areaType)
    option.rank = _areaLeveTpl:getName(areaLevelTpl)
    option.imgRank = _areaTypeTpl:getUIIcon(areaTypeTpl)
  else
    local curRank = C_KiboArenaSystemMgr:GetPlayerRank()
    local configTable = CS.Azur.Gameplay.Table.TDKiboDuelCompetitionRankTable.GetData(curRank)
    option.rank = configTable.name.value
    option.imgRank = configTable.icon[0]
  end
  self:refreshInfo(option)
end

function this:ShowOtherRankInfo()
  local option = {
    isSelf = false,
    name = "",
    rank = "",
    imgRank = ""
  }
  if self.isPve then
    local tpl = kiBoDuelTpl:getTplById(self.duelId)
    option.name = self.enemyName
    option.rank = kiBoDuelTpl:getAreaRankLevel(tpl)
    option.imgRank = kiBoDuelTpl:getAreaIcon(tpl)
  else
    local curRank = C_KiboArenaSystemMgr:GetEnemyRank()
    local configTable = CS.Azur.Gameplay.Table.TDKiboDuelCompetitionRankTable.GetData(curRank)
    option.name = C_KiboArenaSystemMgr:GetEnemyName()
    option.rank = configTable.name.value
    option.imgRank = configTable.icon[0]
  end
  self:refreshInfo(option)
end

function this:refreshInfo(options)
  self.bind.selfActive = options.isSelf == true
  self.bind.otherActive = options.isSelf ~= true
  self.bind.pvpSelfActive = not self.isPve
  self.bind.pveSelfActive = self.isPve
  self.bind.pvpOtherActive = not self.isPve
  self.bind.pveOtherActive = self.isPve
  if options.isSelf then
    self.bind.txtSelfName = options.name
    self.bind.txtSelfRank = options.rank
    self.bind.imgSelfRank = options.imgRank
    self.bind.imgPvpSelfRank = options.imgRank
  else
    self.bind.txtOtherName = options.name
    self.bind.txtOtherRank = options.rank
    self.bind.imgOtherRank = options.imgRank
    self.bind.imgPvpOtherRank = options.imgRank
  end
end

return this
