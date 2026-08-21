using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

internal class FastTouchscreen : Touchscreen
{
	public const string metadata = "AutoWindowSpace;Touch;Vector2;Delta;Analog;TouchPress;Button;Axis;Integer;TouchPhase;Double;Touchscreen;Pointer";

	public FastTouchscreen()
	{
		InputControlExtensions.DeviceBuilder deviceBuilder = this.Setup(302, 5, 0).WithName("Touchscreen").WithDisplayName("Touchscreen")
			.WithChildren(0, 17)
			.WithLayout(new InternedString("Touchscreen"))
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1414742866),
				sizeInBits = 4928u
			});
		InternedString kTouchLayout = new InternedString("Touch");
		InternedString kVector2Layout = new InternedString("Vector2");
		InternedString kDeltaLayout = new InternedString("Delta");
		InternedString kAnalogLayout = new InternedString("Analog");
		InternedString kTouchPressLayout = new InternedString("TouchPress");
		InternedString kIntegerLayout = new InternedString("Integer");
		InternedString kAxisLayout = new InternedString("Axis");
		InternedString kTouchPhaseLayout = new InternedString("TouchPhase");
		InternedString kButtonLayout = new InternedString("Button");
		InternedString kDoubleLayout = new InternedString("Double");
		TouchControl touchControl = Initialize_ctrlTouchscreenprimaryTouch(kTouchLayout, this);
		Vector2Control vector2Control = Initialize_ctrlTouchscreenposition(kVector2Layout, this);
		DeltaControl deltaControl = Initialize_ctrlTouchscreendelta(kDeltaLayout, this);
		AxisControl control = Initialize_ctrlTouchscreenpressure(kAnalogLayout, this);
		Vector2Control vector2Control2 = Initialize_ctrlTouchscreenradius(kVector2Layout, this);
		TouchPressControl touchPressControl = Initialize_ctrlTouchscreenpress(kTouchPressLayout, this);
		TouchControl touchControl2 = Initialize_ctrlTouchscreentouch0(kTouchLayout, this);
		TouchControl touchControl3 = Initialize_ctrlTouchscreentouch1(kTouchLayout, this);
		TouchControl touchControl4 = Initialize_ctrlTouchscreentouch2(kTouchLayout, this);
		TouchControl touchControl5 = Initialize_ctrlTouchscreentouch3(kTouchLayout, this);
		TouchControl touchControl6 = Initialize_ctrlTouchscreentouch4(kTouchLayout, this);
		TouchControl touchControl7 = Initialize_ctrlTouchscreentouch5(kTouchLayout, this);
		TouchControl touchControl8 = Initialize_ctrlTouchscreentouch6(kTouchLayout, this);
		TouchControl touchControl9 = Initialize_ctrlTouchscreentouch7(kTouchLayout, this);
		TouchControl touchControl10 = Initialize_ctrlTouchscreentouch8(kTouchLayout, this);
		TouchControl touchControl11 = Initialize_ctrlTouchscreentouch9(kTouchLayout, this);
		Initialize_ctrlTouchscreendisplayIndex(kIntegerLayout, this);
		IntegerControl touchId = Initialize_ctrlTouchscreenprimaryTouchtouchId(kIntegerLayout, touchControl);
		Vector2Control vector2Control3 = Initialize_ctrlTouchscreenprimaryTouchposition(kVector2Layout, touchControl);
		DeltaControl deltaControl2 = Initialize_ctrlTouchscreenprimaryTouchdelta(kDeltaLayout, touchControl);
		AxisControl axisControl = Initialize_ctrlTouchscreenprimaryTouchpressure(kAxisLayout, touchControl);
		Vector2Control vector2Control4 = Initialize_ctrlTouchscreenprimaryTouchradius(kVector2Layout, touchControl);
		TouchPhaseControl phase = Initialize_ctrlTouchscreenprimaryTouchphase(kTouchPhaseLayout, touchControl);
		TouchPressControl touchPressControl2 = Initialize_ctrlTouchscreenprimaryTouchpress(kTouchPressLayout, touchControl);
		IntegerControl tapCount = Initialize_ctrlTouchscreenprimaryTouchtapCount(kIntegerLayout, touchControl);
		IntegerControl integerControl = Initialize_ctrlTouchscreenprimaryTouchdisplayIndex(kIntegerLayout, touchControl);
		ButtonControl indirectTouch = Initialize_ctrlTouchscreenprimaryTouchindirectTouch(kButtonLayout, touchControl);
		ButtonControl buttonControl = Initialize_ctrlTouchscreenprimaryTouchtap(kButtonLayout, touchControl);
		DoubleControl startTime = Initialize_ctrlTouchscreenprimaryTouchstartTime(kDoubleLayout, touchControl);
		Vector2Control vector2Control5 = Initialize_ctrlTouchscreenprimaryTouchstartPosition(kVector2Layout, touchControl);
		AxisControl x = Initialize_ctrlTouchscreenprimaryTouchpositionx(kAxisLayout, vector2Control3);
		AxisControl y = Initialize_ctrlTouchscreenprimaryTouchpositiony(kAxisLayout, vector2Control3);
		AxisControl up = Initialize_ctrlTouchscreenprimaryTouchdeltaup(kAxisLayout, deltaControl2);
		AxisControl down = Initialize_ctrlTouchscreenprimaryTouchdeltadown(kAxisLayout, deltaControl2);
		AxisControl left = Initialize_ctrlTouchscreenprimaryTouchdeltaleft(kAxisLayout, deltaControl2);
		AxisControl right = Initialize_ctrlTouchscreenprimaryTouchdeltaright(kAxisLayout, deltaControl2);
		AxisControl x2 = Initialize_ctrlTouchscreenprimaryTouchdeltax(kAxisLayout, deltaControl2);
		AxisControl y2 = Initialize_ctrlTouchscreenprimaryTouchdeltay(kAxisLayout, deltaControl2);
		AxisControl x3 = Initialize_ctrlTouchscreenprimaryTouchradiusx(kAxisLayout, vector2Control4);
		AxisControl y3 = Initialize_ctrlTouchscreenprimaryTouchradiusy(kAxisLayout, vector2Control4);
		AxisControl x4 = Initialize_ctrlTouchscreenprimaryTouchstartPositionx(kAxisLayout, vector2Control5);
		AxisControl y4 = Initialize_ctrlTouchscreenprimaryTouchstartPositiony(kAxisLayout, vector2Control5);
		AxisControl x5 = Initialize_ctrlTouchscreenpositionx(kAxisLayout, vector2Control);
		AxisControl y5 = Initialize_ctrlTouchscreenpositiony(kAxisLayout, vector2Control);
		AxisControl up2 = Initialize_ctrlTouchscreendeltaup(kAxisLayout, deltaControl);
		AxisControl down2 = Initialize_ctrlTouchscreendeltadown(kAxisLayout, deltaControl);
		AxisControl left2 = Initialize_ctrlTouchscreendeltaleft(kAxisLayout, deltaControl);
		AxisControl right2 = Initialize_ctrlTouchscreendeltaright(kAxisLayout, deltaControl);
		AxisControl x6 = Initialize_ctrlTouchscreendeltax(kAxisLayout, deltaControl);
		AxisControl y6 = Initialize_ctrlTouchscreendeltay(kAxisLayout, deltaControl);
		AxisControl x7 = Initialize_ctrlTouchscreenradiusx(kAxisLayout, vector2Control2);
		AxisControl y7 = Initialize_ctrlTouchscreenradiusy(kAxisLayout, vector2Control2);
		IntegerControl touchId2 = Initialize_ctrlTouchscreentouch0touchId(kIntegerLayout, touchControl2);
		Vector2Control vector2Control6 = Initialize_ctrlTouchscreentouch0position(kVector2Layout, touchControl2);
		DeltaControl deltaControl3 = Initialize_ctrlTouchscreentouch0delta(kDeltaLayout, touchControl2);
		AxisControl axisControl2 = Initialize_ctrlTouchscreentouch0pressure(kAxisLayout, touchControl2);
		Vector2Control vector2Control7 = Initialize_ctrlTouchscreentouch0radius(kVector2Layout, touchControl2);
		TouchPhaseControl phase2 = Initialize_ctrlTouchscreentouch0phase(kTouchPhaseLayout, touchControl2);
		TouchPressControl touchPressControl3 = Initialize_ctrlTouchscreentouch0press(kTouchPressLayout, touchControl2);
		IntegerControl tapCount2 = Initialize_ctrlTouchscreentouch0tapCount(kIntegerLayout, touchControl2);
		IntegerControl integerControl2 = Initialize_ctrlTouchscreentouch0displayIndex(kIntegerLayout, touchControl2);
		ButtonControl indirectTouch2 = Initialize_ctrlTouchscreentouch0indirectTouch(kButtonLayout, touchControl2);
		ButtonControl tap = Initialize_ctrlTouchscreentouch0tap(kButtonLayout, touchControl2);
		DoubleControl startTime2 = Initialize_ctrlTouchscreentouch0startTime(kDoubleLayout, touchControl2);
		Vector2Control vector2Control8 = Initialize_ctrlTouchscreentouch0startPosition(kVector2Layout, touchControl2);
		AxisControl x8 = Initialize_ctrlTouchscreentouch0positionx(kAxisLayout, vector2Control6);
		AxisControl y8 = Initialize_ctrlTouchscreentouch0positiony(kAxisLayout, vector2Control6);
		AxisControl up3 = Initialize_ctrlTouchscreentouch0deltaup(kAxisLayout, deltaControl3);
		AxisControl down3 = Initialize_ctrlTouchscreentouch0deltadown(kAxisLayout, deltaControl3);
		AxisControl left3 = Initialize_ctrlTouchscreentouch0deltaleft(kAxisLayout, deltaControl3);
		AxisControl right3 = Initialize_ctrlTouchscreentouch0deltaright(kAxisLayout, deltaControl3);
		AxisControl x9 = Initialize_ctrlTouchscreentouch0deltax(kAxisLayout, deltaControl3);
		AxisControl y9 = Initialize_ctrlTouchscreentouch0deltay(kAxisLayout, deltaControl3);
		AxisControl x10 = Initialize_ctrlTouchscreentouch0radiusx(kAxisLayout, vector2Control7);
		AxisControl y10 = Initialize_ctrlTouchscreentouch0radiusy(kAxisLayout, vector2Control7);
		AxisControl x11 = Initialize_ctrlTouchscreentouch0startPositionx(kAxisLayout, vector2Control8);
		AxisControl y11 = Initialize_ctrlTouchscreentouch0startPositiony(kAxisLayout, vector2Control8);
		IntegerControl touchId3 = Initialize_ctrlTouchscreentouch1touchId(kIntegerLayout, touchControl3);
		Vector2Control vector2Control9 = Initialize_ctrlTouchscreentouch1position(kVector2Layout, touchControl3);
		DeltaControl deltaControl4 = Initialize_ctrlTouchscreentouch1delta(kDeltaLayout, touchControl3);
		AxisControl axisControl3 = Initialize_ctrlTouchscreentouch1pressure(kAxisLayout, touchControl3);
		Vector2Control vector2Control10 = Initialize_ctrlTouchscreentouch1radius(kVector2Layout, touchControl3);
		TouchPhaseControl phase3 = Initialize_ctrlTouchscreentouch1phase(kTouchPhaseLayout, touchControl3);
		TouchPressControl touchPressControl4 = Initialize_ctrlTouchscreentouch1press(kTouchPressLayout, touchControl3);
		IntegerControl tapCount3 = Initialize_ctrlTouchscreentouch1tapCount(kIntegerLayout, touchControl3);
		IntegerControl integerControl3 = Initialize_ctrlTouchscreentouch1displayIndex(kIntegerLayout, touchControl3);
		ButtonControl indirectTouch3 = Initialize_ctrlTouchscreentouch1indirectTouch(kButtonLayout, touchControl3);
		ButtonControl tap2 = Initialize_ctrlTouchscreentouch1tap(kButtonLayout, touchControl3);
		DoubleControl startTime3 = Initialize_ctrlTouchscreentouch1startTime(kDoubleLayout, touchControl3);
		Vector2Control vector2Control11 = Initialize_ctrlTouchscreentouch1startPosition(kVector2Layout, touchControl3);
		AxisControl x12 = Initialize_ctrlTouchscreentouch1positionx(kAxisLayout, vector2Control9);
		AxisControl y12 = Initialize_ctrlTouchscreentouch1positiony(kAxisLayout, vector2Control9);
		AxisControl up4 = Initialize_ctrlTouchscreentouch1deltaup(kAxisLayout, deltaControl4);
		AxisControl down4 = Initialize_ctrlTouchscreentouch1deltadown(kAxisLayout, deltaControl4);
		AxisControl left4 = Initialize_ctrlTouchscreentouch1deltaleft(kAxisLayout, deltaControl4);
		AxisControl right4 = Initialize_ctrlTouchscreentouch1deltaright(kAxisLayout, deltaControl4);
		AxisControl x13 = Initialize_ctrlTouchscreentouch1deltax(kAxisLayout, deltaControl4);
		AxisControl y13 = Initialize_ctrlTouchscreentouch1deltay(kAxisLayout, deltaControl4);
		AxisControl x14 = Initialize_ctrlTouchscreentouch1radiusx(kAxisLayout, vector2Control10);
		AxisControl y14 = Initialize_ctrlTouchscreentouch1radiusy(kAxisLayout, vector2Control10);
		AxisControl x15 = Initialize_ctrlTouchscreentouch1startPositionx(kAxisLayout, vector2Control11);
		AxisControl y15 = Initialize_ctrlTouchscreentouch1startPositiony(kAxisLayout, vector2Control11);
		IntegerControl touchId4 = Initialize_ctrlTouchscreentouch2touchId(kIntegerLayout, touchControl4);
		Vector2Control vector2Control12 = Initialize_ctrlTouchscreentouch2position(kVector2Layout, touchControl4);
		DeltaControl deltaControl5 = Initialize_ctrlTouchscreentouch2delta(kDeltaLayout, touchControl4);
		AxisControl axisControl4 = Initialize_ctrlTouchscreentouch2pressure(kAxisLayout, touchControl4);
		Vector2Control vector2Control13 = Initialize_ctrlTouchscreentouch2radius(kVector2Layout, touchControl4);
		TouchPhaseControl phase4 = Initialize_ctrlTouchscreentouch2phase(kTouchPhaseLayout, touchControl4);
		TouchPressControl touchPressControl5 = Initialize_ctrlTouchscreentouch2press(kTouchPressLayout, touchControl4);
		IntegerControl tapCount4 = Initialize_ctrlTouchscreentouch2tapCount(kIntegerLayout, touchControl4);
		IntegerControl integerControl4 = Initialize_ctrlTouchscreentouch2displayIndex(kIntegerLayout, touchControl4);
		ButtonControl indirectTouch4 = Initialize_ctrlTouchscreentouch2indirectTouch(kButtonLayout, touchControl4);
		ButtonControl tap3 = Initialize_ctrlTouchscreentouch2tap(kButtonLayout, touchControl4);
		DoubleControl startTime4 = Initialize_ctrlTouchscreentouch2startTime(kDoubleLayout, touchControl4);
		Vector2Control vector2Control14 = Initialize_ctrlTouchscreentouch2startPosition(kVector2Layout, touchControl4);
		AxisControl x16 = Initialize_ctrlTouchscreentouch2positionx(kAxisLayout, vector2Control12);
		AxisControl y16 = Initialize_ctrlTouchscreentouch2positiony(kAxisLayout, vector2Control12);
		AxisControl up5 = Initialize_ctrlTouchscreentouch2deltaup(kAxisLayout, deltaControl5);
		AxisControl down5 = Initialize_ctrlTouchscreentouch2deltadown(kAxisLayout, deltaControl5);
		AxisControl left5 = Initialize_ctrlTouchscreentouch2deltaleft(kAxisLayout, deltaControl5);
		AxisControl right5 = Initialize_ctrlTouchscreentouch2deltaright(kAxisLayout, deltaControl5);
		AxisControl x17 = Initialize_ctrlTouchscreentouch2deltax(kAxisLayout, deltaControl5);
		AxisControl y17 = Initialize_ctrlTouchscreentouch2deltay(kAxisLayout, deltaControl5);
		AxisControl x18 = Initialize_ctrlTouchscreentouch2radiusx(kAxisLayout, vector2Control13);
		AxisControl y18 = Initialize_ctrlTouchscreentouch2radiusy(kAxisLayout, vector2Control13);
		AxisControl x19 = Initialize_ctrlTouchscreentouch2startPositionx(kAxisLayout, vector2Control14);
		AxisControl y19 = Initialize_ctrlTouchscreentouch2startPositiony(kAxisLayout, vector2Control14);
		IntegerControl touchId5 = Initialize_ctrlTouchscreentouch3touchId(kIntegerLayout, touchControl5);
		Vector2Control vector2Control15 = Initialize_ctrlTouchscreentouch3position(kVector2Layout, touchControl5);
		DeltaControl deltaControl6 = Initialize_ctrlTouchscreentouch3delta(kDeltaLayout, touchControl5);
		AxisControl axisControl5 = Initialize_ctrlTouchscreentouch3pressure(kAxisLayout, touchControl5);
		Vector2Control vector2Control16 = Initialize_ctrlTouchscreentouch3radius(kVector2Layout, touchControl5);
		TouchPhaseControl phase5 = Initialize_ctrlTouchscreentouch3phase(kTouchPhaseLayout, touchControl5);
		TouchPressControl touchPressControl6 = Initialize_ctrlTouchscreentouch3press(kTouchPressLayout, touchControl5);
		IntegerControl tapCount5 = Initialize_ctrlTouchscreentouch3tapCount(kIntegerLayout, touchControl5);
		IntegerControl integerControl5 = Initialize_ctrlTouchscreentouch3displayIndex(kIntegerLayout, touchControl5);
		ButtonControl indirectTouch5 = Initialize_ctrlTouchscreentouch3indirectTouch(kButtonLayout, touchControl5);
		ButtonControl tap4 = Initialize_ctrlTouchscreentouch3tap(kButtonLayout, touchControl5);
		DoubleControl startTime5 = Initialize_ctrlTouchscreentouch3startTime(kDoubleLayout, touchControl5);
		Vector2Control vector2Control17 = Initialize_ctrlTouchscreentouch3startPosition(kVector2Layout, touchControl5);
		AxisControl x20 = Initialize_ctrlTouchscreentouch3positionx(kAxisLayout, vector2Control15);
		AxisControl y20 = Initialize_ctrlTouchscreentouch3positiony(kAxisLayout, vector2Control15);
		AxisControl up6 = Initialize_ctrlTouchscreentouch3deltaup(kAxisLayout, deltaControl6);
		AxisControl down6 = Initialize_ctrlTouchscreentouch3deltadown(kAxisLayout, deltaControl6);
		AxisControl left6 = Initialize_ctrlTouchscreentouch3deltaleft(kAxisLayout, deltaControl6);
		AxisControl right6 = Initialize_ctrlTouchscreentouch3deltaright(kAxisLayout, deltaControl6);
		AxisControl x21 = Initialize_ctrlTouchscreentouch3deltax(kAxisLayout, deltaControl6);
		AxisControl y21 = Initialize_ctrlTouchscreentouch3deltay(kAxisLayout, deltaControl6);
		AxisControl x22 = Initialize_ctrlTouchscreentouch3radiusx(kAxisLayout, vector2Control16);
		AxisControl y22 = Initialize_ctrlTouchscreentouch3radiusy(kAxisLayout, vector2Control16);
		AxisControl x23 = Initialize_ctrlTouchscreentouch3startPositionx(kAxisLayout, vector2Control17);
		AxisControl y23 = Initialize_ctrlTouchscreentouch3startPositiony(kAxisLayout, vector2Control17);
		IntegerControl touchId6 = Initialize_ctrlTouchscreentouch4touchId(kIntegerLayout, touchControl6);
		Vector2Control vector2Control18 = Initialize_ctrlTouchscreentouch4position(kVector2Layout, touchControl6);
		DeltaControl deltaControl7 = Initialize_ctrlTouchscreentouch4delta(kDeltaLayout, touchControl6);
		AxisControl axisControl6 = Initialize_ctrlTouchscreentouch4pressure(kAxisLayout, touchControl6);
		Vector2Control vector2Control19 = Initialize_ctrlTouchscreentouch4radius(kVector2Layout, touchControl6);
		TouchPhaseControl phase6 = Initialize_ctrlTouchscreentouch4phase(kTouchPhaseLayout, touchControl6);
		TouchPressControl touchPressControl7 = Initialize_ctrlTouchscreentouch4press(kTouchPressLayout, touchControl6);
		IntegerControl tapCount6 = Initialize_ctrlTouchscreentouch4tapCount(kIntegerLayout, touchControl6);
		IntegerControl integerControl6 = Initialize_ctrlTouchscreentouch4displayIndex(kIntegerLayout, touchControl6);
		ButtonControl indirectTouch6 = Initialize_ctrlTouchscreentouch4indirectTouch(kButtonLayout, touchControl6);
		ButtonControl tap5 = Initialize_ctrlTouchscreentouch4tap(kButtonLayout, touchControl6);
		DoubleControl startTime6 = Initialize_ctrlTouchscreentouch4startTime(kDoubleLayout, touchControl6);
		Vector2Control vector2Control20 = Initialize_ctrlTouchscreentouch4startPosition(kVector2Layout, touchControl6);
		AxisControl x24 = Initialize_ctrlTouchscreentouch4positionx(kAxisLayout, vector2Control18);
		AxisControl y24 = Initialize_ctrlTouchscreentouch4positiony(kAxisLayout, vector2Control18);
		AxisControl up7 = Initialize_ctrlTouchscreentouch4deltaup(kAxisLayout, deltaControl7);
		AxisControl down7 = Initialize_ctrlTouchscreentouch4deltadown(kAxisLayout, deltaControl7);
		AxisControl left7 = Initialize_ctrlTouchscreentouch4deltaleft(kAxisLayout, deltaControl7);
		AxisControl right7 = Initialize_ctrlTouchscreentouch4deltaright(kAxisLayout, deltaControl7);
		AxisControl x25 = Initialize_ctrlTouchscreentouch4deltax(kAxisLayout, deltaControl7);
		AxisControl y25 = Initialize_ctrlTouchscreentouch4deltay(kAxisLayout, deltaControl7);
		AxisControl x26 = Initialize_ctrlTouchscreentouch4radiusx(kAxisLayout, vector2Control19);
		AxisControl y26 = Initialize_ctrlTouchscreentouch4radiusy(kAxisLayout, vector2Control19);
		AxisControl x27 = Initialize_ctrlTouchscreentouch4startPositionx(kAxisLayout, vector2Control20);
		AxisControl y27 = Initialize_ctrlTouchscreentouch4startPositiony(kAxisLayout, vector2Control20);
		IntegerControl touchId7 = Initialize_ctrlTouchscreentouch5touchId(kIntegerLayout, touchControl7);
		Vector2Control vector2Control21 = Initialize_ctrlTouchscreentouch5position(kVector2Layout, touchControl7);
		DeltaControl deltaControl8 = Initialize_ctrlTouchscreentouch5delta(kDeltaLayout, touchControl7);
		AxisControl axisControl7 = Initialize_ctrlTouchscreentouch5pressure(kAxisLayout, touchControl7);
		Vector2Control vector2Control22 = Initialize_ctrlTouchscreentouch5radius(kVector2Layout, touchControl7);
		TouchPhaseControl phase7 = Initialize_ctrlTouchscreentouch5phase(kTouchPhaseLayout, touchControl7);
		TouchPressControl touchPressControl8 = Initialize_ctrlTouchscreentouch5press(kTouchPressLayout, touchControl7);
		IntegerControl tapCount7 = Initialize_ctrlTouchscreentouch5tapCount(kIntegerLayout, touchControl7);
		IntegerControl integerControl7 = Initialize_ctrlTouchscreentouch5displayIndex(kIntegerLayout, touchControl7);
		ButtonControl indirectTouch7 = Initialize_ctrlTouchscreentouch5indirectTouch(kButtonLayout, touchControl7);
		ButtonControl tap6 = Initialize_ctrlTouchscreentouch5tap(kButtonLayout, touchControl7);
		DoubleControl startTime7 = Initialize_ctrlTouchscreentouch5startTime(kDoubleLayout, touchControl7);
		Vector2Control vector2Control23 = Initialize_ctrlTouchscreentouch5startPosition(kVector2Layout, touchControl7);
		AxisControl x28 = Initialize_ctrlTouchscreentouch5positionx(kAxisLayout, vector2Control21);
		AxisControl y28 = Initialize_ctrlTouchscreentouch5positiony(kAxisLayout, vector2Control21);
		AxisControl up8 = Initialize_ctrlTouchscreentouch5deltaup(kAxisLayout, deltaControl8);
		AxisControl down8 = Initialize_ctrlTouchscreentouch5deltadown(kAxisLayout, deltaControl8);
		AxisControl left8 = Initialize_ctrlTouchscreentouch5deltaleft(kAxisLayout, deltaControl8);
		AxisControl right8 = Initialize_ctrlTouchscreentouch5deltaright(kAxisLayout, deltaControl8);
		AxisControl x29 = Initialize_ctrlTouchscreentouch5deltax(kAxisLayout, deltaControl8);
		AxisControl y29 = Initialize_ctrlTouchscreentouch5deltay(kAxisLayout, deltaControl8);
		AxisControl x30 = Initialize_ctrlTouchscreentouch5radiusx(kAxisLayout, vector2Control22);
		AxisControl y30 = Initialize_ctrlTouchscreentouch5radiusy(kAxisLayout, vector2Control22);
		AxisControl x31 = Initialize_ctrlTouchscreentouch5startPositionx(kAxisLayout, vector2Control23);
		AxisControl y31 = Initialize_ctrlTouchscreentouch5startPositiony(kAxisLayout, vector2Control23);
		IntegerControl touchId8 = Initialize_ctrlTouchscreentouch6touchId(kIntegerLayout, touchControl8);
		Vector2Control vector2Control24 = Initialize_ctrlTouchscreentouch6position(kVector2Layout, touchControl8);
		DeltaControl deltaControl9 = Initialize_ctrlTouchscreentouch6delta(kDeltaLayout, touchControl8);
		AxisControl axisControl8 = Initialize_ctrlTouchscreentouch6pressure(kAxisLayout, touchControl8);
		Vector2Control vector2Control25 = Initialize_ctrlTouchscreentouch6radius(kVector2Layout, touchControl8);
		TouchPhaseControl phase8 = Initialize_ctrlTouchscreentouch6phase(kTouchPhaseLayout, touchControl8);
		TouchPressControl touchPressControl9 = Initialize_ctrlTouchscreentouch6press(kTouchPressLayout, touchControl8);
		IntegerControl tapCount8 = Initialize_ctrlTouchscreentouch6tapCount(kIntegerLayout, touchControl8);
		IntegerControl integerControl8 = Initialize_ctrlTouchscreentouch6displayIndex(kIntegerLayout, touchControl8);
		ButtonControl indirectTouch8 = Initialize_ctrlTouchscreentouch6indirectTouch(kButtonLayout, touchControl8);
		ButtonControl tap7 = Initialize_ctrlTouchscreentouch6tap(kButtonLayout, touchControl8);
		DoubleControl startTime8 = Initialize_ctrlTouchscreentouch6startTime(kDoubleLayout, touchControl8);
		Vector2Control vector2Control26 = Initialize_ctrlTouchscreentouch6startPosition(kVector2Layout, touchControl8);
		AxisControl x32 = Initialize_ctrlTouchscreentouch6positionx(kAxisLayout, vector2Control24);
		AxisControl y32 = Initialize_ctrlTouchscreentouch6positiony(kAxisLayout, vector2Control24);
		AxisControl up9 = Initialize_ctrlTouchscreentouch6deltaup(kAxisLayout, deltaControl9);
		AxisControl down9 = Initialize_ctrlTouchscreentouch6deltadown(kAxisLayout, deltaControl9);
		AxisControl left9 = Initialize_ctrlTouchscreentouch6deltaleft(kAxisLayout, deltaControl9);
		AxisControl right9 = Initialize_ctrlTouchscreentouch6deltaright(kAxisLayout, deltaControl9);
		AxisControl x33 = Initialize_ctrlTouchscreentouch6deltax(kAxisLayout, deltaControl9);
		AxisControl y33 = Initialize_ctrlTouchscreentouch6deltay(kAxisLayout, deltaControl9);
		AxisControl x34 = Initialize_ctrlTouchscreentouch6radiusx(kAxisLayout, vector2Control25);
		AxisControl y34 = Initialize_ctrlTouchscreentouch6radiusy(kAxisLayout, vector2Control25);
		AxisControl x35 = Initialize_ctrlTouchscreentouch6startPositionx(kAxisLayout, vector2Control26);
		AxisControl y35 = Initialize_ctrlTouchscreentouch6startPositiony(kAxisLayout, vector2Control26);
		IntegerControl touchId9 = Initialize_ctrlTouchscreentouch7touchId(kIntegerLayout, touchControl9);
		Vector2Control vector2Control27 = Initialize_ctrlTouchscreentouch7position(kVector2Layout, touchControl9);
		DeltaControl deltaControl10 = Initialize_ctrlTouchscreentouch7delta(kDeltaLayout, touchControl9);
		AxisControl axisControl9 = Initialize_ctrlTouchscreentouch7pressure(kAxisLayout, touchControl9);
		Vector2Control vector2Control28 = Initialize_ctrlTouchscreentouch7radius(kVector2Layout, touchControl9);
		TouchPhaseControl phase9 = Initialize_ctrlTouchscreentouch7phase(kTouchPhaseLayout, touchControl9);
		TouchPressControl touchPressControl10 = Initialize_ctrlTouchscreentouch7press(kTouchPressLayout, touchControl9);
		IntegerControl tapCount9 = Initialize_ctrlTouchscreentouch7tapCount(kIntegerLayout, touchControl9);
		IntegerControl integerControl9 = Initialize_ctrlTouchscreentouch7displayIndex(kIntegerLayout, touchControl9);
		ButtonControl indirectTouch9 = Initialize_ctrlTouchscreentouch7indirectTouch(kButtonLayout, touchControl9);
		ButtonControl tap8 = Initialize_ctrlTouchscreentouch7tap(kButtonLayout, touchControl9);
		DoubleControl startTime9 = Initialize_ctrlTouchscreentouch7startTime(kDoubleLayout, touchControl9);
		Vector2Control vector2Control29 = Initialize_ctrlTouchscreentouch7startPosition(kVector2Layout, touchControl9);
		AxisControl x36 = Initialize_ctrlTouchscreentouch7positionx(kAxisLayout, vector2Control27);
		AxisControl y36 = Initialize_ctrlTouchscreentouch7positiony(kAxisLayout, vector2Control27);
		AxisControl up10 = Initialize_ctrlTouchscreentouch7deltaup(kAxisLayout, deltaControl10);
		AxisControl down10 = Initialize_ctrlTouchscreentouch7deltadown(kAxisLayout, deltaControl10);
		AxisControl left10 = Initialize_ctrlTouchscreentouch7deltaleft(kAxisLayout, deltaControl10);
		AxisControl right10 = Initialize_ctrlTouchscreentouch7deltaright(kAxisLayout, deltaControl10);
		AxisControl x37 = Initialize_ctrlTouchscreentouch7deltax(kAxisLayout, deltaControl10);
		AxisControl y37 = Initialize_ctrlTouchscreentouch7deltay(kAxisLayout, deltaControl10);
		AxisControl x38 = Initialize_ctrlTouchscreentouch7radiusx(kAxisLayout, vector2Control28);
		AxisControl y38 = Initialize_ctrlTouchscreentouch7radiusy(kAxisLayout, vector2Control28);
		AxisControl x39 = Initialize_ctrlTouchscreentouch7startPositionx(kAxisLayout, vector2Control29);
		AxisControl y39 = Initialize_ctrlTouchscreentouch7startPositiony(kAxisLayout, vector2Control29);
		IntegerControl touchId10 = Initialize_ctrlTouchscreentouch8touchId(kIntegerLayout, touchControl10);
		Vector2Control vector2Control30 = Initialize_ctrlTouchscreentouch8position(kVector2Layout, touchControl10);
		DeltaControl deltaControl11 = Initialize_ctrlTouchscreentouch8delta(kDeltaLayout, touchControl10);
		AxisControl axisControl10 = Initialize_ctrlTouchscreentouch8pressure(kAxisLayout, touchControl10);
		Vector2Control vector2Control31 = Initialize_ctrlTouchscreentouch8radius(kVector2Layout, touchControl10);
		TouchPhaseControl phase10 = Initialize_ctrlTouchscreentouch8phase(kTouchPhaseLayout, touchControl10);
		TouchPressControl touchPressControl11 = Initialize_ctrlTouchscreentouch8press(kTouchPressLayout, touchControl10);
		IntegerControl tapCount10 = Initialize_ctrlTouchscreentouch8tapCount(kIntegerLayout, touchControl10);
		IntegerControl integerControl10 = Initialize_ctrlTouchscreentouch8displayIndex(kIntegerLayout, touchControl10);
		ButtonControl indirectTouch10 = Initialize_ctrlTouchscreentouch8indirectTouch(kButtonLayout, touchControl10);
		ButtonControl tap9 = Initialize_ctrlTouchscreentouch8tap(kButtonLayout, touchControl10);
		DoubleControl startTime10 = Initialize_ctrlTouchscreentouch8startTime(kDoubleLayout, touchControl10);
		Vector2Control vector2Control32 = Initialize_ctrlTouchscreentouch8startPosition(kVector2Layout, touchControl10);
		AxisControl x40 = Initialize_ctrlTouchscreentouch8positionx(kAxisLayout, vector2Control30);
		AxisControl y40 = Initialize_ctrlTouchscreentouch8positiony(kAxisLayout, vector2Control30);
		AxisControl up11 = Initialize_ctrlTouchscreentouch8deltaup(kAxisLayout, deltaControl11);
		AxisControl down11 = Initialize_ctrlTouchscreentouch8deltadown(kAxisLayout, deltaControl11);
		AxisControl left11 = Initialize_ctrlTouchscreentouch8deltaleft(kAxisLayout, deltaControl11);
		AxisControl right11 = Initialize_ctrlTouchscreentouch8deltaright(kAxisLayout, deltaControl11);
		AxisControl x41 = Initialize_ctrlTouchscreentouch8deltax(kAxisLayout, deltaControl11);
		AxisControl y41 = Initialize_ctrlTouchscreentouch8deltay(kAxisLayout, deltaControl11);
		AxisControl x42 = Initialize_ctrlTouchscreentouch8radiusx(kAxisLayout, vector2Control31);
		AxisControl y42 = Initialize_ctrlTouchscreentouch8radiusy(kAxisLayout, vector2Control31);
		AxisControl x43 = Initialize_ctrlTouchscreentouch8startPositionx(kAxisLayout, vector2Control32);
		AxisControl y43 = Initialize_ctrlTouchscreentouch8startPositiony(kAxisLayout, vector2Control32);
		IntegerControl touchId11 = Initialize_ctrlTouchscreentouch9touchId(kIntegerLayout, touchControl11);
		Vector2Control vector2Control33 = Initialize_ctrlTouchscreentouch9position(kVector2Layout, touchControl11);
		DeltaControl deltaControl12 = Initialize_ctrlTouchscreentouch9delta(kDeltaLayout, touchControl11);
		AxisControl axisControl11 = Initialize_ctrlTouchscreentouch9pressure(kAxisLayout, touchControl11);
		Vector2Control vector2Control34 = Initialize_ctrlTouchscreentouch9radius(kVector2Layout, touchControl11);
		TouchPhaseControl phase11 = Initialize_ctrlTouchscreentouch9phase(kTouchPhaseLayout, touchControl11);
		TouchPressControl touchPressControl12 = Initialize_ctrlTouchscreentouch9press(kTouchPressLayout, touchControl11);
		IntegerControl tapCount11 = Initialize_ctrlTouchscreentouch9tapCount(kIntegerLayout, touchControl11);
		IntegerControl integerControl11 = Initialize_ctrlTouchscreentouch9displayIndex(kIntegerLayout, touchControl11);
		ButtonControl indirectTouch11 = Initialize_ctrlTouchscreentouch9indirectTouch(kButtonLayout, touchControl11);
		ButtonControl tap10 = Initialize_ctrlTouchscreentouch9tap(kButtonLayout, touchControl11);
		DoubleControl startTime11 = Initialize_ctrlTouchscreentouch9startTime(kDoubleLayout, touchControl11);
		Vector2Control vector2Control35 = Initialize_ctrlTouchscreentouch9startPosition(kVector2Layout, touchControl11);
		AxisControl x44 = Initialize_ctrlTouchscreentouch9positionx(kAxisLayout, vector2Control33);
		AxisControl y44 = Initialize_ctrlTouchscreentouch9positiony(kAxisLayout, vector2Control33);
		AxisControl up12 = Initialize_ctrlTouchscreentouch9deltaup(kAxisLayout, deltaControl12);
		AxisControl down12 = Initialize_ctrlTouchscreentouch9deltadown(kAxisLayout, deltaControl12);
		AxisControl left12 = Initialize_ctrlTouchscreentouch9deltaleft(kAxisLayout, deltaControl12);
		AxisControl right12 = Initialize_ctrlTouchscreentouch9deltaright(kAxisLayout, deltaControl12);
		AxisControl x45 = Initialize_ctrlTouchscreentouch9deltax(kAxisLayout, deltaControl12);
		AxisControl y45 = Initialize_ctrlTouchscreentouch9deltay(kAxisLayout, deltaControl12);
		AxisControl x46 = Initialize_ctrlTouchscreentouch9radiusx(kAxisLayout, vector2Control34);
		AxisControl y46 = Initialize_ctrlTouchscreentouch9radiusy(kAxisLayout, vector2Control34);
		AxisControl x47 = Initialize_ctrlTouchscreentouch9startPositionx(kAxisLayout, vector2Control35);
		AxisControl y47 = Initialize_ctrlTouchscreentouch9startPositiony(kAxisLayout, vector2Control35);
		deviceBuilder.WithControlUsage(0, new InternedString("PrimaryAction"), buttonControl);
		deviceBuilder.WithControlUsage(1, new InternedString("Point"), vector2Control);
		deviceBuilder.WithControlUsage(2, new InternedString("Secondary2DMotion"), deltaControl);
		deviceBuilder.WithControlUsage(3, new InternedString("Pressure"), control);
		deviceBuilder.WithControlUsage(4, new InternedString("Radius"), vector2Control2);
		base.touchControlArray = new TouchControl[10];
		base.touchControlArray[0] = touchControl2;
		base.touchControlArray[1] = touchControl3;
		base.touchControlArray[2] = touchControl4;
		base.touchControlArray[3] = touchControl5;
		base.touchControlArray[4] = touchControl6;
		base.touchControlArray[5] = touchControl7;
		base.touchControlArray[6] = touchControl8;
		base.touchControlArray[7] = touchControl9;
		base.touchControlArray[8] = touchControl10;
		base.touchControlArray[9] = touchControl11;
		base.primaryTouch = touchControl;
		base.position = vector2Control;
		base.delta = deltaControl;
		base.radius = vector2Control2;
		base.pressure = control;
		base.press = touchPressControl;
		base.displayIndex = integerControl;
		touchControl.press = touchPressControl2;
		touchControl.displayIndex = integerControl;
		touchControl.touchId = touchId;
		touchControl.position = vector2Control3;
		touchControl.delta = deltaControl2;
		touchControl.pressure = axisControl;
		touchControl.radius = vector2Control4;
		touchControl.phase = phase;
		touchControl.indirectTouch = indirectTouch;
		touchControl.tap = buttonControl;
		touchControl.tapCount = tapCount;
		touchControl.startTime = startTime;
		touchControl.startPosition = vector2Control5;
		vector2Control.x = x5;
		vector2Control.y = y5;
		deltaControl.up = up2;
		deltaControl.down = down2;
		deltaControl.left = left2;
		deltaControl.right = right2;
		deltaControl.x = x6;
		deltaControl.y = y6;
		vector2Control2.x = x7;
		vector2Control2.y = y7;
		touchControl2.press = touchPressControl3;
		touchControl2.displayIndex = integerControl2;
		touchControl2.touchId = touchId2;
		touchControl2.position = vector2Control6;
		touchControl2.delta = deltaControl3;
		touchControl2.pressure = axisControl2;
		touchControl2.radius = vector2Control7;
		touchControl2.phase = phase2;
		touchControl2.indirectTouch = indirectTouch2;
		touchControl2.tap = tap;
		touchControl2.tapCount = tapCount2;
		touchControl2.startTime = startTime2;
		touchControl2.startPosition = vector2Control8;
		touchControl3.press = touchPressControl4;
		touchControl3.displayIndex = integerControl3;
		touchControl3.touchId = touchId3;
		touchControl3.position = vector2Control9;
		touchControl3.delta = deltaControl4;
		touchControl3.pressure = axisControl3;
		touchControl3.radius = vector2Control10;
		touchControl3.phase = phase3;
		touchControl3.indirectTouch = indirectTouch3;
		touchControl3.tap = tap2;
		touchControl3.tapCount = tapCount3;
		touchControl3.startTime = startTime3;
		touchControl3.startPosition = vector2Control11;
		touchControl4.press = touchPressControl5;
		touchControl4.displayIndex = integerControl4;
		touchControl4.touchId = touchId4;
		touchControl4.position = vector2Control12;
		touchControl4.delta = deltaControl5;
		touchControl4.pressure = axisControl4;
		touchControl4.radius = vector2Control13;
		touchControl4.phase = phase4;
		touchControl4.indirectTouch = indirectTouch4;
		touchControl4.tap = tap3;
		touchControl4.tapCount = tapCount4;
		touchControl4.startTime = startTime4;
		touchControl4.startPosition = vector2Control14;
		touchControl5.press = touchPressControl6;
		touchControl5.displayIndex = integerControl5;
		touchControl5.touchId = touchId5;
		touchControl5.position = vector2Control15;
		touchControl5.delta = deltaControl6;
		touchControl5.pressure = axisControl5;
		touchControl5.radius = vector2Control16;
		touchControl5.phase = phase5;
		touchControl5.indirectTouch = indirectTouch5;
		touchControl5.tap = tap4;
		touchControl5.tapCount = tapCount5;
		touchControl5.startTime = startTime5;
		touchControl5.startPosition = vector2Control17;
		touchControl6.press = touchPressControl7;
		touchControl6.displayIndex = integerControl6;
		touchControl6.touchId = touchId6;
		touchControl6.position = vector2Control18;
		touchControl6.delta = deltaControl7;
		touchControl6.pressure = axisControl6;
		touchControl6.radius = vector2Control19;
		touchControl6.phase = phase6;
		touchControl6.indirectTouch = indirectTouch6;
		touchControl6.tap = tap5;
		touchControl6.tapCount = tapCount6;
		touchControl6.startTime = startTime6;
		touchControl6.startPosition = vector2Control20;
		touchControl7.press = touchPressControl8;
		touchControl7.displayIndex = integerControl7;
		touchControl7.touchId = touchId7;
		touchControl7.position = vector2Control21;
		touchControl7.delta = deltaControl8;
		touchControl7.pressure = axisControl7;
		touchControl7.radius = vector2Control22;
		touchControl7.phase = phase7;
		touchControl7.indirectTouch = indirectTouch7;
		touchControl7.tap = tap6;
		touchControl7.tapCount = tapCount7;
		touchControl7.startTime = startTime7;
		touchControl7.startPosition = vector2Control23;
		touchControl8.press = touchPressControl9;
		touchControl8.displayIndex = integerControl8;
		touchControl8.touchId = touchId8;
		touchControl8.position = vector2Control24;
		touchControl8.delta = deltaControl9;
		touchControl8.pressure = axisControl8;
		touchControl8.radius = vector2Control25;
		touchControl8.phase = phase8;
		touchControl8.indirectTouch = indirectTouch8;
		touchControl8.tap = tap7;
		touchControl8.tapCount = tapCount8;
		touchControl8.startTime = startTime8;
		touchControl8.startPosition = vector2Control26;
		touchControl9.press = touchPressControl10;
		touchControl9.displayIndex = integerControl9;
		touchControl9.touchId = touchId9;
		touchControl9.position = vector2Control27;
		touchControl9.delta = deltaControl10;
		touchControl9.pressure = axisControl9;
		touchControl9.radius = vector2Control28;
		touchControl9.phase = phase9;
		touchControl9.indirectTouch = indirectTouch9;
		touchControl9.tap = tap8;
		touchControl9.tapCount = tapCount9;
		touchControl9.startTime = startTime9;
		touchControl9.startPosition = vector2Control29;
		touchControl10.press = touchPressControl11;
		touchControl10.displayIndex = integerControl10;
		touchControl10.touchId = touchId10;
		touchControl10.position = vector2Control30;
		touchControl10.delta = deltaControl11;
		touchControl10.pressure = axisControl10;
		touchControl10.radius = vector2Control31;
		touchControl10.phase = phase10;
		touchControl10.indirectTouch = indirectTouch10;
		touchControl10.tap = tap9;
		touchControl10.tapCount = tapCount10;
		touchControl10.startTime = startTime10;
		touchControl10.startPosition = vector2Control32;
		touchControl11.press = touchPressControl12;
		touchControl11.displayIndex = integerControl11;
		touchControl11.touchId = touchId11;
		touchControl11.position = vector2Control33;
		touchControl11.delta = deltaControl12;
		touchControl11.pressure = axisControl11;
		touchControl11.radius = vector2Control34;
		touchControl11.phase = phase11;
		touchControl11.indirectTouch = indirectTouch11;
		touchControl11.tap = tap10;
		touchControl11.tapCount = tapCount11;
		touchControl11.startTime = startTime11;
		touchControl11.startPosition = vector2Control35;
		vector2Control3.x = x;
		vector2Control3.y = y;
		deltaControl2.up = up;
		deltaControl2.down = down;
		deltaControl2.left = left;
		deltaControl2.right = right;
		deltaControl2.x = x2;
		deltaControl2.y = y2;
		vector2Control4.x = x3;
		vector2Control4.y = y3;
		vector2Control5.x = x4;
		vector2Control5.y = y4;
		vector2Control6.x = x8;
		vector2Control6.y = y8;
		deltaControl3.up = up3;
		deltaControl3.down = down3;
		deltaControl3.left = left3;
		deltaControl3.right = right3;
		deltaControl3.x = x9;
		deltaControl3.y = y9;
		vector2Control7.x = x10;
		vector2Control7.y = y10;
		vector2Control8.x = x11;
		vector2Control8.y = y11;
		vector2Control9.x = x12;
		vector2Control9.y = y12;
		deltaControl4.up = up4;
		deltaControl4.down = down4;
		deltaControl4.left = left4;
		deltaControl4.right = right4;
		deltaControl4.x = x13;
		deltaControl4.y = y13;
		vector2Control10.x = x14;
		vector2Control10.y = y14;
		vector2Control11.x = x15;
		vector2Control11.y = y15;
		vector2Control12.x = x16;
		vector2Control12.y = y16;
		deltaControl5.up = up5;
		deltaControl5.down = down5;
		deltaControl5.left = left5;
		deltaControl5.right = right5;
		deltaControl5.x = x17;
		deltaControl5.y = y17;
		vector2Control13.x = x18;
		vector2Control13.y = y18;
		vector2Control14.x = x19;
		vector2Control14.y = y19;
		vector2Control15.x = x20;
		vector2Control15.y = y20;
		deltaControl6.up = up6;
		deltaControl6.down = down6;
		deltaControl6.left = left6;
		deltaControl6.right = right6;
		deltaControl6.x = x21;
		deltaControl6.y = y21;
		vector2Control16.x = x22;
		vector2Control16.y = y22;
		vector2Control17.x = x23;
		vector2Control17.y = y23;
		vector2Control18.x = x24;
		vector2Control18.y = y24;
		deltaControl7.up = up7;
		deltaControl7.down = down7;
		deltaControl7.left = left7;
		deltaControl7.right = right7;
		deltaControl7.x = x25;
		deltaControl7.y = y25;
		vector2Control19.x = x26;
		vector2Control19.y = y26;
		vector2Control20.x = x27;
		vector2Control20.y = y27;
		vector2Control21.x = x28;
		vector2Control21.y = y28;
		deltaControl8.up = up8;
		deltaControl8.down = down8;
		deltaControl8.left = left8;
		deltaControl8.right = right8;
		deltaControl8.x = x29;
		deltaControl8.y = y29;
		vector2Control22.x = x30;
		vector2Control22.y = y30;
		vector2Control23.x = x31;
		vector2Control23.y = y31;
		vector2Control24.x = x32;
		vector2Control24.y = y32;
		deltaControl9.up = up9;
		deltaControl9.down = down9;
		deltaControl9.left = left9;
		deltaControl9.right = right9;
		deltaControl9.x = x33;
		deltaControl9.y = y33;
		vector2Control25.x = x34;
		vector2Control25.y = y34;
		vector2Control26.x = x35;
		vector2Control26.y = y35;
		vector2Control27.x = x36;
		vector2Control27.y = y36;
		deltaControl10.up = up10;
		deltaControl10.down = down10;
		deltaControl10.left = left10;
		deltaControl10.right = right10;
		deltaControl10.x = x37;
		deltaControl10.y = y37;
		vector2Control28.x = x38;
		vector2Control28.y = y38;
		vector2Control29.x = x39;
		vector2Control29.y = y39;
		vector2Control30.x = x40;
		vector2Control30.y = y40;
		deltaControl11.up = up11;
		deltaControl11.down = down11;
		deltaControl11.left = left11;
		deltaControl11.right = right11;
		deltaControl11.x = x41;
		deltaControl11.y = y41;
		vector2Control31.x = x42;
		vector2Control31.y = y42;
		vector2Control32.x = x43;
		vector2Control32.y = y43;
		vector2Control33.x = x44;
		vector2Control33.y = y44;
		deltaControl12.up = up12;
		deltaControl12.down = down12;
		deltaControl12.left = left12;
		deltaControl12.right = right12;
		deltaControl12.x = x45;
		deltaControl12.y = y45;
		vector2Control34.x = x46;
		vector2Control34.y = y46;
		vector2Control35.x = x47;
		vector2Control35.y = y47;
		deviceBuilder.WithStateOffsetToControlIndexMap(new uint[244]
		{
			32785u, 16810014u, 16810026u, 33587231u, 33587243u, 50364450u, 50364451u, 50364452u, 50364462u, 50364463u,
			50364464u, 67141664u, 67141665u, 67141669u, 67141676u, 67141677u, 67141681u, 83918851u, 83918868u, 100696102u,
			100696114u, 117473319u, 117473331u, 134225925u, 134225942u, 134225943u, 138420248u, 142614553u, 142622736u, 146801690u,
			148898843u, 167837724u, 201359400u, 218136617u, 234913844u, 251691073u, 268468290u, 285245509u, 285245510u, 285245511u,
			302022723u, 302022724u, 302022728u, 318799927u, 335577161u, 352354378u, 369107001u, 369107002u, 373301307u, 377495612u,
			381682749u, 383779902u, 402718783u, 436240459u, 453017676u, 469794893u, 486572122u, 503349339u, 520126558u, 520126559u,
			520126560u, 536903772u, 536903773u, 536903777u, 553680976u, 570458210u, 587235427u, 603988050u, 603988051u, 608182356u,
			612376661u, 616563798u, 618660951u, 637599832u, 671121508u, 687898725u, 704675942u, 721453171u, 738230388u, 755007607u,
			755007608u, 755007609u, 771784821u, 771784822u, 771784826u, 788562025u, 805339259u, 822116476u, 838869099u, 838869100u,
			843063405u, 847257710u, 851444847u, 853542000u, 872480881u, 906002557u, 922779774u, 939556991u, 956334220u, 973111437u,
			989888656u, 989888657u, 989888658u, 1006665870u, 1006665871u, 1006665875u, 1023443074u, 1040220308u, 1056997525u, 1073750148u,
			1073750149u, 1077944454u, 1082138759u, 1086325896u, 1088423049u, 1107361930u, 1140883606u, 1157660823u, 1174438040u, 1191215269u,
			1207992486u, 1224769705u, 1224769706u, 1224769707u, 1241546919u, 1241546920u, 1241546924u, 1258324123u, 1275101357u, 1291878574u,
			1308631197u, 1308631198u, 1312825503u, 1317019808u, 1321206945u, 1323304098u, 1342242979u, 1375764655u, 1392541872u, 1409319089u,
			1426096318u, 1442873535u, 1459650754u, 1459650755u, 1459650756u, 1476427968u, 1476427969u, 1476427973u, 1493205172u, 1509982406u,
			1526759623u, 1543512246u, 1543512247u, 1547706552u, 1551900857u, 1556087994u, 1558185147u, 1577124028u, 1610645704u, 1627422921u,
			1644200138u, 1660977367u, 1677754584u, 1694531803u, 1694531804u, 1694531805u, 1711309017u, 1711309018u, 1711309022u, 1728086221u,
			1744863455u, 1761640672u, 1778393295u, 1778393296u, 1782587601u, 1786781906u, 1790969043u, 1793066196u, 1812005077u, 1845526753u,
			1862303970u, 1879081187u, 1895858416u, 1912635633u, 1929412852u, 1929412853u, 1929412854u, 1946190066u, 1946190067u, 1946190071u,
			1962967270u, 1979744504u, 1996521721u, 2013274344u, 2013274345u, 2017468650u, 2021662955u, 2025850092u, 2027947245u, 2046886126u,
			2080407802u, 2097185019u, 2113962236u, 2130739465u, 2147516682u, 2164293901u, 2164293902u, 2164293903u, 2181071115u, 2181071116u,
			2181071120u, 2197848319u, 2214625553u, 2231402770u, 2248155393u, 2248155394u, 2252349699u, 2256544004u, 2260731141u, 2262828294u,
			2281767175u, 2315288851u, 2332066068u, 2348843285u, 2365620514u, 2382397731u, 2399174950u, 2399174951u, 2399174952u, 2415952164u,
			2415952165u, 2415952169u, 2432729368u, 2449506602u, 2466283819u, 2483036442u, 2483036443u, 2487230748u, 2491425053u, 2495612190u,
			2497709343u, 2516648224u, 2550169900u, 2566947117u
		});
		deviceBuilder.WithControlTree(new byte[4011]
		{
			63, 19, 1, 0, 0, 0, 0, 192, 8, 3,
			0, 0, 0, 0, 63, 19, 5, 1, 0, 0,
			0, 128, 3, 5, 0, 0, 0, 0, 192, 8,
			107, 0, 0, 0, 0, 192, 1, 7, 0, 0,
			0, 1, 128, 3, 57, 0, 68, 0, 1, 192,
			0, 9, 0, 0, 0, 0, 192, 1, 21, 0,
			0, 0, 0, 96, 0, 11, 0, 0, 0, 0,
			192, 0, 15, 0, 0, 0, 0, 32, 0, 255,
			255, 1, 0, 1, 96, 0, 13, 0, 2, 0,
			2, 64, 0, 255, 255, 4, 0, 2, 96, 0,
			255, 255, 6, 0, 2, 144, 0, 17, 0, 8,
			0, 8, 192, 0, 19, 0, 16, 0, 8, 120,
			0, 255, 255, 24, 0, 6, 144, 0, 255, 255,
			30, 0, 6, 168, 0, 255, 255, 36, 0, 2,
			192, 0, 255, 255, 38, 0, 2, 32, 1, 23,
			0, 0, 0, 0, 192, 1, 51, 0, 0, 0,
			0, 8, 1, 25, 0, 0, 0, 0, 32, 1,
			35, 0, 0, 0, 0, 228, 0, 27, 0, 40,
			0, 4, 8, 1, 29, 0, 44, 0, 4, 210,
			0, 255, 255, 48, 0, 2, 228, 0, 255, 255,
			50, 0, 2, 246, 0, 255, 255, 0, 0, 0,
			8, 1, 31, 0, 0, 0, 0, 255, 0, 255,
			255, 0, 0, 0, 8, 1, 33, 0, 0, 0,
			0, 4, 1, 255, 255, 52, 0, 3, 8, 1,
			255, 255, 55, 0, 3, 16, 1, 255, 255, 58,
			0, 1, 32, 1, 37, 0, 6, 2, 1, 25,
			1, 39, 0, 0, 0, 0, 32, 1, 45, 0,
			0, 0, 0, 21, 1, 255, 255, 59, 0, 1,
			25, 1, 41, 0, 60, 0, 1, 23, 1, 255,
			255, 0, 0, 0, 25, 1, 43, 0, 0, 0,
			0, 24, 1, 255, 255, 0, 0, 0, 25, 1,
			255, 255, 61, 0, 1, 29, 1, 47, 0, 0,
			0, 0, 32, 1, 255, 255, 0, 0, 0, 27,
			1, 255, 255, 0, 0, 0, 29, 1, 49, 0,
			0, 0, 0, 28, 1, 255, 255, 0, 0, 0,
			29, 1, 255, 255, 62, 0, 1, 128, 1, 53,
			0, 0, 0, 0, 192, 1, 55, 0, 65, 0,
			1, 80, 1, 255, 255, 63, 0, 1, 128, 1,
			255, 255, 64, 0, 1, 160, 1, 255, 255, 66,
			0, 1, 192, 1, 255, 255, 67, 0, 1, 160,
			2, 59, 0, 92, 0, 1, 128, 3, 75, 0,
			93, 0, 1, 48, 2, 61, 0, 77, 0, 4,
			160, 2, 69, 0, 81, 0, 4, 248, 1, 63,
			0, 71, 0, 2, 48, 2, 65, 0, 73, 0,
			2, 220, 1, 255, 255, 69, 0, 1, 248, 1,
			255, 255, 70, 0, 1, 32, 2, 67, 0, 0,
			0, 0, 48, 2, 255, 255, 0, 0, 0, 12,
			2, 255, 255, 75, 0, 1, 32, 2, 255, 255,
			76, 0, 1, 96, 2, 71, 0, 0, 0, 0,
			160, 2, 73, 0, 0, 0, 0, 72, 2, 255,
			255, 85, 0, 3, 96, 2, 255, 255, 88, 0,
			3, 128, 2, 255, 255, 91, 0, 1, 160, 2,
			255, 255, 94, 0, 1, 16, 3, 77, 0, 105,
			0, 1, 128, 3, 103, 0, 106, 0, 1, 216,
			2, 79, 0, 0, 0, 0, 16, 3, 87, 0,
			0, 0, 0, 188, 2, 255, 255, 95, 0, 1,
			216, 2, 81, 0, 96, 0, 1, 200, 2, 83,
			0, 0, 0, 0, 216, 2, 85, 0, 0, 0,
			0, 194, 2, 255, 255, 97, 0, 2, 200, 2,
			255, 255, 99, 0, 2, 208, 2, 255, 255, 101,
			0, 1, 216, 2, 255, 255, 102, 0, 1, 244,
			2, 89, 0, 0, 0, 0, 16, 3, 255, 255,
			0, 0, 0, 230, 2, 91, 0, 0, 0, 0,
			244, 2, 255, 255, 0, 0, 0, 223, 2, 93,
			0, 0, 0, 0, 230, 2, 255, 255, 0, 0,
			0, 220, 2, 95, 0, 0, 0, 0, 223, 2,
			99, 0, 0, 0, 0, 218, 2, 97, 0, 0,
			0, 0, 220, 2, 255, 255, 0, 0, 0, 217,
			2, 255, 255, 103, 0, 1, 218, 2, 255, 255,
			0, 0, 0, 222, 2, 101, 0, 0, 0, 0,
			223, 2, 255, 255, 0, 0, 0, 221, 2, 255,
			255, 104, 0, 1, 222, 2, 255, 255, 0, 0,
			0, 72, 3, 255, 255, 107, 0, 2, 128, 3,
			105, 0, 109, 0, 2, 100, 3, 255, 255, 111,
			0, 1, 128, 3, 255, 255, 112, 0, 1, 0,
			7, 109, 0, 0, 0, 0, 192, 8, 211, 0,
			203, 0, 1, 64, 5, 111, 0, 113, 0, 1,
			0, 7, 161, 0, 158, 0, 1, 96, 4, 113,
			0, 137, 0, 1, 64, 5, 129, 0, 138, 0,
			1, 240, 3, 115, 0, 122, 0, 4, 96, 4,
			123, 0, 126, 0, 4, 184, 3, 117, 0, 116,
			0, 2, 240, 3, 119, 0, 118, 0, 2, 156,
			3, 255, 255, 114, 0, 1, 184, 3, 255, 255,
			115, 0, 1, 224, 3, 121, 0, 0, 0, 0,
			240, 3, 255, 255, 0, 0, 0, 204, 3, 255,
			255, 120, 0, 1, 224, 3, 255, 255, 121, 0,
			1, 32, 4, 125, 0, 0, 0, 0, 96, 4,
			127, 0, 0, 0, 0, 8, 4, 255, 255, 130,
			0, 3, 32, 4, 255, 255, 133, 0, 3, 64,
			4, 255, 255, 136, 0, 1, 96, 4, 255, 255,
			139, 0, 1, 208, 4, 131, 0, 150, 0, 1,
			64, 5, 157, 0, 151, 0, 1, 152, 4, 133,
			0, 0, 0, 0, 208, 4, 141, 0, 0, 0,
			0, 124, 4, 255, 255, 140, 0, 1, 152, 4,
			135, 0, 141, 0, 1, 136, 4, 137, 0, 0,
			0, 0, 152, 4, 139, 0, 0, 0, 0, 130,
			4, 255, 255, 142, 0, 2, 136, 4, 255, 255,
			144, 0, 2, 144, 4, 255, 255, 146, 0, 1,
			152, 4, 255, 255, 147, 0, 1, 180, 4, 143,
			0, 0, 0, 0, 208, 4, 255, 255, 0, 0,
			0, 166, 4, 145, 0, 0, 0, 0, 180, 4,
			255, 255, 0, 0, 0, 159, 4, 147, 0, 0,
			0, 0, 166, 4, 255, 255, 0, 0, 0, 156,
			4, 149, 0, 0, 0, 0, 159, 4, 153, 0,
			0, 0, 0, 154, 4, 151, 0, 0, 0, 0,
			156, 4, 255, 255, 0, 0, 0, 153, 4, 255,
			255, 148, 0, 1, 154, 4, 255, 255, 0, 0,
			0, 158, 4, 155, 0, 0, 0, 0, 159, 4,
			255, 255, 0, 0, 0, 157, 4, 255, 255, 149,
			0, 1, 158, 4, 255, 255, 0, 0, 0, 8,
			5, 255, 255, 152, 0, 2, 64, 5, 159, 0,
			154, 0, 2, 36, 5, 255, 255, 156, 0, 1,
			64, 5, 255, 255, 157, 0, 1, 32, 6, 163,
			0, 182, 0, 1, 0, 7, 179, 0, 183, 0,
			1, 176, 5, 165, 0, 167, 0, 4, 32, 6,
			173, 0, 171, 0, 4, 120, 5, 167, 0, 161,
			0, 2, 176, 5, 169, 0, 163, 0, 2, 92,
			5, 255, 255, 159, 0, 1, 120, 5, 255, 255,
			160, 0, 1, 160, 5, 171, 0, 0, 0, 0,
			176, 5, 255, 255, 0, 0, 0, 140, 5, 255,
			255, 165, 0, 1, 160, 5, 255, 255, 166, 0,
			1, 224, 5, 175, 0, 0, 0, 0, 32, 6,
			177, 0, 0, 0, 0, 200, 5, 255, 255, 175,
			0, 3, 224, 5, 255, 255, 178, 0, 3, 0,
			6, 255, 255, 181, 0, 1, 32, 6, 255, 255,
			184, 0, 1, 144, 6, 181, 0, 195, 0, 1,
			0, 7, 207, 0, 196, 0, 1, 88, 6, 183,
			0, 0, 0, 0, 144, 6, 191, 0, 0, 0,
			0, 60, 6, 255, 255, 185, 0, 1, 88, 6,
			185, 0, 186, 0, 1, 72, 6, 187, 0, 0,
			0, 0, 88, 6, 189, 0, 0, 0, 0, 66,
			6, 255, 255, 187, 0, 2, 72, 6, 255, 255,
			189, 0, 2, 80, 6, 255, 255, 191, 0, 1,
			88, 6, 255, 255, 192, 0, 1, 116, 6, 193,
			0, 0, 0, 0, 144, 6, 255, 255, 0, 0,
			0, 102, 6, 195, 0, 0, 0, 0, 116, 6,
			255, 255, 0, 0, 0, 95, 6, 197, 0, 0,
			0, 0, 102, 6, 255, 255, 0, 0, 0, 92,
			6, 199, 0, 0, 0, 0, 95, 6, 203, 0,
			0, 0, 0, 90, 6, 201, 0, 0, 0, 0,
			92, 6, 255, 255, 0, 0, 0, 89, 6, 255,
			255, 193, 0, 1, 90, 6, 255, 255, 0, 0,
			0, 94, 6, 205, 0, 0, 0, 0, 95, 6,
			255, 255, 0, 0, 0, 93, 6, 255, 255, 194,
			0, 1, 94, 6, 255, 255, 0, 0, 0, 200,
			6, 255, 255, 197, 0, 2, 0, 7, 209, 0,
			199, 0, 2, 228, 6, 255, 255, 201, 0, 1,
			0, 7, 255, 255, 202, 0, 1, 224, 7, 213,
			0, 227, 0, 1, 192, 8, 229, 0, 228, 0,
			1, 112, 7, 215, 0, 212, 0, 4, 224, 7,
			223, 0, 216, 0, 4, 56, 7, 217, 0, 206,
			0, 2, 112, 7, 219, 0, 208, 0, 2, 28,
			7, 255, 255, 204, 0, 1, 56, 7, 255, 255,
			205, 0, 1, 96, 7, 221, 0, 0, 0, 0,
			112, 7, 255, 255, 0, 0, 0, 76, 7, 255,
			255, 210, 0, 1, 96, 7, 255, 255, 211, 0,
			1, 160, 7, 225, 0, 0, 0, 0, 224, 7,
			227, 0, 0, 0, 0, 136, 7, 255, 255, 220,
			0, 3, 160, 7, 255, 255, 223, 0, 3, 192,
			7, 255, 255, 226, 0, 1, 224, 7, 255, 255,
			229, 0, 1, 80, 8, 231, 0, 240, 0, 1,
			192, 8, 1, 1, 241, 0, 1, 24, 8, 233,
			0, 0, 0, 0, 80, 8, 241, 0, 0, 0,
			0, 252, 7, 255, 255, 230, 0, 1, 24, 8,
			235, 0, 231, 0, 1, 8, 8, 237, 0, 0,
			0, 0, 24, 8, 239, 0, 0, 0, 0, 2,
			8, 255, 255, 232, 0, 2, 8, 8, 255, 255,
			234, 0, 2, 16, 8, 255, 255, 236, 0, 1,
			24, 8, 255, 255, 237, 0, 1, 52, 8, 243,
			0, 0, 0, 0, 80, 8, 255, 255, 0, 0,
			0, 38, 8, 245, 0, 0, 0, 0, 52, 8,
			255, 255, 0, 0, 0, 31, 8, 247, 0, 0,
			0, 0, 38, 8, 255, 255, 0, 0, 0, 28,
			8, 249, 0, 0, 0, 0, 31, 8, 253, 0,
			0, 0, 0, 26, 8, 251, 0, 0, 0, 0,
			28, 8, 255, 255, 0, 0, 0, 25, 8, 255,
			255, 238, 0, 1, 26, 8, 255, 255, 0, 0,
			0, 30, 8, 255, 0, 0, 0, 0, 31, 8,
			255, 255, 0, 0, 0, 29, 8, 255, 255, 239,
			0, 1, 30, 8, 255, 255, 0, 0, 0, 136,
			8, 255, 255, 242, 0, 2, 192, 8, 3, 1,
			244, 0, 2, 164, 8, 255, 255, 246, 0, 1,
			192, 8, 255, 255, 247, 0, 1, 0, 14, 7,
			1, 0, 0, 0, 63, 19, 161, 1, 0, 0,
			0, 64, 12, 9, 1, 0, 0, 0, 0, 14,
			111, 1, 82, 1, 1, 128, 10, 11, 1, 248,
			0, 1, 64, 12, 61, 1, 37, 1, 1, 160,
			9, 13, 1, 16, 1, 1, 128, 10, 29, 1,
			17, 1, 1, 48, 9, 15, 1, 1, 1, 4,
			160, 9, 23, 1, 5, 1, 4, 248, 8, 17,
			1, 251, 0, 2, 48, 9, 19, 1, 253, 0,
			2, 220, 8, 255, 255, 249, 0, 1, 248, 8,
			255, 255, 250, 0, 1, 32, 9, 21, 1, 0,
			0, 0, 48, 9, 255, 255, 0, 0, 0, 12,
			9, 255, 255, 255, 0, 1, 32, 9, 255, 255,
			0, 1, 1, 96, 9, 25, 1, 0, 0, 0,
			160, 9, 27, 1, 0, 0, 0, 72, 9, 255,
			255, 9, 1, 3, 96, 9, 255, 255, 12, 1,
			3, 128, 9, 255, 255, 15, 1, 1, 160, 9,
			255, 255, 18, 1, 1, 16, 10, 31, 1, 29,
			1, 1, 128, 10, 57, 1, 30, 1, 1, 216,
			9, 33, 1, 0, 0, 0, 16, 10, 41, 1,
			0, 0, 0, 188, 9, 255, 255, 19, 1, 1,
			216, 9, 35, 1, 20, 1, 1, 200, 9, 37,
			1, 0, 0, 0, 216, 9, 39, 1, 0, 0,
			0, 194, 9, 255, 255, 21, 1, 2, 200, 9,
			255, 255, 23, 1, 2, 208, 9, 255, 255, 25,
			1, 1, 216, 9, 255, 255, 26, 1, 1, 244,
			9, 43, 1, 0, 0, 0, 16, 10, 255, 255,
			0, 0, 0, 230, 9, 45, 1, 0, 0, 0,
			244, 9, 255, 255, 0, 0, 0, 223, 9, 47,
			1, 0, 0, 0, 230, 9, 255, 255, 0, 0,
			0, 220, 9, 49, 1, 0, 0, 0, 223, 9,
			53, 1, 0, 0, 0, 218, 9, 51, 1, 0,
			0, 0, 220, 9, 255, 255, 0, 0, 0, 217,
			9, 255, 255, 27, 1, 1, 218, 9, 255, 255,
			0, 0, 0, 222, 9, 55, 1, 0, 0, 0,
			223, 9, 255, 255, 0, 0, 0, 221, 9, 255,
			255, 28, 1, 1, 222, 9, 255, 255, 0, 0,
			0, 72, 10, 255, 255, 31, 1, 2, 128, 10,
			59, 1, 33, 1, 2, 100, 10, 255, 255, 35,
			1, 1, 128, 10, 255, 255, 36, 1, 1, 96,
			11, 63, 1, 61, 1, 1, 64, 12, 79, 1,
			62, 1, 1, 240, 10, 65, 1, 46, 1, 4,
			96, 11, 73, 1, 50, 1, 4, 184, 10, 67,
			1, 40, 1, 2, 240, 10, 69, 1, 42, 1,
			2, 156, 10, 255, 255, 38, 1, 1, 184, 10,
			255, 255, 39, 1, 1, 224, 10, 71, 1, 0,
			0, 0, 240, 10, 255, 255, 0, 0, 0, 204,
			10, 255, 255, 44, 1, 1, 224, 10, 255, 255,
			45, 1, 1, 32, 11, 75, 1, 0, 0, 0,
			96, 11, 77, 1, 0, 0, 0, 8, 11, 255,
			255, 54, 1, 3, 32, 11, 255, 255, 57, 1,
			3, 64, 11, 255, 255, 60, 1, 1, 96, 11,
			255, 255, 63, 1, 1, 208, 11, 81, 1, 74,
			1, 1, 64, 12, 107, 1, 75, 1, 1, 152,
			11, 83, 1, 0, 0, 0, 208, 11, 91, 1,
			0, 0, 0, 124, 11, 255, 255, 64, 1, 1,
			152, 11, 85, 1, 65, 1, 1, 136, 11, 87,
			1, 0, 0, 0, 152, 11, 89, 1, 0, 0,
			0, 130, 11, 255, 255, 66, 1, 2, 136, 11,
			255, 255, 68, 1, 2, 144, 11, 255, 255, 70,
			1, 1, 152, 11, 255, 255, 71, 1, 1, 180,
			11, 93, 1, 0, 0, 0, 208, 11, 255, 255,
			0, 0, 0, 166, 11, 95, 1, 0, 0, 0,
			180, 11, 255, 255, 0, 0, 0, 159, 11, 97,
			1, 0, 0, 0, 166, 11, 255, 255, 0, 0,
			0, 156, 11, 99, 1, 0, 0, 0, 159, 11,
			103, 1, 0, 0, 0, 154, 11, 101, 1, 0,
			0, 0, 156, 11, 255, 255, 0, 0, 0, 153,
			11, 255, 255, 72, 1, 1, 154, 11, 255, 255,
			0, 0, 0, 158, 11, 105, 1, 0, 0, 0,
			159, 11, 255, 255, 0, 0, 0, 157, 11, 255,
			255, 73, 1, 1, 158, 11, 255, 255, 0, 0,
			0, 8, 12, 255, 255, 76, 1, 2, 64, 12,
			109, 1, 78, 1, 2, 36, 12, 255, 255, 80,
			1, 1, 64, 12, 255, 255, 81, 1, 1, 32,
			13, 113, 1, 106, 1, 1, 0, 14, 129, 1,
			107, 1, 1, 176, 12, 115, 1, 91, 1, 4,
			32, 13, 123, 1, 95, 1, 4, 120, 12, 117,
			1, 85, 1, 2, 176, 12, 119, 1, 87, 1,
			2, 92, 12, 255, 255, 83, 1, 1, 120, 12,
			255, 255, 84, 1, 1, 160, 12, 121, 1, 0,
			0, 0, 176, 12, 255, 255, 0, 0, 0, 140,
			12, 255, 255, 89, 1, 1, 160, 12, 255, 255,
			90, 1, 1, 224, 12, 125, 1, 0, 0, 0,
			32, 13, 127, 1, 0, 0, 0, 200, 12, 255,
			255, 99, 1, 3, 224, 12, 255, 255, 102, 1,
			3, 0, 13, 255, 255, 105, 1, 1, 32, 13,
			255, 255, 108, 1, 1, 144, 13, 131, 1, 119,
			1, 1, 0, 14, 157, 1, 120, 1, 1, 88,
			13, 133, 1, 0, 0, 0, 144, 13, 141, 1,
			0, 0, 0, 60, 13, 255, 255, 109, 1, 1,
			88, 13, 135, 1, 110, 1, 1, 72, 13, 137,
			1, 0, 0, 0, 88, 13, 139, 1, 0, 0,
			0, 66, 13, 255, 255, 111, 1, 2, 72, 13,
			255, 255, 113, 1, 2, 80, 13, 255, 255, 115,
			1, 1, 88, 13, 255, 255, 116, 1, 1, 116,
			13, 143, 1, 0, 0, 0, 144, 13, 255, 255,
			0, 0, 0, 102, 13, 145, 1, 0, 0, 0,
			116, 13, 255, 255, 0, 0, 0, 95, 13, 147,
			1, 0, 0, 0, 102, 13, 255, 255, 0, 0,
			0, 92, 13, 149, 1, 0, 0, 0, 95, 13,
			153, 1, 0, 0, 0, 90, 13, 151, 1, 0,
			0, 0, 92, 13, 255, 255, 0, 0, 0, 89,
			13, 255, 255, 117, 1, 1, 90, 13, 255, 255,
			0, 0, 0, 94, 13, 155, 1, 0, 0, 0,
			95, 13, 255, 255, 0, 0, 0, 93, 13, 255,
			255, 118, 1, 1, 94, 13, 255, 255, 0, 0,
			0, 200, 13, 255, 255, 121, 1, 2, 0, 14,
			159, 1, 123, 1, 2, 228, 13, 255, 255, 125,
			1, 1, 0, 14, 255, 255, 126, 1, 1, 128,
			17, 163, 1, 0, 0, 0, 63, 19, 9, 2,
			0, 0, 0, 192, 15, 165, 1, 127, 1, 1,
			128, 17, 215, 1, 172, 1, 1, 224, 14, 167,
			1, 151, 1, 1, 192, 15, 183, 1, 152, 1,
			1, 112, 14, 169, 1, 136, 1, 4, 224, 14,
			177, 1, 140, 1, 4, 56, 14, 171, 1, 130,
			1, 2, 112, 14, 173, 1, 132, 1, 2, 28,
			14, 255, 255, 128, 1, 1, 56, 14, 255, 255,
			129, 1, 1, 96, 14, 175, 1, 0, 0, 0,
			112, 14, 255, 255, 0, 0, 0, 76, 14, 255,
			255, 134, 1, 1, 96, 14, 255, 255, 135, 1,
			1, 160, 14, 179, 1, 0, 0, 0, 224, 14,
			181, 1, 0, 0, 0, 136, 14, 255, 255, 144,
			1, 3, 160, 14, 255, 255, 147, 1, 3, 192,
			14, 255, 255, 150, 1, 1, 224, 14, 255, 255,
			153, 1, 1, 80, 15, 185, 1, 164, 1, 1,
			192, 15, 211, 1, 165, 1, 1, 24, 15, 187,
			1, 0, 0, 0, 80, 15, 195, 1, 0, 0,
			0, 252, 14, 255, 255, 154, 1, 1, 24, 15,
			189, 1, 155, 1, 1, 8, 15, 191, 1, 0,
			0, 0, 24, 15, 193, 1, 0, 0, 0, 2,
			15, 255, 255, 156, 1, 2, 8, 15, 255, 255,
			158, 1, 2, 16, 15, 255, 255, 160, 1, 1,
			24, 15, 255, 255, 161, 1, 1, 52, 15, 197,
			1, 0, 0, 0, 80, 15, 255, 255, 0, 0,
			0, 38, 15, 199, 1, 0, 0, 0, 52, 15,
			255, 255, 0, 0, 0, 31, 15, 201, 1, 0,
			0, 0, 38, 15, 255, 255, 0, 0, 0, 28,
			15, 203, 1, 0, 0, 0, 31, 15, 207, 1,
			0, 0, 0, 26, 15, 205, 1, 0, 0, 0,
			28, 15, 255, 255, 0, 0, 0, 25, 15, 255,
			255, 162, 1, 1, 26, 15, 255, 255, 0, 0,
			0, 30, 15, 209, 1, 0, 0, 0, 31, 15,
			255, 255, 0, 0, 0, 29, 15, 255, 255, 163,
			1, 1, 30, 15, 255, 255, 0, 0, 0, 136,
			15, 255, 255, 166, 1, 2, 192, 15, 213, 1,
			168, 1, 2, 164, 15, 255, 255, 170, 1, 1,
			192, 15, 255, 255, 171, 1, 1, 160, 16, 217,
			1, 196, 1, 1, 128, 17, 233, 1, 197, 1,
			1, 48, 16, 219, 1, 181, 1, 4, 160, 16,
			227, 1, 185, 1, 4, 248, 15, 221, 1, 175,
			1, 2, 48, 16, 223, 1, 177, 1, 2, 220,
			15, 255, 255, 173, 1, 1, 248, 15, 255, 255,
			174, 1, 1, 32, 16, 225, 1, 0, 0, 0,
			48, 16, 255, 255, 0, 0, 0, 12, 16, 255,
			255, 179, 1, 1, 32, 16, 255, 255, 180, 1,
			1, 96, 16, 229, 1, 0, 0, 0, 160, 16,
			231, 1, 0, 0, 0, 72, 16, 255, 255, 189,
			1, 3, 96, 16, 255, 255, 192, 1, 3, 128,
			16, 255, 255, 195, 1, 1, 160, 16, 255, 255,
			198, 1, 1, 16, 17, 235, 1, 209, 1, 1,
			128, 17, 5, 2, 210, 1, 1, 216, 16, 237,
			1, 0, 0, 0, 16, 17, 245, 1, 0, 0,
			0, 188, 16, 255, 255, 199, 1, 1, 216, 16,
			239, 1, 200, 1, 1, 200, 16, 241, 1, 0,
			0, 0, 216, 16, 243, 1, 0, 0, 0, 194,
			16, 255, 255, 201, 1, 2, 200, 16, 255, 255,
			203, 1, 2, 208, 16, 255, 255, 205, 1, 1,
			216, 16, 255, 255, 206, 1, 1, 244, 16, 247,
			1, 0, 0, 0, 16, 17, 255, 255, 0, 0,
			0, 230, 16, 249, 1, 0, 0, 0, 244, 16,
			255, 255, 0, 0, 0, 223, 16, 251, 1, 0,
			0, 0, 230, 16, 255, 255, 0, 0, 0, 220,
			16, 253, 1, 0, 0, 0, 223, 16, 1, 2,
			0, 0, 0, 218, 16, 255, 1, 0, 0, 0,
			220, 16, 255, 255, 0, 0, 0, 217, 16, 255,
			255, 207, 1, 1, 218, 16, 255, 255, 0, 0,
			0, 222, 16, 3, 2, 0, 0, 0, 223, 16,
			255, 255, 0, 0, 0, 221, 16, 255, 255, 208,
			1, 1, 222, 16, 255, 255, 0, 0, 0, 72,
			17, 255, 255, 211, 1, 2, 128, 17, 7, 2,
			213, 1, 2, 100, 17, 255, 255, 215, 1, 1,
			128, 17, 255, 255, 216, 1, 1, 96, 18, 11,
			2, 217, 1, 2, 63, 19, 27, 2, 219, 1,
			2, 240, 17, 13, 2, 229, 1, 4, 96, 18,
			21, 2, 233, 1, 4, 184, 17, 15, 2, 223,
			1, 2, 240, 17, 17, 2, 225, 1, 2, 156,
			17, 255, 255, 221, 1, 1, 184, 17, 255, 255,
			222, 1, 1, 224, 17, 19, 2, 0, 0, 0,
			240, 17, 255, 255, 0, 0, 0, 204, 17, 255,
			255, 227, 1, 1, 224, 17, 255, 255, 228, 1,
			1, 32, 18, 23, 2, 0, 0, 0, 96, 18,
			25, 2, 0, 0, 0, 8, 18, 255, 255, 237,
			1, 3, 32, 18, 255, 255, 240, 1, 3, 64,
			18, 255, 255, 243, 1, 1, 96, 18, 255, 255,
			244, 1, 1, 208, 18, 29, 2, 255, 1, 1,
			63, 19, 55, 2, 0, 2, 1, 152, 18, 31,
			2, 0, 0, 0, 208, 18, 39, 2, 0, 0,
			0, 124, 18, 255, 255, 245, 1, 1, 152, 18,
			33, 2, 246, 1, 1, 136, 18, 35, 2, 0,
			0, 0, 152, 18, 37, 2, 0, 0, 0, 130,
			18, 255, 255, 247, 1, 2, 136, 18, 255, 255,
			249, 1, 2, 144, 18, 255, 255, 251, 1, 1,
			152, 18, 255, 255, 252, 1, 1, 180, 18, 41,
			2, 0, 0, 0, 208, 18, 255, 255, 0, 0,
			0, 166, 18, 43, 2, 0, 0, 0, 180, 18,
			255, 255, 0, 0, 0, 159, 18, 45, 2, 0,
			0, 0, 166, 18, 255, 255, 0, 0, 0, 156,
			18, 47, 2, 0, 0, 0, 159, 18, 51, 2,
			0, 0, 0, 154, 18, 49, 2, 0, 0, 0,
			156, 18, 255, 255, 0, 0, 0, 153, 18, 255,
			255, 253, 1, 1, 154, 18, 255, 255, 0, 0,
			0, 158, 18, 53, 2, 0, 0, 0, 159, 18,
			255, 255, 0, 0, 0, 157, 18, 255, 255, 254,
			1, 1, 158, 18, 255, 255, 0, 0, 0, 0,
			19, 255, 255, 0, 0, 0, 63, 19, 57, 2,
			0, 0, 0, 32, 19, 255, 255, 1, 2, 2,
			63, 19, 59, 2, 3, 2, 1, 48, 19, 255,
			255, 4, 2, 1, 63, 19, 255, 255, 5, 2,
			1
		}, new ushort[519]
		{
			0, 17, 18, 1, 30, 42, 31, 43, 19, 32,
			33, 37, 2, 44, 45, 49, 19, 32, 33, 37,
			2, 44, 45, 49, 34, 35, 36, 46, 47, 48,
			34, 35, 36, 46, 47, 48, 20, 3, 20, 3,
			21, 39, 4, 51, 21, 39, 4, 51, 38, 50,
			38, 50, 22, 23, 5, 22, 23, 5, 24, 25,
			25, 26, 27, 28, 28, 29, 40, 41, 6, 52,
			52, 53, 65, 53, 65, 66, 66, 54, 69, 70,
			71, 54, 69, 70, 71, 67, 68, 72, 67, 68,
			72, 55, 56, 56, 73, 74, 74, 57, 58, 57,
			58, 59, 60, 61, 62, 63, 63, 64, 75, 64,
			75, 76, 76, 7, 77, 77, 78, 90, 78, 90,
			91, 91, 79, 94, 95, 96, 79, 94, 95, 96,
			92, 93, 97, 92, 93, 97, 80, 81, 81, 98,
			99, 99, 82, 83, 82, 83, 84, 85, 86, 87,
			88, 88, 89, 100, 89, 100, 101, 101, 8, 102,
			102, 103, 115, 103, 115, 116, 116, 104, 119, 120,
			121, 104, 119, 120, 121, 117, 118, 122, 117, 118,
			122, 105, 106, 106, 123, 124, 124, 107, 108, 107,
			108, 109, 110, 111, 112, 113, 113, 114, 125, 114,
			125, 126, 126, 9, 127, 127, 128, 140, 128, 140,
			141, 141, 129, 144, 145, 146, 129, 144, 145, 146,
			142, 143, 147, 142, 143, 147, 130, 131, 131, 148,
			149, 149, 132, 133, 132, 133, 134, 135, 136, 137,
			138, 138, 139, 150, 139, 150, 151, 151, 10, 152,
			152, 153, 165, 153, 165, 166, 166, 154, 169, 170,
			171, 154, 169, 170, 171, 167, 168, 172, 167, 168,
			172, 155, 156, 156, 173, 174, 174, 157, 158, 157,
			158, 159, 160, 161, 162, 163, 163, 164, 175, 164,
			175, 176, 176, 11, 177, 177, 178, 190, 178, 190,
			191, 191, 179, 194, 195, 196, 179, 194, 195, 196,
			192, 193, 197, 192, 193, 197, 180, 181, 181, 198,
			199, 199, 182, 183, 182, 183, 184, 185, 186, 187,
			188, 188, 189, 200, 189, 200, 201, 201, 12, 202,
			202, 203, 215, 203, 215, 216, 216, 204, 219, 220,
			221, 204, 219, 220, 221, 217, 218, 222, 217, 218,
			222, 205, 206, 206, 223, 224, 224, 207, 208, 207,
			208, 209, 210, 211, 212, 213, 213, 214, 225, 214,
			225, 226, 226, 13, 227, 227, 228, 240, 228, 240,
			241, 241, 229, 244, 245, 246, 229, 244, 245, 246,
			242, 243, 247, 242, 243, 247, 230, 231, 231, 248,
			249, 249, 232, 233, 232, 233, 234, 235, 236, 237,
			238, 238, 239, 250, 239, 250, 251, 251, 14, 252,
			252, 253, 265, 253, 265, 266, 266, 254, 269, 270,
			271, 254, 269, 270, 271, 267, 268, 272, 267, 268,
			272, 255, 256, 256, 273, 274, 274, 257, 258, 257,
			258, 259, 260, 261, 262, 263, 263, 264, 275, 264,
			275, 276, 276, 15, 281, 15, 281, 277, 277, 278,
			290, 278, 290, 291, 291, 279, 294, 295, 296, 279,
			294, 295, 296, 292, 293, 297, 292, 293, 297, 280,
			298, 299, 299, 282, 283, 282, 283, 284, 285, 286,
			287, 288, 288, 289, 300, 289, 301, 301, 16
		});
		deviceBuilder.Finish();
	}

	private TouchControl Initialize_ctrlTouchscreenprimaryTouch(InternedString kTouchLayout, InputControl parent)
	{
		TouchControl touchControl = new TouchControl();
		touchControl.Setup().At(this, 0).WithParent(parent)
			.WithChildren(17, 13)
			.WithName("primaryTouch")
			.WithDisplayName("Primary Touch")
			.WithLayout(kTouchLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1414485315),
				byteOffset = 0u,
				bitOffset = 0u,
				sizeInBits = 448u
			})
			.Finish();
		return touchControl;
	}

	private Vector2Control Initialize_ctrlTouchscreenposition(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 1).WithParent(parent)
			.WithChildren(42, 2)
			.WithName("position")
			.WithDisplayName("Position")
			.WithLayout(kVector2Layout)
			.WithUsages(1, 1)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 4u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private DeltaControl Initialize_ctrlTouchscreendelta(InternedString kDeltaLayout, InputControl parent)
	{
		DeltaControl deltaControl = new DeltaControl();
		deltaControl.Setup().At(this, 2).WithParent(parent)
			.WithChildren(44, 6)
			.WithName("delta")
			.WithDisplayName("Delta")
			.WithLayout(kDeltaLayout)
			.WithUsages(2, 1)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 12u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return deltaControl;
	}

	private AxisControl Initialize_ctrlTouchscreenpressure(InternedString kAnalogLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 3).WithParent(parent)
			.WithName("pressure")
			.WithDisplayName("Pressure")
			.WithLayout(kAnalogLayout)
			.WithUsages(3, 1)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 20u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.WithDefaultState(1)
			.Finish();
		return axisControl;
	}

	private Vector2Control Initialize_ctrlTouchscreenradius(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 4).WithParent(parent)
			.WithChildren(50, 2)
			.WithName("radius")
			.WithDisplayName("Radius")
			.WithLayout(kVector2Layout)
			.WithUsages(4, 1)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 24u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private TouchPressControl Initialize_ctrlTouchscreenpress(InternedString kTouchPressLayout, InputControl parent)
	{
		TouchPressControl touchPressControl = new TouchPressControl();
		touchPressControl.Setup().At(this, 5).WithParent(parent)
			.WithName("press")
			.WithDisplayName("Press")
			.WithLayout(kTouchPressLayout)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 32u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return touchPressControl;
	}

	private TouchControl Initialize_ctrlTouchscreentouch0(InternedString kTouchLayout, InputControl parent)
	{
		TouchControl touchControl = new TouchControl();
		touchControl.Setup().At(this, 6).WithParent(parent)
			.WithChildren(52, 13)
			.WithName("touch0")
			.WithDisplayName("Touch")
			.WithLayout(kTouchLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1414485315),
				byteOffset = 56u,
				bitOffset = 0u,
				sizeInBits = 448u
			})
			.Finish();
		return touchControl;
	}

	private TouchControl Initialize_ctrlTouchscreentouch1(InternedString kTouchLayout, InputControl parent)
	{
		TouchControl touchControl = new TouchControl();
		touchControl.Setup().At(this, 7).WithParent(parent)
			.WithChildren(77, 13)
			.WithName("touch1")
			.WithDisplayName("Touch")
			.WithLayout(kTouchLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1414485315),
				byteOffset = 112u,
				bitOffset = 0u,
				sizeInBits = 448u
			})
			.Finish();
		return touchControl;
	}

	private TouchControl Initialize_ctrlTouchscreentouch2(InternedString kTouchLayout, InputControl parent)
	{
		TouchControl touchControl = new TouchControl();
		touchControl.Setup().At(this, 8).WithParent(parent)
			.WithChildren(102, 13)
			.WithName("touch2")
			.WithDisplayName("Touch")
			.WithLayout(kTouchLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1414485315),
				byteOffset = 168u,
				bitOffset = 0u,
				sizeInBits = 448u
			})
			.Finish();
		return touchControl;
	}

	private TouchControl Initialize_ctrlTouchscreentouch3(InternedString kTouchLayout, InputControl parent)
	{
		TouchControl touchControl = new TouchControl();
		touchControl.Setup().At(this, 9).WithParent(parent)
			.WithChildren(127, 13)
			.WithName("touch3")
			.WithDisplayName("Touch")
			.WithLayout(kTouchLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1414485315),
				byteOffset = 224u,
				bitOffset = 0u,
				sizeInBits = 448u
			})
			.Finish();
		return touchControl;
	}

	private TouchControl Initialize_ctrlTouchscreentouch4(InternedString kTouchLayout, InputControl parent)
	{
		TouchControl touchControl = new TouchControl();
		touchControl.Setup().At(this, 10).WithParent(parent)
			.WithChildren(152, 13)
			.WithName("touch4")
			.WithDisplayName("Touch")
			.WithLayout(kTouchLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1414485315),
				byteOffset = 280u,
				bitOffset = 0u,
				sizeInBits = 448u
			})
			.Finish();
		return touchControl;
	}

	private TouchControl Initialize_ctrlTouchscreentouch5(InternedString kTouchLayout, InputControl parent)
	{
		TouchControl touchControl = new TouchControl();
		touchControl.Setup().At(this, 11).WithParent(parent)
			.WithChildren(177, 13)
			.WithName("touch5")
			.WithDisplayName("Touch")
			.WithLayout(kTouchLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1414485315),
				byteOffset = 336u,
				bitOffset = 0u,
				sizeInBits = 448u
			})
			.Finish();
		return touchControl;
	}

	private TouchControl Initialize_ctrlTouchscreentouch6(InternedString kTouchLayout, InputControl parent)
	{
		TouchControl touchControl = new TouchControl();
		touchControl.Setup().At(this, 12).WithParent(parent)
			.WithChildren(202, 13)
			.WithName("touch6")
			.WithDisplayName("Touch")
			.WithLayout(kTouchLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1414485315),
				byteOffset = 392u,
				bitOffset = 0u,
				sizeInBits = 448u
			})
			.Finish();
		return touchControl;
	}

	private TouchControl Initialize_ctrlTouchscreentouch7(InternedString kTouchLayout, InputControl parent)
	{
		TouchControl touchControl = new TouchControl();
		touchControl.Setup().At(this, 13).WithParent(parent)
			.WithChildren(227, 13)
			.WithName("touch7")
			.WithDisplayName("Touch")
			.WithLayout(kTouchLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1414485315),
				byteOffset = 448u,
				bitOffset = 0u,
				sizeInBits = 448u
			})
			.Finish();
		return touchControl;
	}

	private TouchControl Initialize_ctrlTouchscreentouch8(InternedString kTouchLayout, InputControl parent)
	{
		TouchControl touchControl = new TouchControl();
		touchControl.Setup().At(this, 14).WithParent(parent)
			.WithChildren(252, 13)
			.WithName("touch8")
			.WithDisplayName("Touch")
			.WithLayout(kTouchLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1414485315),
				byteOffset = 504u,
				bitOffset = 0u,
				sizeInBits = 448u
			})
			.Finish();
		return touchControl;
	}

	private TouchControl Initialize_ctrlTouchscreentouch9(InternedString kTouchLayout, InputControl parent)
	{
		TouchControl touchControl = new TouchControl();
		touchControl.Setup().At(this, 15).WithParent(parent)
			.WithChildren(277, 13)
			.WithName("touch9")
			.WithDisplayName("Touch")
			.WithLayout(kTouchLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1414485315),
				byteOffset = 560u,
				bitOffset = 0u,
				sizeInBits = 448u
			})
			.Finish();
		return touchControl;
	}

	private IntegerControl Initialize_ctrlTouchscreendisplayIndex(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 16).WithParent(parent)
			.WithName("displayIndex")
			.WithDisplayName("Display Index")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1431521364),
				byteOffset = 34u,
				bitOffset = 0u,
				sizeInBits = 16u
			})
			.Finish();
		return integerControl;
	}

	private IntegerControl Initialize_ctrlTouchscreenprimaryTouchtouchId(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 17).WithParent(parent)
			.WithName("touchId")
			.WithDisplayName("Primary Touch Touch ID")
			.WithShortDisplayName("Primary Touch Touch ID")
			.WithLayout(kIntegerLayout)
			.IsSynthetic(value: true)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1229870112),
				byteOffset = 0u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return integerControl;
	}

	private Vector2Control Initialize_ctrlTouchscreenprimaryTouchposition(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 18).WithParent(parent)
			.WithChildren(30, 2)
			.WithName("position")
			.WithDisplayName("Primary Touch Position")
			.WithShortDisplayName("Primary Touch Position")
			.WithLayout(kVector2Layout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 4u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private DeltaControl Initialize_ctrlTouchscreenprimaryTouchdelta(InternedString kDeltaLayout, InputControl parent)
	{
		DeltaControl deltaControl = new DeltaControl();
		deltaControl.Setup().At(this, 19).WithParent(parent)
			.WithChildren(32, 6)
			.WithName("delta")
			.WithDisplayName("Primary Touch Delta")
			.WithShortDisplayName("Primary Touch Delta")
			.WithLayout(kDeltaLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 12u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return deltaControl;
	}

	private AxisControl Initialize_ctrlTouchscreenprimaryTouchpressure(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 20).WithParent(parent)
			.WithName("pressure")
			.WithDisplayName("Primary Touch Pressure")
			.WithShortDisplayName("Primary Touch Pressure")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 20u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private Vector2Control Initialize_ctrlTouchscreenprimaryTouchradius(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 21).WithParent(parent)
			.WithChildren(38, 2)
			.WithName("radius")
			.WithDisplayName("Primary Touch Radius")
			.WithShortDisplayName("Primary Touch Radius")
			.WithLayout(kVector2Layout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 24u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private TouchPhaseControl Initialize_ctrlTouchscreenprimaryTouchphase(InternedString kTouchPhaseLayout, InputControl parent)
	{
		TouchPhaseControl touchPhaseControl = new TouchPhaseControl();
		touchPhaseControl.Setup().At(this, 22).WithParent(parent)
			.WithName("phase")
			.WithDisplayName("Primary Touch Touch Phase")
			.WithShortDisplayName("Primary Touch Touch Phase")
			.WithLayout(kTouchPhaseLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 32u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return touchPhaseControl;
	}

	private TouchPressControl Initialize_ctrlTouchscreenprimaryTouchpress(InternedString kTouchPressLayout, InputControl parent)
	{
		TouchPressControl touchPressControl = new TouchPressControl();
		touchPressControl.Setup().At(this, 23).WithParent(parent)
			.WithName("press")
			.WithDisplayName("Primary Touch Touch Contact?")
			.WithShortDisplayName("Primary Touch Touch Contact?")
			.WithLayout(kTouchPressLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 32u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return touchPressControl;
	}

	private IntegerControl Initialize_ctrlTouchscreenprimaryTouchtapCount(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 24).WithParent(parent)
			.WithName("tapCount")
			.WithDisplayName("Primary Touch Tap Count")
			.WithShortDisplayName("Primary Touch Tap Count")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 33u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private IntegerControl Initialize_ctrlTouchscreenprimaryTouchdisplayIndex(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 25).WithParent(parent)
			.WithName("displayIndex")
			.WithDisplayName("Primary Touch Display Index")
			.WithShortDisplayName("Primary Touch Display Index")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 34u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private ButtonControl Initialize_ctrlTouchscreenprimaryTouchindirectTouch(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 26).WithParent(parent)
			.WithName("indirectTouch")
			.WithDisplayName("Primary Touch Indirect Touch?")
			.WithShortDisplayName("Primary Touch Indirect Touch?")
			.WithLayout(kButtonLayout)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 35u,
				bitOffset = 0u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlTouchscreenprimaryTouchtap(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 27).WithParent(parent)
			.WithName("tap")
			.WithDisplayName("Primary Touch Tap")
			.WithShortDisplayName("Primary Touch Tap")
			.WithLayout(kButtonLayout)
			.WithUsages(0, 1)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 35u,
				bitOffset = 4u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private DoubleControl Initialize_ctrlTouchscreenprimaryTouchstartTime(InternedString kDoubleLayout, InputControl parent)
	{
		DoubleControl doubleControl = new DoubleControl();
		doubleControl.Setup().At(this, 28).WithParent(parent)
			.WithName("startTime")
			.WithDisplayName("Primary Touch Start Time")
			.WithShortDisplayName("Primary Touch Start Time")
			.WithLayout(kDoubleLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1145195552),
				byteOffset = 40u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return doubleControl;
	}

	private Vector2Control Initialize_ctrlTouchscreenprimaryTouchstartPosition(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 29).WithParent(parent)
			.WithChildren(40, 2)
			.WithName("startPosition")
			.WithDisplayName("Primary Touch Start Position")
			.WithShortDisplayName("Primary Touch Start Position")
			.WithLayout(kVector2Layout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 48u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private AxisControl Initialize_ctrlTouchscreenprimaryTouchpositionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 30).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Primary Touch Primary Touch Position X")
			.WithShortDisplayName("Primary Touch Primary Touch Position X")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 4u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreenprimaryTouchpositiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 31).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Primary Touch Primary Touch Position Y")
			.WithShortDisplayName("Primary Touch Primary Touch Position Y")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 8u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreenprimaryTouchdeltaup(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 32).WithParent(parent)
			.WithName("up")
			.WithDisplayName("Primary Touch Primary Touch Delta Up")
			.WithShortDisplayName("Primary Touch Primary Touch Delta Up")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 16u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreenprimaryTouchdeltadown(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 33).WithParent(parent)
			.WithName("down")
			.WithDisplayName("Primary Touch Primary Touch Delta Down")
			.WithShortDisplayName("Primary Touch Primary Touch Delta Down")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 16u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreenprimaryTouchdeltaleft(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 34).WithParent(parent)
			.WithName("left")
			.WithDisplayName("Primary Touch Primary Touch Delta Left")
			.WithShortDisplayName("Primary Touch Primary Touch Delta Left")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 12u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreenprimaryTouchdeltaright(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 35).WithParent(parent)
			.WithName("right")
			.WithDisplayName("Primary Touch Primary Touch Delta Right")
			.WithShortDisplayName("Primary Touch Primary Touch Delta Right")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 12u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreenprimaryTouchdeltax(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 36).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Primary Touch Primary Touch Delta X")
			.WithShortDisplayName("Primary Touch Primary Touch Delta X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 12u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreenprimaryTouchdeltay(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 37).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Primary Touch Primary Touch Delta Y")
			.WithShortDisplayName("Primary Touch Primary Touch Delta Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 16u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreenprimaryTouchradiusx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 38).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Primary Touch Primary Touch Radius X")
			.WithShortDisplayName("Primary Touch Primary Touch Radius X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 24u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreenprimaryTouchradiusy(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 39).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Primary Touch Primary Touch Radius Y")
			.WithShortDisplayName("Primary Touch Primary Touch Radius Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 28u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreenprimaryTouchstartPositionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 40).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Primary Touch Primary Touch Start Position X")
			.WithShortDisplayName("Primary Touch Primary Touch Start Position X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 48u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreenprimaryTouchstartPositiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 41).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Primary Touch Primary Touch Start Position Y")
			.WithShortDisplayName("Primary Touch Primary Touch Start Position Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 52u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreenpositionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 42).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Position X")
			.WithShortDisplayName("Position X")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 4u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreenpositiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 43).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Position Y")
			.WithShortDisplayName("Position Y")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 8u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreendeltaup(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 44).WithParent(parent)
			.WithName("up")
			.WithDisplayName("Delta Up")
			.WithShortDisplayName("Delta Up")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 16u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreendeltadown(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 45).WithParent(parent)
			.WithName("down")
			.WithDisplayName("Delta Down")
			.WithShortDisplayName("Delta Down")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 16u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreendeltaleft(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 46).WithParent(parent)
			.WithName("left")
			.WithDisplayName("Delta Left")
			.WithShortDisplayName("Delta Left")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 12u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreendeltaright(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 47).WithParent(parent)
			.WithName("right")
			.WithDisplayName("Delta Right")
			.WithShortDisplayName("Delta Right")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 12u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreendeltax(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 48).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Delta X")
			.WithShortDisplayName("Delta X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 12u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreendeltay(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 49).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Delta Y")
			.WithShortDisplayName("Delta Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 16u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreenradiusx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 50).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Radius X")
			.WithShortDisplayName("Radius X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 24u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreenradiusy(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 51).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Radius Y")
			.WithShortDisplayName("Radius Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 28u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch0touchId(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 52).WithParent(parent)
			.WithName("touchId")
			.WithDisplayName("Touch Touch ID")
			.WithShortDisplayName("Touch Touch ID")
			.WithLayout(kIntegerLayout)
			.IsSynthetic(value: true)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1229870112),
				byteOffset = 56u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return integerControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch0position(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 53).WithParent(parent)
			.WithChildren(65, 2)
			.WithName("position")
			.WithDisplayName("Touch Position")
			.WithShortDisplayName("Touch Position")
			.WithLayout(kVector2Layout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 60u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private DeltaControl Initialize_ctrlTouchscreentouch0delta(InternedString kDeltaLayout, InputControl parent)
	{
		DeltaControl deltaControl = new DeltaControl();
		deltaControl.Setup().At(this, 54).WithParent(parent)
			.WithChildren(67, 6)
			.WithName("delta")
			.WithDisplayName("Touch Delta")
			.WithShortDisplayName("Touch Delta")
			.WithLayout(kDeltaLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 68u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return deltaControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch0pressure(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 55).WithParent(parent)
			.WithName("pressure")
			.WithDisplayName("Touch Pressure")
			.WithShortDisplayName("Touch Pressure")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 76u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch0radius(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 56).WithParent(parent)
			.WithChildren(73, 2)
			.WithName("radius")
			.WithDisplayName("Touch Radius")
			.WithShortDisplayName("Touch Radius")
			.WithLayout(kVector2Layout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 80u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private TouchPhaseControl Initialize_ctrlTouchscreentouch0phase(InternedString kTouchPhaseLayout, InputControl parent)
	{
		TouchPhaseControl touchPhaseControl = new TouchPhaseControl();
		touchPhaseControl.Setup().At(this, 57).WithParent(parent)
			.WithName("phase")
			.WithDisplayName("Touch Touch Phase")
			.WithShortDisplayName("Touch Touch Phase")
			.WithLayout(kTouchPhaseLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 88u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return touchPhaseControl;
	}

	private TouchPressControl Initialize_ctrlTouchscreentouch0press(InternedString kTouchPressLayout, InputControl parent)
	{
		TouchPressControl touchPressControl = new TouchPressControl();
		touchPressControl.Setup().At(this, 58).WithParent(parent)
			.WithName("press")
			.WithDisplayName("Touch Touch Contact?")
			.WithShortDisplayName("Touch Touch Contact?")
			.WithLayout(kTouchPressLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 88u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return touchPressControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch0tapCount(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 59).WithParent(parent)
			.WithName("tapCount")
			.WithDisplayName("Touch Tap Count")
			.WithShortDisplayName("Touch Tap Count")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 89u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch0displayIndex(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 60).WithParent(parent)
			.WithName("displayIndex")
			.WithDisplayName("Touch Display Index")
			.WithShortDisplayName("Touch Display Index")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 90u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch0indirectTouch(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 61).WithParent(parent)
			.WithName("indirectTouch")
			.WithDisplayName("Touch Indirect Touch?")
			.WithShortDisplayName("Touch Indirect Touch?")
			.WithLayout(kButtonLayout)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 91u,
				bitOffset = 0u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch0tap(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 62).WithParent(parent)
			.WithName("tap")
			.WithDisplayName("Touch Tap")
			.WithShortDisplayName("Touch Tap")
			.WithLayout(kButtonLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 91u,
				bitOffset = 4u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private DoubleControl Initialize_ctrlTouchscreentouch0startTime(InternedString kDoubleLayout, InputControl parent)
	{
		DoubleControl doubleControl = new DoubleControl();
		doubleControl.Setup().At(this, 63).WithParent(parent)
			.WithName("startTime")
			.WithDisplayName("Touch Start Time")
			.WithShortDisplayName("Touch Start Time")
			.WithLayout(kDoubleLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1145195552),
				byteOffset = 96u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return doubleControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch0startPosition(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 64).WithParent(parent)
			.WithChildren(75, 2)
			.WithName("startPosition")
			.WithDisplayName("Touch Start Position")
			.WithShortDisplayName("Touch Start Position")
			.WithLayout(kVector2Layout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 104u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private AxisControl Initialize_ctrlTouchscreentouch0positionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 65).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Position X")
			.WithShortDisplayName("Touch Touch Position X")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 60u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch0positiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 66).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Position Y")
			.WithShortDisplayName("Touch Touch Position Y")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 64u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch0deltaup(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 67).WithParent(parent)
			.WithName("up")
			.WithDisplayName("Touch Touch Delta Up")
			.WithShortDisplayName("Touch Touch Delta Up")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 72u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch0deltadown(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 68).WithParent(parent)
			.WithName("down")
			.WithDisplayName("Touch Touch Delta Down")
			.WithShortDisplayName("Touch Touch Delta Down")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 72u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch0deltaleft(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 69).WithParent(parent)
			.WithName("left")
			.WithDisplayName("Touch Touch Delta Left")
			.WithShortDisplayName("Touch Touch Delta Left")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 68u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch0deltaright(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 70).WithParent(parent)
			.WithName("right")
			.WithDisplayName("Touch Touch Delta Right")
			.WithShortDisplayName("Touch Touch Delta Right")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 68u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch0deltax(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 71).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Delta X")
			.WithShortDisplayName("Touch Touch Delta X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 68u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch0deltay(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 72).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Delta Y")
			.WithShortDisplayName("Touch Touch Delta Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 72u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch0radiusx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 73).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Radius X")
			.WithShortDisplayName("Touch Touch Radius X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 80u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch0radiusy(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 74).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Radius Y")
			.WithShortDisplayName("Touch Touch Radius Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 84u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch0startPositionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 75).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Start Position X")
			.WithShortDisplayName("Touch Touch Start Position X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 104u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch0startPositiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 76).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Start Position Y")
			.WithShortDisplayName("Touch Touch Start Position Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 108u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch1touchId(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 77).WithParent(parent)
			.WithName("touchId")
			.WithDisplayName("Touch Touch ID")
			.WithShortDisplayName("Touch Touch ID")
			.WithLayout(kIntegerLayout)
			.IsSynthetic(value: true)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1229870112),
				byteOffset = 112u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return integerControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch1position(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 78).WithParent(parent)
			.WithChildren(90, 2)
			.WithName("position")
			.WithDisplayName("Touch Position")
			.WithShortDisplayName("Touch Position")
			.WithLayout(kVector2Layout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 116u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private DeltaControl Initialize_ctrlTouchscreentouch1delta(InternedString kDeltaLayout, InputControl parent)
	{
		DeltaControl deltaControl = new DeltaControl();
		deltaControl.Setup().At(this, 79).WithParent(parent)
			.WithChildren(92, 6)
			.WithName("delta")
			.WithDisplayName("Touch Delta")
			.WithShortDisplayName("Touch Delta")
			.WithLayout(kDeltaLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 124u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return deltaControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch1pressure(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 80).WithParent(parent)
			.WithName("pressure")
			.WithDisplayName("Touch Pressure")
			.WithShortDisplayName("Touch Pressure")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 132u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch1radius(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 81).WithParent(parent)
			.WithChildren(98, 2)
			.WithName("radius")
			.WithDisplayName("Touch Radius")
			.WithShortDisplayName("Touch Radius")
			.WithLayout(kVector2Layout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 136u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private TouchPhaseControl Initialize_ctrlTouchscreentouch1phase(InternedString kTouchPhaseLayout, InputControl parent)
	{
		TouchPhaseControl touchPhaseControl = new TouchPhaseControl();
		touchPhaseControl.Setup().At(this, 82).WithParent(parent)
			.WithName("phase")
			.WithDisplayName("Touch Touch Phase")
			.WithShortDisplayName("Touch Touch Phase")
			.WithLayout(kTouchPhaseLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 144u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return touchPhaseControl;
	}

	private TouchPressControl Initialize_ctrlTouchscreentouch1press(InternedString kTouchPressLayout, InputControl parent)
	{
		TouchPressControl touchPressControl = new TouchPressControl();
		touchPressControl.Setup().At(this, 83).WithParent(parent)
			.WithName("press")
			.WithDisplayName("Touch Touch Contact?")
			.WithShortDisplayName("Touch Touch Contact?")
			.WithLayout(kTouchPressLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 144u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return touchPressControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch1tapCount(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 84).WithParent(parent)
			.WithName("tapCount")
			.WithDisplayName("Touch Tap Count")
			.WithShortDisplayName("Touch Tap Count")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 145u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch1displayIndex(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 85).WithParent(parent)
			.WithName("displayIndex")
			.WithDisplayName("Touch Display Index")
			.WithShortDisplayName("Touch Display Index")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 146u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch1indirectTouch(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 86).WithParent(parent)
			.WithName("indirectTouch")
			.WithDisplayName("Touch Indirect Touch?")
			.WithShortDisplayName("Touch Indirect Touch?")
			.WithLayout(kButtonLayout)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 147u,
				bitOffset = 0u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch1tap(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 87).WithParent(parent)
			.WithName("tap")
			.WithDisplayName("Touch Tap")
			.WithShortDisplayName("Touch Tap")
			.WithLayout(kButtonLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 147u,
				bitOffset = 4u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private DoubleControl Initialize_ctrlTouchscreentouch1startTime(InternedString kDoubleLayout, InputControl parent)
	{
		DoubleControl doubleControl = new DoubleControl();
		doubleControl.Setup().At(this, 88).WithParent(parent)
			.WithName("startTime")
			.WithDisplayName("Touch Start Time")
			.WithShortDisplayName("Touch Start Time")
			.WithLayout(kDoubleLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1145195552),
				byteOffset = 152u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return doubleControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch1startPosition(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 89).WithParent(parent)
			.WithChildren(100, 2)
			.WithName("startPosition")
			.WithDisplayName("Touch Start Position")
			.WithShortDisplayName("Touch Start Position")
			.WithLayout(kVector2Layout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 160u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private AxisControl Initialize_ctrlTouchscreentouch1positionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 90).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Position X")
			.WithShortDisplayName("Touch Touch Position X")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 116u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch1positiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 91).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Position Y")
			.WithShortDisplayName("Touch Touch Position Y")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 120u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch1deltaup(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 92).WithParent(parent)
			.WithName("up")
			.WithDisplayName("Touch Touch Delta Up")
			.WithShortDisplayName("Touch Touch Delta Up")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 128u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch1deltadown(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 93).WithParent(parent)
			.WithName("down")
			.WithDisplayName("Touch Touch Delta Down")
			.WithShortDisplayName("Touch Touch Delta Down")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 128u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch1deltaleft(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 94).WithParent(parent)
			.WithName("left")
			.WithDisplayName("Touch Touch Delta Left")
			.WithShortDisplayName("Touch Touch Delta Left")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 124u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch1deltaright(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 95).WithParent(parent)
			.WithName("right")
			.WithDisplayName("Touch Touch Delta Right")
			.WithShortDisplayName("Touch Touch Delta Right")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 124u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch1deltax(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 96).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Delta X")
			.WithShortDisplayName("Touch Touch Delta X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 124u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch1deltay(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 97).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Delta Y")
			.WithShortDisplayName("Touch Touch Delta Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 128u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch1radiusx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 98).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Radius X")
			.WithShortDisplayName("Touch Touch Radius X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 136u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch1radiusy(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 99).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Radius Y")
			.WithShortDisplayName("Touch Touch Radius Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 140u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch1startPositionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 100).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Start Position X")
			.WithShortDisplayName("Touch Touch Start Position X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 160u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch1startPositiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 101).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Start Position Y")
			.WithShortDisplayName("Touch Touch Start Position Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 164u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch2touchId(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 102).WithParent(parent)
			.WithName("touchId")
			.WithDisplayName("Touch Touch ID")
			.WithShortDisplayName("Touch Touch ID")
			.WithLayout(kIntegerLayout)
			.IsSynthetic(value: true)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1229870112),
				byteOffset = 168u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return integerControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch2position(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 103).WithParent(parent)
			.WithChildren(115, 2)
			.WithName("position")
			.WithDisplayName("Touch Position")
			.WithShortDisplayName("Touch Position")
			.WithLayout(kVector2Layout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 172u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private DeltaControl Initialize_ctrlTouchscreentouch2delta(InternedString kDeltaLayout, InputControl parent)
	{
		DeltaControl deltaControl = new DeltaControl();
		deltaControl.Setup().At(this, 104).WithParent(parent)
			.WithChildren(117, 6)
			.WithName("delta")
			.WithDisplayName("Touch Delta")
			.WithShortDisplayName("Touch Delta")
			.WithLayout(kDeltaLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 180u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return deltaControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch2pressure(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 105).WithParent(parent)
			.WithName("pressure")
			.WithDisplayName("Touch Pressure")
			.WithShortDisplayName("Touch Pressure")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 188u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch2radius(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 106).WithParent(parent)
			.WithChildren(123, 2)
			.WithName("radius")
			.WithDisplayName("Touch Radius")
			.WithShortDisplayName("Touch Radius")
			.WithLayout(kVector2Layout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 192u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private TouchPhaseControl Initialize_ctrlTouchscreentouch2phase(InternedString kTouchPhaseLayout, InputControl parent)
	{
		TouchPhaseControl touchPhaseControl = new TouchPhaseControl();
		touchPhaseControl.Setup().At(this, 107).WithParent(parent)
			.WithName("phase")
			.WithDisplayName("Touch Touch Phase")
			.WithShortDisplayName("Touch Touch Phase")
			.WithLayout(kTouchPhaseLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 200u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return touchPhaseControl;
	}

	private TouchPressControl Initialize_ctrlTouchscreentouch2press(InternedString kTouchPressLayout, InputControl parent)
	{
		TouchPressControl touchPressControl = new TouchPressControl();
		touchPressControl.Setup().At(this, 108).WithParent(parent)
			.WithName("press")
			.WithDisplayName("Touch Touch Contact?")
			.WithShortDisplayName("Touch Touch Contact?")
			.WithLayout(kTouchPressLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 200u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return touchPressControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch2tapCount(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 109).WithParent(parent)
			.WithName("tapCount")
			.WithDisplayName("Touch Tap Count")
			.WithShortDisplayName("Touch Tap Count")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 201u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch2displayIndex(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 110).WithParent(parent)
			.WithName("displayIndex")
			.WithDisplayName("Touch Display Index")
			.WithShortDisplayName("Touch Display Index")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 202u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch2indirectTouch(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 111).WithParent(parent)
			.WithName("indirectTouch")
			.WithDisplayName("Touch Indirect Touch?")
			.WithShortDisplayName("Touch Indirect Touch?")
			.WithLayout(kButtonLayout)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 203u,
				bitOffset = 0u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch2tap(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 112).WithParent(parent)
			.WithName("tap")
			.WithDisplayName("Touch Tap")
			.WithShortDisplayName("Touch Tap")
			.WithLayout(kButtonLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 203u,
				bitOffset = 4u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private DoubleControl Initialize_ctrlTouchscreentouch2startTime(InternedString kDoubleLayout, InputControl parent)
	{
		DoubleControl doubleControl = new DoubleControl();
		doubleControl.Setup().At(this, 113).WithParent(parent)
			.WithName("startTime")
			.WithDisplayName("Touch Start Time")
			.WithShortDisplayName("Touch Start Time")
			.WithLayout(kDoubleLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1145195552),
				byteOffset = 208u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return doubleControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch2startPosition(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 114).WithParent(parent)
			.WithChildren(125, 2)
			.WithName("startPosition")
			.WithDisplayName("Touch Start Position")
			.WithShortDisplayName("Touch Start Position")
			.WithLayout(kVector2Layout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 216u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private AxisControl Initialize_ctrlTouchscreentouch2positionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 115).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Position X")
			.WithShortDisplayName("Touch Touch Position X")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 172u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch2positiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 116).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Position Y")
			.WithShortDisplayName("Touch Touch Position Y")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 176u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch2deltaup(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 117).WithParent(parent)
			.WithName("up")
			.WithDisplayName("Touch Touch Delta Up")
			.WithShortDisplayName("Touch Touch Delta Up")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 184u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch2deltadown(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 118).WithParent(parent)
			.WithName("down")
			.WithDisplayName("Touch Touch Delta Down")
			.WithShortDisplayName("Touch Touch Delta Down")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 184u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch2deltaleft(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 119).WithParent(parent)
			.WithName("left")
			.WithDisplayName("Touch Touch Delta Left")
			.WithShortDisplayName("Touch Touch Delta Left")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 180u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch2deltaright(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 120).WithParent(parent)
			.WithName("right")
			.WithDisplayName("Touch Touch Delta Right")
			.WithShortDisplayName("Touch Touch Delta Right")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 180u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch2deltax(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 121).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Delta X")
			.WithShortDisplayName("Touch Touch Delta X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 180u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch2deltay(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 122).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Delta Y")
			.WithShortDisplayName("Touch Touch Delta Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 184u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch2radiusx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 123).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Radius X")
			.WithShortDisplayName("Touch Touch Radius X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 192u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch2radiusy(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 124).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Radius Y")
			.WithShortDisplayName("Touch Touch Radius Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 196u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch2startPositionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 125).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Start Position X")
			.WithShortDisplayName("Touch Touch Start Position X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 216u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch2startPositiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 126).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Start Position Y")
			.WithShortDisplayName("Touch Touch Start Position Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 220u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch3touchId(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 127).WithParent(parent)
			.WithName("touchId")
			.WithDisplayName("Touch Touch ID")
			.WithShortDisplayName("Touch Touch ID")
			.WithLayout(kIntegerLayout)
			.IsSynthetic(value: true)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1229870112),
				byteOffset = 224u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return integerControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch3position(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 128).WithParent(parent)
			.WithChildren(140, 2)
			.WithName("position")
			.WithDisplayName("Touch Position")
			.WithShortDisplayName("Touch Position")
			.WithLayout(kVector2Layout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 228u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private DeltaControl Initialize_ctrlTouchscreentouch3delta(InternedString kDeltaLayout, InputControl parent)
	{
		DeltaControl deltaControl = new DeltaControl();
		deltaControl.Setup().At(this, 129).WithParent(parent)
			.WithChildren(142, 6)
			.WithName("delta")
			.WithDisplayName("Touch Delta")
			.WithShortDisplayName("Touch Delta")
			.WithLayout(kDeltaLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 236u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return deltaControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch3pressure(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 130).WithParent(parent)
			.WithName("pressure")
			.WithDisplayName("Touch Pressure")
			.WithShortDisplayName("Touch Pressure")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 244u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch3radius(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 131).WithParent(parent)
			.WithChildren(148, 2)
			.WithName("radius")
			.WithDisplayName("Touch Radius")
			.WithShortDisplayName("Touch Radius")
			.WithLayout(kVector2Layout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 248u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private TouchPhaseControl Initialize_ctrlTouchscreentouch3phase(InternedString kTouchPhaseLayout, InputControl parent)
	{
		TouchPhaseControl touchPhaseControl = new TouchPhaseControl();
		touchPhaseControl.Setup().At(this, 132).WithParent(parent)
			.WithName("phase")
			.WithDisplayName("Touch Touch Phase")
			.WithShortDisplayName("Touch Touch Phase")
			.WithLayout(kTouchPhaseLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 256u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return touchPhaseControl;
	}

	private TouchPressControl Initialize_ctrlTouchscreentouch3press(InternedString kTouchPressLayout, InputControl parent)
	{
		TouchPressControl touchPressControl = new TouchPressControl();
		touchPressControl.Setup().At(this, 133).WithParent(parent)
			.WithName("press")
			.WithDisplayName("Touch Touch Contact?")
			.WithShortDisplayName("Touch Touch Contact?")
			.WithLayout(kTouchPressLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 256u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return touchPressControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch3tapCount(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 134).WithParent(parent)
			.WithName("tapCount")
			.WithDisplayName("Touch Tap Count")
			.WithShortDisplayName("Touch Tap Count")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 257u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch3displayIndex(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 135).WithParent(parent)
			.WithName("displayIndex")
			.WithDisplayName("Touch Display Index")
			.WithShortDisplayName("Touch Display Index")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 258u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch3indirectTouch(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 136).WithParent(parent)
			.WithName("indirectTouch")
			.WithDisplayName("Touch Indirect Touch?")
			.WithShortDisplayName("Touch Indirect Touch?")
			.WithLayout(kButtonLayout)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 259u,
				bitOffset = 0u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch3tap(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 137).WithParent(parent)
			.WithName("tap")
			.WithDisplayName("Touch Tap")
			.WithShortDisplayName("Touch Tap")
			.WithLayout(kButtonLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 259u,
				bitOffset = 4u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private DoubleControl Initialize_ctrlTouchscreentouch3startTime(InternedString kDoubleLayout, InputControl parent)
	{
		DoubleControl doubleControl = new DoubleControl();
		doubleControl.Setup().At(this, 138).WithParent(parent)
			.WithName("startTime")
			.WithDisplayName("Touch Start Time")
			.WithShortDisplayName("Touch Start Time")
			.WithLayout(kDoubleLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1145195552),
				byteOffset = 264u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return doubleControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch3startPosition(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 139).WithParent(parent)
			.WithChildren(150, 2)
			.WithName("startPosition")
			.WithDisplayName("Touch Start Position")
			.WithShortDisplayName("Touch Start Position")
			.WithLayout(kVector2Layout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 272u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private AxisControl Initialize_ctrlTouchscreentouch3positionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 140).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Position X")
			.WithShortDisplayName("Touch Touch Position X")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 228u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch3positiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 141).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Position Y")
			.WithShortDisplayName("Touch Touch Position Y")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 232u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch3deltaup(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 142).WithParent(parent)
			.WithName("up")
			.WithDisplayName("Touch Touch Delta Up")
			.WithShortDisplayName("Touch Touch Delta Up")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 240u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch3deltadown(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 143).WithParent(parent)
			.WithName("down")
			.WithDisplayName("Touch Touch Delta Down")
			.WithShortDisplayName("Touch Touch Delta Down")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 240u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch3deltaleft(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 144).WithParent(parent)
			.WithName("left")
			.WithDisplayName("Touch Touch Delta Left")
			.WithShortDisplayName("Touch Touch Delta Left")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 236u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch3deltaright(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 145).WithParent(parent)
			.WithName("right")
			.WithDisplayName("Touch Touch Delta Right")
			.WithShortDisplayName("Touch Touch Delta Right")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 236u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch3deltax(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 146).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Delta X")
			.WithShortDisplayName("Touch Touch Delta X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 236u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch3deltay(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 147).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Delta Y")
			.WithShortDisplayName("Touch Touch Delta Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 240u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch3radiusx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 148).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Radius X")
			.WithShortDisplayName("Touch Touch Radius X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 248u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch3radiusy(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 149).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Radius Y")
			.WithShortDisplayName("Touch Touch Radius Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 252u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch3startPositionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 150).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Start Position X")
			.WithShortDisplayName("Touch Touch Start Position X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 272u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch3startPositiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 151).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Start Position Y")
			.WithShortDisplayName("Touch Touch Start Position Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 276u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch4touchId(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 152).WithParent(parent)
			.WithName("touchId")
			.WithDisplayName("Touch Touch ID")
			.WithShortDisplayName("Touch Touch ID")
			.WithLayout(kIntegerLayout)
			.IsSynthetic(value: true)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1229870112),
				byteOffset = 280u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return integerControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch4position(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 153).WithParent(parent)
			.WithChildren(165, 2)
			.WithName("position")
			.WithDisplayName("Touch Position")
			.WithShortDisplayName("Touch Position")
			.WithLayout(kVector2Layout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 284u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private DeltaControl Initialize_ctrlTouchscreentouch4delta(InternedString kDeltaLayout, InputControl parent)
	{
		DeltaControl deltaControl = new DeltaControl();
		deltaControl.Setup().At(this, 154).WithParent(parent)
			.WithChildren(167, 6)
			.WithName("delta")
			.WithDisplayName("Touch Delta")
			.WithShortDisplayName("Touch Delta")
			.WithLayout(kDeltaLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 292u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return deltaControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch4pressure(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 155).WithParent(parent)
			.WithName("pressure")
			.WithDisplayName("Touch Pressure")
			.WithShortDisplayName("Touch Pressure")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 300u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch4radius(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 156).WithParent(parent)
			.WithChildren(173, 2)
			.WithName("radius")
			.WithDisplayName("Touch Radius")
			.WithShortDisplayName("Touch Radius")
			.WithLayout(kVector2Layout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 304u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private TouchPhaseControl Initialize_ctrlTouchscreentouch4phase(InternedString kTouchPhaseLayout, InputControl parent)
	{
		TouchPhaseControl touchPhaseControl = new TouchPhaseControl();
		touchPhaseControl.Setup().At(this, 157).WithParent(parent)
			.WithName("phase")
			.WithDisplayName("Touch Touch Phase")
			.WithShortDisplayName("Touch Touch Phase")
			.WithLayout(kTouchPhaseLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 312u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return touchPhaseControl;
	}

	private TouchPressControl Initialize_ctrlTouchscreentouch4press(InternedString kTouchPressLayout, InputControl parent)
	{
		TouchPressControl touchPressControl = new TouchPressControl();
		touchPressControl.Setup().At(this, 158).WithParent(parent)
			.WithName("press")
			.WithDisplayName("Touch Touch Contact?")
			.WithShortDisplayName("Touch Touch Contact?")
			.WithLayout(kTouchPressLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 312u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return touchPressControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch4tapCount(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 159).WithParent(parent)
			.WithName("tapCount")
			.WithDisplayName("Touch Tap Count")
			.WithShortDisplayName("Touch Tap Count")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 313u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch4displayIndex(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 160).WithParent(parent)
			.WithName("displayIndex")
			.WithDisplayName("Touch Display Index")
			.WithShortDisplayName("Touch Display Index")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 314u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch4indirectTouch(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 161).WithParent(parent)
			.WithName("indirectTouch")
			.WithDisplayName("Touch Indirect Touch?")
			.WithShortDisplayName("Touch Indirect Touch?")
			.WithLayout(kButtonLayout)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 315u,
				bitOffset = 0u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch4tap(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 162).WithParent(parent)
			.WithName("tap")
			.WithDisplayName("Touch Tap")
			.WithShortDisplayName("Touch Tap")
			.WithLayout(kButtonLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 315u,
				bitOffset = 4u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private DoubleControl Initialize_ctrlTouchscreentouch4startTime(InternedString kDoubleLayout, InputControl parent)
	{
		DoubleControl doubleControl = new DoubleControl();
		doubleControl.Setup().At(this, 163).WithParent(parent)
			.WithName("startTime")
			.WithDisplayName("Touch Start Time")
			.WithShortDisplayName("Touch Start Time")
			.WithLayout(kDoubleLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1145195552),
				byteOffset = 320u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return doubleControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch4startPosition(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 164).WithParent(parent)
			.WithChildren(175, 2)
			.WithName("startPosition")
			.WithDisplayName("Touch Start Position")
			.WithShortDisplayName("Touch Start Position")
			.WithLayout(kVector2Layout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 328u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private AxisControl Initialize_ctrlTouchscreentouch4positionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 165).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Position X")
			.WithShortDisplayName("Touch Touch Position X")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 284u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch4positiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 166).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Position Y")
			.WithShortDisplayName("Touch Touch Position Y")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 288u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch4deltaup(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 167).WithParent(parent)
			.WithName("up")
			.WithDisplayName("Touch Touch Delta Up")
			.WithShortDisplayName("Touch Touch Delta Up")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 296u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch4deltadown(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 168).WithParent(parent)
			.WithName("down")
			.WithDisplayName("Touch Touch Delta Down")
			.WithShortDisplayName("Touch Touch Delta Down")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 296u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch4deltaleft(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 169).WithParent(parent)
			.WithName("left")
			.WithDisplayName("Touch Touch Delta Left")
			.WithShortDisplayName("Touch Touch Delta Left")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 292u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch4deltaright(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 170).WithParent(parent)
			.WithName("right")
			.WithDisplayName("Touch Touch Delta Right")
			.WithShortDisplayName("Touch Touch Delta Right")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 292u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch4deltax(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 171).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Delta X")
			.WithShortDisplayName("Touch Touch Delta X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 292u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch4deltay(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 172).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Delta Y")
			.WithShortDisplayName("Touch Touch Delta Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 296u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch4radiusx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 173).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Radius X")
			.WithShortDisplayName("Touch Touch Radius X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 304u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch4radiusy(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 174).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Radius Y")
			.WithShortDisplayName("Touch Touch Radius Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 308u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch4startPositionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 175).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Start Position X")
			.WithShortDisplayName("Touch Touch Start Position X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 328u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch4startPositiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 176).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Start Position Y")
			.WithShortDisplayName("Touch Touch Start Position Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 332u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch5touchId(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 177).WithParent(parent)
			.WithName("touchId")
			.WithDisplayName("Touch Touch ID")
			.WithShortDisplayName("Touch Touch ID")
			.WithLayout(kIntegerLayout)
			.IsSynthetic(value: true)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1229870112),
				byteOffset = 336u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return integerControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch5position(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 178).WithParent(parent)
			.WithChildren(190, 2)
			.WithName("position")
			.WithDisplayName("Touch Position")
			.WithShortDisplayName("Touch Position")
			.WithLayout(kVector2Layout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 340u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private DeltaControl Initialize_ctrlTouchscreentouch5delta(InternedString kDeltaLayout, InputControl parent)
	{
		DeltaControl deltaControl = new DeltaControl();
		deltaControl.Setup().At(this, 179).WithParent(parent)
			.WithChildren(192, 6)
			.WithName("delta")
			.WithDisplayName("Touch Delta")
			.WithShortDisplayName("Touch Delta")
			.WithLayout(kDeltaLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 348u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return deltaControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch5pressure(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 180).WithParent(parent)
			.WithName("pressure")
			.WithDisplayName("Touch Pressure")
			.WithShortDisplayName("Touch Pressure")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 356u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch5radius(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 181).WithParent(parent)
			.WithChildren(198, 2)
			.WithName("radius")
			.WithDisplayName("Touch Radius")
			.WithShortDisplayName("Touch Radius")
			.WithLayout(kVector2Layout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 360u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private TouchPhaseControl Initialize_ctrlTouchscreentouch5phase(InternedString kTouchPhaseLayout, InputControl parent)
	{
		TouchPhaseControl touchPhaseControl = new TouchPhaseControl();
		touchPhaseControl.Setup().At(this, 182).WithParent(parent)
			.WithName("phase")
			.WithDisplayName("Touch Touch Phase")
			.WithShortDisplayName("Touch Touch Phase")
			.WithLayout(kTouchPhaseLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 368u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return touchPhaseControl;
	}

	private TouchPressControl Initialize_ctrlTouchscreentouch5press(InternedString kTouchPressLayout, InputControl parent)
	{
		TouchPressControl touchPressControl = new TouchPressControl();
		touchPressControl.Setup().At(this, 183).WithParent(parent)
			.WithName("press")
			.WithDisplayName("Touch Touch Contact?")
			.WithShortDisplayName("Touch Touch Contact?")
			.WithLayout(kTouchPressLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 368u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return touchPressControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch5tapCount(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 184).WithParent(parent)
			.WithName("tapCount")
			.WithDisplayName("Touch Tap Count")
			.WithShortDisplayName("Touch Tap Count")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 369u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch5displayIndex(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 185).WithParent(parent)
			.WithName("displayIndex")
			.WithDisplayName("Touch Display Index")
			.WithShortDisplayName("Touch Display Index")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 370u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch5indirectTouch(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 186).WithParent(parent)
			.WithName("indirectTouch")
			.WithDisplayName("Touch Indirect Touch?")
			.WithShortDisplayName("Touch Indirect Touch?")
			.WithLayout(kButtonLayout)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 371u,
				bitOffset = 0u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch5tap(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 187).WithParent(parent)
			.WithName("tap")
			.WithDisplayName("Touch Tap")
			.WithShortDisplayName("Touch Tap")
			.WithLayout(kButtonLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 371u,
				bitOffset = 4u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private DoubleControl Initialize_ctrlTouchscreentouch5startTime(InternedString kDoubleLayout, InputControl parent)
	{
		DoubleControl doubleControl = new DoubleControl();
		doubleControl.Setup().At(this, 188).WithParent(parent)
			.WithName("startTime")
			.WithDisplayName("Touch Start Time")
			.WithShortDisplayName("Touch Start Time")
			.WithLayout(kDoubleLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1145195552),
				byteOffset = 376u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return doubleControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch5startPosition(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 189).WithParent(parent)
			.WithChildren(200, 2)
			.WithName("startPosition")
			.WithDisplayName("Touch Start Position")
			.WithShortDisplayName("Touch Start Position")
			.WithLayout(kVector2Layout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 384u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private AxisControl Initialize_ctrlTouchscreentouch5positionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 190).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Position X")
			.WithShortDisplayName("Touch Touch Position X")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 340u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch5positiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 191).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Position Y")
			.WithShortDisplayName("Touch Touch Position Y")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 344u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch5deltaup(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 192).WithParent(parent)
			.WithName("up")
			.WithDisplayName("Touch Touch Delta Up")
			.WithShortDisplayName("Touch Touch Delta Up")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 352u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch5deltadown(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 193).WithParent(parent)
			.WithName("down")
			.WithDisplayName("Touch Touch Delta Down")
			.WithShortDisplayName("Touch Touch Delta Down")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 352u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch5deltaleft(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 194).WithParent(parent)
			.WithName("left")
			.WithDisplayName("Touch Touch Delta Left")
			.WithShortDisplayName("Touch Touch Delta Left")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 348u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch5deltaright(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 195).WithParent(parent)
			.WithName("right")
			.WithDisplayName("Touch Touch Delta Right")
			.WithShortDisplayName("Touch Touch Delta Right")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 348u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch5deltax(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 196).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Delta X")
			.WithShortDisplayName("Touch Touch Delta X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 348u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch5deltay(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 197).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Delta Y")
			.WithShortDisplayName("Touch Touch Delta Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 352u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch5radiusx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 198).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Radius X")
			.WithShortDisplayName("Touch Touch Radius X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 360u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch5radiusy(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 199).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Radius Y")
			.WithShortDisplayName("Touch Touch Radius Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 364u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch5startPositionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 200).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Start Position X")
			.WithShortDisplayName("Touch Touch Start Position X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 384u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch5startPositiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 201).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Start Position Y")
			.WithShortDisplayName("Touch Touch Start Position Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 388u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch6touchId(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 202).WithParent(parent)
			.WithName("touchId")
			.WithDisplayName("Touch Touch ID")
			.WithShortDisplayName("Touch Touch ID")
			.WithLayout(kIntegerLayout)
			.IsSynthetic(value: true)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1229870112),
				byteOffset = 392u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return integerControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch6position(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 203).WithParent(parent)
			.WithChildren(215, 2)
			.WithName("position")
			.WithDisplayName("Touch Position")
			.WithShortDisplayName("Touch Position")
			.WithLayout(kVector2Layout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 396u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private DeltaControl Initialize_ctrlTouchscreentouch6delta(InternedString kDeltaLayout, InputControl parent)
	{
		DeltaControl deltaControl = new DeltaControl();
		deltaControl.Setup().At(this, 204).WithParent(parent)
			.WithChildren(217, 6)
			.WithName("delta")
			.WithDisplayName("Touch Delta")
			.WithShortDisplayName("Touch Delta")
			.WithLayout(kDeltaLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 404u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return deltaControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch6pressure(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 205).WithParent(parent)
			.WithName("pressure")
			.WithDisplayName("Touch Pressure")
			.WithShortDisplayName("Touch Pressure")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 412u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch6radius(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 206).WithParent(parent)
			.WithChildren(223, 2)
			.WithName("radius")
			.WithDisplayName("Touch Radius")
			.WithShortDisplayName("Touch Radius")
			.WithLayout(kVector2Layout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 416u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private TouchPhaseControl Initialize_ctrlTouchscreentouch6phase(InternedString kTouchPhaseLayout, InputControl parent)
	{
		TouchPhaseControl touchPhaseControl = new TouchPhaseControl();
		touchPhaseControl.Setup().At(this, 207).WithParent(parent)
			.WithName("phase")
			.WithDisplayName("Touch Touch Phase")
			.WithShortDisplayName("Touch Touch Phase")
			.WithLayout(kTouchPhaseLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 424u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return touchPhaseControl;
	}

	private TouchPressControl Initialize_ctrlTouchscreentouch6press(InternedString kTouchPressLayout, InputControl parent)
	{
		TouchPressControl touchPressControl = new TouchPressControl();
		touchPressControl.Setup().At(this, 208).WithParent(parent)
			.WithName("press")
			.WithDisplayName("Touch Touch Contact?")
			.WithShortDisplayName("Touch Touch Contact?")
			.WithLayout(kTouchPressLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 424u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return touchPressControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch6tapCount(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 209).WithParent(parent)
			.WithName("tapCount")
			.WithDisplayName("Touch Tap Count")
			.WithShortDisplayName("Touch Tap Count")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 425u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch6displayIndex(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 210).WithParent(parent)
			.WithName("displayIndex")
			.WithDisplayName("Touch Display Index")
			.WithShortDisplayName("Touch Display Index")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 426u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch6indirectTouch(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 211).WithParent(parent)
			.WithName("indirectTouch")
			.WithDisplayName("Touch Indirect Touch?")
			.WithShortDisplayName("Touch Indirect Touch?")
			.WithLayout(kButtonLayout)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 427u,
				bitOffset = 0u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch6tap(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 212).WithParent(parent)
			.WithName("tap")
			.WithDisplayName("Touch Tap")
			.WithShortDisplayName("Touch Tap")
			.WithLayout(kButtonLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 427u,
				bitOffset = 4u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private DoubleControl Initialize_ctrlTouchscreentouch6startTime(InternedString kDoubleLayout, InputControl parent)
	{
		DoubleControl doubleControl = new DoubleControl();
		doubleControl.Setup().At(this, 213).WithParent(parent)
			.WithName("startTime")
			.WithDisplayName("Touch Start Time")
			.WithShortDisplayName("Touch Start Time")
			.WithLayout(kDoubleLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1145195552),
				byteOffset = 432u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return doubleControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch6startPosition(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 214).WithParent(parent)
			.WithChildren(225, 2)
			.WithName("startPosition")
			.WithDisplayName("Touch Start Position")
			.WithShortDisplayName("Touch Start Position")
			.WithLayout(kVector2Layout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 440u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private AxisControl Initialize_ctrlTouchscreentouch6positionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 215).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Position X")
			.WithShortDisplayName("Touch Touch Position X")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 396u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch6positiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 216).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Position Y")
			.WithShortDisplayName("Touch Touch Position Y")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 400u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch6deltaup(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 217).WithParent(parent)
			.WithName("up")
			.WithDisplayName("Touch Touch Delta Up")
			.WithShortDisplayName("Touch Touch Delta Up")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 408u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch6deltadown(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 218).WithParent(parent)
			.WithName("down")
			.WithDisplayName("Touch Touch Delta Down")
			.WithShortDisplayName("Touch Touch Delta Down")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 408u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch6deltaleft(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 219).WithParent(parent)
			.WithName("left")
			.WithDisplayName("Touch Touch Delta Left")
			.WithShortDisplayName("Touch Touch Delta Left")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 404u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch6deltaright(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 220).WithParent(parent)
			.WithName("right")
			.WithDisplayName("Touch Touch Delta Right")
			.WithShortDisplayName("Touch Touch Delta Right")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 404u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch6deltax(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 221).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Delta X")
			.WithShortDisplayName("Touch Touch Delta X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 404u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch6deltay(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 222).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Delta Y")
			.WithShortDisplayName("Touch Touch Delta Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 408u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch6radiusx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 223).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Radius X")
			.WithShortDisplayName("Touch Touch Radius X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 416u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch6radiusy(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 224).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Radius Y")
			.WithShortDisplayName("Touch Touch Radius Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 420u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch6startPositionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 225).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Start Position X")
			.WithShortDisplayName("Touch Touch Start Position X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 440u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch6startPositiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 226).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Start Position Y")
			.WithShortDisplayName("Touch Touch Start Position Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 444u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch7touchId(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 227).WithParent(parent)
			.WithName("touchId")
			.WithDisplayName("Touch Touch ID")
			.WithShortDisplayName("Touch Touch ID")
			.WithLayout(kIntegerLayout)
			.IsSynthetic(value: true)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1229870112),
				byteOffset = 448u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return integerControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch7position(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 228).WithParent(parent)
			.WithChildren(240, 2)
			.WithName("position")
			.WithDisplayName("Touch Position")
			.WithShortDisplayName("Touch Position")
			.WithLayout(kVector2Layout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 452u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private DeltaControl Initialize_ctrlTouchscreentouch7delta(InternedString kDeltaLayout, InputControl parent)
	{
		DeltaControl deltaControl = new DeltaControl();
		deltaControl.Setup().At(this, 229).WithParent(parent)
			.WithChildren(242, 6)
			.WithName("delta")
			.WithDisplayName("Touch Delta")
			.WithShortDisplayName("Touch Delta")
			.WithLayout(kDeltaLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 460u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return deltaControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch7pressure(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 230).WithParent(parent)
			.WithName("pressure")
			.WithDisplayName("Touch Pressure")
			.WithShortDisplayName("Touch Pressure")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 468u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch7radius(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 231).WithParent(parent)
			.WithChildren(248, 2)
			.WithName("radius")
			.WithDisplayName("Touch Radius")
			.WithShortDisplayName("Touch Radius")
			.WithLayout(kVector2Layout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 472u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private TouchPhaseControl Initialize_ctrlTouchscreentouch7phase(InternedString kTouchPhaseLayout, InputControl parent)
	{
		TouchPhaseControl touchPhaseControl = new TouchPhaseControl();
		touchPhaseControl.Setup().At(this, 232).WithParent(parent)
			.WithName("phase")
			.WithDisplayName("Touch Touch Phase")
			.WithShortDisplayName("Touch Touch Phase")
			.WithLayout(kTouchPhaseLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 480u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return touchPhaseControl;
	}

	private TouchPressControl Initialize_ctrlTouchscreentouch7press(InternedString kTouchPressLayout, InputControl parent)
	{
		TouchPressControl touchPressControl = new TouchPressControl();
		touchPressControl.Setup().At(this, 233).WithParent(parent)
			.WithName("press")
			.WithDisplayName("Touch Touch Contact?")
			.WithShortDisplayName("Touch Touch Contact?")
			.WithLayout(kTouchPressLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 480u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return touchPressControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch7tapCount(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 234).WithParent(parent)
			.WithName("tapCount")
			.WithDisplayName("Touch Tap Count")
			.WithShortDisplayName("Touch Tap Count")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 481u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch7displayIndex(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 235).WithParent(parent)
			.WithName("displayIndex")
			.WithDisplayName("Touch Display Index")
			.WithShortDisplayName("Touch Display Index")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 482u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch7indirectTouch(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 236).WithParent(parent)
			.WithName("indirectTouch")
			.WithDisplayName("Touch Indirect Touch?")
			.WithShortDisplayName("Touch Indirect Touch?")
			.WithLayout(kButtonLayout)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 483u,
				bitOffset = 0u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch7tap(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 237).WithParent(parent)
			.WithName("tap")
			.WithDisplayName("Touch Tap")
			.WithShortDisplayName("Touch Tap")
			.WithLayout(kButtonLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 483u,
				bitOffset = 4u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private DoubleControl Initialize_ctrlTouchscreentouch7startTime(InternedString kDoubleLayout, InputControl parent)
	{
		DoubleControl doubleControl = new DoubleControl();
		doubleControl.Setup().At(this, 238).WithParent(parent)
			.WithName("startTime")
			.WithDisplayName("Touch Start Time")
			.WithShortDisplayName("Touch Start Time")
			.WithLayout(kDoubleLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1145195552),
				byteOffset = 488u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return doubleControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch7startPosition(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 239).WithParent(parent)
			.WithChildren(250, 2)
			.WithName("startPosition")
			.WithDisplayName("Touch Start Position")
			.WithShortDisplayName("Touch Start Position")
			.WithLayout(kVector2Layout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 496u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private AxisControl Initialize_ctrlTouchscreentouch7positionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 240).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Position X")
			.WithShortDisplayName("Touch Touch Position X")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 452u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch7positiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 241).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Position Y")
			.WithShortDisplayName("Touch Touch Position Y")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 456u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch7deltaup(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 242).WithParent(parent)
			.WithName("up")
			.WithDisplayName("Touch Touch Delta Up")
			.WithShortDisplayName("Touch Touch Delta Up")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 464u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch7deltadown(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 243).WithParent(parent)
			.WithName("down")
			.WithDisplayName("Touch Touch Delta Down")
			.WithShortDisplayName("Touch Touch Delta Down")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 464u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch7deltaleft(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 244).WithParent(parent)
			.WithName("left")
			.WithDisplayName("Touch Touch Delta Left")
			.WithShortDisplayName("Touch Touch Delta Left")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 460u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch7deltaright(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 245).WithParent(parent)
			.WithName("right")
			.WithDisplayName("Touch Touch Delta Right")
			.WithShortDisplayName("Touch Touch Delta Right")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 460u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch7deltax(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 246).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Delta X")
			.WithShortDisplayName("Touch Touch Delta X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 460u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch7deltay(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 247).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Delta Y")
			.WithShortDisplayName("Touch Touch Delta Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 464u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch7radiusx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 248).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Radius X")
			.WithShortDisplayName("Touch Touch Radius X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 472u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch7radiusy(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 249).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Radius Y")
			.WithShortDisplayName("Touch Touch Radius Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 476u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch7startPositionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 250).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Start Position X")
			.WithShortDisplayName("Touch Touch Start Position X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 496u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch7startPositiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 251).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Start Position Y")
			.WithShortDisplayName("Touch Touch Start Position Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 500u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch8touchId(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 252).WithParent(parent)
			.WithName("touchId")
			.WithDisplayName("Touch Touch ID")
			.WithShortDisplayName("Touch Touch ID")
			.WithLayout(kIntegerLayout)
			.IsSynthetic(value: true)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1229870112),
				byteOffset = 504u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return integerControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch8position(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 253).WithParent(parent)
			.WithChildren(265, 2)
			.WithName("position")
			.WithDisplayName("Touch Position")
			.WithShortDisplayName("Touch Position")
			.WithLayout(kVector2Layout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 508u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private DeltaControl Initialize_ctrlTouchscreentouch8delta(InternedString kDeltaLayout, InputControl parent)
	{
		DeltaControl deltaControl = new DeltaControl();
		deltaControl.Setup().At(this, 254).WithParent(parent)
			.WithChildren(267, 6)
			.WithName("delta")
			.WithDisplayName("Touch Delta")
			.WithShortDisplayName("Touch Delta")
			.WithLayout(kDeltaLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 516u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return deltaControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch8pressure(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 255).WithParent(parent)
			.WithName("pressure")
			.WithDisplayName("Touch Pressure")
			.WithShortDisplayName("Touch Pressure")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 524u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch8radius(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 256).WithParent(parent)
			.WithChildren(273, 2)
			.WithName("radius")
			.WithDisplayName("Touch Radius")
			.WithShortDisplayName("Touch Radius")
			.WithLayout(kVector2Layout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 528u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private TouchPhaseControl Initialize_ctrlTouchscreentouch8phase(InternedString kTouchPhaseLayout, InputControl parent)
	{
		TouchPhaseControl touchPhaseControl = new TouchPhaseControl();
		touchPhaseControl.Setup().At(this, 257).WithParent(parent)
			.WithName("phase")
			.WithDisplayName("Touch Touch Phase")
			.WithShortDisplayName("Touch Touch Phase")
			.WithLayout(kTouchPhaseLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 536u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return touchPhaseControl;
	}

	private TouchPressControl Initialize_ctrlTouchscreentouch8press(InternedString kTouchPressLayout, InputControl parent)
	{
		TouchPressControl touchPressControl = new TouchPressControl();
		touchPressControl.Setup().At(this, 258).WithParent(parent)
			.WithName("press")
			.WithDisplayName("Touch Touch Contact?")
			.WithShortDisplayName("Touch Touch Contact?")
			.WithLayout(kTouchPressLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 536u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return touchPressControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch8tapCount(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 259).WithParent(parent)
			.WithName("tapCount")
			.WithDisplayName("Touch Tap Count")
			.WithShortDisplayName("Touch Tap Count")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 537u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch8displayIndex(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 260).WithParent(parent)
			.WithName("displayIndex")
			.WithDisplayName("Touch Display Index")
			.WithShortDisplayName("Touch Display Index")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 538u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch8indirectTouch(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 261).WithParent(parent)
			.WithName("indirectTouch")
			.WithDisplayName("Touch Indirect Touch?")
			.WithShortDisplayName("Touch Indirect Touch?")
			.WithLayout(kButtonLayout)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 539u,
				bitOffset = 0u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch8tap(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 262).WithParent(parent)
			.WithName("tap")
			.WithDisplayName("Touch Tap")
			.WithShortDisplayName("Touch Tap")
			.WithLayout(kButtonLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 539u,
				bitOffset = 4u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private DoubleControl Initialize_ctrlTouchscreentouch8startTime(InternedString kDoubleLayout, InputControl parent)
	{
		DoubleControl doubleControl = new DoubleControl();
		doubleControl.Setup().At(this, 263).WithParent(parent)
			.WithName("startTime")
			.WithDisplayName("Touch Start Time")
			.WithShortDisplayName("Touch Start Time")
			.WithLayout(kDoubleLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1145195552),
				byteOffset = 544u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return doubleControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch8startPosition(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 264).WithParent(parent)
			.WithChildren(275, 2)
			.WithName("startPosition")
			.WithDisplayName("Touch Start Position")
			.WithShortDisplayName("Touch Start Position")
			.WithLayout(kVector2Layout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 552u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private AxisControl Initialize_ctrlTouchscreentouch8positionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 265).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Position X")
			.WithShortDisplayName("Touch Touch Position X")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 508u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch8positiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 266).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Position Y")
			.WithShortDisplayName("Touch Touch Position Y")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 512u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch8deltaup(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 267).WithParent(parent)
			.WithName("up")
			.WithDisplayName("Touch Touch Delta Up")
			.WithShortDisplayName("Touch Touch Delta Up")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 520u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch8deltadown(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 268).WithParent(parent)
			.WithName("down")
			.WithDisplayName("Touch Touch Delta Down")
			.WithShortDisplayName("Touch Touch Delta Down")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 520u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch8deltaleft(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 269).WithParent(parent)
			.WithName("left")
			.WithDisplayName("Touch Touch Delta Left")
			.WithShortDisplayName("Touch Touch Delta Left")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 516u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch8deltaright(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 270).WithParent(parent)
			.WithName("right")
			.WithDisplayName("Touch Touch Delta Right")
			.WithShortDisplayName("Touch Touch Delta Right")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 516u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch8deltax(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 271).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Delta X")
			.WithShortDisplayName("Touch Touch Delta X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 516u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch8deltay(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 272).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Delta Y")
			.WithShortDisplayName("Touch Touch Delta Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 520u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch8radiusx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 273).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Radius X")
			.WithShortDisplayName("Touch Touch Radius X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 528u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch8radiusy(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 274).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Radius Y")
			.WithShortDisplayName("Touch Touch Radius Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 532u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch8startPositionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 275).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Start Position X")
			.WithShortDisplayName("Touch Touch Start Position X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 552u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch8startPositiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 276).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Start Position Y")
			.WithShortDisplayName("Touch Touch Start Position Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 556u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch9touchId(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 277).WithParent(parent)
			.WithName("touchId")
			.WithDisplayName("Touch Touch ID")
			.WithShortDisplayName("Touch Touch ID")
			.WithLayout(kIntegerLayout)
			.IsSynthetic(value: true)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1229870112),
				byteOffset = 560u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return integerControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch9position(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 278).WithParent(parent)
			.WithChildren(290, 2)
			.WithName("position")
			.WithDisplayName("Touch Position")
			.WithShortDisplayName("Touch Position")
			.WithLayout(kVector2Layout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 564u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private DeltaControl Initialize_ctrlTouchscreentouch9delta(InternedString kDeltaLayout, InputControl parent)
	{
		DeltaControl deltaControl = new DeltaControl();
		deltaControl.Setup().At(this, 279).WithParent(parent)
			.WithChildren(292, 6)
			.WithName("delta")
			.WithDisplayName("Touch Delta")
			.WithShortDisplayName("Touch Delta")
			.WithLayout(kDeltaLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 572u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return deltaControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch9pressure(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 280).WithParent(parent)
			.WithName("pressure")
			.WithDisplayName("Touch Pressure")
			.WithShortDisplayName("Touch Pressure")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 580u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch9radius(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 281).WithParent(parent)
			.WithChildren(298, 2)
			.WithName("radius")
			.WithDisplayName("Touch Radius")
			.WithShortDisplayName("Touch Radius")
			.WithLayout(kVector2Layout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 584u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private TouchPhaseControl Initialize_ctrlTouchscreentouch9phase(InternedString kTouchPhaseLayout, InputControl parent)
	{
		TouchPhaseControl touchPhaseControl = new TouchPhaseControl();
		touchPhaseControl.Setup().At(this, 282).WithParent(parent)
			.WithName("phase")
			.WithDisplayName("Touch Touch Phase")
			.WithShortDisplayName("Touch Touch Phase")
			.WithLayout(kTouchPhaseLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 592u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return touchPhaseControl;
	}

	private TouchPressControl Initialize_ctrlTouchscreentouch9press(InternedString kTouchPressLayout, InputControl parent)
	{
		TouchPressControl touchPressControl = new TouchPressControl();
		touchPressControl.Setup().At(this, 283).WithParent(parent)
			.WithName("press")
			.WithDisplayName("Touch Touch Contact?")
			.WithShortDisplayName("Touch Touch Contact?")
			.WithLayout(kTouchPressLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 592u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return touchPressControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch9tapCount(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 284).WithParent(parent)
			.WithName("tapCount")
			.WithDisplayName("Touch Tap Count")
			.WithShortDisplayName("Touch Tap Count")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 593u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private IntegerControl Initialize_ctrlTouchscreentouch9displayIndex(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 285).WithParent(parent)
			.WithName("displayIndex")
			.WithDisplayName("Touch Display Index")
			.WithShortDisplayName("Touch Display Index")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1113150533),
				byteOffset = 594u,
				bitOffset = 0u,
				sizeInBits = 8u
			})
			.Finish();
		return integerControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch9indirectTouch(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 286).WithParent(parent)
			.WithName("indirectTouch")
			.WithDisplayName("Touch Indirect Touch?")
			.WithShortDisplayName("Touch Indirect Touch?")
			.WithLayout(kButtonLayout)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 595u,
				bitOffset = 0u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlTouchscreentouch9tap(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 287).WithParent(parent)
			.WithName("tap")
			.WithDisplayName("Touch Tap")
			.WithShortDisplayName("Touch Tap")
			.WithLayout(kButtonLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 595u,
				bitOffset = 4u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private DoubleControl Initialize_ctrlTouchscreentouch9startTime(InternedString kDoubleLayout, InputControl parent)
	{
		DoubleControl doubleControl = new DoubleControl();
		doubleControl.Setup().At(this, 288).WithParent(parent)
			.WithName("startTime")
			.WithDisplayName("Touch Start Time")
			.WithShortDisplayName("Touch Start Time")
			.WithLayout(kDoubleLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1145195552),
				byteOffset = 600u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return doubleControl;
	}

	private Vector2Control Initialize_ctrlTouchscreentouch9startPosition(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 289).WithParent(parent)
			.WithChildren(300, 2)
			.WithName("startPosition")
			.WithDisplayName("Touch Start Position")
			.WithShortDisplayName("Touch Start Position")
			.WithLayout(kVector2Layout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 608u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private AxisControl Initialize_ctrlTouchscreentouch9positionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 290).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Position X")
			.WithShortDisplayName("Touch Touch Position X")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 564u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch9positiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 291).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Position Y")
			.WithShortDisplayName("Touch Touch Position Y")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 568u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch9deltaup(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 292).WithParent(parent)
			.WithName("up")
			.WithDisplayName("Touch Touch Delta Up")
			.WithShortDisplayName("Touch Touch Delta Up")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 576u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch9deltadown(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 293).WithParent(parent)
			.WithName("down")
			.WithDisplayName("Touch Touch Delta Down")
			.WithShortDisplayName("Touch Touch Delta Down")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 576u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch9deltaleft(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 294).WithParent(parent)
			.WithName("left")
			.WithDisplayName("Touch Touch Delta Left")
			.WithShortDisplayName("Touch Touch Delta Left")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 572u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch9deltaright(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 295).WithParent(parent)
			.WithName("right")
			.WithDisplayName("Touch Touch Delta Right")
			.WithShortDisplayName("Touch Touch Delta Right")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 572u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlTouchscreentouch9deltax(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 296).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Delta X")
			.WithShortDisplayName("Touch Touch Delta X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 572u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch9deltay(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 297).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Delta Y")
			.WithShortDisplayName("Touch Touch Delta Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 576u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch9radiusx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 298).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Radius X")
			.WithShortDisplayName("Touch Touch Radius X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 584u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch9radiusy(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 299).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Radius Y")
			.WithShortDisplayName("Touch Touch Radius Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 588u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch9startPositionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 300).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Touch Touch Start Position X")
			.WithShortDisplayName("Touch Touch Start Position X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 608u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlTouchscreentouch9startPositiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 301).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Touch Touch Start Position Y")
			.WithShortDisplayName("Touch Touch Start Position Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 612u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}
}
