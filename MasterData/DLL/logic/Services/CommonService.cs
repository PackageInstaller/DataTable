namespace Services;

public class CommonService : IService
{
	public IRuntimeAttributeService mAttributeService;

	public IFCBuffService mFCBuffService;

	public ILevelColliderService mLevelColliderService;

	public CommonService(SimContext context)
	{
		mAttributeService = new RuntimeAttributeService();
		mFCBuffService = new FCBuffService(context);
		mLevelColliderService = new LevelColliderService();
	}

	public void Shutdown()
	{
		(mAttributeService as IService).Shutdown();
		mAttributeService = null;
		(mFCBuffService as IService).Shutdown();
		mFCBuffService = null;
		(mLevelColliderService as IService).Shutdown();
		mLevelColliderService = null;
	}
}
