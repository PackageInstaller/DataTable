using LuaInterface;
using UnityEngine;

public class QWorldPassiveNPC : MonoBehaviour, IQWorldCullable
{
	public const float DEFAULT_RADIUS = 0.6f;

	public const float DEFAULT_HEIGHT = 1.2f;

	public float radius = 0.6f;

	public float height = 1.2f;

	public static readonly string[] skinnedMesh = new string[3] { "hair", "face", "body" };

	public static readonly string[] Bones = new string[20]
	{
		"root", "Bip001", "Bip001 Pelvis", "Bip001 Spine", "Bip001 L Thigh", "Bip001 L Calf", "Bip001 L Foot", "Bip001 R Thigh", "Bip001 R Calf", "Bip001 R Foot",
		"Bip001 Spine1", "Bip001 Head", "Bip001 L Clavicle", "Bip001 L UpperArm", "Bip001 L ForeArm", "Bip001 L Hand", "Bip001 R Clavicle", "Bip001 R UpperArm", "Bip001 R ForeArm", "Bip001 R Hand"
	};

	[NoToLua]
	public Bounds GetBounds()
	{
		float num = GetBoundSphereRadius() * 2f;
		return new Bounds(Vector3.zero, new Vector3(num, height, num));
	}

	[NoToLua]
	public float GetBoundSphereRadius()
	{
		return radius;
	}

	public Vector3 GetPosition()
	{
		return base.transform.position;
	}
}
