using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourPresetNameView : UGuiView
{
	[SerializeField]
	private GameObject createTitle;

	[SerializeField]
	private GameObject renameTitle;

	[SerializeField]
	private TMP_InputField nameInput;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private Button btnCancel;

	[SerializeField]
	private Button btnCancel2;

	private ArmourPresetNameViewModel viewModel;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		viewModel = GetUserData<ArmourPresetNameViewModel>(userData);
		BindingSet<ArmourPresetNameView, ArmourPresetNameViewModel> bindingSet = this.CreateBindingSet(viewModel);
		if ((UnityEngine.Object)(object)nameInput != null)
		{
			bindingSet.Bind<TMP_InputField>(nameInput).For((Expression<Func<TMP_InputField, string>>)((TMP_InputField v) => v.text), (Expression<Func<TMP_InputField, OnChangeEvent>>)((TMP_InputField v) => v.onValueChanged)).To((ArmourPresetNameViewModel vm) => vm.PresetName)
				.TwoWay();
		}
		if (btnConfirm != null)
		{
			bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((ArmourPresetNameViewModel vm) => vm.OptCmd)
				.CommandParameter("Confirm");
		}
		if (btnCancel != null)
		{
			bindingSet.Bind(btnCancel).For((Button v) => v.onClick).To((ArmourPresetNameViewModel vm) => vm.OptCmd)
				.CommandParameter("Cancel");
		}
		if (btnCancel2 != null)
		{
			bindingSet.Bind(btnCancel2).For((Button v) => v.onClick).To((ArmourPresetNameViewModel vm) => vm.OptCmd)
				.CommandParameter("Cancel");
		}
		bindingSet.Build();
		InitInput();
		RefreshView();
	}

	public override void RefreshData(object userData)
	{
		base.RefreshData(userData);
		viewModel = GetUserData<ArmourPresetNameViewModel>(userData);
		this.SetDataContext(viewModel);
		RefreshView();
	}

	private void InitInput()
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Expected O, but got Unknown
		if ((UnityEngine.Object)(object)nameInput != null)
		{
			nameInput.onValidateInput = new OnValidateInput(ValidateInput);
		}
	}

	private void RefreshView()
	{
		if (viewModel != null)
		{
			if (createTitle != null)
			{
				createTitle.SetActive(viewModel.CreateMode);
			}
			if (renameTitle != null)
			{
				renameTitle.SetActive(!viewModel.CreateMode);
			}
			if ((UnityEngine.Object)(object)nameInput != null)
			{
				nameInput.characterLimit = 6;
				nameInput.text = viewModel.PresetName;
				nameInput.ActivateInputField();
				((Selectable)(object)nameInput).Select();
			}
		}
	}

	private char ValidateInput(string text, int charIndex, char addedChar)
	{
		if (!ArmourPresetWindowViewModel.IsValidPresetNameChar(addedChar))
		{
			return '\0';
		}
		return addedChar;
	}
}
