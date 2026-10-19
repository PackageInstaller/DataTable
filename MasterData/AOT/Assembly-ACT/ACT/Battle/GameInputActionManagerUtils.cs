using Fundamental;

namespace ACT.Battle;

public static class GameInputActionManagerUtils
{
	public static void SetActionEnable(this IGameInputBindingHandle handle, string actionPath, bool enable)
	{
		if (!enable)
		{
			handle.ActionDisableList.Add(actionPath);
		}
		else
		{
			handle.ActionDisableList.Remove(actionPath);
		}
	}

	public static void BindInputAction(this IGameInputBindingHandle handle)
	{
		Singleton<GameInputActionManager>.instance.Bind(handle);
	}

	public static void UnbindInputAction(this IGameInputBindingHandle handle)
	{
		Singleton<GameInputActionManager>.instance.Unbind(handle);
	}
}
