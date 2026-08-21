using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine.Rendering;

namespace UnityEngine;

public struct RenderParams
{
	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private int _003Clayer_003Ek__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private uint _003CrenderingLayerMask_003Ek__BackingField;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private int _003CrendererPriority_003Ek__BackingField;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private Bounds _003CworldBounds_003Ek__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private Camera _003Ccamera_003Ek__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private MotionVectorGenerationMode _003CmotionVectorMode_003Ek__BackingField;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private ReflectionProbeUsage _003CreflectionProbeUsage_003Ek__BackingField;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private MaterialPropertyBlock _003CmatProps_003Ek__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private ShadowCastingMode _003CshadowCastingMode_003Ek__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private bool _003CreceiveShadows_003Ek__BackingField;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private LightProbeUsage _003ClightProbeUsage_003Ek__BackingField;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private LightProbeProxyVolume _003ClightProbeProxyVolume_003Ek__BackingField;

	public int layer
	{
		[CompilerGenerated]
		set
		{
			_003Clayer_003Ek__BackingField = value;
		}
	}

	public uint renderingLayerMask
	{
		[CompilerGenerated]
		set
		{
			_003CrenderingLayerMask_003Ek__BackingField = value;
		}
	}

	public int rendererPriority
	{
		[CompilerGenerated]
		set
		{
			_003CrendererPriority_003Ek__BackingField = value;
		}
	}

	public Bounds worldBounds
	{
		[CompilerGenerated]
		set
		{
			_003CworldBounds_003Ek__BackingField = value;
		}
	}

	public Camera camera
	{
		[CompilerGenerated]
		set
		{
			_003Ccamera_003Ek__BackingField = value;
		}
	}

	public MotionVectorGenerationMode motionVectorMode
	{
		[CompilerGenerated]
		set
		{
			_003CmotionVectorMode_003Ek__BackingField = value;
		}
	}

	public ReflectionProbeUsage reflectionProbeUsage
	{
		[CompilerGenerated]
		set
		{
			_003CreflectionProbeUsage_003Ek__BackingField = value;
		}
	}

	public Material material { get; set; }

	public MaterialPropertyBlock matProps
	{
		[CompilerGenerated]
		set
		{
			_003CmatProps_003Ek__BackingField = value;
		}
	}

	public ShadowCastingMode shadowCastingMode
	{
		[CompilerGenerated]
		set
		{
			_003CshadowCastingMode_003Ek__BackingField = value;
		}
	}

	public bool receiveShadows
	{
		[CompilerGenerated]
		set
		{
			_003CreceiveShadows_003Ek__BackingField = value;
		}
	}

	public LightProbeUsage lightProbeUsage
	{
		[CompilerGenerated]
		set
		{
			_003ClightProbeUsage_003Ek__BackingField = value;
		}
	}

	public LightProbeProxyVolume lightProbeProxyVolume
	{
		[CompilerGenerated]
		set
		{
			_003ClightProbeProxyVolume_003Ek__BackingField = value;
		}
	}

	public RenderParams(Material mat)
	{
		layer = 0;
		renderingLayerMask = GraphicsSettings.defaultRenderingLayerMask;
		rendererPriority = 0;
		worldBounds = new Bounds(Vector3.zero, Vector3.zero);
		camera = null;
		motionVectorMode = MotionVectorGenerationMode.Camera;
		reflectionProbeUsage = ReflectionProbeUsage.Off;
		material = mat;
		matProps = null;
		shadowCastingMode = ShadowCastingMode.Off;
		receiveShadows = false;
		lightProbeUsage = LightProbeUsage.Off;
		lightProbeProxyVolume = null;
	}
}
