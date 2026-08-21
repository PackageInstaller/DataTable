using GameFramework.Runtime;

namespace Ase;

public class ServiceSystem : Singleton<ServiceSystem>
{
	private PlayerContext playerContext;

	private IServiceContainer container;

	private const string PLAYER_CONTEXT = "PLAYER_CONTEXT";

	private bool initialized;

	public bool Initialized => initialized;

	public ServiceSystem()
	{
		playerContext = new PlayerContext();
		Context.AddContext("PLAYER_CONTEXT", playerContext);
		container = playerContext.GetContainer();
	}

	public void Register<T>(T target)
	{
		container.Register(target);
	}

	public void Unregister<T>()
	{
		container.Unregister<T>();
	}

	public T GetService<T>()
	{
		return playerContext.GetService<T>();
	}

	public void RegisterGlobalService()
	{
		container.Register((IAccountService)new AccountService());
		container.Register((IAnnouncementService)new AnnouncementService());
		container.Register((ILoadingService)new LoadingService());
		initialized = true;
	}

	public void RegisterSystemService()
	{
		container.Register(SDKHelper.CreateSDKService());
		container.Register((ITimeService)new TimeService());
		container.Register((IRoleService)new RoleService());
		container.Register((ISOService)new SOService());
		container.Register((IGameNewsTipService)new GameNewsTipService());
		container.Register((IKnapsackService)new KnapsackService());
		container.Register((IEquipmentService)new EquipmentService());
		container.Register((IAchievementService)new AchievementService());
		container.Register((IHeroService)new HeroService());
		container.Register((ITeamService)new TeamService());
		container.Register((IHomeLandService)new HomeLandService());
		container.Register((IMailService)new MailService());
		container.Register((IChatService)new ChatService());
		container.Register((IDrawCardService)new DrawCardService());
		container.Register((ISocialService)new SocialService());
		container.Register((IMultiRoomService)new MultiRoomService());
		container.Register((ICopyService)new CopyService());
		container.Register((ITaskServices)new TaskServices());
		container.Register((ILevelSaveService)new LevelSaveService());
		container.Register((IShopService)new ShopService());
		container.Register((IRankService)new RankService());
		container.Register((IOpActivityService)new OpActivityService());
		container.Register((IMapService)new MapService());
		container.Register((IGuildService)new GuildService());
		container.Register((IRedPointService)new RedPointService());
		container.Register((IPassportService)new PassportService());
		container.Register((IGameNoteService)new GameNoteService());
		container.Register((IGameActivityService)new GameActivityService());
		container.Register((IBannerService)new BannerService());
		container.Register((IBFBEService)new BFBEService());
		container.Register((IHomeComeService)new HomeComeService());
		container.Register((IActivityAchievementService)new ActivityAchievementService());
		container.Register((ICampaignService)new CampaignService());
	}

	public void UnregisterSystemService()
	{
		ServiceDispose();
		container.Unregister<ISDKService>();
		container.Unregister<IRoleService>();
		container.Unregister<ISOService>();
		container.Unregister<IKnapsackService>();
		container.Unregister<IEquipmentService>();
		container.Unregister<IAchievementService>();
		container.Unregister<IHeroService>();
		container.Unregister<ITeamService>();
		container.Unregister<IHomeLandService>();
		container.Unregister<IMailService>();
		container.Unregister<IChatService>();
		container.Unregister<IDrawCardService>();
		container.Unregister<ISocialService>();
		container.Unregister<IMultiRoomService>();
		container.Unregister<ICopyService>();
		container.Unregister<ITaskServices>();
		container.Unregister<ILevelSaveService>();
		container.Unregister<IShopService>();
		container.Unregister<IRankService>();
		container.Unregister<IOpActivityService>();
		container.Unregister<IMapService>();
		container.Unregister<IGuildService>();
		container.Unregister<IRedPointService>();
		container.Unregister<IPassportService>();
		container.Unregister<IGameNoteService>();
		container.Unregister<ITimeService>();
		container.Unregister<IGameActivityService>();
		container.Unregister<IBannerService>();
		container.Unregister<IGameNewsTipService>();
		container.Unregister<IBFBEService>();
		container.Unregister<IHomeComeService>();
		container.Unregister<IActivityAchievementService>();
		container.Unregister<ICampaignService>();
	}

	public void ServiceDispose()
	{
		playerContext.GetService<ISDKService>()?.Dispose();
		playerContext.GetService<ISocialService>()?.Dispose();
		playerContext.GetService<IGuildService>()?.Dispose();
		playerContext.GetService<IShopService>()?.Dispose();
		playerContext.GetService<IRoleService>()?.Dispose();
		playerContext.GetService<IHomeLandService>()?.Dispose();
		playerContext.GetService<IAccountService>()?.Dispose();
		playerContext.GetService<ITimeService>()?.Dispose();
		playerContext.GetService<ICopyService>()?.Dispose();
		playerContext.GetService<ILevelSaveService>()?.Dispose();
		playerContext.GetService<ISOService>()?.Dispose();
		playerContext.GetService<ICampaignService>()?.Dispose();
	}

	public override void Dispose()
	{
		if (playerContext != null)
		{
			ServiceDispose();
			playerContext.Dispose();
			playerContext = null;
		}
		container = null;
		Context.RemoveContext("PLAYER_CONTEXT");
	}
}
