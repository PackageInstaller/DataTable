using System;

public sealed class VarBindingAttribute : Attribute
{
	public EntityVarName mVarName;

	public bool mIsSync;

	public bool mIsReadOnly;

	public bool mIsGOAPVar;

	public string mComment;

	public Type mVarType;

	public Type mComponentType;

	public VarBindingAttribute(EntityVarName varName, bool isSync, bool isGOAPVar = false, bool isReadOnly = false, string comment = "")
	{
		mVarName = varName;
		mIsSync = isSync;
		mIsReadOnly = isReadOnly;
		mIsGOAPVar = isGOAPVar;
		mComment = comment;
	}
}
