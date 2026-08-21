namespace MessagePack;

public static class MessagePackCode
{
	public const byte MinFixInt = 0;

	public const byte MaxFixInt = 127;

	public const byte MinFixMap = 128;

	public const byte MaxFixMap = 143;

	public const byte MinFixArray = 144;

	public const byte MaxFixArray = 159;

	public const byte MinFixStr = 160;

	public const byte MaxFixStr = 191;

	public const byte Nil = 192;

	public const byte NeverUsed = 193;

	public const byte False = 194;

	public const byte True = 195;

	public const byte Bin8 = 196;

	public const byte Bin16 = 197;

	public const byte Bin32 = 198;

	public const byte Ext8 = 199;

	public const byte Ext16 = 200;

	public const byte Ext32 = 201;

	public const byte Float32 = 202;

	public const byte Float64 = 203;

	public const byte UInt8 = 204;

	public const byte UInt16 = 205;

	public const byte UInt32 = 206;

	public const byte UInt64 = 207;

	public const byte Int8 = 208;

	public const byte Int16 = 209;

	public const byte Int32 = 210;

	public const byte Int64 = 211;

	public const byte FixExt1 = 212;

	public const byte FixExt2 = 213;

	public const byte FixExt4 = 214;

	public const byte FixExt8 = 215;

	public const byte FixExt16 = 216;

	public const byte Str8 = 217;

	public const byte Str16 = 218;

	public const byte Str32 = 219;

	public const byte Array16 = 220;

	public const byte Array32 = 221;

	public const byte Map16 = 222;

	public const byte Map32 = 223;

	public const byte MinNegativeFixInt = 224;

	public const byte MaxNegativeFixInt = byte.MaxValue;

	private static readonly MessagePackType[] TypeLookupTable;

	private static readonly string[] FormatNameTable;

	static MessagePackCode()
	{
		TypeLookupTable = new MessagePackType[256];
		FormatNameTable = new string[256];
		for (int i = 0; i <= 127; i++)
		{
			TypeLookupTable[i] = MessagePackType.Integer;
			FormatNameTable[i] = "positive fixint";
		}
		for (int j = 128; j <= 143; j++)
		{
			TypeLookupTable[j] = MessagePackType.Map;
			FormatNameTable[j] = "fixmap";
		}
		for (int k = 144; k <= 159; k++)
		{
			TypeLookupTable[k] = MessagePackType.Array;
			FormatNameTable[k] = "fixarray";
		}
		for (int l = 160; l <= 191; l++)
		{
			TypeLookupTable[l] = MessagePackType.String;
			FormatNameTable[l] = "fixstr";
		}
		TypeLookupTable[192] = MessagePackType.Nil;
		TypeLookupTable[193] = MessagePackType.Unknown;
		TypeLookupTable[194] = MessagePackType.Boolean;
		TypeLookupTable[195] = MessagePackType.Boolean;
		TypeLookupTable[196] = MessagePackType.Binary;
		TypeLookupTable[197] = MessagePackType.Binary;
		TypeLookupTable[198] = MessagePackType.Binary;
		TypeLookupTable[199] = MessagePackType.Extension;
		TypeLookupTable[200] = MessagePackType.Extension;
		TypeLookupTable[201] = MessagePackType.Extension;
		TypeLookupTable[202] = MessagePackType.Float;
		TypeLookupTable[203] = MessagePackType.Float;
		TypeLookupTable[204] = MessagePackType.Integer;
		TypeLookupTable[205] = MessagePackType.Integer;
		TypeLookupTable[206] = MessagePackType.Integer;
		TypeLookupTable[207] = MessagePackType.Integer;
		TypeLookupTable[208] = MessagePackType.Integer;
		TypeLookupTable[209] = MessagePackType.Integer;
		TypeLookupTable[210] = MessagePackType.Integer;
		TypeLookupTable[211] = MessagePackType.Integer;
		TypeLookupTable[212] = MessagePackType.Extension;
		TypeLookupTable[213] = MessagePackType.Extension;
		TypeLookupTable[214] = MessagePackType.Extension;
		TypeLookupTable[215] = MessagePackType.Extension;
		TypeLookupTable[216] = MessagePackType.Extension;
		TypeLookupTable[217] = MessagePackType.String;
		TypeLookupTable[218] = MessagePackType.String;
		TypeLookupTable[219] = MessagePackType.String;
		TypeLookupTable[220] = MessagePackType.Array;
		TypeLookupTable[221] = MessagePackType.Array;
		TypeLookupTable[222] = MessagePackType.Map;
		TypeLookupTable[223] = MessagePackType.Map;
		FormatNameTable[192] = "nil";
		FormatNameTable[193] = "(never used)";
		FormatNameTable[194] = "false";
		FormatNameTable[195] = "true";
		FormatNameTable[196] = "bin 8";
		FormatNameTable[197] = "bin 16";
		FormatNameTable[198] = "bin 32";
		FormatNameTable[199] = "ext 8";
		FormatNameTable[200] = "ext 16";
		FormatNameTable[201] = "ext 32";
		FormatNameTable[202] = "float 32";
		FormatNameTable[203] = "float 64";
		FormatNameTable[204] = "uint 8";
		FormatNameTable[205] = "uint 16";
		FormatNameTable[206] = "uint 32";
		FormatNameTable[207] = "uint 64";
		FormatNameTable[208] = "int 8";
		FormatNameTable[209] = "int 16";
		FormatNameTable[210] = "int 32";
		FormatNameTable[211] = "int 64";
		FormatNameTable[212] = "fixext 1";
		FormatNameTable[213] = "fixext 2";
		FormatNameTable[214] = "fixext 4";
		FormatNameTable[215] = "fixext 8";
		FormatNameTable[216] = "fixext 16";
		FormatNameTable[217] = "str 8";
		FormatNameTable[218] = "str 16";
		FormatNameTable[219] = "str 32";
		FormatNameTable[220] = "array 16";
		FormatNameTable[221] = "array 32";
		FormatNameTable[222] = "map 16";
		FormatNameTable[223] = "map 32";
		for (int m = 224; m <= 255; m++)
		{
			TypeLookupTable[m] = MessagePackType.Integer;
			FormatNameTable[m] = "negative fixint";
		}
	}

	public static MessagePackType ToMessagePackType(byte code)
	{
		return TypeLookupTable[code];
	}

	public static string ToFormatName(byte code)
	{
		return FormatNameTable[code];
	}

	internal static bool IsSignedInteger(byte code)
	{
		if ((uint)(code - 208) <= 3u)
		{
			return true;
		}
		if (code >= 224)
		{
			return code <= byte.MaxValue;
		}
		return false;
	}
}
