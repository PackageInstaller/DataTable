using System;
using ACT.Battle.ECS.System;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[Obsolete]
[AbilityTypeMetadata("执行镜头", "Action", new string[] { "camera", "fov", "volume" })]
public class ActionCamera : ConfigAction
{
	public CameraConfig config;

	public bool needCasterFaceDir;

	public bool needCasterFaceDirToChangeCamera;

	public CameraConfig leftConfig;

	public YooAssetReference assetAssetID;

	public YooAssetReference leftAssetAssetID;

	public ConfigFunction<Vector3> posFunc;

	protected override AbilityAuth defaultAuth => AbilityAuth.ClientOwner;

	public override void Do(ActionMemory memory)
	{
		if (config.vCam == BattleConsts.MAINCAM)
		{
			Singleton<GameManager>.instance.ecsManager.systemAbility.ChangeVCamera(config.vCam);
			return;
		}
		Vector3 pos = ((posFunc != null) ? posFunc.Return(memory) : default(Vector3));
		bool canUsePos = posFunc != null;
		if (string.IsNullOrEmpty(config.vCam))
		{
			config.vCam = BattleConsts.MAINCAM;
		}
		Entity entity = memory.target.entity;
		bool flag = entity.IsTrajectory();
		bool flag2 = entity.IsFaceLeft();
		if (needCasterFaceDirToChangeCamera)
		{
			VCameraParams p = new VCameraParams
			{
				patternAssetID = ((!flag && !flag2) ? assetAssetID : leftAssetAssetID),
				config = ((!flag && !flag2) ? config : leftConfig),
				caster = memory.target.entity,
				canUsePos = canUsePos,
				pos = pos
			};
			Singleton<GameManager>.instance.ecsManager.systemAbility.LoadVCamera(p);
			return;
		}
		if (needCasterFaceDir && !flag)
		{
			Singleton<GameManager>.instance.ecsManager.systemAbility.SetVCamAnimatorParam(flag2);
		}
		VCameraParams p2 = new VCameraParams
		{
			patternAssetID = assetAssetID,
			config = config,
			caster = ((config.vCam == BattleConsts.MAINCAM) ? MonoECS.instance.mainEntity : memory.target.entity),
			canUsePos = canUsePos,
			pos = pos
		};
		Singleton<GameManager>.instance.ecsManager.systemAbility.LoadVCamera(p2);
	}
}
