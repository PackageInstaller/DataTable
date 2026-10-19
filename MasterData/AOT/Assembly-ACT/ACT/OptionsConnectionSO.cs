namespace ACT;

public abstract class OptionsConnectionSO<TOption> : ConnectionSO<int>
{
	public override IConnection<int> CreateConnection(ISettingWithValue<int> owner)
	{
		return GetConnectionWithOptions(owner);
	}

	protected abstract IConnectionWithOptions<TOption> GetConnectionWithOptions(ISettingWithValue<int> owner);
}
