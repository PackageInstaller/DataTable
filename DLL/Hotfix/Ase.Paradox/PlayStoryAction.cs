using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("播放剧情", 0)]
[Category("✫ DragonLost/Story")]
[Description("播放指定剧情ID的剧情。")]
public class PlayStoryAction : ActionTaskBase
{
	[Name("剧情ID", 0)]
	[Description("要播放的剧情的ID。")]
	public BBParameter<int> timeLineID;

	[Name("等待完成", 0)]
	public bool waitFinish = true;

	protected override async void OnExecute()
	{
		base.OnExecute();
		if (!waitFinish)
		{
			Singleton<Story>.Instance.PlayStory(GetOwnerEntity().GetWorld().Id, timeLineID.value);
			OnActionFinish();
		}
		else
		{
			await Singleton<Story>.Instance.PlayStory(GetOwnerEntity().GetWorld().Id, timeLineID.value);
			OnActionFinish();
		}
	}
}
