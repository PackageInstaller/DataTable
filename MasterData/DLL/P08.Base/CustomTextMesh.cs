using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(MeshFilter))]
[RequireComponent(typeof(MeshRenderer))]
public class CustomTextMesh : MonoBehaviour
{
	public enum Align
	{
		Center,
		Right,
		Left,
		Up,
		Bottom
	}

	public Mesh mMesh;

	public Font mFont;

	public string mText;

	public Material mMat;

	public Color color1 = Color.white;

	public Color color2 = Color.white;

	private MeshRenderer mMeshRender;

	private MeshFilter mMeshFilter;

	public uint mCapacity = 20u;

	public float[] mScales;

	public List<char> mNumbers;

	public int mValidSize;

	public int mFontSize = 32;

	private Vector3[] vertices;

	private Vector2[] uvs;

	private int[] triangles;

	private Color[] colors;

	private float scale;

	public Align mXAlign = Align.Left;

	public Align mYAlign;

	public void SetCapacity(uint length, bool isForce)
	{
		if ((mCapacity < length) | isForce)
		{
			mCapacity = length;
			vertices = new Vector3[mCapacity << 2];
			uvs = new Vector2[mCapacity << 2];
			triangles = new int[(mCapacity << 1) * 3];
			colors = new Color[mCapacity << 2];
			mScales = new float[mCapacity];
			mNumbers = new List<char>((int)mCapacity);
			Rebuild();
		}
	}

	public void SetText(int text)
	{
		_ = 0;
		mNumbers.Clear();
		mValidSize = 0;
		if (text == 0)
		{
			mNumbers.Insert(0, '0');
			mScales[mValidSize] = 1f;
			mValidSize = 1;
		}
		else
		{
			while (text != 0)
			{
				mNumbers.Insert(0, (char)(text % 10 + 48));
				text /= 10;
				mScales[mValidSize] = 1f;
				mValidSize++;
			}
		}
		Rebuild();
	}

	public int GetTextLength()
	{
		return mNumbers.Count;
	}

	private void Awake()
	{
		if (mCapacity == 0)
		{
			mCapacity = 4u;
		}
		SetCapacity(mCapacity, isForce: true);
		if (mMesh == null)
		{
			mMesh = new Mesh();
			mMesh.MarkDynamic();
		}
		mMesh.Clear();
		if (mMeshRender == null)
		{
			mMeshRender = GetComponent<MeshRenderer>();
			if (mFont != null)
			{
				mMeshRender.sharedMaterial = mMat;
			}
		}
		if (mMeshFilter == null)
		{
			mMeshFilter = GetComponent<MeshFilter>();
			mMeshFilter.mesh = mMesh;
		}
		Rebuild();
	}

	[ContextMenu("Rebuild")]
	public void Rebuild()
	{
		if (mNumbers == null || mNumbers.Count == 0)
		{
			return;
		}
		scale = (float)mFontSize / (float)mFont.fontSize;
		float num = 0f;
		for (int i = 0; i < mNumbers.Count; i++)
		{
			if (mFont.HasCharacter(mNumbers[i]) && mFont.GetCharacterInfo(mNumbers[i], out var info))
			{
				num += (float)info.advance * mScales[i];
			}
		}
		float num2 = 0f;
		num2 = mXAlign switch
		{
			Align.Center => (0f - num * 0.5f) * scale, 
			Align.Left => 0f, 
			Align.Right => (0f - num) * scale, 
			_ => 0f, 
		};
		int num3 = 0;
		for (int j = 0; j < vertices.Length; j += 4)
		{
			if (j / 4 >= mNumbers.Count)
			{
				vertices[j] = Vector3.zero;
				vertices[j + 1] = Vector3.zero;
				vertices[j + 2] = Vector3.zero;
				vertices[j + 3] = Vector3.zero;
				uvs[j] = Vector2.zero;
				uvs[j + 1] = Vector2.zero;
				uvs[j + 2] = Vector2.zero;
				uvs[j + 3] = Vector2.zero;
				colors[j] = Color.white;
				colors[j + 1] = Color.white;
				colors[j + 2] = Color.white;
				colors[j + 3] = Color.white;
				continue;
			}
			scale = (float)mFontSize / (float)mFont.fontSize * mScales[j / 4];
			char c = mNumbers[j / 4];
			if (mFont.HasCharacter(c) && mFont.GetCharacterInfo(c, out var info2))
			{
				float num4 = 0f;
				num4 = mYAlign switch
				{
					Align.Center => (0f - (float)info2.glyphHeight * 0.5f) * scale, 
					Align.Bottom => 0f, 
					Align.Up => (float)(-info2.glyphHeight) * scale, 
					_ => 0f, 
				};
				vertices[j] = new Vector3(num2, (float)info2.glyphHeight * scale + num4, 0f);
				vertices[j + 1] = new Vector3(num2, num4, 0f);
				vertices[j + 2] = new Vector3(num2 + (float)info2.glyphWidth * scale, (float)info2.glyphHeight * scale + num4, 0f);
				vertices[j + 3] = new Vector3(num2 + (float)info2.glyphWidth * scale, 0f + num4, 0f);
				num2 += (float)info2.advance * scale;
				colors[j] = color1;
				colors[j + 1] = color2;
				colors[j + 2] = color1;
				colors[j + 3] = color2;
				uvs[j] = info2.uvTopLeft;
				uvs[j + 1] = info2.uvBottomLeft;
				uvs[j + 2] = info2.uvTopRight;
				uvs[j + 3] = info2.uvBottomRight;
			}
		}
		for (int k = 0; k < triangles.Length; k += 6)
		{
			num3 = k / 3 << 1;
			triangles[k] = (triangles[k + 3] = num3);
			triangles[k + 1] = (triangles[k + 5] = num3 + 3);
			triangles[k + 2] = num3 + 1;
			triangles[k + 4] = num3 + 2;
		}
		mMesh.vertices = vertices;
		mMesh.colors = colors;
		mMesh.triangles = triangles;
		mMesh.uv = uvs;
	}
}
