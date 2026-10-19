using System.Collections.Generic;
using ACT.UI;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行黑边Boxing", "Action", new string[] { "letter", "boxing", "camera", "fov", "volume" })]
public class ActionLetterBoxing : ConfigAction
{
	public enum LetterType
	{
		Normal,
		FromCenter,
		Fade
	}

	public bool hideUI;

	public LetterType type;

	private Dictionary<int, string> singleDt = new Dictionary<int, string>
	{
		{ 0, "LetterBoxing" },
		{ 1, "LetterBoxing_FromCenter" },
		{ 2, "LetterBoxing_Fade" }
	};

	protected override AbilityAuth defaultAuth => AbilityAuth.ClientOwner;

	public override async void Do(ActionMemory memory)
	{
		if (hideUI)
		{
			UIOpenResult uIOpenResult = await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_LETTERBOXINGPANEL, false);
			if (Singleton<NewUIManager>.instance.TryGetUIController(uIOpenResult.Uid, out var ui) && ui.GetUIView() is MonoLetterBoxingView monoLetterBoxingView)
			{
				monoLetterBoxingView.EnterLetterBoxing("LetterBoxing");
			}
			return;
		}
		MonoLetterBoxingView con = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_LETTERBOXINGPANEL) as MonoLetterBoxingView;
		if (con != null && con.UIController.State != UIState.Closed)
		{
			await con.ExitLetterBoxing("LetterBoxing");
			await con.CloseAsync();
		}
	}
}
