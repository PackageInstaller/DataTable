using System;

namespace Ase;

public interface IPlatformSdk
{
	void OnInit();

	void OnLogin(string userId, Action<IdentityResult> callback);

	void OnEnterGame();

	void OnLeaveGame();

	void OnLogout();

	void OnDispose();
}
