using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Sprites;
using UnityEngine.UI;

public class AdventureShadowBlob : AdventureBlobIndicator
{
	public Vector2 blobSize = new Vector2(1f, 1f);

	public float blobOffset = 0.05f;

	public Vector2 blobHeightClamp = new Vector2(0f, 5f);

	public AnimationCurve blobScaleCurve = AnimationCurve.Linear(0f, 1f, 1f, 0f);

	protected Vector4? _blobUV;

	protected override void OnPopulateMesh(VertexHelper vh)
	{
		vh.Clear();
		if (!Application.isPlaying)
		{
			return;
		}
		_uiVert = UIVertex.simpleVert;
		if (!_blobUV.HasValue)
		{
			_blobUV = ((_blobSprite != null) ? DataUtility.GetOuterUV(_blobSprite) : new Vector4(0f, 0f, 1f, 1f));
		}
		Vector4 value = _blobUV.Value;
		Color blobColor = color;
		int num = 0;
		List<LogicEntity> weapons = ModuleController<AdventureModuleController>.Instance.weapons;
		if (weapons == null || weapons.Count <= 0)
		{
			return;
		}
		int count = weapons.Count;
		for (int i = 0; i < count; i++)
		{
			AdventureWeapon adventureWeapon = weapons.get_Item(i) as AdventureWeapon;
			if (adventureWeapon != null && (adventureWeapon.isShowShadowBlob || adventureWeapon.iShowShadowBlob()))
			{
				Transform transform = adventureWeapon.transform;
				Vector3 vector = new Vector3(transform.position.x, transform.position.z, 0f);
				vector.z = 0f - CommonHelper.GetTerrainHeight(vector, -200f, out var _) - blobOffset;
				float value2 = transform.position.y - vector.z;
				value2 = Mathf.Clamp(value2, blobHeightClamp.x, blobHeightClamp.y);
				float num2 = blobScaleCurve.Evaluate(value2 / blobHeightClamp.y);
				num2 *= 0.5f;
				Vector2 vector2 = blobSize * num2;
				num += DrawBlobPolygon(vh, vector, 0f, vector2, blobColor, value, num);
			}
		}
	}
}
