namespace System.Net;

internal enum FtpLoginState : byte
{
	NotLoggedIn,
	LoggedIn,
	LoggedInButNeedsRelogin,
	ReloginFailed
}
