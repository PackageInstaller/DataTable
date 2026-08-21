namespace UnityEngine.Rendering;

public class SphericalHarmonicsL2Utils
{
	public static void GetL1(SphericalHarmonicsL2 sh, out Vector3 L1_R, out Vector3 L1_G, out Vector3 L1_B)
	{
		L1_R = new Vector3(sh[0, 1], sh[0, 2], sh[0, 3]);
		L1_G = new Vector3(sh[1, 1], sh[1, 2], sh[1, 3]);
		L1_B = new Vector3(sh[2, 1], sh[2, 2], sh[2, 3]);
	}

	public static void GetL2(SphericalHarmonicsL2 sh, out Vector3 L2_0, out Vector3 L2_1, out Vector3 L2_2, out Vector3 L2_3, out Vector3 L2_4)
	{
		L2_0 = new Vector3(sh[0, 4], sh[1, 4], sh[2, 4]);
		L2_1 = new Vector3(sh[0, 5], sh[1, 5], sh[2, 5]);
		L2_2 = new Vector3(sh[0, 6], sh[1, 6], sh[2, 6]);
		L2_3 = new Vector3(sh[0, 7], sh[1, 7], sh[2, 7]);
		L2_4 = new Vector3(sh[0, 8], sh[1, 8], sh[2, 8]);
	}

	public static void SetL0(ref SphericalHarmonicsL2 sh, Vector3 L0)
	{
		sh[0, 0] = L0.x;
		sh[1, 0] = L0.y;
		sh[2, 0] = L0.z;
	}

	public static void SetL1R(ref SphericalHarmonicsL2 sh, Vector3 L1_R)
	{
		sh[0, 1] = L1_R.x;
		sh[0, 2] = L1_R.y;
		sh[0, 3] = L1_R.z;
	}

	public static void SetL1G(ref SphericalHarmonicsL2 sh, Vector3 L1_G)
	{
		sh[1, 1] = L1_G.x;
		sh[1, 2] = L1_G.y;
		sh[1, 3] = L1_G.z;
	}

	public static void SetL1B(ref SphericalHarmonicsL2 sh, Vector3 L1_B)
	{
		sh[2, 1] = L1_B.x;
		sh[2, 2] = L1_B.y;
		sh[2, 3] = L1_B.z;
	}

	public static void SetL1(ref SphericalHarmonicsL2 sh, Vector3 L1_R, Vector3 L1_G, Vector3 L1_B)
	{
		SetL1R(ref sh, L1_R);
		SetL1G(ref sh, L1_G);
		SetL1B(ref sh, L1_B);
	}

	public static void SetCoefficient(ref SphericalHarmonicsL2 sh, int index, Vector3 coefficient)
	{
		sh[0, index] = coefficient.x;
		sh[1, index] = coefficient.y;
		sh[2, index] = coefficient.z;
	}

	public static Vector3 GetCoefficient(SphericalHarmonicsL2 sh, int index)
	{
		return new Vector3(sh[0, index], sh[1, index], sh[2, index]);
	}
}
