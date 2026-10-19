using System.Collections.Generic;
using System.Threading;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using UI.ViewComponent.BattlemainView.ActComponent;
using UnityEngine;

namespace ACT.UI;

public interface IBaseUIView : IBaseUIComponent
{
	GameObject gameObject { get; }

	UI_LAYER UILayer { get; }

	List<SafeArea> SafeArea { get; }

	Canvas ContentCanvas { get; }

	List<ActComponent> uiComponents { get; }

	Transform transform { get; }

	bool isEmpty { get; }

	UI_TYPE UIType { get; }

	ImageAssetStation Station { get; }

	IBaseUIController UIController { get; }

	IInputController InputController { get; }

	void Close();

	void BindUIController(IBaseUIController uiController);

	void Init(object data);

	void UnInit();

	UniTask PreShow(CancellationToken token);

	UniTask Show(CancellationToken token);

	void ReShow(object newData);

	UniTask Hide(CancellationToken token);

	UniTask PushToStack(CancellationToken token);

	UniTask PopFromStack(CancellationToken token);

	void SetSortingLayer(int layer);

	void InitializeHiddenState();

	void OnMoveToShow();

	void OnMoveToHide();

	void ActivateSubView(ISubUIView subUIView);

	void DeactivateSubViewInput(ISubUIView subUIView);

	IReadOnlyList<ISubUIView> GetActivateSubUIViews();

	Transform FindGuideTarget(string id);

	void RegisterGuideTarget(GuideTargetNode node);

	void UnregisterGuideTarget(GuideTargetNode node);

	void InvokeElementsInit();

	void InvokeElementsAddListener();

	void InvokeElementsRemoveListener();

	void InvokeElementsUnInit();

	void InvokeElementsPushInStack();

	void InvokeElementsPopUpStack();

	void InvokeElementsOnUIDestroy();

	void ClearElements();
}
