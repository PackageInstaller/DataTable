local base = UIBaseWindow
local UIWarChessResult = class("UIWarChessResult", base)
local cs_ResLoader = CS.ResLoader
local HeroData = require("Game.PlayerData.Hero.HeroData")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local JumpManager = require("Game.Jump.JumpManager")
local SkinEnum = require("Game.Skin.SkinEnum")

function UIWarChessResult:OnInit()
  self.resloader = CS.ResLoader.Create()
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.rewardItem)
  self.ui.rewardItem.gameObject:SetActive(false)
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.OnReturnClicked)
  UIUtil.AddButtonListener(self.ui.btn_Detail, self, self.OnClickTeamChipDetail)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_GotoItem1, self, self.OnClickJump2DefeatAdvise, 1)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_GotoItem2, self, self.OnClickJump2DefeatAdvise, 2)
  UIUtil.AddButtonListener(self.ui.btn_GotoTechUp, self, self.OnClickJump2ActTech)
end

function UIWarChessResult:InitWarChessResult(isWin)
  self.ui.vectoryNode:SetActive(isWin)
  self.ui.failureNode:SetActive(not isWin)
  self._isWin = isWin
  local isWCS = WarChessSeasonManager:GetIsInWCSeason()
  DestroyUnityObject(self.img_ResultBG_Material)
  self.img_ResultBG_Material = nil
  self.img_ResultBG_Material = UIUtil.GetImageMaterial(self.ui.img_ResultBG)
  if isWin then
    AudioManager:PlayAudioById(1003)
    self.ui.img_ResultState:SetIndex(0)
    self.ui.tex_ResultState:SetIndex(0)
    local material = self.img_ResultBG_Material
    material:SetFloat("_Decoloration", 0)
    self.ui.img_ResultBG.color = self.ui.col_Success
    if WarChessManager:IsWCCouldRestart() then
      local restartFunc, restartCostId, restartCostNum = WarChessManager:GetWCRestart()
      self.ui.tex_AgainPoint.text = tostring(againCostStamina)
      self.ui.btn_Again.gameObject:SetActive(true)
    end
    self:__ShowMVP()
  else
    AudioManager:PlayAudioById(1004)
    self.ui.img_ResultState:SetIndex(1)
    if isWCS then
      self.ui.tex_ResultState:SetIndex(2)
    else
      self.ui.tex_ResultState:SetIndex(1)
    end
    local material = self.img_ResultBG_Material
    material:SetFloat("_Decoloration", 1)
    self.ui.suggestBtn:SetActive(true)
    self.ui.suggestTips:SetActive(false)
    local battleFailJumpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleFailJump)
    if not battleFailJumpUnlock then
      self.ui.failureNode.gameObject:SetActive(false)
    end
    self:__RefreshDefeatJump()
  end
  self:__ShowChip()
  self:__ShowCoin()
  self:__ShowPowerIncrease()
  self:__RefreshTechBtn()
end

function UIWarChessResult:__RefreshTechBtn()
  if not WarChessSeasonManager:IsInWCS() then
    return
  end
  local openFunc, reddotOPenFunc = WarChessSeasonManager:GetSeasonTechJumpFunc()
  if openFunc == nil then
    return
  end
  self._openTechFunc = openFunc
  self.ui.btn_GotoTechUp.gameObject:SetActive(true)
  self.ui.btn_GotoItem1.gameObject:SetActive(false)
  self.ui.redDot_GotoTechUp:SetActive(reddotOPenFunc ~= nil and reddotOPenFunc())
end

function UIWarChessResult:RefreshWCResultReward(wcSettelRewardData)
  local firstPassRewardDic = wcSettelRewardData.firstPassRewardDic or table.emptytable
  local innerWCReardDic = wcSettelRewardData.innerWCReardDic or table.emptytable
  local stmStorePickRewardDic = wcSettelRewardData.stmStorePickRewardDic or table.emptytable
  local isHaveFirstReward = table.count(firstPassRewardDic) > 0
  local isHaveInnerReward = table.count(innerWCReardDic) > 0
  local isHaveRewardBagReward = table.count(stmStorePickRewardDic) > 0
  local isHaveReward = isHaveFirstReward or isHaveInnerReward or isHaveRewardBagReward
  self.ui.rewardRect:SetActive(isHaveReward)
  self.ui.noReward:SetActive(not isHaveReward)
  self.ui.tex_noReward:SetIndex(0)
  self.ui.firstList:SetActive(isHaveFirstReward)
  self.ui.normalList:SetActive(isHaveInnerReward or isHaveRewardBagReward)
  self.rewardItemPool:HideAll()
  if isHaveFirstReward then
    for itemId, itemNum in pairs(firstPassRewardDic) do
      local rewardItem = self.rewardItemPool:GetOne()
      local itemCfg = ConfigData.item[itemId]
      rewardItem:InitItemWithCount(itemCfg, itemNum)
      rewardItem.transform:SetParent(self.ui.firstList.transform)
    end
  end
  local normalRewardDic = {}
  if isHaveInnerReward then
    for key, value in pairs(innerWCReardDic) do
      normalRewardDic[key] = (normalRewardDic[key] or 0) + value
    end
  end
  if isHaveRewardBagReward then
    for key, value in pairs(stmStorePickRewardDic) do
      normalRewardDic[key] = (normalRewardDic[key] or 0) + value
    end
  end
  for itemId, itemNum in pairs(normalRewardDic) do
    local rewardItem = self.rewardItemPool:GetOne()
    local itemCfg = ConfigData.item[itemId]
    rewardItem:InitItemWithCount(itemCfg, itemNum)
    rewardItem.transform:SetParent(self.ui.normalList.transform)
  end
end

function UIWarChessResult:RefreshWCLevelInfo(name, indexName)
  self.ui.tex_LevelName.gameObject:SetActive(true)
  self.ui.tex_LevelCount.text = indexName
  self.ui.tex_LevelName.text = name
end

function UIWarChessResult:__ShowChip()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local teamDic = wcCtrl.teamCtrl:GetWCTeams()
  local allChipLevel = 0
  for _, teamData in pairs(teamDic) do
    local dynPlayer = teamData:GetTeamDynPlayer()
    local chipList = dynPlayer:GetChipList()
    for _, chipData in pairs(chipList) do
      allChipLevel = allChipLevel + chipData:GetCount()
    end
  end
  self.ui.tex_ChipCount.text = tostring(allChipLevel)
  if allChipLevel <= 0 then
    self.ui.btn_Detail.interactable = false
  else
    self.ui.btn_Detail.interactable = true
  end
end

function UIWarChessResult:__ShowCoin()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local CCNum = wcCtrl.backPackCtrl:GetWCCoinNum()
  self.ui.tex_MoneyCount.text = tostring(CCNum)
end

function UIWarChessResult:__ShowPowerIncrease()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local teamDic = wcCtrl.teamCtrl:GetWCTeams()
  local totalNewPower = 0
  local totalOldPower = 0
  for _, teamData in pairs(teamDic) do
    local dynPlayer = teamData:GetTeamDynPlayer()
    local newPower = dynPlayer:GetTotalFightingPower(true, false)
    local oldPower = dynPlayer:GetMirrorTeamFightPower(true, false) or 1
    totalNewPower = totalNewPower + newPower
    totalOldPower = totalOldPower + oldPower
  end
  local increase = (totalNewPower / totalOldPower - 1) * 100
  increase = 0 < increase and increase or 0
  self.ui.tex_BuffRate:SetIndex(0, GetPreciseDecimalStr(increase, 0))
end

function UIWarChessResult:__ShowMVP()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local epMvpData = wcCtrl.teamCtrl:GetWCMvpData()
  if epMvpData ~= nil then
    local heroId, MvpType, diggestRate = epMvpData:GetEpMvpData()
    local heroData = wcCtrl.teamCtrl:GetHeroDynDataById(heroId)
    if heroData == nil then
      local heroCfg = ConfigData.hero_data[heroId]
      heroData = HeroData.New({
        basic = {
          id = heroId,
          level = 1,
          exp = 0,
          star = heroCfg.rank,
          potentialLvl = 0,
          ts = -1,
          career = heroCfg.career,
          company = heroCfg.camp,
          skinId = PlayerDataCenter.skinData:DealNotSelfHaveHeroSkinOverraid(0, heroId)
        }
      })
    end
    ExplorationManager:PlayMVPVoice(heroId)
    self.ui.tex_MvpType:SetIndex(MvpType)
    self.ui.tex_Rate:SetIndex(0, GetPreciseDecimalStr(diggestRate * 100, 0))
    self:_LoadMvpPic(heroData:GetResPicName())
  end
end

function UIWarChessResult:_LoadMvpPic(resPicName)
  if self.bigImgResloader ~= nil then
    self.bigImgResloader:Put2Pool()
  end
  self.bigImgResloader = cs_ResLoader.Create()
  self.bigImgResloader:LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(resPicName, SkinEnum.fromWhere.mpv), function(prefab)
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate(self.ui.heroBigImgNode)
    local commonPicCtrl = self.bigImgGameObject:FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroList")
  end)
end

function UIWarChessResult:OnClickTeamChipDetail()
  UIManager:ShowWindowAsync(UIWindowTypeID.WarChessViewChip, function(window)
    if window ~= nil then
      window:InitAllTeamChips()
    end
  end)
end

function UIWarChessResult:OnReturnClicked()
  WarChessManager:ExitWarChess(Consts.SceneName.Sector, self._isWin, nil, function()
    local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
    if aftertTeatmentCtrl ~= nil then
      aftertTeatmentCtrl:TeatmentBengin()
    end
  end)
end

function UIWarChessResult:__RefreshDefeatJump()
  local cfg1 = ConfigData.defeat_jump[1]
  local cfg2 = ConfigData.defeat_jump[2]
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

function UIWarChessResult:OnClickJump2DefeatAdvise(typeIndex)
  WarChessManager:ExitWarChess(Consts.SceneName.Main, false, function()
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
end

function UIWarChessResult:OnClickJump2ActTech()
  WarChessManager:ExitWarChess(Consts.SceneName.Main, false, function()
    if self._openTechFunc ~= nil then
      self._openTechFunc()
    end
  end)
end

function UIWarChessResult:OnDelete()
  DestroyUnityObject(self.img_ResultBG_Material)
  self.img_ResultBG_Material = nil
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

return UIWarChessResult
