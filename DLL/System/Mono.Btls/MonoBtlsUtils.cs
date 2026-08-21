using System;
using System.Runtime.CompilerServices;
using System.Text;

namespace Mono.Btls;

internal static class MonoBtlsUtils
{
	private static byte[] emailOid;

	public static bool Compare(byte[] a, byte[] b)
	{
		if (a.Length != b.Length)
		{
			return false;
		}
		for (int i = 0; i < a.Length; i++)
		{
			if (a[i] != b[i])
			{
				return false;
			}
		}
		return true;
	}

	private static bool AppendEntry(StringBuilder sb, MonoBtlsX509Name name, int index, string separator, bool quotes)
	{
		//IL_01c8: Field data (rva=0x5d0) could not be found in any section!
		//IL_01c8: Field data (rva=0x5d0) could not be found in any section!
		//IL_01c8: Field data (rva=0x5d0) could not be found in any section!
		//IL_01c8: Field data (rva=0x5d0) could not be found in any section!
		//IL_01c8: Field data (rva=0x5d0) could not be found in any section!
		//IL_01c8: Field data (rva=0x5d0) could not be found in any section!
		//IL_01c8: Field data (rva=0x5d0) could not be found in any section!
		//IL_01c8: Field data (rva=0x5d0) could not be found in any section!
		//IL_01c8: Field data (rva=0x5d0) could not be found in any section!
		//IL_01c8: Field data (rva=0x5d0) could not be found in any section!
		//IL_01c8: Field data (rva=0x5d0) could not be found in any section!
		//IL_01c8: Field data (rva=0x5d0) could not be found in any section!
		MonoBtlsX509NameEntryType monoBtlsX509NameEntryType = name.GetEntryType(index);
		if (monoBtlsX509NameEntryType < MonoBtlsX509NameEntryType.Unknown)
		{
			return false;
		}
		if (monoBtlsX509NameEntryType == MonoBtlsX509NameEntryType.Unknown && Compare(name.GetEntryOidData(index), emailOid))
		{
			monoBtlsX509NameEntryType = MonoBtlsX509NameEntryType.Email;
		}
		string text = name.GetEntryValue(index, out var tag);
		if (text == null)
		{
			return false;
		}
		string entryOid = name.GetEntryOid(index);
		if (entryOid == null)
		{
			return false;
		}
		if (sb.Length > 0)
		{
			sb.Append(separator);
		}
		switch (monoBtlsX509NameEntryType)
		{
		case MonoBtlsX509NameEntryType.CountryName:
			sb.Append("C=");
			break;
		case MonoBtlsX509NameEntryType.OrganizationName:
			sb.Append("O=");
			break;
		case MonoBtlsX509NameEntryType.OrganizationalUnitName:
			sb.Append("OU=");
			break;
		case MonoBtlsX509NameEntryType.CommonName:
			sb.Append("CN=");
			break;
		case MonoBtlsX509NameEntryType.LocalityName:
			sb.Append("L=");
			break;
		case MonoBtlsX509NameEntryType.StateOrProvinceName:
			sb.Append("S=");
			break;
		case MonoBtlsX509NameEntryType.StreetAddress:
			sb.Append("STREET=");
			break;
		case MonoBtlsX509NameEntryType.DomainComponent:
			sb.Append("DC=");
			break;
		case MonoBtlsX509NameEntryType.UserId:
			sb.Append("UID=");
			break;
		case MonoBtlsX509NameEntryType.Email:
			sb.Append("E=");
			break;
		case MonoBtlsX509NameEntryType.DnQualifier:
			sb.Append("dnQualifier=");
			break;
		case MonoBtlsX509NameEntryType.Title:
			sb.Append("T=");
			break;
		case MonoBtlsX509NameEntryType.Surname:
			sb.Append("SN=");
			break;
		case MonoBtlsX509NameEntryType.GivenName:
			sb.Append("G=");
			break;
		case MonoBtlsX509NameEntryType.Initial:
			sb.Append("I=");
			break;
		case MonoBtlsX509NameEntryType.SerialNumber:
			sb.Append("SERIALNUMBER=");
			break;
		default:
			sb.Append("OID.");
			sb.Append(entryOid);
			sb.Append("=");
			break;
		}
		char[] array = new char[7];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		char[] anyOf = array;
		if (quotes && tag != 30 && (text.IndexOfAny(anyOf, 0, text.Length) > 0 || text.StartsWith(" ") || text.EndsWith(" ")))
		{
			text = "\"" + text + "\"";
		}
		sb.Append(text);
		return true;
	}

	public static string FormatName(MonoBtlsX509Name name, bool reversed, string separator, bool quotes)
	{
		int entryCount = name.GetEntryCount();
		StringBuilder stringBuilder = new StringBuilder();
		if (reversed)
		{
			for (int num = entryCount - 1; num >= 0; num--)
			{
				AppendEntry(stringBuilder, name, num, separator, quotes);
			}
		}
		else
		{
			for (int i = 0; i < entryCount; i++)
			{
				AppendEntry(stringBuilder, name, i, separator, quotes);
			}
		}
		return stringBuilder.ToString();
	}

	static MonoBtlsUtils()
	{
		//IL_000d: Field data (rva=0x750) could not be found in any section!
		//IL_000d: Field data (rva=0x750) could not be found in any section!
		byte[] array = new byte[9];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		emailOid = array;
	}
}
