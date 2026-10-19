using ACT.Battle;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.LogicQueue;
using ACT.Manager;
using ACT.MissionSystem;
using ACT.Model;
using ACT.Model.ChatBubbleModel;
using ACT.Model.Jump;
using ACT.Model.MissionModel;
using ACT.Sound;
using ACT.Sound.Management;
using ACT.UI;
using ACT.Utility;
using ACT.World.Bloodstain;
using Battle.LittleItemsModel;
using Fundamental;
using Runtime.Archive;
using Runtime.Battle.ChaseBattle;
using Runtime.Model;
using Runtime.Model.Condition;
using Runtime.Model.PowerModel;

namespace ACT;

internal class InitModelStepOperation : WorldLoadStepOperation
{
	internal override void OnStart()
	{
		Singleton<LoadManager>.CreateInstance();
		Singleton<GameLogicQueue>.CreateInstance();
		if (!Singleton<DropItemManager>.HasInstance())
		{
			Singleton<DropItemManager>.CreateInstance();
		}
		if (!Singleton<InteractiveDialogueManager>.HasInstance())
		{
			Singleton<InteractiveDialogueManager>.CreateInstance();
		}
		if (!Singleton<PropPickingManager>.HasInstance())
		{
			Singleton<PropPickingManager>.CreateInstance();
		}
		if (!Singleton<EntityUIManager>.HasInstance())
		{
			Singleton<EntityUIManager>.CreateInstance();
		}
		if (!Singleton<GameInputActionManager>.HasInstance())
		{
			Singleton<GameInputActionManager>.CreateInstance();
		}
		Model<CGModule>.CreateModel();
		Model<RoGueModel>.CreateModel();
		Model<RogueNewModel>.CreateModel();
		Model<SkinModel>.CreateModel();
		Singleton<ArchiveManager>.CreateInstance();
		Singleton<BGMManager>.CreateInstance();
		if (!Singleton<SystemUnlockManager>.HasInstance())
		{
			Singleton<SystemUnlockManager>.CreateInstance();
		}
		Singleton<MailboxCacheManager>.CreateInstance();
		Singleton<ChaseBattleManager>.CreateInstance();
		if (!Singleton<RedDotManager>.HasInstance())
		{
			Singleton<RedDotManager>.CreateInstance();
		}
		if (!Singleton<CharacterVoiceManager>.HasInstance())
		{
			Singleton<CharacterVoiceManager>.CreateInstance();
		}
		if (!Singleton<MissionManager>.HasInstance())
		{
			Singleton<MissionManager>.CreateInstance();
		}
		Model<LoadULipSyncBakeDataFileModel>.CreateModel();
		Model<PlayerGenderModel>.CreateModel();
		Model<JumpModel>.CreateModel();
		Model<ConditionModel>.CreateModel();
		Model<TrackModel>.CreateModel();
		Model<HandBookModel>.CreateModel();
		Model<MissionModel>.CreateModel();
		Model<MaterialTrackModel>.CreateModel();
		if (!Model<BloodstainModel>.HasInstance())
		{
			Model<BloodstainModel>.CreateModel();
		}
		Model<ErrorAckModel>.CreateModel();
		Model<CraftModel>.CreateModel();
		Model<CollectionModel>.CreateModel();
		Model<TrainingGroundModel>.CreateModel();
		if (!Model<AbyssModel>.HasInstance())
		{
			Model<AbyssModel>.CreateModel();
		}
		Model<CharacterTutorialModel>.CreateModel();
		if (!Model<TeamTeachingModel>.HasInstance())
		{
			Model<TeamTeachingModel>.CreateModel();
		}
		if (!Model<ChallengeTargetTrackerModel>.HasInstance())
		{
			Model<ChallengeTargetTrackerModel>.CreateModel();
		}
		Model<LittleItemModel>.CreateModel();
		Model<ServerPlayerPrefs>.CreateModel();
		Model<GamePlayerPrefs>.CreateModel();
		Model<CustomUIModel>.CreateModel();
		if (!Model<MonsterHandModel>.HasInstance())
		{
			Model<MonsterHandModel>.CreateModel();
		}
		Model<SNSModel>.CreateModel();
		Model<BloodBottleModel>.CreateModel();
		if (!Model<TempleModel>.HasInstance())
		{
			Model<TempleModel>.CreateModel();
		}
		Model<SubworldModel>.CreateModel();
		Model<PlayerModel>.CreateModel();
		Model<SeparateSegmentGameModel>.CreateModel();
		Model<TrialCharacterModel>.CreateModel();
		Model<TeamModel>.CreateModel();
		Model<RaidCheckPointModel>.CreateModel();
		if (!Model<RaidModel>.HasInstance())
		{
			Model<RaidModel>.CreateModel();
		}
		Model<EquipModel>.CreateModel();
		Model<AudioModel>.CreateModel();
		if (!Model<BattleMainModel>.HasInstance())
		{
			Model<BattleMainModel>.CreateModel();
		}
		if (!Model<ShopModel>.HasInstance())
		{
			Model<ShopModel>.CreateModel();
		}
		if (!Model<GiftPackageModel>.HasInstance())
		{
			Model<GiftPackageModel>.CreateModel();
		}
		Model<LoungeModel>.CreateModel();
		if (!Model<LoadingModel>.HasInstance())
		{
			Model<LoadingModel>.CreateModel();
		}
		Model<TreasureModel>.CreateModel();
		Model<DestinyModel>.CreateModel();
		Model<ActivityCenterModel>.CreateModel();
		if (!Model<FacePushModel>.HasInstance())
		{
			Model<FacePushModel>.CreateModel();
		}
		Model<QuestionnaireModel>.CreateModel();
		Model<InteractModel>.CreateModel();
		Model<CommonInteractUIModel>.CreateModel();
		Model<RuntimeTimelineModel>.CreateModel();
		Model<FavorabilityModel>.CreateModel();
		if (!Model<GuideTipModel>.HasInstance())
		{
			Model<GuideTipModel>.CreateModel();
		}
		if (!Model<GuideModel>.HasInstance())
		{
			Model<GuideModel>.CreateModel();
		}
		if (Model<ActivityCenterModel>.HasInstance())
		{
			Model<ActivityCenterModel>.Interface.RefreshRedDot();
		}
		if (!Model<BigWorldChallengeProgressModel>.HasInstance())
		{
			Model<BigWorldChallengeProgressModel>.CreateModel();
		}
		if (!Model<SundryModel>.HasInstance())
		{
			Model<SundryModel>.CreateModel();
		}
		Singleton<ProtagonistManager>.CreateInstance();
		Singleton<TeleportMoveManager>.CreateInstance();
		Singleton<BigWorldChallengeManager>.CreateInstance();
		Singleton<BreakChallengeManager>.CreateInstance();
		Singleton<ComboChallengeManager>.CreateInstance();
		Singleton<BattleChallengeManager>.CreateInstance();
		Singleton<RunningChallengeManager>.CreateInstance();
		Singleton<ConnectNodeManager>.CreateInstance();
		if (!Singleton<BloodstainRuntimeManager>.HasInstance())
		{
			Singleton<BloodstainRuntimeManager>.CreateInstance();
		}
		Model<ChallengePromptsModel>.CreateModel();
		if (!Model<PayModel>.HasInstance())
		{
			Model<PayModel>.CreateModel();
		}
		if (!Model<DivineEyeModel>.HasInstance())
		{
			Model<DivineEyeModel>.CreateModel();
		}
		Model<InviteCharacterModel>.CreateModel();
		if (!Model<ClientModuleModel>.HasInstance())
		{
			Model<ClientModuleModel>.CreateModel();
		}
		if (!Model<ShopModel>.HasInstance())
		{
			Model<ShopModel>.CreateModel();
		}
		if (!Model<LoadingDoneModel>.HasInstance())
		{
			Model<LoadingDoneModel>.CreateModel();
		}
		if (!Model<EliteModel>.HasInstance())
		{
			Model<EliteModel>.CreateModel();
		}
		if (!Model<BattlePassModel>.HasInstance())
		{
			Model<BattlePassModel>.CreateModel();
		}
		if (!Model<TextLibraryModel>.HasInstance())
		{
			Model<TextLibraryModel>.CreateModel();
		}
		Model<ChatBubbleModel>.CreateModel();
		Model<PowerModel>.CreateModel();
		if (!Model<InventoryModel>.HasInstance())
		{
			Model<InventoryModel>.CreateModel();
		}
		if (!Model<ObtainedItemModel>.HasInstance())
		{
			Model<ObtainedItemModel>.CreateModel();
		}
		Model<AssistNpcModel>.CreateModel();
		if (!Model<TargetGuideModel>.HasInstance())
		{
			Model<TargetGuideModel>.CreateModel();
		}
		if (!Model<WildBossModel>.HasInstance())
		{
			Model<WildBossModel>.CreateModel();
		}
		if (!Model<AccomplishmentModel>.HasInstance())
		{
			Model<AccomplishmentModel>.CreateModel();
		}
		Model<EnergyBar12701Model>.CreateModel();
		Model<EscModel>.CreateModel();
		Singleton<DamageableManager>.CreateInstance();
		Singleton<HitHealDeviceManager>.CreateInstance();
		if (!Model<TheOtherWorldModel>.HasInstance())
		{
			Model<TheOtherWorldModel>.CreateModel();
		}
		if (!Model<BattleReportModel>.HasInstance())
		{
			Model<BattleReportModel>.CreateModel();
		}
		Singleton<RuntimeNpcManager>.CreateInstance();
		MonoECS.instance.LoadInputBindingOverride();
		State = OptionState.Succeed;
	}

	internal override void OnUpdate()
	{
	}
}
