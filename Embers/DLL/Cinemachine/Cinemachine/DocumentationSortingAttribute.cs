using System;

namespace Cinemachine;

[DocumentationSorting(Level.Undoc)]
public sealed class DocumentationSortingAttribute : Attribute
{
	public enum Level
	{
		Undoc,
		API,
		UserRef
	}

	public Level Category { get; private set; }

	public DocumentationSortingAttribute(Level category)
	{
		Category = category;
	}
}
