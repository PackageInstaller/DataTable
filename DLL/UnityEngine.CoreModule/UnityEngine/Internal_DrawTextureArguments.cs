using UnityEngine.Bindings;

namespace UnityEngine;

[VisibleToOtherModules(new string[] { "UnityEngine.IMGUIModule" })]
internal struct Internal_DrawTextureArguments
{
	public Rect screenRect;

	public Rect sourceRect;

	public int leftBorder;

	public int rightBorder;

	public int topBorder;

	public int bottomBorder;

	public Color leftBorderColor;

	public Color rightBorderColor;

	public Color topBorderColor;

	public Color bottomBorderColor;

	public Color color;

	public Vector4 borderWidths;

	public Vector4 cornerRadiuses;

	public bool smoothCorners;

	public int pass;

	public Texture texture;

	public Material mat;
}
