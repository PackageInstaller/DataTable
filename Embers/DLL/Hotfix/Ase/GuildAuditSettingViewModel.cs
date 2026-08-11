using GameFramework.Runtime;

namespace Ase;

public class GuildAuditSettingViewModel : OptionBase
{
	private int applyLevelThreshold;

	private GuildDefinition.AuditType auditType;

	private int applyLevelMin;

	private int applyLevelMax;

	private InteractionRequest onApplyLevelThresholdChanged = new InteractionRequest();

	private SimpleCommand changeSettingCmd;

	private ISubscription<GuildMessage> onGuildMessage;

	public int ApplyLevelThreshold
	{
		get
		{
			return applyLevelThreshold;
		}
		set
		{
			Set(ref applyLevelThreshold, value, "ApplyLevelThreshold");
			onApplyLevelThresholdChanged.Raise();
		}
	}

	public GuildDefinition.AuditType AuditType
	{
		get
		{
			return auditType;
		}
		set
		{
			Set(ref auditType, value, "AuditType");
		}
	}

	public int ApplyLevelMin
	{
		get
		{
			return applyLevelMin;
		}
		set
		{
			Set(ref applyLevelMin, value, "ApplyLevelMin");
		}
	}

	public int ApplyLevelMax
	{
		get
		{
			return applyLevelMax;
		}
		set
		{
			Set(ref applyLevelMax, value, "ApplyLevelMax");
		}
	}

	public SimpleCommand ChangeSettingCmd => changeSettingCmd;

	public InteractionRequest OnApplyLevelThresholdChanged => onApplyLevelThresholdChanged;

	public GuildAuditSettingViewModel()
	{
	}

	public GuildAuditSettingViewModel(OptionBase parent, GuildDefinition.AuditType auditType, int applyLevel)
	{
		base.parent = parent;
		onGuildMessage = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<GuildMessage>(OnGuildMessageReceived);
		ApplyLevelMin = GuildDefinition.GetMinLevelForApply();
		ApplyLevelMax = GuildDefinition.GetMaxLevelForApply();
		ApplyLevelThreshold = applyLevel;
		AuditType = auditType;
		changeSettingCmd = new SimpleCommand(OnBtnChangeClick);
	}

	private void OnGuildMessageReceived(GuildMessage message)
	{
		if (message.Type == GuildMessageEnum.GuildPermissionChange)
		{
			MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.GetMyGuildData();
			if (myGuildData == null || !GuildDefinition.CheckGuildMemberPermission(myGuildData.Position, GuildDefinition.GuildPermissions.AuditSetting))
			{
				Close();
			}
		}
	}

	public void OnBtnLevelRedClick()
	{
		ApplyLevelThreshold--;
	}

	public void OnBtnLevelIncClick()
	{
		ApplyLevelThreshold++;
	}

	public void OnApplyLevelInputEndEdit(string content)
	{
		if (int.TryParse(content, out var result))
		{
			if (result >= ApplyLevelMin && result <= ApplyLevelMax)
			{
				ApplyLevelThreshold = result;
				return;
			}
			Toast.ShowInfo("该等级限制不可设定");
			onApplyLevelThresholdChanged.Raise();
		}
		else
		{
			Toast.ShowInfo("无效输入");
			onApplyLevelThresholdChanged.Raise();
		}
	}

	public void OnAuditTypeClick(GuildDefinition.AuditType at)
	{
		AuditType = at;
	}

	private async void OnBtnChangeClick()
	{
		changeSettingCmd.Enabled = false;
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestChangeAuditType((int)AuditType, ApplyLevelThreshold);
		loading?.Dispose();
		if (num)
		{
			Toast.ShowInfo("修改成功");
			Close();
		}
		else
		{
			changeSettingCmd.Enabled = true;
		}
	}

	protected override void Dispose(bool disposing)
	{
		onGuildMessage?.Dispose();
		onGuildMessage = null;
		base.Dispose(disposing);
	}
}
