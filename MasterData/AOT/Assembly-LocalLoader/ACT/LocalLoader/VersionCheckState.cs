namespace ACT.LocalLoader;

public enum VersionCheckState
{
	None,
	Full,
	Patch,
	Forbidden,
	HotUpdate,
	RefreshFail,
	HotUpdateWithPatch
}
