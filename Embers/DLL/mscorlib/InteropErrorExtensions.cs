internal static class InteropErrorExtensions
{
	public static Interop.ErrorInfo Info(this Interop.Error error)
	{
		return new Interop.ErrorInfo(error);
	}
}
