using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行控制UI显示", "Action", new string[] { "control", "ui", "show", "hud", "text", "tip" })]
public class ActionControlUIShow : ConfigAction
{
	public bool hideScene;

	public override void Do(ActionMemory memory)
	{
		if (!hideScene)
		{
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_LETTERBOXINGPANEL, false).Forget();
		}
		else
		{
			MonoECS.instance.HideScene(state: false);
		}
	}
}
