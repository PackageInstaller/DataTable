using System.Collections.Generic;

namespace Ase;

public class GetErrorDialogViewModel : OptionBase
{
	private List<KnapsackItemViewModel> attachmentGetErrorList;

	public List<KnapsackItemViewModel> AttachmentGetErrorList => attachmentGetErrorList;

	public override void ItemOnClick(object obj)
	{
	}

	public GetErrorDialogViewModel()
	{
	}

	public GetErrorDialogViewModel(OptionBase parent, List<PropDataBase> itemsGet)
	{
		base.parent = parent;
		attachmentGetErrorList = new List<KnapsackItemViewModel>();
		foreach (PropDataBase item in itemsGet)
		{
			attachmentGetErrorList.Add(new KnapsackItemViewModel(this, item));
		}
	}
}
