namespace Ase;

public class CastingViewModel : OptionBase
{
	private string castingPath;

	public string CastingPath => castingPath;

	public CastingViewModel(string path)
	{
		castingPath = path;
	}

	public override void Close()
	{
		base.Close();
	}
}
