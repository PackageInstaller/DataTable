public class LuaBridge
{
	private ILuaCall mLua;

	private static LuaBridge sInstance;

	public static LuaBridge Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new LuaBridge();
			}
			return sInstance;
		}
	}

	public ILuaCall Lua => mLua;

	public void init(ILuaCall luac)
	{
		mLua = luac;
	}
}
