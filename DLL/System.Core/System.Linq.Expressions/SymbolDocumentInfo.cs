using System.Dynamic.Utils;

namespace System.Linq.Expressions;

public class SymbolDocumentInfo
{
	internal static readonly Guid DocumentType_Text = new Guid(1518771467, 26129, 4563, 189, 42, 0, 0, 248, 8, 73, 189);

	public string FileName { get; }

	internal SymbolDocumentInfo(string fileName)
	{
		ContractUtils.RequiresNotNull(fileName, "fileName");
		FileName = fileName;
	}
}
