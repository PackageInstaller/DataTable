local JumpManager = {}
local FuncArray = {}
local ValidateFuncArray = {}
local BlockReturnHomeCheckFuncArray = {}
local LastPlayData = require("Game.Sector.Data.LastPlayData")
local cs_MessageCommon = CS.MessageCommon
local HomeEnum = require("Game.Home.HomeEnum")
local SectorEnum = require("Game.Sector.SectorEnum")
local eSectorEntrance = require("Game.Sector.UISector.UISectorEntrance.eSectorEntrance")
local eActivityType = require("Game.ActivityFrame.ActivityFrameEnum").eActivityType
local SectorEntranceHandler = require("Game.Sector.SectorEntranceHandler")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local ShopEnum = require("Game.Shop.ShopEnum")
JumpManager.eJumpTarget = {
  Home = -1,
  ShopInvest = 1,
  ShopResident = 2,
  ShopVariable = 3,
  LotteryNormal = 4,
  LotteryAdvanced = 5,
  Mail = 6,
  Hero = 7,
  Sector = 8,
  Oasis = 9,
  Factory = 10,
  DaliyTask = 11,
  WeeklyTask = 12,
  MainTask = 13,
  SideTask = 14,
  Achieve4Cultivate = 15,
  Achieve4Commander = 16,
  Achieve4Dungeon = 17,
  Achieve4System = 18,
  Achieve4Oasis = 19,
  BuyStamina = 20,
  DailyChallenge = 21,
  WeeklyChallenge = 22,
  Dorm = 23,
  ShopBase = 24,
  Setting = 25,
  UserCenter = 26,
  UserInfoPage = 27,
  WinterActivityTech = 28,
  DungeonTower = 29,
  HeroSkin = 30,
  SctorActivity = 31,
  ShopVow = 32,
  HexaDungeonTower = 33,
  OasisBuilding = 100,
  StrategyOverview = 101,
  fragDungeon = 102,
  resourceDungeon = 103,
  ATHDungeon = 104,
  DynShop = 105,
  DynTask = 106,
  DynSectorLevel = 107,
  DynLottery = 108,
  DynActivity = 109,
  DynWarehouse = 110,
  DynCareerStO = 111,
  DynStage = 112,
  Endless = 113,
  ChatSystem = 114,
  DynHandBook = 115,
  DynFairy = 116,
  VowSystem = 117,
  Milestone = 118,
  Formation = 119
}

function JumpManager:Init()
  self:ClearSectorJumpId()
  self.couldUseItemJump = false
  local config = ConfigData.system_jump
  FuncArray[JumpManager.eJumpTarget.Home] = BindCallback(self, self.Jump2Home)
  FuncArray[0] = FuncArray[JumpManager.eJumpTarget.Home]
  FuncArray[JumpManager.eJumpTarget.ShopInvest] = BindCallback(self, self.Jump2Shop, config[JumpManager.eJumpTarget.ShopInvest].jump_arg[1])
  FuncArray[JumpManager.eJumpTarget.ShopResident] = BindCallback(self, self.Jump2Shop, config[JumpManager.eJumpTarget.ShopResident].jump_arg[1])
  FuncArray[JumpManager.eJumpTarget.ShopVariable] = BindCallback(self, self.Jump2Shop, config[JumpManager.eJumpTarget.ShopVariable].jump_arg[1])
  FuncArray[JumpManager.eJumpTarget.LotteryNormal] = BindCallback(self, self.Jump2Lottery, true)
  FuncArray[JumpManager.eJumpTarget.LotteryAdvanced] = BindCallback(self, self.Jump2Lottery, false)
  FuncArray[JumpManager.eJumpTarget.Mail] = BindCallback(self, self.Jump2Mail)
  FuncArray[JumpManager.eJumpTarget.Hero] = BindCallback(self, self.Jump2Hro)
  FuncArray[JumpManager.eJumpTarget.HeroSkin] = BindCallback(self, self.Jump2HeroSkin)
  FuncArray[JumpManager.eJumpTarget.Sector] = BindCallback(self, self.Jump2Sector)
  FuncArray[JumpManager.eJumpTarget.Oasis] = BindCallback(self, self.Jump2Oasis)
  FuncArray[JumpManager.eJumpTarget.Factory] = BindCallback(self, self.Jump2Factory)
  FuncArray[JumpManager.eJumpTarget.DaliyTask] = BindCallback(self, self.Jump2Task, config[JumpManager.eJumpTarget.DaliyTask].jump_arg[1])
  FuncArray[JumpManager.eJumpTarget.WeeklyTask] = BindCallback(self, self.Jump2Task, config[JumpManager.eJumpTarget.WeeklyTask].jump_arg[1])
  FuncArray[JumpManager.eJumpTarget.MainTask] = BindCallback(self, self.Jump2Task, config[JumpManager.eJumpTarget.MainTask].jump_arg[1])
  FuncArray[JumpManager.eJumpTarget.SideTask] = BindCallback(self, self.Jump2Task, config[JumpManager.eJumpTarget.SideTask].jump_arg[1])
  FuncArray[JumpManager.eJumpTarget.Achieve4Cultivate] = BindCallback(self, self.Jump2Achievement, config[JumpManager.eJumpTarget.Achieve4Cultivate].jump_arg[1])
  FuncArray[JumpManager.eJumpTarget.Achieve4Commander] = BindCallback(self, self.Jump2Achievement, config[JumpManager.eJumpTarget.Achieve4Commander].jump_arg[1])
  FuncArray[JumpManager.eJumpTarget.Achieve4Dungeon] = BindCallback(self, self.Jump2Achievement, config[JumpManager.eJumpTarget.Achieve4Dungeon].jump_arg[1])
  FuncArray[JumpManager.eJumpTarget.Achieve4System] = BindCallback(self, self.Jump2Achievement, config[JumpManager.eJumpTarget.Achieve4System].jump_arg[1])
  FuncArray[JumpManager.eJumpTarget.Achieve4Oasis] = BindCallback(self, self.Jump2Achievement, config[JumpManager.eJumpTarget.Achieve4Oasis].jump_arg[1])
  FuncArray[JumpManager.eJumpTarget.BuyStamina] = BindCallback(self, self.Jump2BuyStamina)
  FuncArray[JumpManager.eJumpTarget.DailyChallenge] = BindCallback(self, self.Jump2DailyChallenge)
  FuncArray[JumpManager.eJumpTarget.WeeklyChallenge] = BindCallback(self, self.Jump2WeeklyChallenge)
  FuncArray[JumpManager.eJumpTarget.Dorm] = BindCallback(self, self.Jump2Dorm)
  FuncArray[JumpManager.eJumpTarget.ShopBase] = BindCallback(self, self.Jump2ShopBase)
  FuncArray[JumpManager.eJumpTarget.Setting] = BindCallback(self, self.Jump2Setting)
  FuncArray[JumpManager.eJumpTarget.UserCenter] = BindCallback(self, self.Jump2UserCenter)
  FuncArray[JumpManager.eJumpTarget.UserInfoPage] = BindCallback(self, self.Jump2UserInfoPage)
  FuncArray[JumpManager.eJumpTarget.WinterActivityTech] = BindCallback(self, self.Jump2WinterActivityTech)
  FuncArray[JumpManager.eJumpTarget.DungeonTower] = BindCallback(self, self.Jump2DungeonTower)
  FuncArray[JumpManager.eJumpTarget.SctorActivity] = BindCallback(self, self.Jump2SctorActivity)
  FuncArray[JumpManager.eJumpTarget.ShopVow] = BindCallback(self, self.Jump2Shop, config[JumpManager.eJumpTarget.ShopVow].jump_arg[1])
  FuncArray[JumpManager.eJumpTarget.HexaDungeonTower] = BindCallback(self, self.Jump2HexaDungeonTower)
  FuncArray[JumpManager.eJumpTarget.OasisBuilding] = BindCallback(self, self.Jump2OasisBuilding)
  FuncArray[JumpManager.eJumpTarget.StrategyOverview] = BindCallback(self, self.Jump2StrategyOverview)
  FuncArray[JumpManager.eJumpTarget.fragDungeon] = BindCallback(self, self.Jump2SectorFragDungeon)
  FuncArray[JumpManager.eJumpTarget.resourceDungeon] = BindCallback(self, self.Jump2SectorResourceDungeon)
  FuncArray[JumpManager.eJumpTarget.ATHDungeon] = BindCallback(self, self.Jump2SectorATHDungeon)
  FuncArray[JumpManager.eJumpTarget.DynTask] = BindCallback(self, self.Jump2DynTask)
  FuncArray[JumpManager.eJumpTarget.DynShop] = BindCallback(self, self.Jump2DynShop)
  FuncArray[JumpManager.eJumpTarget.DynSectorLevel] = BindCallback(self, self.Jump2DynSectorLevel)
  FuncArray[JumpManager.eJumpTarget.DynLottery] = BindCallback(self, self.Jump2DynLottery)
  FuncArray[JumpManager.eJumpTarget.DynActivity] = BindCallback(self, self.Jump2DynActivity)
  FuncArray[JumpManager.eJumpTarget.DynWarehouse] = BindCallback(self, self.Jump2DynWarehouse)
  FuncArray[JumpManager.eJumpTarget.DynCareerStO] = BindCallback(self, self.Jump2DynCareerStO)
  FuncArray[JumpManager.eJumpTarget.DynStage] = BindCallback(self, self.Jump2DynStage)
  FuncArray[JumpManager.eJumpTarget.Endless] = BindCallback(self, self.Jump2Endless)
  FuncArray[JumpManager.eJumpTarget.ChatSystem] = BindCallback(self, self.Jump2ChatSystem)
  FuncArray[JumpManager.eJumpTarget.DynHandBook] = BindCallback(self, self.Jump2HandBook)
  FuncArray[JumpManager.eJumpTarget.DynFairy] = BindCallback(self, self.Jump2Fairy)
  FuncArray[JumpManager.eJumpTarget.VowSystem] = BindCallback(self, self.Jump2VowSystem)
  FuncArray[JumpManager.eJumpTarget.Milestone] = BindCallback(self, self.Jump2Milestone)
  FuncArray[JumpManager.eJumpTarget.Formation] = BindCallback(self, self.Jump2Formation)
  ValidateFuncArray[JumpManager.eJumpTarget.Home] = function()
    return true
  end
  ValidateFuncArray[0] = ValidateFuncArray[JumpManager.eJumpTarget.Home]
  ValidateFuncArray[JumpManager.eJumpTarget.ShopInvest] = BindCallback(self, self.Jump2ShopValidate, config[JumpManager.eJumpTarget.ShopInvest].jump_arg[1])
  ValidateFuncArray[JumpManager.eJumpTarget.ShopResident] = BindCallback(self, self.Jump2ShopValidate, config[JumpManager.eJumpTarget.ShopResident].jump_arg[1])
  ValidateFuncArray[JumpManager.eJumpTarget.ShopVariable] = BindCallback(self, self.Jump2ShopValidate, config[JumpManager.eJumpTarget.ShopVariable].jump_arg[1])
  ValidateFuncArray[JumpManager.eJumpTarget.LotteryNormal] = BindCallback(self, self.Jump2LotteryValidate, true)
  ValidateFuncArray[JumpManager.eJumpTarget.LotteryAdvanced] = BindCallback(self, self.Jump2LotteryValidate, false)
  ValidateFuncArray[JumpManager.eJumpTarget.Mail] = BindCallback(self, self.Jump2MailValidate, false)
  ValidateFuncArray[JumpManager.eJumpTarget.Hero] = BindCallback(self, self.Jump2HroValidate, false)
  ValidateFuncArray[JumpManager.eJumpTarget.HeroSkin] = BindCallback(self, self.Jump2HeroSkinValidate, false)
  ValidateFuncArray[JumpManager.eJumpTarget.Sector] = BindCallback(self, self.Jump2SectorValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.Oasis] = BindCallback(self, self.Jump2OasisValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.Factory] = BindCallback(self, self.Jump2FactoryValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.DaliyTask] = BindCallback(self, self.Jump2TaskValidate, config[JumpManager.eJumpTarget.DaliyTask].jump_arg[1])
  ValidateFuncArray[JumpManager.eJumpTarget.WeeklyTask] = BindCallback(self, self.Jump2TaskValidate, config[JumpManager.eJumpTarget.WeeklyTask].jump_arg[1])
  ValidateFuncArray[JumpManager.eJumpTarget.MainTask] = BindCallback(self, self.Jump2TaskValidate, config[JumpManager.eJumpTarget.MainTask].jump_arg[1])
  ValidateFuncArray[JumpManager.eJumpTarget.SideTask] = BindCallback(self, self.Jump2TaskValidate, config[JumpManager.eJumpTarget.SideTask].jump_arg[1])
  ValidateFuncArray[JumpManager.eJumpTarget.Achieve4Cultivate] = BindCallback(self, self.Jump2AchievementValidate, config[JumpManager.eJumpTarget.Achieve4Cultivate].jump_arg[1])
  ValidateFuncArray[JumpManager.eJumpTarget.Achieve4Commander] = BindCallback(self, self.Jump2AchievementValidate, config[JumpManager.eJumpTarget.Achieve4Commander].jump_arg[1])
  ValidateFuncArray[JumpManager.eJumpTarget.Achieve4Dungeon] = BindCallback(self, self.Jump2AchievementValidate, config[JumpManager.eJumpTarget.Achieve4Dungeon].jump_arg[1])
  ValidateFuncArray[JumpManager.eJumpTarget.Achieve4System] = BindCallback(self, self.Jump2AchievementValidate, config[JumpManager.eJumpTarget.Achieve4System].jump_arg[1])
  ValidateFuncArray[JumpManager.eJumpTarget.Achieve4Oasis] = BindCallback(self, self.Jump2AchievementValidate, config[JumpManager.eJumpTarget.Achieve4Oasis].jump_arg[1])
  ValidateFuncArray[JumpManager.eJumpTarget.BuyStamina] = BindCallback(self, self.Jump2BuyStaminaValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.DailyChallenge] = BindCallback(self, self.Jump2DailyChallengeValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.WeeklyChallenge] = BindCallback(self, self.Jump2WeeklyChallengeValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.Dorm] = BindCallback(self, self.Jump2DormValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.ShopBase] = BindCallback(self, self.Jump2ShopBaseValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.Setting] = BindCallback(self, self.Jump2SettingValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.UserCenter] = BindCallback(self, self.Jump2UserCenterValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.UserInfoPage] = BindCallback(self, self.Jump2UserInfoPageValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.WinterActivityTech] = BindCallback(self, self.Jump2WinterActivityTechValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.DungeonTower] = BindCallback(self, self.Jump2DungeonTowerValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.SctorActivity] = BindCallback(self, self.Jump2SctorActivityValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.ShopVow] = BindCallback(self, self.Jump2ShopValidate, config[JumpManager.eJumpTarget.ShopVow].jump_arg[1])
  ValidateFuncArray[JumpManager.eJumpTarget.HexaDungeonTower] = BindCallback(self, self.Jump2HexaDungeonTowerValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.OasisBuilding] = BindCallback(self, self.Jump2OasisBuildingValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.StrategyOverview] = BindCallback(self, self.Jump2StrategyOverviewValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.fragDungeon] = BindCallback(self, self.Jump2SectorFragDungeonValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.resourceDungeon] = BindCallback(self, self.Jump2SectorResourceDungeonValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.ATHDungeon] = BindCallback(self, self.Jump2SectorATHDungeonValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.DynTask] = BindCallback(self, self.Jump2DynTaskValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.DynShop] = BindCallback(self, self.Jump2DynShopValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.DynSectorLevel] = BindCallback(self, self.Jump2DynSectorLevelValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.DynLottery] = BindCallback(self, self.Jump2DynLotteryValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.DynActivity] = BindCallback(self, self.Jump2DynActivityValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.DynWarehouse] = BindCallback(self, self.Jump2DynWarehouseValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.DynCareerStO] = BindCallback(self, self.Jump2DynCareerStOValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.DynStage] = BindCallback(self, self.Jump2DynStageValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.Endless] = BindCallback(self, self.Jump2EndlessValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.ChatSystem] = BindCallback(self, self.Jump2ChatSystemValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.DynHandBook] = BindCallback(self, self.Jump2HandBookValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.DynFairy] = BindCallback(self, self.Jump2FairyValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.VowSystem] = BindCallback(self, self.Jump2VowSystemValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.Milestone] = BindCallback(self, self.Jump2MilestoneValidate)
  ValidateFuncArray[JumpManager.eJumpTarget.Formation] = BindCallback(self, self.Jump2FormationValidate)
  BlockReturnHomeCheckFuncArray[JumpManager.eJumpTarget.DynActivity] = BindCallback(self, self.Jump2DynActivityBlockHome)
end

function JumpManager:Jump(jumpType, beforeJumpCallback, jumpOverCallback, argList, isCoverJump)
  local bool, num = self:ValidateJump(jumpType, argList)
  if bool then
    self.isJumping = true
    
    local function newJumpOverCallback(...)
      if jumpOverCallback ~= nil then
        jumpOverCallback(...)
      end
      self.isJumping = false
    end
    
    local function RealJumpFunc()
      if not isCoverJump and JumpManager:IsJumpNeedBack2Home(jumpType, argList) then
        self:Add2OnHomeUIOpenListern(function()
          FuncArray[num](newJumpOverCallback, argList, false)
        end)
        UIUtil.ReturnHome()
      else
        local jumpCorverArgs
        if isCoverJump then
          for typeID, win in pairs(UIManager.windows) do
            if win.fromType == eBaseWinFromWhere.jumpCorver then
              jumpCorverArgs = win.jumpCorverArgs
              win.fromType = nil
              UIUtil.ReturnUntil2Marker(win:GetUIWindowTypeId(), true)
            end
          end
        end
        FuncArray[num](newJumpOverCallback, argList, isCoverJump, jumpCorverArgs)
      end
    end
    
    if beforeJumpCallback ~= nil then
      beforeJumpCallback(RealJumpFunc)
    else
      RealJumpFunc()
    end
  end
end

function JumpManager:ValidateJump(jumpType, argList)
  local num
  if type(jumpType) == "string" then
    if string.IsNullOrEmpty(jumpType) then
      return false
    end
    num = tonumber(jumpType)
  elseif type(jumpType) == "number" then
    num = jumpType
  else
    return false
  end
  if FuncArray[num] == nil then
    return false
  end
  return ValidateFuncArray[num](argList, false), num
end

function JumpManager:__ShowCanotJumpMessage(fid, lineWrap, notShowMessage)
  local des = FunctionUnlockMgr:GetFuncUnlockDecription(fid, lineWrap)
  if notShowMessage then
    return des
  end
  des = string.format(ConfigData:GetTipContent(TipContent.Jump_TargetFuncLocked), des)
  cs_MessageCommon.ShowMessageTips(des)
end

local notNeedBack2Home = {
  [JumpManager.eJumpTarget.BuyStamina] = true,
  [JumpManager.eJumpTarget.Home] = true,
  [JumpManager.eJumpTarget.Setting] = true,
  [JumpManager.eJumpTarget.UserCenter] = true,
  [JumpManager.eJumpTarget.DynFairy] = true,
  [JumpManager.eJumpTarget.VowSystem] = true
}
local sectorTypes = {
  [JumpManager.eJumpTarget.Sector] = true,
  [JumpManager.eJumpTarget.ATHDungeon] = true,
  [JumpManager.eJumpTarget.fragDungeon] = true,
  [JumpManager.eJumpTarget.resourceDungeon] = true,
  [JumpManager.eJumpTarget.DynSectorLevel] = true,
  [JumpManager.eJumpTarget.DynCareerStO] = true,
  [JumpManager.eJumpTarget.WeeklyChallenge] = true,
  [JumpManager.eJumpTarget.DailyChallenge] = true,
  [JumpManager.eJumpTarget.DungeonTower] = true,
  [JumpManager.eJumpTarget.HexaDungeonTower] = true,
  [JumpManager.eJumpTarget.DynStage] = true,
  [JumpManager.eJumpTarget.Endless] = true,
  [JumpManager.eJumpTarget.SctorActivity] = true
}
local heroTypes = {
  [JumpManager.eJumpTarget.Hero] = true
}
local DormTypes = {
  [JumpManager.eJumpTarget.Dorm] = true
}
local SectorActivityType = {
  [eActivityType.SectorI] = true,
  [eActivityType.HeroGrow] = true,
  [eActivityType.SectorII] = true,
  [eActivityType.RefreshDun] = true,
  [eActivityType.Carnival] = true,
  [eActivityType.DailyChallenge] = true,
  [eActivityType.SectorIII] = true,
  [eActivityType.Hallowmas] = true,
  [eActivityType.Spring] = true,
  [eActivityType.Winter23] = true,
  [eActivityType.CardSet] = true,
  [eActivityType.Divergent] = true,
  [eActivityType.ShortTheatre] = true,
  [eActivityType.ActBlackHole] = true,
  [eActivityType.SteinsGateMiniGame] = true,
  [eActivityType.SoundPlayMiniGame] = true,
  [eActivityType.HeroGrowV3] = true,
  [eActivityType.SignInLiveStream] = true,
  [eActivityType.Bond] = true,
  [eActivityType.Brotato] = true
}
local NotNeedBack2HomeAct = {
  [eActivityType.WhiteDay] = true,
  [eActivityType.Spring] = true,
  [eActivityType.Winter23] = true,
  [eActivityType.Season] = true,
  [eActivityType.ActivityCarnival23] = true,
  [eActivityType.Anniversary23] = true,
  [eActivityType.SteinsGate] = true,
  [eActivityType.Spring24] = true,
  [eActivityType.Carnival24] = true,
  [eActivityType.DeliverySimulator] = true,
  [eActivityType.ActAnniversary24] = true
}

function JumpManager:IsJumpNeedBack2Home(jumpType, argList)
  if notNeedBack2Home[jumpType] then
    return false
  end
  local homeCtrl = ControllerManager:GetController(ControllerTypeId.HomeController)
  local isInNormalHome = homeCtrl ~= nil and homeCtrl.homeState == HomeEnum.eHomeState.Normal
  if isInNormalHome then
    return false
  end
  if BlockReturnHomeCheckFuncArray[jumpType] ~= nil and BlockReturnHomeCheckFuncArray[jumpType](argList) then
    return false
  end
  if jumpType == JumpManager.eJumpTarget.DynShop and UIManager:GetWindow(UIWindowTypeID.ShopMain) ~= nil then
    return false
  end
  if sectorTypes[jumpType] and ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil then
    return false
  end
  if heroTypes[jumpType] and UIManager:GetWindow(UIWindowTypeID.HeroList) ~= nil then
    return false
  end
  if DormTypes[jumpType] and UIManager:GetWindow(UIWindowTypeID.DormMain) ~= nil then
    return false
  end
  if jumpType == JumpManager.eJumpTarget.DynActivity then
    return self:IsThisActivityJump2Home(argList)
  end
  return true
end

function JumpManager:Add2OnHomeUIOpenListern(jumpfunc)
  function self.back2HomeMsgFunc(isBackStackEmpty)
    if not isBackStackEmpty then
      UIUtil.isRunningJump = true
    end
    if jumpfunc ~= nil then
      jumpfunc()
    end
    self.back2HomeMsgFunc = nil
  end
end

function JumpManager:IsHaveBack2Home()
  return self.back2HomeMsgFunc ~= nil
end

function JumpManager:TryCallBack2HomeMsgFunc(isBackStackEmpty)
  if self.back2HomeMsgFunc ~= nil then
    self.back2HomeMsgFunc(isBackStackEmpty)
    return true
  end
end

function JumpManager:GetIsJumping()
  return self.isJumping
end

function JumpManager:__BeforeDirectJump(noSector, noLobby)
  local formationCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  if formationCtrl ~= nil then
    formationCtrl:RealExitFormation()
  end
  local dailyTaskCtrl = ControllerManager:GetController(ControllerTypeId.DailyDungeonLevelCtrl)
  if dailyTaskCtrl ~= nil then
    dailyTaskCtrl:ExitDailyDungeon()
  end
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if sectorCtrl ~= nil and not noSector then
    sectorCtrl:ExitSectorCtrl()
    sectorCtrl:Delete()
  end
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  if dormCtrl ~= nil then
    dormCtrl:Delete()
  end
  local fairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy)
  if fairyCtrl ~= nil then
    fairyCtrl:Clear()
  end
  local lotterCtrl = ControllerManager:GetController(ControllerTypeId.Lottery)
  if lotterCtrl ~= nil then
    lotterCtrl:Delete()
  end
  local factoryCtrl = ControllerManager:GetController(ControllerTypeId.Factory)
  if factoryCtrl ~= nil then
    factoryCtrl:CloseFactory(true)
  end
  local actLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLobbyCtrl ~= nil and not noLobby then
    actLobbyCtrl:Delete()
  end
end

function JumpManager:GetSectorJumpId()
  return self.sectorJumpId
end

function JumpManager:RecordSectorJumpId(id)
  self.sectorJumpId = id
end

function JumpManager:ClearSectorJumpId(id)
  self.sectorJumpId = nil
end

function JumpManager:Jump2Home(jumpOverCallback)
  UIUtil.ReturnHome()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

function JumpManager:Jump2Shop(shopid, jumpOverCallback)
  self:Jump2DynShop(jumpOverCallback, {shopid})
end

function JumpManager:Jump2ShopValidate(shopid)
  if type(shopid) == "table" then
    return self:Jump2DynShopValidate(shopid)
  else
    return self:Jump2DynShopValidate({shopid})
  end
end

function JumpManager:Jump2Lottery(isNormal, jumpOverCallback)
  if isNormal then
    self:Jump2DynLottery(jumpOverCallback, {2})
  else
    self:Jump2DynLottery(jumpOverCallback, {1})
  end
end

function JumpManager:Jump2LotteryValidate(isNormal)
  if isNormal then
    return self:Jump2DynLotteryValidate({2})
  else
    return self:Jump2DynLotteryValidate({1})
  end
end

function JumpManager:Jump2Mail(jumpOverCallback)
  local isMailUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail)
  if not isMailUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail, true)
    return false
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Mail, function(win)
    if win ~= nil and jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end)
end

function JumpManager:Jump2MailValidate()
  local isMailUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail)
  if not isMailUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail, true)
    return false
  end
  return true
end

function JumpManager:Jump2Hro(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local hideWinList
  local fromWhere = eBaseWinFromWhere.home
  local heroPotentialWin = UIManager:GetWindow(UIWindowTypeID.HeroPotential)
  if heroPotentialWin ~= nil then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.HeroPotential, true)
  end
  local heroStateWin = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if heroStateWin ~= nil then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.HeroState, true)
  end
  local heroWin = UIManager:GetWindow(UIWindowTypeID.HeroList)
  if (heroWin == nil or not heroWin.active) and isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({
        [UIWindowTypeID.TopStatus] = true
      })
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  if heroWin ~= nil then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.HeroList)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  end
  local jumpCorverArgs = {
    hideWinList = hideWinList,
    befroeJumpCouldUseItemJump = self:GetBefroeJumpCouldUseItemJump(jumpCorverArgs)
  }
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroList, function(win)
    if win == nil then
      return
    end
    local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWindow ~= nil and not isCoverJump then
      homeWindow:OpenOtherWin()
    end
    win.jumpCorverArgs = jumpCorverArgs
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end, nil, fromWhere)
end

function JumpManager:Jump2HeroSkin(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local hideWinList
  local fromWhere = eBaseWinFromWhere.home
  if isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({
        [UIWindowTypeID.TopStatus] = true
      })
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  local jumpCorverArgs = {
    hideWinList = hideWinList,
    befroeJumpCouldUseItemJump = self:GetBefroeJumpCouldUseItemJump(jumpCorverArgs)
  }
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroSkin, function(win)
    if win == nil then
      return
    end
    local skinId = argList[1]
    local skinFromWhere = argList[2]
    local initSkinIds = argList[3]
    local heroId = PlayerDataCenter.skinData:GetHeroIdBySkinId(skinId)
    local heroCfg = ConfigData.hero_data[heroId]
    local skinIds = initSkinIds
    if initSkinIds == nil or #initSkinIds < 1 then
      skinIds = {
        heroCfg.default_skin
      }
      for i, v in ipairs(heroCfg.skin) do
        if PlayerDataCenter.skinData:IsSkinUnlocked(v) then
          table.insert(skinIds, v)
        end
      end
    end
    win:SetSkinFromWhere(skinFromWhere)
    win:InitSkinBySkinList(skinId, skinIds, nil, nil)
    win.jumpCorverArgs = jumpCorverArgs
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    if ControllerManager:GetController(ControllerTypeId.HomeController).isRunningAutoShow then
      win:SetHeroSkinBanJump()
    end
  end, nil, fromWhere)
end

function JumpManager:Jump2HroValidate()
  local isHeroListUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup)
  if not isHeroListUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup, true)
    return false
  end
  return true
end

function JumpManager:Jump2HeroSkinValidate()
  local isHeroListUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup)
  if not isHeroListUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup, true)
    return false
  end
  return true
end

function JumpManager:Jump2Sector(jumpOverCallback, argList)
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.SectorEntrance)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  local doNotOpenEpStages = false
  if argList ~= nil then
    doNotOpenEpStages = argList[1]
  end
  Home.homeRightNode:OnClickEpBtn(doNotOpenEpStages)
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

function JumpManager:Jump2SectorValidate(argList)
  return true
end

function JumpManager:Jump2Oasis(jumpOverCallback)
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  if Home == nil then
    return
  end
  Home.homeRightNode:OnClickOasisBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

function JumpManager:Jump2OasisValidate()
  local isOasisUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Building)
  if not isOasisUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Building, true)
    return false
  end
  return true
end

function JumpManager:Jump2Factory(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  if not isCoverJump then
    local Home = UIManager:GetWindow(UIWindowTypeID.Home)
    Home.homeRightNode:OnClickFactoryBtn()
  else
    self:__BeforeDirectJump()
    ControllerManager:GetController(ControllerTypeId.Factory, true):OpenFactory()
  end
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

function JumpManager:Jump2FactoryValidate()
  local isFactoryUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory)
  if not isFactoryUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory, true)
    return false
  end
  return true
end

function JumpManager:Jump2Task(taskTypeID, jumpOverCallback, arglist, isCoverJump, jumpCorverArgs)
  self:Jump2DynTask(jumpOverCallback, {taskTypeID}, isCoverJump, jumpCorverArgs)
end

function JumpManager:Jump2TaskValidate(taskTypeID)
  return self:Jump2DynTaskValidate({taskTypeID})
end

function JumpManager:Jump2Achievement(achievementTypeID, jumpOverCallback, arglist, isCoverJump, jumpCorverArgs)
  local fromWhere = eBaseWinFromWhere.home
  local hideWinList
  if isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({
        [UIWindowTypeID.TopStatus] = true
      })
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  local jumpCorverArgs = {
    hideWinList = hideWinList,
    befroeJumpCouldUseItemJump = self:GetBefroeJumpCouldUseItemJump(jumpCorverArgs)
  }
  UIManager:ShowWindowAsync(UIWindowTypeID.AchievementSystem, function(win)
    if win ~= nil then
      local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
      if homeWindow ~= nil and not isCoverJump then
        homeWindow:OpenOtherWin()
      end
      win:InitAchievement(nil, Home ~= nil)
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
      win.jumpCorverArgs = jumpCorverArgs
    end
  end, nil, fromWhere)
end

function JumpManager:Jump2AchievementValidate(achievementTypeID)
  local isAchUIUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement)
  if not isAchUIUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement, true)
    return false
  end
  return true
end

function JumpManager:Jump2BuyStamina(jumpOverCallback, argList)
  local ShopEnum = require("Game.Shop.ShopEnum")
  local quickBuyData = ShopEnum.eQuickBuy.stamina
  local shopId = quickBuyData.shopId
  local shelfId = quickBuyData.shelfId
  local goodData
  local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  local needNum, closeCallback
  if argList ~= nil then
    needNum = argList[1]
    closeCallback = argList[2]
  end
  local buyKeyWin = UIManager:GetWindow(UIWindowTypeID.QuickBuyKey)
  if buyKeyWin ~= nil and buyKeyWin.active then
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  end
  ctrl:GetShopData(shopId, function(shopData)
    goodData = shopData.shopGoodsDic[shelfId]
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuyKey, function(win)
      if win == nil then
        error("can't open QuickBuy win")
        if jumpOverCallback ~= nil then
          jumpOverCallback()
        end
        return
      end
      local isHideLeftBtn = ExplorationManager:IsInExploration() or WarChessManager:GetIsInWarChess()
      win:SlideIn(true, isHideLeftBtn)
      win:InitQuickPurchaseKey(nil, needNum, goodData, closeCallback)
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
    end)
  end)
end

function JumpManager:Jump2BuyStaminaValidate()
  local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  if not ctrl:GetIsUnlock() then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.notUnlockShopCantBuyStamina))
    return false
  end
  return true
end

function JumpManager:Jump2DailyChallenge(jumpOverCallback)
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.SectorEntrance)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.res)
      sectorController.dailyCtrl:OpenSectorPlayMode()
    end
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can't get sectorController")
      return
    end
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.res)
      sectorController.dailyCtrl:OpenSectorPlayMode()
    end
    self:ClearSectorJumpId()
    self.isJumping = false
  end)
  Home.homeRightNode:OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  self.isJumping = true
end

function JumpManager:Jump2DailyChallengeValidate()
  local isDailyChallengeUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyDungeon)
  if not isDailyChallengeUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyDungeon, true)
    return false
  end
  return true
end

function JumpManager:Jump2WeeklyChallenge(jumpOverCallback)
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.SectorEntrance)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.res)
      sectorController.weeklyCtrl:OpenSectorPlayMode()
    end
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can't get sectorController")
      return
    end
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.res)
      sectorController.weeklyCtrl:OpenSectorPlayMode()
    end
    self:ClearSectorJumpId()
    self.isJumping = false
  end)
  Home.homeRightNode:OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  self.isJumping = true
end

function JumpManager:Jump2WeeklyChallengeValidate()
  local isWeeklyChallengeUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge)
  if not isWeeklyChallengeUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge, true)
    return false
  end
  if not PlayerDataCenter.allWeeklyChallengeData:IsExistChallenge() then
    error("weeklyChallenges count is 0")
    return false
  end
  return true
end

function JumpManager:Jump2Dorm(jumpOverCallback, argList)
  if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.DormMain) then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.DormMain)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  end
  local is2OtherDrom = argList[1]
  if is2OtherDrom then
    local DormUtil = require("Game.Dorm.DormUtil")
    local userId = argList[2]
    local userName = argList[3]
    DormUtil.TryEnterOtherDorm(userId, userName)
    return
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.homeRightNode:OnClickDormBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

function JumpManager:Jump2DormValidate(argList, notShowMessage)
  local isDormUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm)
  if not isDormUnlock then
    local unlockNotice = self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm, true, notShowMessage)
    return false, unlockNotice
  end
  return true
end

function JumpManager:Jump2ShopBase(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local isShopShowBeforeUnlock = JumpManager:Jump2DynShopBeforeUnlock(argList)
  if isShopShowBeforeUnlock == false and not JumpManager:Jump2DynShopValidate(argList) then
    return
  end
  local fromWhere = eBaseWinFromWhere.home
  local hideWinList
  if isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({
        [UIWindowTypeID.TopStatus] = true
      })
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  local shopId, shopDataId, shopPageId
  if argList ~= nil then
    shopId = argList[1]
    shopDataId = argList[2]
    shopPageId = argList[3]
  end
  local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
  if shopWin ~= nil then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.ShopMain, false)
    if isShopShowBeforeUnlock then
      if shopId == nil then
        shopWin:InitShopMainBeforeUnlock()
      else
        shopWin:InitShopMainBeforeUnlock(shopId, shopDataId, shopPageId)
      end
    elseif shopId == nil then
      shopWin:InitShop()
    else
      shopWin:InitShop(shopId, shopDataId, shopPageId)
    end
    return
  end
  local jumpCorverArgs = {
    hideWinList = hideWinList,
    befroeJumpCouldUseItemJump = self:GetBefroeJumpCouldUseItemJump(jumpCorverArgs)
  }
  UIManager:ShowWindowAsync(UIWindowTypeID.ShopMain, function(win)
    if win ~= nil then
      if isShopShowBeforeUnlock then
        if shopId == nil then
          win:InitShopMainBeforeUnlock()
        else
          win:InitShopMainBeforeUnlock(shopId, shopDataId, shopPageId)
        end
      elseif shopId == nil then
        win:InitShop()
      else
        win:InitShop(shopId, shopDataId, shopPageId)
      end
      win.jumpCorverArgs = jumpCorverArgs
      local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
      if homeWindow ~= nil and not isCoverJump then
        homeWindow:OpenOtherWin()
      end
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
    end
  end, nil, fromWhere)
end

function JumpManager:Jump2ShopBaseValidate()
  return true
end

function JumpManager:Jump2StrategyOverview(jumpOverCallback, argList)
  local sectorId = argList ~= nil and argList[1] or nil
  local buildId = argList ~= nil and argList[2] or nil
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController)
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.SectorEntrance)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.main)
      sectorController.addCtrl:OpenSectorSO(sectorId, buildId)
    end
  else
    local Home = UIManager:GetWindow(UIWindowTypeID.Home)
    Home.enterSectorJumpCallback = BindCallback(self, function()
      local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
      if sectorController == nil then
        error("can't get sectorController")
        return
      end
      local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
      if sectorEntrance ~= nil then
        sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.main)
        sectorController.addCtrl:OpenSectorSO(sectorId, buildId)
      end
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
    end)
    Home.homeRightNode:OnClickEpBtn()
  end
end

function JumpManager:Jump2StrategyOverviewValidate(argList)
  local isAllow = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding)
  if not isAllow then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding, true)
  end
  if argList ~= nil and 0 < #argList then
    local sectorId = argList[1]
    isAllow = PlayerDataCenter.sectorStage:IsSectorUnlock(sectorId)
    if not isAllow then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Sector_Locked))
    end
  end
  return isAllow
end

function JumpManager:Jump2OasisBuilding(jumpOverCallback, argList)
  local buildId = argList[1]
  local oasisController = ControllerManager:GetController(ControllerTypeId.OasisController, true)
  if oasisController.buildingItems[buildId] == nil then
    self:Jump2Oasis(jumpOverCallback)
    return
  end
  local Oasis = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if Oasis ~= nil then
    oasisController:BuildingUpgrade(buildId)
    return
  else
    local Home = UIManager:GetWindow(UIWindowTypeID.Home)
    if Home == nil then
      return
    end
    if Home.sideWin ~= nil then
      Home.sideWin:Delete()
      Home.sideWin = nil
    end
    oasisController:InjectJumpEvent(function()
      oasisController.selectBuiltId = nil
      oasisController:BuildingUpgrade(buildId, true)
    end)
    Home.homeRightNode:OnClickOasisBtn()
    oasisController.selectBuiltId = buildId
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end
end

function JumpManager:Jump2OasisBuildingValidate(argList)
  local isOasisUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Building)
  if not isOasisUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Building, true)
    return false
  end
  return true
end

function JumpManager:Jump2SectorFragDungeon(jumpOverCallback, argList)
  local heroId
  if argList[1] ~= 0 and PlayerDataCenter.heroDic[argList[1]] ~= nil then
    heroId = argList[1]
  end
  self:RecordSectorJumpId(22)
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.SectorEntrance)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.res)
      sectorController.dungeonCtrl:OpenSectorPlayMode(eSectorEntrance.eEntranceType.frageDungeon, heroId)
    end
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can't get sectorController")
      return
    end
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.res)
      sectorController.dungeonCtrl:OpenSectorPlayMode(eSectorEntrance.eEntranceType.frageDungeon, heroId)
    end
    self:ClearSectorJumpId()
    self.isJumping = false
  end)
  Home.homeRightNode:OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  self.isJumping = true
end

function JumpManager:Jump2SectorFragDungeonValidate(argList, notShowMessage)
  local isFragDungeonUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship_sector_Ui)
  if not isFragDungeonUnlock then
    local unlockNotice = self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship_sector_Ui, true, notShowMessage)
    return false, unlockNotice
  end
  local heroId = argList[1]
  if heroId == nil then
    return true
  end
  local heroData = PlayerDataCenter.heroDic[heroId]
  if heroData == nil then
    return false
  end
  local frageDungeonData
  local DungeonData = require("Game.Dungeon.DungeonData")
  frageDungeonData = DungeonData.CreateDungeonData4Frage(nil, heroData)
  local isFrageUnlock = frageDungeonData:UnlockAndHasStageOpen()
  if not isFrageUnlock then
    local stageCfg = frageDungeonData:GetNewLockStage()
    local unlockNotice = CheckCondition.GetUnlockInfoLua(stageCfg.pre_condition, stageCfg.pre_para1, stageCfg.pre_para2)
    if not notShowMessage then
      local des = string.format(ConfigData:GetTipContent(TipContent.Jump_TargetFuncLocked), unlockNotice)
      cs_MessageCommon.ShowMessageTips(des)
    end
    return false, unlockNotice
  end
  return true
end

function JumpManager:Jump2SectorResourceDungeon(jumpOverCallback, argList)
  local typeID = argList[1]
  self:RecordSectorJumpId(11)
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.SectorEntrance)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.res)
      sectorController.dungeonCtrl:OpenSectorPlayMode(eSectorEntrance.eEntranceType.resDungeon, typeID)
    end
    return
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can't get sectorController")
      return
    end
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.res)
      sectorController.dungeonCtrl:OpenSectorPlayMode(eSectorEntrance.eEntranceType.resDungeon, typeID)
    end
    self:ClearSectorJumpId()
    self.isJumping = false
  end)
  Home.homeRightNode:OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  self.isJumping = true
end

function JumpManager:Jump2SectorResourceDungeonValidate(argList, notShowMessage)
  local isMatDungeonUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_MaterialDungeon)
  if not isMatDungeonUnlock then
    local unlockNotice = self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_MaterialDungeon, true, notShowMessage)
    return false, unlockNotice
  end
  local typeID = argList[1]
  if typeID == nil or ConfigData.material_dungeon[typeID] == nil then
    error("bad jump arg Jump2SectorFragDungeon typeID:" .. tostring(typeID))
    return false
  end
  local isSpecificDungeonUnlock = FunctionUnlockMgr:ValidateUnlock(typeID)
  if not isSpecificDungeonUnlock then
    local unlockNotice = self:__ShowCanotJumpMessage(typeID, true, notShowMessage)
    return false, unlockNotice
  end
  return true
end

function JumpManager:Jump2SectorATHDungeon(jumpOverCallback, argList)
  local typeID = argList[1]
  self:RecordSectorJumpId(13)
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.SectorEntrance)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.res)
      sectorController.dungeonCtrl:OpenSectorPlayMode(eSectorEntrance.eEntranceType.athDungeon, typeID)
    end
    return
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can't get sectorController")
      return
    end
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.res)
      sectorController.dungeonCtrl:OpenSectorPlayMode(eSectorEntrance.eEntranceType.athDungeon, typeID)
    end
    self:ClearSectorJumpId()
    self.isJumping = false
  end)
  Home.homeRightNode:OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  self.isJumping = true
end

function JumpManager:Jump2SectorATHDungeonValidate(argList, notShowMessage)
  local isATHDungeonUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_ATHDungeon)
  if not isATHDungeonUnlock then
    local unlockNotice = self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_ATHDungeon, true, notShowMessage)
    return false, unlockNotice
  end
  local typeID = argList[1]
  if typeID == nil or ConfigData.material_dungeon[typeID] == nil then
    error("bad jump arg Jump2SectorATHDungeon typeID:" .. tostring(typeID))
    return false
  end
  return true
end

function JumpManager:Jump2DynTask(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local hideWinList
  local fromWhere = eBaseWinFromWhere.home
  local taskWin = UIManager:GetWindow(UIWindowTypeID.Task)
  if (taskWin == nil or not taskWin.active) and isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({
        [UIWindowTypeID.TopStatus] = true
      })
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  local typeID
  if argList ~= nil then
    typeID = argList[1]
  end
  local taskController = ControllerManager:GetController(ControllerTypeId.Task, true)
  local jumpCorverArgs = {
    hideWinList = hideWinList,
    befroeJumpCouldUseItemJump = self:GetBefroeJumpCouldUseItemJump(jumpCorverArgs)
  }
  taskController:ShowTaskUI(typeID, fromWhere, function()
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWindow ~= nil and not isCoverJump then
      homeWindow:OpenOtherWin()
    end
    local taskWin = UIManager:GetWindow(UIWindowTypeID.Task)
    if taskWin ~= nil then
      taskWin.jumpCorverArgs = jumpCorverArgs
    end
  end)
end

function JumpManager:Jump2DynTaskValidate(argList)
  local isTaskUIUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi)
  if not isTaskUIUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi, true)
    return false
  end
  local taskController = ControllerManager:GetController(ControllerTypeId.Task, true)
  local typeID
  if argList ~= nil then
    typeID = argList[1]
  end
  if typeID == nil then
    return true
  end
  local PageGroupList = taskController:GetPageGroupList()
  for _, group in pairs(PageGroupList) do
    for _, typeId in pairs(group) do
      if typeID == typeId then
        return true
      end
    end
  end
  return false
end

function JumpManager:Jump2DynShop(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local fromWhere = eBaseWinFromWhere.home
  local hideWinList
  if isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({
        [UIWindowTypeID.TopStatus] = true
      })
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  local shopId, shopDataId, shopPageId
  if argList ~= nil then
    shopId = argList[1]
    shopDataId = argList[2]
    shopPageId = argList[3]
  end
  local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
  if shopWin ~= nil then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.ShopMain, false)
    if shopId == nil then
      shopWin:InitShop()
    else
      shopWin:InitShop(shopId, shopDataId, shopPageId)
    end
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  end
  local jumpCorverArgs = {
    hideWinList = hideWinList,
    befroeJumpCouldUseItemJump = self:GetBefroeJumpCouldUseItemJump(jumpCorverArgs)
  }
  UIManager:ShowWindowAsync(UIWindowTypeID.ShopMain, function(win)
    if win ~= nil then
      win.jumpCorverArgs = jumpCorverArgs
      if shopId == nil then
        win:InitShop()
      else
        win:InitShop(shopId, shopDataId, shopPageId)
      end
      local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
      if homeWindow ~= nil and not isCoverJump then
        homeWindow:OpenOtherWin()
      end
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
    end
  end, nil, fromWhere)
end

function JumpManager:Jump2DynShopValidate(argList, notShowMessage)
  local isShopUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
  if not isShopUnlock then
    local unlockNotice = self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Store, true, notShowMessage)
    return false, unlockNotice
  end
  local shopId = argList[1]
  if shopId == nil or ConfigData.shop[shopId] == nil then
    return false
  end
  local shopCfg = ConfigData.shop[shopId]
  if shopCfg.shop_type == ShopEnum.eShopType.MonthCard and shopCfg.shop_para[1] and not PlayerDataCenter.dailySignInData:GetIsMonthCardUnlock(shopCfg.shop_para[1]) then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(425))
    return false
  end
  local ShopController = ControllerManager:GetController(ControllerTypeId.Shop, true)
  local isUnlcok, unlockNotice = ShopController:ShopIsUnlock(shopId)
  return isUnlcok, unlockNotice
end

function JumpManager:Jump2DynShopBeforeUnlock(argList, notShowMessage)
  local shopId = argList[1]
  if shopId == nil or ConfigData.shop[shopId] == nil then
    return false
  end
  local ShopController = ControllerManager:GetController(ControllerTypeId.Shop, true)
  if not ShopController:ShopShowBeforeUnlock(shopId) then
    return false
  end
  local isUnlcok, unlockNotice = ShopController:ShopIsUnlock(shopId)
  local isShopUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
  if isUnlcok == true and isShopUnlock == false then
    return true
  else
    return false
  end
end

function JumpManager:Jump2DynSectorLevel(jumpOverCallback, argList)
  local sectorId, isActId, afterEnterLevelFunc, afterLoadCallback, activityFrameData
  local lastPlayData = LastPlayData.New()
  local stageCfg
  if argList ~= nil then
    isActId = argList[2]
    afterEnterLevelFunc = argList[3]
    afterLoadCallback = argList[4]
    local autoStageId = argList[5]
    stageCfg = autoStageId ~= nil and ConfigData.sector_stage[autoStageId] or nil
    if isActId then
      activityFrameData = argList[1]
    else
      sectorId = argList[1]
    end
  end
  if sectorId == nil and activityFrameData == nil then
    JumpManager:Jump2Sector(jumpOverCallback)
    return
  end
  if not isActId then
    local actType, actId, actFrameData = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(sectorId)
    if actId ~= nil then
      isActId = true
      activityFrameData = actFrameData
      lastPlayData:SetLPDSectorId(sectorId)
    end
  end
  if not isActId then
    self:RecordSectorJumpId(sectorId * 10)
  else
    self:RecordSectorJumpId(0)
  end
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.SectorEntrance)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if not isActId then
      sectorController.mainSctCtrl:OnSectorItemClicked(sectorId, nil, stageCfg)
    else
      lastPlayData:SetLPDActSceneLoadoverCallback(afterLoadCallback)
      SectorEntranceHandler:DealOpenAct(activityFrameData, lastPlayData)
    end
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    if afterEnterLevelFunc ~= nil then
      afterEnterLevelFunc()
    end
    return
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can't get sectorController")
      return
    end
    if not isActId then
      sectorController.mainSctCtrl:OnSectorItemClicked(sectorId)
    else
      lastPlayData:SetLPDActSceneLoadoverCallback(afterLoadCallback)
      SectorEntranceHandler:DealOpenAct(activityFrameData, lastPlayData)
    end
    if afterEnterLevelFunc ~= nil then
      afterEnterLevelFunc()
    end
    self:ClearSectorJumpId()
    self.isJumping = false
  end)
  Home.homeRightNode:OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  self.isJumping = true
end

function JumpManager:Jump2DynSectorLevelValidate(argList)
  if argList == nil or argList[1] == nil then
    return false
  end
  local sectorId, isActId, afterEnterLevelFunc, afterLoadCallback, activityFrameData
  if argList ~= nil then
    isActId = argList[2]
    afterEnterLevelFunc = argList[3]
    afterLoadCallback = argList[4]
    if isActId then
      activityFrameData = argList[1]
    else
      sectorId = argList[1]
    end
  end
  if sectorId ~= nil then
    if not PlayerDataCenter.sectorEntranceHandler:CheckSectorValid(sectorId) then
      return false
    end
    local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
    if not SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
      return false
    end
  end
  return true
end

function JumpManager:Jump2DynStage(jumpOverCallback, argList)
  local stageId, afterEnterLevelFunc, afterLoadCallback, levelCfg, sectorId, activityFrameData
  if argList ~= nil then
    stageId = argList[1]
    afterEnterLevelFunc = argList[2]
    afterLoadCallback = argList[3]
  end
  if stageId == nil then
    error("stage Jump fail, stageId == nil!")
    JumpManager:Jump2Sector(jumpOverCallback)
    return
  end
  levelCfg = PlayerDataCenter.sectorEntranceHandler:GetMainStageCfg(stageId)
  sectorId = levelCfg.sector
  if levelCfg == nil or sectorId == nil then
    error("stage Jump fail, levelCfg or sectorId == nil! stageId = " .. tostring(stageId))
    JumpManager:Jump2Sector(jumpOverCallback)
    return
  end
  local actType, actId, actFrameData = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(sectorId)
  if actId ~= nil then
    error("can not use stageJump in activityJump! sectorId = " .. tostring(sectorId))
    return
  end
  self:RecordSectorJumpId(sectorId * 10)
  
  local function realJump()
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can't get sectorController")
      return
    end
    sectorController.mainSctCtrl:OnSectorItemClicked(sectorId, levelCfg.difficulty, levelCfg)
  end
  
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.SectorEntrance)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    realJump()
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    if afterEnterLevelFunc ~= nil then
      afterEnterLevelFunc()
    end
    return
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  if Home == nil then
    error("stageJump fail, HomeUI == nil!")
    return
  end
  Home.enterSectorJumpCallback = BindCallback(self, function()
    realJump()
    if afterEnterLevelFunc ~= nil then
      afterEnterLevelFunc()
    end
    self:ClearSectorJumpId()
    self.isJumping = false
  end)
  Home.homeRightNode:OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  self.isJumping = true
end

function JumpManager:Jump2DynStageValidate(argList)
  if argList == nil or argList[1] == nil then
    return false
  end
  return true
end

function JumpManager:Jump2DynLottery(jumpOverCallback, argList)
  local poolId, groupId
  if argList ~= nil then
    poolId = argList[1]
    groupId = argList[2]
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.homeRightNode:OnClickLotteryBtn(poolId, groupId)
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

function JumpManager:Jump2DynLotteryValidate(argList)
  local isLotteryUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Lottery)
  if not isLotteryUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Lottery, true)
    return false
  end
  return true
end

function JumpManager:_TryRecordActEntered(activityFrameData)
  if activityFrameData == nil then
    return
  end
  local actFrameId = activityFrameData:GetActivityFrameId()
  if ConfigData.activity_general.autoEnterActIdDic[actFrameId] == nil then
    return
  end
  if PlayerDataCenter.gameSettingData:IsActEntered(actFrameId) then
    return
  end
  PlayerDataCenter.gameSettingData:SetActEntered(actFrameId)
  NetworkManager:GetNetwork(NetworkTypeID.Object):ReqRecordActLongIdEnter(actFrameId)
end

function JumpManager:Jump2DynActivity(jumpOverCallbackParam, argList)
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local activityId, category, actSpecialJumpId, isNeedActInRunning
  local lastPlayData = LastPlayData.New()
  if argList ~= nil then
    activityId = argList[1]
    category = argList[2]
    actSpecialJumpId = argList[3]
    isNeedActInRunning = argList[4] == 1
  end
  local activityFrameData
  if 0 < (activityId or 0) then
    activityFrameData = activityFrameCtrl:GetActivityFrameData(activityId)
    category = activityFrameData:GetEnterType()
    if activityFrameData ~= nil and isNeedActInRunning and not activityFrameData:IsInRuningState() then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(6033))
      return
    end
  end
  
  local function jumpOverCallback()
    self:_TryRecordActEntered(activityFrameData)
    if jumpOverCallbackParam ~= nil then
      jumpOverCallbackParam()
    end
  end
  
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.SectorII and actSpecialJumpId ~= nil and actSpecialJumpId == 1 then
    self:Jump2DynSectorLevel(jumpOverCallback, {
      activityFrameData,
      true,
      function()
        local win = UIManager:GetWindow(UIWindowTypeID.Win21SectorBar)
        if win ~= nil then
          win:__OnClickOpenTech()
        end
      end
    })
    return
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.HeroGrow then
    local sectorICfg = ConfigData.activity_hero[activityFrameData.actId]
    if sectorICfg ~= nil then
      local arg = {activityFrameData, true}
      self:Jump2DynSectorLevel(jumpOverCallback, arg)
    end
    return
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.WhiteDay then
    local function AfterLoadCallback()
      local wdWin = UIManager:GetWindow(UIWindowTypeID.WhiteDay)
      
      if wdWin then
        wdWin:SpecialJump2WD(actSpecialJumpId)
      end
    end
    
    if not activityFrameData:IsActivityRunningTimeout() then
      self:__BeforeDirectJump()
    end
    lastPlayData:SetLPDActSceneLoadoverCallback(AfterLoadCallback)
    SectorEntranceHandler:DealOpenAct(activityFrameData, lastPlayData)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  end
  
  local function NormalEnterLobby(activityFrameData, AfterLoadCallback)
    local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
    if actLbCtrl and actLbCtrl:GetActLbActId() ~= activityFrameData:GetActivityFrameId() then
      self:__BeforeDirectJump()
    else
      self:__BeforeDirectJump(true, true)
    end
    lastPlayData:SetLPDActSceneLoadoverCallback(function()
      if AfterLoadCallback ~= nil then
        AfterLoadCallback()
      end
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
    end)
    SectorEntranceHandler:DealOpenAct(activityFrameData, lastPlayData)
  end
  
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.Spring then
    local function AfterLoadCallback()
      if actSpecialJumpId ~= nil and actSpecialJumpId ~= 0 then
        local springCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring)
        
        springCtrl:Spirng23OpenObj(actSpecialJumpId)
      end
    end
    
    NormalEnterLobby(activityFrameData, AfterLoadCallback)
    return
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.Winter23 then
    local function AfterLoadCallback()
      if actSpecialJumpId ~= nil and actSpecialJumpId ~= 0 then
        local winter23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
        
        winter23Ctrl:OpenWinter23Obj(actSpecialJumpId)
      end
    end
    
    NormalEnterLobby(activityFrameData, AfterLoadCallback)
    return
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.Season then
    local function AfterLoadCallback()
      local seasonCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySeason)
      
      if seasonCtrl ~= nil then
        seasonCtrl:OpenSeasonObj(actSpecialJumpId)
      end
    end
    
    NormalEnterLobby(activityFrameData, AfterLoadCallback)
    return
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.ActivityCarnival23 then
    local function AfterLoadCallback()
      local carnival23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23)
      
      if carnival23Ctrl ~= nil then
        carnival23Ctrl:OpenCarnival23Obj(actSpecialJumpId)
      end
    end
    
    NormalEnterLobby(activityFrameData, AfterLoadCallback)
    return
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.Anniversary23 then
    local function AfterLoadCallback()
      local anniversary23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityAnniversary23)
      
      if anniversary23Ctrl ~= nil then
        anniversary23Ctrl:OpenAnniversary23Obj(actSpecialJumpId)
      end
    end
    
    NormalEnterLobby(activityFrameData, AfterLoadCallback)
    return
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.SteinsGate then
    local function AfterLoadCallback()
      local steinsGate23Ctrl = ControllerManager:GetController(ControllerTypeId.Activity23SteinsGate)
      
      if steinsGate23Ctrl ~= nil then
        steinsGate23Ctrl:OpenSteinsGate23Obj(actSpecialJumpId)
      end
    end
    
    NormalEnterLobby(activityFrameData, AfterLoadCallback)
    return
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.Spring24 then
    local function AfterLoadCallback()
      local spring24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivitySpring24)
      
      if spring24Ctrl ~= nil then
        spring24Ctrl:OpenActLobbyObj(actSpecialJumpId)
      end
    end
    
    NormalEnterLobby(activityFrameData, AfterLoadCallback)
    return
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.Carnival24 then
    local function AfterLoadCallback()
      local carnival24Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival24)
      
      if carnival24Ctrl ~= nil then
        carnival24Ctrl:OpenActLobbyObj(actSpecialJumpId)
      end
    end
    
    NormalEnterLobby(activityFrameData, AfterLoadCallback)
    return
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.ActAnniversary24 then
    local function AfterLoadCallback()
      local anni24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
      
      if anni24Ctrl ~= nil then
        anni24Ctrl:OpenActLobbyObj(actSpecialJumpId)
      end
    end
    
    NormalEnterLobby(activityFrameData, AfterLoadCallback)
    return
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.Invitation then
    local invitationWin = UIManager:GetWindow(UIWindowTypeID.EventInvitation)
    if invitationWin ~= nil then
      invitationWin:ClickInvitationPage(actSpecialJumpId)
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
      return
    end
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.HeroGrowV3 then
    local function afterLoadCallback()
      local invitationWin = UIManager:GetWindow(UIWindowTypeID.CharDunVer3)
      
      if invitationWin ~= nil then
        invitationWin:CharDunV3JumpTarget(actSpecialJumpId)
      end
    end
    
    self:Jump2DynSectorLevel(jumpOverCallback, {
      activityFrameData,
      true,
      nil,
      afterLoadCallback
    })
    return
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.DeliverySimulator then
    local function AfterLoadCallback()
    end
    
    NormalEnterLobby(activityFrameData)
    return
  end
  if activityFrameData ~= nil and SectorActivityType[activityFrameData.actCat] then
    self:Jump2DynSectorLevel(jumpOverCallback, {activityFrameData, true})
    return
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.HistoryTinyGame then
    local historyTinyGameCtrl = ControllerManager:GetController(ControllerTypeId.HistoryTinyGameActivity)
    if historyTinyGameCtrl ~= nil then
      historyTinyGameCtrl:TryOpenHistoryTinyGame(activityFrameData:GetActId(), nil, true)
    end
    return
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.BattlePass then
    local bpData = PlayerDataCenter.battlepassData:GetBattlePassByActId(activityFrameData:GetActId())
    if bpData ~= nil then
      do
        local bpCfg = bpData:GetPassCfg()
        if bpCfg.purpose_type == BattlePassEnum.PurposeType.Activity and bpData:IsBattlePassValid() then
          UIManager:ShowWindowAsync(UIWindowTypeID.BattlePassActivity, function(window)
            window:InitBattlePassUI(bpData:GetActId())
          end)
          return
        end
      end
    end
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.FlipCard then
    local lobbyWin = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
    if lobbyWin ~= nil then
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain)
      local flipCardCtrl = ControllerManager:GetController(ControllerTypeId.FlipCard)
      if flipCardCtrl == nil then
        return
      end
      flipCardCtrl:ShowFlipCardMainByActId(activityFrameData:GetActId())
      return
    end
  end
  if (category or 0) == 0 or not activityFrameCtrl:IsHaveShowByEnterType(category) then
    category = activityFrameCtrl:GetAutoJumpTargetActivity()
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  if Home ~= nil then
    Home.homeLeftNode:OnClickActivity(category, activityId)
  end
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

function JumpManager:Jump2DynActivityValidate(argList, withoutMessage)
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  if activityFrameCtrl == nil then
    return false
  end
  if argList ~= nil and 0 < (argList[1] or 0) then
    local activityId = argList[1]
    local activityFrameData = activityFrameCtrl:GetActivityFrameData(activityId)
    if activityFrameData == nil then
      return false
    end
    if not activityFrameData:GetCouldShowActivity() then
      if activityFrameData:GetIsActivityLocked() and not withoutMessage then
        local des = activityFrameData:GetLockTip()
        cs_MessageCommon.ShowMessageTips(des)
      end
      return false
    end
  else
    local couldJumpEnterType = activityFrameCtrl:GetIsHaveUnlockedActivity()
    if couldJumpEnterType == nil then
      return false
    end
  end
  return true
end

function JumpManager:IsThisActivityJump2Home(argList)
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local activityId = argList[1]
  local activityFrameData = activityFrameCtrl:GetActivityFrameData(activityId)
  if activityFrameData == nil then
    return true
  end
  local actCat = activityFrameData.actCat
  local sectorAct = SectorActivityType[actCat] and ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  local notNeedBackAct = NotNeedBack2HomeAct[actCat]
  return not sectorAct and not notNeedBackAct
end

function JumpManager:Jump2DynActivityBlockHome(argList)
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local activityId, category, actSpecialJumpId, isNeedActInRunning
  local lastPlayData = LastPlayData.New()
  if argList ~= nil then
    activityId = argList[1]
    category = argList[2]
    actSpecialJumpId = argList[3]
    isNeedActInRunning = argList[4] == 1
  end
  local activityFrameData
  if 0 < (activityId or 0) then
    activityFrameData = activityFrameCtrl:GetActivityFrameData(activityId)
    category = activityFrameData:GetEnterType()
    if activityFrameData ~= nil and isNeedActInRunning and not activityFrameData:IsInRuningState() then
      return false
    end
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.Invitation then
    local invitationWin = UIManager:GetWindow(UIWindowTypeID.EventInvitation)
    if invitationWin ~= nil then
      return true
    end
  end
  if activityFrameData ~= nil and activityFrameData.actCat == eActivityType.BattlePass then
    local lobbyWin = UIManager:GetWindow(UIWindowTypeID.ActLobbyMain)
    if lobbyWin ~= nil then
      UIUtil.ReturnUntil2Marker(UIWindowTypeID.ActLobbyMain)
      return true
    end
  end
  return false
end

function JumpManager:DirectShowShop(beforeJumpCallback, jumpOverCallback, shopId, unCtrlTopbtn)
  local argList = {shopId}
  local isShopShowBeforeUnlock = JumpManager:Jump2DynShopBeforeUnlock(argList)
  if isShopShowBeforeUnlock == false and not JumpManager:Jump2DynShopValidate(argList) then
    return
  end
  if beforeJumpCallback ~= nil then
    beforeJumpCallback()
  end
  local fromWhere = eBaseWinFromWhere.jumpCorver
  local hideWinList = UIManager:HideAllWindow({
    [UIWindowTypeID.TopStatus] = true
  })
  local jumpCorverArgs = {
    hideWinList = hideWinList,
    befroeJumpCouldUseItemJump = self:GetBefroeJumpCouldUseItemJump(nil)
  }
  UIManager:ShowWindowAsync(UIWindowTypeID.ShopMain, function(win)
    if win == nil then
      return
    end
    if isShopShowBeforeUnlock then
      win:InitShopMainBeforeUnlock(shopId)
    else
      win:InitShop(shopId)
    end
    win.jumpCorverArgs = jumpCorverArgs
    if not unCtrlTopbtn then
      UIUtil.SetTopStatusBtnShow(false, false)
    end
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end, nil, fromWhere)
end

function JumpManager:Jump2DynWarehouseValidate(argList)
  return FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Backpack_ui)
end

function JumpManager:Jump2DynWarehouse(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local hideWinList
  local fromWhere = eBaseWinFromWhere.home
  local wareHouseWin = UIManager:GetWindow(UIWindowTypeID.Warehouse)
  if (wareHouseWin == nil or not wareHouseWin.active) and isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({
        [UIWindowTypeID.TopStatus] = true
      })
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  local itemId = argList ~= nil and argList[1] or nil
  local openType = argList ~= nil and argList[2] or nil
  local jumpCorverArgs = {
    hideWinList = hideWinList,
    befroeJumpCouldUseItemJump = self:GetBefroeJumpCouldUseItemJump(jumpCorverArgs)
  }
  UIManager:ShowWindowAsync(UIWindowTypeID.Warehouse, function(window)
    local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWindow ~= nil and not isCoverJump then
      homeWindow:OpenOtherWin()
    end
    window:InitWarehouse(itemId, openType)
    window.jumpCorverArgs = jumpCorverArgs
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end, nil, fromWhere)
end

function JumpManager:Jump2SettingValidate()
  return true
end

function JumpManager:Jump2Setting(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local oringLayoutLevel = UIWindowGlobalConfig[UIWindowTypeID.Setting].LayoutLevel
  UIWindowGlobalConfig[UIWindowTypeID.Setting].LayoutLevel = EUILayoutLevel.OverHigh
  UIManager:ShowWindowAsync(UIWindowTypeID.Setting, function(win)
    if win ~= nil then
      win.ui.background.enabled = false
      win:SetFromWhichUI(nil)
      local topWin = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      local isHaveTopStatus = topWin ~= nil and topWin.active
      if isHaveTopStatus then
        UIUtil.HideTopStatus()
      end
      win:SetUIMailHideCallback(function()
        if isHaveTopStatus then
          UIUtil.ReShowTopStatus()
        end
      end)
      win:InitSettingByFrom()
      UIWindowGlobalConfig[UIWindowTypeID.Setting].LayoutLevel = oringLayoutLevel
    end
  end)
end

function JumpManager:Jump2UserCenterValidate()
  return true
end

function JumpManager:Jump2UserCenter(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  if not CS.MicaSDKManager.Instance:IsUseSdk() then
    warn("当前未使用SDK，无法转跳到用户中心")
  end
  CS.MicaSDKManager.Instance:OpenUserCenter()
end

function JumpManager:Jump2UserInfoPageValidate()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CommanderInformation)
  if not isUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_CommanderInformation, true)
  end
  return isUnlock
end

function JumpManager:Jump2UserInfoPage(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local hideWinList
  local fromWhere = eBaseWinFromWhere.home
  local userInfoWin = UIManager:GetWindow(UIWindowTypeID.UserInfo)
  if (userInfoWin == nil or not userInfoWin.active) and isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({
        [UIWindowTypeID.TopStatus] = true
      })
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  if userInfoWin ~= nil then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.UserInfo)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  end
  local jumpCorverArgs = {
    hideWinList = hideWinList,
    befroeJumpCouldUseItemJump = self:GetBefroeJumpCouldUseItemJump(jumpCorverArgs)
  }
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfo, function(win)
    if win ~= nil then
      local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
      if homeWindow ~= nil and not isCoverJump then
        homeWindow:OpenOtherWin()
      end
      win.jumpCorverArgs = jumpCorverArgs
      win:InitUserInfo()
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
    end
  end, nil, fromWhere)
end

function JumpManager:Jump2WinterActivityTech(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  error("废弃,请使用动态活动跳转+参数的形式进行内部的控制")
  return
end

function JumpManager:Jump2WinterActivityTechValidate()
  return true
end

function JumpManager:Jump2DungeonTower(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  self:RecordSectorJumpId(27)
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.SectorEntrance)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.challenge)
      sectorController.blackHoleCtrl:OpenSectorPlayMode()
    end
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can't get sectorController")
      return
    end
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.challenge)
      sectorController.blackHoleCtrl:OpenSectorPlayMode()
    end
    self:ClearSectorJumpId()
    self.isJumping = false
  end)
  Home.homeRightNode:OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  self.isJumping = true
end

function JumpManager:Jump2DungeonTowerValidate()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DungeonTower) then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_DungeonTower, true)
    return false
  end
  return true
end

function JumpManager:Jump2HexaDungeonTower(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.SectorEntrance)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.challenge)
      sectorController.sixHeroTowerCtrl:OpenSectorPlayMode()
    end
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can't get sectorController")
      return
    end
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.challenge)
      sectorController.sixHeroTowerCtrl:OpenSectorPlayMode()
    end
    self:ClearSectorJumpId()
    self.isJumping = false
  end)
  Home.homeRightNode:OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  self.isJumping = true
end

function JumpManager:Jump2HexaDungeonTowerValidate()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SixHeroTower) then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_SixHeroTower, true)
    return false
  end
  return true
end

function JumpManager:Jump2SctorActivity(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.SectorEntrance)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.act)
    end
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can't get sectorController")
      return
    end
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.act)
    end
    self:ClearSectorJumpId()
    self.isJumping = false
  end)
  Home.homeRightNode:OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  self.isJumping = true
end

function JumpManager:Jump2SctorActivityValidate()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_LargeActivity) then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_LargeActivity, true)
    return false
  end
  return true
end

function JumpManager:Jump2Endless(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local endlessCfg = PlayerDataCenter.infinityData:GetCanCompleteInfinityMinPower()
  if endlessCfg == nil then
    endlessCfg = PlayerDataCenter.infinityData:GetLastInfinityCfg()
  end
  if endlessCfg == nil then
    local nowCompleteIndex = PlayerDataCenter.infinityData.sectorCompleteDic[1]
    endlessCfg = ConfigData.endless[1][nowCompleteIndex]
  end
  self:Jump2DynStage(jumpOverCallback, {
    endlessCfg and endlessCfg.id or nil
  })
end

function JumpManager:Jump2EndlessValidate()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Endless) then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Endless, true)
    return false
  end
  return true
end

function JumpManager:Jump2ChatSystem(jumpOverCallback, argList)
  local userChatData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserChatData)
  local chatPageId = argList[1]
  local chatBoardId = argList[2]
  local chatBoard
  if chatPageId ~= nil and chatBoardId ~= nil then
    chatBoard = userChatData:GetChatBoard(chatPageId, chatBoardId)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ChatSystem, function(win)
    if win == nil then
      return
    end
    win:InitChatSystem(chatPageId, chatBoard)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end)
end

function JumpManager:Jump2ChatSystemValidate()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_newchat) then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_newchat, true)
    return false
  end
  return true
end

function JumpManager:Jump2DynCareerStO(jumpOverCallback, argList)
  local buildId = argList ~= nil and argList[1] or nil
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.main)
      sectorController.addCtrl:OpenSectorSO(buildId)
    end
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can't get sectorController")
      return
    end
    local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
    if sectorEntrance ~= nil then
      sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.main)
      sectorController.addCtrl:OpenSectorSO(buildId)
    end
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end)
  Home.homeRightNode:OnClickEpBtn()
end

function JumpManager:Jump2DynCareerStOValidate(argList)
  local isAllow = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1)
  if not isAllow then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1, true)
  end
  return isAllow
end

function JumpManager:Jump2HandBook(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local targetType = argList ~= nil and argList[1] or nil
  local targetSubType = argList ~= nil and argList[2] or nil
  local handBookCtrl = ControllerManager:GetController(ControllerTypeId.HandBook, true)
  local hideWinList
  local fromWhere = eBaseWinFromWhere.home
  if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.HandBookMain) then
    UIUtil.ReturnUntil2Marker(UIWindowTypeID.HandBookMain)
    handBookCtrl:HandleHandBookJumpArg(targetType, targetSubType)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  elseif isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({
        [UIWindowTypeID.TopStatus] = true
      })
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  local jumpCorverArgs = {
    hideWinList = hideWinList,
    befroeJumpCouldUseItemJump = self:GetBefroeJumpCouldUseItemJump(jumpCorverArgs)
  }
  handBookCtrl:OpenHandBookMain(fromWhere, function()
    local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWindow ~= nil and not isCoverJump then
      homeWindow:OpenOtherWin()
    end
    local win = UIManager:GetWindow(UIWindowTypeID.HandBookMain)
    win.jumpCorverArgs = jumpCorverArgs
    handBookCtrl:HandleHandBookJumpArg(targetType, targetSubType)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end)
end

function JumpManager:Jump2HandBookValidate()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HandBook) then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_HandBook, true)
    return false
  end
  return true
end

function JumpManager:Jump2Fairy(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local targetType = argList ~= nil and argList[1] or nil
  local FairyCtrl = ControllerManager:GetController(ControllerTypeId.Fairy, true)
  if UIUtil.CheckIsHaveSpecialMarker(UIWindowTypeID.FairyLobbyMain) then
    FairyCtrl:HandleFairyJumpArg(targetType)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return
  else
    self:__BeforeDirectJump()
    FairyCtrl:EnterFairyLobby(function()
      FairyCtrl:HandleFairyJumpArg(targetType)
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
    end)
  end
end

function JumpManager:Jump2FairyValidate()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_fairy) then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_fairy, true)
    return false
  end
  return true
end

function JumpManager:Jump2VowSystem(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local heroId = argList ~= nil and argList[1] or nil
  local vowSystemCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
  vowSystemCtrl:LoadEmptyVowScene(jumpOverCallback)
end

function JumpManager:Jump2VowSystemValidate()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_vow) then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_vow, true)
    return false
  end
  return true
end

function JumpManager:Jump2Milestone(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local msData = PlayerDataCenter.inforData:GetMilestoneData()
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI:OpenOtherWin()
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MailStoneMian, function(win)
    if win == nil then
      return
    end
    win:SetFromWhichUI(eBaseWinFromWhere.home)
    win:InitMilestoneMain(msData)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end)
end

function JumpManager:Jump2MilestoneValidate()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_MileStones)
  if not isUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_CommanderInformation, true)
    return isUnlock
  else
    return isUnlock
  end
end

function JumpManager:Jump2Formation(jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  if fmtCtrl ~= nil then
    fmtCtrl:EnterFormationScene()
  end
end

function JumpManager:Jump2FormationValidate()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_main_formation)
  if not isUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_main_formation, true)
    return isUnlock
  else
    return isUnlock
  end
end

function JumpManager:GetBefroeJumpCouldUseItemJump(jumpCorverArgs)
  if jumpCorverArgs ~= nil and jumpCorverArgs.befroeJumpCouldUseItemJump ~= nil then
    return jumpCorverArgs.befroeJumpCouldUseItemJump
  end
  return self.couldUseItemJump
end

function JumpManager:CleanJumpManager()
  self.couldUseItemJump = false
  self.isJumping = false
end

JumpManager:Init()
JumpManager.ValidateFuncArray = ValidateFuncArray
return JumpManager
