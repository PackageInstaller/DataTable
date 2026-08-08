using UnityEngine;

[RequireComponent(typeof(TextMesh))]
public class TextMeshHelper : MonoBehaviour
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
		Material material2 = new Material(_fontMaterial1);
		material2.CopyPropertiesFromMaterial(material);
		MeshRenderer component = GetComponent<MeshRenderer>();
		if (null != component)
		{
			material2.renderQueue = renderqueue;
			component.material = material2;
		}
	}
}
