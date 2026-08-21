using System;
using GameFramework.Runtime;

namespace Ase;

public class CopyGroupItemViewModel : OptionBase
{
	private SimpleCommand<string> optCommand;

	private CopyMainData data;

	private bool isSelect;

	private bool isSystemOpen;

	private int serviceId;

	private InteractionRequest<string> optRequest = new InteractionRequest<string>();

	public bool IsSelect
	{
		get
		{
			return isSelect;
		}
		private set
		{
			Set(ref isSelect, value, "IsSelect");
		}
	}

	public ICommand OptCommand => optCommand;

	public CopyMainData Data
	{
		get
		{
			return data;
		}
		private set
		{
			Set(ref data, value, "Data");
		}
	}

	public int ServiceId => serviceId;

	public bool IsSystemOpen => isSystemOpen;

	public IInteractionRequest OptRequest => optRequest;

	public CopyGroupItemViewModel()
	{
	}

	public CopyGroupItemViewModel(OptionBase parent, CopyMainData data)
	{
		base.parent = parent;
		optCommand = new SimpleCommand<string>(OnOpt);
		this.data = data;
		serviceId = GetServiceId();
		CheckSystemOpen();
	}

	public async void OnOpt(string optName)
	{
		if (!data.IsLock && !isSelect)
		{
			parent.ItemOnClick(this);
		}
	}

	public void SetSelect(bool isSelect)
	{
		IsSelect = isSelect;
	}

	private int GetServiceId()
	{
		return Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetServiceId(data);
	}

	public void CheckSystemOpen()
	{
		if (serviceId == 0)
		{
			isSystemOpen = true;
		}
		try
		{
			isSystemOpen = Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(serviceId);
			data.SetLock(isSystemOpen);
		}
		catch (Exception)
		{
		}
	}

	public void PlayUnlockEffect()
	{
		if (!data.IsLock && !data.HasPlayUnlock)
		{
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().PlayUnlockEffect(data);
			optRequest.Raise("PlayUnlockEffect");
		}
	}
}
