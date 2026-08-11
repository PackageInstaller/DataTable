using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

internal class FastKeyboard : Keyboard
{
	public const string metadata = ";AnyKey;Button;Axis;Key;DiscreteButton;Keyboard";

	public FastKeyboard()
	{
		InputControlExtensions.DeviceBuilder deviceBuilder = this.Setup(115, 15, 7).WithName("Keyboard").WithDisplayName("Keyboard")
			.WithChildren(0, 115)
			.WithLayout(new InternedString("Keyboard"))
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1262836051),
				sizeInBits = 112u
			});
		InternedString kAnyKeyLayout = new InternedString("AnyKey");
		InternedString kKeyLayout = new InternedString("Key");
		InternedString kDiscreteButtonLayout = new InternedString("DiscreteButton");
		InternedString kButtonLayout = new InternedString("Button");
		AnyKeyControl anyKeyControl = Initialize_ctrlKeyboardanyKey(kAnyKeyLayout, this);
		KeyControl keyControl = Initialize_ctrlKeyboardescape(kKeyLayout, this);
		KeyControl keyControl2 = Initialize_ctrlKeyboardspace(kKeyLayout, this);
		KeyControl keyControl3 = Initialize_ctrlKeyboardenter(kKeyLayout, this);
		KeyControl keyControl4 = Initialize_ctrlKeyboardtab(kKeyLayout, this);
		KeyControl keyControl5 = Initialize_ctrlKeyboardbackquote(kKeyLayout, this);
		KeyControl keyControl6 = Initialize_ctrlKeyboardquote(kKeyLayout, this);
		KeyControl keyControl7 = Initialize_ctrlKeyboardsemicolon(kKeyLayout, this);
		KeyControl keyControl8 = Initialize_ctrlKeyboardcomma(kKeyLayout, this);
		KeyControl keyControl9 = Initialize_ctrlKeyboardperiod(kKeyLayout, this);
		KeyControl keyControl10 = Initialize_ctrlKeyboardslash(kKeyLayout, this);
		KeyControl keyControl11 = Initialize_ctrlKeyboardbackslash(kKeyLayout, this);
		KeyControl keyControl12 = Initialize_ctrlKeyboardleftBracket(kKeyLayout, this);
		KeyControl keyControl13 = Initialize_ctrlKeyboardrightBracket(kKeyLayout, this);
		KeyControl keyControl14 = Initialize_ctrlKeyboardminus(kKeyLayout, this);
		KeyControl keyControl15 = Initialize_ctrlKeyboardequals(kKeyLayout, this);
		KeyControl keyControl16 = Initialize_ctrlKeyboardupArrow(kKeyLayout, this);
		KeyControl keyControl17 = Initialize_ctrlKeyboarddownArrow(kKeyLayout, this);
		KeyControl keyControl18 = Initialize_ctrlKeyboardleftArrow(kKeyLayout, this);
		KeyControl keyControl19 = Initialize_ctrlKeyboardrightArrow(kKeyLayout, this);
		KeyControl keyControl20 = Initialize_ctrlKeyboarda(kKeyLayout, this);
		KeyControl keyControl21 = Initialize_ctrlKeyboardb(kKeyLayout, this);
		KeyControl keyControl22 = Initialize_ctrlKeyboardc(kKeyLayout, this);
		KeyControl keyControl23 = Initialize_ctrlKeyboardd(kKeyLayout, this);
		KeyControl keyControl24 = Initialize_ctrlKeyboarde(kKeyLayout, this);
		KeyControl keyControl25 = Initialize_ctrlKeyboardf(kKeyLayout, this);
		KeyControl keyControl26 = Initialize_ctrlKeyboardg(kKeyLayout, this);
		KeyControl keyControl27 = Initialize_ctrlKeyboardh(kKeyLayout, this);
		KeyControl keyControl28 = Initialize_ctrlKeyboardi(kKeyLayout, this);
		KeyControl keyControl29 = Initialize_ctrlKeyboardj(kKeyLayout, this);
		KeyControl keyControl30 = Initialize_ctrlKeyboardk(kKeyLayout, this);
		KeyControl keyControl31 = Initialize_ctrlKeyboardl(kKeyLayout, this);
		KeyControl keyControl32 = Initialize_ctrlKeyboardm(kKeyLayout, this);
		KeyControl keyControl33 = Initialize_ctrlKeyboardn(kKeyLayout, this);
		KeyControl keyControl34 = Initialize_ctrlKeyboardo(kKeyLayout, this);
		KeyControl keyControl35 = Initialize_ctrlKeyboardp(kKeyLayout, this);
		KeyControl keyControl36 = Initialize_ctrlKeyboardq(kKeyLayout, this);
		KeyControl keyControl37 = Initialize_ctrlKeyboardr(kKeyLayout, this);
		KeyControl keyControl38 = Initialize_ctrlKeyboards(kKeyLayout, this);
		KeyControl keyControl39 = Initialize_ctrlKeyboardt(kKeyLayout, this);
		KeyControl keyControl40 = Initialize_ctrlKeyboardu(kKeyLayout, this);
		KeyControl keyControl41 = Initialize_ctrlKeyboardv(kKeyLayout, this);
		KeyControl keyControl42 = Initialize_ctrlKeyboardw(kKeyLayout, this);
		KeyControl keyControl43 = Initialize_ctrlKeyboardx(kKeyLayout, this);
		KeyControl keyControl44 = Initialize_ctrlKeyboardy(kKeyLayout, this);
		KeyControl keyControl45 = Initialize_ctrlKeyboardz(kKeyLayout, this);
		KeyControl keyControl46 = Initialize_ctrlKeyboard1(kKeyLayout, this);
		KeyControl keyControl47 = Initialize_ctrlKeyboard2(kKeyLayout, this);
		KeyControl keyControl48 = Initialize_ctrlKeyboard3(kKeyLayout, this);
		KeyControl keyControl49 = Initialize_ctrlKeyboard4(kKeyLayout, this);
		KeyControl keyControl50 = Initialize_ctrlKeyboard5(kKeyLayout, this);
		KeyControl keyControl51 = Initialize_ctrlKeyboard6(kKeyLayout, this);
		KeyControl keyControl52 = Initialize_ctrlKeyboard7(kKeyLayout, this);
		KeyControl keyControl53 = Initialize_ctrlKeyboard8(kKeyLayout, this);
		KeyControl keyControl54 = Initialize_ctrlKeyboard9(kKeyLayout, this);
		KeyControl keyControl55 = Initialize_ctrlKeyboard0(kKeyLayout, this);
		KeyControl keyControl56 = Initialize_ctrlKeyboardleftShift(kKeyLayout, this);
		KeyControl keyControl57 = Initialize_ctrlKeyboardrightShift(kKeyLayout, this);
		DiscreteButtonControl control = Initialize_ctrlKeyboardshift(kDiscreteButtonLayout, this);
		KeyControl keyControl58 = Initialize_ctrlKeyboardleftAlt(kKeyLayout, this);
		KeyControl keyControl59 = Initialize_ctrlKeyboardrightAlt(kKeyLayout, this);
		DiscreteButtonControl control2 = Initialize_ctrlKeyboardalt(kDiscreteButtonLayout, this);
		KeyControl keyControl60 = Initialize_ctrlKeyboardleftCtrl(kKeyLayout, this);
		KeyControl keyControl61 = Initialize_ctrlKeyboardrightCtrl(kKeyLayout, this);
		DiscreteButtonControl control3 = Initialize_ctrlKeyboardctrl(kDiscreteButtonLayout, this);
		KeyControl keyControl62 = Initialize_ctrlKeyboardleftMeta(kKeyLayout, this);
		KeyControl keyControl63 = Initialize_ctrlKeyboardrightMeta(kKeyLayout, this);
		KeyControl keyControl64 = Initialize_ctrlKeyboardcontextMenu(kKeyLayout, this);
		KeyControl keyControl65 = Initialize_ctrlKeyboardbackspace(kKeyLayout, this);
		KeyControl keyControl66 = Initialize_ctrlKeyboardpageDown(kKeyLayout, this);
		KeyControl keyControl67 = Initialize_ctrlKeyboardpageUp(kKeyLayout, this);
		KeyControl keyControl68 = Initialize_ctrlKeyboardhome(kKeyLayout, this);
		KeyControl keyControl69 = Initialize_ctrlKeyboardend(kKeyLayout, this);
		KeyControl keyControl70 = Initialize_ctrlKeyboardinsert(kKeyLayout, this);
		KeyControl keyControl71 = Initialize_ctrlKeyboarddelete(kKeyLayout, this);
		KeyControl keyControl72 = Initialize_ctrlKeyboardcapsLock(kKeyLayout, this);
		KeyControl keyControl73 = Initialize_ctrlKeyboardnumLock(kKeyLayout, this);
		KeyControl keyControl74 = Initialize_ctrlKeyboardprintScreen(kKeyLayout, this);
		KeyControl keyControl75 = Initialize_ctrlKeyboardscrollLock(kKeyLayout, this);
		KeyControl keyControl76 = Initialize_ctrlKeyboardpause(kKeyLayout, this);
		KeyControl keyControl77 = Initialize_ctrlKeyboardnumpadEnter(kKeyLayout, this);
		KeyControl keyControl78 = Initialize_ctrlKeyboardnumpadDivide(kKeyLayout, this);
		KeyControl keyControl79 = Initialize_ctrlKeyboardnumpadMultiply(kKeyLayout, this);
		KeyControl keyControl80 = Initialize_ctrlKeyboardnumpadPlus(kKeyLayout, this);
		KeyControl keyControl81 = Initialize_ctrlKeyboardnumpadMinus(kKeyLayout, this);
		KeyControl keyControl82 = Initialize_ctrlKeyboardnumpadPeriod(kKeyLayout, this);
		KeyControl keyControl83 = Initialize_ctrlKeyboardnumpadEquals(kKeyLayout, this);
		KeyControl keyControl84 = Initialize_ctrlKeyboardnumpad1(kKeyLayout, this);
		KeyControl keyControl85 = Initialize_ctrlKeyboardnumpad2(kKeyLayout, this);
		KeyControl keyControl86 = Initialize_ctrlKeyboardnumpad3(kKeyLayout, this);
		KeyControl keyControl87 = Initialize_ctrlKeyboardnumpad4(kKeyLayout, this);
		KeyControl keyControl88 = Initialize_ctrlKeyboardnumpad5(kKeyLayout, this);
		KeyControl keyControl89 = Initialize_ctrlKeyboardnumpad6(kKeyLayout, this);
		KeyControl keyControl90 = Initialize_ctrlKeyboardnumpad7(kKeyLayout, this);
		KeyControl keyControl91 = Initialize_ctrlKeyboardnumpad8(kKeyLayout, this);
		KeyControl keyControl92 = Initialize_ctrlKeyboardnumpad9(kKeyLayout, this);
		KeyControl keyControl93 = Initialize_ctrlKeyboardnumpad0(kKeyLayout, this);
		KeyControl keyControl94 = Initialize_ctrlKeyboardf1(kKeyLayout, this);
		KeyControl keyControl95 = Initialize_ctrlKeyboardf2(kKeyLayout, this);
		KeyControl keyControl96 = Initialize_ctrlKeyboardf3(kKeyLayout, this);
		KeyControl keyControl97 = Initialize_ctrlKeyboardf4(kKeyLayout, this);
		KeyControl keyControl98 = Initialize_ctrlKeyboardf5(kKeyLayout, this);
		KeyControl keyControl99 = Initialize_ctrlKeyboardf6(kKeyLayout, this);
		KeyControl keyControl100 = Initialize_ctrlKeyboardf7(kKeyLayout, this);
		KeyControl keyControl101 = Initialize_ctrlKeyboardf8(kKeyLayout, this);
		KeyControl keyControl102 = Initialize_ctrlKeyboardf9(kKeyLayout, this);
		KeyControl keyControl103 = Initialize_ctrlKeyboardf10(kKeyLayout, this);
		KeyControl keyControl104 = Initialize_ctrlKeyboardf11(kKeyLayout, this);
		KeyControl keyControl105 = Initialize_ctrlKeyboardf12(kKeyLayout, this);
		KeyControl keyControl106 = Initialize_ctrlKeyboardOEM1(kKeyLayout, this);
		KeyControl keyControl107 = Initialize_ctrlKeyboardOEM2(kKeyLayout, this);
		KeyControl keyControl108 = Initialize_ctrlKeyboardOEM3(kKeyLayout, this);
		KeyControl keyControl109 = Initialize_ctrlKeyboardOEM4(kKeyLayout, this);
		KeyControl keyControl110 = Initialize_ctrlKeyboardOEM5(kKeyLayout, this);
		ButtonControl buttonControl = Initialize_ctrlKeyboardIMESelected(kButtonLayout, this);
		deviceBuilder.WithControlUsage(0, new InternedString("Back"), keyControl);
		deviceBuilder.WithControlUsage(1, new InternedString("Cancel"), keyControl);
		deviceBuilder.WithControlUsage(2, new InternedString("Submit"), keyControl3);
		deviceBuilder.WithControlUsage(3, new InternedString("Modifier"), keyControl56);
		deviceBuilder.WithControlUsage(4, new InternedString("Modifier"), keyControl57);
		deviceBuilder.WithControlUsage(5, new InternedString("Modifier"), control);
		deviceBuilder.WithControlUsage(6, new InternedString("Modifier"), keyControl58);
		deviceBuilder.WithControlUsage(7, new InternedString("Modifier"), keyControl59);
		deviceBuilder.WithControlUsage(8, new InternedString("Modifier"), control2);
		deviceBuilder.WithControlUsage(9, new InternedString("Modifier"), keyControl60);
		deviceBuilder.WithControlUsage(10, new InternedString("Modifier"), keyControl61);
		deviceBuilder.WithControlUsage(11, new InternedString("Modifier"), control3);
		deviceBuilder.WithControlUsage(12, new InternedString("Modifier"), keyControl62);
		deviceBuilder.WithControlUsage(13, new InternedString("Modifier"), keyControl63);
		deviceBuilder.WithControlUsage(14, new InternedString("Modifier"), keyControl64);
		deviceBuilder.WithControlAlias(0, new InternedString("AltGr"));
		deviceBuilder.WithControlAlias(1, new InternedString("LeftWindows"));
		deviceBuilder.WithControlAlias(2, new InternedString("LeftApple"));
		deviceBuilder.WithControlAlias(3, new InternedString("LeftCommand"));
		deviceBuilder.WithControlAlias(4, new InternedString("RightWindows"));
		deviceBuilder.WithControlAlias(5, new InternedString("RightApple"));
		deviceBuilder.WithControlAlias(6, new InternedString("RightCommand"));
		base.keys = new KeyControl[110];
		base.keys[0] = keyControl2;
		base.keys[1] = keyControl3;
		base.keys[2] = keyControl4;
		base.keys[3] = keyControl5;
		base.keys[4] = keyControl6;
		base.keys[5] = keyControl7;
		base.keys[6] = keyControl8;
		base.keys[7] = keyControl9;
		base.keys[8] = keyControl10;
		base.keys[9] = keyControl11;
		base.keys[10] = keyControl12;
		base.keys[11] = keyControl13;
		base.keys[12] = keyControl14;
		base.keys[13] = keyControl15;
		base.keys[14] = keyControl20;
		base.keys[15] = keyControl21;
		base.keys[16] = keyControl22;
		base.keys[17] = keyControl23;
		base.keys[18] = keyControl24;
		base.keys[19] = keyControl25;
		base.keys[20] = keyControl26;
		base.keys[21] = keyControl27;
		base.keys[22] = keyControl28;
		base.keys[23] = keyControl29;
		base.keys[24] = keyControl30;
		base.keys[25] = keyControl31;
		base.keys[26] = keyControl32;
		base.keys[27] = keyControl33;
		base.keys[28] = keyControl34;
		base.keys[29] = keyControl35;
		base.keys[30] = keyControl36;
		base.keys[31] = keyControl37;
		base.keys[32] = keyControl38;
		base.keys[33] = keyControl39;
		base.keys[34] = keyControl40;
		base.keys[35] = keyControl41;
		base.keys[36] = keyControl42;
		base.keys[37] = keyControl43;
		base.keys[38] = keyControl44;
		base.keys[39] = keyControl45;
		base.keys[40] = keyControl46;
		base.keys[41] = keyControl47;
		base.keys[42] = keyControl48;
		base.keys[43] = keyControl49;
		base.keys[44] = keyControl50;
		base.keys[45] = keyControl51;
		base.keys[46] = keyControl52;
		base.keys[47] = keyControl53;
		base.keys[48] = keyControl54;
		base.keys[49] = keyControl55;
		base.keys[50] = keyControl56;
		base.keys[51] = keyControl57;
		base.keys[52] = keyControl58;
		base.keys[53] = keyControl59;
		base.keys[54] = keyControl60;
		base.keys[55] = keyControl61;
		base.keys[56] = keyControl62;
		base.keys[57] = keyControl63;
		base.keys[58] = keyControl64;
		base.keys[59] = keyControl;
		base.keys[60] = keyControl18;
		base.keys[61] = keyControl19;
		base.keys[62] = keyControl16;
		base.keys[63] = keyControl17;
		base.keys[64] = keyControl65;
		base.keys[65] = keyControl66;
		base.keys[66] = keyControl67;
		base.keys[67] = keyControl68;
		base.keys[68] = keyControl69;
		base.keys[69] = keyControl70;
		base.keys[70] = keyControl71;
		base.keys[71] = keyControl72;
		base.keys[72] = keyControl73;
		base.keys[73] = keyControl74;
		base.keys[74] = keyControl75;
		base.keys[75] = keyControl76;
		base.keys[76] = keyControl77;
		base.keys[77] = keyControl78;
		base.keys[78] = keyControl79;
		base.keys[79] = keyControl80;
		base.keys[80] = keyControl81;
		base.keys[81] = keyControl82;
		base.keys[82] = keyControl83;
		base.keys[83] = keyControl93;
		base.keys[84] = keyControl84;
		base.keys[85] = keyControl85;
		base.keys[86] = keyControl86;
		base.keys[87] = keyControl87;
		base.keys[88] = keyControl88;
		base.keys[89] = keyControl89;
		base.keys[90] = keyControl90;
		base.keys[91] = keyControl91;
		base.keys[92] = keyControl92;
		base.keys[93] = keyControl94;
		base.keys[94] = keyControl95;
		base.keys[95] = keyControl96;
		base.keys[96] = keyControl97;
		base.keys[97] = keyControl98;
		base.keys[98] = keyControl99;
		base.keys[99] = keyControl100;
		base.keys[100] = keyControl101;
		base.keys[101] = keyControl102;
		base.keys[102] = keyControl103;
		base.keys[103] = keyControl104;
		base.keys[104] = keyControl105;
		base.keys[105] = keyControl106;
		base.keys[106] = keyControl107;
		base.keys[107] = keyControl108;
		base.keys[108] = keyControl109;
		base.keys[109] = keyControl110;
		base.anyKey = anyKeyControl;
		base.shiftKey = control;
		base.ctrlKey = control3;
		base.altKey = control2;
		base.imeSelected = buttonControl;
		deviceBuilder.WithStateOffsetToControlIndexMap(new uint[115]
		{
			111616u, 525314u, 1049603u, 1573892u, 2098181u, 2622470u, 3146759u, 3671048u, 4195337u, 4719626u,
			5243915u, 5768204u, 6292493u, 6816782u, 7341071u, 7865364u, 8389653u, 8913942u, 9438231u, 9962520u,
			10486809u, 11011098u, 11535387u, 12059676u, 12583965u, 13108254u, 13632543u, 14156832u, 14681121u, 15205410u,
			15729699u, 16253988u, 16778277u, 17302566u, 17826855u, 18351144u, 18875433u, 19399722u, 19924011u, 20448300u,
			20972589u, 21496878u, 22021167u, 22545456u, 23069745u, 23594034u, 24118323u, 24642612u, 25166901u, 25691190u,
			26215479u, 26739768u, 26740794u, 27264057u, 27788347u, 27789373u, 28312636u, 28836926u, 28837952u, 29361215u,
			29885505u, 30409794u, 30934083u, 31458305u, 31982610u, 32506899u, 33031184u, 33555473u, 34079812u, 34604101u,
			35128390u, 35652679u, 36176968u, 36701257u, 37225546u, 37749835u, 38274124u, 38798413u, 39322702u, 39846991u,
			40371280u, 40895569u, 41419858u, 41944147u, 42468436u, 42992725u, 43517014u, 44041312u, 44565591u, 45089880u,
			45614169u, 46138458u, 46662747u, 47187036u, 47711325u, 48235614u, 48759903u, 49284193u, 49808482u, 50332771u,
			50857060u, 51381349u, 51905638u, 52429927u, 52954216u, 53478505u, 54002794u, 54527083u, 55051372u, 55575661u,
			56099950u, 56624239u, 57148528u, 57672817u, 58197106u
		});
		deviceBuilder.WithControlTree(new byte[1575]
		{
			111, 0, 1, 0, 0, 0, 0, 56, 0, 15,
			0, 0, 0, 2, 111, 0, 3, 0, 2, 0,
			2, 84, 0, 5, 0, 0, 0, 0, 111, 0,
			169, 0, 0, 0, 0, 70, 0, 7, 0, 0,
			0, 0, 84, 0, 143, 0, 0, 0, 0, 63,
			0, 9, 0, 0, 0, 0, 70, 0, 53, 0,
			0, 0, 0, 60, 0, 131, 0, 0, 0, 0,
			63, 0, 11, 0, 0, 0, 0, 62, 0, 13,
			0, 0, 0, 0, 63, 0, 255, 255, 22, 0,
			1, 61, 0, 255, 255, 4, 0, 1, 62, 0,
			255, 255, 21, 0, 1, 28, 0, 17, 0, 0,
			0, 0, 56, 0, 77, 0, 0, 0, 0, 14,
			0, 19, 0, 0, 0, 0, 28, 0, 45, 0,
			0, 0, 0, 7, 0, 21, 0, 0, 0, 0,
			14, 0, 33, 0, 0, 0, 0, 4, 0, 23,
			0, 0, 0, 0, 7, 0, 29, 0, 0, 0,
			0, 2, 0, 25, 0, 0, 0, 0, 4, 0,
			27, 0, 0, 0, 0, 1, 0, 255, 255, 0,
			0, 0, 2, 0, 255, 255, 5, 0, 1, 3,
			0, 255, 255, 6, 0, 1, 4, 0, 255, 255,
			7, 0, 1, 6, 0, 31, 0, 0, 0, 0,
			7, 0, 255, 255, 10, 0, 1, 5, 0, 255,
			255, 8, 0, 1, 6, 0, 255, 255, 9, 0,
			1, 11, 0, 35, 0, 0, 0, 0, 14, 0,
			41, 0, 0, 0, 0, 9, 0, 37, 0, 0,
			0, 0, 11, 0, 39, 0, 0, 0, 0, 8,
			0, 255, 255, 11, 0, 1, 9, 0, 255, 255,
			12, 0, 1, 10, 0, 255, 255, 13, 0, 1,
			11, 0, 255, 255, 14, 0, 1, 13, 0, 43,
			0, 0, 0, 0, 14, 0, 255, 255, 17, 0,
			1, 12, 0, 255, 255, 15, 0, 1, 13, 0,
			255, 255, 16, 0, 1, 21, 0, 47, 0, 0,
			0, 0, 28, 0, 65, 0, 0, 0, 0, 18,
			0, 49, 0, 0, 0, 0, 21, 0, 61, 0,
			0, 0, 0, 16, 0, 51, 0, 0, 0, 0,
			18, 0, 59, 0, 0, 0, 0, 15, 0, 255,
			255, 18, 0, 1, 16, 0, 255, 255, 23, 0,
			1, 67, 0, 55, 0, 0, 0, 0, 70, 0,
			139, 0, 0, 0, 0, 65, 0, 57, 0, 0,
			0, 0, 67, 0, 137, 0, 0, 0, 0, 64,
			0, 255, 255, 19, 0, 1, 65, 0, 255, 255,
			20, 0, 1, 17, 0, 255, 255, 24, 0, 1,
			18, 0, 255, 255, 25, 0, 1, 20, 0, 63,
			0, 0, 0, 0, 21, 0, 255, 255, 28, 0,
			1, 19, 0, 255, 255, 26, 0, 1, 20, 0,
			255, 255, 27, 0, 1, 25, 0, 67, 0, 0,
			0, 0, 28, 0, 73, 0, 0, 0, 0, 23,
			0, 69, 0, 0, 0, 0, 25, 0, 71, 0,
			0, 0, 0, 22, 0, 255, 255, 29, 0, 1,
			23, 0, 255, 255, 30, 0, 1, 24, 0, 255,
			255, 31, 0, 1, 25, 0, 255, 255, 32, 0,
			1, 27, 0, 75, 0, 0, 0, 0, 28, 0,
			255, 255, 35, 0, 1, 26, 0, 255, 255, 33,
			0, 1, 27, 0, 255, 255, 34, 0, 1, 42,
			0, 79, 0, 0, 0, 0, 56, 0, 105, 0,
			0, 0, 0, 35, 0, 81, 0, 0, 0, 0,
			42, 0, 93, 0, 0, 0, 0, 32, 0, 83,
			0, 0, 0, 0, 35, 0, 89, 0, 0, 0,
			0, 30, 0, 85, 0, 0, 0, 0, 32, 0,
			87, 0, 0, 0, 0, 29, 0, 255, 255, 36,
			0, 1, 30, 0, 255, 255, 37, 0, 1, 31,
			0, 255, 255, 38, 0, 1, 32, 0, 255, 255,
			39, 0, 1, 34, 0, 91, 0, 0, 0, 0,
			35, 0, 255, 255, 42, 0, 1, 33, 0, 255,
			255, 40, 0, 1, 34, 0, 255, 255, 41, 0,
			1, 39, 0, 95, 0, 0, 0, 0, 42, 0,
			101, 0, 0, 0, 0, 37, 0, 97, 0, 0,
			0, 0, 39, 0, 99, 0, 0, 0, 0, 36,
			0, 255, 255, 43, 0, 1, 37, 0, 255, 255,
			44, 0, 1, 38, 0, 255, 255, 45, 0, 1,
			39, 0, 255, 255, 46, 0, 1, 41, 0, 103,
			0, 0, 0, 0, 42, 0, 255, 255, 49, 0,
			1, 40, 0, 255, 255, 47, 0, 1, 41, 0,
			255, 255, 48, 0, 1, 49, 0, 107, 0, 0,
			0, 0, 56, 0, 119, 0, 0, 0, 0, 46,
			0, 109, 0, 0, 0, 0, 49, 0, 115, 0,
			0, 0, 0, 44, 0, 111, 0, 0, 0, 0,
			46, 0, 113, 0, 0, 0, 0, 43, 0, 255,
			255, 50, 0, 1, 44, 0, 255, 255, 51, 0,
			1, 45, 0, 255, 255, 52, 0, 1, 46, 0,
			255, 255, 53, 0, 1, 48, 0, 117, 0, 0,
			0, 0, 49, 0, 255, 255, 56, 0, 1, 47,
			0, 255, 255, 54, 0, 1, 48, 0, 255, 255,
			55, 0, 1, 53, 0, 121, 0, 0, 0, 0,
			56, 0, 127, 0, 0, 0, 0, 51, 0, 123,
			0, 0, 0, 0, 53, 0, 125, 0, 61, 0,
			1, 50, 0, 255, 255, 57, 0, 1, 51, 0,
			255, 255, 58, 0, 1, 52, 0, 255, 255, 59,
			0, 1, 53, 0, 255, 255, 60, 0, 1, 55,
			0, 129, 0, 64, 0, 1, 56, 0, 255, 255,
			65, 0, 1, 54, 0, 255, 255, 62, 0, 1,
			55, 0, 255, 255, 63, 0, 1, 58, 0, 133,
			0, 0, 0, 0, 60, 0, 135, 0, 0, 0,
			0, 57, 0, 255, 255, 66, 0, 1, 58, 0,
			255, 255, 67, 0, 1, 59, 0, 255, 255, 68,
			0, 1, 60, 0, 255, 255, 69, 0, 1, 66,
			0, 255, 255, 70, 0, 1, 67, 0, 255, 255,
			71, 0, 1, 69, 0, 141, 0, 0, 0, 0,
			70, 0, 255, 255, 74, 0, 1, 68, 0, 255,
			255, 72, 0, 1, 69, 0, 255, 255, 73, 0,
			1, 77, 0, 145, 0, 0, 0, 0, 84, 0,
			157, 0, 0, 0, 0, 74, 0, 147, 0, 0,
			0, 0, 77, 0, 153, 0, 0, 0, 0, 72,
			0, 149, 0, 0, 0, 0, 74, 0, 151, 0,
			0, 0, 0, 71, 0, 255, 255, 75, 0, 1,
			72, 0, 255, 255, 76, 0, 1, 73, 0, 255,
			255, 77, 0, 1, 74, 0, 255, 255, 78, 0,
			1, 76, 0, 155, 0, 0, 0, 0, 77, 0,
			255, 255, 81, 0, 1, 75, 0, 255, 255, 79,
			0, 1, 76, 0, 255, 255, 80, 0, 1, 81,
			0, 159, 0, 0, 0, 0, 84, 0, 165, 0,
			0, 0, 0, 79, 0, 161, 0, 0, 0, 0,
			81, 0, 163, 0, 0, 0, 0, 78, 0, 255,
			255, 82, 0, 1, 79, 0, 255, 255, 83, 0,
			1, 80, 0, 255, 255, 84, 0, 1, 81, 0,
			255, 255, 85, 0, 1, 83, 0, 167, 0, 0,
			0, 0, 84, 0, 255, 255, 88, 0, 1, 82,
			0, 255, 255, 86, 0, 1, 83, 0, 255, 255,
			87, 0, 1, 98, 0, 171, 0, 0, 0, 0,
			111, 0, 197, 0, 0, 0, 0, 91, 0, 173,
			0, 0, 0, 0, 98, 0, 185, 0, 0, 0,
			0, 88, 0, 175, 0, 0, 0, 0, 91, 0,
			181, 0, 0, 0, 0, 86, 0, 177, 0, 0,
			0, 0, 88, 0, 179, 0, 0, 0, 0, 85,
			0, 255, 255, 98, 0, 1, 86, 0, 255, 255,
			89, 0, 1, 87, 0, 255, 255, 90, 0, 1,
			88, 0, 255, 255, 91, 0, 1, 90, 0, 183,
			0, 0, 0, 0, 91, 0, 255, 255, 94, 0,
			1, 89, 0, 255, 255, 92, 0, 1, 90, 0,
			255, 255, 93, 0, 1, 95, 0, 187, 0, 0,
			0, 0, 98, 0, 193, 0, 0, 0, 0, 93,
			0, 189, 0, 0, 0, 0, 95, 0, 191, 0,
			0, 0, 0, 92, 0, 255, 255, 95, 0, 1,
			93, 0, 255, 255, 96, 0, 1, 94, 0, 255,
			255, 97, 0, 1, 95, 0, 255, 255, 99, 0,
			1, 97, 0, 195, 0, 0, 0, 0, 98, 0,
			255, 255, 102, 0, 1, 96, 0, 255, 255, 100,
			0, 1, 97, 0, 255, 255, 101, 0, 1, 105,
			0, 199, 0, 0, 0, 0, 111, 0, 211, 0,
			0, 0, 0, 102, 0, 201, 0, 0, 0, 0,
			105, 0, 207, 0, 0, 0, 0, 100, 0, 203,
			0, 0, 0, 0, 102, 0, 205, 0, 0, 0,
			0, 99, 0, 255, 255, 103, 0, 1, 100, 0,
			255, 255, 104, 0, 1, 101, 0, 255, 255, 105,
			0, 1, 102, 0, 255, 255, 106, 0, 1, 104,
			0, 209, 0, 0, 0, 0, 105, 0, 255, 255,
			109, 0, 1, 103, 0, 255, 255, 107, 0, 1,
			104, 0, 255, 255, 108, 0, 1, 108, 0, 213,
			0, 0, 0, 0, 111, 0, 217, 0, 0, 0,
			0, 107, 0, 215, 0, 0, 0, 0, 108, 0,
			255, 255, 112, 0, 1, 106, 0, 255, 255, 110,
			0, 1, 107, 0, 255, 255, 111, 0, 1, 110,
			0, 219, 0, 0, 0, 0, 111, 0, 221, 0,
			115, 0, 1, 109, 0, 255, 255, 113, 0, 1,
			110, 0, 255, 255, 114, 0, 1, 111, 0, 255,
			255, 0, 0, 0, 111, 0, 223, 0, 0, 0,
			0, 112, 0, 255, 255, 116, 0, 1, 111, 0,
			255, 255, 0, 0, 0
		}, new ushort[117]
		{
			0, 64, 0, 64, 1, 2, 3, 4, 5, 6,
			7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
			17, 18, 19, 20, 21, 22, 23, 24, 25, 26,
			27, 28, 29, 30, 31, 32, 33, 34, 35, 36,
			37, 38, 39, 40, 41, 42, 43, 44, 45, 46,
			47, 48, 49, 50, 51, 52, 53, 54, 55, 56,
			57, 58, 59, 60, 61, 62, 63, 65, 66, 67,
			68, 69, 70, 71, 72, 73, 74, 75, 76, 77,
			78, 79, 80, 81, 82, 83, 84, 85, 86, 87,
			88, 89, 90, 91, 92, 93, 94, 95, 96, 97,
			98, 99, 100, 101, 102, 103, 104, 105, 106, 107,
			108, 109, 110, 111, 112, 113, 114
		});
		deviceBuilder.Finish();
	}

	private AnyKeyControl Initialize_ctrlKeyboardanyKey(InternedString kAnyKeyLayout, InputControl parent)
	{
		AnyKeyControl anyKeyControl = new AnyKeyControl();
		anyKeyControl.Setup().At(this, 0).WithParent(parent)
			.WithName("anyKey")
			.WithDisplayName("Any Key")
			.WithLayout(kAnyKeyLayout)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 0u,
				sizeInBits = 109u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return anyKeyControl;
	}

	private KeyControl Initialize_ctrlKeyboardescape(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 1).WithParent(parent)
			.WithName("escape")
			.WithDisplayName("Escape")
			.WithLayout(kKeyLayout)
			.WithUsages(0, 2)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 60u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Escape;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardspace(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 2).WithParent(parent)
			.WithName("space")
			.WithDisplayName("Space")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 1u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Space;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardenter(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 3).WithParent(parent)
			.WithName("enter")
			.WithDisplayName("Enter")
			.WithLayout(kKeyLayout)
			.WithUsages(2, 1)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 2u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Enter;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardtab(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 4).WithParent(parent)
			.WithName("tab")
			.WithDisplayName("Tab")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 3u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Tab;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardbackquote(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 5).WithParent(parent)
			.WithName("backquote")
			.WithDisplayName("`")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 4u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Backquote;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardquote(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 6).WithParent(parent)
			.WithName("quote")
			.WithDisplayName("'")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 5u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Quote;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardsemicolon(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 7).WithParent(parent)
			.WithName("semicolon")
			.WithDisplayName(";")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 6u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Semicolon;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardcomma(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 8).WithParent(parent)
			.WithName("comma")
			.WithDisplayName(",")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 7u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Comma;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardperiod(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 9).WithParent(parent)
			.WithName("period")
			.WithDisplayName(".")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 8u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Period;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardslash(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 10).WithParent(parent)
			.WithName("slash")
			.WithDisplayName("/")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 9u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Slash;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardbackslash(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 11).WithParent(parent)
			.WithName("backslash")
			.WithDisplayName("\\")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 10u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Backslash;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardleftBracket(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 12).WithParent(parent)
			.WithName("leftBracket")
			.WithDisplayName("[")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 11u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.LeftBracket;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardrightBracket(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 13).WithParent(parent)
			.WithName("rightBracket")
			.WithDisplayName("]")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 12u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.RightBracket;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardminus(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 14).WithParent(parent)
			.WithName("minus")
			.WithDisplayName("-")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 13u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Minus;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardequals(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 15).WithParent(parent)
			.WithName("equals")
			.WithDisplayName("=")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 14u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Equals;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardupArrow(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 16).WithParent(parent)
			.WithName("upArrow")
			.WithDisplayName("Up Arrow")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 63u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.UpArrow;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboarddownArrow(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 17).WithParent(parent)
			.WithName("downArrow")
			.WithDisplayName("Down Arrow")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 64u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.DownArrow;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardleftArrow(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 18).WithParent(parent)
			.WithName("leftArrow")
			.WithDisplayName("Left Arrow")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 61u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.LeftArrow;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardrightArrow(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 19).WithParent(parent)
			.WithName("rightArrow")
			.WithDisplayName("Right Arrow")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 62u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.RightArrow;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboarda(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 20).WithParent(parent)
			.WithName("a")
			.WithDisplayName("A")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 15u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.A;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardb(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 21).WithParent(parent)
			.WithName("b")
			.WithDisplayName("B")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 16u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.B;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardc(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 22).WithParent(parent)
			.WithName("c")
			.WithDisplayName("C")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 17u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.C;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardd(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 23).WithParent(parent)
			.WithName("d")
			.WithDisplayName("D")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 18u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.D;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboarde(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 24).WithParent(parent)
			.WithName("e")
			.WithDisplayName("E")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 19u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.E;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardf(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 25).WithParent(parent)
			.WithName("f")
			.WithDisplayName("F")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 20u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.F;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardg(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 26).WithParent(parent)
			.WithName("g")
			.WithDisplayName("G")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 21u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.G;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardh(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 27).WithParent(parent)
			.WithName("h")
			.WithDisplayName("H")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 22u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.H;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardi(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 28).WithParent(parent)
			.WithName("i")
			.WithDisplayName("I")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 23u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.I;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardj(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 29).WithParent(parent)
			.WithName("j")
			.WithDisplayName("J")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 24u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.J;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardk(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 30).WithParent(parent)
			.WithName("k")
			.WithDisplayName("K")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 25u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.K;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardl(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 31).WithParent(parent)
			.WithName("l")
			.WithDisplayName("L")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 26u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.L;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardm(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 32).WithParent(parent)
			.WithName("m")
			.WithDisplayName("M")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 27u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.M;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardn(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 33).WithParent(parent)
			.WithName("n")
			.WithDisplayName("N")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 28u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.N;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardo(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 34).WithParent(parent)
			.WithName("o")
			.WithDisplayName("O")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 29u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.O;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardp(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 35).WithParent(parent)
			.WithName("p")
			.WithDisplayName("P")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 30u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.P;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardq(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 36).WithParent(parent)
			.WithName("q")
			.WithDisplayName("Q")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 31u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Q;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardr(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 37).WithParent(parent)
			.WithName("r")
			.WithDisplayName("R")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 32u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.R;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboards(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 38).WithParent(parent)
			.WithName("s")
			.WithDisplayName("S")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 33u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.S;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardt(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 39).WithParent(parent)
			.WithName("t")
			.WithDisplayName("T")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 34u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.T;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardu(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 40).WithParent(parent)
			.WithName("u")
			.WithDisplayName("U")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 35u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.U;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardv(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 41).WithParent(parent)
			.WithName("v")
			.WithDisplayName("V")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 36u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.V;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardw(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 42).WithParent(parent)
			.WithName("w")
			.WithDisplayName("W")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 37u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.W;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardx(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 43).WithParent(parent)
			.WithName("x")
			.WithDisplayName("X")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 38u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.X;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardy(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 44).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Y")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 39u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Y;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardz(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 45).WithParent(parent)
			.WithName("z")
			.WithDisplayName("Z")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 40u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Z;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboard1(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 46).WithParent(parent)
			.WithName("1")
			.WithDisplayName("1")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 41u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Digit1;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboard2(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 47).WithParent(parent)
			.WithName("2")
			.WithDisplayName("2")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 42u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Digit2;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboard3(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 48).WithParent(parent)
			.WithName("3")
			.WithDisplayName("3")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 43u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Digit3;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboard4(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 49).WithParent(parent)
			.WithName("4")
			.WithDisplayName("4")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 44u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Digit4;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboard5(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 50).WithParent(parent)
			.WithName("5")
			.WithDisplayName("5")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 45u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Digit5;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboard6(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 51).WithParent(parent)
			.WithName("6")
			.WithDisplayName("6")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 46u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Digit6;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboard7(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 52).WithParent(parent)
			.WithName("7")
			.WithDisplayName("7")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 47u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Digit7;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboard8(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 53).WithParent(parent)
			.WithName("8")
			.WithDisplayName("8")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 48u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Digit8;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboard9(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 54).WithParent(parent)
			.WithName("9")
			.WithDisplayName("9")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 49u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Digit9;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboard0(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 55).WithParent(parent)
			.WithName("0")
			.WithDisplayName("0")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 50u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Digit0;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardleftShift(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 56).WithParent(parent)
			.WithName("leftShift")
			.WithDisplayName("Left Shift")
			.WithLayout(kKeyLayout)
			.WithUsages(3, 1)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 51u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.LeftShift;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardrightShift(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 57).WithParent(parent)
			.WithName("rightShift")
			.WithDisplayName("Right Shift")
			.WithLayout(kKeyLayout)
			.WithUsages(4, 1)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 52u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.RightShift;
		return keyControl;
	}

	private DiscreteButtonControl Initialize_ctrlKeyboardshift(InternedString kDiscreteButtonLayout, InputControl parent)
	{
		DiscreteButtonControl obj = new DiscreteButtonControl
		{
			minValue = 1,
			maxValue = 3,
			writeMode = DiscreteButtonControl.WriteMode.WriteNullAndMaxValue
		};
		obj.Setup().At(this, 58).WithParent(parent)
			.WithName("shift")
			.WithDisplayName("Shift")
			.WithLayout(kDiscreteButtonLayout)
			.WithUsages(5, 1)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 51u,
				sizeInBits = 2u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return obj;
	}

	private KeyControl Initialize_ctrlKeyboardleftAlt(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 59).WithParent(parent)
			.WithName("leftAlt")
			.WithDisplayName("Left Alt")
			.WithLayout(kKeyLayout)
			.WithUsages(6, 1)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 53u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.LeftAlt;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardrightAlt(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 60).WithParent(parent)
			.WithName("rightAlt")
			.WithDisplayName("Right Alt")
			.WithLayout(kKeyLayout)
			.WithUsages(7, 1)
			.WithAliases(0, 1)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 54u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.RightAlt;
		return keyControl;
	}

	private DiscreteButtonControl Initialize_ctrlKeyboardalt(InternedString kDiscreteButtonLayout, InputControl parent)
	{
		DiscreteButtonControl obj = new DiscreteButtonControl
		{
			minValue = 1,
			maxValue = 3,
			writeMode = DiscreteButtonControl.WriteMode.WriteNullAndMaxValue
		};
		obj.Setup().At(this, 61).WithParent(parent)
			.WithName("alt")
			.WithDisplayName("Alt")
			.WithLayout(kDiscreteButtonLayout)
			.WithUsages(8, 1)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 53u,
				sizeInBits = 2u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return obj;
	}

	private KeyControl Initialize_ctrlKeyboardleftCtrl(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 62).WithParent(parent)
			.WithName("leftCtrl")
			.WithDisplayName("Left Control")
			.WithLayout(kKeyLayout)
			.WithUsages(9, 1)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 55u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.LeftCtrl;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardrightCtrl(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 63).WithParent(parent)
			.WithName("rightCtrl")
			.WithDisplayName("Right Control")
			.WithLayout(kKeyLayout)
			.WithUsages(10, 1)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 56u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.RightCtrl;
		return keyControl;
	}

	private DiscreteButtonControl Initialize_ctrlKeyboardctrl(InternedString kDiscreteButtonLayout, InputControl parent)
	{
		DiscreteButtonControl obj = new DiscreteButtonControl
		{
			minValue = 1,
			maxValue = 3,
			writeMode = DiscreteButtonControl.WriteMode.WriteNullAndMaxValue
		};
		obj.Setup().At(this, 64).WithParent(parent)
			.WithName("ctrl")
			.WithDisplayName("Control")
			.WithLayout(kDiscreteButtonLayout)
			.WithUsages(11, 1)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 55u,
				sizeInBits = 2u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return obj;
	}

	private KeyControl Initialize_ctrlKeyboardleftMeta(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 65).WithParent(parent)
			.WithName("leftMeta")
			.WithDisplayName("Left System")
			.WithLayout(kKeyLayout)
			.WithUsages(12, 1)
			.WithAliases(1, 3)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 57u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.LeftMeta;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardrightMeta(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 66).WithParent(parent)
			.WithName("rightMeta")
			.WithDisplayName("Right System")
			.WithLayout(kKeyLayout)
			.WithUsages(13, 1)
			.WithAliases(4, 3)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 58u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.RightMeta;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardcontextMenu(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 67).WithParent(parent)
			.WithName("contextMenu")
			.WithDisplayName("Context Menu")
			.WithLayout(kKeyLayout)
			.WithUsages(14, 1)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 59u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.ContextMenu;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardbackspace(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 68).WithParent(parent)
			.WithName("backspace")
			.WithDisplayName("Backspace")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 65u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Backspace;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardpageDown(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 69).WithParent(parent)
			.WithName("pageDown")
			.WithDisplayName("Page Down")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 66u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.PageDown;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardpageUp(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 70).WithParent(parent)
			.WithName("pageUp")
			.WithDisplayName("Page Up")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 67u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.PageUp;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardhome(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 71).WithParent(parent)
			.WithName("home")
			.WithDisplayName("Home")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 68u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Home;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardend(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 72).WithParent(parent)
			.WithName("end")
			.WithDisplayName("End")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 69u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.End;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardinsert(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 73).WithParent(parent)
			.WithName("insert")
			.WithDisplayName("Insert")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 70u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Insert;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboarddelete(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 74).WithParent(parent)
			.WithName("delete")
			.WithDisplayName("Delete")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 71u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Delete;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardcapsLock(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 75).WithParent(parent)
			.WithName("capsLock")
			.WithDisplayName("Caps Lock")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 72u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.CapsLock;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumLock(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 76).WithParent(parent)
			.WithName("numLock")
			.WithDisplayName("Num Lock")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 73u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.NumLock;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardprintScreen(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 77).WithParent(parent)
			.WithName("printScreen")
			.WithDisplayName("Print Screen")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 74u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.PrintScreen;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardscrollLock(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 78).WithParent(parent)
			.WithName("scrollLock")
			.WithDisplayName("Scroll Lock")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 75u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.ScrollLock;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardpause(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 79).WithParent(parent)
			.WithName("pause")
			.WithDisplayName("Pause/Break")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 76u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Pause;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpadEnter(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 80).WithParent(parent)
			.WithName("numpadEnter")
			.WithDisplayName("Numpad Enter")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 77u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.NumpadEnter;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpadDivide(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 81).WithParent(parent)
			.WithName("numpadDivide")
			.WithDisplayName("Numpad /")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 78u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.NumpadDivide;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpadMultiply(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 82).WithParent(parent)
			.WithName("numpadMultiply")
			.WithDisplayName("Numpad *")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 79u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.NumpadMultiply;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpadPlus(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 83).WithParent(parent)
			.WithName("numpadPlus")
			.WithDisplayName("Numpad +")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 80u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.NumpadPlus;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpadMinus(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 84).WithParent(parent)
			.WithName("numpadMinus")
			.WithDisplayName("Numpad -")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 81u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.NumpadMinus;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpadPeriod(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 85).WithParent(parent)
			.WithName("numpadPeriod")
			.WithDisplayName("Numpad .")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 82u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.NumpadPeriod;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpadEquals(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 86).WithParent(parent)
			.WithName("numpadEquals")
			.WithDisplayName("Numpad =")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 83u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.NumpadEquals;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpad1(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 87).WithParent(parent)
			.WithName("numpad1")
			.WithDisplayName("Numpad 1")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 85u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Numpad1;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpad2(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 88).WithParent(parent)
			.WithName("numpad2")
			.WithDisplayName("Numpad 2")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 86u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Numpad2;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpad3(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 89).WithParent(parent)
			.WithName("numpad3")
			.WithDisplayName("Numpad 3")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 87u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Numpad3;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpad4(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 90).WithParent(parent)
			.WithName("numpad4")
			.WithDisplayName("Numpad 4")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 88u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Numpad4;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpad5(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 91).WithParent(parent)
			.WithName("numpad5")
			.WithDisplayName("Numpad 5")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 89u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Numpad5;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpad6(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 92).WithParent(parent)
			.WithName("numpad6")
			.WithDisplayName("Numpad 6")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 90u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Numpad6;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpad7(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 93).WithParent(parent)
			.WithName("numpad7")
			.WithDisplayName("Numpad 7")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 91u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Numpad7;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpad8(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 94).WithParent(parent)
			.WithName("numpad8")
			.WithDisplayName("Numpad 8")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 92u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Numpad8;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpad9(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 95).WithParent(parent)
			.WithName("numpad9")
			.WithDisplayName("Numpad 9")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 93u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Numpad9;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardnumpad0(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 96).WithParent(parent)
			.WithName("numpad0")
			.WithDisplayName("Numpad 0")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 84u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.Numpad0;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardf1(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 97).WithParent(parent)
			.WithName("f1")
			.WithDisplayName("F1")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 94u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.F1;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardf2(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 98).WithParent(parent)
			.WithName("f2")
			.WithDisplayName("F2")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 95u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.F2;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardf3(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 99).WithParent(parent)
			.WithName("f3")
			.WithDisplayName("F3")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 96u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.F3;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardf4(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 100).WithParent(parent)
			.WithName("f4")
			.WithDisplayName("F4")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 97u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.F4;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardf5(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 101).WithParent(parent)
			.WithName("f5")
			.WithDisplayName("F5")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 98u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.F5;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardf6(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 102).WithParent(parent)
			.WithName("f6")
			.WithDisplayName("F6")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 99u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.F6;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardf7(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 103).WithParent(parent)
			.WithName("f7")
			.WithDisplayName("F7")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 100u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.F7;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardf8(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 104).WithParent(parent)
			.WithName("f8")
			.WithDisplayName("F8")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 101u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.F8;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardf9(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 105).WithParent(parent)
			.WithName("f9")
			.WithDisplayName("F9")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 102u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.F9;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardf10(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 106).WithParent(parent)
			.WithName("f10")
			.WithDisplayName("F10")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 103u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.F10;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardf11(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 107).WithParent(parent)
			.WithName("f11")
			.WithDisplayName("F11")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 104u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.F11;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardf12(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 108).WithParent(parent)
			.WithName("f12")
			.WithDisplayName("F12")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 105u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.F12;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardOEM1(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 109).WithParent(parent)
			.WithName("OEM1")
			.WithDisplayName("OEM1")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 106u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.OEM1;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardOEM2(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 110).WithParent(parent)
			.WithName("OEM2")
			.WithDisplayName("OEM2")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 107u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.OEM2;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardOEM3(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 111).WithParent(parent)
			.WithName("OEM3")
			.WithDisplayName("OEM3")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 108u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.OEM3;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardOEM4(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 112).WithParent(parent)
			.WithName("OEM4")
			.WithDisplayName("OEM4")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 109u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.OEM4;
		return keyControl;
	}

	private KeyControl Initialize_ctrlKeyboardOEM5(InternedString kKeyLayout, InputControl parent)
	{
		KeyControl keyControl = new KeyControl();
		keyControl.Setup().At(this, 113).WithParent(parent)
			.WithName("OEM5")
			.WithDisplayName("OEM5")
			.WithLayout(kKeyLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 110u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		keyControl.keyCode = Key.OEM5;
		return keyControl;
	}

	private ButtonControl Initialize_ctrlKeyboardIMESelected(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 114).WithParent(parent)
			.WithName("IMESelected")
			.WithDisplayName("IMESelected")
			.WithLayout(kButtonLayout)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 0u,
				bitOffset = 111u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}
}
