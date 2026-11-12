using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/特殊实体/伞实体(子弹+多个挂点)")]
[DisallowMultipleComponent]
public class UmbrellaEntity : LogicEntity, ISpecialEntity
{
	public string bulletPath;

	public string linkFbx;

	public List<GameObject> attachs;

	public AnimationSlotConfigComponent.SlotType slotType;

	private AdventureActor _owner;

	private CoroutineNode corMain;

	private List<PlayFX> linkFxList = new List<PlayFX>();

	private AdventureBulletBase bullet;

	public AdventureActor Owner => _owner;

	protected override void OnInit()
	{
		base.OnInit();
	}

	protected override void OnActive()
	{
		base.OnActive();
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		DisableLogicUpdate();
		foreach (PlayFX linkFx in linkFxList)
		{
			linkFx.Stop();
		}
		linkFxList.Clear();
		if (bullet != null && !bullet.isFinished)
		{
			bullet.Kill();
		}
		_owner.StopLogicCoroutine(corMain);
		corMain = null;
		_owner = null;
		bullet = null;
	}

	public void Setup(AdventureActor owner)
	{
		_owner = owner;
		EnableLogicUpdate();
	}

	public void Shoot(TSVector2 shootDir, FP range, TSVector2 shootPosXZ, FP shootPosY = default(FP))
	{
		corMain = _owner.StartLogicCoroutine(OnMainLogic(shootDir, range, shootPosXZ, shootPosY), runImmediately: true);
	}

	public void SetSpeedAndLeftTime(FP speed, FP leftTime)
	{
		if (bullet != null)
		{
			bullet.velocitySpeed = speed;
			(bullet as AdventureBullet).LiftTime = leftTime;
		}
	}

	private IEnumerator OnMainLogic(TSVector2 shootDir, FP range, TSVector2 shootPosXZ, FP shootPosY)
	{
		bullet = ILRuntimeAPI.ShootByDirection(bulletPath, _owner, range, shootDir, shootPosXZ, shootPosY);
		Transform transform = ((slotType != AnimationSlotConfigComponent.SlotType.None) ? _owner.slotConfig.GetSlotNode(slotType) : _owner.transform);
		for (int i = 0; i < attachs.Count; i++)
		{
			GameObject targetObj = attachs.get_Item(i);
			PlayFX playFX = new PlayFX();
			playFX.PlayLinFx(_owner, linkFbx, 1f, useCustSource: false, transform.gameObject, TSVector.zero, tsTransform.PositionY, targetObj, TSVector.zero, tsTransform.PositionY);
			linkFxList.Add(playFX);
		}
		while (!bullet.isFinished)
		{
			tsTransform.Position = bullet.tsTransform.Position;
			tsTransform.PositionY = bullet.tsTransform.PositionY;
			tsTransform.Rotation = bullet.tsTransform.Rotation;
			yield return null;
		}
		Finish();
	}

	public void Finish()
	{
		SceneSingleton<SpecialEntityManager>.Instance.Despawn(transform);
	}
}
