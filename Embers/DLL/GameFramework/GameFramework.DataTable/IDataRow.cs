namespace GameFramework.DataTable;

public interface IDataRow
{
	int Id { get; }

	bool ParseDataRow(string dataRowString, object userData);

	bool ParseDataRow(byte[] dataRowBytes, int startIndex, int length, object userData);
}
