local base = UIBaseNode
local UINSEResPage = class("UINSEResPage", UIBaseNode)
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local UINSEResPageItem = require("Game.Sector.UISector.UISectorEntrance.Pages.Res.UINSEResPageItem")

function UINSEResPage:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemPool = UIItemPool.New(UINSEResPageItem, self.ui.obj_dungeonNode)
  self.ui.obj_dungeonNode:SetActive(false)
  self.refreshAllDungeonItem = BindCallback(self, self.AddRefreshAllDungeonItemFunc)
  MsgCenter:AddListener(eMsgEventId.OnCommonDayPass, self.refreshAllDungeonItem)
  MsgCenter:AddListener(eMsgEventId.ChallengeOutOfData, self.refreshAllDungeonItem)
  MsgCenter:AddListener(eMsgEventId.OnDailyDungeonQuickBattleOver, self.refreshAllDungeonItem)
  MsgCenter:AddListener(eMsgEventId.PeroidUpdate, self.refreshAllDungeonItem)
  MsgCenter:AddListener(eMsgEventId.MonthCardRefresh, self.refreshAllDungeonItem)
  MsgCenter:AddListener(eMsgEventId.DungeonUpdate, self.refreshAllDungeonItem)
  MsgCenter:AddListener(eMsgEventId.DungeonQuickBatteEnd, self.refreshAllDungeonItem)
end

function UINSEResPage:InitSEPage(resloader)
  self.__resloader = resloader
  self.sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  self:RefreshAllDungeonItem()
end

function UINSEResPage:AddRefreshAllDungeonItemFunc()
  if self.needFresh then
    return
  end
  self.needFresh = true
  TimerManager:AddLateCommand(function()
    self.needFresh = false
    if IsNull(self.transform) then
      return
    end
    self:RefreshAllDungeonItem()
  end)
end

function UINSEResPage:RefreshAllDungeonItem()
  local dungeonCtrl = self.sectorCtrl.dungeonCtrl
  local weeklyCtrl = self.sectorCtrl.weeklyCtrl
  local dailyCtrl = self.sectorCtrl.dailyCtrl
  local needMove2EndList = {}
  local playTweenOrderList = {}
  self.itemPool:HideAll()
  for _, id in ipairs(ConfigData.sector_entrance_dungeon.id_sort_list) do
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
      local item = self.itemPool:GetOne()
      item:InitResPageItem(dunCfg, playModeCtrl, self.__resloader)
      item.gameObject.name = dunCfg.system_id
      local isUnlock, unlockStr = playModeCtrl:IsSectorPlayModeUnlock(dunCfg.system_id)
      if not isUnlock then
        table.insert(needMove2EndList, item)
      else
        table.insert(playTweenOrderList, item)
      end
    end
  end
  for _, item in ipairs(needMove2EndList) do
    item.transform:SetAsLastSibling()
    table.insert(playTweenOrderList, item)
  end
  self.__playTweenOrderList = playTweenOrderList
  self:__PlayEnterTween(playTweenOrderList)
end

function UINSEResPage:__PlayEnterTween(playTweenOrderList)
  if self.sequence ~= nil then
    self.sequence:Kill()
    self.sequence = nil
  end
  local sequence = cs_DoTween.Sequence()
  for index, item in ipairs(playTweenOrderList) do
    item.transform.localPosition = Vector3.zero
    item.ui.cg_dungeonNode.alpha = 1
    if index == 1 then
      sequence:Append(item.transform:DOLocalMoveY(-30, 0.5):From():SetEase(cs_Ease.OutQuart))
      sequence:Join(item.ui.cg_dungeonNode:DOFade(0, 0.4):From():SetEase(cs_Ease.OutQuart))
    else
      sequence:Join(item.transform:DOLocalMoveY(-30, 0.5):SetDelay((index - 1) * 0.02):From():SetEase(cs_Ease.OutQuart))
      sequence:Join(item.ui.cg_dungeonNode:DOFade(0, 0.4):SetDelay((index - 1) * 0.02):From():SetEase(cs_Ease.OutQuart))
    end
  end
  sequence:AppendCallback(function()
    self.sequence = nil
  end)
  sequence:SetAutoKill(true)
  sequence.target = self.transform
  self.sequence = sequence
end

function UINSEResPage:OnShow()
  if self.__playTweenOrderList ~= nil then
    self:__PlayEnterTween(self.__playTweenOrderList)
  end
end

function UINSEResPage:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnCommonDayPass, self.refreshAllDungeonItem)
  MsgCenter:RemoveListener(eMsgEventId.ChallengeOutOfData, self.refreshAllDungeonItem)
  MsgCenter:RemoveListener(eMsgEventId.PeroidUpdate, self.refreshAllDungeonItem)
  MsgCenter:RemoveListener(eMsgEventId.OnDailyDungeonQuickBattleOver, self.refreshAllDungeonItem)
  MsgCenter:RemoveListener(eMsgEventId.MonthCardRefresh, self.refreshAllDungeonItem)
  MsgCenter:RemoveListener(eMsgEventId.DungeonUpdate, self.refreshAllDungeonItem)
  MsgCenter:RemoveListener(eMsgEventId.DungeonQuickBatteEnd, self.refreshAllDungeonItem)
  if self.sequence ~= nil then
    self.sequence:Kill()
    self.sequence = nil
  end
  for _, item in pairs(self.itemPool.listItem) do
    item:Delete()
  end
  base.OnDelete(self)
end

return UINSEResPage
