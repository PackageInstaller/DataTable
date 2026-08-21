using FMOD.Studio;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("控制背景音乐", 0)]
[Category("✫ DragonLost/Audio")]
[Description("用于控制背景音乐的播放状态")]
public class ControlBgm : ActionTaskBase
{
	[Name("停止当前BGM", 0)]
	[Description("指示是否停止当前背景音乐")]
	public bool stop;

	[Name("设置暂停", 0)]
	[Description("指示是否暂停背景音乐")]
	public bool pause;

	[Name("停止模式", 0)]
	[Description("指定停止背景音乐的模式")]
	public STOP_MODE stopMode;

	[Name("清空BGM列表", 0)]
	[Description("指示是否清空背景音乐列表")]
	public bool clearBgmList;

	[Name("淡入时间", 0)]
	[Description("淡入背景音乐的时间")]
	public BBParameter<float> fadeInTime = 3f;

	[Name("淡出时间", 0)]
	[Description("淡出背景音乐的时间")]
	public BBParameter<float> fadeOutTime = 3f;

	protected override void OnExecute()
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		base.OnExecute();
		if (stop)
		{
			Singleton<AudioSystem>.Instance.StopCurBgm(stopMode, clearBgmList, fadeInTime.value, fadeOutTime.value);
		}
		else
		{
			float fadeTime = (pause ? fadeOutTime.value : fadeInTime.value);
			Singleton<AudioSystem>.Instance.SetBgmPause(pause, fadeTime);
		}
		EndAction(success: true);
	}
}
