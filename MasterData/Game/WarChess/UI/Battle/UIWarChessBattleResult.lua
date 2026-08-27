local UIWarChessBattleResult = class("UIWarChessBattleResult", UIBaseWindow)
local base = UIBaseWindow
local UIRewardItem = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINWarChessResultCoinItem = require("Game.WarChess.UI.Battle.UINWarChessResultCoinItem")
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local cs_BattleStatistics = CS.BattleStatistics.Instance
local cs_GameObject = CS.UnityEngine.GameObject
local cs_DOTween = CS.DG.Tweening.DOTween

function UIWarChessBattleResult:OnInit()
  self.resloader = CS.ResLoader.Create()
  self.rewardItemPool = UIItemPool.New(UIRewardItem, self.ui.obj_rewardItem)
  self.ui.obj_rewardItem:SetActive(false)
  self.ui.obj_CoinNode:SetActive(false)
  self._coinItemPool = UIItemPool.New(UINWarChessResultCoinItem, self.ui.obj_CoinNode)
  if not BattleUtil.IsInTDBattle() then
    UIUtil.AddButtonListener(self.ui.btn_skada, self, self.__OnBtnSkadaClick)
  else
    self.ui.btn_skada.gameObject:SetActive(false)
  end
  UIUtil.AddButtonListener(self.ui.btn_continue, self, self.__OnBtnContinueClick)
  self.__playAnim = BindCallback(self, self.__StartAnimation)
  MsgCenter:AddListener(eMsgEventId.OnShowBattleResultComplete, self.__playAnim)
  self.__OnScreenSizeChanged = BindCallback(self, self.__ToFackCameraCanvas)
  MsgCenter:AddListener(eMsgEventId.OnScreenSizeChanged, self.__OnScreenSizeChanged)
  self:__ToFackCameraCanvas()
end

function UIWarChessBattleResult:__ToFackCameraCanvas()
  local fakeCameraBattle = cs_GameObject.Find("FakeCameraBattle"):FindComponent(eUnityComponentID.Camera)
  local epMapCamera = UIManager:GetMainCamera():FindComponent("EpMapCamera", eUnityComponentID.Camera)
  fakeCameraBattle.enabled = true
  fakeCameraBattle.enabled = false
  self:AlignToFakeCamera(fakeCameraBattle, epMapCamera)
end

function UIWarChessBattleResult:SetWCBattleResultBattleData(playerRoleList, enemyRoleList, mvpGrade)
  self.__playerRoleList = playerRoleList
  self.__enemyRoleList = enemyRoleList
  self:__InitMvpHeroPic(mvpGrade)
end

function UIWarChessBattleResult:SetWCBattleResultRewardData(serverRewardDic)
  self:__InitWCBattleReward(serverRewardDic)
end

function UIWarChessBattleResult:SetContinueCallback(callback)
  self.continueCallback = callback
end

function UIWarChessBattleResult:SetWCBattleResultTitle(title)
  self.ui.tex_levelName.text = title
end

function UIWarChessBattleResult:__InitWCBattleReward(serverRewardDic)
  local isShowAth = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm)
  local rewardDic = {}
  self.rewardDic = rewardDic
  for itemId, itemNum in pairs(serverRewardDic) do
    local itemCfg = ConfigData.item[itemId]
    if not itemCfg.explorationHold then
      local hasAth = ConfigData:IsRewardNotShowATH(itemCfg)
      if not hasAth or isShowAth then
        if rewardDic[itemId] == nil then
          rewardDic[itemId] = {count = itemNum, itemCfg = itemCfg}
        else
          rewardDic[itemId].count = rewardDic[itemId].count + itemNum
        end
      end
    end
  end
  local theRewardList = {}
  local coinRewardList = {}
  for itemId, v in pairs(rewardDic) do
    if ConstWCShowCoin[itemId] ~= nil then
      table.insert(coinRewardList, v)
    else
      table.insert(theRewardList, v)
    end
  end
  self._coinItemPool:HideAll()
  WarChessHelper.WCCoinSort(coinRewardList)
  for k, v in ipairs(coinRewardList) do
    local rewardItem = self._coinItemPool:GetOne()
    rewardItem:InitResultCoinItem(v.itemCfg, v.count)
  end
  ExplorationManager:RewardSort(theRewardList)
  for k, v in ipairs(theRewardList) do
    local rewardItem = self.rewardItemPool:GetOne()
    rewardItem:InitItemWithCount(v.itemCfg, v.count, function()
      UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
        if win ~= nil then
          win:InitListDetail(theRewardList, k)
        end
      end)
    end)
  end
  if self.rewardSequence ~= nil then
    self.rewardSequence:Kill()
    self.rewardSequence = nil
  end
  local hasReward = 0 < #theRewardList
  self.ui.obj_rewardNode:SetActive(hasReward)
  if hasReward then
    local rewardSequence = cs_DOTween.Sequence()
    for index, item in ipairs(self.rewardItemPool.listItem) do
      item:SetFade(0)
      rewardSequence:AppendCallback(function()
        if ConfigData.game_config.itemWithGreatFxDic[item.itemCfg.id] then
          item:LoadGetGreatRewardFx(self.resloader, 5)
        else
          item:LoadGetRewardFx(self.resloader, 5)
        end
      end)
      rewardSequence:Append(item:GetFade():DOFade(1, 0.15):SetLink(item.gameObject))
    end
    rewardSequence:SetDelay(0.15)
    rewardSequence:Pause()
    self.rewardSequence = rewardSequence
  end
end

function UIWarChessBattleResult:__InitMvpHeroPic(mvpGrade)
  local dynHero = mvpGrade.role.character
  self.ui.tex_heroMvp:SetIndex(mvpGrade.MvpType)
  self.ui.img_heroMvp.color = self.ui.color_MVP[mvpGrade.MvpType + 1]
  self.ui.tex_mvpName.text = dynHero:GetName()
  self.ui.tex_mvpDesc:SetIndex(mvpGrade.MvpType)
end

function UIWarChessBattleResult:__OnBtnSkadaClick()
  UIManager:ShowWindowAsync(UIWindowTypeID.ResultSkada, function(window)
    if window == nil then
      return
    end
    window:InitBattleSkada(cs_BattleStatistics, self.__playerRoleList, self.__enemyRoleList)
  end)
end

function UIWarChessBattleResult:__OnBtnContinueClick()
  self:ExitBattleResult()
end

function UIWarChessBattleResult:ExitBattleResult()
  if self.continueCallback ~= nil then
    self.continueCallback()
  end
  self:Delete()
end

function UIWarChessBattleResult:__StartAnimation()
  AudioManager:PlayAudioById(1003)
  local containAth = false
  if self.rewardDic ~= nil then
    for id, num in pairs(self.rewardDic) do
      local itemCfg = ConfigData.item[id]
      if itemCfg ~= nil and itemCfg.type == eItemType.Arithmetic then
        containAth = true
        break
      end
    end
  end
  if containAth and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
  end
  self.__animationStart = true
  if self.rewardSequence ~= nil then
    self.rewardSequence:Restart()
  end
end

function UIWarChessBattleResult:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnScreenSizeChanged, self.__OnScreenSizeChanged)
  MsgCenter:RemoveListener(eMsgEventId.OnShowBattleResultComplete, self.__playAnim)
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.rewardSequence ~= nil then
    self.rewardSequence:Kill()
    self.rewardSequence = nil
  end
  if self.weeklyResultNode ~= nil then
    self.weeklyResultNode:Delete()
  end
  self.__playerRoleList = nil
  self.__enemyRoleList = nil
  base.OnDelete(self)
end

return UIWarChessBattleResult
