using System.Runtime.CompilerServices;

namespace System.Linq.Expressions;

internal sealed class SymbolDocumentWithGuids : SymbolDocumentInfo
{
	[CompilerGenerated]
	private readonly Guid _003CLanguage_003Ek__BackingField;

	[CompilerGenerated]
	private readonly Guid _003CLanguageVendor_003Ek__BackingField;

	[CompilerGenerated]
	private readonly Guid _003CDocumentType_003Ek__BackingField;

	internal SymbolDocumentWithGuids(string fileName, ref Guid language)
		: base(fileName)
	{
		_003CLanguage_003Ek__BackingField = language;
		_003CDocumentType_003Ek__BackingField = SymbolDocumentInfo.DocumentType_Text;
	}

	internal SymbolDocumentWithGuids(string fileName, ref Guid language, ref Guid vendor)
		: base(fileName)
	{
		_003CLanguage_003Ek__BackingField = language;
		_003CLanguageVendor_003Ek__BackingField = vendor;
		_003CDocumentType_003Ek__BackingField = SymbolDocumentInfo.DocumentType_Text;
	}

	internal SymbolDocumentWithGuids(string fileName, ref Guid language, ref Guid vendor, ref Guid documentType)
		: base(fileName)
	{
		_003CLanguage_003Ek__BackingField = language;
		_003CLanguageVendor_003Ek__BackingField = vendor;
		_003CDocumentType_003Ek__BackingField = documentType;
	}
}
