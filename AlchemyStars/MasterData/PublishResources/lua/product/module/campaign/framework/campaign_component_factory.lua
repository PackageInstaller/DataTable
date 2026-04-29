_class("CampaignComponentFactory", Object)
CampaignComponentFactory = CampaignComponentFactory

function CampaignComponentFactory:Constructor()
  self.m_campaign_com_module = nil
  self.m_component_type_dict = {}
end

function CampaignComponentFactory:RegistorCampaignComponent(a_component_type, a_type)
  local component_type = self.m_component_type_dict[a_component_type]
  if nil ~= component_type then
    Log.error("[Campaign][CampaignComponentFactory] RegistorCampaignComponent type is exist! a_component_type:", a_component_type, ", a_type:", a_type)
    return
  end
  self.m_component_type_dict[a_component_type] = a_type
  return
end

function CampaignComponentFactory:CreateCampaignComponent(a_component_type, a_load_info)
  local type = self.m_component_type_dict[a_component_type]
  if not type then
    Log.error("[Campaign][CampaignComponentFactory] CreateCampaignComponent type is not exist! a_component_type:", a_component_type)
    return
  end
  local component_obj = type:New()
  if not component_obj then
    Log.error("[Campaign][CampaignComponentFactory] CreateCampaignComponent CreateInstance Error! a_component_type:", a_component_type, ", a_type:", type)
    return
  end
  component_obj:Init(self.m_campaign_com_module, a_load_info)
  return component_obj
end

function CampaignComponentFactory:InitComponentRegister(a_module)
  self.m_campaign_com_module = a_module
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_COMMON_BASE, CommonBaseComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_DEMO, DemoComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_EXCHANGE_ITEM, ExchangeItemComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_PERSON_PROGESS, PersonProgressComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_CUMULATIVE_LOGIN, CumulativeLoginComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_LINE_MISSION, LineMissionComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_TREE_MISSION, TreeMissionComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_RES_HELP, ResHelpComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_BACK, PlayerBackComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_SUM_II_MISSION, SummerIIMissionComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_QUEST, CampaignQuestComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_LOTTERY, LotteryComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_STORY, StoryComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_MINI_GAME, CampaignMiniGameComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_LV_REWARD, LVRewardComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_BUY_GIFT, BuyGiftComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_ACTION_POINT, ActionPointComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_BLACKFIST, BlackfistComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_TIME_LOGIN, TimeLoginComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_RANDOM_LOTTERY, RandomLotteryComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_BUSINESS, BusinessComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_SEASON_MAZE, SeasonMazeComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_SMELT_ITEM, SmeltItemComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_SEASON, SeasonMissionComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_HOMELAND_TASK, HomelandTaskComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_MINI_MAIL, MiniMailComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_BATTLEFIELD, BattlefieldComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_REBUILD, CampaignBuildComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_CombatSimulator, CombatSimulatorComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_SUBJECT, CampaignSubjectComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_ENTRUST, EntrustComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_REWARD_DOUBLE, RewardDoubleComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_CHALL_MISSION, ChallengeMissionComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_DAILY_MISSION, DailyMissionComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_POWER2ITEM, CampaignPower2itemComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_SENIOR_SKIN, SeniorSkinComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_CYCLE_QUEST, CycleQuestComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_CHESS, ChessComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_MISSION_DROP, CampaignMissionDropComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_MINI_GAME_EXPLORE, ExploreMinigameComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_TIME_REWARD, TimeRewardComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_POINT_PROGRESS, PointProgressComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_AVG_STORY, AvgMinigameComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_IDOL_GAME, IdolMiniGameComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_BLOODSUCKER, BloodsuckerComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_NEWYEAR_DINNER, NewYearDinnerMiniGameComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_POST_STATION_GAME, PostStationComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_DIFFICULTY_MISSION, DifficultyMissionComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_BOUNCE_MISSION, BounceMissionComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_DETECTIVE, DetectiveComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_POPSTAR_MISSION, PopStarComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_TURNCARD, TurnCardComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_MULTILINE_MISSION, MultiLineMissionComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_EIGHT_PETS_MISSION, EightPetsMissionComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_SIMULATION_OPERATION, SimulationOperation)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_DISPATCH, DispatchComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_SURVEY, SurveyComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_TACIT_TEST, TacitTestComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_VOTE, VoteComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_A_SHEEP, ASheepComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_LUCK_LAND, LuckLandComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_TALENT_TREE, TalentTreeComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COLLECT_CARD, CollectCardComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_COM_PERFECT_PUZZLE, PerfectPuzzleComponent)
  self:RegistorCampaignComponent(CampaignComType.E_CAMPAIGN_ALCHEMY, AlchemyComponent)
end
