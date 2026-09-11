public interface ILuaCall
{
	object[] callFunction(string fn, params object[] paras);
}
