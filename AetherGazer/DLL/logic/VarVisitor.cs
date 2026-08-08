public class VarVisitor
{
	public GetVar mGetVar;

	public SetVar mSetVar;

	public VarVisitor(GetVar getVar, SetVar setVar)
	{
		mGetVar = getVar;
		mSetVar = setVar;
	}
}
