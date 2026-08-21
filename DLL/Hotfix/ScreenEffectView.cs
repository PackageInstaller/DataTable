using Ase.ECS;

public class ScreenEffectView : EffectView
{
	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		EffectScaler[] componentsInChildren = base.transform.GetComponentsInChildren<EffectScaler>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].Correction();
		}
	}
}
