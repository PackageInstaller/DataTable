using System.Collections.Generic;
using Ase.ECS;
using FMOD.Studio;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("控制Snapshot", 0)]
[Category("✫ DragonLost/Audio")]
[Description("用于控制快照的播放状态")]
public class ControlSnapshot : ActionTaskBase
{
	[RequiredField]
	[Name("音频Id", 0)]
	[Description("要控制的快照的音频ID")]
	public BBParameter<int> audioId;

	[Name("是否播放", 0)]
	[Description("指示是否播放快照")]
	public bool play = true;

	[Name("跟随实体", 0)]
	[Description("指示是否在实体位置播放快照")]
	public bool followEntity;

	[Name("音量(0-1)", 0)]
	[Description("设置快照的音量大小（范围0-1）")]
	public BBParameter<float> volume = 1f;

	[Name("参数(新版)", 0)]
	[Description("设置快照的参数列表（新版）")]
	public BBParameter<List<AudioParameterSerializable>> paramList;

	[Name("停止模式", 0)]
	[Description("指定停止快照的模式")]
	public STOP_MODE stopMode;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (!play)
		{
			Dispose();
		}
		else
		{
			float num = GetVolume();
			FMOD_Define.SoundEffectParameter parameter = new FMOD_Define.SoundEffectParameter(num, paramList.value);
			if (followEntity)
			{
				EntityViewComponent component = GetOwnerEntity().GetComponent<EntityViewComponent>();
				if (component != null)
				{
					Singleton<AudioSystem>.Instance.PlayLocalSnapshot(component.EntityView.transform, audioId.value, parameter);
				}
			}
			else
			{
				Singleton<AudioSystem>.Instance.PlayGlobalSnapshot(audioId.value, parameter);
			}
		}
		EndAction(success: true);
	}

	private float GetVolume()
	{
		float num = volume.value;
		if (ownerEntity != null && ownerEntity is HeroEntity heroEntity)
		{
			num = ((!heroEntity.BattleHeroData.IsSelf) ? (num * Singleton<AudioSystem>.Instance.OtherRoleVolumeRate) : num);
		}
		return num;
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		Dispose();
	}

	protected override void OnPause()
	{
		base.OnPause();
		Dispose();
	}

	private void Dispose()
	{
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		if (followEntity)
		{
			EntityViewComponent component = GetOwnerEntity().GetComponent<EntityViewComponent>();
			if (component != null)
			{
				Singleton<AudioSystem>.Instance.StopLocalSnapshot(component.EntityView.transform, audioId.value, stopMode);
			}
		}
		else
		{
			Singleton<AudioSystem>.Instance.StopGlobalSnapshot(audioId.value, stopMode);
		}
	}
}
