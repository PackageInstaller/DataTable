#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase.ECS;
using FMOD.Studio;
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("播放背景音乐", 0)]
[Category("✫ DragonLost/Audio")]
[Description("用于播放背景音乐")]
public class PlayBgm : ActionTaskBase
{
	[RequiredField]
	[Name("音频Id", 0)]
	[Description("要播放的背景音乐的音频ID")]
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

	[Name("是否进行id检测", 0)]
	[Description("指示是否进行背景音乐ID检测")]
	public bool CheckBgmId;

	[Name("停止模式", 0)]
	[Description("指定停止背景音乐的模式")]
	public STOP_MODE stopMode;

	[Name("BGM淡入时间", 0)]
	[Description("指定背景音乐的淡入时间")]
	public BBParameter<float> fadeInTime = 3f;

	[Name("BGM淡出时间", 0)]
	[Description("指定背景音乐的淡出时间")]
	public BBParameter<float> fadeOutTime = 3f;

	protected override void OnExecute()
	{
		base.OnExecute();
		DoPlay();
		EndAction(success: true);
	}

	private async void DoPlay()
	{
		try
		{
			await ownerEntity.GetComponent<FMODBankComponent>().WaitUntilBankGroupsLoadedAsync();
			if (!CheckBgmId)
			{
				Singleton<AudioSystem>.Instance.PlayBgm(audioId.value, new FMOD_Define.BgmParameter(volume.value, GetParameters(), ReturnWhileStop, stopMode, fadeInTime.value, fadeOutTime.value));
			}
			else
			{
				Singleton<AudioSystem>.Instance.PlayBgmWithIdCheck(audioId.value, new FMOD_Define.BgmParameter(volume.value, GetParameters(), ReturnWhileStop, stopMode, fadeInTime.value, fadeOutTime.value));
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
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
