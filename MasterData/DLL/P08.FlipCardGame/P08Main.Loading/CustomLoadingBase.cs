namespace P08Main.Loading;

public abstract class CustomLoadingBase
{
	public abstract LoadingImpl GetEnum();

	public abstract void InitLoading(object param = null);

	public abstract void ShowLoadUI();

	public abstract void CloseLoadUI();

	public abstract void SetUIProgress(float value);

	public abstract void Dispose();
}
