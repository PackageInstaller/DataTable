using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(MeshFilter))]
[RequireComponent(typeof(MeshRenderer))]
[ExecuteInEditMode]
public class Text2D : MonoBehaviour, IText2D
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

	public Material mMat;

	public Color color1 = Color.white;

	public Color color2 = Color.white;

	private MeshRenderer mMeshRender;

	private MeshFilter mMeshFilter;

	private Vector3[] vertices;

	private Vector2[] uvs;

	private int[] triangles;

	private Color[] colors;

	private float scale;

	[HideInInspector]
	public string mText = "";

	[HideInInspector]
	public uint mCapacity = 20u;

	public float mScale = 0.01f;

	[SerializeField]
	public List<char> characters;

	public int mFontSize = 32;

	public Align mXAlign = Align.Left;

	public Align mYAlign;

	public void SetCapacity(uint length)
	{
		mCapacity = length;
		vertices = new Vector3[mCapacity << 2];
		uvs = new Vector2[mCapacity << 2];
		triangles = new int[(mCapacity << 1) * 3];
		colors = new Color[mCapacity << 2];
		Rebuild();
	}

	public void SetText(string text)
	{
		if (mMesh == null)
		{
			mMesh = new Mesh();
			mMesh.MarkDynamic();
		}
		if (text.Length > mCapacity)
		{
			text = text.Substring(0, (int)mCapacity);
		}
		if (vertices == null)
		{
			SetCapacity(mCapacity);
		}
		mText = text;
		characters = text.ToCharArray().toList<char>();
		Rebuild();
	}

	public int GetTextLength()
	{
		return characters.Count;
	}

	private void Awake()
	{
		if (mCapacity == 0)
		{
			mCapacity = 4u;
		}
		if (mMesh == null)
		{
			mMesh = new Mesh();
			mMesh.MarkDynamic();
		}
		mMesh.Clear();
		GetMeshRenderer().sharedMaterial = mMat;
		if (mMeshFilter == null)
		{
			mMeshFilter = GetComponent<MeshFilter>();
			mMeshFilter.mesh = mMesh;
		}
		SetCapacity(mCapacity);
		Rebuild();
	}

	[ContextMenu("Rebuild")]
	public void Rebuild()
	{
		if (characters == null || characters.Count == 0 || mFont == null || mMat == null || mMesh == null)
		{
			mMesh.Clear();
			return;
		}
		scale = (float)mFontSize / (float)mFont.fontSize;
		float num = 0f;
		for (int i = 0; i < characters.Count; i++)
		{
			if (mFont.HasCharacter(characters[i]) && mFont.GetCharacterInfo(characters[i], out var info))
			{
				num += (float)info.advance * mScale;
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
			if (j / 4 >= characters.Count)
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
			scale = (float)mFontSize / (float)mFont.fontSize * mScale;
			char c = characters[j / 4];
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
		mMesh.Clear();
		mMesh.vertices = vertices;
		mMesh.colors = colors;
		mMesh.triangles = triangles;
		mMesh.uv = uvs;
	}

	public MeshRenderer GetMeshRenderer()
	{
		if (mMeshRender == null)
		{
			mMeshRender = GetComponent<MeshRenderer>();
		}
		return mMeshRender;
	}
}
