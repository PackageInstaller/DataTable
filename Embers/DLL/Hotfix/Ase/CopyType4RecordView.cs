using GameFramework.Runtime;
using TMPro;
using UnityEngine.UI;

namespace Ase;

public class CopyType4RecordView : UGuiView
{
	public Button btnClose;

	public TextMeshProUGUI copyRankName;

	public TextMeshProUGUI date;

	public TextMeshProUGUI star;

	private CopyType4RecordViewModel viewModel;

	protected override void OnInit(object userData)
	{
		viewModel = GetUserData<CopyType4RecordViewModel>(userData);
		btnClose.onClick.AddListener(delegate
		{
			base.gameObject.SetActive(value: false);
		});
		((TMP_Text)copyRankName).text = viewModel.CopyRankName;
		((TMP_Text)date).text = viewModel.Date;
		((TMP_Text)star).text = $"{viewModel.StarGet}/{viewModel.StarMax}";
	}

	public override void RefreshData(object userData)
	{
		viewModel = GetUserData<CopyType4RecordViewModel>(userData);
		this.SetDataContext(viewModel);
	}
}
