using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace CriMana.Detail;

public abstract class RendererResource : IDisposable
{
	private bool disposed;

	protected Shader shader;

	protected Material currentMaterial;

	protected bool hasAlpha;

	protected bool additive;

	protected bool applyTargetAlpha;

	protected bool ui;

	~RendererResource()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	private void Dispose(bool disposing)
	{
		if (!disposed)
		{
			if (disposing)
			{
				OnDisposeManaged();
			}
			OnDisposeUnmanaged();
			disposed = true;
		}
	}

	public int GetNumberOfFrameBeforeDestroy(int playerId)
	{
		return CRIWAREAE5A50FA(playerId);
	}

	protected void SetupStaticMaterialProperties()
	{
		if (!(currentMaterial == null))
		{
			GetBlendModes(out var srcBlendMode, out var dstBlendMode);
			if (currentMaterial.shader != shader)
			{
				currentMaterial.shader = shader;
			}
			currentMaterial.SetInt("_SrcBlendMode", srcBlendMode);
			currentMaterial.SetInt("_DstBlendMode", dstBlendMode);
			currentMaterial.SetInt("_CullMode", (!ui) ? 2 : 0);
			currentMaterial.SetInt("_ZWriteMode", (!ui) ? 1 : 0);
			SetKeyword(currentMaterial, "CRI_ALPHA_MOVIE", hasAlpha);
			SetKeyword(currentMaterial, "CRI_APPLY_TARGET_ALPHA", applyTargetAlpha);
			SetKeyword(currentMaterial, "CRI_LINEAR_COLORSPACE", QualitySettings.activeColorSpace == ColorSpace.Linear);
		}
	}

	private void GetBlendModes(out int srcBlendMode, out int dstBlendMode)
	{
		srcBlendMode = (additive ? 1 : 5);
		dstBlendMode = ((additive && !hasAlpha) ? 1 : 10);
	}

	public virtual void SetApplyTargetAlpha(bool flag)
	{
		applyTargetAlpha = flag;
		SetupStaticMaterialProperties();
	}

	public virtual void SetUiRenderMode(bool flag)
	{
		ui = flag;
		SetupStaticMaterialProperties();
	}

	protected abstract void OnDisposeManaged();

	protected abstract void OnDisposeUnmanaged();

	public abstract bool IsPrepared();

	public abstract bool ContinuePreparing();

	public abstract void AttachToPlayer(int playerId);

	public abstract bool UpdateFrame(int playerId, FrameInfo frameInfo, ref bool frameDrop);

	public abstract bool UpdateMaterial(Material material);

	public abstract void UpdateTextures();

	public abstract bool IsSuitable(int playerId, MovieInfo movieInfo, bool additive, Shader userShader);

	public virtual void OnPlayerPause(bool pauseStatus, bool triggredFromApplciationPause)
	{
	}

	public virtual void OnPlayerStop()
	{
	}

	public virtual bool OnPlayerStopForSeek()
	{
		return false;
	}

	public virtual void OnPlayerStart()
	{
	}

	public virtual bool ShouldSkipDestroyOnStopForSeek()
	{
		return false;
	}

	public virtual bool HasRenderedNewFrame()
	{
		return true;
	}

	public virtual int GetDisplayedFrameNo()
	{
		return -1;
	}

	public static uint NextPowerOfTwo(uint x)
	{
		x--;
		x |= x >> 1;
		x |= x >> 2;
		x |= x >> 4;
		x |= x >> 8;
		x |= x >> 16;
		return x + 1;
	}

	public static int NextPowerOfTwo(int x)
	{
		return (int)NextPowerOfTwo((uint)x);
	}

	public static int CeilingWith(int x, int ceilingValue)
	{
		return (x + ceilingValue - 1) & -ceilingValue;
	}

	public static int Ceiling16(int x)
	{
		return (x + 15) & -16;
	}

	public static int Ceiling32(int x)
	{
		return (x + 31) & -32;
	}

	public static int Ceiling64(int x)
	{
		return (x + 63) & -64;
	}

	public static int Ceiling256(int x)
	{
		return (x + 255) & -256;
	}

	protected static void DisposeTextures(Texture[] textures)
	{
		if (textures == null)
		{
			return;
		}
		for (int i = 0; i < textures.Length; i++)
		{
			if (textures[i] != null)
			{
				UnityEngine.Object.Destroy(textures[i]);
				textures[i] = null;
			}
		}
	}

	protected static void SetKeyword(Material material, string keyword, bool flag)
	{
		if (flag)
		{
			material.EnableKeyword(keyword);
		}
		else
		{
			material.DisableKeyword(keyword);
		}
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	protected static extern bool CRIWARE09829167(int player_id, int num_textures, IntPtr[] tex_ptrs, [In][Out] FrameInfo frame_info, ref bool frame_drop);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	protected static extern bool CRIWARE913A0F8B(int player_id, int num_textures, [In][Out] IntPtr[] tex_ptrs);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	protected static extern bool CRIWARE3A25993F(int player_id, int num_textures, [In][Out] IntPtr[] tex_ptrs);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	protected static extern bool CRIWAREB34EE65D(int player_id, int num_textures, [In][Out] IntPtr[] tex_ptrs);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	protected static extern sbyte CRIWAREAE5A50FA(int player_id);
}
