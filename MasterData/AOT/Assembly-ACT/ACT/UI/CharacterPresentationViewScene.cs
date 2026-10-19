using System;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Rendering;
using ACT.Utility;
using Bamboo.AssetField;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class CharacterPresentationViewScene : BaseUIScene
{
	public enum SceneState
	{
		None,
		Over
	}

	[SerializeField]
	private GameObject characterModelRoot;

	private AssetLoadHandle _modelHandle;

	private AssetLoadHandle _animationHandle;

	private GameObject _modelPrefab;

	private GameObject _model;

	private Animator _animator;

	private int _characterId;

	private SceneState _sceneState;

	public static CharacterPresentationViewScene Default => Singleton<UISceneManager>.instance.GetScene<CharacterPresentationViewScene>();

	public override void OnLoadComplete()
	{
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Close_MainLight, null);
	}

	public override void Open()
	{
		GameRenderScene.Set(GameRenderScene.Scene.CharacterTeam);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Close_MainLight, null);
		base.Open();
	}

	public override void Close()
	{
		GameRenderScene.Set(GameRenderScene.Scene.MainBattle);
		base.Close();
	}

	public override void OnRelease()
	{
		ReleaseCharacterModel();
		_characterId = 0;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Open_MainLight, null);
	}

	protected override void OnDestroy()
	{
		ReleaseCharacterModel();
		base.OnDestroy();
	}

	public void ShowCharacterModel(int id, ICharacterSource characterSource, int skinId = 0)
	{
		if (_characterId != id)
		{
			_characterId = id;
			ShowCharacterModelImply(id, characterSource, skinId);
		}
	}

	public void ChangeCharacterModel(int id, ICharacterSource characterSource, int skinId = 0)
	{
		_characterId = id;
		ShowCharacterModelImply(id, characterSource, skinId);
	}

	public void ResetCharcterAni()
	{
		ApplySceneState();
	}

	public void ClearCharacterModel()
	{
		ReleaseCharacterModel();
		_characterId = 0;
		_sceneState = SceneState.None;
	}

	public void SetSceneState(SceneState state)
	{
		_sceneState = state;
		ApplySceneState();
	}

	private void ApplySceneState()
	{
		if (!(_animator == null) && _sceneState != SceneState.None)
		{
			_animator.CrossFade(_sceneState.ToString(), 0f, 0, 0f);
		}
	}

	private void ShowCharacterModelImply(int characterId, ICharacterSource characterSource, int skinId = 0)
	{
		EntityCharacterData data = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		if (data != null)
		{
			int skinId2;
			if (skinId != 0)
			{
				skinId2 = skinId;
			}
			else
			{
				skinId2 = ((characterSource == null) ? characterId : CharacterSkinRuntimeUtility.ResolveSkinId(characterId, characterSource));
			}
			ReleaseCharacterModel();
			LoadCharacterModelAsync(characterSource, data, skinId2);
		}
	}

	private void LoadCharacterModelAsync(ICharacterSource characterSource, EntityCharacterData characterData, int skinId)
	{
		string modelPath = CharacterSkinRuntimeUtility.GetModelPath(characterData.id, skinId, CharacterModelUsage.Character);
		if (string.IsNullOrEmpty(modelPath))
		{
			return;
		}
		AssetLoadHandle modelHandle;
		try
		{
			modelHandle = AssetStationManager.BattleStation.InstantiateAsync(modelPath, characterModelRoot.transform);
		}
		catch (OperationCanceledException)
		{
			return;
		}
		if (!AssetLoadHandleExtensions.IsValid(modelHandle))
		{
			return;
		}
		_modelHandle = modelHandle;
		_modelHandle.Completed += (AssetLoadHandle handle) =>
		{
			if (AssetLoadHandleExtensions.IsValid(modelHandle))
			{
				_modelPrefab = modelHandle.AsGameObject();
				string animatorAssetId = CharacterSkinRuntimeUtility.GetAnimatorAssetId(skinId, CharacterModelUsage.Character);
				if (!string.IsNullOrEmpty(animatorAssetId))
				{
					_animationHandle = AssetStationManager.BattleStation.Load<RuntimeAnimatorController>(animatorAssetId);
					CharacterSkinRuntimeUtility.ApplyAnimatorOverride(_modelPrefab, _animationHandle.As<RuntimeAnimatorController>());
				}
				if (characterSource != null)
				{
					_modelPrefab.GetComponent<MonoDestinyEffect>()?.Binding(characterSource);
				}
				_model = CharacterSkinRuntimeUtility.ResolveDisplayObject(_modelPrefab);
				_model.transform.localPosition = Vector3.zero;
				_modelPrefab.GetComponent<MonoEntityConfig>()?.SetRenderLayerToCharacterUIScene();
				_animator = _model.GetComponentInChildren<Animator>();
				_animator.applyRootMotion = false;
				_model.SetActive(value: true);
				ApplySceneState();
			}
		};
	}

	private void ReleaseCharacterModel()
	{
		_animator = null;
		_model = null;
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
		_modelPrefab = null;
	}
}
