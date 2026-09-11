using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(CanvasRenderer))]
public class TransparentGraphic : Graphic
{
	protected override void OnPopulateMesh(VertexHelper toFill)
	{
		toFill.Clear();
	}
}
