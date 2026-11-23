Main = {}






function Main.Init()
	print("lua init");
	require("MainInit")
	LuaDebug.init("laigu",nil,"debug");
	NoticeMgr.Init();
end

function Main.Login()
	print("lua login");
	DataHelper.isFirstLogin = true;
	DataHelper.firstMainPage = true;
	HeroParameter.EmptyAnyssPreArea();
	UnlockTipsMgr.Init();
	NoticeMgr.Login();
	ActivityMgr.Init();
	HeroRedDataHelper.Init();
	PopUpMgr.Login();
	LuaMgr.ScreenMonitorType("t_1");
	PlayerAssistMgr.Init();
	PlayerAreaMgr.SetDefaultModel();
	PlayerGuildMgr.Init();
end

function Main.Logout()
	print("lua logout");

	HeroRedDataHelper.Clear();
	DataMgr.Clear();
	LuaMgr.ScreenMonitorClear();
end

function Main.Clear()
	print("lua clear");
	coroutine_runner.stopAll();
	for k, _ in pairs(_G.package.loaded) do
		_G.package.loaded[k] = nil;
	end
end