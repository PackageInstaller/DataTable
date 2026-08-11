using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class NPCPopDialogView : UGuiView
{
	public PopDialogFitter popDialogTemplate;

	private Dictionary<int, PopDialogFitter> dialogFitters = new Dictionary<int, PopDialogFitter>();

	private NPCPopDialogViewModel viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<NPCPopDialogViewModel>(userData);
		BindingSet<NPCPopDialogView, NPCPopDialogViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((NPCPopDialogView v) => v.ShowDialog).To((NPCPopDialogViewModel vm) => vm.ShowDialogRequest);
		bindingSet.Bind(this).For((NPCPopDialogView v) => v.CloseDialog).To((NPCPopDialogViewModel vm) => vm.CloseDialogRequest);
		NPCPopDialogViewModel nPCPopDialogViewModel = viewModel;
		nPCPopDialogViewModel.updatePosCall = (Action)Delegate.Combine(nPCPopDialogViewModel.updatePosCall, new Action(UpdatePos));
		bindingSet.Build();
	}

	private void UpdatePos()
	{
		foreach (PopDialogFitter value in dialogFitters.Values)
		{
			value.UpdatePos();
		}
	}

	private void ShowDialog(object sender, InteractionEventArgs e)
	{
		NPCDialogData data = (NPCDialogData)e.Context;
		if (!dialogFitters.ContainsKey(data.id))
		{
			PopDialogFitter component = UnityEngine.Object.Instantiate(popDialogTemplate.gameObject, RectTransform).GetComponent<PopDialogFitter>();
			component.Init(viewModel.NpcDialogDatas[data.id], delegate
			{
				DestroyDialogById(data.id);
			});
			dialogFitters.Add(data.id, component);
			component.gameObject.SetActive(value: true);
		}
	}

	private void CloseDialog(object sender, InteractionEventArgs e)
	{
		NPCDialogData nPCDialogData = (NPCDialogData)e.Context;
		DestroyDialogById(nPCDialogData.id);
	}

	private void DestroyDialogById(int id)
	{
		if (dialogFitters.ContainsKey(id))
		{
			dialogFitters[id].gameObject.SetActive(value: false);
			UnityEngine.Object.Destroy(dialogFitters[id].gameObject);
			dialogFitters.Remove(id);
		}
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<NPCPopDialogViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
