namespace ACT.World.StateObject;

public interface IExposedTable
{
	void SetValue(VarName name, int value);

	bool GetValue(VarName name, out int value);

	void ClearValue(VarName name);
}
