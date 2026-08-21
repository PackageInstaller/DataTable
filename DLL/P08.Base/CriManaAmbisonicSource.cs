using UnityEngine;

public class CriManaAmbisonicSource : CriMonoBehaviour
{
	private CriAtomEx3dSource atomEx3DsourceForAmbisonics;

	private Vector3 ambisonicSourceOrientationFront;

	private Vector3 ambisonicSourceOrientationTop;

	private Vector3 lastEulerOfAmbisonicSource;

	public override void CriInternalUpdate()
	{
		UpdateAmbisonicSourceOrientation();
	}

	public override void CriInternalLateUpdate()
	{
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		atomEx3DsourceForAmbisonics = base.gameObject.transform.parent.GetComponent<CriManaMovieMaterial>().player.atomEx3DsourceForAmbisonics;
		if (atomEx3DsourceForAmbisonics == null)
		{
			Debug.LogError("atomEx3DsourceForAmbisonics == null");
		}
		else
		{
			ForceUpdateAmbisonicSourceOrientation();
		}
	}

	private void ForceUpdateAmbisonicSourceOrientation()
	{
		lastEulerOfAmbisonicSource = base.transform.eulerAngles;
		RoatateAmbisonicSourceOrientationByTransformOfChild(ref lastEulerOfAmbisonicSource);
		atomEx3DsourceForAmbisonics.SetOrientation(ambisonicSourceOrientationFront, ambisonicSourceOrientationTop);
		atomEx3DsourceForAmbisonics.Update();
	}

	private void UpdateAmbisonicSourceOrientation()
	{
		if (lastEulerOfAmbisonicSource != base.transform.eulerAngles)
		{
			ForceUpdateAmbisonicSourceOrientation();
		}
	}

	private void RoatateAmbisonicSourceOrientationByTransformOfChild(ref Vector3 input_euler)
	{
		Quaternion quaternion = Quaternion.Euler(input_euler);
		float num = quaternion.x * quaternion.x + quaternion.y * quaternion.y + quaternion.z * quaternion.z + quaternion.w * quaternion.w;
		float num2 = ((!(num <= 0f)) ? (2f / num) : 0f);
		float[] array = new float[9]
		{
			1f - num2 * (quaternion.y * quaternion.y + quaternion.z * quaternion.z),
			num2 * (quaternion.x * quaternion.y - quaternion.w * quaternion.z),
			num2 * (quaternion.x * quaternion.z + quaternion.w * quaternion.y),
			num2 * (quaternion.x * quaternion.y + quaternion.w * quaternion.z),
			1f - num2 * (quaternion.x * quaternion.x + quaternion.z * quaternion.z),
			num2 * (quaternion.y * quaternion.z - quaternion.w * quaternion.x),
			num2 * (quaternion.x * quaternion.z - quaternion.w * quaternion.y),
			num2 * (quaternion.y * quaternion.z + quaternion.w * quaternion.x),
			1f - num2 * (quaternion.x * quaternion.x + quaternion.y * quaternion.y)
		};
		Vector3 vector = new Vector3(0f, 0f, 1f);
		Vector3 vector2 = ambisonicSourceOrientationFront;
		vector2.x = array[0] * vector.x + array[1] * vector.y + array[2] * vector.z;
		vector2.y = array[3] * vector.x + array[4] * vector.y + array[5] * vector.z;
		vector2.z = array[6] * vector.x + array[7] * vector.y + array[8] * vector.z;
		ambisonicSourceOrientationFront = vector2;
		Vector3 vector3 = new Vector3(0f, 1f, 0f);
		Vector3 vector4 = ambisonicSourceOrientationTop;
		vector4.x = array[0] * vector3.x + array[1] * vector3.y + array[2] * vector3.z;
		vector4.y = array[3] * vector3.x + array[4] * vector3.y + array[5] * vector3.z;
		vector4.z = array[6] * vector3.x + array[7] * vector3.y + array[8] * vector3.z;
		ambisonicSourceOrientationTop = vector4;
	}
}
