using UnityEngine;

namespace Capture.Library;

public struct Rect3D
{
	public Vector3 P0;

	public Vector3 P1;

	public Vector3 P2;

	public Vector3 P3;

	public Vector3 P4;

	public Vector3 P5;

	public Vector3 P6;

	public Vector3 P7;

	public static Rect3D zero = new Rect3D
	{
		P0 = Vector3.zero,
		P1 = Vector3.zero,
		P2 = Vector3.zero,
		P3 = Vector3.zero,
		P4 = Vector3.zero,
		P5 = Vector3.zero,
		P6 = Vector3.zero,
		P7 = Vector3.zero
	};

	public Vector3 this[int index]
	{
		get
		{
			return index switch
			{
				0 => P0, 
				1 => P1, 
				2 => P2, 
				3 => P3, 
				4 => P4, 
				5 => P5, 
				6 => P6, 
				7 => P7, 
				_ => Vector3.zero, 
			};
		}
		set
		{
			switch (index)
			{
			case 0:
				P0 = value;
				break;
			case 1:
				P1 = value;
				break;
			case 2:
				P2 = value;
				break;
			case 3:
				P3 = value;
				break;
			case 4:
				P4 = value;
				break;
			case 5:
				P5 = value;
				break;
			case 6:
				P6 = value;
				break;
			case 7:
				P7 = value;
				break;
			}
		}
	}
}
