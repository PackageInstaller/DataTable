using GameFramework.Runtime;
using Sirenix.Utilities;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace Ase;

public class WorldMapWindow : UGuiWindow, IPointerClickHandler, IEventSystemHandler, IDragHandler, IBeginDragHandler, IEndDragHandler
{
	[SerializeField]
	private Button backBtn;

	[SerializeField]
	private Button back2MainBtn;

	[SerializeField]
	private Button btnTask;

	[SerializeField]
	private TextMeshProUGUI worldName;

	public float radialBlurDuration = 0.5f;

	public float cameraFovDiff = 5f;

	private bool _canDrag = true;

	private Vector2 _lastDragPos;

	private float _lastTouchFingerDis;

	private WorldMapViewModel _viewModel;

	public void OnPointerClick(PointerEventData eventData)
	{
		if (_viewModel.MapManager.Draging)
		{
			return;
		}
		GameObject touchGoByRay = _viewModel.MapManager.GetTouchGoByRay(eventData.position);
		if (touchGoByRay.SafeIsUnityNull())
		{
			return;
		}
		WorldMapItemBlock component = touchGoByRay.GetComponent<WorldMapItemBlock>();
		if (!(component == null))
		{
			if (component.AudioPlayer != null)
			{
				component.AudioPlayer.AudioInvoke();
			}
			_viewModel.ItemOnClick(component.DrData);
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		_viewModel.MapManager?.SetValidDrag(valid: true);
	}

	public void OnDrag(PointerEventData eventData)
	{
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		_viewModel.MapManager?.SetValidDrag(valid: false);
	}

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		_viewModel = GetData<WorldMapViewModel>();
		BindingSet<WorldMapWindow, WorldMapViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind().For((WorldMapWindow v) => v.OnDismissRequest).To((WorldMapViewModel vm) => vm.DismissRequest);
		bindingSet.Bind().For((WorldMapWindow v) => v.OpenUguiWindow).To((WorldMapViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((WorldMapWindow v) => ((UGuiWindow)v).OnVisibleChanged).To((WorldMapViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind().For((WorldMapWindow v) => v.CloseMapWorldScene).To((WorldMapViewModel vm) => vm.CloseMapWorldSceneRequest);
		bindingSet.Bind(backBtn).For((Button v) => v.onClick).To((WorldMapViewModel vm) => vm.Close);
		bindingSet.Bind(back2MainBtn).For((Button v) => v.onClick).To((WorldMapViewModel vm) => vm.Back2MainWindow);
		bindingSet.Bind(btnTask).For((Button v) => v.onClick).To((WorldMapViewModel vm) => vm.OpenTaskMainWindow);
		bindingSet.Bind().For((WorldMapWindow v) => v.Refresh).To((WorldMapViewModel vm) => vm.RefreshMapDataRequest);
		bindingSet.Build();
		_viewModel.RadialBlurDuration = radialBlurDuration;
		_viewModel.CameraFovDiff = cameraFovDiff;
	}

	private void CloseMapWorldScene(object sender, InteractionEventArgs e)
	{
		_viewModel.ClearWorldMapScene();
	}

	protected override void OnShow()
	{
		base.OnShow();
		Refresh();
	}

	protected override void OnVisibleChanged(object sender, InteractionEventArgs e)
	{
		bool flag = (bool)e.Context;
		CanvasGroup.alpha = (flag ? 1 : 0);
		CanvasGroup.interactable = flag;
		CanvasGroup.blocksRaycasts = flag;
	}

	private void Refresh(object sender = null, InteractionEventArgs e = null)
	{
		((TMP_Text)worldName).text = _viewModel.DrWorldMap.Name;
	}

	protected override void OnDestroy()
	{
		_viewModel.ClearWorldMapScene();
		base.OnDestroy();
	}
}
