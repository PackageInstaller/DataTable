public class CharPreviewStartGame : SplashNode
{
	public CharPreviewStartGame(GameMain main)
		: base(main)
	{
	}

	protected override void OnEnter()
	{
		base.OnEnter();
		mIsDone = true;
	}

	protected override void OnUpdate()
	{
		base.OnUpdate();
	}

	protected override void OnExit()
	{
		base.OnExit();
		IniManager.Initialize();
		Asset.Initialize(mGameMain.mServerAssetHashManifest);
		NaiveAngleConfigManager.Initialize();
		NScene.Load<CharPreviewGameStartScene>();
		mGameMain.gameObject.SetActive(value: false);
	}
}
