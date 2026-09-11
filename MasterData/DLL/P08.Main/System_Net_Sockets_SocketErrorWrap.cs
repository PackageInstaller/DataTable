using System;
using System.Net.Sockets;
using LuaInterface;

public class System_Net_Sockets_SocketErrorWrap
{
	public static void Register(LuaState L)
	{
		L.BeginEnum(typeof(SocketError));
		L.RegVar("AccessDenied", get_AccessDenied, null);
		L.RegVar("AddressAlreadyInUse", get_AddressAlreadyInUse, null);
		L.RegVar("AddressFamilyNotSupported", get_AddressFamilyNotSupported, null);
		L.RegVar("AddressNotAvailable", get_AddressNotAvailable, null);
		L.RegVar("AlreadyInProgress", get_AlreadyInProgress, null);
		L.RegVar("ConnectionAborted", get_ConnectionAborted, null);
		L.RegVar("ConnectionRefused", get_ConnectionRefused, null);
		L.RegVar("ConnectionReset", get_ConnectionReset, null);
		L.RegVar("DestinationAddressRequired", get_DestinationAddressRequired, null);
		L.RegVar("Disconnecting", get_Disconnecting, null);
		L.RegVar("Fault", get_Fault, null);
		L.RegVar("HostDown", get_HostDown, null);
		L.RegVar("HostNotFound", get_HostNotFound, null);
		L.RegVar("HostUnreachable", get_HostUnreachable, null);
		L.RegVar("InProgress", get_InProgress, null);
		L.RegVar("Interrupted", get_Interrupted, null);
		L.RegVar("InvalidArgument", get_InvalidArgument, null);
		L.RegVar("IOPending", get_IOPending, null);
		L.RegVar("IsConnected", get_IsConnected, null);
		L.RegVar("MessageSize", get_MessageSize, null);
		L.RegVar("NetworkDown", get_NetworkDown, null);
		L.RegVar("NetworkReset", get_NetworkReset, null);
		L.RegVar("NetworkUnreachable", get_NetworkUnreachable, null);
		L.RegVar("NoBufferSpaceAvailable", get_NoBufferSpaceAvailable, null);
		L.RegVar("NoData", get_NoData, null);
		L.RegVar("NoRecovery", get_NoRecovery, null);
		L.RegVar("NotConnected", get_NotConnected, null);
		L.RegVar("NotInitialized", get_NotInitialized, null);
		L.RegVar("NotSocket", get_NotSocket, null);
		L.RegVar("OperationAborted", get_OperationAborted, null);
		L.RegVar("OperationNotSupported", get_OperationNotSupported, null);
		L.RegVar("ProcessLimit", get_ProcessLimit, null);
		L.RegVar("ProtocolFamilyNotSupported", get_ProtocolFamilyNotSupported, null);
		L.RegVar("ProtocolNotSupported", get_ProtocolNotSupported, null);
		L.RegVar("ProtocolOption", get_ProtocolOption, null);
		L.RegVar("ProtocolType", get_ProtocolType, null);
		L.RegVar("Shutdown", get_Shutdown, null);
		L.RegVar("SocketError", get_SocketError, null);
		L.RegVar("SocketNotSupported", get_SocketNotSupported, null);
		L.RegVar("Success", get_Success, null);
		L.RegVar("SystemNotReady", get_SystemNotReady, null);
		L.RegVar("TimedOut", get_TimedOut, null);
		L.RegVar("TooManyOpenSockets", get_TooManyOpenSockets, null);
		L.RegVar("TryAgain", get_TryAgain, null);
		L.RegVar("TypeNotFound", get_TypeNotFound, null);
		L.RegVar("VersionNotSupported", get_VersionNotSupported, null);
		L.RegVar("WouldBlock", get_WouldBlock, null);
		L.RegFunction("IntToEnum", IntToEnum);
		L.EndEnum();
		TypeTraits<SocketError>.Check = CheckType;
		StackTraits<SocketError>.Push = Push;
	}

	private static void Push(IntPtr L, SocketError arg)
	{
		ToLua.Push(L, arg);
	}

	private static bool CheckType(IntPtr L, int pos)
	{
		return TypeChecker.CheckEnumType(typeof(SocketError), L, pos);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AccessDenied(IntPtr L)
	{
		ToLua.Push(L, SocketError.AccessDenied);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AddressAlreadyInUse(IntPtr L)
	{
		ToLua.Push(L, SocketError.AddressAlreadyInUse);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AddressFamilyNotSupported(IntPtr L)
	{
		ToLua.Push(L, SocketError.AddressFamilyNotSupported);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AddressNotAvailable(IntPtr L)
	{
		ToLua.Push(L, SocketError.AddressNotAvailable);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AlreadyInProgress(IntPtr L)
	{
		ToLua.Push(L, SocketError.AlreadyInProgress);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ConnectionAborted(IntPtr L)
	{
		ToLua.Push(L, SocketError.ConnectionAborted);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ConnectionRefused(IntPtr L)
	{
		ToLua.Push(L, SocketError.ConnectionRefused);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ConnectionReset(IntPtr L)
	{
		ToLua.Push(L, SocketError.ConnectionReset);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_DestinationAddressRequired(IntPtr L)
	{
		ToLua.Push(L, SocketError.DestinationAddressRequired);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Disconnecting(IntPtr L)
	{
		ToLua.Push(L, SocketError.Disconnecting);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Fault(IntPtr L)
	{
		ToLua.Push(L, SocketError.Fault);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_HostDown(IntPtr L)
	{
		ToLua.Push(L, SocketError.HostDown);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_HostNotFound(IntPtr L)
	{
		ToLua.Push(L, SocketError.HostNotFound);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_HostUnreachable(IntPtr L)
	{
		ToLua.Push(L, SocketError.HostUnreachable);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_InProgress(IntPtr L)
	{
		ToLua.Push(L, SocketError.InProgress);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Interrupted(IntPtr L)
	{
		ToLua.Push(L, SocketError.Interrupted);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_InvalidArgument(IntPtr L)
	{
		ToLua.Push(L, SocketError.InvalidArgument);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IOPending(IntPtr L)
	{
		ToLua.Push(L, SocketError.IOPending);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsConnected(IntPtr L)
	{
		ToLua.Push(L, SocketError.IsConnected);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MessageSize(IntPtr L)
	{
		ToLua.Push(L, SocketError.MessageSize);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_NetworkDown(IntPtr L)
	{
		ToLua.Push(L, SocketError.NetworkDown);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_NetworkReset(IntPtr L)
	{
		ToLua.Push(L, SocketError.NetworkReset);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_NetworkUnreachable(IntPtr L)
	{
		ToLua.Push(L, SocketError.NetworkUnreachable);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_NoBufferSpaceAvailable(IntPtr L)
	{
		ToLua.Push(L, SocketError.NoBufferSpaceAvailable);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_NoData(IntPtr L)
	{
		ToLua.Push(L, SocketError.NoData);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_NoRecovery(IntPtr L)
	{
		ToLua.Push(L, SocketError.NoRecovery);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_NotConnected(IntPtr L)
	{
		ToLua.Push(L, SocketError.NotConnected);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_NotInitialized(IntPtr L)
	{
		ToLua.Push(L, SocketError.NotInitialized);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_NotSocket(IntPtr L)
	{
		ToLua.Push(L, SocketError.NotSocket);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OperationAborted(IntPtr L)
	{
		ToLua.Push(L, SocketError.OperationAborted);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OperationNotSupported(IntPtr L)
	{
		ToLua.Push(L, SocketError.OperationNotSupported);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ProcessLimit(IntPtr L)
	{
		ToLua.Push(L, SocketError.ProcessLimit);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ProtocolFamilyNotSupported(IntPtr L)
	{
		ToLua.Push(L, SocketError.ProtocolFamilyNotSupported);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ProtocolNotSupported(IntPtr L)
	{
		ToLua.Push(L, SocketError.ProtocolNotSupported);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ProtocolOption(IntPtr L)
	{
		ToLua.Push(L, SocketError.ProtocolOption);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ProtocolType(IntPtr L)
	{
		ToLua.Push(L, SocketError.ProtocolType);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Shutdown(IntPtr L)
	{
		ToLua.Push(L, SocketError.Shutdown);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SocketError(IntPtr L)
	{
		ToLua.Push(L, SocketError.SocketError);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SocketNotSupported(IntPtr L)
	{
		ToLua.Push(L, SocketError.SocketNotSupported);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Success(IntPtr L)
	{
		ToLua.Push(L, SocketError.Success);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SystemNotReady(IntPtr L)
	{
		ToLua.Push(L, SocketError.SystemNotReady);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TimedOut(IntPtr L)
	{
		ToLua.Push(L, SocketError.TimedOut);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TooManyOpenSockets(IntPtr L)
	{
		ToLua.Push(L, SocketError.TooManyOpenSockets);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TryAgain(IntPtr L)
	{
		ToLua.Push(L, SocketError.TryAgain);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TypeNotFound(IntPtr L)
	{
		ToLua.Push(L, SocketError.TypeNotFound);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_VersionNotSupported(IntPtr L)
	{
		ToLua.Push(L, SocketError.VersionNotSupported);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_WouldBlock(IntPtr L)
	{
		ToLua.Push(L, SocketError.WouldBlock);
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IntToEnum(IntPtr L)
	{
		SocketError socketError = (SocketError)LuaDLL.lua_tonumber(L, 1);
		ToLua.Push(L, socketError);
		return 1;
	}
}
