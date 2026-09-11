public class MusicGameCriAtomSource : CriAtomSource
{
	protected override void InternalInitialize()
	{
		CriAtomPlugin.InitializeLibrary();
		base.player = new CriAtomExPlayer(enableAudioSyncedTimer: true);
		base.source = new CriAtomEx3dSource();
	}
}
