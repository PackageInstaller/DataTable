local UIEpSelectDebuff = class("UIEpSelectDebuff", UIBaseWindow)
local base = UIBaseWindow
local UINPeriodicDebuff = require("Game.PeriodicChallenge.UI.UINPeriodicDebuff")
local UINDungeonBuffItem = require("Game.CommonUI.DungeonState.UINDungeonBuffItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function UIEpSelectDebuff:OnInit()
  self.resloader = CS.ResLoader.Create()
  self.explorationNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.__OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.__OnClickCancle)
  self.selectBuffItemPool = UIItemPool.New(UINPeriodicDebuff, self.ui.obj_debuffSelectItem)
  self.ui.obj_debuffSelectItem:SetActive(false)
  self.buffItemPool = UIItemPool.New(UINDungeonBuffItem, self.ui.obj_BuffItem)
  self.ui.obj_BuffItem:SetActive(false)
  self.__OnItemValueChange = BindCallback(self, self.OnItemSelect)
  self.__onPressBuffItem = BindCallback(self, self.__OnPressBuffItem)
  self.__onPressUpBuffItem = BindCallback(self, self.__OnPressUpBuffItem)
  self.selectedBuffIdDic = nil
  self.effectBuffList = nil
end

function UIEpSelectDebuff:InitEpSelectDebuff(dynPlayer, closeCallback)
  self.dynPlayer = dynPlayer
  self.buffIdDic = dynPlayer:GetEpDebuffSelectDic()
  self.closeCallback = closeCallback
  local wcData = PlayerDataCenter.allWeeklyChallengeData:GetWeeklyChallengeDataByDungeonId(ExplorationManager:GetEpDungeonId())
  self._fmtBuffSelect = wcData:GetFmtBuffSelectData()
  self:RefreshMonsterLevel()
  self:RefreshCouldSelectBuff()
  self:RefreshCurrBuffList()
  self:RefreshEnemyBattlePow()
end

function UIEpSelectDebuff:__OnClickConfirm()
  if self.selectedBuffIdDic == nil or table.count(self.selectedBuffIdDic) <= 0 then
    self:__OnClickCancle()
    return
  end
  self.explorationNetworkCtrl:CS_WEEKLYCHALLENGE_SelectBuff(self.selectedBuffIdDic, function()
    self:__OnClickCancle()
  end)
end

function UIEpSelectDebuff:__OnClickCancle()
  self.explorationNetworkCtrl:CS_WEEKLYCHALLENGE_SelectBuffExit(function()
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.SelectDebuff)
    self:Delete()
    if self.closeCallback ~= nil then
      self.closeCallback()
    end
  end)
end

function UIEpSelectDebuff:OnItemSelect(buffId, flag)
  if flag and not self.selectedBuffIdDic[buffId] then
    self.selectedBuffIdDic[buffId] = true
  elseif not flag and self.selectedBuffIdDic[buffId] then
    self.selectedBuffIdDic[buffId] = nil
  end
  for i, item in ipairs(self.selectBuffItemPool.listItem) do
    item:ChangeState(self.selectedBuffIdDic[item.buffId], false)
  end
  self:RefreshBuffListWhenSelect(buffId, flag)
  self:RefreshEnemyBattlePow()
end

function UIEpSelectDebuff:RefreshCouldSelectBuff()
  self.selectedBuffIdDic = {}
  local list = {}
  for buffId, permillage in pairs(self.buffIdDic) do
    table.insert(list, {buffId = buffId, permillage = permillage})
  end
  table.sort(list, function(a, b)
    if a.permillage ~= b.permillage then
      return a.permillage < b.permillage
    end
    return a.buffId < b.buffId
  end)
  self.selectBuffItemPool:HideAll()
  for i, buffData in ipairs(list) do
    local item = self.selectBuffItemPool:GetOne(true)
    item.gameObject:SetActive(true)
    item:InitDebuffItem(buffData.buffId, buffData.permillage, self.__OnItemValueChange, false, self.resloader)
  end
end

function UIEpSelectDebuff:RefreshCurrBuffList()
  self.effectBuffList = {}
  self.buffItemPool:HideAll()
  local epBuffList = self.dynPlayer:GetEpBuffList()
  for index, dynBuff in ipairs(epBuffList) do
    if self._fmtBuffSelect:IsFmtEffectBuff(dynBuff.dataId) then
      local item = self.buffItemPool:GetOne()
      item:InitBuffByCfg(dynBuff, dynBuff:GetBuffCfg(), self.__onPressBuffItem, self.__onPressUpBuffItem)
      table.insert(self.effectBuffList, dynBuff.dataId)
    end
  end
  self.ui.tex_BuffCount:SetIndex(0, tostring(#self.effectBuffList))
end

function UIEpSelectDebuff:RefreshBuffListWhenSelect(buffId, isSelect)
  if self.preSelectItemDic == nil then
    self.preSelectItemDic = {}
  end
  if isSelect then
    if self.preSelectItemDic ~= nil and self.preSelectItemDic[buffId] ~= nil then
      return
    end
    local buffCfg = ConfigData.exploration_buff[buffId]
    local item = self.buffItemPool:GetOne()
    item:InitBuffOnlyWithCfg(buffCfg, self.__onPressBuffItem, self.__onPressUpBuffItem)
    self.preSelectItemDic[buffId] = item
  else
    if self.preSelectItemDic == nil or self.preSelectItemDic[buffId] == nil then
      return
    end
    local item = self.preSelectItemDic[buffId]
    self.buffItemPool:HideOne(item)
    self.preSelectItemDic[buffId] = nil
  end
  self.ui.tex_BuffCount:SetIndex(0, tostring(#self.effectBuffList + table.count(self.preSelectItemDic)))
end

function UIEpSelectDebuff:__OnPressBuffItem(buffItem, buffCfg)
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(LanguageUtil.GetLocaleText(buffCfg.name), LanguageUtil.GetLocaleText(buffCfg.describe))
  win:FloatTo(buffItem.transform, HAType.autoCenter, VAType.down)
end

function UIEpSelectDebuff:__OnPressUpBuffItem()
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

function UIEpSelectDebuff:RefreshEnemyBattlePow()
  local effectAll = 0
  if self._cacheEffect == nil then
    for _, buffId in ipairs(self.effectBuffList) do
      effectAll = effectAll + (self._fmtBuffSelect:GetFmtBuffEffect(buffId) or 0)
    end
    self._cacheEffect = effectAll
  else
    effectAll = effectAll + self._cacheEffect
  end
  for buffId, _ in pairs(self.selectedBuffIdDic) do
    effectAll = effectAll + (self._fmtBuffSelect:GetFmtBuffEffect(buffId) or 0)
  end
  self.ui.tex_Gain.text = tostring(math.floor(effectAll / 10)) .. "%"
  local logicLayer = math.floor(effectAll / 100)
  local showLayer = math.clamp(logicLayer, 0, 100)
  self.ui.tex_Layer:SetIndex(0, tostring(showLayer))
  self.ui.tex_EnemyPower.text = tostring(self._fmtBuffSelect:GetBuffEmenyPower(logicLayer, self.realCurLevel))
  local warningTipValue = self._fmtBuffSelect:GetBuffScoreWarningValue(self.realCurLevel)
  self.ui.obj_Warning:SetActive(effectAll >= warningTipValue)
end

function UIEpSelectDebuff:RefreshMonsterLevel()
  local monsterLvData = self.dynPlayer:GetMonsterLevelData()
  local realCurLevel = monsterLvData.lv
  self.ui.tex_CurLevel.text = tostring(realCurLevel - 1)
  local monsterLevelCfgs = ExplorationManager:GetMonsterLevelCfgs()
  if monsterLevelCfgs == nil then
    error("monsterLevelCfgs is nil")
    return
  end
  local maxLevel = monsterLevelCfgs.maxLevel
  if realCurLevel < maxLevel then
    self.ui.tex_NextLevel:SetIndex(0, tostring(realCurLevel))
  else
    self.ui.tex_NextLevel:SetIndex(1)
  end
  self.realCurLevel = realCurLevel
end

function UIEpSelectDebuff:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UIEpSelectDebuff
