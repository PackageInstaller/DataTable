using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class InputConfirmWindow : UGuiWindow
{
	[SerializeField]
	private TextMeshProUGUI title;

	[SerializeField]
	private TextMeshProUGUI tips;

	[SerializeField]
	private InputField inputField;

	[SerializeField]
	private Button btnPaste;

	[SerializeField]
	private Button btnOutside;

	[SerializeField]
	private Button btnClose;

	[SerializeField]
	private Button btnConfirm;

	private InputConfirmViewModel _viewModel;

	protected override void OnCreate(IBundle bundle)
	{
		//IL_085c: Unknown result type (might be due to invalid IL or missing references)
		//IL_086d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0888: Unknown result type (might be due to invalid IL or missing references)
		base.OnCreate(bundle);
		_viewModel = GetData<InputConfirmViewModel>();
		Text component = inputField.placeholder.GetComponent<Text>();
		BindingSet<InputConfirmWindow, InputConfirmViewModel> bindingSet = this.CreateBindingSet(_viewModel);
		bindingSet.Bind(this).For((InputConfirmWindow v) => v.OnDismissRequest).To((InputConfirmViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((InputConfirmWindow v) => v.OpenUguiWindow).To((InputConfirmViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(btnOutside).For((Button v) => v.onClick).To((InputConfirmViewModel vm) => vm.Close);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((InputConfirmViewModel vm) => vm.Close);
		bindingSet.Bind<TextMeshProUGUI>(title).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((InputConfirmViewModel vm) => vm.Title);
		bindingSet.Bind<TextMeshProUGUI>(tips).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((InputConfirmViewModel vm) => vm.Tips);
		bindingSet.Bind(component).For((Text v) => v.text).To((InputConfirmViewModel vm) => vm.PlaceholderText);
		bindingSet.Bind(inputField).For((InputField v) => v.text, (InputField v) => v.onEndEdit).To((InputConfirmViewModel vm) => vm.InputContent)
			.TwoWay();
		bindingSet.Bind(btnPaste).For((Button v) => v.onClick).To((InputConfirmViewModel vm) => vm.Paste);
		bindingSet.Bind(btnPaste.gameObject).For((GameObject v) => v.activeSelf).To((InputConfirmViewModel vm) => vm.ShowPasteBtn);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((InputConfirmViewModel vm) => vm.OnBtnConfirmClick);
		bindingSet.Build();
		inputField.characterLimit = _viewModel.CharacterLimit;
		((TMP_Text)tips).alignment = _viewModel.TipsAnchor;
		component.alignment = _viewModel.PlaceholderAnchor;
		inputField.textComponent.alignment = _viewModel.InputAnchor;
	}
}
