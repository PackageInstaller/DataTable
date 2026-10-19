using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using Bamboo.Chronos;
using Bamboo.ECS;
using UnityEngine;

public class TrainingGroundModel : Model<TrainingGroundModel>
{
	public abstract class TrainingGroundConfig<T>
	{
		public abstract void Init();

		public abstract void CopyTo(T config);

		public abstract void CopyDynamicValue(T config);

		public abstract bool Equals(T config);
	}

	public sealed class EnemyConfig : TrainingGroundConfig<EnemyConfig>
	{
		public int enemyId;

		public int aiIndex;

		public int level;

		public bool useAi;

		public bool isLockBlood;

		public const string LockHpAbility = "TrainingGroundLockHp_Ability";

		public bool isWeak;

		public const string WeakAbility = "TrainingGroundRemainWeak";

		public int sceneId;

		public int worldId;

		public const string LockHatredAbility = "TrainingGroundLockHatred";

		public override void Init()
		{
			enemyId = 20001;
			aiIndex = 0;
			level = 10;
			useAi = false;
			isLockBlood = false;
			isWeak = false;
			worldId = 140100;
			sceneId = 20000;
		}

		public void Refresh()
		{
			Init();
		}

		public override void CopyTo(EnemyConfig copyConfig)
		{
			copyConfig.enemyId = enemyId;
			copyConfig.aiIndex = aiIndex;
			copyConfig.level = level;
			copyConfig.sceneId = sceneId;
		}

		public override void CopyDynamicValue(EnemyConfig config)
		{
			config.useAi = useAi;
			config.isLockBlood = isLockBlood;
			config.isWeak = isWeak;
		}

		public override bool Equals(EnemyConfig enemyConfig)
		{
			if (enemyConfig != null && enemyConfig.enemyId == enemyId && enemyConfig.level == level && enemyConfig.aiIndex == aiIndex)
			{
				return true;
			}
			return false;
		}
	}

	public class CharacterConfig : TrainingGroundConfig<CharacterConfig>
	{
		public List<int> characterIds;

		public bool ultraEnergy;

		public bool skillEnergy;

		public bool invincible;

		public bool superArmor;

		public override void Init()
		{
			ultraEnergy = false;
			skillEnergy = false;
			invincible = false;
			superArmor = false;
		}

		public void Refresh()
		{
			Init();
		}

		public override void CopyTo(CharacterConfig copyConfig)
		{
			copyConfig.ultraEnergy = ultraEnergy;
			copyConfig.skillEnergy = skillEnergy;
			copyConfig.invincible = invincible;
			copyConfig.superArmor = superArmor;
		}

		public override void CopyDynamicValue(CharacterConfig config)
		{
			throw new NotImplementedException();
		}

		public void B_CopyTO_A(CharacterConfig copyConfig)
		{
			copyConfig.ultraEnergy = ultraEnergy;
			copyConfig.skillEnergy = skillEnergy;
			copyConfig.invincible = invincible;
			copyConfig.superArmor = superArmor;
		}

		public override bool Equals(CharacterConfig characterConfig)
		{
			if (characterConfig.ultraEnergy == ultraEnergy && characterConfig.skillEnergy == skillEnergy && characterConfig.invincible == invincible && characterConfig.superArmor == superArmor)
			{
				return true;
			}
			return false;
		}
	}

	private EnemyConfig _enemyConfig;

	private CharacterConfig _characterConfig;

	private EnemyConfig _enmyConfigBackUp;

	private CharacterConfig _characterConfigBackUp;

	private bool _useUnlockSystem;

	public const string m_enemyOption = "SELECTOPTION";

	private Looper loopframe;

	private Entity _characterRuntimeTagEntity;

	private bool _runtimeInvincibleApplied;

	private bool _runtimeSuperArmorApplied;

	public Vector3 MainWorldBattleCharaPostion { get; set; }

	public bool useUnlockSystem
	{
		get
		{
			return _useUnlockSystem;
		}
		set
		{
			_useUnlockSystem = value;
		}
	}

	public int selectEnemy { get; set; }

	public PresetTeam worldTeamProfile { get; set; }

	public int worldBattleTeamIndex { get; set; }

	public EnemyConfig enemyConfig => _enemyConfig;

	public CharacterConfig characterConfig => _characterConfig;

	public EnemyConfig copy_enemyConfig
	{
		get
		{
			_enemyConfig.CopyTo(_enmyConfigBackUp);
			return _enmyConfigBackUp;
		}
	}

	public CharacterConfig CopyCharacterConfigBackUp
	{
		get
		{
			_characterConfig.CopyTo(_characterConfigBackUp);
			return _characterConfigBackUp;
		}
	}

	public void InitEnemyDynamicValue()
	{
		_enemyConfig.CopyDynamicValue(_enmyConfigBackUp);
	}

	protected override void Init()
	{
		_useUnlockSystem = false;
		if (_enemyConfig == null)
		{
			_enemyConfig = new EnemyConfig();
		}
		if (_characterConfig == null)
		{
			_characterConfig = new CharacterConfig();
		}
		if (_enmyConfigBackUp == null)
		{
			_enmyConfigBackUp = new EnemyConfig();
		}
		if (_characterConfigBackUp == null)
		{
			_characterConfigBackUp = new CharacterConfig();
		}
		_enemyConfig.Init();
		_characterConfig.Init();
		_enmyConfigBackUp.Init();
		_characterConfigBackUp.Init();
	}

	protected override void UnInit()
	{
		_useUnlockSystem = false;
		ClearCharacterRuntimeTags();
		if (loopframe.IsValid())
		{
			loopframe.Cancel();
		}
		_enemyConfig.Refresh();
		_characterConfig.Refresh();
		_enmyConfigBackUp.Refresh();
		_characterConfigBackUp.Refresh();
	}

	protected override void OnDestroy()
	{
		_enemyConfig = null;
		_characterConfig = null;
		_enmyConfigBackUp = null;
		_characterConfigBackUp = null;
	}

	public bool HasChange()
	{
		if (_enemyConfig.Equals(_enmyConfigBackUp))
		{
			return !_characterConfig.Equals(_characterConfigBackUp);
		}
		return true;
	}

	public bool EnemyHasChange()
	{
		return !_enemyConfig.Equals(_enmyConfigBackUp);
	}

	public bool CharacterHasChange()
	{
		return !_characterConfig.Equals(_characterConfigBackUp);
	}

	public bool SceneHasChange()
	{
		return !_enemyConfig.sceneId.Equals(_enmyConfigBackUp.sceneId);
	}

	public bool CharacterTeamHasChange()
	{
		List<int> list = worldTeamProfile.CharacterIds.ToList();
		List<int> list2 = G.localPlayer.teamInfo.PresetTeams[G.localPlayer.teamInfo.MainTeamIdx].CharacterIds.ToList();
		for (int i = 0; i < list2.Count; i++)
		{
			if (list2[i] != list[i])
			{
				return true;
			}
		}
		return false;
	}

	public void CopyBackToOrginalEnemyConfig()
	{
		_enmyConfigBackUp.CopyTo(_enemyConfig);
	}

	public void SaveEnemySelectConfig()
	{
		_enemyConfig.enemyId = _enmyConfigBackUp.enemyId;
		_enemyConfig.aiIndex = _enmyConfigBackUp.aiIndex;
		_enemyConfig.level = _enmyConfigBackUp.level;
	}

	public void CopyBackToOrginalCharacterConfig()
	{
		_characterConfigBackUp.B_CopyTO_A(_characterConfig);
	}

	public void SaveEnemyDynamicChangeValue()
	{
		_enmyConfigBackUp.CopyDynamicValue(_enemyConfig);
	}

	public void ResetOrginalConfig()
	{
		_characterConfig.Refresh();
		_enemyConfig.Refresh();
	}

	private bool HasContinueCharacterState()
	{
		if (!characterConfig.ultraEnergy && !characterConfig.skillEnergy && !characterConfig.invincible)
		{
			return characterConfig.superArmor;
		}
		return true;
	}

	private void ApplyCharacterRuntimeTags()
	{
		if (MonoECS.instance.sceneStatus != SceneStatus.Trainingground || !MonoECS.instance.mainEntity.IsValid)
		{
			ClearCharacterRuntimeTags();
			return;
		}
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (_characterRuntimeTagEntity.IsValid && _characterRuntimeTagEntity != mainEntity)
		{
			if (_runtimeInvincibleApplied)
			{
				SetRuntimeMotionTag(_characterRuntimeTagEntity, MotionTag_backUp.Invincibility, isOn: false);
			}
			if (_runtimeSuperArmorApplied)
			{
				SetRuntimeMotionTag(_characterRuntimeTagEntity, MotionTag_backUp.SuperArmor, isOn: false);
			}
			_runtimeInvincibleApplied = false;
			_runtimeSuperArmorApplied = false;
		}
		_characterRuntimeTagEntity = mainEntity;
		SetRuntimeMotionTagIfChanged(mainEntity, MotionTag_backUp.Invincibility, characterConfig.invincible, ref _runtimeInvincibleApplied);
		SetRuntimeMotionTagIfChanged(mainEntity, MotionTag_backUp.SuperArmor, characterConfig.superArmor, ref _runtimeSuperArmorApplied);
	}

	private void ClearCharacterRuntimeTags()
	{
		if (_characterRuntimeTagEntity.IsValid)
		{
			if (_runtimeInvincibleApplied)
			{
				SetRuntimeMotionTag(_characterRuntimeTagEntity, MotionTag_backUp.Invincibility, isOn: false);
			}
			if (_runtimeSuperArmorApplied)
			{
				SetRuntimeMotionTag(_characterRuntimeTagEntity, MotionTag_backUp.SuperArmor, isOn: false);
			}
		}
		_characterRuntimeTagEntity = default;
		_runtimeInvincibleApplied = false;
		_runtimeSuperArmorApplied = false;
	}

	private void SetRuntimeMotionTagIfChanged(Entity entity, MotionTag_backUp tag, bool isOn, ref bool applied)
	{
		if (applied != isOn)
		{
			SetRuntimeMotionTag(entity, tag, isOn);
			applied = isOn;
		}
	}

	private void SetRuntimeMotionTag(Entity entity, MotionTag_backUp tag, bool isOn)
	{
		if (entity.IsValid && entity.TryGetCompMotion(out CompMotion component))
		{
			if (isOn)
			{
				component.AddRuntimeMotionTag(tag);
			}
			else
			{
				component.RemoveRuntimeMotionTag(tag);
			}
			component.UpdateMotionTags();
		}
	}

	public void SetContinueCharacterState()
	{
		ApplyCharacterRuntimeTags();
		if (!HasContinueCharacterState())
		{
			if (loopframe.IsValid())
			{
				loopframe.Cancel();
			}
		}
		else
		{
			if (loopframe.IsValid())
			{
				return;
			}
			loopframe = FixedUpdateTimer.Default.LoopFrame(1, () =>
			{
				if (MonoECS.instance.sceneStatus != SceneStatus.Trainingground)
				{
					ClearCharacterRuntimeTags();
				}
				else
				{
					ApplyCharacterRuntimeTags();
					List<ACT.Battle.Skill> list = MonoECS.instance.mainEntity.GetCompMotion()?.skills;
					if (list != null)
					{
						CompAbility compAbility = MonoECS.instance.mainEntity.GetCompAbility();
						if (characterConfig.skillEnergy)
						{
							foreach (ACT.Battle.Skill item in list)
							{
								if (item.config.name.IndexOf("specialAttackCD", StringComparison.Ordinal) >= 0)
								{
									item.SetSkillCd(0f, exceeds: false);
								}
							}
							compAbility.ModifyNormalEnergy(compAbility.MaxNormalEnergy);
						}
						if (characterConfig.ultraEnergy)
						{
							compAbility.CurrentUltimateSkillValue += 50f;
							foreach (ACT.Battle.Skill item2 in list)
							{
								if (item2.config.name == "skillCD")
								{
									item2.SetSkillCd(0f, exceeds: false);
								}
							}
						}
					}
				}
			});
		}
	}
}
