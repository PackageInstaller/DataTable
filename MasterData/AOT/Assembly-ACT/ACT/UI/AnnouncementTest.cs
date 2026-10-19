using ACT.UI.AOT;
using UnityEngine;

namespace ACT.UI;

public class AnnouncementTest : MonoBehaviour
{
	public AnnouncementView View;

	public AnnouncementViewHCLR ViewHclr;

	private async void Awake()
	{
		await LuminApplication.GmApi.GetAnnouncements(2);
		await LuminApplication.GmApi.GetAnnouncements(1, 4);
		await LuminApplication.GmApi.GetAnnouncements(1, 5);
		AnnouncementRedDot.Load();
		ViewHclr = View.GetComponent<AnnouncementViewHCLR>();
		View.Init();
		View.IsHCLR = true;
		ViewHclr.SwitchToGameAnnouncement();
	}
}
