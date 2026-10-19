using System;

namespace ACT.Config;

[Serializable]
public class PropertyTypeData
{
	public readonly int id;

	public readonly int propertyDescId;

	public readonly int type;

	public readonly int uiShow;

	public readonly int propertyDesc;

	public PropertyTypeData(int id, int propertyDescId, int type, int uiShow, int propertyDesc)
	{
		this.id = id;
		this.propertyDescId = propertyDescId;
		this.type = type;
		this.uiShow = uiShow;
		this.propertyDesc = propertyDesc;
	}
}
