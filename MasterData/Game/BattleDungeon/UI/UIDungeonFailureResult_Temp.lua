local UIDungeonFailureResult_Temp = class("UIExplorationResult", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local JumpManager = require("Game.Jump.JumpManager")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_MessageCommon = CS.MessageCommon
local CCId = 1

function UIDungeonFailureResult_Temp:OnInit()
  self.isWin = false
  self.rewardsRecord = {}
  self.rewardList = {}
  self.CCNum = nil
  self.resloader = cs_ResLoader.Create()
  self.ui.btn_Skada.gameObject:SetActive(true)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.OnReturnClicked)
  UIUtil.AddButtonListener(self.ui.btn_Again, self, self.OnRestartClicked)
  UIUtil.AddButtonListener(self.ui.btn_Detail, self, self.ShowAllChips)
  UIUtil.AddButtonListener(self.ui.btn_ViewAllReward, self, self.ShowAllItems)
  UIUtil.AddButtonListener(self.ui.btn_Skada, self, self.__ShowBattleStatistic)
  UIUtil.AddButtonListener(self.ui.btn_Recomme, self, self.OnRecommeClick)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_GotoItem1, self, self.OnClickJump2DefeatAdvise, 1)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_GotoItem2, self, self.OnClickJump2DefeatAdvise, 2)
  self.ui.btn_Again.gameObject:SetActive(false)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.rewardItem)
  self.ui.rewardItem.gameObject:SetActive(false)
end

function UIDungeonFailureResult_Temp:FailDungeon(clearAction, closeAction, statisticFunc)
  self.statisticFunc = statisticFunc
  self._auBack = AudioManager:PlayAudioById(3010, function()
    self._auBack = nil
  end)
  self.rewardsRecord = rewardsRecord
  self.isWin = false
  self._battleEndClear = clearAction
  self.closeAction = closeAction
  DestroyUnityObject(self.resultBG_Material)
  self.resultBG_Material = nil
  self.resultBG_Material = UIUtil.GetImageMaterial(self.ui.img_ResultBG)
  local resultBG_Material = self.resultBG_Material
  if self.isWin then
    self.ui.img_ResultState:SetIndex(0)
    self.ui.tex_ResultState:SetIndex(0)
    self.ui.vectoryNode:SetActive(true)
    self.ui.failureNode:SetActive(false)
    resultBG_Material:SetFloat("_Decoloration", 0)
  else
    self.ui.img_ResultState:SetIndex(1)
    self.ui.tex_ResultState:SetIndex(1)
    self.ui.vectoryNode:SetActive(false)
    self.ui.failureNode:SetActive(true)
    resultBG_Material:SetFloat("_Decoloration", 1)
  end
  self:__RefreshDefeatJump()
end

function UIDungeonFailureResult_Temp:DungeonFaileSetPlayeAgain(playerAgainCallback, dInterfaceData)
  self.playerAgainCallback = playerAgainCallback
  self.__dInterfaceData = dInterfaceData
  local cost = dInterfaceData:GetReplayStaminaCost()
  self.ui.againCost:SetActive(false)
  if 0 < cost then
    self.ui.tex_AgainPoint.text = tostring(cost)
    self.ui.againCost:SetActive(true)
  end
  self.ui.btn_Again.gameObject:SetActive(true)
end

function UIDungeonFailureResult_Temp:OnRecommeClick()
  PlayerClickCollectManager:BtnClickNumCollect(1007)
  if BattleDungeonManager.dunInterfaceData then
    local levelData = BattleDungeonManager.dunInterfaceData:GetIDungeonLevelData()
    local dunId = levelData and levelData:GetDungeonLevelStageId() or nil
    if dunId then
      local recommeCtrl = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
      recommeCtrl:ReqDunRecommeFormation(dunId, false)
      recommeCtrl:SetTopStatusHide(true)
    end
  end
end

function UIDungeonFailureResult_Temp:OnReturnClicked()
  if self._battleEndClear ~= nil then
    self._battleEndClear()
  end
  if self.closeAction ~= nil then
    self.closeAction()
  end
end

function UIDungeonFailureResult_Temp:OnRestartClicked()
  if self.playerAgainCallback ~= nil then
    self.playerAgainCallback(self.__dInterfaceData)
  end
end

function UIDungeonFailureResult_Temp:UpdataResultsUI(isWin)
  self:ShowReward()
  self:ShowChip()
  self:ShowCoin()
  self:ShowPowerIncrease()
  self:ShowMVP()
end

function UIDungeonFailureResult_Temp:ShowReward()
  local hasAth = false
  self.rewardList = {}
  for itemId, num in pairs(self.rewardsRecord) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("can't read itemCfg with id=" .. itemId)
    else
      hasAth = ConfigData:IsRewardNotShowATH(itemCfg)
      if not hasAth and itemCfg.explorationHold then
        table.insert(self.rewardList, {itemCfg = itemCfg, num = num})
      end
    end
  end
  if hasAth then
    if PlayerDataCenter.lastAthDiff ~= nil then
      for _, athData in ipairs(PlayerDataCenter.lastAthDiff) do
        table.insert(self.rewardList, {
          num = 1,
          itemCfg = athData.itemCfg,
          isAth = true,
          athData = athData
        })
      end
    end
    PlayerDataCenter.lastAthDiff = nil
  end
  local containAth = false
  self.rewardItemPool:HideAll()
  self.ui.btn_ViewAllReward.gameObject:SetActive(false)
  for index, v in ipairs(self.rewardList) do
    if 4 < index then
      break
    end
    local item = self.rewardItemPool:GetOne()
    if v.isAth then
      item:InitItemWithCount(v.itemCfg, v.num, function()
        UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
          if win ~= nil then
            win:InitAthDetail(v.itemCfg, v.athData)
          end
        end)
      end)
    else
      item:InitItemWithCount(v.itemCfg, v.num)
    end
    if v.itemCfg.type == eItemType.Arithmetic then
      containAth = true
    end
  end
  if containAth and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
  end
end

function UIDungeonFailureResult_Temp:ShowChip()
  self.chipList = ExplorationManager.epCtrl.dynPlayer:GetChipList()
  local chipNum = 0
  for _, chipData in ipairs(self.chipList) do
    chipNum = chipNum + chipData:GetCount()
  end
  self.ui.tex_ChipCount.text = tostring(chipNum)
  if chipNum <= 0 then
    self.ui.btn_Detail.interactable = false
  else
    self.ui.btn_Detail.interactable = true
  end
end

function UIDungeonFailureResult_Temp:ShowCoin()
  self.CCNum = 0
  if self.rewardsRecord[CCId] ~= nil then
    self.CCNum = self.rewardsRecord[CCId]
  end
  self.ui.tex_MoneyCount.text = tostring(self.CCNum)
end

function UIDungeonFailureResult_Temp:ShowPowerIncrease()
  local power = ExplorationManager.epCtrl.dynPlayer:GetTotalFightingPower(true, false)
  local oldPower = ExplorationManager.epCtrl.dynPlayer:GetMirrorTeamFightPower(true, false)
  local increase = GetPreciseDecimalStr(power / oldPower * 100, 0)
  self.ui.tex_BuffRate:SetIndex(0, tostring(increase))
end

function UIDungeonFailureResult_Temp:ShowMVP()
  if ExplorationManager.tempMVP ~= nil then
    local mvpGrade = ExplorationManager.tempMVP
    local heroData = mvpGrade.role.character.heroData
    self.ui.tex_MvpType:SetIndex(mvpGrade.gradeType)
    local value = mvpGrade.value
    local totalValue = mvpGrade.totalValue
    self.ui.tex_Rate:SetIndex(0, GetPreciseDecimalStr(value / totalValue * 100, 0))
    if self.bigImgResloader ~= nil then
      self.bigImgResloader:Put2Pool()
    end
    self.bigImgResloader = cs_ResLoader.Create()
    self.bigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(heroData:GetResPicName()), function(prefab)
      DestroyUnityObject(self.bigImgGameObject)
      self.bigImgGameObject = prefab:Instantiate(self.ui.heroBigImgNode)
      local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
      commonPicCtrl:SetPosType("HeroList")
    end)
  end
end

function UIDungeonFailureResult_Temp:ShowAllChips()
  UIManager:ShowWindowAsync(UIWindowTypeID.ViewChips, function(windows)
    if windows ~= nil then
      self.viewAllChipWin = windows
      if self.chipList ~= nil then
        windows:InitChips(self.chipList, self.resloader)
      end
    end
  end)
end

function UIDungeonFailureResult_Temp:ShowAllItems()
  UIManager:ShowWindowAsync(UIWindowTypeID.ViewItems, function(windows)
    if windows ~= nil then
      self.viewAllItemWin = windows
      windows:InitItems(self.rewardList, self.resloader)
    end
  end)
end

function UIDungeonFailureResult_Temp:__ShowBattleStatistic()
  if self.statisticFunc ~= nil then
    self.statisticFunc()
  end
end

function UIDungeonFailureResult_Temp:__RefreshDefeatJump()
  if BattleDungeonManager.dunInterfaceData then
    local levelData = BattleDungeonManager.dunInterfaceData:GetIDungeonLevelData()
    local canLookRecome = levelData and levelData:HasRecommendFormation() or false
    self.ui.btn_Recomme.gameObject:SetActive(canLookRecome)
  end
  local list = BattleDungeonManager.dunInterfaceData:GetDefeatJumpList()
  local cfg1 = ConfigData.defeat_jump[list[1] or 1]
  local cfg2 = ConfigData.defeat_jump[list[2] or 2]
  self.__defeatJumpCfgList = {cfg1, cfg2}
  self.ui.img_PicGotoItem2.enabled = false
  self.ui.img_PicGotoItem1.enabled = false
  self.resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath("ExplorationResultFailures"), function(spriteAtlas)
    if spriteAtlas == nil then
      return
    end
    if IsNull(self.transform) then
      return
    end
    self.ui.img_PicGotoItem1.sprite = AtlasUtil.GetResldSprite(spriteAtlas, cfg1.pic_path)
    self.ui.img_PicGotoItem2.sprite = AtlasUtil.GetResldSprite(spriteAtlas, cfg2.pic_path)
    self.ui.img_PicGotoItem2.enabled = true
    self.ui.img_PicGotoItem1.enabled = true
  end)
  self.ui.text_GotoItem1.text = LanguageUtil.GetLocaleText(cfg1.des)
  self.ui.text_GotoItem2.text = LanguageUtil.GetLocaleText(cfg2.des)
end

function UIDungeonFailureResult_Temp:OnClickJump2DefeatAdvise(typeIndex)
  if self._battleEndClear ~= nil then
    self._battleEndClear()
  end
  BattleDungeonManager:InjectBattleExitEvent(function()
    UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(2)
    CS.GSceneManager.Instance:LoadSceneAsyncByAB(Consts.SceneName.Main, function(ok)
      ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
      UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
        if window == nil then
          return
        end
        window:SetFrom2Home(AreaConst.Home)
        local defeatJumpCfg = self.__defeatJumpCfgList[typeIndex]
        if defeatJumpCfg == nil then
          error("defeatJumpCfg is nil with index " .. tostring(typeIndex))
          return
        end
        local jumpId = defeatJumpCfg.jump_id
        local jumpArg = defeatJumpCfg.jump_arg
        JumpManager:Jump(jumpId, nil, function()
          local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
          if aftertTeatmentCtrl ~= nil then
            aftertTeatmentCtrl:TeatmentBengin()
          end
        end, jumpArg)
      end)
    end)
  end)
  if self.closeAction ~= nil then
    self.closeAction()
  end
end

function UIDungeonFailureResult_Temp:OnDelete()
  if self._auBack ~= nil then
    AudioManager:StopAudioByBack(self._auBack)
    self._auBack = nil
  end
  DestroyUnityObject(self.resultBG_Material)
  self.resultBG_Material = nil
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
    self.bigImgResloader = nil
  end
  if self.viewAllChipWin ~= nil then
    self.viewAllChipWin:Delete()
  end
  if self.viewAllItemWin ~= nil then
    self.viewAllItemWin:Delete()
  end
  base.OnDelete(self)
end

return UIDungeonFailureResult_Temp
