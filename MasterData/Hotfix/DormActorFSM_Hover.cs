using System.Collections.Generic;
using TrueSync;
using UnityEngine;

public class DormActorFSM_Hover : DormActorFSM
{
	private List<DormFurObj> _highlightedInteractableFurnitures;

	private AdventureFXPlayer _topOfHeadFX;

	private AdventureFXPlayer _posMarkFX;

	public DormActorFSM_Hover(DormActor actor, int state)
		: base(actor, state)
	{
	}

	public override void OnEnter(object data = null)
	{
		base.OnEnter(data);
		actor.DisableMovment();
		actor.SetAvoidanceSimulationEnabled(enable: false);
		actor.SyncMovementLocation(new TSVector2(actor.transform.position.x, actor.transform.position.z), 0.2f);
		actor.PlayCatchAnim();
		_topOfHeadFX = actor.PlayFX("Assets/AssetBundles/FX/Dorm/UI/fx_dorm_ui_hand_catch.prefab");
		_posMarkFX = actor.PlayFX("Assets/AssetBundles/FX/Dorm/UI/fx_dorm_ui_drop_point.prefab");
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("Home_UI_catch");
		actor.ActiveHighlightDisplay(outline: true, displayOnTop: true);
		FaceCameraWithOffset(210f);
		DormLevelController dormLevelController = ModuleController<DormModuleController>.Instance.levelInstance as DormLevelController;
		_highlightedInteractableFurnitures = dormLevelController.QueryInteractableFurnituresForActor(actor);
		if (_highlightedInteractableFurnitures != null)
		{
			for (int i = 0; i < _highlightedInteractableFurnitures.Count; i++)
			{
				_highlightedInteractableFurnitures.get_Item(i)?.ActiveHighlightDisplay(outline: true);
			}
		}
	}

	public override void OnExit()
	{
		actor.EnableMovment();
		actor.SyncMovementLocation(new TSVector2(actor.transform.position.x, actor.transform.position.z), 0);
		actor.SetAvoidanceSimulationEnabled(enable: true);
		MonoSingleton<WwiseAudioManager>.Instance.PlaySound("Home_UI_put");
		actor.StopCatchAnim();
		if (_topOfHeadFX != null)
		{
			_topOfHeadFX.Stop();
			_topOfHeadFX = null;
		}
		if (_posMarkFX != null)
		{
			_posMarkFX.Stop();
			_posMarkFX = null;
		}
		actor.DeactiveHighlightDisplay();
		if (_highlightedInteractableFurnitures != null)
		{
			for (int i = 0; i < _highlightedInteractableFurnitures.Count; i++)
			{
				_highlightedInteractableFurnitures.get_Item(i)?.DeactiveHighlightDisplay();
			}
			_highlightedInteractableFurnitures = null;
		}
		base.OnExit();
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		actor.SyncTimelineAnimationTransform();
	}

	private void FaceCameraWithOffset(float offsetDegrees)
	{
		Camera mainCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
		if (!(mainCamera == null))
		{
			Vector3 forward = mainCamera.transform.forward;
			forward.y = 0f;
			if (!(forward.sqrMagnitude < 1E-06f))
			{
				float y = Quaternion.LookRotation(forward).eulerAngles.y;
				actor.SyncRotation(y + offsetDegrees);
			}
		}
	}
}
