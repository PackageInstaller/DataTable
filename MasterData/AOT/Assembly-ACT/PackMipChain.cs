using System.Collections.Generic;
using UnityEngine;

public class PackMipChain : MonoBehaviour
{
	public int MaxMipLevel = 9;

	public Texture2D TargetTex;

	public Texture2D Mip1;

	public Texture2D Mip2;

	public Texture2D Mip3;

	public Texture2D Mip4;

	public Texture2D Mip5;

	public Texture2D Mip6;

	public Texture2D Mip7;

	public Texture2D Mip8;

	public Texture2D Mip9;

	public Texture2D Mip10;

	public void Pack()
	{
		List<Texture2D> list = new List<Texture2D> { Mip1, Mip2, Mip3, Mip4, Mip5, Mip6, Mip7, Mip8, Mip9, Mip10 };
		for (int i = 0; i < MaxMipLevel; i++)
		{
			Color[] pixels = list[i].GetPixels(0);
			TargetTex.SetPixels(pixels, i + 1);
		}
		TargetTex.Apply(updateMipmaps: false);
	}
}
