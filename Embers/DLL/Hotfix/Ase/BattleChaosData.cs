using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BattleChaosData : ViewModelBase
{
	private float normalBullet;

	private float normalBulletMax = -1f;

	private float reloading;

	private float reloadingMax;

	private InteractionRequest<Vector3> updateReloadingPosRequest;

	public float NormalBullet
	{
		get
		{
			return normalBullet;
		}
		set
		{
			Set(ref normalBullet, value, "NormalBullet");
			if (normalBulletMax == -1f)
			{
				NormalBulletMax = value;
			}
		}
	}

	public float NormalBulletMax
	{
		get
		{
			return normalBulletMax;
		}
		private set
		{
			Set(ref normalBulletMax, value, "NormalBulletMax");
		}
	}

	public float Reloading
	{
		get
		{
			return reloading;
		}
		set
		{
			Set(ref reloading, value, "Reloading");
		}
	}

	public float ReloadingMax
	{
		get
		{
			return reloadingMax;
		}
		set
		{
			Set(ref reloadingMax, value, "ReloadingMax");
		}
	}

	public IInteractionRequest UpdateReloadingPosRequest => updateReloadingPosRequest;

	public BattleChaosData()
	{
		updateReloadingPosRequest = new InteractionRequest<Vector3>();
	}

	public void SetReloading(float reloadingFill, Vector3 pos)
	{
		Reloading = reloadingFill;
		updateReloadingPosRequest.Raise(pos);
	}
}
