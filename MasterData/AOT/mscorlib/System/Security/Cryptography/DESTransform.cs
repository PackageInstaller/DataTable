using Mono.Security.Cryptography;

namespace System.Security.Cryptography;

internal class DESTransform : SymmetricTransform
{
	internal static readonly int KEY_BIT_SIZE = 64;

	internal static readonly int KEY_BYTE_SIZE = KEY_BIT_SIZE / 8;

	internal static readonly int BLOCK_BIT_SIZE = 64;

	internal static readonly int BLOCK_BYTE_SIZE = BLOCK_BIT_SIZE / 8;

	private byte[] keySchedule;

	private byte[] byteBuff;

	private uint[] dwordBuff;

	private static readonly uint[] spBoxes = new uint[512]
	{
		8421888u, 0u, 32768u, 8421890u, 8421378u, 33282u, 2u, 32768u, 512u, 8421888u,
		8421890u, 512u, 8389122u, 8421378u, 8388608u, 2u, 514u, 8389120u, 8389120u, 33280u,
		33280u, 8421376u, 8421376u, 8389122u, 32770u, 8388610u, 8388610u, 32770u, 0u, 514u,
		33282u, 8388608u, 32768u, 8421890u, 2u, 8421376u, 8421888u, 8388608u, 8388608u, 512u,
		8421378u, 32768u, 33280u, 8388610u, 512u, 2u, 8389122u, 33282u, 8421890u, 32770u,
		8421376u, 8389122u, 8388610u, 514u, 33282u, 8421888u, 514u, 8389120u, 8389120u, 0u,
		32770u, 33280u, 0u, 8421378u, 1074282512u, 1073758208u, 16384u, 540688u, 524288u, 16u,
		1074266128u, 1073758224u, 1073741840u, 1074282512u, 1074282496u, 1073741824u, 1073758208u, 524288u, 16u, 1074266128u,
		540672u, 524304u, 1073758224u, 0u, 1073741824u, 16384u, 540688u, 1074266112u, 524304u, 1073741840u,
		0u, 540672u, 16400u, 1074282496u, 1074266112u, 16400u, 0u, 540688u, 1074266128u, 524288u,
		1073758224u, 1074266112u, 1074282496u, 16384u, 1074266112u, 1073758208u, 16u, 1074282512u, 540688u, 16u,
		16384u, 1073741824u, 16400u, 1074282496u, 524288u, 1073741840u, 524304u, 1073758224u, 1073741840u, 524304u,
		540672u, 0u, 1073758208u, 16400u, 1073741824u, 1074266128u, 1074282512u, 540672u, 260u, 67174656u,
		0u, 67174404u, 67109120u, 0u, 65796u, 67109120u, 65540u, 67108868u, 67108868u, 65536u,
		67174660u, 65540u, 67174400u, 260u, 67108864u, 4u, 67174656u, 256u, 65792u, 67174400u,
		67174404u, 65796u, 67109124u, 65792u, 65536u, 67109124u, 4u, 67174660u, 256u, 67108864u,
		67174656u, 67108864u, 65540u, 260u, 65536u, 67174656u, 67109120u, 0u, 256u, 65540u,
		67174660u, 67109120u, 67108868u, 256u, 0u, 67174404u, 67109124u, 65536u, 67108864u, 67174660u,
		4u, 65796u, 65792u, 67108868u, 67174400u, 67109124u, 260u, 67174400u, 65796u, 4u,
		67174404u, 65792u, 2151682048u, 2147487808u, 2147487808u, 64u, 4198464u, 2151678016u, 2151677952u, 2147487744u,
		0u, 4198400u, 4198400u, 2151682112u, 2147483712u, 0u, 4194368u, 2151677952u, 2147483648u, 4096u,
		4194304u, 2151682048u, 64u, 4194304u, 2147487744u, 4160u, 2151678016u, 2147483648u, 4160u, 4194368u,
		4096u, 4198464u, 2151682112u, 2147483712u, 4194368u, 2151677952u, 4198400u, 2151682112u, 2147483712u, 0u,
		0u, 4198400u, 4160u, 4194368u, 2151678016u, 2147483648u, 2151682048u, 2147487808u, 2147487808u, 64u,
		2151682112u, 2147483712u, 2147483648u, 4096u, 2151677952u, 2147487744u, 4198464u, 2151678016u, 2147487744u, 4160u,
		4194304u, 2151682048u, 64u, 4194304u, 4096u, 4198464u, 128u, 17039488u, 17039360u, 553648256u,
		262144u, 128u, 536870912u, 17039360u, 537133184u, 262144u, 16777344u, 537133184u, 553648256u, 553910272u,
		262272u, 536870912u, 16777216u, 537133056u, 537133056u, 0u, 536871040u, 553910400u, 553910400u, 16777344u,
		553910272u, 536871040u, 0u, 553648128u, 17039488u, 16777216u, 553648128u, 262272u, 262144u, 553648256u,
		128u, 16777216u, 536870912u, 17039360u, 553648256u, 537133184u, 16777344u, 536870912u, 553910272u, 17039488u,
		537133184u, 128u, 16777216u, 553910272u, 553910400u, 262272u, 553648128u, 553910400u, 17039360u, 0u,
		537133056u, 553648128u, 262272u, 16777344u, 536871040u, 262144u, 0u, 537133056u, 17039488u, 536871040u,
		268435464u, 270532608u, 8192u, 270540808u, 270532608u, 8u, 270540808u, 2097152u, 268443648u, 2105352u,
		2097152u, 268435464u, 2097160u, 268443648u, 268435456u, 8200u, 0u, 2097160u, 268443656u, 8192u,
		2105344u, 268443656u, 8u, 270532616u, 270532616u, 0u, 2105352u, 270540800u, 8200u, 2105344u,
		270540800u, 268435456u, 268443648u, 8u, 270532616u, 2105344u, 270540808u, 2097152u, 8200u, 268435464u,
		2097152u, 268443648u, 268435456u, 8200u, 268435464u, 270540808u, 2105344u, 270532608u, 2105352u, 270540800u,
		0u, 270532616u, 8u, 8192u, 270532608u, 2105352u, 8192u, 2097160u, 268443656u, 0u,
		270540800u, 268435456u, 2097160u, 268443656u, 1048576u, 34603009u, 33555457u, 0u, 1024u, 33555457u,
		1049601u, 34604032u, 34604033u, 1048576u, 0u, 33554433u, 1u, 33554432u, 34603009u, 1025u,
		33555456u, 1049601u, 1048577u, 33555456u, 33554433u, 34603008u, 34604032u, 1048577u, 34603008u, 1024u,
		1025u, 34604033u, 1049600u, 1u, 33554432u, 1049600u, 33554432u, 1049600u, 1048576u, 33555457u,
		33555457u, 34603009u, 34603009u, 1u, 1048577u, 33554432u, 33555456u, 1048576u, 34604032u, 1025u,
		1049601u, 34604032u, 1025u, 33554433u, 34604033u, 34603008u, 1049600u, 0u, 1u, 34604033u,
		0u, 1049601u, 34603008u, 1024u, 33554433u, 33555456u, 1024u, 1048577u, 134219808u, 2048u,
		131072u, 134350880u, 134217728u, 134219808u, 32u, 134217728u, 131104u, 134348800u, 134350880u, 133120u,
		134350848u, 133152u, 2048u, 32u, 134348800u, 134217760u, 134219776u, 2080u, 133120u, 131104u,
		134348832u, 134350848u, 2080u, 0u, 0u, 134348832u, 134217760u, 134219776u, 133152u, 131072u,
		133152u, 131072u, 134350848u, 2048u, 32u, 134348832u, 2048u, 133152u, 134219776u, 32u,
		134217760u, 134348800u, 134348832u, 134217728u, 131072u, 134219808u, 0u, 134350880u, 131104u, 134217760u,
		134348800u, 134219776u, 134219808u, 0u, 134350880u, 133120u, 133120u, 2080u, 2080u, 131104u,
		134217728u, 134350848u
	};

	private static readonly byte[] PC1 = new byte[56]
	{
		56, 48, 40, 32, 24, 16, 8, 0, 57, 49,
		41, 33, 25, 17, 9, 1, 58, 50, 42, 34,
		26, 18, 10, 2, 59, 51, 43, 35, 62, 54,
		46, 38, 30, 22, 14, 6, 61, 53, 45, 37,
		29, 21, 13, 5, 60, 52, 44, 36, 28, 20,
		12, 4, 27, 19, 11, 3
	};

	private static readonly byte[] leftRotTotal = new byte[16]
	{
		1, 2, 4, 6, 8, 10, 12, 14, 15, 17,
		19, 21, 23, 25, 27, 28
	};

	private static readonly byte[] PC2 = new byte[48]
	{
		13, 16, 10, 23, 0, 4, 2, 27, 14, 5,
		20, 9, 22, 18, 11, 3, 25, 7, 15, 6,
		26, 19, 12, 1, 40, 51, 30, 36, 46, 54,
		29, 39, 50, 44, 32, 47, 43, 48, 38, 55,
		33, 52, 45, 41, 49, 35, 28, 31
	};

	internal static readonly uint[] ipTab = new uint[512]
	{
		0u, 0u, 256u, 0u, 0u, 256u, 256u, 256u, 1u, 0u,
		257u, 0u, 1u, 256u, 257u, 256u, 0u, 1u, 256u, 1u,
		0u, 257u, 256u, 257u, 1u, 1u, 257u, 1u, 1u, 257u,
		257u, 257u, 0u, 0u, 16777216u, 0u, 0u, 16777216u, 16777216u, 16777216u,
		65536u, 0u, 16842752u, 0u, 65536u, 16777216u, 16842752u, 16777216u, 0u, 65536u,
		16777216u, 65536u, 0u, 16842752u, 16777216u, 16842752u, 65536u, 65536u, 16842752u, 65536u,
		65536u, 16842752u, 16842752u, 16842752u, 0u, 0u, 512u, 0u, 0u, 512u,
		512u, 512u, 2u, 0u, 514u, 0u, 2u, 512u, 514u, 512u,
		0u, 2u, 512u, 2u, 0u, 514u, 512u, 514u, 2u, 2u,
		514u, 2u, 2u, 514u, 514u, 514u, 0u, 0u, 33554432u, 0u,
		0u, 33554432u, 33554432u, 33554432u, 131072u, 0u, 33685504u, 0u, 131072u, 33554432u,
		33685504u, 33554432u, 0u, 131072u, 33554432u, 131072u, 0u, 33685504u, 33554432u, 33685504u,
		131072u, 131072u, 33685504u, 131072u, 131072u, 33685504u, 33685504u, 33685504u, 0u, 0u,
		1024u, 0u, 0u, 1024u, 1024u, 1024u, 4u, 0u, 1028u, 0u,
		4u, 1024u, 1028u, 1024u, 0u, 4u, 1024u, 4u, 0u, 1028u,
		1024u, 1028u, 4u, 4u, 1028u, 4u, 4u, 1028u, 1028u, 1028u,
		0u, 0u, 67108864u, 0u, 0u, 67108864u, 67108864u, 67108864u, 262144u, 0u,
		67371008u, 0u, 262144u, 67108864u, 67371008u, 67108864u, 0u, 262144u, 67108864u, 262144u,
		0u, 67371008u, 67108864u, 67371008u, 262144u, 262144u, 67371008u, 262144u, 262144u, 67371008u,
		67371008u, 67371008u, 0u, 0u, 2048u, 0u, 0u, 2048u, 2048u, 2048u,
		8u, 0u, 2056u, 0u, 8u, 2048u, 2056u, 2048u, 0u, 8u,
		2048u, 8u, 0u, 2056u, 2048u, 2056u, 8u, 8u, 2056u, 8u,
		8u, 2056u, 2056u, 2056u, 0u, 0u, 134217728u, 0u, 0u, 134217728u,
		134217728u, 134217728u, 524288u, 0u, 134742016u, 0u, 524288u, 134217728u, 134742016u, 134217728u,
		0u, 524288u, 134217728u, 524288u, 0u, 134742016u, 134217728u, 134742016u, 524288u, 524288u,
		134742016u, 524288u, 524288u, 134742016u, 134742016u, 134742016u, 0u, 0u, 4096u, 0u,
		0u, 4096u, 4096u, 4096u, 16u, 0u, 4112u, 0u, 16u, 4096u,
		4112u, 4096u, 0u, 16u, 4096u, 16u, 0u, 4112u, 4096u, 4112u,
		16u, 16u, 4112u, 16u, 16u, 4112u, 4112u, 4112u, 0u, 0u,
		268435456u, 0u, 0u, 268435456u, 268435456u, 268435456u, 1048576u, 0u, 269484032u, 0u,
		1048576u, 268435456u, 269484032u, 268435456u, 0u, 1048576u, 268435456u, 1048576u, 0u, 269484032u,
		268435456u, 269484032u, 1048576u, 1048576u, 269484032u, 1048576u, 1048576u, 269484032u, 269484032u, 269484032u,
		0u, 0u, 8192u, 0u, 0u, 8192u, 8192u, 8192u, 32u, 0u,
		8224u, 0u, 32u, 8192u, 8224u, 8192u, 0u, 32u, 8192u, 32u,
		0u, 8224u, 8192u, 8224u, 32u, 32u, 8224u, 32u, 32u, 8224u,
		8224u, 8224u, 0u, 0u, 536870912u, 0u, 0u, 536870912u, 536870912u, 536870912u,
		2097152u, 0u, 538968064u, 0u, 2097152u, 536870912u, 538968064u, 536870912u, 0u, 2097152u,
		536870912u, 2097152u, 0u, 538968064u, 536870912u, 538968064u, 2097152u, 2097152u, 538968064u, 2097152u,
		2097152u, 538968064u, 538968064u, 538968064u, 0u, 0u, 16384u, 0u, 0u, 16384u,
		16384u, 16384u, 64u, 0u, 16448u, 0u, 64u, 16384u, 16448u, 16384u,
		0u, 64u, 16384u, 64u, 0u, 16448u, 16384u, 16448u, 64u, 64u,
		16448u, 64u, 64u, 16448u, 16448u, 16448u, 0u, 0u, 1073741824u, 0u,
		0u, 1073741824u, 1073741824u, 1073741824u, 4194304u, 0u, 1077936128u, 0u, 4194304u, 1073741824u,
		1077936128u, 1073741824u, 0u, 4194304u, 1073741824u, 4194304u, 0u, 1077936128u, 1073741824u, 1077936128u,
		4194304u, 4194304u, 1077936128u, 4194304u, 4194304u, 1077936128u, 1077936128u, 1077936128u, 0u, 0u,
		32768u, 0u, 0u, 32768u, 32768u, 32768u, 128u, 0u, 32896u, 0u,
		128u, 32768u, 32896u, 32768u, 0u, 128u, 32768u, 128u, 0u, 32896u,
		32768u, 32896u, 128u, 128u, 32896u, 128u, 128u, 32896u, 32896u, 32896u,
		0u, 0u, 2147483648u, 0u, 0u, 2147483648u, 2147483648u, 2147483648u, 8388608u, 0u,
		2155872256u, 0u, 8388608u, 2147483648u, 2155872256u, 2147483648u, 0u, 8388608u, 2147483648u, 8388608u,
		0u, 2155872256u, 2147483648u, 2155872256u, 8388608u, 8388608u, 2155872256u, 8388608u, 8388608u, 2155872256u,
		2155872256u, 2155872256u
	};

	internal static readonly uint[] fpTab = new uint[512]
	{
		0u, 0u, 0u, 64u, 0u, 16384u, 0u, 16448u, 0u, 4194304u,
		0u, 4194368u, 0u, 4210688u, 0u, 4210752u, 0u, 1073741824u, 0u, 1073741888u,
		0u, 1073758208u, 0u, 1073758272u, 0u, 1077936128u, 0u, 1077936192u, 0u, 1077952512u,
		0u, 1077952576u, 0u, 0u, 64u, 0u, 16384u, 0u, 16448u, 0u,
		4194304u, 0u, 4194368u, 0u, 4210688u, 0u, 4210752u, 0u, 1073741824u, 0u,
		1073741888u, 0u, 1073758208u, 0u, 1073758272u, 0u, 1077936128u, 0u, 1077936192u, 0u,
		1077952512u, 0u, 1077952576u, 0u, 0u, 0u, 0u, 16u, 0u, 4096u,
		0u, 4112u, 0u, 1048576u, 0u, 1048592u, 0u, 1052672u, 0u, 1052688u,
		0u, 268435456u, 0u, 268435472u, 0u, 268439552u, 0u, 268439568u, 0u, 269484032u,
		0u, 269484048u, 0u, 269488128u, 0u, 269488144u, 0u, 0u, 16u, 0u,
		4096u, 0u, 4112u, 0u, 1048576u, 0u, 1048592u, 0u, 1052672u, 0u,
		1052688u, 0u, 268435456u, 0u, 268435472u, 0u, 268439552u, 0u, 268439568u, 0u,
		269484032u, 0u, 269484048u, 0u, 269488128u, 0u, 269488144u, 0u, 0u, 0u,
		0u, 4u, 0u, 1024u, 0u, 1028u, 0u, 262144u, 0u, 262148u,
		0u, 263168u, 0u, 263172u, 0u, 67108864u, 0u, 67108868u, 0u, 67109888u,
		0u, 67109892u, 0u, 67371008u, 0u, 67371012u, 0u, 67372032u, 0u, 67372036u,
		0u, 0u, 4u, 0u, 1024u, 0u, 1028u, 0u, 262144u, 0u,
		262148u, 0u, 263168u, 0u, 263172u, 0u, 67108864u, 0u, 67108868u, 0u,
		67109888u, 0u, 67109892u, 0u, 67371008u, 0u, 67371012u, 0u, 67372032u, 0u,
		67372036u, 0u, 0u, 0u, 0u, 1u, 0u, 256u, 0u, 257u,
		0u, 65536u, 0u, 65537u, 0u, 65792u, 0u, 65793u, 0u, 16777216u,
		0u, 16777217u, 0u, 16777472u, 0u, 16777473u, 0u, 16842752u, 0u, 16842753u,
		0u, 16843008u, 0u, 16843009u, 0u, 0u, 1u, 0u, 256u, 0u,
		257u, 0u, 65536u, 0u, 65537u, 0u, 65792u, 0u, 65793u, 0u,
		16777216u, 0u, 16777217u, 0u, 16777472u, 0u, 16777473u, 0u, 16842752u, 0u,
		16842753u, 0u, 16843008u, 0u, 16843009u, 0u, 0u, 0u, 0u, 128u,
		0u, 32768u, 0u, 32896u, 0u, 8388608u, 0u, 8388736u, 0u, 8421376u,
		0u, 8421504u, 0u, 2147483648u, 0u, 2147483776u, 0u, 2147516416u, 0u, 2147516544u,
		0u, 2155872256u, 0u, 2155872384u, 0u, 2155905024u, 0u, 2155905152u, 0u, 0u,
		128u, 0u, 32768u, 0u, 32896u, 0u, 8388608u, 0u, 8388736u, 0u,
		8421376u, 0u, 8421504u, 0u, 2147483648u, 0u, 2147483776u, 0u, 2147516416u, 0u,
		2147516544u, 0u, 2155872256u, 0u, 2155872384u, 0u, 2155905024u, 0u, 2155905152u, 0u,
		0u, 0u, 0u, 32u, 0u, 8192u, 0u, 8224u, 0u, 2097152u,
		0u, 2097184u, 0u, 2105344u, 0u, 2105376u, 0u, 536870912u, 0u, 536870944u,
		0u, 536879104u, 0u, 536879136u, 0u, 538968064u, 0u, 538968096u, 0u, 538976256u,
		0u, 538976288u, 0u, 0u, 32u, 0u, 8192u, 0u, 8224u, 0u,
		2097152u, 0u, 2097184u, 0u, 2105344u, 0u, 2105376u, 0u, 536870912u, 0u,
		536870944u, 0u, 536879104u, 0u, 536879136u, 0u, 538968064u, 0u, 538968096u, 0u,
		538976256u, 0u, 538976288u, 0u, 0u, 0u, 0u, 8u, 0u, 2048u,
		0u, 2056u, 0u, 524288u, 0u, 524296u, 0u, 526336u, 0u, 526344u,
		0u, 134217728u, 0u, 134217736u, 0u, 134219776u, 0u, 134219784u, 0u, 134742016u,
		0u, 134742024u, 0u, 134744064u, 0u, 134744072u, 0u, 0u, 8u, 0u,
		2048u, 0u, 2056u, 0u, 524288u, 0u, 524296u, 0u, 526336u, 0u,
		526344u, 0u, 134217728u, 0u, 134217736u, 0u, 134219776u, 0u, 134219784u, 0u,
		134742016u, 0u, 134742024u, 0u, 134744064u, 0u, 134744072u, 0u, 0u, 0u,
		0u, 2u, 0u, 512u, 0u, 514u, 0u, 131072u, 0u, 131074u,
		0u, 131584u, 0u, 131586u, 0u, 33554432u, 0u, 33554434u, 0u, 33554944u,
		0u, 33554946u, 0u, 33685504u, 0u, 33685506u, 0u, 33686016u, 0u, 33686018u,
		0u, 0u, 2u, 0u, 512u, 0u, 514u, 0u, 131072u, 0u,
		131074u, 0u, 131584u, 0u, 131586u, 0u, 33554432u, 0u, 33554434u, 0u,
		33554944u, 0u, 33554946u, 0u, 33685504u, 0u, 33685506u, 0u, 33686016u, 0u,
		33686018u, 0u
	};

	internal DESTransform(SymmetricAlgorithm symmAlgo, bool encryption, byte[] key, byte[] iv)
		: base(symmAlgo, encryption, iv)
	{
		byte[] array = null;
		if (key == null)
		{
			key = GetStrongKey();
			array = key;
		}
		if (DES.IsWeakKey(key) || DES.IsSemiWeakKey(key))
		{
			throw new CryptographicException(Locale.GetText("This is a known weak, or semi-weak, key."));
		}
		if (array == null)
		{
			array = (byte[])key.Clone();
		}
		keySchedule = new byte[KEY_BYTE_SIZE * 16];
		byteBuff = new byte[BLOCK_BYTE_SIZE];
		dwordBuff = new uint[BLOCK_BYTE_SIZE / 4];
		SetKey(array);
	}

	private uint CipherFunct(uint r, int n)
	{
		byte[] array = keySchedule;
		int num = n << 3;
		uint num2 = (r >> 1) | (r << 31);
		uint num3 = 0 | spBoxes[((num2 >> 26) ^ array[num++]) & 0x3F] | spBoxes[64 + (((num2 >> 22) ^ array[num++]) & 0x3F)] | spBoxes[128 + (((num2 >> 18) ^ array[num++]) & 0x3F)] | spBoxes[192 + (((num2 >> 14) ^ array[num++]) & 0x3F)] | spBoxes[256 + (((num2 >> 10) ^ array[num++]) & 0x3F)] | spBoxes[320 + (((num2 >> 6) ^ array[num++]) & 0x3F)] | spBoxes[384 + (((num2 >> 2) ^ array[num++]) & 0x3F)];
		num2 = (r << 1) | (r >> 31);
		return num3 | spBoxes[448 + ((num2 ^ array[num]) & 0x3F)];
	}

	internal static void Permutation(byte[] input, byte[] output, uint[] permTab, bool preSwap)
	{
		if (preSwap && BitConverter.IsLittleEndian)
		{
			BSwap(input);
		}
		int num = input[0] >> 4 << 1;
		int num2 = 32 + ((input[0] & 0xF) << 1);
		uint num3 = permTab[num++] | permTab[num2++];
		uint num4 = permTab[num] | permTab[num2];
		int num5 = BLOCK_BYTE_SIZE << 1;
		int num6 = 2;
		int num7 = 1;
		while (num6 < num5)
		{
			int num8 = input[num7];
			num = (num6 << 5) + (num8 >> 4 << 1);
			num2 = (num6 + 1 << 5) + ((num8 & 0xF) << 1);
			num3 |= permTab[num++] | permTab[num2++];
			num4 |= permTab[num] | permTab[num2];
			num6 += 2;
			num7++;
		}
		if (preSwap || !BitConverter.IsLittleEndian)
		{
			output[0] = (byte)num3;
			output[1] = (byte)(num3 >> 8);
			output[2] = (byte)(num3 >> 16);
			output[3] = (byte)(num3 >> 24);
			output[4] = (byte)num4;
			output[5] = (byte)(num4 >> 8);
			output[6] = (byte)(num4 >> 16);
			output[7] = (byte)(num4 >> 24);
		}
		else
		{
			output[0] = (byte)(num3 >> 24);
			output[1] = (byte)(num3 >> 16);
			output[2] = (byte)(num3 >> 8);
			output[3] = (byte)num3;
			output[4] = (byte)(num4 >> 24);
			output[5] = (byte)(num4 >> 16);
			output[6] = (byte)(num4 >> 8);
			output[7] = (byte)num4;
		}
	}

	private static void BSwap(byte[] byteBuff)
	{
		byte b = byteBuff[0];
		byteBuff[0] = byteBuff[3];
		byteBuff[3] = b;
		b = byteBuff[1];
		byteBuff[1] = byteBuff[2];
		byteBuff[2] = b;
		b = byteBuff[4];
		byteBuff[4] = byteBuff[7];
		byteBuff[7] = b;
		b = byteBuff[5];
		byteBuff[5] = byteBuff[6];
		byteBuff[6] = b;
	}

	internal void SetKey(byte[] key)
	{
		Array.Clear(keySchedule, 0, keySchedule.Length);
		int num = PC1.Length;
		byte[] array = new byte[num];
		byte[] array2 = new byte[num];
		int num2 = 0;
		byte[] pC = PC1;
		foreach (byte b in pC)
		{
			array[num2++] = (byte)((key[b >> 3] >> (7 ^ (b & 7))) & 1);
		}
		for (int j = 0; j < KEY_BYTE_SIZE * 2; j++)
		{
			int num3 = num >> 1;
			int k;
			for (k = 0; k < num3; k++)
			{
				int num4 = k + leftRotTotal[j];
				array2[k] = array[(num4 < num3) ? num4 : (num4 - num3)];
			}
			for (k = num3; k < num; k++)
			{
				int num5 = k + leftRotTotal[j];
				array2[k] = array[(num5 < num) ? num5 : (num5 - num3)];
			}
			int num6 = j * KEY_BYTE_SIZE;
			k = 0;
			pC = PC2;
			foreach (byte b2 in pC)
			{
				if (array2[b2] != 0)
				{
					keySchedule[num6 + k / 6] |= (byte)(128 >> k % 6 + 2);
				}
				k++;
			}
		}
	}

	public void ProcessBlock(byte[] input, byte[] output)
	{
		Buffer.BlockCopy(input, 0, dwordBuff, 0, BLOCK_BYTE_SIZE);
		if (encrypt)
		{
			uint num = dwordBuff[0];
			uint num2 = dwordBuff[1];
			num ^= CipherFunct(num2, 0);
			num2 ^= CipherFunct(num, 1);
			num ^= CipherFunct(num2, 2);
			num2 ^= CipherFunct(num, 3);
			num ^= CipherFunct(num2, 4);
			num2 ^= CipherFunct(num, 5);
			num ^= CipherFunct(num2, 6);
			num2 ^= CipherFunct(num, 7);
			num ^= CipherFunct(num2, 8);
			num2 ^= CipherFunct(num, 9);
			num ^= CipherFunct(num2, 10);
			num2 ^= CipherFunct(num, 11);
			num ^= CipherFunct(num2, 12);
			num2 ^= CipherFunct(num, 13);
			num ^= CipherFunct(num2, 14);
			num2 ^= CipherFunct(num, 15);
			dwordBuff[0] = num2;
			dwordBuff[1] = num;
		}
		else
		{
			uint num3 = dwordBuff[0];
			uint num4 = dwordBuff[1];
			num3 ^= CipherFunct(num4, 15);
			num4 ^= CipherFunct(num3, 14);
			num3 ^= CipherFunct(num4, 13);
			num4 ^= CipherFunct(num3, 12);
			num3 ^= CipherFunct(num4, 11);
			num4 ^= CipherFunct(num3, 10);
			num3 ^= CipherFunct(num4, 9);
			num4 ^= CipherFunct(num3, 8);
			num3 ^= CipherFunct(num4, 7);
			num4 ^= CipherFunct(num3, 6);
			num3 ^= CipherFunct(num4, 5);
			num4 ^= CipherFunct(num3, 4);
			num3 ^= CipherFunct(num4, 3);
			num4 ^= CipherFunct(num3, 2);
			num3 ^= CipherFunct(num4, 1);
			num4 ^= CipherFunct(num3, 0);
			dwordBuff[0] = num4;
			dwordBuff[1] = num3;
		}
		Buffer.BlockCopy(dwordBuff, 0, output, 0, BLOCK_BYTE_SIZE);
	}

	protected override void ECB(byte[] input, byte[] output)
	{
		Permutation(input, output, ipTab, preSwap: false);
		ProcessBlock(output, byteBuff);
		Permutation(byteBuff, output, fpTab, preSwap: true);
	}

	internal static byte[] GetStrongKey()
	{
		byte[] array = KeyBuilder.Key(KEY_BYTE_SIZE);
		while (DES.IsWeakKey(array) || DES.IsSemiWeakKey(array))
		{
			array = KeyBuilder.Key(KEY_BYTE_SIZE);
		}
		return array;
	}
}
