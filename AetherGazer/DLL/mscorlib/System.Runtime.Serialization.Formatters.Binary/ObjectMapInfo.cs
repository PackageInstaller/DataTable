namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class ObjectMapInfo
{
	internal int objectId;

	private int numMembers;

	private string[] memberNames;

	private Type[] memberTypes;

	internal ObjectMapInfo(int objectId, int numMembers, string[] memberNames, Type[] memberTypes)
	{
		this.objectId = objectId;
		this.numMembers = numMembers;
		this.memberNames = memberNames;
		this.memberTypes = memberTypes;
	}

	internal bool isCompatible(int numMembers, string[] memberNames, Type[] memberTypes)
	{
		bool result = true;
		if (this.numMembers == numMembers)
		{
			for (int i = 0; i < numMembers; i++)
			{
				if (!this.memberNames[i].Equals(memberNames[i]))
				{
					result = false;
					break;
				}
				if (memberTypes != null && this.memberTypes[i] != memberTypes[i])
				{
					result = false;
					break;
				}
			}
		}
		else
		{
			result = false;
		}
		return result;
	}
}
