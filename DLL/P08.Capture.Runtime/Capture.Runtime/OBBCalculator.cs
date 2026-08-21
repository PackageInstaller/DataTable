using Capture.Library;
using UnityEngine;

namespace Capture.Runtime;

public struct OBBCalculator
{
	public bool hasOBB;

	public MeshFilter mf;

	public CharacterController cc;

	public CapsuleCollider ccl;

	public BoxCollider bc;

	public OBB CalculateOBB()
	{
		if (mf != null)
		{
			return StructHelper.GetOBBFromMeshFilter(mf);
		}
		if (cc != null)
		{
			return StructHelper.GetOBBFromCharacterController(cc);
		}
		if (ccl != null)
		{
			return StructHelper.GetOBBFromCapsuleCollider(ccl);
		}
		if (bc != null)
		{
			return StructHelper.GetOBBFromBoxCollider(bc);
		}
		return new OBB
		{
			rect = Rect3D.zero
		};
	}
}
