using UnityEngine;

namespace Capture.Library;

public struct Shape2D_10Point
{
	public Vector2 P0;

	public Vector2 P1;

	public Vector2 P2;

	public Vector2 P3;

	public Vector2 P4;

	public Vector2 P5;

	public Vector2 P6;

	public Vector2 P7;

	public Vector2 P8;

	public Vector2 P9;

	public int vertextCount;

	public Vector2 this[int index]
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
				8 => P8, 
				9 => P9, 
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
			case 8:
				P8 = value;
				break;
			case 9:
				P9 = value;
				break;
			}
		}
	}
}
