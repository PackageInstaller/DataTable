using System;

namespace Ase;

[Serializable]
public struct ViewConfig(int id, string viewPath, string viewClass, string pageType)
{
	public int Id = id;

	public string ViewPath = viewPath;

	public string ViewClass = viewClass;

	public string PageType = pageType;
}
