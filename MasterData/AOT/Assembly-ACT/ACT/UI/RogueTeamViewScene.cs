using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Rendering;
using ACT.Utility;
using Bamboo.AssetField;
using Cinemachine;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class RogueTeamViewScene : BaseUIScene
{
	private const string IdleStateName = "idle";

	[SerializeField]
	private GameObject characterModelRoot;

	private const string Spine2 = "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2";

	[SerializeField]
	private CinemachineVirtualCamera fullBodyCamera;

	[SerializeField]
	private float _vcamYOffset;

	private int _characterId;

	private int _loadVersion;

	private AssetLoadHandle _modelHandle;

	private AssetLoadHandle _animationHandle;

	private Animator _animator;

	public static RogueTeamViewScene Default => Singleton<UISceneManager>.instance.GetScene<RogueTeamViewScene>();

	public override void Open()
	{
		GameRenderScene.Set(GameRenderScene.Scene.CharacterTeam);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Close_MainLight, null);
		base.Open();
	}

	public override void Close()
	{
		GameRenderScene.Set(GameRenderScene.Scene.MainBattle);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Open_MainLight, null);
		base.Close();
	}

	public override void OnRelease()
	{
		_loadVersion++;
		_characterId = 0;
		ReleaseCharacterModel();
		base.OnRelease();
	}

	public void ShowCharacterModel(ICharacterSource characterSource)
	{
		if (characterSource == null)
		{
			return;
		}
		int characterId = characterSource.Id();
		if (_characterId == characterId && AssetLoadHandleExtensions.IsValid(_modelHandle))
		{
			return;
		}
		_characterId = characterId;
		int loadVersion = ++_loadVersion;
		ReleaseCharacterModel();
		int skinId = CharacterSkinRuntimeUtility.ResolveSkinId(characterId, characterSource);
		string modelPath = CharacterSkinRuntimeUtility.GetModelPath(characterId, skinId, CharacterModelUsage.Character);
		if (string.IsNullOrEmpty(modelPath))
		{
			return;
		}
		AssetLoadHandle assetLoadHandle = AssetStationManager.BattleStation.InstantiateAsync(modelPath, characterModelRoot.transform);
		if (AssetLoadHandleExtensions.IsValid(assetLoadHandle))
		{
			_modelHandle = assetLoadHandle;
			assetLoadHandle.Completed += (AssetLoadHandle handle) =>
			{
				OnCharacterModelLoaded(handle, characterSource, characterId, skinId, loadVersion);
			};
		}
	}

	public void ResetCharcterAni()
	{
		_animator?.CrossFade("idle", 0f, 0, 0f);
	}

	private void OnCharacterModelLoaded(AssetLoadHandle handle, ICharacterSource characterSource, int characterId, int skinId, int loadVersion)
	{
		if (!AssetLoadHandleExtensions.IsValid(handle) || _characterId != characterId || _loadVersion != loadVersion)
		{
			return;
		}
		GameObject gameObject = handle.AsGameObject();
		if (!(gameObject == null))
		{
			string animatorAssetId = CharacterSkinRuntimeUtility.GetAnimatorAssetId(skinId, CharacterModelUsage.Skin);
			if (!string.IsNullOrEmpty(animatorAssetId))
			{
				_animationHandle = AssetStationManager.BattleStation.Load<RuntimeAnimatorController>(animatorAssetId);
				CharacterSkinRuntimeUtility.ApplyAnimatorOverride(gameObject, _animationHandle.As<RuntimeAnimatorController>());
			}
			gameObject.GetComponent<MonoDestinyEffect>()?.Binding(characterSource);
			gameObject.GetComponent<MonoEntityConfig>()?.SetRenderLayerToCharacterUIScene();
			GameObject gameObject2 = CharacterSkinRuntimeUtility.ResolveDisplayObject(gameObject);
			gameObject2.transform.localPosition = Vector3.zero;
			gameObject2.SetActive(value: true);
			AdjustCameraHeight(gameObject2);
			_animator = gameObject2.GetComponentInChildren<Animator>(includeInactive: true);
			if (_animator != null)
			{
				_animator.applyRootMotion = false;
				_animator.CrossFade("idle", 0f, 0, 0f);
			}
			gameObject.GetComponent<AniPartControl>()?.PlayVisible(AniPartControl.PartType.SystemDither, 0.1f, default, null, reset: true);
		}
	}

	private void AdjustCameraHeight(GameObject model)
	{
		Transform transform = model.transform.Find("Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2");
		if (!transform)
		{
			transform = model.transform.GetChild(0).transform.Find("Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2");
		}
		Transform transform2 = fullBodyCamera.transform;
		transform2.position = new Vector3(transform2.position.x, transform.position.y + _vcamYOffset, transform2.position.z);
	}

	private void ReleaseCharacterModel()
	{
		_animator = null;
		if (AssetLoadHandleExtensions.IsValid(_modelHandle))
		{
			AssetStationManager.BattleStation.ReleaseInstance(_modelHandle);
			_modelHandle = default;
		}
		if (AssetLoadHandleExtensions.IsValid(_animationHandle))
		{
			AssetStationManager.BattleStation.Release(_animationHandle);
			_animationHandle = default;
		}
	}
}
