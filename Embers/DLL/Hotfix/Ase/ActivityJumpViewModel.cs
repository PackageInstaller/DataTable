using GameFramework.Runtime;

namespace Ase;

public class ActivityJumpViewModel : ActivityViewModelBase
{
	private SimpleCommand jumpWindowCmd;

	public SimpleCommand JumpWindowCmd => jumpWindowCmd;

	public ActivityJumpViewModel()
	{
		jumpWindowCmd = new SimpleCommand(JumpWindow);
	}

	private async void JumpWindow()
	{
		jumpWindowCmd.Enabled = false;
		DRActivityDisplay dataRow = GameEntry.DataTable.GetDataRow((DRActivityDisplay p) => p.ActivityTypeId == base.ActivityTypeId);
		if (dataRow == null)
		{
			jumpWindowCmd.Enabled = true;
			return;
		}
		OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(new JumpWindowParams(dataRow.TargetWindow, dataRow.WindowParams), parent, "ActivityJumpView", delegate
		{
			jumpWindowCmd.Enabled = true;
		});
		if (openViewArg != null)
		{
			parent?.ItemOnClick(openViewArg);
		}
	}
}
