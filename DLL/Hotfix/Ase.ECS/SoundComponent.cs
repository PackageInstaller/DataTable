using FMOD.Studio;
using FMODUnity;
using GameFramework;

namespace Ase.ECS;

public class SoundComponent : BaseComponent
{
	protected bool initialized;

	protected BaseEntity ownerEntity;

	protected BaseEntity followEntity;

	protected DRAudio configData;

	protected SoundData soundData;

	protected EventInstance instance;

	private float delayTimer;

	public void RegistSound(DREffect effectConfig, bool delayStartBaseFrozen, BaseEntity ownerEntity, BaseEntity followEntity)
	{
		if (soundData == null)
		{
			soundData = ReferencePool.Acquire<SoundData>();
		}
		else
		{
			soundData.Clear();
		}
		soundData.AudioId = effectConfig.AudioID;
		soundData.ParamNameList = effectConfig.ParamNameList;
		soundData.ParamValueList = effectConfig.ParamValueList;
		soundData.ApplyFollowParentType = effectConfig.AudioFollowParentType;
		soundData.DelayStart = effectConfig.DelayStart;
		soundData.DelayStartBaseFrozen = delayStartBaseFrozen;
		DRAudio dRAudio = ownerEntity?.Parent?.GetSoundIdByParentSkinConfig(effectConfig.AudioID);
		if (dRAudio != null)
		{
			soundData.AudioId = dRAudio.Id;
		}
		if (soundData.AudioId > 0)
		{
			configData = GameEntry.DataTable.GetDataRow<DRAudio>(soundData.AudioId);
			if (configData == null)
			{
				initialized = false;
				return;
			}
			this.ownerEntity = ownerEntity;
			this.followEntity = followEntity;
			initialized = true;
		}
		else
		{
			initialized = false;
		}
	}

	public void TryPlaySound()
	{
		if (initialized)
		{
			if (soundData.DelayStart <= 0f)
			{
				delayTimer = 0f;
				DoPlaySound();
			}
			else
			{
				delayTimer = soundData.DelayStart;
			}
		}
	}

	public void TryDispose()
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		if (((EventInstance)(ref instance)).isValid())
		{
			((EventInstance)(ref instance)).stop((STOP_MODE)0);
			((EventInstance)(ref instance)).release();
		}
	}

	private void DoPlaySound()
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_0059: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		if (followEntity != null)
		{
			instance = Singleton<AudioSystem>.Instance.CreateInstance(soundData.AudioId);
			if (((EventInstance)(ref instance)).isValid())
			{
				SetResultVolume();
				SetParameter();
				EventDescription eventDescription = Singleton<AudioSystem>.Instance.GetEventDescription(soundData.AudioId);
				bool position = default(bool);
				((EventDescription)(ref eventDescription)).isOneshot(ref position);
				SetPosition(position);
				((EventInstance)(ref instance)).start();
			}
		}
	}

	private void SetResultVolume()
	{
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		float num = 1f;
		HeroEntity ownerHeroEntity = GetOwnerHeroEntity(ownerEntity);
		if (ownerHeroEntity != null)
		{
			num = ((!ownerHeroEntity.BattleHeroData.IsSelf) ? (num * Singleton<AudioSystem>.Instance.OtherRoleVolumeRate) : num);
		}
		((EventInstance)(ref instance)).setVolume(num);
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
		if (entity is BulletEntity bulletEntity)
		{
			return GetOwnerHeroEntity(bulletEntity.Parent);
		}
		if (entity is EffectEntity effectEntity)
		{
			return GetOwnerHeroEntity(effectEntity.EffectData.owner);
		}
		return null;
	}

	private void SetParameter()
	{
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e1: Unknown result type (might be due to invalid IL or missing references)
		if (soundData.ParamValueList != null)
		{
			for (int i = 0; i < soundData.ParamValueList.Count; i++)
			{
				((EventInstance)(ref instance)).setParameterByName(soundData.ParamNameList[i], soundData.ParamValueList[i], false);
			}
		}
		if (!soundData.ApplyFollowParentType)
		{
			return;
		}
		if (followEntity is EffectEntity effectEntity)
		{
			if (effectEntity.EffectData.owner is MonsterEntity monsterEntity)
			{
				int materialType = monsterEntity.GetMaterialType();
				((EventInstance)(ref instance)).setParameterByName("MaterialType", (float)materialType, false);
			}
		}
		else if (followEntity is BulletEntity { Parent: MonsterEntity parent })
		{
			int materialType2 = parent.GetMaterialType();
			((EventInstance)(ref instance)).setParameterByName("MaterialType", (float)materialType2, false);
		}
	}

	private void SetPosition(bool isOneshot)
	{
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		if (followEntity.GetBaseEntityView() != null)
		{
			if (isOneshot)
			{
				((EventInstance)(ref instance)).set3DAttributes(RuntimeUtils.To3DAttributes(followEntity.GetBaseEntityView().transform));
			}
			else
			{
				RuntimeManager.AttachInstanceToGameObject(instance, followEntity.GetBaseEntityView().transform);
			}
		}
	}

	public override void OnInit(object data)
	{
		base.OnInit(data);
		delayTimer = 0f;
		initialized = false;
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		if (initialized && !(delayTimer <= 0f))
		{
			if (soundData.DelayStartBaseFrozen)
			{
				delayTimer -= deltaTime * (ownerEntity?.FrozenSpeed ?? 1f);
			}
			else
			{
				delayTimer -= deltaTime;
			}
			if (delayTimer <= 0f)
			{
				delayTimer = 0f;
				DoPlaySound();
			}
		}
	}

	public override void OnDispose()
	{
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		base.OnDispose();
		if (soundData != null)
		{
			ReferencePool.Release(soundData);
			soundData = null;
		}
		if (((EventInstance)(ref instance)).isValid())
		{
			EventDescription val = default(EventDescription);
			((EventInstance)(ref instance)).getDescription(ref val);
			bool flag = default(bool);
			((EventDescription)(ref val)).isOneshot(ref flag);
			if (!flag)
			{
				((EventInstance)(ref instance)).stop((STOP_MODE)0);
			}
		}
	}
}
