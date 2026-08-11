using System;

namespace Ase;

public class IdentityAuthentication
{
	private IPlatformSdk sdk;

	public IdentityAuthentication()
	{
		Init();
	}

	public void Init()
	{
		sdk?.OnInit();
	}

	public void Login(string userId, Action<IdentityResult> callback)
	{
		if (sdk == null)
		{
			callback?.Invoke(new IdentityResult
			{
				Success = true
			});
		}
		else
		{
			sdk.OnLogin(userId, callback);
		}
	}

	public void EnterGame()
	{
		sdk?.OnEnterGame();
	}

	public void LeaveGame()
	{
		sdk?.OnLeaveGame();
	}

	public void Logout()
	{
		sdk?.OnLogout();
	}

	public void Dispose()
	{
		sdk?.OnDispose();
	}
}
