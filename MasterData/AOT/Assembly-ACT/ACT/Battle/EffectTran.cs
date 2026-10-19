using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class EffectTran
{
	public static ObjectPool<EffectTran> EffectTranPool = new ObjectPool<EffectTran>(null, (EffectTran p) =>
	{
		p.OnRelease();
	}, 20);

	public Vector3 pos;

	public Quaternion rot;

	public void OnRelease()
	{
		pos = Vector3.zero;
		rot = Quaternion.identity;
	}
}
