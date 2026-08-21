namespace System;

internal static class NotImplemented
{
	internal static Exception ByDesign => new NotImplementedException();
}
