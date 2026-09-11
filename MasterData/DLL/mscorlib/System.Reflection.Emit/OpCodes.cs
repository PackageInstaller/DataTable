using System.Runtime.InteropServices;

namespace System.Reflection.Emit;

[ComVisible(true)]
public class OpCodes
{
	public static readonly OpCode Nop = new OpCode(1179903, 84215041);

	public static readonly OpCode Break = new OpCode(1180159, 17106177);

	public static readonly OpCode Ldarg_0 = new OpCode(1245951, 84214017);

	public static readonly OpCode Ldarg_1 = new OpCode(1246207, 84214017);

	public static readonly OpCode Ldarg_2 = new OpCode(1246463, 84214017);

	public static readonly OpCode Ldarg_3 = new OpCode(1246719, 84214017);

	public static readonly OpCode Ldloc_0 = new OpCode(1246975, 84214017);

	public static readonly OpCode Ldloc_1 = new OpCode(1247231, 84214017);

	public static readonly OpCode Ldloc_2 = new OpCode(1247487, 84214017);

	public static readonly OpCode Ldloc_3 = new OpCode(1247743, 84214017);

	public static readonly OpCode Stloc_0 = new OpCode(17959679, 84214017);

	public static readonly OpCode Stloc_1 = new OpCode(17959935, 84214017);

	public static readonly OpCode Stloc_2 = new OpCode(17960191, 84214017);

	public static readonly OpCode Stloc_3 = new OpCode(17960447, 84214017);

	public static readonly OpCode Ldarg_S = new OpCode(1249023, 85065985);

	public static readonly OpCode Ldarga_S = new OpCode(1380351, 85065985);

	public static readonly OpCode Starg_S = new OpCode(17961215, 85065985);

	public static readonly OpCode Ldloc_S = new OpCode(1249791, 85065985);

	public static readonly OpCode Ldloca_S = new OpCode(1381119, 85065985);

	public static readonly OpCode Stloc_S = new OpCode(17961983, 85065985);

	public static readonly OpCode Ldnull = new OpCode(1643775, 84215041);

	public static readonly OpCode Ldc_I4_M1 = new OpCode(1381887, 84214017);

	public static readonly OpCode Ldc_I4_0 = new OpCode(1382143, 84214017);

	public static readonly OpCode Ldc_I4_1 = new OpCode(1382399, 84214017);

	public static readonly OpCode Ldc_I4_2 = new OpCode(1382655, 84214017);

	public static readonly OpCode Ldc_I4_3 = new OpCode(1382911, 84214017);

	public static readonly OpCode Ldc_I4_4 = new OpCode(1383167, 84214017);

	public static readonly OpCode Ldc_I4_5 = new OpCode(1383423, 84214017);

	public static readonly OpCode Ldc_I4_6 = new OpCode(1383679, 84214017);

	public static readonly OpCode Ldc_I4_7 = new OpCode(1383935, 84214017);

	public static readonly OpCode Ldc_I4_8 = new OpCode(1384191, 84214017);

	public static readonly OpCode Ldc_I4_S = new OpCode(1384447, 84934913);

	public static readonly OpCode Ldc_I4 = new OpCode(1384703, 84018433);

	public static readonly OpCode Ldc_I8 = new OpCode(1450495, 84083969);

	public static readonly OpCode Ldc_R4 = new OpCode(1516287, 85001473);

	public static readonly OpCode Ldc_R8 = new OpCode(1582079, 84346113);

	public static readonly OpCode Dup = new OpCode(18097663, 84215041);

	public static readonly OpCode Pop = new OpCode(17966847, 84215041);

	public static readonly OpCode Jmp = new OpCode(1189887, 33817857);

	public static readonly OpCode Call = new OpCode(437987583, 33817857);

	public static readonly OpCode Calli = new OpCode(437987839, 34145537);

	public static readonly OpCode Ret = new OpCode(437398271, 117769473);

	public static readonly OpCode Br_S = new OpCode(1190911, 983297);

	public static readonly OpCode Brfalse_S = new OpCode(51522815, 51314945);

	public static readonly OpCode Brtrue_S = new OpCode(51523071, 51314945);

	public static readonly OpCode Beq_S = new OpCode(34746111, 51314945);

	public static readonly OpCode Bge_S = new OpCode(34746367, 51314945);

	public static readonly OpCode Bgt_S = new OpCode(34746623, 51314945);

	public static readonly OpCode Ble_S = new OpCode(34746879, 51314945);

	public static readonly OpCode Blt_S = new OpCode(34747135, 51314945);

	public static readonly OpCode Bne_Un_S = new OpCode(34747391, 51314945);

	public static readonly OpCode Bge_Un_S = new OpCode(34747647, 51314945);

	public static readonly OpCode Bgt_Un_S = new OpCode(34747903, 51314945);

	public static readonly OpCode Ble_Un_S = new OpCode(34748159, 51314945);

	public static readonly OpCode Blt_Un_S = new OpCode(34748415, 51314945);

	public static readonly OpCode Br = new OpCode(1194239, 1281);

	public static readonly OpCode Brfalse = new OpCode(51526143, 50332929);

	public static readonly OpCode Brtrue = new OpCode(51526399, 50332929);

	public static readonly OpCode Beq = new OpCode(34749439, 50331905);

	public static readonly OpCode Bge = new OpCode(34749695, 50331905);

	public static readonly OpCode Bgt = new OpCode(34749951, 50331905);

	public static readonly OpCode Ble = new OpCode(34750207, 50331905);

	public static readonly OpCode Blt = new OpCode(34750463, 50331905);

	public static readonly OpCode Bne_Un = new OpCode(34750719, 50331905);

	public static readonly OpCode Bge_Un = new OpCode(34750975, 50331905);

	public static readonly OpCode Bgt_Un = new OpCode(34751231, 50331905);

	public static readonly OpCode Ble_Un = new OpCode(34751487, 50331905);

	public static readonly OpCode Blt_Un = new OpCode(34751743, 50331905);

	public static readonly OpCode Switch = new OpCode(51529215, 51053825);

	public static readonly OpCode Ldind_I1 = new OpCode(51726079, 84215041);

	public static readonly OpCode Ldind_U1 = new OpCode(51726335, 84215041);

	public static readonly OpCode Ldind_I2 = new OpCode(51726591, 84215041);

	public static readonly OpCode Ldind_U2 = new OpCode(51726847, 84215041);

	public static readonly OpCode Ldind_I4 = new OpCode(51727103, 84215041);

	public static readonly OpCode Ldind_U4 = new OpCode(51727359, 84215041);

	public static readonly OpCode Ldind_I8 = new OpCode(51793151, 84215041);

	public static readonly OpCode Ldind_I = new OpCode(51727871, 84215041);

	public static readonly OpCode Ldind_R4 = new OpCode(51859199, 84215041);

	public static readonly OpCode Ldind_R8 = new OpCode(51924991, 84215041);

	public static readonly OpCode Ldind_Ref = new OpCode(51990783, 84215041);

	public static readonly OpCode Stind_Ref = new OpCode(85086719, 84215041);

	public static readonly OpCode Stind_I1 = new OpCode(85086975, 84215041);

	public static readonly OpCode Stind_I2 = new OpCode(85087231, 84215041);

	public static readonly OpCode Stind_I4 = new OpCode(85087487, 84215041);

	public static readonly OpCode Stind_I8 = new OpCode(101864959, 84215041);

	public static readonly OpCode Stind_R4 = new OpCode(135419647, 84215041);

	public static readonly OpCode Stind_R8 = new OpCode(152197119, 84215041);

	public static readonly OpCode Add = new OpCode(34822399, 84215041);

	public static readonly OpCode Sub = new OpCode(34822655, 84215041);

	public static readonly OpCode Mul = new OpCode(34822911, 84215041);

	public static readonly OpCode Div = new OpCode(34823167, 84215041);

	public static readonly OpCode Div_Un = new OpCode(34823423, 84215041);

	public static readonly OpCode Rem = new OpCode(34823679, 84215041);

	public static readonly OpCode Rem_Un = new OpCode(34823935, 84215041);

	public static readonly OpCode And = new OpCode(34824191, 84215041);

	public static readonly OpCode Or = new OpCode(34824447, 84215041);

	public static readonly OpCode Xor = new OpCode(34824703, 84215041);

	public static readonly OpCode Shl = new OpCode(34824959, 84215041);

	public static readonly OpCode Shr = new OpCode(34825215, 84215041);

	public static readonly OpCode Shr_Un = new OpCode(34825471, 84215041);

	public static readonly OpCode Neg = new OpCode(18048511, 84215041);

	public static readonly OpCode Not = new OpCode(18048767, 84215041);

	public static readonly OpCode Conv_I1 = new OpCode(18180095, 84215041);

	public static readonly OpCode Conv_I2 = new OpCode(18180351, 84215041);

	public static readonly OpCode Conv_I4 = new OpCode(18180607, 84215041);

	public static readonly OpCode Conv_I8 = new OpCode(18246399, 84215041);

	public static readonly OpCode Conv_R4 = new OpCode(18312191, 84215041);

	public static readonly OpCode Conv_R8 = new OpCode(18377983, 84215041);

	public static readonly OpCode Conv_U4 = new OpCode(18181631, 84215041);

	public static readonly OpCode Conv_U8 = new OpCode(18247423, 84215041);

	public static readonly OpCode Callvirt = new OpCode(438005759, 33817345);

	public static readonly OpCode Cpobj = new OpCode(85094655, 84738817);

	public static readonly OpCode Ldobj = new OpCode(51606015, 84738817);

	public static readonly OpCode Ldstr = new OpCode(1667839, 84542209);

	public static readonly OpCode Newobj = new OpCode(437875711, 33817345);

	[ComVisible(true)]
	public static readonly OpCode Castclass = new OpCode(169440511, 84738817);

	public static readonly OpCode Isinst = new OpCode(169178623, 84738817);

	public static readonly OpCode Conv_R_Un = new OpCode(18380543, 84215041);

	public static readonly OpCode Unbox = new OpCode(169179647, 84739329);

	public static readonly OpCode Throw = new OpCode(168983295, 134546177);

	public static readonly OpCode Ldfld = new OpCode(169049087, 83952385);

	public static readonly OpCode Ldflda = new OpCode(169180415, 83952385);

	public static readonly OpCode Stfld = new OpCode(185761279, 83952385);

	public static readonly OpCode Ldsfld = new OpCode(1277695, 83952385);

	public static readonly OpCode Ldsflda = new OpCode(1409023, 83952385);

	public static readonly OpCode Stsfld = new OpCode(17989887, 83952385);

	public static readonly OpCode Stobj = new OpCode(68321791, 84739329);

	public static readonly OpCode Conv_Ovf_I1_Un = new OpCode(18187007, 84215041);

	public static readonly OpCode Conv_Ovf_I2_Un = new OpCode(18187263, 84215041);

	public static readonly OpCode Conv_Ovf_I4_Un = new OpCode(18187519, 84215041);

	public static readonly OpCode Conv_Ovf_I8_Un = new OpCode(18253311, 84215041);

	public static readonly OpCode Conv_Ovf_U1_Un = new OpCode(18188031, 84215041);

	public static readonly OpCode Conv_Ovf_U2_Un = new OpCode(18188287, 84215041);

	public static readonly OpCode Conv_Ovf_U4_Un = new OpCode(18188543, 84215041);

	public static readonly OpCode Conv_Ovf_U8_Un = new OpCode(18254335, 84215041);

	public static readonly OpCode Conv_Ovf_I_Un = new OpCode(18189055, 84215041);

	public static readonly OpCode Conv_Ovf_U_Un = new OpCode(18189311, 84215041);

	public static readonly OpCode Box = new OpCode(18451711, 84739329);

	public static readonly OpCode Newarr = new OpCode(52006399, 84738817);

	public static readonly OpCode Ldlen = new OpCode(169185023, 84214529);

	public static readonly OpCode Ldelema = new OpCode(202739711, 84738817);

	public static readonly OpCode Ldelem_I1 = new OpCode(202739967, 84214529);

	public static readonly OpCode Ldelem_U1 = new OpCode(202740223, 84214529);

	public static readonly OpCode Ldelem_I2 = new OpCode(202740479, 84214529);

	public static readonly OpCode Ldelem_U2 = new OpCode(202740735, 84214529);

	public static readonly OpCode Ldelem_I4 = new OpCode(202740991, 84214529);

	public static readonly OpCode Ldelem_U4 = new OpCode(202741247, 84214529);

	public static readonly OpCode Ldelem_I8 = new OpCode(202807039, 84214529);

	public static readonly OpCode Ldelem_I = new OpCode(202741759, 84214529);

	public static readonly OpCode Ldelem_R4 = new OpCode(202873087, 84214529);

	public static readonly OpCode Ldelem_R8 = new OpCode(202938879, 84214529);

	public static readonly OpCode Ldelem_Ref = new OpCode(203004671, 84214529);

	public static readonly OpCode Stelem_I = new OpCode(219323391, 84214529);

	public static readonly OpCode Stelem_I1 = new OpCode(219323647, 84214529);

	public static readonly OpCode Stelem_I2 = new OpCode(219323903, 84214529);

	public static readonly OpCode Stelem_I4 = new OpCode(219324159, 84214529);

	public static readonly OpCode Stelem_I8 = new OpCode(236101631, 84214529);

	public static readonly OpCode Stelem_R4 = new OpCode(252879103, 84214529);

	public static readonly OpCode Stelem_R8 = new OpCode(269656575, 84214529);

	public static readonly OpCode Stelem_Ref = new OpCode(286434047, 84214529);

	public static readonly OpCode Ldelem = new OpCode(202613759, 84738817);

	public static readonly OpCode Stelem = new OpCode(470983935, 84738817);

	public static readonly OpCode Unbox_Any = new OpCode(169059839, 84738817);

	public static readonly OpCode Conv_Ovf_I1 = new OpCode(18199551, 84215041);

	public static readonly OpCode Conv_Ovf_U1 = new OpCode(18199807, 84215041);

	public static readonly OpCode Conv_Ovf_I2 = new OpCode(18200063, 84215041);

	public static readonly OpCode Conv_Ovf_U2 = new OpCode(18200319, 84215041);

	public static readonly OpCode Conv_Ovf_I4 = new OpCode(18200575, 84215041);

	public static readonly OpCode Conv_Ovf_U4 = new OpCode(18200831, 84215041);

	public static readonly OpCode Conv_Ovf_I8 = new OpCode(18266623, 84215041);

	public static readonly OpCode Conv_Ovf_U8 = new OpCode(18266879, 84215041);

	public static readonly OpCode Refanyval = new OpCode(18203391, 84739329);

	public static readonly OpCode Ckfinite = new OpCode(18400255, 84215041);

	public static readonly OpCode Mkrefany = new OpCode(51627775, 84739329);

	public static readonly OpCode Ldtoken = new OpCode(1429759, 84673793);

	public static readonly OpCode Conv_U2 = new OpCode(18207231, 84215041);

	public static readonly OpCode Conv_U1 = new OpCode(18207487, 84215041);

	public static readonly OpCode Conv_I = new OpCode(18207743, 84215041);

	public static readonly OpCode Conv_Ovf_I = new OpCode(18207999, 84215041);

	public static readonly OpCode Conv_Ovf_U = new OpCode(18208255, 84215041);

	public static readonly OpCode Add_Ovf = new OpCode(34854655, 84215041);

	public static readonly OpCode Add_Ovf_Un = new OpCode(34854911, 84215041);

	public static readonly OpCode Mul_Ovf = new OpCode(34855167, 84215041);

	public static readonly OpCode Mul_Ovf_Un = new OpCode(34855423, 84215041);

	public static readonly OpCode Sub_Ovf = new OpCode(34855679, 84215041);

	public static readonly OpCode Sub_Ovf_Un = new OpCode(34855935, 84215041);

	public static readonly OpCode Endfinally = new OpCode(1236223, 117769473);

	public static readonly OpCode Leave = new OpCode(1236479, 1281);

	public static readonly OpCode Leave_S = new OpCode(1236735, 984321);

	public static readonly OpCode Stind_I = new OpCode(85123071, 84215041);

	public static readonly OpCode Conv_U = new OpCode(18211071, 84215041);

	public static readonly OpCode Prefix7 = new OpCode(1243391, 67437057);

	public static readonly OpCode Prefix6 = new OpCode(1243647, 67437057);

	public static readonly OpCode Prefix5 = new OpCode(1243903, 67437057);

	public static readonly OpCode Prefix4 = new OpCode(1244159, 67437057);

	public static readonly OpCode Prefix3 = new OpCode(1244415, 67437057);

	public static readonly OpCode Prefix2 = new OpCode(1244671, 67437057);

	public static readonly OpCode Prefix1 = new OpCode(1244927, 67437057);

	public static readonly OpCode Prefixref = new OpCode(1245183, 67437057);

	public static readonly OpCode Arglist = new OpCode(1376510, 84215042);

	public static readonly OpCode Ceq = new OpCode(34931198, 84215042);

	public static readonly OpCode Cgt = new OpCode(34931454, 84215042);

	public static readonly OpCode Cgt_Un = new OpCode(34931710, 84215042);

	public static readonly OpCode Clt = new OpCode(34931966, 84215042);

	public static readonly OpCode Clt_Un = new OpCode(34932222, 84215042);

	public static readonly OpCode Ldftn = new OpCode(1378046, 84149506);

	public static readonly OpCode Ldvirtftn = new OpCode(169150462, 84149506);

	public static readonly OpCode Ldarg = new OpCode(1247742, 84804866);

	public static readonly OpCode Ldarga = new OpCode(1379070, 84804866);

	public static readonly OpCode Starg = new OpCode(17959934, 84804866);

	public static readonly OpCode Ldloc = new OpCode(1248510, 84804866);

	public static readonly OpCode Ldloca = new OpCode(1379838, 84804866);

	public static readonly OpCode Stloc = new OpCode(17960702, 84804866);

	public static readonly OpCode Localloc = new OpCode(51711998, 84215042);

	public static readonly OpCode Endfilter = new OpCode(51515902, 117769474);

	public static readonly OpCode Unaligned = new OpCode(1184510, 68158466);

	public static readonly OpCode Volatile = new OpCode(1184766, 67437570);

	public static readonly OpCode Tailcall = new OpCode(1185022, 67437570);

	public static readonly OpCode Initobj = new OpCode(51516926, 84738818);

	public static readonly OpCode Constrained = new OpCode(1185534, 67961858);

	public static readonly OpCode Cpblk = new OpCode(118626302, 84215042);

	public static readonly OpCode Initblk = new OpCode(118626558, 84215042);

	public static readonly OpCode Rethrow = new OpCode(1186558, 134546178);

	public static readonly OpCode Sizeof = new OpCode(1383678, 84739330);

	public static readonly OpCode Refanytype = new OpCode(18161150, 84215042);

	public static readonly OpCode Readonly = new OpCode(1187582, 67437570);
}
