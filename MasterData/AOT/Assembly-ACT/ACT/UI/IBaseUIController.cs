using System.Collections.Generic;

namespace ACT.UI;

public interface IBaseUIController
{
	uint Uid { get; }

	UI_TYPE UIType { get; }

	UIState State { get; }

	bool IsLoadOver { get; }

	UIExpectedState ExpectedState { get; set; }

	uint Parent { get; }

	IReadOnlyList<uint> Children { get; }

	IReadOnlyCollection<ISubUIView> ActivateSubViews { get; }

	UIPanelType PanelType { get; }

	int SortingLayerCount { get; }

	int SortingLayer { get; }

	int? ForceSortingLayer { get; }

	bool IsConnectSystem { get; }

	int SystemId { get; }

	bool DisableInputOnTransition { get; }

	bool RequireBlackScreenTransition { get; }

	bool RequirePauseGame { get; }

	bool RequireCatchScreen { get; }

	bool RequireBlurBackGround { get; }

	UITransitionStrategy TransitionStrategy { get; }

	UILifetimePolicy LifetimePolicy { get; }

	UIInstanceStrategy InstanceStrategy { get; }

	float LifetimeDelay { get; }

	float CloseTime { get; }

	bool IsInHideRoot { get; }

	bool IsBlurEnabled { get; }

	void Init(UI_TYPE type, uint uid);

	void SetUid(uint uid);

	void UnInit();

	void Open(object data);

	void Close();

	void CloseImmediately();

	void OpenView();

	void CloseView(UI_TYPE otherUIType);

	void PushStack(UI_TYPE otherUIType);

	void PopStack(UI_TYPE otherUIType);

	void SetParentUI(uint parent);

	void AddChildUI(uint child);

	void RemoveChildUI(uint child);

	void MoveToShowRoot();

	void MoveToHideRoot();

	void SetSortingLayer(int layer);

	IBaseUIView GetUIView();

	void ReOpen(object newData);
}
