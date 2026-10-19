using ACT.Battle.ECS.System;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("虚拟镜头效果", "Mixin", new string[] { "virtual", "camera" })]
public class ConfigMixinVirtualCamera : ConfigMixin
{
	public abstract class BaseVirtualCamera
	{
		public ConfigFunction<Vector3> posFunc;

		internal CameraRuntimeItem m_Item;

		public abstract void Load(ActionMemory memory);

		public abstract void Release();
	}

	public class NormalType : BaseVirtualCamera
	{
		public enum NormalTypeSetType
		{
			normal,
			dependsDir
		}

		public YooAssetReference virtualCameraReferenceAssetID;

		public CameraConfig config;

		public NormalTypeSetType normalTypeSetType;

		public YooAssetReference leftReferenceAssetID;

		public CameraConfig leftConfig;

		public override void Load(ActionMemory memory)
		{
			Vector3 pos = posFunc?.Return(memory) ?? memory.caster.GetMono().transform.position;
			bool flag = memory.target.entity.IsFaceLeft();
			VCameraParams p = new VCameraParams
			{
				patternAssetID = ((normalTypeSetType != NormalTypeSetType.dependsDir) ? virtualCameraReferenceAssetID : ((!flag) ? virtualCameraReferenceAssetID : leftReferenceAssetID)),
				config = ((normalTypeSetType != NormalTypeSetType.dependsDir) ? config : ((!flag) ? config : leftConfig)),
				caster = memory.target.entity,
				canUsePos = (posFunc != null),
				pos = pos
			};
			m_Item = GameManager.abilitySystem.LoadVCamera(p);
		}

		public override void Release()
		{
			if (m_Item != null && m_Item.go != null)
			{
				Singleton<GameManager>.instance.ecsManager.systemAbility.ReleaseCameraItem(m_Item);
			}
		}
	}

	public BaseVirtualCamera configVirtualCamera;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinVirtualCamera(this, ab, index);
	}
}
