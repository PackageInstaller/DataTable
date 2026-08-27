local base = UIBaseNode
local UINSEChallengePage = class("UINSEChallengePage", UIBaseNode)
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local UINSEChallengePageItem = require("Game.Sector.UISector.UISectorEntrance.Pages.Challenge.UINSEChallengePageItem")

function UINSEChallengePage:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemPool = UIItemPool.New(UINSEChallengePageItem, self.ui.obj_dungeonNode)
  self.ui.obj_dungeonNode:SetActive(false)
  if CS.ClientConsts.IsAudit then
    self.ui.obj_empty.gameObject:SetActive(false)
  end
  self.refreshAllDungeonItem = BindCallback(self, self.AddRefreshAllDungeonItemFunc)
  MsgCenter:AddListener(eMsgEventId.OnCommonDayPass, self.refreshAllDungeonItem)
end

function UINSEChallengePage:InitSEPage(resloader)
  self.__resloader = resloader
  self.sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  self:RefreshAllChallengeItem()
end

function UINSEChallengePage:AddRefreshAllDungeonItemFunc()
  if self.needFresh then
    return
  end
  self.needFresh = true
  TimerManager:AddLateCommand(function()
    self.needFresh = false
    if IsNull(self.transform) then
      return
    end
    self:RefreshAllChallengeItem()
  end)
end

function UINSEChallengePage:RefreshAllChallengeItem()
  local blackHoleCtrl = self.sectorCtrl.blackHoleCtrl
  local sixHeroTowerCtrl = self.sectorCtrl.sixHeroTowerCtrl
  self.itemPool:HideAll()
  local playTweenOrderList = {}
  for _, id in ipairs(ConfigData.sector_entrance_challenge.id_sort_list) do
    local dunCfg = ConfigData.sector_entrance_challenge[id]
    local playModeCtrl
    local entranceType = dunCfg.system_id
    if blackHoleCtrl.IsEntrancetypeBlackHole(entranceType) then
      playModeCtrl = blackHoleCtrl
    elseif sixHeroTowerCtrl.IsEntrancetypeSixHeroTower(entranceType) then
      playModeCtrl = sixHeroTowerCtrl
    end
    if playModeCtrl ~= nil and playModeCtrl:IsSectorPlayModeExist() then
      local item = self.itemPool:GetOne()
      item:InitResPageItem(dunCfg, playModeCtrl, self.__resloader)
      item.gameObject.name = dunCfg.system_id
      table.insert(playTweenOrderList, item)
    end
  end
  self.ui.obj_empty.transform:SetAsLastSibling()
  table.insert(playTweenOrderList, {
    transform = self.ui.obj_empty.transform,
    ui = {
      cg_dungeonNode = self.ui.cg_empty
    }
  })
  self:__PlayEnterTween(playTweenOrderList)
end

function UINSEChallengePage:__PlayEnterTween(playTweenOrderList)
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
  self.ui.obj_empty.transform.localPosition = Vector3.zero
  self.ui.cg_empty.alpha = 1
  sequence:Join(self.ui.obj_empty.transform:DOLocalMoveY(-30, 0.5):SetDelay((#playTweenOrderList - 1) * 0.02):From():SetEase(cs_Ease.OutQuart))
  sequence:Join(self.ui.cg_empty:DOFade(0, 0.4):SetDelay((#playTweenOrderList - 1) * 0.02):From():SetEase(cs_Ease.OutQuart))
  sequence:AppendCallback(function()
    self.sequence = nil
  end)
  sequence:SetAutoKill(true)
  sequence.target = self.transform
  self.sequence = sequence
end

function UINSEChallengePage:OnDelete()
  if self.sequence ~= nil then
    self.sequence:Kill()
    self.sequence = nil
  end
  self.itemPool:DeleteAll()
  base.OnDelete(self)
end

return UINSEChallengePage
