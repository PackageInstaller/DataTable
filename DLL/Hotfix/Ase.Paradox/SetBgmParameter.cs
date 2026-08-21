using System.Collections.Generic;
using FMOD.Studio;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("设置当前背景音乐参数", 0)]
[Category("✫ DragonLost/Audio")]
[Description("用于设置当前背景音乐的参数")]
public class SetBgmParameter : ActionTaskBase
{
	[RequiredField]
	[Name("音频Id", 0)]
	[Description("要设置参数的背景音乐的音频ID")]
	public BBParameter<int> audioId;

	[Name("音量(0-1)", 0)]
	[Description("设置背景音乐的音量大小（范围0-1）")]
	public BBParameter<float> volume = 1f;

	[Name("参数(旧版)", 0)]
	[Description("设置背景音乐的参数列表（旧版）")]
	public BBParameter<Dictionary<string, float>> paramDic;

	[Name("参数(新版)", 0)]
	[Description("设置背景音乐的参数列表（新版）")]
	public BBParameter<List<AudioParameterSerializable>> paramList;

	[Name("Stop后是否播放上一首", 0)]
	[Description("指示在停止播放后是否继续播放上一首背景音乐")]
	public bool ReturnWhileStop = true;

	protected override void OnExecute()
	{
		base.OnExecute();
		Singleton<AudioSystem>.Instance.SetBgmParameter(audioId.value, new FMOD_Define.BgmParameter(volume.value, GetParameters(), ReturnWhileStop, (STOP_MODE)0));
		EndAction(success: true);
	}

	private List<AudioParameterSerializable> GetParameters()
	{
		List<AudioParameterSerializable> list = new List<AudioParameterSerializable>();
		if (paramList?.value != null)
		{
			list.AddRange(paramList.value);
		}
		if (paramDic?.value != null)
		{
			foreach (KeyValuePair<string, float> param in paramDic.value)
			{
				if (!list.Exists((AudioParameterSerializable p) => p.Key.Equals(param.Key)))
				{
					list.Add(new AudioParameterSerializable
					{
						Key = param.Key,
						Value = param.Value,
						Duration = 0f
					});
				}
			}
		}
		return list;
	}
}
