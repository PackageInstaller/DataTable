using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using ACT.World.StateObject;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.Bloodstain;

public class BloodstainView : MonoBehaviour
{
	private const float RecoveryRatio = 0.5f;

	private const int DefaultAttackableId = 2;

	[SerializeField]
	private Transform _rewardFlyEffectOrigin;

	[SerializeField]
	private float _rewardFlyEffectDuration = 0.5f;

	[SerializeField]
	private int _attackableId = 2;

	[SerializeField]
	private Vector3 _hitBoxSize = Vector3.one;

	private BloodstainData _data;

	private Entity _attackEntity;

	private bool _claiming;

	private bool _isDespawning;

	private static string[] _abilityStrings = new string[3] { "TestRecoverHP", "TestRecoverNE", "TestRecoverCE" };

	public string BloodstainId => _data?.BloodstainId;

	public bool IsDespawning => _isDespawning;

	public void Bind(BloodstainData data)
	{
		ReleaseAttackProxy();
		_data = data?.Clone();
		_claiming = false;
		_isDespawning = false;
		if (_data != null)
		{
			transform.SetPositionAndRotation(_data.Position, _data.Rotation);
			SpawnAttackProxy();
		}
	}

	public void Release()
	{
		ReleaseAttackProxy();
		_data = null;
		_claiming = false;
		_isDespawning = false;
	}

	public void OnHitByLocalPlayer()
	{
		if (_data != null && !string.IsNullOrEmpty(_data.BloodstainId) && !_claiming && !_isDespawning && !_data.ClaimedByLocalPlayer)
		{
			_claiming = true;
			G.service?.ClaimBloodstain(_data.BloodstainId, (bool success, IList<UniversalItem> rewards) =>
			{
				OnClaimBloodstain(success, rewards?.ToItems());
			});
		}
	}

	private void SpawnAttackProxy()
	{
		if (_data == null || _attackEntity.IsValid || MonoECS.instance == null)
		{
			return;
		}
		if (!RuntimeConfigs.data.entityNeutralDatas.ContainsKey(_attackableId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"Bloodstain attackable entityNeutralData {_attackableId} not exist");
			}
		}
		else
		{
			_attackEntity = GameManager.entities.factory.CreateAttackEntity();
			MonoECS.instance.SpawnAttackInteractObject(_attackEntity, _attackableId, 0, 2, _data.Position, Alliance.Netural, _hitBoxSize, _data.Rotation);
			CompAbility? compAbility = _attackEntity.GetCompAbility();
			compAbility.damageableHited = (Action<Entity>)Delegate.Combine(compAbility.damageableHited, new Action<Entity>(OnAttackProxyHited));
		}
	}

	private void ReleaseAttackProxy()
	{
		if (_attackEntity.IsValid)
		{
			CompAbility compAbility = _attackEntity.GetCompAbility();
			if (compAbility != null)
			{
				compAbility.damageableHited = (Action<Entity>)Delegate.Remove(compAbility.damageableHited, new Action<Entity>(OnAttackProxyHited));
			}
			if (MonoECS.instance != null)
			{
				MonoECS.instance.TryRemoveBehave(_attackEntity);
			}
			_attackEntity = default;
		}
	}

	private void OnAttackProxyHited(Entity attacker)
	{
		if (IsLocalPlayerTeamEntity(attacker))
		{
			OnHitByLocalPlayer();
		}
	}

	private static bool IsLocalPlayerTeamEntity(Entity attacker)
	{
		MPPlayer mPPlayer = MonoECS.instance?.localPlayer;
		if (attacker.IsValid && mPPlayer != null)
		{
			return mPPlayer.IndexOfTeamCharacter(attacker) != -1;
		}
		return false;
	}

	private void OnClaimBloodstain(bool success, List<Item> rewards)
	{
		_claiming = false;
		if (success && _data != null)
		{
			string bloodstainId = _data.BloodstainId;
			_isDespawning = true;
			if (rewards != null && rewards.Count > 0)
			{
				PropPickingUtility.DispatchPropPickingEvt(rewards, PropPickingWay.Normal, StateObjectType.GeneralInteract);
			}
			PlayClaimSequenceAsync(bloodstainId).Forget();
		}
	}

	private async UniTaskVoid PlayClaimSequenceAsync(string bloodstainId)
	{
		if (!(await PlayRewardFlyEffectAsync().SuppressCancellationThrow()))
		{
			ApplyBloodstainRecovery();
			if (Model<BloodstainModel>.HasInstance())
			{
				Model<BloodstainModel>.Interface.RemoveBloodstain(bloodstainId);
			}
			if (Singleton<BloodstainRuntimeManager>.HasInstance())
			{
				Singleton<BloodstainRuntimeManager>.instance.FinishDespawnView(bloodstainId);
			}
		}
	}

	private async UniTask PlayRewardFlyEffectAsync()
	{
		Vector3 vector = ((_rewardFlyEffectOrigin != null) ? _rewardFlyEffectOrigin.position : transform.position);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"Bloodstain reward fly effect placeholder at {vector}");
		}
		await UniTask.Delay(TimeSpan.FromSeconds(_rewardFlyEffectDuration), ignoreTimeScale: false, PlayerLoopTiming.Update, destroyCancellationToken);
	}

	private static void ApplyBloodstainRecovery()
	{
		MonoECS instance = MonoECS.instance;
		if (instance?.localPlayer == null)
		{
			return;
		}
		MPPlayer localPlayer = instance.localPlayer;
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = localPlayer.GetTeamCharacter(i);
			if (!teamCharacter.IsValid || !teamCharacter.IsAlive())
			{
				continue;
			}
			CompAbility compAbility = teamCharacter.GetCompAbility();
			if (compAbility != null)
			{
				for (int j = 0; j < _abilityStrings.Length; j++)
				{
					string abName = _abilityStrings[j];
					compAbility.AddAbility(teamCharacter, abName, AbilitySource.BloodBottle, default, 1);
					compAbility.RemoveAbility(abName);
				}
			}
		}
	}
}
