using UnityEngine;

[RequireComponent(typeof(TextMesh))]
public class TextMeshOutlineHelper : MonoBehaviour
{
	private TextMesh _textMesh;

	public Material _fontMaterial1;

	public int renderqueue = 3000;

	public TextMesh textMesh
	{
		get
		{
			if (null == _textMesh)
			{
				_textMesh = GetComponent<TextMesh>();
			}
			return _textMesh;
		}
	}

	private void OnEnable()
	{
		Rebuild();
	}

	public void Rebuild()
	{
		Material material = textMesh.font.material;
		_fontMaterial1.mainTexture = material.mainTexture;
	}
}
