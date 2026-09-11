using CriMana;

public class CriManaLoopUI : CriManaMovieControllerForUI
{
	public int m_LoopStartFrameIndex = 10;

	public int m_LoopEndFrameIndex = 100;

	private void Update()
	{
		if (base.player != null && base.player.status == Player.Status.Playing && base.player.GetDisplayedFrameNo() >= m_LoopEndFrameIndex)
		{
			base.player.SetSeekPosition(m_LoopStartFrameIndex);
			base.player.StopForSeek();
		}
		if (base.player != null && base.player.status == Player.Status.PlayEnd)
		{
			base.player.SetSeekPosition(m_LoopStartFrameIndex);
			base.player.StopForSeek();
		}
		if (base.player != null && base.player.status == Player.Status.Stop)
		{
			base.player.Start();
		}
	}
}
