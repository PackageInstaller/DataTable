using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem;

internal class FastMouse : Mouse, IInputStateCallbackReceiver, IEventMerger
{
	public const string metadata = "AutoWindowSpace;Vector2;Delta;Button;Axis;Digital;Integer;Mouse;Pointer";

	public FastMouse()
	{
		InputControlExtensions.DeviceBuilder deviceBuilder = this.Setup(30, 10, 2).WithName("Mouse").WithDisplayName("Mouse")
			.WithChildren(0, 14)
			.WithLayout(new InternedString("Mouse"))
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1297044819),
				sizeInBits = 392u
			});
		InternedString kVector2Layout = new InternedString("Vector2");
		InternedString kDeltaLayout = new InternedString("Delta");
		InternedString kButtonLayout = new InternedString("Button");
		InternedString kAxisLayout = new InternedString("Axis");
		InternedString kDigitalLayout = new InternedString("Digital");
		InternedString kIntegerLayout = new InternedString("Integer");
		Vector2Control vector2Control = Initialize_ctrlMouseposition(kVector2Layout, this);
		DeltaControl deltaControl = Initialize_ctrlMousedelta(kDeltaLayout, this);
		DeltaControl deltaControl2 = Initialize_ctrlMousescroll(kDeltaLayout, this);
		ButtonControl buttonControl = Initialize_ctrlMousepress(kButtonLayout, this);
		ButtonControl control = Initialize_ctrlMouseleftButton(kButtonLayout, this);
		ButtonControl control2 = Initialize_ctrlMouserightButton(kButtonLayout, this);
		ButtonControl buttonControl2 = Initialize_ctrlMousemiddleButton(kButtonLayout, this);
		ButtonControl control3 = Initialize_ctrlMouseforwardButton(kButtonLayout, this);
		ButtonControl control4 = Initialize_ctrlMousebackButton(kButtonLayout, this);
		AxisControl control5 = Initialize_ctrlMousepressure(kAxisLayout, this);
		Vector2Control vector2Control2 = Initialize_ctrlMouseradius(kVector2Layout, this);
		Initialize_ctrlMousepointerId(kDigitalLayout, this);
		IntegerControl integerControl = Initialize_ctrlMousedisplayIndex(kIntegerLayout, this);
		IntegerControl integerControl2 = Initialize_ctrlMouseclickCount(kIntegerLayout, this);
		AxisControl x = Initialize_ctrlMousepositionx(kAxisLayout, vector2Control);
		AxisControl y = Initialize_ctrlMousepositiony(kAxisLayout, vector2Control);
		AxisControl up = Initialize_ctrlMousedeltaup(kAxisLayout, deltaControl);
		AxisControl down = Initialize_ctrlMousedeltadown(kAxisLayout, deltaControl);
		AxisControl left = Initialize_ctrlMousedeltaleft(kAxisLayout, deltaControl);
		AxisControl right = Initialize_ctrlMousedeltaright(kAxisLayout, deltaControl);
		AxisControl x2 = Initialize_ctrlMousedeltax(kAxisLayout, deltaControl);
		AxisControl y2 = Initialize_ctrlMousedeltay(kAxisLayout, deltaControl);
		AxisControl up2 = Initialize_ctrlMousescrollup(kAxisLayout, deltaControl2);
		AxisControl down2 = Initialize_ctrlMousescrolldown(kAxisLayout, deltaControl2);
		AxisControl left2 = Initialize_ctrlMousescrollleft(kAxisLayout, deltaControl2);
		AxisControl right2 = Initialize_ctrlMousescrollright(kAxisLayout, deltaControl2);
		AxisControl axisControl = Initialize_ctrlMousescrollx(kAxisLayout, deltaControl2);
		AxisControl axisControl2 = Initialize_ctrlMousescrolly(kAxisLayout, deltaControl2);
		AxisControl x3 = Initialize_ctrlMouseradiusx(kAxisLayout, vector2Control2);
		AxisControl y3 = Initialize_ctrlMouseradiusy(kAxisLayout, vector2Control2);
		deviceBuilder.WithControlUsage(0, new InternedString("Point"), vector2Control);
		deviceBuilder.WithControlUsage(1, new InternedString("Secondary2DMotion"), deltaControl);
		deviceBuilder.WithControlUsage(2, new InternedString("ScrollHorizontal"), axisControl);
		deviceBuilder.WithControlUsage(3, new InternedString("ScrollVertical"), axisControl2);
		deviceBuilder.WithControlUsage(4, new InternedString("PrimaryAction"), control);
		deviceBuilder.WithControlUsage(5, new InternedString("SecondaryAction"), control2);
		deviceBuilder.WithControlUsage(6, new InternedString("Forward"), control3);
		deviceBuilder.WithControlUsage(7, new InternedString("Back"), control4);
		deviceBuilder.WithControlUsage(8, new InternedString("Pressure"), control5);
		deviceBuilder.WithControlUsage(9, new InternedString("Radius"), vector2Control2);
		deviceBuilder.WithControlAlias(0, new InternedString("horizontal"));
		deviceBuilder.WithControlAlias(1, new InternedString("vertical"));
		base.scroll = deltaControl2;
		base.leftButton = control;
		base.middleButton = buttonControl2;
		base.rightButton = control2;
		base.backButton = control4;
		base.forwardButton = control3;
		base.clickCount = integerControl2;
		base.position = vector2Control;
		base.delta = deltaControl;
		base.radius = vector2Control2;
		base.pressure = control5;
		base.press = buttonControl;
		base.displayIndex = integerControl;
		vector2Control.x = x;
		vector2Control.y = y;
		deltaControl.up = up;
		deltaControl.down = down;
		deltaControl.left = left;
		deltaControl.right = right;
		deltaControl.x = x2;
		deltaControl.y = y2;
		deltaControl2.up = up2;
		deltaControl2.down = down2;
		deltaControl2.left = left2;
		deltaControl2.right = right2;
		deltaControl2.x = axisControl;
		deltaControl2.y = axisControl2;
		vector2Control2.x = x3;
		vector2Control2.y = y3;
		deviceBuilder.WithStateOffsetToControlIndexMap(new uint[26]
		{
			32782u, 16809999u, 33587218u, 33587219u, 33587220u, 50364432u, 50364433u, 50364437u, 67141656u, 67141657u,
			67141658u, 83918870u, 83918871u, 83918875u, 100664323u, 100664324u, 101188613u, 101712902u, 102237191u, 102761480u,
			109068300u, 117456909u, 134250505u, 167804956u, 184582173u, 201327627u
		});
		deviceBuilder.WithControlTree(new byte[371]
		{
			135, 1, 1, 0, 0, 0, 0, 196, 0, 3,
			0, 0, 0, 0, 135, 1, 23, 0, 0, 0,
			0, 128, 0, 5, 0, 0, 0, 0, 196, 0,
			11, 0, 0, 0, 0, 64, 0, 7, 0, 0,
			0, 1, 128, 0, 9, 0, 3, 0, 1, 32,
			0, 255, 255, 1, 0, 1, 64, 0, 255, 255,
			2, 0, 1, 96, 0, 255, 255, 7, 0, 3,
			128, 0, 255, 255, 4, 0, 3, 193, 0, 13,
			0, 0, 0, 0, 196, 0, 19, 0, 0, 0,
			0, 161, 0, 15, 0, 10, 0, 4, 193, 0,
			17, 0, 14, 0, 4, 145, 0, 255, 255, 18,
			0, 3, 161, 0, 255, 255, 21, 0, 3, 192,
			0, 255, 255, 0, 0, 0, 193, 0, 255, 255,
			24, 0, 2, 195, 0, 21, 0, 0, 0, 0,
			196, 0, 255, 255, 28, 0, 1, 194, 0, 255,
			255, 26, 0, 1, 195, 0, 255, 255, 27, 0,
			1, 32, 1, 25, 0, 0, 0, 0, 135, 1,
			41, 0, 0, 0, 0, 240, 0, 27, 0, 0,
			0, 0, 32, 1, 39, 0, 0, 0, 0, 224,
			0, 29, 0, 0, 0, 0, 240, 0, 255, 255,
			41, 0, 1, 210, 0, 31, 0, 39, 0, 1,
			224, 0, 255, 255, 40, 0, 1, 203, 0, 33,
			0, 0, 0, 0, 210, 0, 255, 255, 0, 0,
			0, 200, 0, 35, 0, 0, 0, 0, 203, 0,
			255, 255, 0, 0, 0, 198, 0, 37, 0, 0,
			0, 0, 200, 0, 255, 255, 0, 0, 0, 197,
			0, 255, 255, 29, 0, 1, 198, 0, 255, 255,
			0, 0, 0, 8, 1, 255, 255, 30, 0, 1,
			32, 1, 255, 255, 31, 0, 1, 128, 1, 43,
			0, 0, 0, 0, 135, 1, 47, 0, 0, 0,
			0, 80, 1, 255, 255, 32, 0, 2, 128, 1,
			45, 0, 34, 0, 2, 104, 1, 255, 255, 36,
			0, 1, 128, 1, 255, 255, 37, 0, 1, 132,
			1, 49, 0, 0, 0, 0, 135, 1, 255, 255,
			0, 0, 0, 130, 1, 51, 0, 0, 0, 0,
			132, 1, 255, 255, 0, 0, 0, 129, 1, 255,
			255, 38, 0, 1, 130, 1, 255, 255, 0, 0,
			0
		}, new ushort[42]
		{
			0, 14, 15, 1, 16, 17, 21, 18, 19, 20,
			2, 22, 23, 27, 2, 22, 23, 27, 24, 25,
			26, 24, 25, 26, 3, 4, 5, 6, 7, 8,
			9, 9, 10, 28, 10, 28, 29, 29, 11, 12,
			12, 13
		});
		deviceBuilder.Finish();
	}

	private Vector2Control Initialize_ctrlMouseposition(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 0).WithParent(parent)
			.WithChildren(14, 2)
			.WithName("position")
			.WithDisplayName("Position")
			.WithLayout(kVector2Layout)
			.WithUsages(0, 1)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 0u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private DeltaControl Initialize_ctrlMousedelta(InternedString kDeltaLayout, InputControl parent)
	{
		DeltaControl deltaControl = new DeltaControl();
		deltaControl.Setup().At(this, 1).WithParent(parent)
			.WithChildren(16, 6)
			.WithName("delta")
			.WithDisplayName("Delta")
			.WithLayout(kDeltaLayout)
			.WithUsages(1, 1)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 8u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return deltaControl;
	}

	private DeltaControl Initialize_ctrlMousescroll(InternedString kDeltaLayout, InputControl parent)
	{
		DeltaControl deltaControl = new DeltaControl();
		deltaControl.Setup().At(this, 2).WithParent(parent)
			.WithChildren(22, 6)
			.WithName("scroll")
			.WithDisplayName("Scroll")
			.WithLayout(kDeltaLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 16u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return deltaControl;
	}

	private ButtonControl Initialize_ctrlMousepress(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 3).WithParent(parent)
			.WithName("press")
			.WithDisplayName("Press")
			.WithLayout(kButtonLayout)
			.IsSynthetic(value: true)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 24u,
				bitOffset = 0u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlMouseleftButton(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 4).WithParent(parent)
			.WithName("leftButton")
			.WithDisplayName("Left Button")
			.WithShortDisplayName("LMB")
			.WithLayout(kButtonLayout)
			.WithUsages(4, 1)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 24u,
				bitOffset = 0u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlMouserightButton(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 5).WithParent(parent)
			.WithName("rightButton")
			.WithDisplayName("Right Button")
			.WithShortDisplayName("RMB")
			.WithLayout(kButtonLayout)
			.WithUsages(5, 1)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 24u,
				bitOffset = 1u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlMousemiddleButton(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 6).WithParent(parent)
			.WithName("middleButton")
			.WithDisplayName("Middle Button")
			.WithShortDisplayName("MMB")
			.WithLayout(kButtonLayout)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 24u,
				bitOffset = 2u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlMouseforwardButton(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 7).WithParent(parent)
			.WithName("forwardButton")
			.WithDisplayName("Forward")
			.WithLayout(kButtonLayout)
			.WithUsages(6, 1)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 24u,
				bitOffset = 3u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private ButtonControl Initialize_ctrlMousebackButton(InternedString kButtonLayout, InputControl parent)
	{
		ButtonControl buttonControl = new ButtonControl();
		buttonControl.Setup().At(this, 8).WithParent(parent)
			.WithName("backButton")
			.WithDisplayName("Back")
			.WithLayout(kButtonLayout)
			.WithUsages(7, 1)
			.IsButton(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 24u,
				bitOffset = 4u,
				sizeInBits = 1u
			})
			.WithMinAndMax(0, 1)
			.Finish();
		return buttonControl;
	}

	private AxisControl Initialize_ctrlMousepressure(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 9).WithParent(parent)
			.WithName("pressure")
			.WithDisplayName("Pressure")
			.WithLayout(kAxisLayout)
			.WithUsages(8, 1)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 32u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.WithDefaultState(1)
			.Finish();
		return axisControl;
	}

	private Vector2Control Initialize_ctrlMouseradius(InternedString kVector2Layout, InputControl parent)
	{
		Vector2Control vector2Control = new Vector2Control();
		vector2Control.Setup().At(this, 10).WithParent(parent)
			.WithChildren(28, 2)
			.WithName("radius")
			.WithDisplayName("Radius")
			.WithLayout(kVector2Layout)
			.WithUsages(9, 1)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1447379762),
				byteOffset = 40u,
				bitOffset = 0u,
				sizeInBits = 64u
			})
			.Finish();
		return vector2Control;
	}

	private IntegerControl Initialize_ctrlMousepointerId(InternedString kDigitalLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 11).WithParent(parent)
			.WithName("pointerId")
			.WithDisplayName("pointerId")
			.WithLayout(kDigitalLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1112101920),
				byteOffset = 48u,
				bitOffset = 0u,
				sizeInBits = 1u
			})
			.Finish();
		return integerControl;
	}

	private IntegerControl Initialize_ctrlMousedisplayIndex(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 12).WithParent(parent)
			.WithName("displayIndex")
			.WithDisplayName("Display Index")
			.WithLayout(kIntegerLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1431521364),
				byteOffset = 26u,
				bitOffset = 0u,
				sizeInBits = 16u
			})
			.Finish();
		return integerControl;
	}

	private IntegerControl Initialize_ctrlMouseclickCount(InternedString kIntegerLayout, InputControl parent)
	{
		IntegerControl integerControl = new IntegerControl();
		integerControl.Setup().At(this, 13).WithParent(parent)
			.WithName("clickCount")
			.WithDisplayName("Click Count")
			.WithLayout(kIntegerLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1431521364),
				byteOffset = 28u,
				bitOffset = 0u,
				sizeInBits = 16u
			})
			.Finish();
		return integerControl;
	}

	private AxisControl Initialize_ctrlMousepositionx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 14).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Position X")
			.WithShortDisplayName("Position X")
			.WithLayout(kAxisLayout)
			.DontReset(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 0u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlMousepositiony(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 15).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Position Y")
			.WithShortDisplayName("Position Y")
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

	private AxisControl Initialize_ctrlMousedeltaup(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 16).WithParent(parent)
			.WithName("up")
			.WithDisplayName("Delta Up")
			.WithShortDisplayName("Delta Up")
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

	private AxisControl Initialize_ctrlMousedeltadown(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 17).WithParent(parent)
			.WithName("down")
			.WithDisplayName("Delta Down")
			.WithShortDisplayName("Delta Down")
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

	private AxisControl Initialize_ctrlMousedeltaleft(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 18).WithParent(parent)
			.WithName("left")
			.WithDisplayName("Delta Left")
			.WithShortDisplayName("Delta Left")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 8u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlMousedeltaright(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 19).WithParent(parent)
			.WithName("right")
			.WithDisplayName("Delta Right")
			.WithShortDisplayName("Delta Right")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 8u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlMousedeltax(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 20).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Delta X")
			.WithShortDisplayName("Delta X")
			.WithLayout(kAxisLayout)
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

	private AxisControl Initialize_ctrlMousedeltay(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 21).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Delta Y")
			.WithShortDisplayName("Delta Y")
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

	private AxisControl Initialize_ctrlMousescrollup(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 22).WithParent(parent)
			.WithName("up")
			.WithDisplayName("Scroll Up")
			.WithShortDisplayName("Scroll Up")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 20u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlMousescrolldown(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 23).WithParent(parent)
			.WithName("down")
			.WithDisplayName("Scroll Down")
			.WithShortDisplayName("Scroll Down")
			.WithLayout(kAxisLayout)
			.IsSynthetic(value: true)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 20u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return obj;
	}

	private AxisControl Initialize_ctrlMousescrollleft(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMin = -3.402823E+38f,
			invert = true
		};
		obj.Setup().At(this, 24).WithParent(parent)
			.WithName("left")
			.WithDisplayName("Scroll Left")
			.WithShortDisplayName("Scroll Left")
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

	private AxisControl Initialize_ctrlMousescrollright(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl obj = new AxisControl
		{
			clamp = AxisControl.Clamp.BeforeNormalize,
			clampMax = 3.402823E+38f
		};
		obj.Setup().At(this, 25).WithParent(parent)
			.WithName("right")
			.WithDisplayName("Scroll Right")
			.WithShortDisplayName("Scroll Right")
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

	private AxisControl Initialize_ctrlMousescrollx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 26).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Scroll Left/Right")
			.WithShortDisplayName("Scroll Left/Right")
			.WithLayout(kAxisLayout)
			.WithUsages(2, 1)
			.WithAliases(0, 1)
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

	private AxisControl Initialize_ctrlMousescrolly(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 27).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Scroll Up/Down")
			.WithShortDisplayName("Scroll Wheel")
			.WithLayout(kAxisLayout)
			.WithUsages(3, 1)
			.WithAliases(1, 1)
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

	private AxisControl Initialize_ctrlMouseradiusx(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 28).WithParent(parent)
			.WithName("x")
			.WithDisplayName("Radius X")
			.WithShortDisplayName("Radius X")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 40u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	private AxisControl Initialize_ctrlMouseradiusy(InternedString kAxisLayout, InputControl parent)
	{
		AxisControl axisControl = new AxisControl();
		axisControl.Setup().At(this, 29).WithParent(parent)
			.WithName("y")
			.WithDisplayName("Radius Y")
			.WithShortDisplayName("Radius Y")
			.WithLayout(kAxisLayout)
			.WithStateBlock(new InputStateBlock
			{
				format = new FourCC(1179407392),
				byteOffset = 44u,
				bitOffset = 0u,
				sizeInBits = 32u
			})
			.Finish();
		return axisControl;
	}

	protected new void OnNextUpdate()
	{
		InputState.Change(base.delta, Vector2.zero, InputState.currentUpdateType);
		InputState.Change(base.scroll, Vector2.zero, InputState.currentUpdateType);
	}

	protected new unsafe void OnStateEvent(InputEventPtr eventPtr)
	{
		if (eventPtr.type != 1398030676)
		{
			base.OnStateEvent(eventPtr);
			return;
		}
		StateEvent* ptr = StateEvent.FromUnchecked(eventPtr);
		if (ptr->stateFormat != MouseState.Format)
		{
			base.OnStateEvent(eventPtr);
			return;
		}
		MouseState state = *(MouseState*)ptr->state;
		MouseState* ptr2 = (MouseState*)((byte*)base.currentStatePtr + m_StateBlock.byteOffset);
		state.delta += ptr2->delta;
		state.scroll += ptr2->scroll;
		InputState.Change(this, ref state, InputState.currentUpdateType, eventPtr);
	}

	void IInputStateCallbackReceiver.OnNextUpdate()
	{
		OnNextUpdate();
	}

	void IInputStateCallbackReceiver.OnStateEvent(InputEventPtr eventPtr)
	{
		OnStateEvent(eventPtr);
	}

	internal unsafe static bool MergeForward(InputEventPtr currentEventPtr, InputEventPtr nextEventPtr)
	{
		if (currentEventPtr.type != 1398030676 || nextEventPtr.type != 1398030676)
		{
			return false;
		}
		StateEvent* ptr = StateEvent.FromUnchecked(currentEventPtr);
		StateEvent* ptr2 = StateEvent.FromUnchecked(nextEventPtr);
		if (ptr->stateFormat != MouseState.Format || ptr2->stateFormat != MouseState.Format)
		{
			return false;
		}
		MouseState* state = (MouseState*)ptr->state;
		MouseState* state2 = (MouseState*)ptr2->state;
		if (state->buttons != state2->buttons || state->clickCount != state2->clickCount)
		{
			return false;
		}
		state2->delta += state->delta;
		state2->scroll += state->scroll;
		return true;
	}

	bool IEventMerger.MergeForward(InputEventPtr currentEventPtr, InputEventPtr nextEventPtr)
	{
		return MergeForward(currentEventPtr, nextEventPtr);
	}
}
