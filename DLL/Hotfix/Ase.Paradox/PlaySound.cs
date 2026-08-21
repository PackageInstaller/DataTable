using System;
using System.Collections.Generic;
using Ase.ECS;
using FMOD.Studio;
using FMODUnity;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("播放音效", 0)]
[Category("✫ DragonLost/Audio")]
[Description("用于播放音效")]
public class PlaySound : ActionTaskBase
{
	public enum SOUND_FOLLOW_MODE
	{
		OWNER_POS,
		OWNER_FOLLOW
	}

	[RequiredField]
	[Name("音频Id", 0)]
	[Description("要播放的音效的音频ID")]
	public BBParameter<int> audioId;

	[Name("音量(0-1)", 0)]
	[Description("设置音效的音量大小（范围0-1）")]
	public BBParameter<float> volume = 1f;

	[Name("参数(旧版)", 0)]
	[Description("设置背景音乐的参数列表（旧版）")]
	public BBParameter<Dictionary<string, float>> paramDic;

	[Name("参数(新版)", 0)]
	[Description("设置音效的参数列表（新版）")]
	public BBParameter<List<AudioParameterSerializable>> paramList;

	[Name("跟随模式", 0)]
	[Description("指定音效播放时跟随的模式")]
	public SOUND_FOLLOW_MODE followMode;

	[Name("叠加效果(仅短音效有效)", 0)]
	[Description("指示是否允许音效叠加播放")]
	public bool allowMultiple;

	[Name("是否随行为树结束而停止", 0)]
	[Description("指示音效是否随行为树结束而停止")]
	public bool followTreeStop = true;

	[Name("音效停止时机(实体相关)", 0)]
	[Description("用于【停止时机】需要与【实体状态】挂钩的声音")]
	public BBParameter<List<SoundDisposeTiming>> DisposeTiming = new BBParameter<List<SoundDisposeTiming>>(new List<SoundDisposeTiming> { SoundDisposeTiming.OnEntityDead });

	[Name("停止模式", 0)]
	[Description("指定停止音效的模式")]
	public STOP_MODE stopMode;

	private EventInstance _instance;

	private bool _isOneshot;

	private int audioID;

	protected override bool IsDisplayNode => true;

	protected override void OnExecute()
	{
		base.OnExecute();
		DoPlay();
		EndAction(success: true);
	}

	private async void DoPlay()
	{
		audioID = ownerEntity.GetSoundIdByParentSkinConfig(audioId.value)?.Id ?? audioId.value;
		try
		{
			await ownerEntity.GetComponent<FMODBankComponent>().WaitUntilBankGroupsLoadedAsync();
			EventDescription eventDescription = Singleton<AudioSystem>.Instance.GetEventDescription(audioID);
			((EventDescription)(ref eventDescription)).isOneshot(ref _isOneshot);
		}
		catch (Exception)
		{
			EndAction(success: true);
		}
		bool flag = _isOneshot && allowMultiple;
		if (!((EventInstance)(ref _instance)).isValid() | flag)
		{
			InitInstance();
		}
		Set3DAttributes();
		if (DisposeTiming != null && DisposeTiming.value != null && DisposeTiming.value.Count > 0)
		{
			BindHostedComponent();
		}
		((EventInstance)(ref _instance)).start();
	}

	private void InitInstance()
	{
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		//IL_0069: Unknown result type (might be due to invalid IL or missing references)
		if (volume != null)
		{
			float num = volume.value;
			HeroEntity ownerHeroEntity = GetOwnerHeroEntity(ownerEntity);
			if (ownerHeroEntity != null)
			{
				BattleHeroData battleHeroData = ownerHeroEntity.BattleHeroData;
				num = ((battleHeroData != null && !battleHeroData.IsSelf) ? (num * Singleton<AudioSystem>.Instance.OtherRoleVolumeRate) : num);
			}
			if (this != null)
			{
				_instance = Singleton<AudioSystem>.Instance.CreateInstance(audioID, num, GetParameters());
			}
		}
	}

	private HeroEntity GetOwnerHeroEntity(BaseEntity entity)
	{
		if (entity == null)
		{
			return null;
		}
		if (entity is HeroEntity result)
		{
			return result;
		}
		if (entity.Parent != null)
		{
			return GetOwnerHeroEntity(entity.Parent);
		}
		return null;
	}

	private void Set3DAttributes()
	{
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		if (followMode == SOUND_FOLLOW_MODE.OWNER_POS)
		{
			((EventInstance)(ref _instance)).set3DAttributes(RuntimeUtils.To3DAttributes(GetOwnerEntity().transform.position));
		}
		else if (followMode == SOUND_FOLLOW_MODE.OWNER_FOLLOW)
		{
			EntityViewComponent component = GetOwnerEntity().GetComponent<EntityViewComponent>();
			if (component != null)
			{
				RuntimeManager.AttachInstanceToGameObject(_instance, component.EntityView.transform);
			}
		}
	}

	private void BindHostedComponent()
	{
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		if (ownerEntity != null && (ownerEntity is HeroEntity || ownerEntity is MonsterEntity))
		{
			ownerEntity.GetComponent<SoundHostedComponent>()?.HostedSound(new HostedSound
			{
				Instance = _instance,
				StopMode = stopMode,
				DisposeTimings = DisposeTiming.value
			});
		}
	}

	protected override void OnPause()
	{
		base.OnPause();
		Dispose();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		Dispose();
	}

	private void Dispose()
	{
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		if (followTreeStop && ((EventInstance)(ref _instance)).isValid())
		{
			((EventInstance)(ref _instance)).stop(stopMode);
		}
		((EventInstance)(ref _instance)).release();
		((EventInstance)(ref _instance)).clearHandle();
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
