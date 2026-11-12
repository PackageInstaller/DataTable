public class AdventurePlayerCameraUpdateControl : SceneSingleton<AdventurePlayerCameraUpdateControl>
{
	public void DriveCameraUpdate()
	{
		SceneSingleton<AdventurePlayerController>.Instance?.FixCameraLateUpdate();
	}
}
