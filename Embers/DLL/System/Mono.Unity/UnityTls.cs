using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace Mono.Unity;

internal static class UnityTls
{
	public enum unitytls_error_code : uint
	{
		UNITYTLS_SUCCESS = 0u,
		UNITYTLS_INVALID_ARGUMENT = 1u,
		UNITYTLS_INVALID_FORMAT = 2u,
		UNITYTLS_INVALID_PASSWORD = 3u,
		UNITYTLS_INVALID_STATE = 4u,
		UNITYTLS_BUFFER_OVERFLOW = 5u,
		UNITYTLS_OUT_OF_MEMORY = 6u,
		UNITYTLS_INTERNAL_ERROR = 7u,
		UNITYTLS_NOT_SUPPORTED = 8u,
		UNITYTLS_ENTROPY_SOURCE_FAILED = 9u,
		UNITYTLS_STREAM_CLOSED = 10u,
		UNITYTLS_USER_CUSTOM_ERROR_START = 1048576u,
		UNITYTLS_USER_WOULD_BLOCK = 1048577u,
		UNITYTLS_USER_READ_FAILED = 1048578u,
		UNITYTLS_USER_WRITE_FAILED = 1048579u,
		UNITYTLS_USER_UNKNOWN_ERROR = 1048580u,
		UNITYTLS_USER_CUSTOM_ERROR_END = 2097152u
	}

	public struct unitytls_errorstate
	{
		private uint magic;

		public unitytls_error_code code;

		private ulong reserved;
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	public struct unitytls_key
	{
	}

	public struct unitytls_key_ref
	{
		public ulong handle;
	}

	public struct unitytls_x509_ref
	{
		public ulong handle;
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	public struct unitytls_x509list
	{
	}

	public struct unitytls_x509list_ref
	{
		public ulong handle;
	}

	[Flags]
	public enum unitytls_x509verify_result : uint
	{
		UNITYTLS_X509VERIFY_SUCCESS = 0u,
		UNITYTLS_X509VERIFY_NOT_DONE = 0x80000000u,
		UNITYTLS_X509VERIFY_FATAL_ERROR = uint.MaxValue,
		UNITYTLS_X509VERIFY_FLAG_EXPIRED = 1u,
		UNITYTLS_X509VERIFY_FLAG_REVOKED = 2u,
		UNITYTLS_X509VERIFY_FLAG_CN_MISMATCH = 4u,
		UNITYTLS_X509VERIFY_FLAG_NOT_TRUSTED = 8u,
		UNITYTLS_X509VERIFY_FLAG_USER_ERROR1 = 0x10000u,
		UNITYTLS_X509VERIFY_FLAG_USER_ERROR2 = 0x20000u,
		UNITYTLS_X509VERIFY_FLAG_USER_ERROR3 = 0x40000u,
		UNITYTLS_X509VERIFY_FLAG_USER_ERROR4 = 0x80000u,
		UNITYTLS_X509VERIFY_FLAG_USER_ERROR5 = 0x100000u,
		UNITYTLS_X509VERIFY_FLAG_USER_ERROR6 = 0x200000u,
		UNITYTLS_X509VERIFY_FLAG_USER_ERROR7 = 0x400000u,
		UNITYTLS_X509VERIFY_FLAG_USER_ERROR8 = 0x800000u,
		UNITYTLS_X509VERIFY_FLAG_UNKNOWN_ERROR = 0x8000000u
	}

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	public unsafe delegate unitytls_x509verify_result unitytls_x509verify_callback(void* userData, unitytls_x509_ref cert, unitytls_x509verify_result result, unitytls_errorstate* errorState);

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	public struct unitytls_tlsctx
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	public struct unitytls_x509name
	{
	}

	public enum unitytls_ciphersuite : uint
	{
		UNITYTLS_CIPHERSUITE_INVALID = 16777215u
	}

	public enum unitytls_protocol : uint
	{
		UNITYTLS_PROTOCOL_TLS_1_0,
		UNITYTLS_PROTOCOL_TLS_1_1,
		UNITYTLS_PROTOCOL_TLS_1_2,
		UNITYTLS_PROTOCOL_INVALID
	}

	public struct unitytls_tlsctx_protocolrange
	{
		public unitytls_protocol min;

		public unitytls_protocol max;
	}

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	public unsafe delegate IntPtr unitytls_tlsctx_write_callback(void* userData, byte* data, IntPtr bufferLen, unitytls_errorstate* errorState);

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	public unsafe delegate IntPtr unitytls_tlsctx_read_callback(void* userData, byte* buffer, IntPtr bufferLen, unitytls_errorstate* errorState);

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	public unsafe delegate void unitytls_tlsctx_trace_callback(void* userData, unitytls_tlsctx* ctx, byte* traceMessage, IntPtr traceMessageLen);

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	public unsafe delegate void unitytls_tlsctx_certificate_callback(void* userData, unitytls_tlsctx* ctx, byte* cn, IntPtr cnLen, unitytls_x509name* caList, IntPtr caListLen, unitytls_x509list_ref* chain, unitytls_key_ref* key, unitytls_errorstate* errorState);

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	public unsafe delegate unitytls_x509verify_result unitytls_tlsctx_x509verify_callback(void* userData, unitytls_x509list_ref chain, unitytls_errorstate* errorState);

	public struct unitytls_tlsctx_callbacks
	{
		public unitytls_tlsctx_read_callback read;

		public unitytls_tlsctx_write_callback write;

		public unsafe void* data;
	}

	[StructLayout(LayoutKind.Sequential)]
	public class unitytls_interface_struct
	{
		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public delegate unitytls_errorstate unitytls_errorstate_create_t();

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate void unitytls_errorstate_raise_error_t(unitytls_errorstate* errorState, unitytls_error_code errorCode);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate unitytls_key_ref unitytls_key_get_ref_t(unitytls_key* key, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate unitytls_key* unitytls_key_parse_der_t(byte* buffer, IntPtr bufferLen, byte* password, IntPtr passwordLen, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate unitytls_key* unitytls_key_parse_pem_t(byte* buffer, IntPtr bufferLen, byte* password, IntPtr passwordLen, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate void unitytls_key_free_t(unitytls_key* key);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate IntPtr unitytls_x509_export_der_t(unitytls_x509_ref cert, byte* buffer, IntPtr bufferLen, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate unitytls_x509list_ref unitytls_x509list_get_ref_t(unitytls_x509list* list, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate unitytls_x509_ref unitytls_x509list_get_x509_t(unitytls_x509list_ref list, IntPtr index, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate unitytls_x509list* unitytls_x509list_create_t(unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate void unitytls_x509list_append_t(unitytls_x509list* list, unitytls_x509_ref cert, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate void unitytls_x509list_append_der_t(unitytls_x509list* list, byte* buffer, IntPtr bufferLen, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate void unitytls_x509list_free_t(unitytls_x509list* list);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate unitytls_x509verify_result unitytls_x509verify_default_ca_t(unitytls_x509list_ref chain, byte* cn, IntPtr cnLen, unitytls_x509verify_callback cb, void* userData, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate unitytls_x509verify_result unitytls_x509verify_explicit_ca_t(unitytls_x509list_ref chain, unitytls_x509list_ref trustCA, byte* cn, IntPtr cnLen, unitytls_x509verify_callback cb, void* userData, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate unitytls_tlsctx* unitytls_tlsctx_create_server_t(unitytls_tlsctx_protocolrange supportedProtocols, unitytls_tlsctx_callbacks callbacks, ulong certChain, ulong leafCertificateKey, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate unitytls_tlsctx* unitytls_tlsctx_create_client_t(unitytls_tlsctx_protocolrange supportedProtocols, unitytls_tlsctx_callbacks callbacks, byte* cn, IntPtr cnLen, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate void unitytls_tlsctx_server_require_client_authentication_t(unitytls_tlsctx* ctx, unitytls_x509list_ref clientAuthCAList, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate void unitytls_tlsctx_set_certificate_callback_t(unitytls_tlsctx* ctx, unitytls_tlsctx_certificate_callback cb, void* userData, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate void unitytls_tlsctx_set_trace_callback_t(unitytls_tlsctx* ctx, unitytls_tlsctx_trace_callback cb, void* userData, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate void unitytls_tlsctx_set_x509verify_callback_t(unitytls_tlsctx* ctx, unitytls_tlsctx_x509verify_callback cb, void* userData, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate void unitytls_tlsctx_set_supported_ciphersuites_t(unitytls_tlsctx* ctx, unitytls_ciphersuite* supportedCiphersuites, IntPtr supportedCiphersuitesLen, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate unitytls_ciphersuite unitytls_tlsctx_get_ciphersuite_t(unitytls_tlsctx* ctx, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate unitytls_protocol unitytls_tlsctx_get_protocol_t(unitytls_tlsctx* ctx, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate unitytls_x509verify_result unitytls_tlsctx_process_handshake_t(unitytls_tlsctx* ctx, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate IntPtr unitytls_tlsctx_read_t(unitytls_tlsctx* ctx, byte* buffer, IntPtr bufferLen, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate IntPtr unitytls_tlsctx_write_t(unitytls_tlsctx* ctx, byte* data, IntPtr bufferLen, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate void unitytls_tlsctx_notify_close_t(unitytls_tlsctx* ctx, unitytls_errorstate* errorState);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate void unitytls_tlsctx_free_t(unitytls_tlsctx* ctx);

		[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
		public unsafe delegate void unitytls_random_generate_bytes_t(byte* buffer, IntPtr bufferLen, unitytls_errorstate* errorState);

		public readonly ulong UNITYTLS_INVALID_HANDLE;

		public readonly unitytls_tlsctx_protocolrange UNITYTLS_TLSCTX_PROTOCOLRANGE_DEFAULT;

		public unitytls_errorstate_create_t unitytls_errorstate_create;

		public unitytls_errorstate_raise_error_t unitytls_errorstate_raise_error;

		public unitytls_key_get_ref_t unitytls_key_get_ref;

		public unitytls_key_parse_der_t unitytls_key_parse_der;

		public unitytls_key_parse_pem_t unitytls_key_parse_pem;

		public unitytls_key_free_t unitytls_key_free;

		public unitytls_x509_export_der_t unitytls_x509_export_der;

		public unitytls_x509list_get_ref_t unitytls_x509list_get_ref;

		public unitytls_x509list_get_x509_t unitytls_x509list_get_x509;

		public unitytls_x509list_create_t unitytls_x509list_create;

		public unitytls_x509list_append_t unitytls_x509list_append;

		public unitytls_x509list_append_der_t unitytls_x509list_append_der;

		public unitytls_x509list_append_der_t unitytls_x509list_append_pem;

		public unitytls_x509list_free_t unitytls_x509list_free;

		public unitytls_x509verify_default_ca_t unitytls_x509verify_default_ca;

		public unitytls_x509verify_explicit_ca_t unitytls_x509verify_explicit_ca;

		public unitytls_tlsctx_create_server_t unitytls_tlsctx_create_server;

		public unitytls_tlsctx_create_client_t unitytls_tlsctx_create_client;

		public unitytls_tlsctx_server_require_client_authentication_t unitytls_tlsctx_server_require_client_authentication;

		public unitytls_tlsctx_set_certificate_callback_t unitytls_tlsctx_set_certificate_callback;

		public unitytls_tlsctx_set_trace_callback_t unitytls_tlsctx_set_trace_callback;

		public unitytls_tlsctx_set_x509verify_callback_t unitytls_tlsctx_set_x509verify_callback;

		public unitytls_tlsctx_set_supported_ciphersuites_t unitytls_tlsctx_set_supported_ciphersuites;

		public unitytls_tlsctx_get_ciphersuite_t unitytls_tlsctx_get_ciphersuite;

		public unitytls_tlsctx_get_protocol_t unitytls_tlsctx_get_protocol;

		public unitytls_tlsctx_process_handshake_t unitytls_tlsctx_process_handshake;

		public unitytls_tlsctx_read_t unitytls_tlsctx_read;

		public unitytls_tlsctx_write_t unitytls_tlsctx_write;

		public unitytls_tlsctx_notify_close_t unitytls_tlsctx_notify_close;

		public unitytls_tlsctx_free_t unitytls_tlsctx_free;

		public unitytls_random_generate_bytes_t unitytls_random_generate_bytes;
	}

	private static unitytls_interface_struct marshalledInterface;

	public static bool IsSupported => NativeInterface != null;

	public static unitytls_interface_struct NativeInterface
	{
		get
		{
			if (marshalledInterface == null)
			{
				IntPtr unityTlsInterface = GetUnityTlsInterface();
				if (unityTlsInterface == IntPtr.Zero)
				{
					return null;
				}
				marshalledInterface = Marshal.PtrToStructure<unitytls_interface_struct>(unityTlsInterface);
			}
			return marshalledInterface;
		}
	}

	[MethodImpl(MethodImplOptions.InternalCall)]
	private static extern IntPtr GetUnityTlsInterface();
}
