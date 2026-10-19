using System;
using System.IO;
using System.Text;
using UnityEngine;

namespace ACT.Net;

public class NetUtils
{
	private static uint[] table = new uint[256]
	{
		0u, 4240017535u, 570562233u, 3736837830u, 1141124466u, 3099436301u, 1711684555u, 2596254644u, 2282248932u, 1957810843u,
		2852801629u, 1454621730u, 3423369110u, 817233897u, 3993919791u, 314042704u, 3412177807u, 936918000u, 3915621686u, 366619977u,
		2405801725u, 1943803522u, 2909243460u, 1373503547u, 1131014507u, 3218104596u, 1634467794u, 2647816109u, 124634137u, 4224994406u,
		628085408u, 3654703839u, 1303535961u, 2970347814u, 1873836000u, 2466906015u, 162941995u, 4111451220u, 733239954u, 3608007405u,
		3317316541u, 956543938u, 3887607044u, 453092731u, 2176718543u, 2097651376u, 2747007094u, 1594198025u, 2262029014u, 2053790377u,
		2765210735u, 1483230224u, 3268935588u, 1047427035u, 3772115229u, 476864866u, 249268274u, 4066508877u, 752459403u, 3495958260u,
		1256170816u, 3060149567u, 1759359993u, 2489596806u, 2607071922u, 1742555853u, 3110523915u, 1172266100u, 3747672000u, 601450431u,
		4251122041u, 31158534u, 325883990u, 4023717929u, 829329135u, 3453421200u, 1466479908u, 2882616667u, 1969922973u, 2312317922u,
		1342533949u, 2898065730u, 1913087876u, 2394877947u, 335633487u, 3904427056u, 906185462u, 3401237129u, 3624741849u, 615818150u,
		4195302752u, 112637215u, 2617837227u, 1622183636u, 3188396050u, 1119000685u, 3604390891u, 711928724u, 4107580754u, 141376813u,
		2463272601u, 1852507878u, 2966460448u, 1281953887u, 1591671055u, 2724688240u, 2094854070u, 2154129353u, 450548861u, 3865271298u,
		953729732u, 3294710459u, 498536548u, 3775830043u, 1068828381u, 3272380066u, 1504918806u, 2768942441u, 2075208623u, 2265490384u,
		2512341632u, 1762050815u, 3082640441u, 1258607686u, 3518719986u, 755167117u, 4089016651u, 251722036u, 3988292387u, 285281116u,
		3485111706u, 855842277u, 2847714897u, 1426400814u, 2344532200u, 1996959895u, 1706088903u, 2567524792u, 1202900862u, 3138078465u,
		565507253u, 3708648650u, 62317068u, 4279200371u, 651767980u, 3663771859u, 81470997u, 4167216746u, 1658658270u, 2657392033u,
		1088359271u, 3160834840u, 2932959816u, 1382605367u, 2362670321u, 1886057614u, 3939845946u, 376229701u, 3369554307u, 879679996u,
		2685067898u, 1555261957u, 2181625027u, 2125561020u, 3826175752u, 414664567u, 3322730929u, 984961486u, 671266974u, 3569037537u,
		167816743u, 4139329112u, 1812370924u, 2428444051u, 1308918613u, 2998733610u, 1802195445u, 2547177866u, 1231636300u, 3050360627u,
		795835527u, 3554079992u, 225274430u, 4057260609u, 3814918929u, 534414190u, 3244367272u, 1037604311u, 2808555107u, 1541320220u,
		2238001370u, 2044508325u, 1994146193u, 2321926638u, 1423857448u, 2825379671u, 853044451u, 3462522012u, 282753626u, 3965973029u,
		4275313525u, 40735498u, 3705015756u, 544179635u, 3134207495u, 1181335160u, 2563907774u, 1684777153u, 3183342110u, 1090812513u,
		2680153255u, 1661365464u, 4189708140u, 83908371u, 3686517205u, 654459306u, 901097722u, 3373015173u, 397917763u, 3943577148u,
		1907459464u, 2366115319u, 1404277553u, 2936675150u, 997073096u, 3352799415u, 426522225u, 3855990286u, 2137656762u, 2211677637u,
		1567103747u, 2714866556u, 3009837612u, 1340076627u, 2439277717u, 1843258602u, 4150417246u, 198958881u, 3579855335u, 702138776u,
		4027552583u, 213261112u, 3524101630u, 783551873u, 3020668469u, 1219638858u, 2517215372u, 1789927667u, 2013776291u, 2227061212u,
		1510334234u, 2797360997u, 1006888145u, 3233442990u, 503444072u, 3803740695u
	};

	public static uint seed = 4041331395u;

	public static ushort HostToNetworkOrder(ushort num)
	{
		byte[] bytes = BitConverter.GetBytes(num);
		bytes[0] = (byte)((num >> 8) & 0xFF);
		bytes[1] = (byte)(num & 0xFF);
		return BitConverter.ToUInt16(bytes, 0);
	}

	public static uint HostToNetworkOrder(uint num)
	{
		byte[] bytes = BitConverter.GetBytes(num);
		bytes[0] = (byte)((num >> 24) & 0xFF);
		bytes[1] = (byte)((num >> 16) & 0xFF);
		bytes[2] = (byte)((num >> 8) & 0xFF);
		bytes[3] = (byte)(num & 0xFF);
		return BitConverter.ToUInt32(bytes, 0);
	}

	public static ulong HostToNetworkOrder(ulong num)
	{
		byte[] bytes = BitConverter.GetBytes(num);
		bytes[0] = (byte)((num >> 56) & 0xFF);
		bytes[1] = (byte)((num >> 48) & 0xFF);
		bytes[2] = (byte)((num >> 40) & 0xFF);
		bytes[3] = (byte)((num >> 32) & 0xFF);
		bytes[4] = (byte)((num >> 24) & 0xFF);
		bytes[5] = (byte)((num >> 16) & 0xFF);
		bytes[6] = (byte)((num >> 8) & 0xFF);
		bytes[7] = (byte)(num & 0xFF);
		return BitConverter.ToUInt64(bytes, 0);
	}

	public static ushort NetworkToHostOrder(ushort num)
	{
		byte[] bytes = BitConverter.GetBytes(num);
		return (ushort)((bytes[0] << 8) | bytes[1]);
	}

	public static uint NetworkToHostOrder(uint num)
	{
		byte[] bytes = BitConverter.GetBytes(num);
		return (uint)((((((bytes[0] << 8) | bytes[1]) << 8) | bytes[2]) << 8) | bytes[3]);
	}

	public static ulong NetworkToHostOrder(ulong num)
	{
		byte[] bytes = BitConverter.GetBytes(num);
		return ((((((((((((((ulong)bytes[0] << 8) | bytes[1]) << 8) | bytes[2]) << 8) | bytes[3]) << 8) | bytes[4]) << 8) | bytes[5]) << 8) | bytes[6]) << 8) | bytes[7];
	}

	public static ushort BigEndianToUshort(byte[] buf, int index = 0)
	{
		return (ushort)((buf[index] << 8) | buf[index + 1]);
	}

	public static byte[] UshortToBigEndian(ushort number)
	{
		byte[] array = new byte[2];
		array[1] = (byte)(number & 0xFF);
		array[0] = (byte)((number >> 8) & 0xFF);
		return array;
	}

	public static uint BigEndianToUint(byte[] buf, int index = 0)
	{
		return (uint)((((((buf[index] << 8) | buf[index + 1]) << 8) | buf[index + 2]) << 8) | buf[index + 3]);
	}

	public static byte[] UintToBigEndian(uint number)
	{
		byte[] array = new byte[4];
		array[3] = (byte)(number & 0xFF);
		array[2] = (byte)((number >> 8) & 0xFF);
		array[1] = (byte)((number >> 16) & 0xFF);
		array[0] = (byte)((number >> 24) & 0xFF);
		return array;
	}

	public static uint crc32(MemoryStream stream)
	{
		return crc32(stream.GetBuffer(), (int)stream.Length);
	}

	public static uint crc32(uint seed, string str)
	{
		return crc32(Encoding.Default.GetBytes(str), str.Length);
	}

	public static uint crc32(byte[] buf, int buf_len)
	{
		uint num = seed ^ 0xFFFFFFFFu;
		for (int i = 0; i < buf.Length && i < buf_len; i++)
		{
			num = (num >> 8) ^ table[(buf[i] ^ num) & 0xFF];
		}
		return num ^ 0xFFFFFFFFu;
	}

	public static uint crc32WithSeed(uint seed, byte[] buf, int buf_len)
	{
		uint num = seed ^ 0xFFFFFFFFu;
		for (int i = 0; i < buf.Length && i < buf_len; i++)
		{
			num = (num >> 8) ^ table[(buf[i] ^ num) & 0xFF];
		}
		return num ^ 0xFFFFFFFFu;
	}

	public static uint crc32WithSeed(uint seed, MemoryStream stream)
	{
		return crc32WithSeed(seed, stream.GetBuffer(), (int)stream.Length);
	}

	public static void LogBytes(byte[] array, int from, int length)
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < length; i++)
		{
			stringBuilder.Append(array[from + i]).Append(' ');
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.Log(stringBuilder.ToString());
		}
	}
}
