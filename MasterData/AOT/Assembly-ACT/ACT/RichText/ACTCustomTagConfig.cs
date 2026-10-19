using System.Collections.Generic;

namespace ACT.RichText;

public class ACTCustomTagConfig : LuminSerializedScriptableObject
{
	public struct CustomTag
	{
		public string name;

		public string startTag;

		public string endTag;
	}

	public List<CustomTag> CustomTags;
}
