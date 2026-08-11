#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase;

public class DamageRing : MonoBehaviour
{
	public Material mat;

	public float rotAngOri = -45f;

	public void SetVal(List<string> angle)
	{
		if (angle == null || angle.Count != 2)
		{
			Log.Error("增伤圈角度配置异常！");
			return;
		}
		float num = float.Parse(angle[0]);
		float num2 = float.Parse(angle[1]);
		if (num < 0f)
		{
			base.gameObject.transform.localRotation = Quaternion.Euler(0f, rotAngOri + num, 0f);
			num2 -= num;
			num = 0f;
		}
		mat.SetFloat("_StartAngle", num);
		mat.SetFloat("_Angle", num2);
		base.gameObject.SetActive(value: true);
	}
}
